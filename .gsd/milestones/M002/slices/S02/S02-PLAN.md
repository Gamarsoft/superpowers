# S02: Live runtime corroboration and milestone closure

**Goal:** Prove through the real companion entrypoint that the M002 authored refresh preserved the current runtime, `data-choice` interaction boundary, and four-archetype contract, then close the milestone on measured evidence.
**Demo:** `start-server.sh` still serves the refreshed annotated recommendation and the unchanged carry-forward example correctly, the existing acceptance/lifecycle/server/WebSocket stack stays green, and M002 closes with R019 validated from live proof rather than doc-only confidence.

## Must-Haves

- The refreshed M002 examples render through the real `start-server.sh` / `stop-server.sh` path without changing the current runtime contract, `data-choice` behavior, or fragment/full-document boundary.
- `live-companion-acceptance.test.js`, `windows-lifecycle.test.sh`, `server.test.js`, and `ws-protocol.test.js` all pass against the refreshed authored files.
- A quick browser corroboration re-checks the live runtime behavior and captures the exact request path if the previously seen auxiliary `404` warning recurs.
- Milestone artifacts move only after the proof stack is green, with R019 validated and M002 marked complete.

## Proof Level

- This slice proves: final-assembly
- Real runtime required: yes
- Human/UAT required: yes

## Verification

- `node tests/brainstorm-server/live-companion-acceptance.test.js`
- `bash tests/brainstorm-server/windows-lifecycle.test.sh`
- `node tests/brainstorm-server/server.test.js`
- `node tests/brainstorm-server/ws-protocol.test.js`
- Live runtime check: start the companion through `skills/brainstorming/scripts/start-server.sh`, load the refreshed annotated recommendation and unchanged carry-forward example in the browser, verify the outcome against `state/server-info`, `state/server.log`, and `state/events`, and capture the exact request path before changing code if the auxiliary `404` warning recurs.

## Observability / Diagnostics

- Runtime signals: `state/server-info`, `state/server.log` `screen-added` / `screen-updated` lines, `state/events` write-and-clear transitions, and the preserved session/render snapshots emitted by the live acceptance and lifecycle suites on failure.
- Inspection surfaces: `skills/brainstorming/scripts/start-server.sh`, `skills/brainstorming/scripts/stop-server.sh`, `tests/brainstorm-server/live-companion-acceptance.test.js`, `tests/brainstorm-server/windows-lifecycle.test.sh`, `tests/brainstorm-server/server.test.js`, `tests/brainstorm-server/ws-protocol.test.js`, and browser console/network logs during corroboration.
- Failure visibility: the green matrix localizes runtime drift versus browser-only noise; preserved temp-session artifacts and an exact failing request path should make any recurring `404` attributable before runtime code changes.
- Redaction constraints: keep session artifacts synthetic and local; do not record secrets or non-fixture user content in logs, summaries, or diagnostics.

## Integration Closure

- Upstream surfaces consumed: `skills/brainstorming/scripts/start-server.sh`, `skills/brainstorming/scripts/stop-server.sh`, `skills/brainstorming/scripts/server.cjs`, `skills/brainstorming/scripts/helper.js`, `skills/brainstorming/examples/visual-companion/annotated-recommendation.html`, `skills/brainstorming/examples/visual-companion/carry-forward-summary.html`, `tests/brainstorm-server/live-companion-acceptance.test.js`, `tests/brainstorm-server/windows-lifecycle.test.sh`, `tests/brainstorm-server/server.test.js`, `tests/brainstorm-server/ws-protocol.test.js`
- New wiring introduced in this slice: none unless a failing verification proves a targeted compatibility fix is required.
- What remains before the milestone is truly usable end-to-end: nothing

## Tasks

