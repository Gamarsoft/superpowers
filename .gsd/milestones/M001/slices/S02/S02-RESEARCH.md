# M001/S02 — Research

**Date:** 2026-03-28

## Summary

This slice primarily owns **R002** and **R003** and supports **R006**. The good news is that the codebase already has the right boundary for this work: fragment screens are wrapped by the shared frame in `skills/brainstorming/scripts/frame-template.html`, while full HTML documents bypass that frame entirely in `skills/brainstorming/scripts/server.cjs`. That means S02 can deliver comparison-first defaults mostly as a **frame-template styling pass** instead of a server or workflow change.

The main gap is that the current shared frame is still visually generic. It provides solid base primitives — `options`, `cards`, `mockup`, `pros-cons`, `section`, `label`, and selection styling — but it does **not** yet add comparison-specific emphasis for recommendation, current winner, ranked order honesty, or carry-forward scanning. Right now those semantics come mostly from authored copy like `Current winner`, `Recommended`, `Chosen direction`, and `Still open`, plus item order and the existing `.selected` class.

The main constraint is also the main surprise: `.selected` is doing double duty. In the S01 example kit it marks the authored current winner, and in `helper.js` it is also the only live interaction state the browser understands. Because M001 explicitly forbids new required metadata beyond `data-choice`, S02 should avoid inventing workflow semantics in JS. The safest path is to make fragment defaults clearer using the existing structural surfaces, keep lower-ranked options readable, and leave true chosen-vs-still-open interaction clarity to S03.

## Recommendation

Implement S02 as a **fragment-only comparison-kit upgrade** centered on `skills/brainstorming/scripts/frame-template.html`, with only minimal example/test edits if a hook truly cannot be expressed through existing structure.

Concretely:
- add shared-frame design tokens and CSS treatments for recommendation emphasis, ranked order cues, section scanning, and carry-forward readability
- target the structures already present in the S01 example kit: `.subtitle`, `.label`, `.section`, `.mockup`, `.options`, `.cards`, `.option.selected`, `.card.selected`, `.letter`, and `.options[data-multiselect]`
- keep non-selected alternatives readable; use emphasis, not suppression
- do **not** change `server.cjs` unless a compatibility bug appears
- do **not** add new required metadata or hidden helper behavior
- add regression coverage that proves the new defaults are fragment-only and that full-document passthrough remains unchanged

## Don't Hand-Roll

| Problem | Existing Solution | Why Use It |
|---------|------------------|------------|
| Fragment vs full-document routing | `isFullDocument()` + `wrapInFrame()` in `skills/brainstorming/scripts/server.cjs` | This already enforces the R006 compatibility boundary. Styling should ride on fragment wrapping, not replace it. |
| Choice capture and selected-state plumbing | `toggleSelect(this)` plus the `data-choice` click listener in `skills/brainstorming/scripts/helper.js` | This preserves D006's additive `data-choice` contract and avoids turning S02 into workflow logic. |
| Archetype structure for comparison screens | The four S01 fragment examples under `skills/brainstorming/examples/visual-companion/` | These are the actual authored surfaces downstream slices are supposed to target. Style against them instead of inventing a new fragment schema. |

## Existing Code and Patterns

- `skills/brainstorming/scripts/frame-template.html` — shared fragment frame with theme tokens, fixed header/footer, and reusable UI primitives (`options`, `cards`, `mockup`, `pros-cons`, `section`, `label`). It already supports selection visuals, but not comparison-first semantics.
- `skills/brainstorming/scripts/helper.js` — additive browser behavior keyed only off `data-choice`. It updates the indicator bar based on `.selected` elements inside `.options` or `.cards`, which means authored current-winner state and user click state currently share one visual hook.
- `skills/brainstorming/scripts/server.cjs` — fragment/full-document compatibility boundary. Fragments are wrapped in the shared frame; full documents are served as-is with helper injection. This is the line S02 must not blur.
- `skills/brainstorming/examples/visual-companion/ranked-alternatives.html` — ranked pattern already signals order through numeric `.letter` badges and sets the current winner with `.option.selected`, but honesty currently depends mostly on copy and source order.
- `skills/brainstorming/examples/visual-companion/annotated-recommendation.html` — recommended direction uses `.label`, `.mockup`, `.mockup-header`, and a follow-on `options` list. Good surface for frame-level “current winner” emphasis without new metadata.
- `skills/brainstorming/examples/visual-companion/carry-forward-summary.html` — already separates `Chosen direction` and `Still open`, and already uses `data-multiselect` for the unresolved cluster. This was a useful surprise: the carry-forward archetype already has enough structure for better defaults without new JS.
- `skills/brainstorming/examples/visual-companion/side-by-side-comparison.html` — comparison cards already reuse the generic `cards` + `pros-cons` surface. The frame can strengthen scanability here without touching runtime logic.
- `tests/brainstorm-server/server.test.js` — currently protects fragment wrapping, full-document passthrough, helper injection, and `state/events`. It does **not** yet prove comparison-kit visual defaults, so S02 will likely need targeted additions here or a nearby dedicated test.

