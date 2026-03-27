---
estimated_steps: 4
estimated_files: 4
---

# T02: Turn the authored-contract surface GREEN and record the slice evidence

**Slice:** S02 — Protocol wording hardening and GREEN rerun
**Milestone:** M003

## Description

Close the writing-skills plus TDD loop by rerunning the authored-contract suite to GREEN, fixing only any remaining wording gaps it exposes, and recording the passing proof for downstream slices.

## Steps

1. Run `node tests/brainstorm-server/visual-companion-contract.test.js` after T01 and inspect the fail-fast output.
2. If the suite still fails, make the smallest wording adjustment needed in `skills/brainstorming/SKILL.md` or `skills/brainstorming/visual-companion.md` and rerun until the contract surface is GREEN.
3. Write `S02-SUMMARY.md` with the final verification evidence, the exact protocol outcomes now proven, and the reminder that runtime/helper/frame-template scope stayed untouched.
4. Read back the summary and confirm it names the passing command and the authored sections that satisfied it.

## Must-Haves

- [ ] `node tests/brainstorm-server/visual-companion-contract.test.js` passes after the S02 doc edits.
- [ ] `.gsd/milestones/M003/slices/S02/S02-SUMMARY.md` records the green rerun and the protocol wording outcomes it proved.

## Verification

- `node tests/brainstorm-server/visual-companion-contract.test.js`
- Read back `.gsd/milestones/M003/slices/S02/S02-SUMMARY.md` and confirm it records the passing authored-contract proof and the no-runtime-change boundary.

## Observability Impact

- Signals changed: none at runtime; this task only closes the authored-contract proof surface by rerunning `node tests/brainstorm-server/visual-companion-contract.test.js` and recording the passing evidence.
- Future inspection: use the contract test output plus the read-back sections in `skills/brainstorming/SKILL.md` (`## Visual companion`), `skills/brainstorming/visual-companion.md` (`## Per-question decision rule`), and `.gsd/milestones/M003/slices/S02/S02-SUMMARY.md`.
- Failure visibility: if wording drifts again, the contract test should fail fast on the first missing authored anchor, making the remaining gap visible as startup, artifact-first sequencing, question-tool continuity, or degraded fallback.

## Inputs

- `.gsd/milestones/M003/slices/S02/tasks/T01-PLAN.md` — the doc surfaces and protocol outcomes that must be in place before the green rerun
- `tests/brainstorm-server/visual-companion-contract.test.js` — the authoritative section-scoped proof surface for S02
- `skills/brainstorming/SKILL.md` — updated `## Visual companion` section under test
- `skills/brainstorming/visual-companion.md` — updated `## Per-question decision rule` section under test

## Expected Output

- `.gsd/milestones/M003/slices/S02/S02-SUMMARY.md` — recorded green proof for the hardened authored protocol
- `skills/brainstorming/SKILL.md` and/or `skills/brainstorming/visual-companion.md` — only if a final wording tweak is needed to satisfy the last failing contract anchor
