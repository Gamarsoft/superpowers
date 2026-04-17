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
- spacing and hierarchy
- section order
- responsive intent
- typography emphasis
- state treatment
- token and component intent
- what should become shared versus page-local

Do **not** use Pencil or any generated export as drop-in production code.

Translate the approved design into the repo’s actual framework, components, templates, and styling primitives.

## What to record in implementation summaries

When Pencil-backed sources were used, record:

- which `.pen` files were used
- that Pencil CLI interactive mode was used
- which screenshots or captures were used
- which Pencil skills were loaded
- any mismatch between the packet and the `.pen` file
- any mismatch between the `.pen` file and the current code system
- any intentional deviation made for brownfield system fit
