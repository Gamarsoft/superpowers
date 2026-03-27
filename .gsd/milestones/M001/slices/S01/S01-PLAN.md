---
estimated_steps: 9
estimated_files: 8
---

# S01: Authoring contract and archetype kit

**Goal:** Establish the comparison-first authoring contract for the visual companion so future screens are built from exactly four archetypes, routed through `/frontend-design` or `$frontend-design`, and authored against a bounded first-use design-context workflow without changing the current HTML/runtime boundary.
**Demo:** A future agent can open the brainstorming guidance, pick one of four named archetypes, follow the documented `/frontend-design` / `$frontend-design` workflow, reuse repo design context when available, fall back to explicit degraded mode when it is not, and copy from concrete fragment examples without inventing new metadata or assuming full-document defaults.

## Description

This slice directly owns **R001, R007, R008, R009, and R012**. I’m grouping the work into three increments because the main risk is contract drift, not missing runtime machinery. First, lock the language in the authoring docs so the archetype names, workflow order, degraded mode, and compatibility boundary are unambiguous. Second, add concrete fragment examples because research showed the current guidance is too generic to produce consistent comparison-first screens. Third, add a regression test that reads the docs and example artifacts so later slices cannot quietly erode the contract while S02 and S03 build on it.

## Must-Haves

- The guidance defines exactly four v1 archetypes and ties each archetype to a concrete authored example.
- Companion screen creation explicitly routes through `/frontend-design` or `$frontend-design` as the screen-structuring step.
- The first-use workflow is documented in bounded order: instruction context, repo design-context source if present, one-time minimal session capture, else explicit degraded mode.
- The fragment-first/full-document compatibility rule stays explicit, and no new required metadata is introduced beyond `data-choice`.

## Proof Level

- This slice proves: contract
- Real runtime required: no
- Human/UAT required: no

## Observability / Diagnostics

- **Runtime signals preserved:** `state/server-info` (startup), `state/events` (`data-choice` clicks only), and `state/server-stopped` (structured shutdown reason) remain the inspectable runtime surfaces that the authored contract must not contradict.
- **Inspection surfaces for future agents:** `skills/brainstorming/visual-companion.md` and `skills/brainstorming/SKILL.md` define the authoring workflow; `skills/brainstorming/scripts/server.cjs` + `tests/brainstorm-server/server.test.js` remain the source of truth for fragment/full-document and failure-state behavior.
- **Failure visibility expectation:** if compatibility language drifts, `visual-companion-contract.test.js` should fail with explicit missing-phrase assertions; if runtime diagnostics drift, `server.test.js` should fail on missing `server-stopped` reasoned output or changed event persistence behavior.
- **Redaction constraints:** documentation and tests must never introduce secrets or PII-bearing logging examples; examples should stay synthetic and metadata-bounded to `data-choice`.

## Verification

- `node tests/brainstorm-server/visual-companion-contract.test.js`
- `cd tests/brainstorm-server && node server.test.js` (explicit failure-path/diagnostic verification for `state/server-stopped`, `watch-fallback`, and `owner-pid-invalid` behavior)
- `cd tests/brainstorm-server && node ws-protocol.test.js`
- `rg -n "server-stopped|watch-fallback|owner-pid-invalid|state/events" skills/brainstorming/scripts/server.cjs tests/brainstorm-server/server.test.js`

## Integration Closure

- Upstream surfaces consumed: `skills/brainstorming/visual-companion.md`, `skills/brainstorming/SKILL.md`, `skills/brainstorming/scripts/server.cjs`, `skills/brainstorming/scripts/helper.js`, `skills/brainstorming/scripts/frame-template.html`, `tests/brainstorm-server/server.test.js`
- New wiring introduced in this slice: documentation links from the brainstorming skill entrypoint to the comparison-first guide, authored fragment examples referenced by the guide, and a contract regression test that locks the authoring rules in place
- What remains before the milestone is truly usable end-to-end: S02 must add fragment comparison defaults, S03 must make chosen vs still-open carry-forward explicit in live flows, and S04 must validate the assembled behavior against the real companion entrypoint

