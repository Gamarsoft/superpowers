---
id: S03
parent: M001
milestone: M001
provides:
  - Clearer container-scoped helper selection feedback plus explicit authored carry-forward states that stay correct for click-assisted and terminal-only flows without new metadata or runtime memory.
requires:
  - slice: S01
    provides: Carry-forward rules, degraded-mode guidance, and the additive `data-choice` boundary for authored screens.
  - slice: S02
    provides: Fragment comparison-default surfaces that selected-state clarity and carry-forward presentation can strengthen.
affects:
  - S04
key_files:
  - skills/brainstorming/scripts/helper.js
  - skills/brainstorming/scripts/frame-template.html
  - skills/brainstorming/visual-companion.md
  - skills/brainstorming/examples/visual-companion/annotated-recommendation.html
  - skills/brainstorming/examples/visual-companion/carry-forward-summary.html
  - tests/brainstorm-server/helper-selection-clarity.test.js
  - tests/brainstorm-server/carry-forward-behavior.test.js
  - tests/brainstorm-server/server.test.js
  - tests/brainstorm-server/ws-protocol.test.js
key_decisions:
  - Keep helper-selected feedback container-scoped, DOM-derived, and presentation-only; never let `helper.js` read workflow copy or `state/events`.
  - Make later-screen continuity authoritative in visible authored copy (`Chosen direction`, `Still open`, and when needed `Degraded mode`) rather than browser-event persistence.
  - Use the live sequence `browser click -> state/events present -> fresh later screen -> state/events cleared -> authored carry-forward still explicit` as the runtime proof surface.
patterns_established:
  - Helper clarity can improve safely when it only reads current `.selected` DOM inside a single active choice container.
  - Carry-forward meaning belongs in authored screens, so terminal-only follow-ups remain clear even when browser history is absent or cleared.
  - Runtime continuity proof should stay anchored to existing observability surfaces instead of adding workflow memory.
observability_surfaces:
  - skills/brainstorming/scripts/helper.js
  - skills/brainstorming/scripts/frame-template.html
  - skills/brainstorming/visual-companion.md
  - tests/brainstorm-server/helper-selection-clarity.test.js
  - tests/brainstorm-server/carry-forward-behavior.test.js
  - tests/brainstorm-server/server.test.js
  - tests/brainstorm-server/ws-protocol.test.js
  - /tmp/brainstorm-live-s03-final/state/events
  - live companion browser indicator text
drill_down_paths:
  - .gsd/milestones/M001/slices/S03/tasks/T01-SUMMARY.md
  - .gsd/milestones/M001/slices/S03/tasks/T02-SUMMARY.md
  - .gsd/milestones/M001/slices/S03/tasks/T03-SUMMARY.md
duration: 3h
verification_result: passed
completed_at: 2026-03-28T15:16:59Z
---

# S03: Selection clarity and carry-forward behavior

**Shipped clearer helper-selected feedback and explicit authored carry-forward states that stay honest across click-assisted and terminal-only flows without changing the thin runtime contract.**

## What Happened

S03 tightened the comparison-first companion at the thinnest possible seams instead of expanding runtime behavior. First, T01 kept all selection clarity inside the existing helper/frame contract. `skills/brainstorming/scripts/helper.js` now derives indicator state from the active `.options` or `.cards` container, escapes rendered labels, distinguishes default, single-select, and multiselect feedback, and only hydrates from authored `.selected` DOM when exactly one container is active. `skills/brainstorming/scripts/frame-template.html` exposes that indicator as a live status surface with clearer default guidance.

Second, T02 made authored screens the source of continuity. `skills/brainstorming/visual-companion.md` now requires later screens to say `Chosen direction` or `Still open` explicitly, and to surface `Degraded mode` when richer design context was unavailable. The carry-forward examples in `skills/brainstorming/examples/visual-companion/annotated-recommendation.html` and `skills/brainstorming/examples/visual-companion/carry-forward-summary.html` now model click-assisted and terminal-only follow-ups directly, so meaning remains visible even if `state/events` is missing, stale, or cleared.

Third, T03 proved the live runtime path without changing `skills/brainstorming/scripts/server.cjs`. The existing server and WebSocket tests already covered choice-event persistence, non-choice no-write behavior, and event clearing on genuinely new screens, so the final proof came from the real companion flow: a click created `/tmp/brainstorm-live-s03-final/state/events`, a fresh later screen cleared it, and the browser still showed explicit chosen/still-open/degraded carry-forward copy because that meaning lived in the authored HTML, not in helper or server memory.

## Verification

All slice-level verification passed:

