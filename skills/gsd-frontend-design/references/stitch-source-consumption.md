# Stitch Source Consumption

Use this whenever the frontend packet contains `stitch-sources.json` or per-screen Stitch metadata.

## Goal

Recover the exact selected reference screen before implementing or refining the UI.

## Retrieval ladder

For each target screen:

1. Read the packet and `screen-index.md`.
2. Open `stitch-sources.json`.
3. Fetch the live Stitch screen when MCP is available.
4. If live retrieval fails, open the local HTML mirror.
5. If HTML mirror is unavailable, open the full-resolution screenshot mirror.
6. Use the embedded packet preview image only as a last resort.

## How to use the source

Use Stitch sources to understand:

- layout and grouping
- spacing and hierarchy
- section order
- responsive intent
- typography emphasis
- state treatment

Do **not** use Stitch HTML as drop-in production code.

Translate it into the repo's actual framework and design-system primitives.

## In implementation summaries

When Stitch-backed sources were used, record:

- which `screenKey`s were used
- whether live retrieval or local mirrors were used
- any mismatch between the packet and the source
- any intentional deviation made for brownfield system fit
