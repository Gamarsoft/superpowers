# Frontend Direction Phase

Run this phase when UI/UX materially shapes implementation and no approved packet exists.

## Required Outputs

- `--frontend-direction.md`
- `--frontend/screen-index.md`
- `--frontend/brownfield-ui-extraction.md` for brownfield work
- retained screenshots or browser captures when they materially guide implementation
- optional `chatgpt-image-2/` prompt pack when generated references are useful

## Decision Rule

Use the lightest durable evidence that prevents implementation drift:

1. current UI screenshots/browser captures for brownfield continuity
2. packet prose for decisions and constraints
3. approved generated images only when they clarify a visual direction better than prose/screenshots
4. degraded current UI when evidence is insufficient

## Stop Condition

The phase is done when the packet names:

- screens and states in scope
- must-preserve patterns
- approved visual changes
- reference intent and approval status
- copy source
- runtime verification expectations

Use the shared packet statuses: `not-required` when frontend direction is out of scope, `required-pending` while required decisions remain open, `approved` when the contract is complete, and `approved-with-degraded-evidence` only after every degraded constraint is recorded and explicitly approved.

Approve the complete packet before returning to delivery routing. This phase does not select a route, create an adapter, or start UI implementation.