## Constraints

- **No new required metadata beyond `data-choice`.** Any S02 solution that depends on new mandatory attributes or a new DSL violates M001 scope.
- **Fragment-only defaults.** Only content wrapped by `frame-template.html` should inherit the comparison kit. Full-document screens must remain compatibility-supported and unchanged by default.
- **Helper behavior stays additive.** `helper.js` should not become a hidden recommendation engine or carry-forward workflow layer in this slice.
- **Lower-ranked options must stay readable.** R003 is not satisfied by dimming alternatives into irrelevance.
- **The S01 contract test is intentionally strict.** If example files or guide references move, `tests/brainstorm-server/visual-companion-contract.test.js` will fail even if the semantics still seem right.

## Common Pitfalls

- **Using `.selected` as if it means “final decision.”** In the current system it means both authored emphasis and click-selected state. Avoid deepening that semantic ambiguity in S02; use it for visual emphasis only and leave decision carry-forward behavior to S03.
- **Making non-winning options too quiet.** Heavy opacity drops, low-contrast text, or overly dominant winner chrome would violate the “honest comparison” requirement even if the winner becomes obvious.
- **Accidentally leaking fragment defaults into full documents.** Any test or implementation that assumes every screen receives the shared frame would break the explicit compatibility boundary.
- **Adding archetype-specific hooks too aggressively.** The example kit already exposes useful structural patterns. Reach for optional classes only if the existing surfaces truly cannot express the needed visual defaults.

## Open Risks

- The current structural hooks may be just enough for S02, but not enough to visually separate “authored current winner” from “user clicked this just now.” If that distinction becomes necessary for clarity, S02 should stop short and let S03 own the stronger interaction semantics rather than forcing new metadata into this slice.

## Skills Discovered

| Technology | Skill | Status |
|------------|-------|--------|
| HTML/CSS fragment companion UI | `frontend-design` | installed |
| Node.js runtime / server-side JS | `wshobson/agents@nodejs-backend-patterns` | available — install with `npx skills add wshobson/agents@nodejs-backend-patterns` |
| JavaScript test authoring | `wshobson/agents@javascript-testing-patterns` | available — install with `npx skills add wshobson/agents@javascript-testing-patterns` |

## Sources

- The shared frame already provides generic fragment primitives and selection styling, but no comparison-first defaults yet (source: [`skills/brainstorming/scripts/frame-template.html`](../../../../../skills/brainstorming/scripts/frame-template.html))
- The helper only understands `data-choice` plus `.selected`, and the indicator bar updates only after interaction inside `.options` or `.cards` containers (source: [`skills/brainstorming/scripts/helper.js`](../../../../../skills/brainstorming/scripts/helper.js))
- Fragment wrapping vs full-document passthrough is enforced in the server by `isFullDocument()` and `wrapInFrame()` (source: [`skills/brainstorming/scripts/server.cjs`](../../../../../skills/brainstorming/scripts/server.cjs))
- Existing tests already lock the fragment/full-document compatibility boundary, helper injection, and frame structure, but not comparison-specific visual defaults (source: [`tests/brainstorm-server/server.test.js`](../../../../../tests/brainstorm-server/server.test.js))
- The S01 archetype files already expose the exact structures S02 should target: ranked winner emphasis, annotated recommendation surfaces, carry-forward sections, and side-by-side comparison cards (source: [`skills/brainstorming/examples/visual-companion/ranked-alternatives.html`](../../../../../skills/brainstorming/examples/visual-companion/ranked-alternatives.html), [`skills/brainstorming/examples/visual-companion/annotated-recommendation.html`](../../../../../skills/brainstorming/examples/visual-companion/annotated-recommendation.html), [`skills/brainstorming/examples/visual-companion/carry-forward-summary.html`](../../../../../skills/brainstorming/examples/visual-companion/carry-forward-summary.html), [`skills/brainstorming/examples/visual-companion/side-by-side-comparison.html`](../../../../../skills/brainstorming/examples/visual-companion/side-by-side-comparison.html))
