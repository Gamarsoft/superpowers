---
id: T01
parent: S02
milestone: M002
provides:
  - A green real-entrypoint runtime matrix for the refreshed M002 examples with no proven runtime drift
key_files:
  - tests/brainstorm-server/live-companion-acceptance.test.js
  - tests/brainstorm-server/windows-lifecycle.test.sh
  - tests/brainstorm-server/server.test.js
  - tests/brainstorm-server/ws-protocol.test.js
  - .gsd/milestones/M002/slices/S02/S02-PLAN.md
  - .gsd/STATE.md
key_decisions:
  - Left the runtime untouched because the authoritative matrix stayed green end to end.
patterns_established:
  - Run the real-entrypoint acceptance and lifecycle checks before lower-level server and WebSocket suites, then rerun the exact chained verification command to close the task.
observability_surfaces:
  - state/server-info
  - state/server.log
  - state/events
  - tests/brainstorm-server/live-companion-acceptance.test.js preserved failure artifacts
  - tests/brainstorm-server/windows-lifecycle.test.sh preserved failure artifacts
duration: ~15m
verification_result: passed
completed_at: 2026-03-30 00:02:17 +0200
blocker_discovered: false
---

# T01: Run the real-entrypoint runtime matrix and localize any drift

**Confirmed the refreshed M002 examples pass the full real-entrypoint runtime matrix without any runtime or authored-file changes.**

## What Happened

I ran the four authoritative runtime checks in the research-defined order so the real `start-server.sh` / `stop-server.sh` path was proven before the lower-level suites. `live-companion-acceptance.test.js` passed against the refreshed annotated recommendation, unchanged carry-forward example, and full-document passthrough fixture. `windows-lifecycle.test.sh` then passed the startup-metadata, helper-injection, newest-screen, `state/events`, and `state/server.log` checks. `server.test.js` and `ws-protocol.test.js` both stayed green, so there was no evidence of drift in `start-server.sh`, `server.cjs`, helper injection, lifecycle handling, or the authored example boundary.

Because nothing failed, the task stayed in localization mode only long enough to confirm that no contradiction existed. I then reran the exact chained matrix command from the task and slice plan so the closeout proof matched the written contract verbatim.

## Verification

- `node tests/brainstorm-server/live-companion-acceptance.test.js` → PASS (6/6)
- `bash tests/brainstorm-server/windows-lifecycle.test.sh` → PASS (10/10)
- `node tests/brainstorm-server/server.test.js` → PASS (26/26)
- `node tests/brainstorm-server/ws-protocol.test.js` → PASS (31/31)
- `node tests/brainstorm-server/live-companion-acceptance.test.js && bash tests/brainstorm-server/windows-lifecycle.test.sh && node tests/brainstorm-server/server.test.js && node tests/brainstorm-server/ws-protocol.test.js` → PASS
- Observability surfaces verified through the passing suites:
  - `state/server-info` parity with startup JSON
  - `state/server.log` `screen-added` / `screen-updated` diagnostics
  - `state/events` write-and-clear behavior across choice submission and genuinely newer screens
  - preserved acceptance/lifecycle temp-session artifacts remain the first failure-inspection surface if a later rerun regresses

## Quality Check

**Checklist application announced:** security first, then code-quality, then SOLID.
**Diff reviewed:** `fb1472c60b5a48eac02465f5c16adb2a402f3584..WORKTREE` — 1 tracked checkbox update, 1 new task summary, and the ignored local `.gsd/STATE.md` handoff update
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

Rerun the matrix in this order if T02 or T03 surfaces a contradiction:

1. `node tests/brainstorm-server/live-companion-acceptance.test.js`
2. `bash tests/brainstorm-server/windows-lifecycle.test.sh`
3. `node tests/brainstorm-server/server.test.js`
4. `node tests/brainstorm-server/ws-protocol.test.js`

If one fails, inspect the preserved temp-session artifacts printed by the failing acceptance or lifecycle suite before editing runtime files. The authoritative runtime signals remain `state/server-info`, `state/server.log`, and `state/events`.

## Deviations

None.

## Known Issues

None in the T01 runtime matrix. The earlier manual-browser auxiliary `404` remains a T02 corroboration question, not a T01 runtime failure.

## Files Created/Modified

- `.gsd/milestones/M002/slices/S02/tasks/T01-SUMMARY.md` — recorded the green runtime-matrix results, observability proof, and handoff notes.
- `.gsd/milestones/M002/slices/S02/S02-PLAN.md` — marked T01 complete.
- `.gsd/STATE.md` — advanced the next action to T02 as the local handoff state file.
