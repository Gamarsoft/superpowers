---
id: T01
parent: S04
milestone: M001
provides:
  - Refreshed lifecycle compatibility diagnostics aligned with the current start/stop/server-info/runtime contract
key_files:
  - tests/brainstorm-server/windows-lifecycle.test.sh
  - .gsd/milestones/M001/slices/S04/S04-PLAN.md
  - tests/brainstorm-server/live-companion-acceptance.test.js
key_decisions:
  - Preserve failed lifecycle sessions and served-HTML snapshots instead of tearing them down before inspection
patterns_established:
  - Lifecycle runtime checks assert startup JSON, state/server-info parity, helper-served HTML, newest-screen selection, and state/events clearing through the real start/stop entrypoints
observability_surfaces:
  - start-server.sh startup JSON; preserved failure session path; state/server-info; state/server.log; served HTML snapshots
duration: 45m
verification_result: passed
completed_at: 2026-03-28 16:41:39 CET
# Set blocker_discovered: true only if execution revealed the remaining slice plan
# is fundamentally invalid (wrong API, missing capability, architectural mismatch).
# Do NOT set true for ordinary bugs, minor deviations, or fixable issues.
blocker_discovered: false
---

# T01: Refresh lifecycle compatibility diagnostics

**Replaced the stale lifecycle script with a current-contract start/serve/select/clear/stop check that preserves failure artifacts and points directly at the drifted runtime surface.**

## What Happened

I replaced `tests/brainstorm-server/windows-lifecycle.test.sh` instead of trying to patch the old Windows-owner-PID checks. The new script now exercises the supported `skills/brainstorming/scripts/start-server.sh` / `stop-server.sh` flow, parses the returned startup JSON, verifies `state/server-info` parity, fetches served HTML through the live URL, sends a real WebSocket choice event, adds a genuinely newer screen, confirms `state/events` clears, and checks `state/server.log` for `screen-added` diagnostics.

While tightening the script, I hit one race: the older screen’s watcher event could still clear `state/events` after the choice write. I fixed that by waiting for the older screen’s `screen-added` log before sending the choice, then waiting for the newer screen’s log before asserting reload and clearing behavior.

I also made the script diagnostic-first. On failure it now preserves the temp session, prints the exact `state/server-info`, `state/server.log`, and served-HTML snapshot paths, and avoids calling `stop-server.sh` so the evidence is still inspectable. On success it still verifies the supported shutdown flow.

Per the unit pre-flight requirement, I added an explicit diagnostic failure-path verification note to `S04-PLAN.md`. Because this is the first task in the slice and `tests/brainstorm-server/live-companion-acceptance.test.js` did not exist yet, I also created an explicit failing stub for T02 so the planned verification surface exists and fails clearly instead of as a missing file.

## Verification

### Task verification
- Passed: `cd tests/brainstorm-server && bash windows-lifecycle.test.sh`
- Passed: `cd tests/brainstorm-server && node server.test.js`

### Slice verification run during T01
- Passed: `node tests/brainstorm-server/visual-companion-contract.test.js`
- Passed: `node tests/brainstorm-server/fragment-comparison-defaults.test.js`
- Passed: `node tests/brainstorm-server/carry-forward-behavior.test.js`
- Passed: `cd tests/brainstorm-server && node server.test.js && node ws-protocol.test.js`
- Passed: `cd tests/brainstorm-server && bash windows-lifecycle.test.sh`
- Expected fail for next task: `node tests/brainstorm-server/live-companion-acceptance.test.js` currently exits with `T02 pending...`

### Browser-assisted live check
Started the companion through `skills/brainstorming/scripts/start-server.sh`, opened the live URL in the browser, asserted the older fragment screen and helper-driven indicator text were visible, clicked the fragment `data-choice`, confirmed `state/events` contained that choice, added a genuinely newer screen, then used browser assertions to confirm `Browser newer screen`, `Chosen direction`, `Still open`, and `Degraded mode` became visible while `state/events` cleared.

## Diagnostics

For lifecycle drift, run:
- `cd tests/brainstorm-server && bash windows-lifecycle.test.sh`

If it fails, the script now prints:
- the preserved temp session directory
- `state/server-info`
- `state/server.log`
- the latest served-HTML snapshot path

Those artifacts localize whether the drift is in startup metadata, helper-served HTML, newest-screen selection, `state/events` clearing, or shutdown handling.

## Quality Check

**Diff reviewed:** `0622f0c..WORKTREE` — 4 implementation files reviewed (3 modified, 1 new)
**Checklists applied:** security, code-quality, solid

### Issues Found

#### Critical
- none

#### Important
- `tests/brainstorm-server/live-companion-acceptance.test.js:1` — intentional failing placeholder until T02 implements the real-entrypoint acceptance flow

#### Minor
- none

**Verdict:** PASS WITH NOTES

## Deviations

- Added the required diagnostic failure-path verification note to `.gsd/milestones/M001/slices/S04/S04-PLAN.md` before implementation.
- Created `tests/brainstorm-server/live-companion-acceptance.test.js` as an explicit failing stub so the slice’s planned T02 verification target exists during T01.

## Known Issues

- `tests/brainstorm-server/live-companion-acceptance.test.js` is still a placeholder and intentionally fails until T02 replaces it with the real acceptance test.

## Files Created/Modified

- `tests/brainstorm-server/windows-lifecycle.test.sh` — replaced the stale Windows-owner-PID script with a current lifecycle compatibility check that uses the real start/stop entrypoints, verifies startup metadata, helper-served HTML, newest-screen selection, event clearing, shutdown, and preserves failure artifacts.
- `tests/brainstorm-server/live-companion-acceptance.test.js` — added an explicit failing stub for the planned T02 acceptance test surface.
- `.gsd/milestones/M001/slices/S04/S04-PLAN.md` — added the missing diagnostic failure-path verification step and marked T01 complete.
- `.gsd/DECISIONS.md` — recorded the decision to preserve lifecycle failure artifacts for downstream debugging.
- `.gsd/STATE.md` — advanced the next action to T02 and noted the lifecycle diagnostics decision.
- `.gsd/milestones/M001/slices/S04/tasks/T01-SUMMARY.md` — recorded the task outcome, evidence, and remaining T02 gap.
