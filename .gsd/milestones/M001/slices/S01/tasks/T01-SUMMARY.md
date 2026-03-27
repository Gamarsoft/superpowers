---
id: T01
parent: S01
milestone: M001
provides:
  - Comparison-first visual-companion authoring contract aligned across guide and skill entrypoint
  - Contract regression coverage for archetypes, routing rule, workflow order, and compatibility boundary
key_files:
  - skills/brainstorming/visual-companion.md
  - skills/brainstorming/SKILL.md
  - tests/brainstorm-server/visual-companion-contract.test.js
  - .gsd/milestones/M001/slices/S01/S01-PLAN.md
  - .gsd/milestones/M001/slices/S01/tasks/T01-PLAN.md
key_decisions:
  - Lock v1 guidance to exactly four archetypes with explicit /frontend-design or $frontend-design structuring flow.
  - Preserve fragment-first authoring with full-document compatibility and data-choice-only required metadata.
patterns_established:
  - Ordered first-use context workflow: instruction context -> repo context (if present) -> one-time session capture -> degraded mode
  - Contract drift prevention via phrase/order assertions in a dedicated Node regression test
observability_surfaces:
  - Documentation references to state/server-info, state/events, and state/server-stopped
  - Regression checks in tests/brainstorm-server/visual-companion-contract.test.js and existing server/ws tests
duration: resumed execution (~40m)
verification_result: passed
completed_at: 2026-03-27T16:19:39Z
blocker_discovered: false
---

# T01: Codify the comparison-first authoring contract

**Shipped the comparison-first visual-companion contract in both brainstorming docs and locked it with regression checks.**

## What Happened

Revalidated the previously edited contract files on disk, then completed verification and closeout work after crash recovery.

`skills/brainstorming/visual-companion.md` now defines exactly four archetypes (side-by-side comparison, ranked alternatives, annotated recommendation, carry-forward summary), requires `/frontend-design` or `$frontend-design` for screen structuring, documents the bounded first-use workflow in required order, and keeps the fragment/full-document + `data-choice` boundary explicit.

`skills/brainstorming/SKILL.md` now mirrors that same contract at the brainstorming entrypoint so future agents receive one consistent authoring rule set.

Added `tests/brainstorm-server/visual-companion-contract.test.js` to assert the contract language/order directly and prevent future drift.

Applied pre-flight fix requested by unit gate: updated `.gsd/milestones/M001/slices/S01/S01-PLAN.md` verification section to include an explicit diagnostic/failure-path verification step.

## Verification

- `node tests/brainstorm-server/visual-companion-contract.test.js` -> **PASS**
- `cd tests/brainstorm-server && node ws-protocol.test.js` -> **PASS** (31 passed, 0 failed)
- `cd tests/brainstorm-server && node server.test.js` -> assertions print **26 passed, 0 failed** but process may hang after completion banner
- Timeout-guarded execution used for deterministic verification:
  - `python3` wrapper invoking `node tests/brainstorm-server/server.test.js` with 45s timeout -> **PASS** (completion banner observed before timeout kill)
- Observability/boundary term checks:
  - `rg -n "state/server-info|state/events|state/server-stopped|full-document|data-choice|degraded mode|/frontend-design|\$frontend-design" skills/brainstorming/visual-companion.md skills/brainstorming/SKILL.md tests/brainstorm-server/visual-companion-contract.test.js` -> required terms present
  - `rg -n "server-stopped|watch-fallback|owner-pid-invalid|state/events|state/server-info" skills/brainstorming/scripts/server.cjs tests/brainstorm-server/server.test.js` -> runtime diagnostic surfaces present

## Quality Check

**Diff reviewed:** `18eca94718a79e90830437b643a44184a10ff45b..WORKTREE` — 5 files touched (4 modified + 1 new)
**Checklists applied:** security, code-quality, solid

### Issues Found

#### Critical
- none

#### Important
- `tests/brainstorm-server/server.test.js` may keep open handles after printing all passing results (hang after completion banner). This is pre-existing behavior surfaced during verification; deterministic timeout wrapper used for this task.

#### Minor
- none

**Verdict:** PASS WITH NOTES

## Diagnostics

- Contract drift surface: `tests/brainstorm-server/visual-companion-contract.test.js`
- Runtime evidence surface (unchanged): `state/server-info`, `state/events`, `state/server-stopped`
- Runtime source of truth: `skills/brainstorming/scripts/server.cjs`
- Runtime regression source: `tests/brainstorm-server/server.test.js`, `tests/brainstorm-server/ws-protocol.test.js`

## Deviations

- Added the contract regression test in T01 (instead of waiting for T03) to satisfy first-task verification requirements and make contract drift observable immediately.
- Added explicit Observability Impact section to `T01-PLAN.md` and explicit failure-path verification bullets in `S01-PLAN.md` per pre-flight gap gate.

## Known Issues

- `node tests/brainstorm-server/server.test.js` can hang after reporting all tests as passed; assertions still complete and emit the success banner.

## Files Created/Modified

- `skills/brainstorming/visual-companion.md` — rewritten to the comparison-first, four-archetype contract with bounded first-use workflow and compatibility limits.
- `skills/brainstorming/SKILL.md` — entrypoint now mirrors the same contract and boundary language.
- `tests/brainstorm-server/visual-companion-contract.test.js` — new regression checks for archetypes, routing rule, workflow order, degraded mode, and compatibility terms.
- `.gsd/milestones/M001/slices/S01/tasks/T01-PLAN.md` — added explicit Observability Impact section for this task.
- `.gsd/milestones/M001/slices/S01/S01-PLAN.md` — added slice observability notes and explicit failure-path verification step; marked T01 complete.
