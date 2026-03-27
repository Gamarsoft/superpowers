---
estimated_steps: 9
estimated_files: 10
---

# S04: Compatibility and integrated validation

**Goal:** Prove the assembled comparison-first companion against the real runtime boundary so fragment screens keep their shared defaults, full-document screens stay compatibility-safe, and click-assisted plus terminal-only carry-forward behavior remains explicit without changing the current HTML/runtime contract.
**Demo:** The real companion entrypoint starts through `skills/brainstorming/scripts/start-server.sh`, serves authored fragment and full-document screens correctly, records and clears `state/events` at the right times, and still renders explicit `Chosen direction`, `Still open`, and `Degraded mode` copy after a fresh later screen and a full-document compatibility pass-through check.

## Description

This slice directly owns the two remaining active requirements: **R006** and **R011**. I’m grouping the work into three tasks because the main risk is not missing behavior; it is trusting the wrong proof surface. First, the stale lifecycle script has to be brought back into line with the current `server.cjs` plus `state/server-info` contract so operational verification stops producing false alarms. Second, S04 needs one automated real-entrypoint acceptance test that exercises the assembled flow through `start-server.sh` instead of relying only on lower-level server tests. Third, once those proof surfaces are trustworthy, the slice can run the full regression matrix and close milestone documentation against actual passing evidence. The verification strategy therefore uses the existing contract suites as the backbone, adds a refreshed lifecycle check, adds a real-entrypoint acceptance test, and finishes with an explicit browser-assisted live acceptance pass because browser auto-reload summaries alone are not authoritative.

## Must-Haves

- The current HTML/runtime contract remains intact across fragment wrapping, full-document passthrough, helper injection, newest-screen selection, and `screen_dir` / `state_dir/events` behavior.
- Existing valid screens continue to render, and full-document screens remain compatibility-supported without inheriting fragment-shell defaults automatically.
- Click-assisted and terminal-only flows both keep carry-forward meaning explicit in authored output, including `Chosen direction`, `Still open`, and `Degraded mode` where applicable.
- The milestone closes on trustworthy automated and live proof surfaces that use the real companion entrypoint rather than new workflow memory or server rewrites.

## Proof Level

- This slice proves: final-assembly
- Real runtime required: yes
- Human/UAT required: no

## Verification

- `node tests/brainstorm-server/visual-companion-contract.test.js`
- `node tests/brainstorm-server/fragment-comparison-defaults.test.js`
- `node tests/brainstorm-server/carry-forward-behavior.test.js`
- `cd tests/brainstorm-server && node server.test.js && node ws-protocol.test.js`
- `cd tests/brainstorm-server && bash windows-lifecycle.test.sh`
- Diagnostic failure-path check: if `bash windows-lifecycle.test.sh` fails, inspect the preserved session’s `state/server-info`, `state/server.log`, and served HTML snapshot path printed by the script before retrying.
- `node tests/brainstorm-server/live-companion-acceptance.test.js`
- Live runtime check: start the companion with `skills/brainstorming/scripts/start-server.sh`, open the served fragment screen in the browser, click a `data-choice` option, verify `state/events` is written, load a genuinely newer carry-forward screen, verify `state/events` is cleared while explicit `Chosen direction`, `Still open`, and `Degraded mode` copy remains visible as authored, then load a genuinely newer full-document screen and assert `data-comparison-kit="fragment-shell"` is absent.

## Observability / Diagnostics

- Runtime signals: `start-server.sh` startup JSON, `state/server-info`, `state/server.log` `screen-added` lines, `state/events` presence/clearing, and fragment-shell marker presence/absence at render time.
- Inspection surfaces: `skills/brainstorming/scripts/start-server.sh`, `skills/brainstorming/scripts/stop-server.sh`, `skills/brainstorming/scripts/server.cjs`, `tests/brainstorm-server/*.test.js`, `tests/brainstorm-server/windows-lifecycle.test.sh`, and explicit browser assertions against the live companion URL.
- Failure visibility: regressions should localize whether failure came from lifecycle startup/shutdown drift, fragment/full-document contamination, missing event write/clear transitions, or authored carry-forward text no longer being explicit.
- Redaction constraints: keep fixtures and assertions synthetic; do not record secrets, copied user reasoning, or private session content in logs, fixtures, or summary artifacts.

## Integration Closure

- Upstream surfaces consumed: `skills/brainstorming/scripts/start-server.sh`, `skills/brainstorming/scripts/stop-server.sh`, `skills/brainstorming/scripts/server.cjs`, `skills/brainstorming/scripts/helper.js`, `skills/brainstorming/scripts/frame-template.html`, `skills/brainstorming/examples/visual-companion/*.html`, `tests/brainstorm-server/server.test.js`, `tests/brainstorm-server/ws-protocol.test.js`, `tests/brainstorm-server/fragment-comparison-defaults.test.js`, `tests/brainstorm-server/carry-forward-behavior.test.js`, `tests/brainstorm-server/visual-companion-contract.test.js`
- New wiring introduced in this slice: a refreshed lifecycle compatibility check, a real-entrypoint automated acceptance test, and milestone-closure documentation tied directly to the passing validation matrix.
- What remains before the milestone is truly usable end-to-end: nothing

