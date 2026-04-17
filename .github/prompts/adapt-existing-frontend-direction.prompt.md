Adapt an existing frontend direction packet to the current durable Pencil-first format.

Inputs you should locate first:

- the existing `--frontend-direction.md` file
- the matching `screen-index.md`
- any selected-direction screenshots already saved locally
- any packet-linked `.pen` files
- any temporary HTML companion artifacts that influenced the chosen direction

Goals:

1. Preserve the packet's current human-readable thesis, rationale, and verification content.
2. Upgrade it so later agents can recover the durable `.pen` and screenshot references first.
3. Keep the packet brownfield-safe; temporary HTML companion artifacts remain comparison evidence, not implementation truth.

Required edits:

1. In **Packet Summary**, add:
   - packet-linked `.pen` files
   - Pencil transport expectation for downstream work
   - screenshot / export locations
2. Add or update the section that explains durable visual references so it names the exact `.pen` files, boards / frames, and screenshots implementation should use.
3. For each retained key screen in the packet gallery, add a source block containing:
   - screen key
   - primary visual source
   - `.pen` file path
   - board / frame name
   - screenshot / export path
   - whether a temporary HTML companion artifact influenced the choice
4. Update or create `screen-index.md` so each key screen has durable Pencil reference columns.
5. If temporary HTML companion artifacts influenced a retained direction, summarize that only as translated outcome notes; do not make the raw HTML file the durable packet source.

Important rules:

- prefer packet-linked `.pen` file -> retained screenshot / export -> current rendered UI
- do not remove the existing gallery prose or acceptance checks
- do not treat raw HTML companion files as binding implementation references
- call out missing durable references honestly
