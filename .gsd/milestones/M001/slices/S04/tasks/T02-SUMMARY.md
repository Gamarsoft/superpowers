---
id: T02
parent: S04
milestone: M001
provides:
  - Real-entrypoint acceptance coverage for authored fragment, carry-forward, and full-document compatibility behavior
key_files:
  - tests/brainstorm-server/live-companion-acceptance.test.js
  - .gsd/milestones/M001/slices/S04/S04-PLAN.md
  - .gsd/DECISIONS.md
  - .gsd/STATE.md
key_decisions:
  - Preserve the live acceptance session, logs, and rendered HTML snapshots on failure, while still verifying `stop-server.sh` teardown on the green path
patterns_established:
  - Real-entrypoint acceptance follows the authored fragment -> choice event write -> newer carry-forward clears `state/events` -> newer full-document passthrough sequence through `start-server.sh`
observability_surfaces:
  - start-server.sh startup JSON; state/server-info; state/server.log; state/events write/clear transitions; rendered HTML snapshots on failure
duration: 1h
verification_result: passed
completed_at: 2026-03-28 16:51:49 CET
# Set blocker_discovered: true only if execution revealed the remaining slice plan
# is fundamentally invalid (wrong API, missing capability, architectural mismatch).
# Do NOT set true for ordinary bugs, minor deviations, or fixable issues.
blocker_discovered: false
---

# T02: Add a real-entrypoint companion acceptance test

**Added a real-entrypoint acceptance test that starts through `start-server.sh`, proves authored continuity and boundary behavior in one flow, and preserves runtime artifacts on failure.**

## What Happened

I replaced the failing placeholder at `tests/brainstorm-server/live-companion-acceptance.test.js` with a real end-to-end Node acceptance test that exercises the supported runtime boundary instead of spawning `server.cjs` directly.

The new test starts the companion with `skills/brainstorming/scripts/start-server.sh`, captures and validates the startup JSON, checks `state/server-info` parity, reuses the authored `annotated-recommendation.html` fragment example, simulates a real choice submission over WebSocket so `state/events` is written, then adds a genuinely newer `carry-forward-summary.html` screen and verifies two things at once: the rendered output still shows explicit `Chosen direction`, `Still open`, and `Degraded mode` copy, and the runtime clears `state/events` for the newer screen.

In the same live session, the test then adds a genuinely newer full-document fixture and asserts it passes through without `data-comparison-kit="fragment-shell"`, the indicator bar, or the shared fragment content frame, while still receiving helper injection.

I kept the acceptance test diagnostic-first, matching the slice observability requirements. It writes startup/stop stdout+stderr artifacts, stores rendered HTML snapshots for each stage, and preserves the temp session on failure so a later agent can inspect `state/server-info`, `state/server.log`, and the failing HTML snapshots before manually stopping the session. On the green path it explicitly verifies `skills/brainstorming/scripts/stop-server.sh` teardown.

No authored example changes were needed.

## Verification

### Task verification
- Passed: `node tests/brainstorm-server/live-companion-acceptance.test.js`
- Passed: `cd tests/brainstorm-server && bash windows-lifecycle.test.sh`

### Slice verification run during T02
- Passed: `node tests/brainstorm-server/visual-companion-contract.test.js`
- Passed: `node tests/brainstorm-server/fragment-comparison-defaults.test.js`
- Passed: `node tests/brainstorm-server/carry-forward-behavior.test.js`
- Passed: `cd tests/brainstorm-server && node server.test.js && node ws-protocol.test.js`
- Passed: `cd tests/brainstorm-server && bash windows-lifecycle.test.sh`
- Passed: `node tests/brainstorm-server/live-companion-acceptance.test.js`

### Browser-assisted live check
Started the companion through `skills/brainstorming/scripts/start-server.sh`, opened the served fragment screen in the browser, clicked `[data-choice='task-grouped-settings']`, confirmed `state/events` contained that choice, added a genuinely newer carry-forward screen, used explicit browser assertions to confirm `Decision checkpoint: export flow`, `Chosen direction: drawer-based export flow`, `Still open: permission fallback copy`, and `Degraded mode`, then confirmed `state/events` was absent. After that I added a newer full-document screen and verified in the browser DOM that `#full-document-marker` was visible, `window.brainstorm` still existed, and `.header`, `.indicator-bar`, `#claude-content`, and `[data-comparison-kit="fragment-shell"]` were all absent.

## Diagnostics

For the automated proof surface, run:
- `node tests/brainstorm-server/live-companion-acceptance.test.js`

If it fails, the test preserves and prints:
- the temp workspace root
- the live session directory
- `state/server-info`
- `state/server.log`
- the rendered HTML snapshot paths for the fragment, carry-forward, and full-document stages

Those artifacts localize whether the failure is in real-entrypoint startup, authored fragment rendering, `state/events` persistence or clearing, or full-document contamination by fragment chrome.

## Quality Check

**Diff reviewed:** `a3cd50f..WORKTREE` — 3 files, 467 insertions, 3 deletions
**Checklists applied:** security, code-quality, solid

### Issues Found

#### Critical
- none

#### Important
- none

#### Minor
- none

**Verdict:** PASS

## Deviations

- None.

## Known Issues

- Browser automation surfaced a benign favicon 404 during the live check; it did not affect the runtime assertions or server-side state verification.

## Files Created/Modified

- `tests/brainstorm-server/live-companion-acceptance.test.js` — replaced the placeholder with a real-entrypoint acceptance flow that validates startup metadata, fragment rendering, event write/clear transitions, full-document passthrough, teardown, and failure artifacts.
- `.gsd/milestones/M001/slices/S04/S04-PLAN.md` — marked T02 complete.
- `.gsd/DECISIONS.md` — recorded the decision to preserve live-acceptance failure artifacts while still verifying `stop-server.sh` on the green path.
- `.gsd/STATE.md` — advanced the next action to T03 and recorded the latest validation/observability decisions.
