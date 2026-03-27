# T02: Implement the shared comparison-kit defaults

**Slice:** S02 — Fragment comparison defaults
**Milestone:** M001

## Description

Deliver the comparison-first visual upgrade inside the shared fragment frame. This task tunes the existing frame primitives so recommendation, current winner, ranked order, and carry-forward sections read clearly by default while lower-ranked options remain honest and readable.

## Steps

1. Upgrade the design tokens and CSS in `skills/brainstorming/scripts/frame-template.html` for the existing comparison surfaces: `.subtitle`, `.label`, `.section`, `.mockup`, `.options`, `.cards`, `.option.selected`, `.card.selected`, `.letter`, and `.options[data-multiselect]`.
2. Keep the emphasis additive: strengthen recommendation and current-winner scan, preserve legibility for lower-ranked options, and avoid any helper or server behavior changes.
3. Make only minimal example-file adjustments if one of the S01 archetypes needs an optional hook or clearer authored structure for the new defaults.
4. Extend `tests/brainstorm-server/fragment-comparison-defaults.test.js` so the slice locks the new ranking, recommendation, and carry-forward proof surfaces.

## Must-Haves

- [ ] Wrapped fragment screens make recommendation and alternatives easier to parse at a glance without hiding lower-ranked options.
- [ ] Ranked, annotated-recommendation, and carry-forward archetypes inherit clearer defaults from the shared frame without introducing new required metadata or runtime logic.

## Verification

- `node tests/brainstorm-server/fragment-comparison-defaults.test.js`
- `node tests/brainstorm-server/visual-companion-contract.test.js`
- `cd tests/brainstorm-server && node server.test.js && node ws-protocol.test.js`

## Observability Impact

- Signals added/changed: the comparison-defaults regression test now names missing ranking, recommendation, or carry-forward selectors in wrapped fragment HTML.
- How a future agent inspects this: inspect `skills/brainstorming/scripts/frame-template.html` for the comparison-first style section, then run the four-command verification chain to localize whether failure is in the shared frame, the contract docs, or the runtime boundary.
- Failure state exposed: missing current-winner emphasis, over-dimmed alternatives, absent carry-forward styling hooks, or regressions in existing server/WebSocket behavior.

## Inputs

- `skills/brainstorming/scripts/frame-template.html` — fragment wrapper and reusable UI primitives that already exist but are visually generic
- `tests/brainstorm-server/fragment-comparison-defaults.test.js` — boundary proof surface from T01 that must grow into slice-level regression coverage
- `skills/brainstorming/examples/visual-companion/ranked-alternatives.html` — ranked example that should show an obvious current winner without false finality
- `skills/brainstorming/examples/visual-companion/annotated-recommendation.html` — recommendation example that should get stronger scanability from the shared frame
- `skills/brainstorming/examples/visual-companion/carry-forward-summary.html` — carry-forward example that should read clearly with chosen vs still-open sections
- `skills/brainstorming/scripts/helper.js` — additive interaction boundary that must remain unchanged in this slice

## Expected Output

- `skills/brainstorming/scripts/frame-template.html` — shared comparison-first defaults for fragment screens
- `tests/brainstorm-server/fragment-comparison-defaults.test.js` — extended regression coverage for recommendation, ranking, and carry-forward defaults
- `skills/brainstorming/examples/visual-companion/ranked-alternatives.html` — minimal optional-hook or authored-structure adjustments only if required by the new defaults
- `skills/brainstorming/examples/visual-companion/annotated-recommendation.html` — minimal optional-hook or authored-structure adjustments only if required by the new defaults
- `skills/brainstorming/examples/visual-companion/carry-forward-summary.html` — minimal optional-hook or authored-structure adjustments only if required by the new defaults
