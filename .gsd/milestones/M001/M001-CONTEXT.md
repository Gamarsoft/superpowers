# M001: Comparison-First Visual Companion Upgrade

**Gathered:** 2026-03-27
**Status:** Ready for planning

## Project Description

Upgrade the brainstorming visual companion so it becomes a comparison-first design aid that helps users see differences, understand recommendations, and carry decisions forward without ambiguity. The browser should become much better at helping the human compare alternatives and understand the currently winning direction, while the terminal continues to carry the reasoning and conversation.

## Why This Milestone

The current companion runtime is already functional, but the product value is still under-realized because strong comparison screens and lightweight decision carry-forward are not yet systematized. This milestone focuses on the highest-value gap: clearer comparison support above the existing runtime, without turning the helper or server into a workflow engine.

## User-Visible Outcome

### When this milestone is complete, the user can:

- open the visual companion during brainstorming and immediately tell what options are being compared, which direction is currently recommended, and what the main trade-off is
- move from one comparison screen to the next without ambiguity about which option is being carried forward or whether the comparison is still open

### Entry point / environment

- Entry point: the existing brainstorming skill plus the local visual companion URL served by `scripts/start-server.sh`
- Environment: local dev, browser, and terminal in the existing brainstorming workflow
- Live dependencies involved: browser companion runtime, `state_dir/events`, and `/frontend-design` or `$frontend-design` during runtime screen creation

## Completion Class

- Contract complete means: the docs, frame defaults, helper behavior, and authored examples express the four archetypes, the `frontend-design` invocation rule, the design-context workflow, and the fragment/full-document compatibility rule clearly enough to verify by file review and tests
- Integration complete means: the assembled flow works across authored fragment screens, full-document compatibility screens, browser click capture, terminal-only carry-forward, and the comparison-first authoring/runtime rules
- Operational complete means: the existing non-blocking browser-plus-terminal session behavior still works under normal start, reload, and screen-advance conditions without a server lifecycle rewrite

## Final Integrated Acceptance

To call this milestone complete, we must prove:

- given two or three alternatives, the companion can show a comparison-first screen where the recommendation, visible alternatives, and main trade-off are legible at a glance
- given a chosen option or an unresolved choice, the next screen can explicitly carry that state forward whether the decision came from a browser click or the terminal alone
- given an existing valid fragment screen or full HTML document, the runtime still renders it correctly and does not assume fragment-only comparison defaults for full documents

## Risks and Unknowns

- The design could drift from comparison-first into generic visual-polish work — that would improve appearance more than decision support
- The helper or frame could drift into hidden workflow behavior — that would weaken predictability and violate the current runtime contract
- The first `frontend-design` invocation could add too much friction if the one-time session design-context workflow is not kept minimal and clearly bounded
- Fragment-first defaults could be mistaken for universal behavior unless the full-document compatibility rule is explicit everywhere it matters

## Existing Codebase / Prior Art

- `skills/brainstorming/visual-companion.md` — current operating guide for when and how to use the companion
- `skills/brainstorming/scripts/frame-template.html` — shared frame and fragment-only shell that should receive the comparison-kit defaults
- `skills/brainstorming/scripts/helper.js` — additive click capture and selected-state behavior, already keyed off `data-choice`
- `skills/brainstorming/scripts/server.cjs` — runtime transport, serving, helper injection, reload, and event persistence
- `tests/brainstorm-server/server.test.js` — compatibility tests that already protect fragment wrapping, full-document passthrough, helper injection, and event persistence
- `tests/brainstorm-server/ws-protocol.test.js` — lower-level protocol tests for the current zero-dependency runtime

> See `.gsd/DECISIONS.md` for all architectural and pattern decisions — it is an append-only register; read it during planning, append to it during execution.

## Relevant Requirements

- R001 — define the four comparison-first archetypes as the product surface for M001
- R002 — make recommendation and alternatives legible by default
- R003 — make ranked alternatives visibly honest about the current winner and lower-ranked options
- R004 — make carry-forward explicit on later screens
- R005 — preserve the terminal as the primary reasoning channel in the non-blocking browser-plus-terminal model
- R006 — preserve the current HTML/runtime contract, including fragment/full-document compatibility
- R007 — require runtime use of `/frontend-design` or `$frontend-design` when creating companion screens
- R008 — define the bounded one-time session design-context workflow before first `frontend-design` use
- R009 — reuse an existing repo design-context source if one exists
- R010 — make degraded mode explicit when design context is unavailable or declined
- R011 — preserve existing valid screens and terminal-only flows
- R012 — strengthen guidance and examples enough that authors can use the kit consistently

## Scope

### In Scope

- exactly four v1 archetypes: side-by-side comparison, ranked alternatives, annotated recommendation / current winner, and carry-forward summary
- explicit runtime use of `/frontend-design` or `$frontend-design` as the screen-structuring step when creating companion screens
- the one-time session design-context workflow, in this order: existing instruction context, repo design-context source if present, then minimal one-time session capture
- explicit degraded mode when that design context is unavailable or declined
- fragment-first comparison-kit defaults in the shared frame
- additive selected-state clarity in `helper.js`
- compatibility and scenario validation for click-assisted and terminal-only flows

### Out of Scope / Non-Goals

- deep server architecture rewrite
- mandatory new authoring DSL or schema
- replacing the terminal as the primary reasoning channel
- automatic comparison-kit defaults for full-document screens in v1
- broader diagram-oriented companion patterns beyond the comparison-first priority
- session-wide decision ledgers, branching, or gated workflow orchestration

## Technical Constraints

- Preserve the current non-blocking browser-plus-terminal model.
- Preserve the current HTML/runtime contract, including fragment and full-document support.
- Keep server/runtime changes limited and additive in the first milestone.
- Do not add new required metadata beyond existing `data-choice` in M001.
- Treat `frontend-design` as a screen-structuring step for brainstorming, not a near-final mockup step.
- Respect the one-time session design-context workflow before the first `frontend-design` use.
- Keep full-document support compatibility-only in v1; fragment screens get the comparison-kit defaults.

## Integration Points

- `skills/brainstorming/visual-companion.md` — owns the authoring contract, archetype guidance, runtime `frontend-design` rule, and the explicit full-document compatibility rule
- `/frontend-design` or `$frontend-design` — own the runtime screen-structuring pass during companion screen creation
- `skills/brainstorming/scripts/frame-template.html` — owns fragment-only comparison defaults
- `skills/brainstorming/scripts/helper.js` — owns additive selected-state clarity for `data-choice` interactions
- `skills/brainstorming/scripts/server.cjs` — preserves the existing runtime transport and authoring contract
- `state_dir/events` — remains the click/event integration point, but carry-forward must not depend on its existence

## Open Questions

- Whether any helper refinement beyond selected-state clarity is still needed after the first authored comparison screens exist — current thinking: keep helper changes narrow until a real gap appears
- Whether the repo should eventually provide a standard design-context source so the first `frontend-design` use can become frictionless — current thinking: support reuse when present now, but do not make centralization part of M001
- Whether optional metadata for recommendation or carry-forward semantics is ever worth adding later — current thinking: not in M001; authored markup should stay explicit and `data-choice`-based
