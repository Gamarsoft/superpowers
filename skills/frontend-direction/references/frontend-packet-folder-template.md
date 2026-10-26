# Frontend Packet Files

New final packets use this self-contained form. A project may choose a different parent directory; keep the internal contract.

```text
docs/superpowers/specs/YYYY-MM-DD--<slug>--frontend/
  packet.md                    # sole human entry; frontend-packet: 2 marker
  packet.json                  # schema, approval/revision, references, file hashes
  screen-index.md              # important states, setup, acceptance, actual checks
  brownfield-ui-extraction.md  # required for brownfield; absent for greenfield
  design/                     # manifest, provenance and selected source exports
    manifest.json             # design_source.manifest; medium-specific payload
  runtime/                    # check records, recoverable code and dependency setup
  references/                 # current scoped images/captures
  history/                    # earlier local drafts, concepts and supersession notes
```

Use the [version-2 schema](packet-schema.md). A Paper manifest binds structure, computed styles, frozen resolved tokens, assets, copy and component/source mappings. Runtime-authored design binds its actual recoverable source; references-only design records the scoped omission decision. Runtime check records are independent of the selected design medium. Keep launch assets, dependencies, dirty-source snapshots and any immutable-reference recovery evidence locally inventoried; write reproducible commands and state setup in the runtime record and `packet.md`. Additional current supporting files are included in the inventory. README files may point to `packet.md`; do not create competing implementation briefs.

Standalone brief lives in `packet.md`. Link a supplied approved spec/follow-on; GSD artifacts are supplemental only for an already confirmed route. Preserve draft relationships and supersession in `history/`. Existing historical packets remain byte-identical at their original paths. Current references live outside history even when copied from an earlier concept for an explicitly surviving scoped purpose under current approval.

Retain final binding sources/captures according to project policy. Logs and traces used as binding proof belong in the current inventory. Other temporary diagnostics remain local by default. Historical layouts remain readable as reference material only; this workflow generates and consumes v2 packets exclusively. There is no normalization, migration or fallback path. No external upload-pack authoring returns.
