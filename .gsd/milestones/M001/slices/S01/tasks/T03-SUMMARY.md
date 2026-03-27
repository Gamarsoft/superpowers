---
id: T03
parent: S01
milestone: M001
provides:
  - Repeatable contract regression coverage that locks archetype labels, workflow ordering, degraded-mode wording, compatibility boundary, and example-kit presence
  - Re-verified runtime regressions proving S01 documentation/example work stayed additive to the existing server/WebSocket contract
key_files:
  - tests/brainstorm-server/visual-companion-contract.test.js
  - .gsd/milestones/M001/slices/S01/tasks/T03-PLAN.md
  - .gsd/milestones/M001/slices/S01/S01-PLAN.md
  - .gsd/STATE.md
key_decisions:
  - Make archetype locking section-scoped and order-exact (parse the v1 contract block, not loose whole-document matches)
  - Lock example-kit drift via both filesystem assertions and guide link-order assertions
patterns_established:
  - Contract tests should emit explicit missing-marker failures for docs/examples rather than generic mismatch messages
  - Slice closure keeps runtime regressions in the verification chain even for documentation-first tasks
observability_surfaces:
  - Contract drift command: `node tests/brainstorm-server/visual-companion-contract.test.js`
  - Runtime diagnostic regressions: `cd tests/brainstorm-server && node server.test.js && node ws-protocol.test.js`
  - Runtime signal grep: `rg -n "server-stopped|watch-fallback|owner-pid-invalid|state/events" skills/brainstorming/scripts/server.cjs tests/brainstorm-server/server.test.js`
duration: ~35m
verification_result: passed
completed_at: 2026-03-27T16:58:00Z
# Set blocker_discovered: true only if execution revealed the remaining slice plan
# is fundamentally invalid (wrong API, missing capability, architectural mismatch).
# Do NOT set true for ordinary bugs, minor deviations, or fixable issues.
blocker_discovered: false
---

# T03: Lock the contract with regression checks

**Expanded the contract regression test to lock the guide/example kit boundaries and re-ran runtime regressions to prove S01 stayed additive.**

## What Happened

Applied the pre-flight gate fix first by adding `## Observability Impact` to `.gsd/milestones/M001/slices/S01/tasks/T03-PLAN.md`.

Then rewrote `tests/brainstorm-server/visual-companion-contract.test.js` to cover the full T03 contract surface:

- exact four archetype labels in order from the `v1 authoring contract` section
- explicit `/frontend-design` + `$frontend-design` routing rule in guidance docs
- ordered first-use workflow (`instruction context` → `repo design-context source if present` → `one-time minimal session capture` → `degraded mode`)
- explicit degraded-mode wording checks
- explicit full-document compatibility + `data-choice` boundary checks
- required example kit presence (`side-by-side-comparison.html`, `ranked-alternatives.html`, `annotated-recommendation.html`, `carry-forward-summary.html`)
- guide link ordering for the four examples

Initial run failed because the guide-link regex matched markdown text and target paths twice. Tightened the matcher to capture only link targets, then reran the full chain to green.

Marked T03 complete in `.gsd/milestones/M001/slices/S01/S01-PLAN.md` and updated `.gsd/STATE.md` to reflect slice-closeout readiness.

## Verification

Executed and passed:

- `node tests/brainstorm-server/visual-companion-contract.test.js` → **PASS**
- `cd tests/brainstorm-server && node server.test.js && node ws-protocol.test.js` → **PASS**
  - `server.test.js`: `26 passed, 0 failed`
  - `ws-protocol.test.js`: `31 passed, 0 failed`
- `rg -n "server-stopped|watch-fallback|owner-pid-invalid|state/events" skills/brainstorming/scripts/server.cjs tests/brainstorm-server/server.test.js` → **PASS** (diagnostic strings present in runtime and regression suite)

## Quality Check

**Diff reviewed:** `b41d7e8..WORKTREE` — task-plan observability patch + contract regression test hardening + slice/task state artifacts
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

- Contract drift surface: `tests/brainstorm-server/visual-companion-contract.test.js`
- Guidance source of truth: `skills/brainstorming/visual-companion.md` (+ mirrored companion contract in `skills/brainstorming/SKILL.md`)
- Example artifact surface: `skills/brainstorming/examples/visual-companion/*.html`
- Runtime diagnostics preserved: `state/events`, `state/server-stopped`, and watch/owner failure markers exercised by `tests/brainstorm-server/server.test.js`

## Deviations

- `visual-companion-contract.test.js` already existed from prior slice work, so this task hardened/expanded that file instead of creating it from scratch.

## Known Issues

- none

## Files Created/Modified

- `tests/brainstorm-server/visual-companion-contract.test.js` — expanded contract assertions for archetypes, workflow/order, degraded mode, compatibility wording, and example-kit presence/linking.
- `.gsd/milestones/M001/slices/S01/tasks/T03-PLAN.md` — added required `## Observability Impact` section from pre-flight gate.
- `.gsd/milestones/M001/slices/S01/S01-PLAN.md` — marked T03 complete (`[x]`).
- `.gsd/STATE.md` — advanced phase/next action to slice-closeout readiness.
- `.gsd/milestones/M001/slices/S01/tasks/T03-SUMMARY.md` — recorded execution, verification, quality checklist verdict, and diagnostics for T03.
