Adapt an existing frontend direction packet to the current compact screenshot-first format.

Inputs to locate first:

- the existing frontend direction file
- the matching `screen-index.md`
- `brownfield-ui-extraction.md` when present
- selected-direction screenshots or browser captures saved locally
- optional approved ChatGPT Images 2 files
- any temporary HTML companion artifacts that influenced the chosen direction

Goals:

1. Preserve the packet's human-readable thesis, rationale, and verification content.
2. Make later agents recover source evidence, reference intent, and screenshots/captures first.
3. Keep the packet brownfield-safe; temporary HTML companion artifacts remain comparison evidence, not implementation truth.

Required edits:

1. Convert the packet to this short shape: Summary, Source Evidence, Screens And States, Visual References, Implementation Contract, Verification, Open Questions.
2. Add or update durable visual references with exact screenshot/capture/generated-image paths and approved reference intent.
3. For each retained key screen, include screen key, primary visual source, screenshot/capture path, generated-image path if approved, reference intent, and whether a temporary companion artifact influenced the choice.
4. Update or create `screen-index.md` with compact source, intent, approval, and notes columns.
5. Call out missing evidence honestly and use degraded current-UI mode when required.

Important rules:

- prefer packet source evidence, retained screenshots/captures, approved generated images, then current rendered UI
- keep `Must preserve`, `May adapt`, `Explicit no-gos`, UX copy source, reference intent, and verification gates
- do not treat raw HTML companion files as binding implementation references
