#!/usr/bin/env python3
"""Read-only inventory and identity checks for canonical frontend packets."""
import argparse
from datetime import date
import hashlib
import json
import os
from pathlib import Path, PurePosixPath
import re


MARKER = '<!-- frontend-packet: 1 -->'
IGNORED = {'.git', 'node_modules', '__pycache__', '.DS_Store'}


def sha256(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def nonempty(value):
    return isinstance(value, str) and bool(value.strip())


def current_files(root, errors):
    """Walk current payload only; never follow a symlink or enter history."""
    files = {}
    for directory, dirs, names in os.walk(root, followlinks=False):
        base = Path(directory)
        for name in dirs[:]:
            path = base / name
            if name in IGNORED or (base == root and name == 'history'):
                dirs.remove(name)
            elif path.is_symlink():
                errors.append({'code': 'symlink', 'message': f'Symlink: {path.relative_to(root)}'})
                dirs.remove(name)
        for name in names:
            path = base / name
            if name in IGNORED or (base == root and name == 'packet.json'):
                continue
            relative = path.relative_to(root).as_posix()
            if path.is_symlink():
                errors.append({'code': 'symlink', 'message': f'Symlink: {relative}'})
            elif path.is_file():
                files[relative] = sha256(path)
    return dict(sorted(files.items()))


def check(root, expected_revision=None, expected_hash=None):
    errors = []
    result = {'valid': False, 'errors': errors, 'revision': None, 'descriptor_sha256': None}

    def issue(code, message):
        errors.append({'code': code, 'message': message})

    def local_path(value, kind='file'):
        if (not nonempty(value) or '\\' in value or ':' in value
                or any(part in ('', '.', '..') for part in value.split('/'))
                or PurePosixPath(value).is_absolute()):
            issue('unsafe-path', f'Use a relative contained path: {value!r}')
            return False
        path = root
        for part in PurePosixPath(value).parts:
            path = path / part
            if path.is_symlink():
                issue('symlink', f'Symlink: {value}')
                return False
        if not (path.is_dir() if kind == 'directory' else path.is_file()):
            issue('missing-file', f'Missing {kind}: {value}')
            return False
        return True

    descriptor = root / 'packet.json'
    if not local_path('packet.json'):
        issue('missing-descriptor', 'Canonical packet requires packet.json; recover it before implementation.')
        return result
    raw = descriptor.read_bytes()
    result['descriptor_sha256'] = hashlib.sha256(raw).hexdigest()
    try:
        packet = json.loads(raw)
    except (ValueError, UnicodeDecodeError) as exc:
        issue('descriptor', f'Invalid packet.json: {exc}')
        return result
    if not isinstance(packet, dict):
        issue('descriptor', 'packet.json must be an object.')
        return result
    if type(packet.get('schema_version')) is not int or packet['schema_version'] != 1:
        issue('schema-version', 'Supported schema_version is 1; do not treat this as legacy.')
        return result

    revision = packet.get('revision')
    result['revision'] = revision
    if not nonempty(revision):
        issue('revision', 'revision must identify the approved source version.')
    if ((expected_revision is not None and revision != expected_revision)
            or (expected_hash is not None and result['descriptor_sha256'] != expected_hash)):
        issue('expected-identity', 'Packet differs from the expected revision or descriptor SHA-256.')
    status = packet.get('status')
    if status not in ('approved', 'approved-with-degraded-evidence'):
        issue('status', 'Final handoff requires approved or explicitly approved-with-degraded-evidence status.')
    approval = packet.get('approval')
    if not isinstance(approval, dict):
        issue('approval', 'approval must record the actual human decision, date and revision.')
        approval = {}
    if not nonempty(approval.get('decision')):
        issue('approval', 'Record the actual human approval decision; validation cannot create it.')
    try:
        date.fromisoformat(approval.get('date', ''))
    except (ValueError, TypeError):
        issue('approval', 'approval.date must be an ISO date (YYYY-MM-DD).')
    if approval.get('revision') != revision:
        issue('revision-mismatch', 'approval.revision differs from packet revision.')
    limitations = packet.get('limitations')
    if not isinstance(limitations, list) or any(not nonempty(x) for x in limitations):
        issue('limitations', 'limitations must be a list of specific remaining limits; [] is allowed.')
        limitations = []
    if status == 'approved-with-degraded-evidence':
        accepted = approval.get('accepted_limitations')
        if (not limitations or not isinstance(accepted, list)
                or any(limit not in accepted for limit in limitations)):
            issue('degraded-approval', 'Record explicit acceptance of each listed degraded limitation.')

    if packet.get('entrypoint') != 'packet.md':
        issue('documents', 'entrypoint must be packet.md.')
    if local_path('packet.md'):
        if not (root / 'packet.md').read_text(encoding='utf-8').startswith(MARKER + '\n'):
            issue('documents', f'packet.md must start with {MARKER}.')
    context = packet.get('context')
    if context not in ('brownfield', 'greenfield'):
        issue('documents', 'context must be brownfield or greenfield.')
    documents = packet.get('documents')
    if not isinstance(documents, dict):
        documents = {}
    if documents.get('screen_index') != 'screen-index.md':
        issue('documents', 'documents.screen_index must be screen-index.md.')
    local_path('screen-index.md')
    if context == 'brownfield':
        if documents.get('inspection') != 'brownfield-ui-extraction.md':
            issue('documents', 'Brownfield packets require brownfield-ui-extraction.md.')
        local_path('brownfield-ui-extraction.md')
    elif documents.get('inspection') is not None:
        issue('documents', 'Use null inspection for greenfield context.')

    prototype = packet.get('prototype')
    if isinstance(prototype, dict):
        if prototype.get('path') != 'prototype':
            issue('prototype', 'Current source belongs in prototype/.')
        local_path('prototype', 'directory')
        entry = prototype.get('entrypoint')
        if not isinstance(entry, str) or not entry.startswith('prototype/'):
            issue('prototype', 'prototype.entrypoint must be inside prototype/.')
        local_path(entry)
        if prototype.get('revision') != revision:
            issue('revision-mismatch', 'prototype.revision differs from packet revision.')
        for field in ('launch_command', 'url'):
            if not nonempty(prototype.get(field)):
                issue('prototype', f'prototype.{field} is required.')
    elif prototype is None and 'prototype' in packet:
        omission = packet.get('prototype_omission')
        scoped = (isinstance(omission, dict) and nonempty(omission.get('reason'))
                  and nonempty(omission.get('decision')))
        if status != 'approved-with-degraded-evidence' and not scoped:
            issue('prototype', 'Record the explicit references-only scope or accepted degraded evidence.')
    else:
        issue('prototype', 'prototype must be an object or an explicitly scoped null.')

    targets = packet.get('targets')
    if not isinstance(targets, list) or not targets:
        issue('targets', 'At least one current reference target is required.')
        targets = []
    target_ids = set()
    target_states = []
    for target in targets:
        if not isinstance(target, dict):
            issue('targets', 'Each target must be an object.')
            continue
        identifier = target.get('id')
        if not nonempty(identifier) or identifier in target_ids:
            issue('targets', 'Target IDs must be nonempty and unique.')
        else:
            target_ids.add(identifier)
        path = target.get('path')
        if not isinstance(path, str) or not path.startswith('references/'):
            issue('target-path', 'Current targets belong in references/, never history/.')
        local_path(path)
        if target.get('intent') not in ('visual-truth', 'semantic-guidance', 'reference-only'):
            issue('targets', 'Target intent must be visual-truth, semantic-guidance or reference-only.')
        for field in ('scope', 'source_version', 'state'):
            if not nonempty(target.get(field)):
                issue('targets', f'Target {field} must be specified.')
        target_states.append(target.get('state'))
        viewport = target.get('viewport')
        if not isinstance(viewport, dict) or any(
                type(viewport.get(k)) is not int or viewport[k] <= 0 for k in ('width', 'height')):
            issue('targets', 'Target viewport requires positive integer width and height.')

    states = packet.get('states')
    if not isinstance(states, list) or not states:
        issue('states', 'Map important states to setup and actual verification.')
        states = []
    state_ids = set()
    for state in states:
        if not isinstance(state, dict):
            issue('states', 'Each state must be an object.')
            continue
        identifier = state.get('id')
        if not nonempty(identifier) or identifier in state_ids:
            issue('states', 'State IDs must be nonempty and unique.')
        else:
            state_ids.add(identifier)
        if not nonempty(state.get('setup')):
            issue('state-setup', 'Every state needs concrete setup/trigger instructions.')
        refs = state.get('references')
        if not isinstance(refs, list) or any(not isinstance(x, str) or x not in target_ids for x in refs):
            issue('state-reference', 'State references must name current target IDs; [] is allowed.')
        if state.get('verification') not in ('exercised', 'source-inspected', 'not-exercised'):
            issue('states', 'State verification must distinguish exercised, source-inspected and not-exercised.')
    if any(not isinstance(s, str) or s not in state_ids for s in target_states):
        issue('state-reference', 'Every target state must exist in states.')

    inventory = packet.get('files')
    if not isinstance(inventory, dict):
        issue('inventory', 'files must map every current payload path to its SHA-256.')
        inventory = {}
    actual = current_files(root, errors)
    if set(inventory) != set(actual):
        issue('inventory-mismatch', f'Current files differ: added={sorted(set(actual)-set(inventory))}, missing={sorted(set(inventory)-set(actual))}')
    for name, expected in inventory.items():
        if not local_path(name):
            continue
        if not isinstance(expected, str) or not re.fullmatch('[0-9a-f]{64}', expected):
            issue('inventory', f'Invalid SHA-256 for {name}.')
        elif name in actual and actual[name] != expected:
            issue('hash-mismatch', f'Changed file: {name}. Recover approved bytes or resolve the revision; do not silently refresh hashes.')
    result['valid'] = not errors
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('command', choices=('inventory', 'check'))
    parser.add_argument('root', type=Path)
    parser.add_argument('--expected-revision')
    parser.add_argument('--expected-descriptor-sha256')
    args = parser.parse_args()
    try:
        if args.root.is_symlink() or not args.root.is_dir():
            raise ValueError('Packet root must be an existing directory, not a symlink.')
        if args.command == 'inventory':
            errors = []
            result = current_files(args.root, errors)
            if errors:
                result = {'valid': False, 'errors': errors}
            valid = not errors
        else:
            result = check(args.root, args.expected_revision, args.expected_descriptor_sha256)
            valid = result['valid']
    except (OSError, UnicodeError, ValueError) as exc:
        result = {'valid': False, 'errors': [{'code': 'io', 'message': str(exc)}]}
        valid = False
    print(json.dumps(result, indent=2, ensure_ascii=False))
    return 0 if valid else 1


if __name__ == '__main__':
    raise SystemExit(main())
