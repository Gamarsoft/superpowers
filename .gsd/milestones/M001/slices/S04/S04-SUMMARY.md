---
id: S04
parent: M001
milestone: M001
provides:
  - Final integrated validation evidence that closes M001 on the real runtime boundary and moves R006/R011 from mapped to validated
requires:
  - slice: S02
    provides: Fragment-shell boundary coverage and shared-frame comparison-default proof surfaces
  - slice: S03
    provides: Explicit authored carry-forward behavior and live continuity proof surfaces for click-assisted and terminal-only flows
affects:
  - M001 closure
key_files:
  - .gsd/milestones/M001/M001-ROADMAP.md
  - .gsd/REQUIREMENTS.md
  - .gsd/PROJECT.md
  - .gsd/STATE.md
  - .gsd/DECISIONS.md
  - .gsd/milestones/M001/slices/S04/S04-PLAN.md
  - tests/brainstorm-server/windows-lifecycle.test.sh
  - tests/brainstorm-server/live-companion-acceptance.test.js
key_decisions:
  - D017: Use the refreshed lifecycle script, server/WebSocket suites, and real-entrypoint acceptance test as the authoritative automated S04 proof stack.
  - D018: Preserve lifecycle failure artifacts so compatibility drift can be localized at the real runtime boundary.
  - D019: Preserve live-acceptance failure artifacts while still verifying green-path teardown.
  - D020: Close R006 and R011 only when the full automated matrix passes and a live browser flow is corroborated by `state/server-info`, `state/server.log`, and `state/events`.
patterns_established:
  - Milestone closure evidence should pair a passing automated matrix with a live browser flow tied back to persisted runtime state instead of relying on browser reload behavior alone.
  - Compatibility proof stays trustworthy when fragment-boundary checks use both positive fragment-shell assertions and negative full-document contamination assertions.
  - Carry-forward proof remains valid only when authored continuity copy stays explicit after `state/events` is written and then cleared on a fresher screen.
observability_surfaces:
  - node tests/brainstorm-server/visual-companion-contract.test.js
  - node tests/brainstorm-server/fragment-comparison-defaults.test.js
  - node tests/brainstorm-server/carry-forward-behavior.test.js
  - cd tests/brainstorm-server && node server.test.js && node ws-protocol.test.js
  - cd tests/brainstorm-server && bash windows-lifecycle.test.sh
  - node tests/brainstorm-server/live-companion-acceptance.test.js
  - start-server.sh startup JSON
  - state/server-info
  - state/server.log
  - state/events
  - explicit browser assertions for visible copy and fragment-shell absence on full-document passthrough
drill_down_paths:
  - .gsd/milestones/M001/slices/S04/tasks/T01-SUMMARY.md
  - .gsd/milestones/M001/slices/S04/tasks/T02-SUMMARY.md
  - .gsd/milestones/M001/slices/S04/tasks/T03-SUMMARY.md
duration: ~2h 30m
verification_result: passed
completed_at: 2026-03-28T15:56:43Z
---

# S04: Compatibility and integrated validation

**Closed M001 on a green validation matrix plus a live browser/state acceptance pass, proving the current runtime contract and existing screen continuity end to end.**

## What Happened

S04 finished the milestone by upgrading proof quality instead of expanding runtime scope.

T01 replaced the stale lifecycle script with a current-contract compatibility check that uses `start-server.sh` / `stop-server.sh`, verifies startup metadata and `state/server-info` parity, fetches helper-served HTML through the live URL, proves newest-screen selection and `state/events` clearing, and preserves failure artifacts for inspection.

T02 added a real-entrypoint acceptance test that starts the live companion through `start-server.sh`, serves authored fragment and carry-forward examples, simulates a real choice event write, confirms a fresher carry-forward screen clears `state/events` while explicit `Chosen direction`, `Still open`, and `Degraded mode` copy remains visible, then proves a fresher full-document screen passes through without fragment-shell contamination.

T03 turned those refreshed proof surfaces into closure evidence. I ran the entire automated matrix, then repeated the core acceptance path manually in the browser against a fresh live session. The browser pass deliberately used server-side state as the tie-breaker: after clicking the fragment `data-choice`, `state/events` contained the clicked choice; after adding the newer carry-forward screen, the browser showed explicit continuity copy and `state/events` was gone; after adding the newer full-document screen, the browser DOM still exposed `window.brainstorm` but did not expose `data-comparison-kit="fragment-shell"`, `.indicator-bar`, `#claude-content`, or `.header`. With that evidence in hand, S04 moved R006 and R011 from mapped to validated and closed M001.

