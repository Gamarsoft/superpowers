#!/usr/bin/env python3
"""Read-only inventory and identity checks for canonical frontend packets."""
import argparse
from datetime import date
import hashlib
import json
import os
from pathlib import Path, PurePosixPath
import re


MARKER = '<!-- frontend-packet: 2 -->'
IGNORED = {'.git', 'node_modules', '__pycache__', '.DS_Store'}
HANDOFF_FIELDS = (
    'checkout_build', 'start_command_and_working_directory',
    'base_url_and_target_route', 'readiness_check',
    'authentication_and_fixture_state_setup', 'required_viewports_platforms',
    'server_owner_lifetime',
)


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
    binding_paths = []
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

    def binding_file(value):
        binding_paths.append(value)
        return local_path(value)

    def evidence_json(value):
        if not binding_file(value):
            return None
        try:
            record = json.loads((root / value).read_bytes())
        except (ValueError, UnicodeDecodeError) as exc:
            issue('evidence-json', f'Invalid JSON evidence {value}: {exc}')
            return None
        if not isinstance(record, dict):
            issue('evidence-json', f'Evidence must be a JSON object: {value}')
            return None
        return record

    def path_list(value, label, code, allow_empty=False):
        if not isinstance(value, list) or (not value and not allow_empty):
            issue(code, f'{label} must list contained binding files' + ('; [] is allowed.' if allow_empty else '.'))
            return
        for path in value:
            binding_file(path)

    def recoverable_source(source):
        if not isinstance(source, dict):
            issue('runtime-source', 'Retain local source or a verified immutable source reference; a checkout path alone is insufficient.')
            return None
        source_revision = source.get('revision')
        if not nonempty(source_revision):
            issue('runtime-source', 'source.revision must identify the exact code snapshot or immutable revision.')
        binding_file(source.get('dependencies'))
        path_list(source.get('dirty_changes'), 'source.dirty_changes', 'runtime-source', allow_empty=True)
        kind = source.get('kind')
        if kind == 'local' or 'paths' in source:
            path_list(source.get('paths'), 'source.paths', 'runtime-source')
        if kind == 'immutable-reference' or 'recovery_evidence' in source:
            locator = source.get('locator')
            if not nonempty(locator):
                issue('runtime-source', 'Immutable source requires its exact locator and revision.')
            recovery = evidence_json(source.get('recovery_evidence'))
            if recovery is not None and (
                    recovery.get('result') != 'passed'
                    or recovery.get('locator') != locator
                    or recovery.get('revision') != source_revision
                    or not nonempty(recovery.get('method'))):
                issue('source-recovery', 'Local recovery evidence must record passed retrieval of the same immutable locator/revision and its verification method.')
        if kind not in ('local', 'immutable-reference'):
            issue('runtime-source', 'source.kind must be local or immutable-reference.')
        return source_revision

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
    version = packet.get('schema_version')
    if type(version) is not int or version != 2:
        label = 'missing' if version is None else repr(version)
        issue('schema-version', f'Unsupported packet schema version {label}. This workflow requires version 2; historical packets are reference material only.')
        return result
    for obsolete in ('prototype', 'prototype_omission'):
        if obsolete in packet:
            issue('obsolete-field', f'{obsolete} is not a version-2 field; use design_source and runtime_evidence.')

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
    accepted = approval.get('accepted_limitations')
    if status == 'approved-with-degraded-evidence':
        if (not limitations or not isinstance(accepted, list)
                or any(limit not in accepted for limit in limitations)):
            issue('degraded-approval', 'Record explicit acceptance of each listed degraded limitation.')

    def accepted_degradation(limitation):
        return (status == 'approved-with-degraded-evidence' and nonempty(limitation)
                and limitation in limitations and isinstance(accepted, list) and limitation in accepted)

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

    design = packet.get('design_source')
    if not isinstance(design, dict):
        issue('design-source', 'design_source must identify medium, approved revision and a local design/ manifest.')
    else:
        medium = design.get('medium')
        if medium not in ('paper', 'runtime', 'references-only'):
            issue('design-source', 'design_source.medium must be paper, runtime or references-only.')
        if design.get('revision') != revision:
            issue('revision-mismatch', 'design_source.revision differs from packet revision.')
        manifest_path = design.get('manifest')
        if not isinstance(manifest_path, str) or not manifest_path.startswith('design/'):
            issue('design-source', 'design_source.manifest must be a local JSON file under design/.')
        manifest = evidence_json(manifest_path)
        if manifest is not None:
            if manifest.get('revision') != revision:
                issue('revision-mismatch', 'Design manifest revision differs from packet revision.')
            for field in ('provenance', 'structure', 'computed_styles', 'resolved_tokens', 'copy', 'component_mappings'):
                if field == 'provenance' or medium == 'paper' or field in manifest:
                    if not nonempty(manifest.get(field)):
                        issue('design-manifest', f'Design manifest requires {field} as a local binding file.')
                    binding_file(manifest.get(field))
            if medium == 'paper' or 'assets' in manifest:
                path_list(manifest.get('assets'), 'manifest.assets', 'design-manifest', allow_empty=True)
            if 'supporting_files' in manifest:
                path_list(manifest['supporting_files'], 'manifest.supporting_files', 'design-manifest', allow_empty=True)
            if medium == 'runtime' or 'source' in manifest:
                recoverable_source(manifest.get('source'))
            if medium == 'references-only':
                omission = manifest.get('omission')
                if (not isinstance(omission, dict) or not nonempty(omission.get('reason'))
                        or not nonempty(omission.get('decision'))):
                    issue('design-manifest', 'References-only source requires its actual scoped omission reason and human decision.')

    targets = packet.get('targets')
    if not isinstance(targets, list) or not targets:
        issue('targets', 'At least one current reference target is required.')
        targets = []
    target_ids = set()
    target_states = []
    target_state_by_id = {}
    for target in targets:
        if not isinstance(target, dict):
            issue('targets', 'Each target must be an object.')
            continue
        identifier = target.get('id')
        if not nonempty(identifier) or identifier in target_ids:
            issue('targets', 'Target IDs must be nonempty and unique.')
        else:
            target_ids.add(identifier)
            target_state_by_id[identifier] = target.get('state')
        path = target.get('path')
        if not isinstance(path, str) or not path.startswith('references/'):
            issue('target-path', 'Current targets belong in references/, never history/.')
        local_path(path)
        binding_paths.append(path)
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
    referenced_targets = set()
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
        else:
            for target_id in refs:
                if target_state_by_id[target_id] != identifier:
                    issue('state-reference', f'Target {target_id} belongs to a different state than {identifier}.')
                else:
                    referenced_targets.add(target_id)
        if state.get('verification') not in ('exercised', 'source-inspected', 'not-exercised'):
            issue('states', 'State verification must distinguish exercised, source-inspected and not-exercised.')
    if any(not isinstance(s, str) or s not in state_ids for s in target_states):
        issue('state-reference', 'Every target state must exist in states.')
    if target_ids - referenced_targets:
        issue('state-reference', f'Targets must be listed by their declared state: {sorted(target_ids - referenced_targets)}')

    runtime = packet.get('runtime_evidence')
    if not isinstance(runtime, dict):
        issue('runtime-evidence', 'runtime_evidence must record required_checks, checks and not_required_reason.')
        runtime = {}
    if 'not_required_reason' not in runtime:
        issue('runtime-evidence', 'not_required_reason is required; use null when runtime checks were required.')
    required = runtime.get('required_checks')
    if (not isinstance(required, list) or any(not nonempty(x) for x in required)
            or len(required) != len(set(required))):
        issue('runtime-evidence', 'required_checks must be a list of unique nonempty check IDs; [] needs a substantive reason.')
        required = []
    if not required and not nonempty(runtime.get('not_required_reason')):
        issue('runtime-evidence', 'Explain why no pre-approval runtime checks were required for this scope.')
    checks = runtime.get('checks')
    if not isinstance(checks, list):
        issue('runtime-evidence', 'checks must be a list of check records.')
        checks = []
    check_ids = set()
    for item in checks:
        if not isinstance(item, dict):
            issue('runtime-check', 'Each runtime check must be an object.')
            continue
        identifier = item.get('id')
        if not nonempty(identifier) or identifier in check_ids:
            issue('runtime-check', 'Runtime check IDs must be nonempty and unique.')
        else:
            check_ids.add(identifier)
        check_states = item.get('state_ids')
        if (not isinstance(check_states, list) or not check_states
                or any(not isinstance(x, str) or x not in state_ids for x in check_states)
                or len(check_states) != len(set(check_states))):
            issue('runtime-check', f'Check {identifier!r} must name unique existing state_ids.')
        outcome = item.get('result')
        if outcome not in ('passed', 'failed', 'unavailable'):
            issue('runtime-check', 'Check result must be passed, failed or unavailable.')
        degraded = accepted_degradation(item.get('limitation'))
        if identifier in required and (outcome == 'failed' or (outcome == 'unavailable' and not degraded)):
            issue('required-check', f'Required check {identifier!r} must pass or record its explicitly accepted unavailable evidence limit; a failure cannot be omitted.')
        record = evidence_json(item.get('record'))
        if record is None:
            continue
        if (record.get('check_id') != identifier or record.get('state_ids') != check_states
                or record.get('result') != outcome):
            issue('runtime-record', f'Runtime record must match check {identifier!r}, state_ids and result.')
        if not nonempty(record.get('source_revision')):
            issue('runtime-record', 'Runtime record must identify source_revision, or explicitly mark it unavailable.')
        handoff = record.get('handoff')
        if not isinstance(handoff, dict) or any(not nonempty(handoff.get(field)) for field in HANDOFF_FIELDS):
            issue('runtime-record', 'Runtime record requires all seven implementation runtime handoff fields; mark unavailable values pending with their reason.')
        if 'supporting_files' in record:
            path_list(record['supporting_files'], 'runtime record supporting_files', 'runtime-record', allow_empty=True)
        if outcome == 'unavailable' and not nonempty(record.get('unavailable_reason')):
            issue('runtime-record', 'Unavailable checks must explain the missing evidence in unavailable_reason.')
        if not (outcome == 'unavailable' and degraded and 'source' in record and record['source'] is None):
            source_revision = recoverable_source(record.get('source'))
            if source_revision is not None and source_revision != record.get('source_revision'):
                issue('runtime-record', 'Runtime source revision differs from the record source_revision.')
    for identifier in required:
        if identifier not in check_ids:
            issue('required-check', f'Missing required check {identifier!r}; retain an unavailable record and its accepted degraded scope when evidence is missing.')

    inventory = packet.get('files')
    if not isinstance(inventory, dict):
        issue('inventory', 'files must map every current payload path to its SHA-256.')
        inventory = {}
    actual = current_files(root, errors)
    for path in binding_paths:
        if isinstance(path, str) and (path not in inventory or path not in actual):
            issue('binding-inventory', f'Binding file must be in the verified inventory, outside excluded paths: {path}')
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