- `node tests/brainstorm-server/helper-selection-clarity.test.js`
- `node tests/brainstorm-server/carry-forward-behavior.test.js`
- `node tests/brainstorm-server/visual-companion-contract.test.js`
- `cd tests/brainstorm-server && node server.test.js && node ws-protocol.test.js`
- `node -e "const fs=require('fs');const helper=fs.readFileSync('skills/brainstorming/scripts/helper.js','utf8');for(const banned of ['Chosen direction','Still open','state/events']){if(helper.includes(banned)){throw new Error('Helper drifted into workflow semantics: '+banned);}}console.log(JSON.stringify({check:'helper-workflow-boundary',status:'pass'}));"`

Observability and live-runtime proof also passed:

- Started the real companion at `http://localhost:3340` against `/tmp/brainstorm-live-s03-final`.
- Loaded fresh screen `t03-click-assisted-annotated.html`, clicked `[data-choice='technical-stack-settings']`, and verified browser text `Selected: Still open alternative: technical-stack sections — return to the terminal to continue` plus `.selected` state.
- Confirmed `/tmp/brainstorm-live-s03-final/state/events` existed immediately after the click and contained the clicked choice.
- Wrote fresh later screen `t03-terminal-only-carry-forward.html`, waited for reload, and verified visible `Decision checkpoint: export flow`, `Degraded mode`, `Chosen direction: drawer-based export flow`, and `Still open: permission fallback copy` without another click.
- Confirmed `/tmp/brainstorm-live-s03-final/state/events` was cleared after the new screen appeared.

## Requirements Advanced

- R006 — Advanced by preserving the current helper/server boundary, keeping `data-choice` as the only required interaction metadata, and reusing the existing `state/events` contract as a thin transient signal rather than a new workflow layer.
- R011 — Advanced by proving terminal-only carry-forward screens remain explicit after event clearing and by keeping the adjacent runtime compatibility suites green.

## Requirements Validated

- R004 — Validated by authored `Chosen direction` / `Still open` copy in the guide and examples, regression coverage in `tests/brainstorm-server/carry-forward-behavior.test.js`, and live runtime proof after `state/events` clearing.
- R005 — Validated by the helper workflow-boundary guard, container-scoped helper regression coverage, and live proof that the browser remained an additive decision aid while the terminal/authored screen stayed the continuity authority.
- R010 — Validated by explicit degraded-mode guidance in `skills/brainstorming/visual-companion.md`, the degraded carry-forward example, regression checks, and live browser assertions for visible `Degraded mode` output.

## New Requirements Surfaced

- none

## Requirements Invalidated or Re-scoped

- none

## Deviations

None.

## Known Limitations

- S04 still needs to prove the assembled kit against broader compatibility scenarios, especially existing authored screens and final milestone acceptance flows.
- Browser diagnostics still show the pre-existing favicon 404 noise during live checks; it does not affect selection clarity or carry-forward behavior.

## Follow-ups

- Reuse the S03 live proof sequence in S04, but extend it across full-document compatibility screens and milestone-level end-to-end acceptance scenarios.

## Files Created/Modified

- `skills/brainstorming/scripts/helper.js` — clarified indicator rendering while keeping selection semantics container-scoped, DOM-derived, and presentation-only.
- `skills/brainstorming/scripts/frame-template.html` — exposed the indicator as a clearer live status surface.
- `skills/brainstorming/visual-companion.md` — made chosen/still-open/degraded carry-forward wording an explicit authoring rule.
- `skills/brainstorming/examples/visual-companion/annotated-recommendation.html` — modeled click-assisted chosen-direction carry-forward explicitly in visible copy.
- `skills/brainstorming/examples/visual-companion/carry-forward-summary.html` — modeled terminal-only degraded carry-forward with explicit chosen and still-open states.
- `tests/brainstorm-server/helper-selection-clarity.test.js` — locked helper selection clarity and workflow-boundary behavior.
- `tests/brainstorm-server/carry-forward-behavior.test.js` — proved carry-forward output is explicit with or without `state/events`.
- `.gsd/REQUIREMENTS.md` — moved R004, R005, and R010 to validated and refreshed coverage counts.
- `.gsd/DECISIONS.md` — recorded the live-runtime proof surface used by S03.

## Forward Intelligence

### What the next slice should know
- The most trustworthy S03 evidence is not a single unit test; it is the combined sequence of helper indicator text, `state/events` creation on click, `state/events` clearing on a fresh screen, and unchanged authored carry-forward meaning after reload.

### What's fragile
- Fresh-screen validation still depends on truly newer filenames or mtimes — if S04 reuses filenames carelessly, event-clearing proof can look flaky even when the runtime is correct.

### Authoritative diagnostics
- `tests/brainstorm-server/server.test.js` and the real `/tmp/.../state/events` file are the fastest truth sources for runtime continuity questions because they expose both persistence and clearing behavior directly.

### What assumptions changed
- The slice plan left room for adjacent runtime-test updates, but the existing server/WebSocket suites already covered the needed contract; the real work was strengthening authored carry-forward proof and helper clarity without changing server logic.
