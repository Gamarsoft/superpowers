# T02: Add the four authored fragment examples

**Slice:** S01 — Authoring contract and archetype kit
**Milestone:** M001

## Description

Turn the contract into copyable artifacts. This task adds one concrete fragment example for each v1 archetype and links them from the guide so future authors can start from proven comparison-first structures instead of generic cards or mockups.

## Steps

1. Create a new example set under `skills/brainstorming/examples/visual-companion/` with one fragment per archetype.
2. Use only the existing shared-frame authoring surface and `data-choice` metadata boundary when composing each example.
3. Make the ranked example show a visible current winner without hiding lower-ranked alternatives, and make the carry-forward example show both chosen-direction and still-open wording.
4. Cross-link the example files from `skills/brainstorming/visual-companion.md` with short notes on when each archetype should be copied or adapted.

## Must-Haves

- [ ] Four fragment examples exist, one for each named archetype.
- [ ] The examples demonstrate comparison-first structure without introducing a new DSL or required metadata beyond `data-choice`.

## Verification

- `rg -n "Recommended|Current winner|Still open|Chosen direction|data-choice" skills/brainstorming/examples/visual-companion/*.html`
- Manual check in `skills/brainstorming/visual-companion.md` confirms each archetype links to its example file and explains when to use it.

## Observability Impact

- **Signals changed:** no runtime protocol changes; this task adds inspectable authored example artifacts and guide cross-links.
- **How future agents inspect:** open `skills/brainstorming/examples/visual-companion/*.html` to verify each archetype stays fragment-first and `data-choice`-bounded; inspect `skills/brainstorming/visual-companion.md` for direct per-archetype links and usage notes.
- **Failure state visible:** contract/example drift becomes visible when verification grep misses required markers (`Recommended`, `Current winner`, `Chosen direction`, `Still open`, `data-choice`) or when guide links are missing/broken during manual check.

## Inputs

- `skills/brainstorming/visual-companion.md` — contract language from T01 that defines the four archetypes and example expectations
- `skills/brainstorming/scripts/frame-template.html` — existing fragment surface area the examples should stay within
- `skills/brainstorming/scripts/helper.js` — existing selection semantics that examples may rely on via `data-choice`
- `S01-RESEARCH.md` summary — explains why concrete authored examples are required proof for this slice

## Expected Output

- `skills/brainstorming/examples/visual-companion/side-by-side-comparison.html` — fragment example for side-by-side comparison
- `skills/brainstorming/examples/visual-companion/ranked-alternatives.html` — fragment example for ranked alternatives
- `skills/brainstorming/examples/visual-companion/annotated-recommendation.html` — fragment example for annotated recommendation / current winner
- `skills/brainstorming/examples/visual-companion/carry-forward-summary.html` — fragment example for carry-forward summary, including chosen and still-open wording
- `skills/brainstorming/visual-companion.md` — guide links and usage notes for the example kit
