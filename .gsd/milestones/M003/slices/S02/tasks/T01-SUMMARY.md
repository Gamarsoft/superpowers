---
id: T01
parent: S02
milestone: M003
provides:
  - Explicit visual-companion protocol wording for startup, artifact-first sequencing, question-tool continuity, and degraded fallback in the parser-sensitive workflow docs
key_files:
  - skills/brainstorming/SKILL.md
  - skills/brainstorming/visual-companion.md
  - .gsd/milestones/M003/slices/S02/S02-PLAN.md
  - .gsd/milestones/M003/slices/S02/tasks/T01-PLAN.md
key_decisions:
  - Mirror the contract-test anchor phrases directly in the authored workflow sections instead of paraphrasing them
patterns_established:
  - Parser-sensitive workflow docs expose protocol drift through exact section read-back plus the contract test's fail-fast missing-anchor output
observability_surfaces:
  - skills/brainstorming/SKILL.md; skills/brainstorming/visual-companion.md; node tests/brainstorm-server/visual-companion-contract.test.js fail-fast output
duration: 40m
verification_result: passed
completed_at: 2026-03-30 13:49:48 CET
# Set blocker_discovered: true only if execution revealed the remaining slice plan
# is fundamentally invalid (wrong API, missing capability, architectural mismatch).
# Do NOT set true for ordinary bugs, minor deviations, or fixable issues.
blocker_discovered: false
---

# T01: Mirror the M003 protocol rules into the authored workflow docs

**Hardened the authored visual-companion workflow docs so the parser-sensitive sections now state first-turn startup, artifact-first sequencing, question-tool continuity, and the degraded fallback explicitly.**

## What Happened

I started with the named M003 pressure-scenario artifact and the two parser-sensitive workflow sections, then added the smallest wording needed to make the authored contract explicit without renaming or moving headings.

In `skills/brainstorming/SKILL.md`, I added explicit startup wording for the first later genuinely visual question after consent, kept the terminal-primary model by requiring the terminal decision prompt on every qualifying visual turn even after earlier browser use, and named plain terminal prompting as degraded behavior when the platform question tool is unavailable.

In `skills/brainstorming/visual-companion.md`, I hardened `## Per-question decision rule` so each qualifying visual turn is explicitly artifact-first: author or refresh the artifact first, make it viewable, tell the user what they are seeing and what decision it supports, then ask the terminal decision or confirmation with the platform question tool when available. I mirrored the later-turn continuity and degraded-fallback wording there so the two docs stay aligned.

Per the unit pre-flight requirement, I also fixed the flagged planning gaps before implementation. `S02-PLAN.md` now includes a verification step that points future agents at the contract test's fail-fast missing-anchor output, and `T01-PLAN.md` now has an `## Observability Impact` section that explains how to inspect authored drift later.

## Verification

### Task verification
- Passed: read back `skills/brainstorming/SKILL.md` `## Visual companion` and confirmed it explicitly names first-turn startup, later-turn question-tool continuity, and degraded fallback.
- Passed: read back `skills/brainstorming/visual-companion.md` `## Per-question decision rule` and confirmed the artifact is created or refreshed before the terminal decision prompt.

### Slice verification run during T01
- Passed: `node tests/brainstorm-server/visual-companion-contract.test.js`
- Passed: read back `skills/brainstorming/SKILL.md` (`## Visual companion`) and `skills/brainstorming/visual-companion.md` (`## Per-question decision rule`) and confirmed the wording mirrors the M003 pressure-scenario outcomes while keeping the section headings unchanged.

## Diagnostics

Inspect later with:
- `skills/brainstorming/SKILL.md` → `## Visual companion`
- `skills/brainstorming/visual-companion.md` → `## Per-question decision rule`
- `node tests/brainstorm-server/visual-companion-contract.test.js`

If the wording drifts, the contract test now remains the primary diagnostic surface because its fail-fast output points at the first missing authored anchor: startup, artifact-first sequencing, question-tool continuity, or degraded fallback.

## Quality Check

**Diff reviewed:** `HEAD..WORKTREE` — 4 files, 16 insertions
**Checklists applied:** security, code-quality

### Issues Found

#### Critical
- none

#### Important
- none

#### Minor
- none

**Verdict:** PASS

## Deviations

- Added the required diagnostic failure-path verification step to `.gsd/milestones/M003/slices/S02/S02-PLAN.md` before implementation.
- Added the required `## Observability Impact` section to `.gsd/milestones/M003/slices/S02/tasks/T01-PLAN.md` before implementation.

## Known Issues

- None.

## Files Created/Modified

- `skills/brainstorming/SKILL.md` — updated `## Visual companion` with explicit first-turn startup, artifact-first continuity, question-tool continuity, and degraded-fallback wording.
- `skills/brainstorming/visual-companion.md` — updated `## Per-question decision rule` to make the qualifying-turn protocol explicitly artifact-first and to mirror continuity and degraded fallback.
- `.gsd/milestones/M003/slices/S02/S02-PLAN.md` — added a diagnostic verification step for inspectable fail-fast contract-test output and marked T01 complete.
- `.gsd/milestones/M003/slices/S02/tasks/T01-PLAN.md` — added `## Observability Impact` for future inspection and failure visibility.
- `.gsd/STATE.md` — advanced the next action to T02.
- `.gsd/milestones/M003/slices/S02/tasks/T01-SUMMARY.md` — recorded the task outcome, verification, and diagnostics.
