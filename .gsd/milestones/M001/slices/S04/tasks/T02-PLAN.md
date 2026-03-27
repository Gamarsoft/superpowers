---
estimated_steps: 3
estimated_files: 5
---

# T02: Add a real-entrypoint companion acceptance test

**Slice:** S04 — Compatibility and integrated validation
**Milestone:** M001

## Description

Add one automated acceptance test that uses the real companion entrypoint instead of only the thin server boundary. This task should prove that authored fragment comparison screens, click-assisted continuity, terminal-only carry-forward, and full-document passthrough all still work when the runtime is started through `start-server.sh`.

## Steps

1. Create `tests/brainstorm-server/live-companion-acceptance.test.js` to start the companion in a temporary session via `skills/brainstorming/scripts/start-server.sh` and stop it through `skills/brainstorming/scripts/stop-server.sh`.
2. Reuse the authored comparison examples to assert visible fragment comparison content, simulate a choice submission so `state/events` is written, then add a genuinely newer carry-forward screen and verify `state/events` clears while explicit `Chosen direction`, `Still open`, and `Degraded mode` copy remains in the rendered output.
3. Add a genuinely newer full-document screen in the same acceptance flow and assert it passes through without the fragment-shell marker or shared-frame contamination.

## Must-Haves

- [ ] The real start/stop entrypoint is exercised in automation, not just manual testing.
- [ ] The acceptance test proves both compatibility boundaries and authored continuity behavior across fragment and full-document screens.

## Verification

- `node tests/brainstorm-server/live-companion-acceptance.test.js`
- `cd tests/brainstorm-server && bash windows-lifecycle.test.sh`

## Observability Impact

- Signals added/changed: the new acceptance test captures startup JSON, rendered HTML, `state/events` write/clear transitions, and fragment-shell marker presence or absence in one flow.
- How a future agent inspects this: run `node tests/brainstorm-server/live-companion-acceptance.test.js`, then inspect the temp session directory, `state/server-info`, `state/server.log`, and the rendered HTML snapshots emitted by the test on failure.
- Failure state exposed: real-entrypoint startup failure, missing authored carry-forward text, event persistence drift, or full-document contamination by the fragment shell.

## Inputs

- `skills/brainstorming/scripts/start-server.sh` — real companion entrypoint to exercise
- `skills/brainstorming/scripts/stop-server.sh` — supported teardown path for temporary sessions
- `skills/brainstorming/examples/visual-companion/annotated-recommendation.html` — authored fragment comparison example to reuse for acceptance coverage
- `skills/brainstorming/examples/visual-companion/carry-forward-summary.html` — authored carry-forward example with explicit continuity copy
- `tests/brainstorm-server/server.test.js` — existing thin-boundary assertions that this task complements rather than duplicates

## Expected Output

- `tests/brainstorm-server/live-companion-acceptance.test.js` — automated real-entrypoint acceptance coverage for fragment, carry-forward, and full-document compatibility scenarios
- `skills/brainstorming/examples/visual-companion/annotated-recommendation.html` — only if a tiny authored-example tweak is required to support truthful acceptance assertions
- `skills/brainstorming/examples/visual-companion/carry-forward-summary.html` — only if a tiny authored-example tweak is required to support truthful acceptance assertions
