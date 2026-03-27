---
estimated_steps: 4
estimated_files: 5
---

# T03: Run the integrated validation matrix and close milestone evidence

**Slice:** S04 — Compatibility and integrated validation
**Milestone:** M001

## Description

Turn the refreshed proof surfaces into milestone closure. This task runs the full validation matrix, performs the explicit browser-assisted live acceptance pass, and updates the milestone artifacts only after R006 and R011 are proven with real evidence.

## Steps

1. Run the complete automated validation matrix for the contract, fragment-default, carry-forward, server/WebSocket, lifecycle, and real-entrypoint acceptance suites.
2. Execute the live companion acceptance flow through `start-server.sh` and browser assertions, using `state/events`, `state/server-info`, and `state/server.log` as the authoritative tie-breakers when browser reload evidence is ambiguous.
3. Write `S04-SUMMARY.md` with the exact proof surfaces, results, and any deviations or limitations that remain.
4. Update the roadmap, requirements, project state, and `.gsd/STATE.md` so the slice and milestone close on measured validation rather than planned intent.

## Must-Haves

- [ ] R006 and R011 are advanced all the way from mapped to validated using the passing automated matrix plus live acceptance evidence.
- [ ] The milestone closure artifacts cite the real proof surfaces and do not claim completion until the full validation stack is green.

## Verification

- `node tests/brainstorm-server/visual-companion-contract.test.js && node tests/brainstorm-server/fragment-comparison-defaults.test.js && node tests/brainstorm-server/carry-forward-behavior.test.js && cd tests/brainstorm-server && node server.test.js && node ws-protocol.test.js && bash windows-lifecycle.test.sh && cd ../.. && node tests/brainstorm-server/live-companion-acceptance.test.js`
- Live runtime check: start the companion, click a fragment `data-choice`, verify `state/events`, add a fresher carry-forward screen, verify explicit continuity copy after `state/events` clears, then add a fresher full-document screen and assert no fragment-shell contamination.

## Inputs

- `.gsd/milestones/M001/slices/S04/S04-PLAN.md` — slice contract and required verification stack
- `tests/brainstorm-server/live-companion-acceptance.test.js` — automated real-entrypoint proof added in T02
- `tests/brainstorm-server/windows-lifecycle.test.sh` — refreshed lifecycle compatibility diagnostics from T01
- `.gsd/REQUIREMENTS.md` — active requirements R006 and R011 that must move to validated only after proof passes
- `.gsd/milestones/M001/M001-ROADMAP.md` — milestone status artifact that closes once S04 evidence is real

## Expected Output

- `.gsd/milestones/M001/slices/S04/S04-SUMMARY.md` — slice completion summary tied to actual verification evidence
- `.gsd/milestones/M001/M001-ROADMAP.md` — S04 marked complete and M001 closed if all proof passes
- `.gsd/REQUIREMENTS.md` — R006 and R011 updated from active to validated when proven
- `.gsd/PROJECT.md` — project status refreshed to reflect integrated validation completion
- `.gsd/STATE.md` — planning/execution state advanced after slice closure

## Observability Impact

- The task does not add new runtime behavior, but it turns the existing validation and runtime signals into closure evidence that later agents can inspect directly.
- Future inspection starts from the passing matrix commands plus the live acceptance surfaces: `state/server-info`, `state/server.log`, `state/events`, browser assertions, and the preserved failure artifacts already emitted by `tests/brainstorm-server/windows-lifecycle.test.sh` and `tests/brainstorm-server/live-companion-acceptance.test.js`.
- Failure state becomes more visible in milestone artifacts because `S04-SUMMARY.md`, `M001-ROADMAP.md`, `.gsd/REQUIREMENTS.md`, `.gsd/PROJECT.md`, and `.gsd/STATE.md` will cite the exact proof surfaces used to validate or localize regressions instead of relying on planned intent.