## Tasks

- [x] **T01: Refresh lifecycle compatibility diagnostics** `est:45m`
  - Why: The current `windows-lifecycle.test.sh` is out of sync with the live runtime surface. Until that script matches `server.cjs` and `state/server-info`, S04 cannot trust its operational proof for R006.
  - Files: `tests/brainstorm-server/windows-lifecycle.test.sh`, `skills/brainstorming/scripts/start-server.sh`, `skills/brainstorming/scripts/stop-server.sh`, `skills/brainstorming/scripts/server.cjs`
  - Do: Update the lifecycle script to use the current start/stop entrypoints and persisted state paths, then assert the supported lifecycle behaviors that matter for compatibility: startup metadata, helper-served HTML, newest-screen selection, and transient `state/events` clearing on a genuinely newer screen. Keep the script diagnostic-first so failures name the drifted contract surface instead of producing generic shell errors.
  - Verify: `cd tests/brainstorm-server && bash windows-lifecycle.test.sh`
  - Done when: the lifecycle script passes against the current runtime contract and becomes a trustworthy operational check for start/reload/newest-screen/event-clearing behavior.
- [x] **T02: Add a real-entrypoint companion acceptance test** `est:1h`
  - Why: The remaining milestone gap is final assembly proof through `start-server.sh`, not another low-level server unit. S04 needs one automated test that exercises authored fragment and full-document scenarios through the actual entrypoint.
  - Files: `tests/brainstorm-server/live-companion-acceptance.test.js`, `skills/brainstorming/scripts/start-server.sh`, `skills/brainstorming/scripts/stop-server.sh`, `skills/brainstorming/examples/visual-companion/annotated-recommendation.html`, `skills/brainstorming/examples/visual-companion/carry-forward-summary.html`
  - Do: Add an end-to-end Node test that starts the companion through `start-server.sh` in a temporary session, uses genuinely newer screens to exercise authored fragment comparison output, simulates a choice submission so `state/events` is written, verifies a fresher later screen clears `state/events` while still showing explicit carry-forward copy, and then verifies a newer full-document screen passes through without fragment-shell contamination. Reuse the authored comparison examples where possible instead of inventing a parallel fixture vocabulary.
  - Verify: `node tests/brainstorm-server/live-companion-acceptance.test.js`
  - Done when: the automated acceptance test passes and proves the real entrypoint preserves both compatibility boundaries and click-assisted/terminal-only continuity behavior.
- [x] **T03: Run the integrated validation matrix and close milestone evidence** `est:45m`
  - Why: S04 only counts as done when the full proof stack passes and the milestone docs reflect actual validated status for R006 and R011.
  - Files: `.gsd/milestones/M001/M001-ROADMAP.md`, `.gsd/REQUIREMENTS.md`, `.gsd/PROJECT.md`, `.gsd/STATE.md`, `.gsd/milestones/M001/slices/S04/S04-SUMMARY.md`
  - Do: Run the complete automated matrix for the contract, fragment-default, carry-forward, server/WebSocket, lifecycle, and real-entrypoint acceptance suites. Then perform the explicit browser-assisted live acceptance flow from the slice verification section, using server-side file/log checks whenever the browser harness is ambiguous. After the evidence is green, update the roadmap, requirements, project state, and S04 summary so the slice and milestone close on measured proof rather than intent.
  - Verify: `node tests/brainstorm-server/visual-companion-contract.test.js && node tests/brainstorm-server/fragment-comparison-defaults.test.js && node tests/brainstorm-server/carry-forward-behavior.test.js && cd tests/brainstorm-server && node server.test.js && node ws-protocol.test.js && bash windows-lifecycle.test.sh && cd ../.. && node tests/brainstorm-server/live-companion-acceptance.test.js`
  - Done when: all slice verification passes, R006 and R011 are marked validated from real evidence, and the milestone docs state that nothing remains before M001 is end-to-end usable.

## Files Likely Touched

- `tests/brainstorm-server/windows-lifecycle.test.sh`
- `tests/brainstorm-server/live-companion-acceptance.test.js`
- `skills/brainstorming/scripts/start-server.sh`
- `skills/brainstorming/scripts/stop-server.sh`
- `skills/brainstorming/scripts/server.cjs`
- `skills/brainstorming/examples/visual-companion/annotated-recommendation.html`
- `skills/brainstorming/examples/visual-companion/carry-forward-summary.html`
- `.gsd/milestones/M001/M001-ROADMAP.md`
- `.gsd/REQUIREMENTS.md`
- `.gsd/PROJECT.md`
- `.gsd/STATE.md`
- `.gsd/milestones/M001/slices/S04/S04-SUMMARY.md`
