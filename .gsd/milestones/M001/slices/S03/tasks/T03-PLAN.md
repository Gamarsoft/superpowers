---
estimated_steps: 4
estimated_files: 3
---

# T03: Prove the real runtime path for click-assisted and terminal-only continuity

**Slice:** S03 — Selection clarity and carry-forward behavior
**Milestone:** M001

## Description

Close the slice at the real runtime boundary. This task keeps the existing server/WebSocket contract intact, adds only the adjacent coverage needed for S03, and exercises the live companion flow with fresh screen filenames so browser-click and no-click paths are both proven honestly.

## Steps

1. Extend adjacent runtime assertions only where needed so `tests/brainstorm-server/server.test.js` and `tests/brainstorm-server/ws-protocol.test.js` still prove choice-event persistence, no-write behavior for non-choice events, and event clearing on genuinely new screens.
2. Run the focused S03 regressions plus the existing server/WebSocket suites to prove helper clarity and authored carry-forward work without changing the runtime contract.
3. Exercise the live companion flow with fresh screen filenames: first verify click-assisted selection clarity in the browser, then verify a later authored carry-forward screen still reads correctly when no browser click occurs.
4. If a small compatibility bug blocks the proof, fix only that narrow runtime issue and keep the helper/server behavior additive rather than workflow-driven.

## Must-Haves

- [ ] The existing browser-plus-terminal runtime contract still holds, including choice-event persistence rules and event clearing on new screens.
- [ ] Real runtime verification confirms both click-assisted and terminal-only carry-forward paths without any new metadata or session-memory layer.

## Verification

- `cd tests/brainstorm-server && node server.test.js && node ws-protocol.test.js`
- Live runtime check against the real companion server using fresh screen filenames for both the click-assisted and terminal-only scenarios

## Observability Impact

- Signals added/changed: none beyond stronger adjacent assertions; the task relies on existing `state/events`, WebSocket choice events, and the browser indicator/carry-forward UI as the observable surfaces.
- How a future agent inspects this: run the server and WebSocket suites, then inspect the live browser view and `state/events` behavior while switching between fresh screen files.
- Failure state exposed: event-clearing regressions, unexpected dependence on stale browser events, broken helper injection, or live-screen carry-forward ambiguity.

## Inputs

- `tests/brainstorm-server/server.test.js` — existing runtime contract coverage for helper injection, event persistence, and event clearing
- `tests/brainstorm-server/ws-protocol.test.js` — current WebSocket behavior coverage that must remain intact
- `skills/brainstorming/scripts/server.cjs` — real runtime boundary that should change only for a narrow compatibility fix if verification exposes one
- Outputs of T01 and T02 — focused helper and carry-forward regressions that should already be green before live runtime proof

## Expected Output

- `tests/brainstorm-server/server.test.js` — adjacent runtime coverage updated only if S03 needs a tighter assertion
- `tests/brainstorm-server/ws-protocol.test.js` — adjacent protocol coverage updated only if S03 needs a tighter assertion
- `skills/brainstorming/scripts/server.cjs` — unchanged unless a minimal compatibility fix is required to keep the existing contract working under S03 scenarios
