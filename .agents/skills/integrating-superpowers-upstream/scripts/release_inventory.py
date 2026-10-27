"""Inventory pinned upstream changes without changing refs, index or worktree."""

import argparse
import json
from pathlib import Path
import subprocess
import sys


class InventoryError(Exception):
    pass


def git(repo, *args, allow_missing=False):
    result = subprocess.run(
        ['git', '--no-optional-locks', '-c', 'core.fsmonitor=false',
         '-C', str(repo), *args], capture_output=True)
    if result.returncode and not (allow_missing and result.returncode == 1):
        raise InventoryError(result.stderr.decode(errors='replace').strip()
                             or f'git {args[0]} exited {result.returncode}')
    return result


def commit(repo, ref):
    return git(repo, 'rev-parse', '--verify', '--end-of-options',
               f'{ref}^{{commit}}').stdout.decode().strip()


def ancestor(repo, base, tip):
    return git(repo, 'merge-base', '--is-ancestor', base, tip,
               allow_missing=True).returncode == 0


def changes(repo, base, tip):
    fields = git(repo, 'diff', '--name-status', '-z', '--find-renames',
                 base, tip, '--').stdout.split(b'\0')
    records = []
    index = 0
    while index < len(fields) - 1:
        status = fields[index].decode('ascii')
        path = fields[index + 1].decode('utf-8', errors='surrogateescape')
        index += 2
        record = {'status': status, 'path': path}
        if status.startswith(('R', 'C')):
            record['old_path'] = path
            record['path'] = fields[index].decode('utf-8', errors='surrogateescape')
            index += 1
        records.append(record)
    return records


def endpoints(record):
    return {record['path']} | ({record['old_path']} if 'old_path' in record else set())


def inventory(repo, fork_ref, base_ref, target_ref):
    fork, base, target = (commit(repo, ref) for ref in (fork_ref, base_ref, target_ref))
    if not ancestor(repo, base, target):
        raise InventoryError('reviewed base is not an ancestor of target; reconcile release history')
    merge_bases = git(repo, 'merge-base', '--all', fork, target,
                      allow_missing=True).stdout.decode().splitlines()
    if not merge_bases:
        raise InventoryError('fork and target have no common history; verify repository identity')
    fork_files = changes(repo, base, fork)
    touched = {p for record in fork_files for p in endpoints(record)}
    files = changes(repo, base, target)
    for record in files:
        record['fork_changed_paths'] = sorted(endpoints(record) & touched)
    return {
        'schema_version': 1,
        'fork': fork,
        'reviewed_base': base,
        'target': target,
        'merge_bases': merge_bases,
        'reviewed_base_is_ancestor_of_fork': ancestor(repo, base, fork),
        'target_is_ancestor_of_fork': ancestor(repo, target, fork),
        'changed_records': len(files),
        'overlap_records': sum(bool(record['fork_changed_paths']) for record in files),
        'files': files,
    }


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--repo', type=Path, default=Path('.'))
    parser.add_argument('--fork', required=True, help='fork revision to compare')
    parser.add_argument('--base', required=True, help='last assessed upstream revision')
    parser.add_argument('--target', required=True, help='verified upstream release revision')
    args = parser.parse_args()
    try:
        result = inventory(args.repo, args.fork, args.base, args.target)
    except (InventoryError, OSError) as error:
        print(f'inventory: {error}', file=sys.stderr)
        return 1
    print(json.dumps(result, indent=2, ensure_ascii=True))
    return 0


if __name__ == '__main__':
    sys.exit(main())
