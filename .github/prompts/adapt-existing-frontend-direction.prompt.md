Adapt an existing frontend direction packet to the Stitch source-aware format.

Inputs you should locate first:

- the existing `--frontend-direction.md` file
- the matching `screen-index.md`
- the matching `stitch-prompt-pack.md`
- any selected-direction screenshots already saved locally
- `.stitch/DESIGN.md` and `.stitch/BOOTSTRAP.md` when present
- live Stitch project and screen data when available through MCP

Goals:

1. Preserve the packet's current human-readable thesis, rationale, and verification content.
2. Upgrade it so later agents can retrieve exact Stitch sources.
3. Keep the packet brownfield-safe; Stitch remains reference evidence, not implementation code.

Required edits:

1. In **Packet Summary**, add:
   - selected Stitch source manifest path
   - Stitch retrieval mode
   - selected screen mirror path
2. Add a new section after **Screen Inventory** named **Stitch Source Manifest** that links to `stitch-sources.json` and explains how implementation and refinement should use it.
3. For each retained screen in the packet gallery, add a **Stitch source** block containing:
   - screen key
   - Project ID
   - Screen ID
   - full resource name
   - device type
   - width × height
   - screenshot mirror path
   - HTML mirror path
   - metadata JSON path
4. Create or update `stitch-sources.json` using the manifest template.
5. Update or create `screen-index.md` so each key screen has Stitch source columns.
6. Mirror each selected or retained Stitch screen into:
   - `selected-direction/*.png`
   - `selected-direction/*.html`
   - `selected-direction/*.meta.json`
7. If live Stitch MCP is available, fetch actual screen IDs and actual source metadata from the real Stitch project.
8. If live Stitch MCP is not available, do **not** invent IDs. Use explicit TODO placeholders or `null` values and mark the packet `preview only (degraded)` until source capture is completed.

Important rules:

- prefer live Stitch screen -> HTML mirror -> full-resolution screenshot mirror -> packet preview image
- do not remove the existing gallery prose or acceptance checks
- do not guess screen IDs
- call out missing data honestly
