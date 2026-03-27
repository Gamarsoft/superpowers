---
estimated_steps: 9
estimated_files: 8
---

# S03: Selection clarity and carry-forward behavior

**Goal:** Make selected-state feedback clearer in click-assisted screens and keep later screens explicit about either the chosen direction or the still-open comparison, without turning the helper or runtime into a workflow engine.
**Demo:** In the real companion runtime, clicking a `data-choice` option strengthens selected clarity only through the existing helper contract, and a later screen can explicitly show `Chosen direction` or `Still open` even when no browser click happened and `state/events` is absent or cleared.

## Description

This slice directly owns **R004**, **R005**, and **R010**, and it supports **R006** and **R011**. I’m grouping the work into three tasks because the risks stack in a strict order. First, helper-selected behavior is the thinnest runtime seam and the easiest place to accidentally add hidden workflow logic, so S03 should lock the additive `data-choice` boundary before changing copy or examples. Second, carry-forward has to stay authored and visible rather than inferred from `state/events`, which means the slice needs explicit chosen-versus-still-open examples and tests that pass even for terminal-only flows. Third, because this slice touches interactive behavior and continuity at the live runtime boundary, it needs one real companion verification pass in addition to targeted regression tests. The verification strategy therefore combines two new focused test files, the existing server/WebSocket suites, and one live runtime check using fresh screen filenames so event-clearing behavior is exercised honestly.

## Must-Haves

- Click-assisted screens make the current selected choice clearer using the existing `data-choice` and `.selected` contract, with helper behavior remaining additive and presentation-level.
- The helper continues to treat selection as container-scoped and transient unless authored `.selected` markup says otherwise.
- Later screens explicitly show either `Chosen direction` or `Still open`, including terminal-only flows where no browser click happened.
- If the screen is produced in degraded mode, the carry-forward presentation stays explicit and honest instead of implying that richer design context was available.
- The current HTML/runtime contract stays intact: no new required metadata, no workflow memory layer, and no reliance on durable `state/events` carry-forward.

## Proof Level

- This slice proves: integration
- Real runtime required: yes
- Human/UAT required: no

## Verification

- `node tests/brainstorm-server/helper-selection-clarity.test.js`
- `node tests/brainstorm-server/carry-forward-behavior.test.js`
- `node tests/brainstorm-server/visual-companion-contract.test.js`
- `cd tests/brainstorm-server && node server.test.js && node ws-protocol.test.js`
- `node -e "const fs=require('fs');const helper=fs.readFileSync('skills/brainstorming/scripts/helper.js','utf8');for(const banned of ['Chosen direction','Still open','state/events']){if(helper.includes(banned)){throw new Error('Helper drifted into workflow semantics: '+banned);}}console.log(JSON.stringify({check:'helper-workflow-boundary',status:'pass'}));"`
- Live runtime check: start the real companion server, use a fresh screen filename to verify click-assisted selection clarity in the browser, then load a later screen with explicit `Chosen direction` or `Still open` copy and confirm the result is still correct with no browser click.

## Observability / Diagnostics

- Runtime signals: helper indicator text, authored `.selected` markup, and `state/events` file creation/clearing remain the slice’s inspectable state transitions.
- Inspection surfaces: `skills/brainstorming/scripts/helper.js`, `skills/brainstorming/scripts/frame-template.html`, `skills/brainstorming/examples/visual-companion/*.html`, `tests/brainstorm-server/helper-selection-clarity.test.js`, `tests/brainstorm-server/carry-forward-behavior.test.js`, and the real browser view served by `skills/brainstorming/scripts/server.cjs`.
- Failure visibility: regressions should name whether failure came from helper container scoping, indicator semantics, event-dependence, missing `Chosen direction` / `Still open` copy, or degraded-mode honesty.
- Redaction constraints: keep all fixtures and assertions synthetic; do not record user prompts, secrets, or copied session reasoning in example files or test output.

## Integration Closure

- Upstream surfaces consumed: `skills/brainstorming/scripts/helper.js`, `skills/brainstorming/scripts/frame-template.html`, `skills/brainstorming/scripts/server.cjs`, `skills/brainstorming/visual-companion.md`, `skills/brainstorming/examples/visual-companion/annotated-recommendation.html`, `skills/brainstorming/examples/visual-companion/carry-forward-summary.html`, `tests/brainstorm-server/server.test.js`, `tests/brainstorm-server/ws-protocol.test.js`, `tests/brainstorm-server/visual-companion-contract.test.js`
- New wiring introduced in this slice: a focused helper-selection regression, a focused carry-forward behavior regression, and any minimal helper or authored-example updates needed to keep selection clarity and carry-forward explicit without new metadata.
- What remains before the milestone is truly usable end-to-end: S04 must prove the assembled comparison-first kit against the real companion entrypoint, compatibility scenarios, and integrated acceptance checks.