## Verification

All slice-level verification passed:

- `node tests/brainstorm-server/visual-companion-contract.test.js`
- `node tests/brainstorm-server/fragment-comparison-defaults.test.js`
- `node tests/brainstorm-server/carry-forward-behavior.test.js`
- `cd tests/brainstorm-server && node server.test.js && node ws-protocol.test.js`
- `cd tests/brainstorm-server && bash windows-lifecycle.test.sh`
- `node tests/brainstorm-server/live-companion-acceptance.test.js`
- Combined green matrix: `node tests/brainstorm-server/visual-companion-contract.test.js && node tests/brainstorm-server/fragment-comparison-defaults.test.js && node tests/brainstorm-server/carry-forward-behavior.test.js && cd tests/brainstorm-server && node server.test.js && node ws-protocol.test.js && bash windows-lifecycle.test.sh && cd ../.. && node tests/brainstorm-server/live-companion-acceptance.test.js`

Live runtime acceptance also passed:

- Started the companion through `skills/brainstorming/scripts/start-server.sh` and confirmed startup JSON matched `state/server-info`.
- Loaded the authored fragment example in the browser and verified visible `Annotated recommendation: settings information architecture`, `Chosen direction: task-grouped settings`, and `Still open alternative: technical-stack sections` content.
- Clicked `[data-choice='task-grouped-settings']`, verified browser text `Selected: Chosen direction: task-grouped settings`, and confirmed `state/events` contained the clicked choice.
- Added a genuinely newer carry-forward screen, waited for reload, verified visible `Decision checkpoint: export flow`, `Chosen direction: drawer-based export flow`, `Still open: permission fallback copy`, and `Degraded mode`, then confirmed `state/events` was absent.
- Added a genuinely newer full-document screen, verified `#full-document-marker` plus boundary copy in the browser, and confirmed via DOM evaluation that `window.brainstorm` was present while `[data-comparison-kit="fragment-shell"]`, `.indicator-bar`, `#claude-content`, and `.header` were all absent.
- Stopped the live session with `skills/brainstorming/scripts/stop-server.sh` after the browser pass completed.

## Requirements Advanced

- R006 — Advanced from mapped to validated by the passing contract, fragment-boundary, server/WebSocket, lifecycle, and real-entrypoint suites plus the live browser/state corroboration against `state/server-info`, `state/server.log`, and `state/events`.
- R011 — Advanced from mapped to validated by the same green matrix plus the live browser proof that existing authored fragment screens, terminal-only carry-forward screens, and full-document passthrough all still behave correctly through the real entrypoint.

## Requirements Validated

- R006 — Current HTML/runtime contract stays intact.
- R011 — Existing screens and terminal-only flows keep working.

## New Requirements Surfaced

- none

## Requirements Invalidated or Re-scoped

- none

## Deviations

- Added the missing `## Observability Impact` section to `.gsd/milestones/M001/slices/S04/tasks/T03-PLAN.md` during unit pre-flight so the task had an explicit inspection contract before closure work began.

## Known Limitations

- Browser diagnostics still report a benign favicon 404 during live checks. It does not affect the runtime contract, lifecycle behavior, WebSocket/event handling, or full-document boundary assertions.

## Follow-ups

- None required for M001 closure.

## Files Created/Modified

- `.gsd/milestones/M001/slices/S04/S04-SUMMARY.md` — recorded the slice closure evidence, requirement movement, and authoritative diagnostics.
- `.gsd/milestones/M001/M001-ROADMAP.md` — marked S04 complete and added milestone closure evidence tied to the passing matrix plus live browser/state proof.
- `.gsd/REQUIREMENTS.md` — moved R006 and R011 from active/mapped to validated.
- `.gsd/PROJECT.md` — refreshed project status to show M001 complete.
- `.gsd/STATE.md` — advanced global planning state from executing to complete.
- `.gsd/DECISIONS.md` — recorded the milestone-closure evidence contract used by S04.
- `.gsd/milestones/M001/slices/S04/S04-PLAN.md` — marked T03 complete.
- `.gsd/milestones/M001/slices/S04/tasks/T03-PLAN.md` — added the missing observability-impact section required for this unit.
- `tests/brainstorm-server/windows-lifecycle.test.sh` — remains the refreshed lifecycle compatibility proof surface used by this slice.
- `tests/brainstorm-server/live-companion-acceptance.test.js` — remains the real-entrypoint acceptance proof surface used by this slice.
