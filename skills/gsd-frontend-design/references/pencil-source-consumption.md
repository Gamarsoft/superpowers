# Pencil Source Consumption

Use this whenever the frontend packet includes `pencil-workset.md`, `screen-index.md`, or relevant `.pen` files.

## Goal

Recover the exact approved visual reference before implementing or refining the UI.

## Retrieval ladder

For each target screen or component:

1. Read the packet and `screen-index.md`.
2. Open `pencil-workset.md`.
3. Load `pencil-design-core`.
4. Use Pencil CLI interactive mode only.
5. Open the exact `.pen` file or files named for the task.
6. Review any retained screenshots, browser captures, or Pencil exports linked by the packet.
7. Inspect the related code components, tokens, and shell primitives in the repo.
8. Load the correct stack adapter for implementation translation.

## How to use the source

Use Pencil-backed sources to understand:

- layout and grouping
- surface treatment and background containers
- spacing and hierarchy
- section order
- responsive intent
- typography emphasis
- state treatment
- control emphasis and primary/secondary action priority
- token and component intent
- what should become shared versus page-local

Do **not** use Pencil or any generated export as drop-in production code.

Translate the approved design into the repo’s actual framework, components, templates, and styling primitives.

## Board intent contract

For each board or screenshot, read the approved intent before editing code.

Use:

- `visual-truth`: the board is binding for visual treatment and requires board-parity verification.
- `semantic-guidance`: the board demonstrates behavior, layout intent, content priority, workflow, or state coverage. Adapt visual treatment to the existing product system.
- `reference-only`: the board is inspiration, exploration, or a comparison aid. It is not an acceptance target unless promoted by the packet or human.

If the packet does not declare intent or approval is pending, propose a classification and ask for confirmation before visual changes. If confirmation is unavailable, do not treat the board as visual truth; implement only behavior clearly required by the spec and record degraded mode or a blocker.

For each `visual-truth` board or screenshot, create a short parity checklist before editing code.

Cover:

- page background and major containers
- card or pane boundaries, radius, padding, border, and shadow/elevation
- filters and form controls, including whether they read as primary, secondary, neutral, or destructive
- action hierarchy, especially which single action is visually primary
- selected, hover, disabled, loading, empty, validation, and permission states named by the packet
- typography scale, weight, case, and numeric emphasis
- section order and section visual weight
- mobile navigation or mode-switching behavior

DOM presence is not enough. A section can be present and still fail the board if its surface, control priority, spacing, or visual hierarchy does not match the approved direction.

For each `semantic-guidance` board, create an intent-fit checklist instead:

- required behavior or workflow
- required information hierarchy and content priority
- named states and edge cases
- product-system adaptation choices
- explicit visual elements that are non-binding

Completion may proceed with unresolved mismatches only by explicit waiver:

- source board or screenshot
- approved board intent
- observed runtime mismatch
- reason parity is blocked
- accepted fallback
- whether the packet, `.pen` file, or code should be updated later

## What to record in implementation summaries

When Pencil-backed sources were used, record:

- which `.pen` files were used
- that Pencil CLI interactive mode was used
- which screenshots or captures were used
- which Pencil skills were loaded
- any mismatch between the packet and the `.pen` file
- any mismatch between the `.pen` file and the current code system
- any intentional deviation made for brownfield system fit
- the approved intent for each board or screenshot
- the board-parity or intent-fit checklist result for each required viewport/state
- any visual waiver accepted before completion