## Tasks

- [x] **T01: Lock additive helper selection semantics** `est:45m`
  - Why: The biggest S03 risk is hidden workflow behavior creeping into `helper.js`. The slice needs a precise proof that selected-state clarity can improve without making the helper authoritative for carry-forward.
  - Files: `skills/brainstorming/scripts/helper.js`, `skills/brainstorming/scripts/frame-template.html`, `tests/brainstorm-server/helper-selection-clarity.test.js`
  - Do: Make only the minimal helper and frame changes needed to strengthen selected-state feedback for existing `data-choice` interactions, while keeping selection container-scoped, transient, and `.selected`-driven on reload. Add a lightweight Node regression harness that exercises single-select and multiselect behavior, asserts default indicator guidance, single selected label behavior, multiselect count behavior, and verifies the helper does not read workflow copy or `state/events`.
  - Verify: `node tests/brainstorm-server/helper-selection-clarity.test.js && node -e "const fs=require('fs');const helper=fs.readFileSync('skills/brainstorming/scripts/helper.js','utf8');for(const banned of ['Chosen direction','Still open','state/events']){if(helper.includes(banned)){throw new Error('Helper drifted into workflow semantics: '+banned);}}console.log(JSON.stringify({check:'helper-workflow-boundary',status:'pass'}));"`
  - Done when: helper-selected state is clearer in the UI, the regression proves container-local semantics for both single-select and multiselect surfaces, and the helper still stays presentation-level and `data-choice`-based.
- [x] **T02: Author explicit carry-forward states for chosen, still-open, and degraded flows** `est:1h`
  - Why: R004 and R010 are the core continuity requirements for this slice. Later screens must be understandable even when browser events are missing, cleared, or never happened.
  - Files: `skills/brainstorming/visual-companion.md`, `skills/brainstorming/examples/visual-companion/annotated-recommendation.html`, `skills/brainstorming/examples/visual-companion/carry-forward-summary.html`, `tests/brainstorm-server/carry-forward-behavior.test.js`
  - Do: Tighten the guide and example screens so later-screen copy explicitly distinguishes `Chosen direction` from `Still open`, and add explicit degraded-mode wording for plain archetype-based carry-forward output when richer design context was unavailable or declined. Keep these semantics in authored visible copy, not metadata, and add a dedicated regression that renders the carry-forward examples with and without `state/events` present so the output stays explicit either way.
  - Verify: `node tests/brainstorm-server/carry-forward-behavior.test.js && node tests/brainstorm-server/visual-companion-contract.test.js`
  - Done when: the guide and examples make chosen, still-open, and degraded carry-forward states explicit, and regression coverage proves those states do not depend on browser-click persistence.
- [x] **T03: Prove the real runtime path for click-assisted and terminal-only continuity** `est:45m`
  - Why: S03 changes behavior at the live helper/server boundary, so the slice needs real runtime proof in addition to focused unit-style regressions.
  - Files: `tests/brainstorm-server/server.test.js`, `tests/brainstorm-server/ws-protocol.test.js`, `skills/brainstorming/scripts/server.cjs`
  - Do: Extend adjacent runtime coverage only where needed so existing tests still prove choice-event persistence, no-write behavior for non-choice events, and event clearing on genuinely new screens. Then exercise the real companion flow with fresh screen filenames to confirm both browser-click and terminal-only paths render explicit carry-forward states without any new metadata or server/session rewrite.
  - Verify: `cd tests/brainstorm-server && node server.test.js && node ws-protocol.test.js`
  - Done when: the runtime suite still passes, a live companion check confirms click-assisted and no-click flows, and no change was needed beyond additive helper clarity or explicit authored carry-forward copy.

## Files Likely Touched

- `skills/brainstorming/scripts/helper.js`
- `skills/brainstorming/scripts/frame-template.html`
- `skills/brainstorming/visual-companion.md`
- `skills/brainstorming/examples/visual-companion/annotated-recommendation.html`
- `skills/brainstorming/examples/visual-companion/carry-forward-summary.html`
- `tests/brainstorm-server/helper-selection-clarity.test.js`
- `tests/brainstorm-server/carry-forward-behavior.test.js`
- `tests/brainstorm-server/server.test.js`
