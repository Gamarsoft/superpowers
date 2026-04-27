# Verification in Browser

## Verify against

- approved packet
- `brownfield-ui-extraction.md`
- `pencil-workset.md`
- relevant `.pen` files
- retained screenshots
- the real existing product context

## Board-intent checks

For each named board, record the approved intent: `visual-truth`, `semantic-guidance`, or `reference-only`.

If intent is missing or pending, ask for confirmation before visual changes. If confirmation is unavailable, do not treat the board as visual truth; report degraded mode or a blocker.

For `visual-truth` boards, compare runtime screenshots against the board.

Record pass/mismatch/waived for:

- major page background and pane/card containers
- border, radius, padding, and surface contrast
- filter/select/button visual priority
- primary action uniqueness and placement
- selected state treatment
- metrics, table/list, empty, support, and destructive-state surfaces
- typography size, weight, and numeric emphasis
- section order and section visual weight

For `semantic-guidance` boards, record pass/mismatch/waived for:

- required behavior or workflow
- content priority and information hierarchy
- named states
- product-system adaptation choices
- explicitly non-binding visual details

DOM presence is insufficient. A Nebular component can be present and still fail if it misses required behavior, states, or, for `visual-truth`, if its default theme makes it read as the wrong control type or action priority.

## Desktop checks

- shell still looks correct
- action row placement matches intent
- cards and surfaces match the hierarchy
- dense tables or two-panel layouts remain legible
- footer actions stay anchored where expected
- neutral controls do not accidentally render as primary actions
- approved framed or white surfaces are actually visible, not just structurally present

## Mobile checks

- shell still functions
- filters/actions do not collapse awkwardly
- dense rows remain scannable
- no clipping or horizontal overflow
- primary actions remain reachable
- mobile switchers, summaries, and selected-profile paths match the approved flow

## Accessibility basics

- icon-only actions have names
- visible labels exist where needed
- status contrast is acceptable
- error and helper text are understandable

## Completion rule

Do not claim fidelity based only on compilation.
Use browser evidence.

Captured screenshots alone are not enough. State each board's approved intent, what was compared or validated, and list unresolved mismatches.

Completion may proceed with a mismatch only by waiver: source board, approved intent, runtime mismatch, implementation constraint, accepted fallback, and follow-up.
