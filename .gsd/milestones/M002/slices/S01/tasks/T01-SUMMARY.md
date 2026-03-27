---
id: T01
parent: S01
milestone: M002
provides:
  - Contract-level regression coverage for the stricter S01 routing rule, pre-display quality gate, revise-or-stay-terminal fallback, and active-example refresh boundary
  - Explicit failure surfaces that tell downstream doc/example work exactly which authored sections are still missing
key_files:
  - tests/brainstorm-server/visual-companion-contract.test.js
  - .gsd/milestones/M002/slices/S01/tasks/T01-PLAN.md
  - .gsd/milestones/M002/slices/S01/S01-PLAN.md
  - .gsd/DECISIONS.md
  - .gsd/STATE.md
key_decisions:
  - Lock the new S01 proof to section-scoped parsing with ordered checklist labels and an explicit `Active example refresh boundary (M002)` block instead of broad whole-document phrase checks.
patterns_established:
  - Use named markdown sections plus ordered bold-numbered labels when extending authored-contract tests so later tasks can satisfy the bar without guessing at wording drift.
observability_surfaces:
  - node tests/brainstorm-server/visual-companion-contract.test.js
  - git diff --name-only -- skills/brainstorming/examples/visual-companion
duration: ~45m
verification_result: passed
completed_at: 2026-03-29 23:06:38 CEST
# Set blocker_discovered: true only if execution revealed the remaining slice plan
# is fundamentally invalid (wrong API, missing capability, architectural mismatch).
# Do NOT set true for ordinary bugs, minor deviations, or fixable issues.
blocker_discovered: false
---

# T01: Extend the contract regression for the stricter S01 bar

**Extended the authored-contract regression so missing M002 routing, quality-gate, fallback, and active-example-boundary language now fails mechanically with targeted assertion names.**

## What Happened

I started by applying the unit’s required pre-flight fixes: `T01-PLAN.md` now has an `## Observability Impact` section, and `S01-PLAN.md` now includes an explicit failure-path verification step that tells future agents to inspect the named assertion when the contract test is red.

Then I extended `tests/brainstorm-server/visual-companion-contract.test.js` using the same narrow parsing style established in M001 instead of switching to broad document-wide phrase hunting. The test now reads specific sections and ordered lists to prove three new areas:

- genuinely-visual routing plus explicit terminal fallback for conceptual, scope, and text-first turns
- a named `Pre-display quality gate` section with four ordered checklist labels, a hard `No placeholder screens.` rule, and explicit `revise the artifact or stay in terminal` failure behavior
- an `Active example refresh boundary (M002)` block that lists only the three in-scope example files and explicitly keeps `carry-forward-summary.html` outside the refresh boundary

I also appended D022 to `.gsd/DECISIONS.md` so T02/T03 know the new proof expects named sections and ordered checklist structure, not just semantically similar prose.

Finally, I ran the contract test to establish the intended red bar for this task. It now fails on missing S01 wording exactly where expected, which means T02/T03 can drive the docs/examples to green without guessing what the test wants.

## Verification

- `node tests/brainstorm-server/visual-companion-contract.test.js` → **FAIL as expected** with `Expected visual-companion.md visual routing threshold to include "materially easier to judge by seeing"`
- `git diff --name-only -- skills/brainstorming/examples/visual-companion` → **PASS** (no output; no example files changed during T01)
- Readback check of `.gsd/milestones/M002/slices/S01/tasks/T01-PLAN.md` → **PASS** (`## Observability Impact` added)
- Readback check of `.gsd/milestones/M002/slices/S01/S01-PLAN.md` → **PASS** (failure-path verification step added)

## Quality Check

**Diff reviewed:** `HEAD..WORKTREE` — 6 task files touched
**Checklists applied:** security, code-quality, solid

### Issues Found

#### Critical
- none

#### Important
- none

#### Minor
- none

**Verdict:** PASS

## Diagnostics

- Primary failure surface: `node tests/brainstorm-server/visual-companion-contract.test.js`
- Failure inspection rule: read the named assertion in stderr/stdout; it should identify the missing routing phrase, checklist section, or boundary block directly
- Boundary drift check for later tasks: `git diff --name-only -- skills/brainstorming/examples/visual-companion`

## Deviations

- Added the required pre-flight observability/failure-path fixes to `T01-PLAN.md` and `S01-PLAN.md` before extending the regression, because the unit explicitly required those gaps to be closed first.
- Appended D022 to `.gsd/DECISIONS.md` so downstream work has an explicit contract-proof structure to follow.

## Known Issues

- The contract test is intentionally red until T02/T03 add the missing S01 doc language and active-example-boundary block.

## Files Created/Modified

- `tests/brainstorm-server/visual-companion-contract.test.js` — added section-scoped assertions for genuinely-visual routing, terminal fallback, the pre-display quality gate, the placeholder-screen ban, revise-or-stay-terminal behavior, and the M002 active-example boundary.
- `.gsd/milestones/M002/slices/S01/tasks/T01-PLAN.md` — added the missing `## Observability Impact` section required by the unit pre-flight gate.
- `.gsd/milestones/M002/slices/S01/S01-PLAN.md` — added explicit failure-path verification language and marked T01 complete.
- `.gsd/DECISIONS.md` — appended D022 describing the new section-scoped contract-proof structure for M002.
- `.gsd/STATE.md` — recorded M002/S01 progress and advanced the next action to T02.
- `.gsd/milestones/M002/slices/S01/tasks/T01-SUMMARY.md` — recorded the task outcome, verification, diagnostics, and closeout state.
