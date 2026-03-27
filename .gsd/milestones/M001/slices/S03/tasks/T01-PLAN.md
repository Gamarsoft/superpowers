---
estimated_steps: 3
estimated_files: 3
---

# T01: Lock additive helper selection semantics

**Slice:** S03 — Selection clarity and carry-forward behavior
**Milestone:** M001

## Description

Strengthen click-assisted selected-state clarity without changing the product boundary. This task keeps `helper.js` presentation-level and `data-choice`-based while adding a focused regression that proves container-local semantics for single-select and multiselect interactions.

## Steps

1. Make only the minimal helper and shared-frame adjustments needed to improve selected-state feedback for existing `data-choice` interactions.
2. Add `tests/brainstorm-server/helper-selection-clarity.test.js` with a lightweight harness that exercises single-select and multiselect behavior, including default indicator guidance, single selected label behavior, and multiselect count behavior.
3. Add a workflow-boundary guard so the task fails if `helper.js` starts depending on `Chosen direction`, `Still open`, or `state/events`.

## Must-Haves

- [ ] Click-assisted selection feels clearer, but the helper still derives state only from the current DOM and existing `data-choice` / `.selected` surfaces.
- [ ] Regression coverage proves container-scoped semantics and blocks hidden workflow logic from entering `helper.js`.

## Verification

- `node tests/brainstorm-server/helper-selection-clarity.test.js`
- `node -e "const fs=require('fs');const helper=fs.readFileSync('skills/brainstorming/scripts/helper.js','utf8');for(const banned of ['Chosen direction','Still open','state/events']){if(helper.includes(banned)){throw new Error('Helper drifted into workflow semantics: '+banned);}}console.log(JSON.stringify({check:'helper-workflow-boundary',status:'pass'}));"`

## Observability Impact

- Signals added/changed: helper-selected indicator semantics become explicitly testable for default, single-select, and multiselect states.
- How a future agent inspects this: run `node tests/brainstorm-server/helper-selection-clarity.test.js`, then inspect `skills/brainstorming/scripts/helper.js` and the selection indicator markup in `skills/brainstorming/scripts/frame-template.html`.
- Failure state exposed: container-scope drift, broken selected-label rendering, incorrect multiselect counts, or helper code that starts inferring workflow semantics.

## Inputs

- `skills/brainstorming/scripts/helper.js` — existing click capture and indicator behavior that must stay additive and container-scoped
- `skills/brainstorming/scripts/frame-template.html` — shared selection indicator surface that may need minimal clarity tweaks
- `tests/brainstorm-server/server.test.js` — adjacent runtime behavior that this task must not invalidate
- S03 research summary — confirms helper state is transient and must not become durable carry-forward memory

## Expected Output

- `skills/brainstorming/scripts/helper.js` — clearer selected-state feedback that remains presentation-only
- `skills/brainstorming/scripts/frame-template.html` — minimal indicator or selected-state markup adjustments if needed
- `tests/brainstorm-server/helper-selection-clarity.test.js` — focused regression coverage for helper-selected semantics and workflow-boundary drift
