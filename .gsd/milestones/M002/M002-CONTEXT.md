# M002: Visual Companion Routing and Authoring Quality

**Gathered:** 2026-03-29
**Status:** Queued — pending auto-mode execution.

## Project Description

Improve the brainstorming visual companion by tightening when the browser is used and by raising the minimum quality bar for authored screens. This milestone updates routing guidance in `skills/brainstorming/SKILL.md`, commits an explicit pre-display quality gate plus a hard `no placeholder screens` rule in `skills/brainstorming/visual-companion.md`, and refreshes only the three active example fragments so they become stronger starting points for layout, hierarchy, and flow-style comparisons within the existing four archetypes.

## Why This Milestone

M001 proved the runtime, fragment shell, helper boundary, and comparison-first authoring contract. Live trials then exposed the next bottleneck: the companion can still be invoked for weakly visual questions, and valid browser turns can still show artifacts that are too generic to support a real decision. This milestone addresses that operator-discipline gap now, while the runtime baseline is stable and before any broader diagram or orchestration work is considered.

## User-Visible Outcome

### When this milestone is complete, the user can:

- stay in terminal for conceptual, scope, and text-first brainstorming turns instead of being sent to low-value browser detours
- view companion screens that contain concrete, subject-specific visual artifacts strong enough to support real layout, hierarchy, or flow comparisons

### Entry point / environment

- Entry point: the existing brainstorming workflow driven by `skills/brainstorming/SKILL.md` and `skills/brainstorming/visual-companion.md`
- Environment: local dev, terminal, and browser in the current brainstorming session flow
- Live dependencies involved: the existing visual companion runtime, fragment example files, and the current `data-choice` interaction boundary

## Completion Class

- Contract complete means: the routing rule, pre-display checklist, `no placeholder screens` rule, failure fallback, and active-example refresh boundary are explicit in the skill docs and example files
- Integration complete means: `SKILL.md`, `visual-companion.md`, and the three active fragment examples reinforce the same quality bar without implying runtime, metadata, or archetype changes
- Operational complete means: the refreshed fragment examples still work through the existing companion runtime and require no server, helper, or frame-template changes

## Final Integrated Acceptance

To call this milestone complete, we must prove:

- given a conceptual, scope, or text-first brainstorming question, the updated routing guidance keeps the interaction in terminal instead of treating the browser as default
- given a valid visual question with a weak or placeholder artifact, the updated guide blocks the screen from being shown and requires revision or terminal fallback
- given the refreshed active examples, the side-by-side, ranked, and annotated-recommendation screens show concrete, subject-specific artifacts that support real visual judgment while staying inside the current runtime and archetype contract

## Risks and Unknowns

- Routing language could still be interpreted too loosely — if the boundary between visual and merely UI-adjacent questions stays fuzzy, low-value browser turns will continue
- The checklist could become descriptive rather than enforceable — if failure behavior is not explicit, placeholder screens may still slip through
- Flow-style examples may remain borderline — if they still read like dressed-up prose instead of genuinely visual artifacts, the guidance may need a later diagram-focused follow-up

## Existing Codebase / Prior Art

- `skills/brainstorming/SKILL.md` — owns brainstorming workflow routing and already contains the current visual-companion offer and per-question decision language
- `skills/brainstorming/visual-companion.md` — owns the comparison-first authoring contract and is the correct home for the pre-display quality gate
- `skills/brainstorming/examples/visual-companion/side-by-side-comparison.html` — active example to strengthen for two-option layout and wireflow-style comparisons
- `skills/brainstorming/examples/visual-companion/ranked-alternatives.html` — active example to strengthen for hierarchy-heavy current-winner comparisons
- `skills/brainstorming/examples/visual-companion/annotated-recommendation.html` — active example to strengthen for follow-up recommendation and rationale screens
- `skills/brainstorming/examples/visual-companion/carry-forward-summary.html` — keep untouched in this milestone unless planning finds a direct contradiction
- `.gsd/milestones/M001/M001-SUMMARY.md` — authoritative proof that the current runtime boundary is already validated and should not be reopened here
- `docs/superpowers/specs/2026-03-29--visual-companion-routing-and-authoring-quality.md` — authoritative design input for the milestone
- `docs/superpowers/specs/2026-03-29--visual-companion-routing-and-authoring-quality--gsd-handoff.md` — milestone and requirement seed

> See `.gsd/DECISIONS.md` for all architectural and pattern decisions — it is an append-only register; read it during planning, append to it during execution.

## Relevant Requirements

- R013 — tighten companion routing so only genuinely visual questions are sent to the browser
- R014 — commit the pre-display checklist in `visual-companion.md`
- R015 — make `no placeholder screens` and checklist-failure fallback explicit hard rules
- R016 — keep the example refresh boundary explicit: three active examples only, carry-forward untouched unless contradiction appears
- R017 — strengthen the side-by-side, ranked, and annotated-recommendation examples for concrete visual decisions
- R018 — keep flow-style cases conditional unless the artifact is genuinely visual enough to justify browser use
- R019 — preserve the current runtime contract, `data-choice` boundary, and four-archetype surface in this slice

## Scope

### In Scope

- tighter routing guidance in `skills/brainstorming/SKILL.md` for when the companion should and should not be used
- an explicit pre-display checklist in `skills/brainstorming/visual-companion.md`
- a hard `no placeholder screens` rule and explicit revise-or-stay-terminal failure behavior
- stronger, more concrete authored content in `side-by-side-comparison.html`, `ranked-alternatives.html`, and `annotated-recommendation.html`
- keeping flow-style examples under the current archetypes, but only when the artifact is visually credible enough to pass the new quality gate

### Out of Scope / Non-Goals

- runtime, server, helper, or frame-template behavior changes
- new required metadata beyond the current `data-choice` contract
- expanding the archetype count or introducing a new wireflow/diagram archetype in this milestone
- refreshing `carry-forward-summary.html` unless a direct contradiction is uncovered during planning or execution
- replacing the terminal as the primary reasoning channel

## Technical Constraints

- Preserve the M001 runtime baseline and do not reopen fragment/full-document behavior.
- Keep the current four archetypes as the only archetypes in scope.
- Keep the companion optional and per-question, not mandatory for UI-adjacent discussion.
- Treat stronger examples as guidance and copyable starting points, not hidden runtime requirements.
- Keep the first slice anchored to docs and example quality before considering any later runtime-guidance follow-up.

## Integration Points

- `skills/brainstorming/SKILL.md` — route only genuinely visual questions toward the companion
- `skills/brainstorming/visual-companion.md` — define the checklist, hard rules, and fallback behavior before display
- `skills/brainstorming/examples/visual-companion/*.html` — provide the concrete artifact quality bar for active archetypes
- existing visual companion runtime — render the refreshed fragments without any contract changes
- `.gsd/REQUIREMENTS.md` — track the new active capability contract introduced by this milestone

## Open Questions

- Are the refreshed flow-style examples strong enough without a dedicated diagram archetype? — Current thinking: keep them under the existing archetypes in M002, then revisit only if the same trial family still fails.
- Does `carry-forward-summary.html` need a later quality pass once routing and checklist changes land? — Current thinking: leave it untouched in M002 unless planning or verification finds a direct contradiction.