## Tasks

- [x] **T01: Codify the comparison-first authoring contract** `est:45m`
  - Why: R001, R007, R008, and R009 all depend on one authoritative description of the archetypes, the `/frontend-design` rule, the bounded first-use workflow, and the compatibility boundary before examples or downstream runtime work can stay consistent.
  - Files: `skills/brainstorming/visual-companion.md`, `skills/brainstorming/SKILL.md`
  - Do: Rewrite the companion guidance around exactly four named archetypes; state that screen creation explicitly invokes `/frontend-design` or `$frontend-design` as a screen-structuring step; document the first-use order as instruction context → repo design-context source if present (for example `.impeccable.md`) → one-time minimal session capture → explicit degraded mode; and make the fragment-first/full-document compatibility rule plus `data-choice`-only metadata boundary prominent enough for downstream slices to reuse.
  - Verify: `rg -n "side-by-side comparison|ranked alternatives|annotated recommendation|carry-forward summary|/frontend-design|\$frontend-design|degraded mode|full-document|data-choice" skills/brainstorming/visual-companion.md skills/brainstorming/SKILL.md`
  - Done when: the guide and skill entrypoint use the same contract language for the four archetypes, the workflow order, degraded mode, and the compatibility boundary.
- [x] **T02: Add the four authored fragment examples** `est:1h`
  - Why: R001 and R012 require concrete examples strong enough that future authors can copy the archetypes instead of improvising generic mockups.
  - Files: `skills/brainstorming/visual-companion.md`, `skills/brainstorming/examples/visual-companion/side-by-side-comparison.html`, `skills/brainstorming/examples/visual-companion/ranked-alternatives.html`, `skills/brainstorming/examples/visual-companion/annotated-recommendation.html`, `skills/brainstorming/examples/visual-companion/carry-forward-summary.html`
  - Do: Add one fragment example per archetype using the existing shared-frame classes and only current metadata boundaries; make the ranked example show a visible current winner without hiding alternatives; make the carry-forward example show both chosen-direction and still-open phrasing; and cross-link each example from `visual-companion.md` with short authoring notes on when to copy it.
  - Verify: `rg -n "Recommended|Current winner|Still open|Chosen direction|data-choice" skills/brainstorming/examples/visual-companion/*.html`
  - Done when: four example fragments exist, each clearly represents one named archetype, and the guide points authors to them as the default comparison-first starting points.
- [x] **T03: Lock the contract with regression checks** `est:45m`
  - Why: This slice is mostly contract and examples, so it needs an explicit regression surface that proves the docs and artifacts still match the runtime boundary future slices depend on.
  - Files: `tests/brainstorm-server/visual-companion-contract.test.js`
  - Do: Add a Node-based contract test that reads the guide and example artifacts, asserts the exact four archetype labels, the explicit `/frontend-design` or `$frontend-design` rule, the ordered first-use workflow, the degraded-mode language, the full-document compatibility rule, and the presence of the four example fragments, then run the existing runtime regression tests to confirm the slice stayed additive.
  - Verify: `node tests/brainstorm-server/visual-companion-contract.test.js && cd tests/brainstorm-server && node server.test.js && node ws-protocol.test.js`
  - Done when: the new contract test passes and the existing server/WebSocket regressions still pass without requiring runtime changes.

## Files Likely Touched

- `skills/brainstorming/visual-companion.md`
- `skills/brainstorming/SKILL.md`
- `skills/brainstorming/examples/visual-companion/side-by-side-comparison.html`
- `skills/brainstorming/examples/visual-companion/ranked-alternatives.html`
- `skills/brainstorming/examples/visual-companion/annotated-recommendation.html`
- `skills/brainstorming/examples/visual-companion/carry-forward-summary.html`
- `tests/brainstorm-server/visual-companion-contract.test.js`