- [x] **T01: Run the real-entrypoint runtime matrix and localize any drift** `est:45m`
  - Why: R019 only closes if the refreshed authored files keep the existing runtime proof surfaces green.
  - Files: `tests/brainstorm-server/live-companion-acceptance.test.js`, `tests/brainstorm-server/windows-lifecycle.test.sh`, `tests/brainstorm-server/server.test.js`, `tests/brainstorm-server/ws-protocol.test.js`, `skills/brainstorming/scripts/start-server.sh`, `skills/brainstorming/scripts/server.cjs`
  - Do: Run the four authoritative runtime checks in the order defined by the slice research; if one fails, inspect the preserved session artifacts and localize whether the contradiction lives in the entrypoint, thin runtime, helper injection, or authored example boundary before editing anything; only change runtime or authored files if the failure proves a real compatibility contradiction, then rerun until the matrix is green.
  - Verify: `node tests/brainstorm-server/live-companion-acceptance.test.js && bash tests/brainstorm-server/windows-lifecycle.test.sh && node tests/brainstorm-server/server.test.js && node tests/brainstorm-server/ws-protocol.test.js`
  - Done when: all four runtime checks pass against the refreshed M002 examples, or any needed fix is localized and rerun to green without expanding the runtime contract.

- [x] **T02: Corroborate live browser behavior against runtime artifacts** `est:30m`
  - Why: The automated matrix is authoritative, but S02 still needs a quick human-visible pass through the real entrypoint and a disciplined answer to the earlier stray `404` warning.
  - Files: `skills/brainstorming/scripts/start-server.sh`, `skills/brainstorming/scripts/stop-server.sh`, `skills/brainstorming/examples/visual-companion/annotated-recommendation.html`, `skills/brainstorming/examples/visual-companion/carry-forward-summary.html`
  - Do: Start a temporary session through the real entrypoint, load the refreshed annotated recommendation and unchanged carry-forward example in the browser, and use browser assertions plus `state/server-info`, `state/server.log`, `state/events`, and console/network logs as tie-breakers; if the auxiliary `404` warning recurs, capture the exact request path before deciding whether it is browser noise or true runtime drift; tear down through `stop-server.sh`.
  - Verify: Live runtime check from the slice verification section, including browser assertions for render success and a recorded log or request-path result for any recurring `404`.
  - Done when: browser corroboration agrees with the green runtime matrix, or it produces a localized contradiction with enough evidence to justify a targeted fix.

- [x] **T03: Close M002 from verified runtime evidence** `est:40m`
  - Why: Milestone closure should happen only after R019 is proven by the real-entrypoint evidence stack, not because the authored files already looked good in S01.
  - Files: `.gsd/REQUIREMENTS.md`, `.gsd/milestones/M002/M002-ROADMAP.md`, `.gsd/PROJECT.md`, `.gsd/STATE.md`, `.gsd/milestones/M002/slices/S02/S02-SUMMARY.md`, `.gsd/milestones/M002/slices/S02/S02-UAT.md`, `.gsd/milestones/M002/M002-SUMMARY.md`
  - Do: Write the slice summary and UAT evidence, create the milestone summary, and update the roadmap, requirements, project state, and `.gsd/STATE.md` only after T01 and T02 are green; mark R019 validated, record whether the stray `404` was absent or localized as non-blocking noise, and keep the closure language tied to exact proof surfaces.
  - Verify: Read back the updated milestone artifacts and confirm they cite the passing S02 verification stack before marking R019 validated and M002 complete.
  - Done when: S02 and M002 are closed on cited runtime evidence, R019 moves from active to validated, and the state files point to the next real unit of work instead of this slice.

## Files Likely Touched

- `tests/brainstorm-server/live-companion-acceptance.test.js`
- `tests/brainstorm-server/windows-lifecycle.test.sh`
- `tests/brainstorm-server/server.test.js`
- `tests/brainstorm-server/ws-protocol.test.js`
- `skills/brainstorming/scripts/start-server.sh`
- `skills/brainstorming/scripts/stop-server.sh`
- `skills/brainstorming/scripts/server.cjs`
- `.gsd/REQUIREMENTS.md`
- `.gsd/milestones/M002/M002-ROADMAP.md`
- `.gsd/PROJECT.md`
- `.gsd/STATE.md`
- `.gsd/milestones/M002/slices/S02/S02-SUMMARY.md`
- `.gsd/milestones/M002/slices/S02/S02-UAT.md`
- `.gsd/milestones/M002/M002-SUMMARY.md`
