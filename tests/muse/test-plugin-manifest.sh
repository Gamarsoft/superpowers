#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/../.."
python3 - <<'PY'
import json
from pathlib import Path
manifest = json.loads(Path('.muse-plugin/plugin.json').read_text())
entries = manifest['capabilities']['skills']
registered = {entry['id']: entry['path'] for entry in entries}
actual = {path.parent.name: path.as_posix() for path in Path('skills').glob('*/SKILL.md')}
assert len(entries) == len(registered), 'Duplicate Muse skill IDs'
assert registered == actual, f'Muse inventory mismatch: missing={sorted(actual.keys()-registered.keys())}; stale={sorted(registered.keys()-actual.keys())}'
assert manifest['version'] == json.loads(Path('package.json').read_text())['version']
assert manifest['capabilities']['hooks'][0]['command'] == ['sh', 'hooks/session-start']
print(f'PASS: Muse registers all {len(actual)} skills and the session bootstrap')
PY
