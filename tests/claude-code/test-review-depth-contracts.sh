#!/usr/bin/env bash
# Dispatch wiring checks. Behavioral evidence lives in codex/sdd-behavior/review-depth.
set -euo pipefail
cd "$(dirname "$0")/../.."
python3 - <<'PY'
from pathlib import Path

root = Path('skills')
shared = root / 'requesting-code-review/references/review-method.md'
assert shared.is_file(), 'missing shared review method'
selector = shared.with_name('profile-selection.md').read_text()
ux_profile = shared.with_name('ux-copy-checklist.md')
assert any(row.startswith('| UX copy |') and ux_profile.name in row
           for row in selector.splitlines()), 'missing shared UX copy profile'
ux_guide = '../../writing-ux-copy/SKILL.md'
assert f']({ux_guide})' in ux_profile.read_text() and (ux_profile.parent / ux_guide).is_file(), \
    'UX copy review must point to the writing skill'
method = shared.read_text()
for field in ('Contract and behavior', 'Failure paths', 'Boundary conditions',
              'Compatibility and integration', 'Test adequacy', 'Maintainability',
              'NOT CHECKED', 'N/A', 'Evidence'):
    assert field in method, f'missing baseline coverage: {field}'
for name in ('requesting-code-review/code-reviewer.md',
             'subagent-driven-development/task-reviewer-prompt.md',
             'subagent-driven-development/re-review-prompt.md',
             'subagent-driven-development/final-reviewer-prompt.md'):
    text = (root / name).read_text()
    assert 'review-method.md' in text, f'{name} bypasses shared method'
    assert 'profile-selection.md' in text, f'{name} bypasses profile selection'
    assert 'coverage' in text.lower(), f'{name} omits coverage output'
for name in ('requesting-code-review/SKILL.md', 'subagent-driven-development/SKILL.md'):
    text = (root / name).read_text()
    assert 'profile-selection.md' in text, f'{name} bypasses profile selection'
    assert 'NOT CHECKED' in text, f'{name} accepts incomplete coverage'
sdd = (root / 'subagent-driven-development/SKILL.md').read_text()
assert 'final-reviewer-prompt.md' in sdd, 'final review lacks a dispatch template'
assert 're-review-prompt.md' in sdd, 'correction review lost its bounded template'
assert 'two' in sdd, 'correction budget removed'
print('Review-depth dispatch contracts passed')
PY
