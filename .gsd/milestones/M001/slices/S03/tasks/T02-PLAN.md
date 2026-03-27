---
estimated_steps: 4
estimated_files: 4
---

# T02: Author explicit carry-forward states for chosen, still-open, and degraded flows

**Slice:** S03 — Selection clarity and carry-forward behavior
**Milestone:** M001

## Description

Make authored carry-forward screens the authority for continuity. This task tightens the guide and example screens so later screens explicitly say what direction is being carried forward, or that the comparison is still open, and it keeps degraded mode visible and honest when richer design context was unavailable.

## Steps

1. Tighten `skills/brainstorming/visual-companion.md` so the carry-forward guidance explicitly distinguishes `Chosen direction`, `Still open`, and explicit degraded-mode output.
2. Update the carry-forward-oriented example screens so they model those states in visible authored copy without adding new metadata.
3. Add `tests/brainstorm-server/carry-forward-behavior.test.js` to render the authored screens with and without `state/events` present and assert the carry-forward copy stays explicit either way.
4. Re-run the contract regression so guide wording and example references remain aligned after the updates.

## Must-Haves

- [ ] Later-screen examples explicitly communicate chosen versus still-open direction for both click-assisted and terminal-only flows.
- [ ] Degraded mode stays visible and honest in the authored output rather than being implied or hidden.

## Verification

- `node tests/brainstorm-server/carry-forward-behavior.test.js`
- `node tests/brainstorm-server/visual-companion-contract.test.js`

## Observability Impact

- Signals added/changed: carry-forward continuity becomes inspectable through explicit authored status copy and a dedicated regression that runs with and without event-file context.
- How a future agent inspects this: read `skills/brainstorming/visual-companion.md`, inspect the carry-forward example fragments, and run `node tests/brainstorm-server/carry-forward-behavior.test.js`.
- Failure state exposed: missing chosen/still-open wording, degraded-mode ambiguity, or accidental dependence on persisted browser events.

## Inputs

- `skills/brainstorming/visual-companion.md` — S01 contract text that already defines the archetypes and degraded-mode rule
- `skills/brainstorming/examples/visual-companion/annotated-recommendation.html` — recommendation example that can model a carried-forward choice
- `skills/brainstorming/examples/visual-companion/carry-forward-summary.html` — existing carry-forward example that already separates chosen and still-open sections
- `tests/brainstorm-server/visual-companion-contract.test.js` — strict guide/example regression that must stay aligned with any wording changes
- S03 research summary — confirms next-screen carry-forward cannot rely on durable `state/events`

## Expected Output

- `skills/brainstorming/visual-companion.md` — explicit carry-forward and degraded-mode authoring guidance
- `skills/brainstorming/examples/visual-companion/annotated-recommendation.html` — updated example copy if needed for explicit carried-forward choice
- `skills/brainstorming/examples/visual-companion/carry-forward-summary.html` — explicit chosen, still-open, and degraded-mode-friendly carry-forward example
- `tests/brainstorm-server/carry-forward-behavior.test.js` — dedicated regression proving authored continuity survives absent or cleared browser events
