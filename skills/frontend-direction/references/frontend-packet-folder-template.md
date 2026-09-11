# Frontend Packet Files

New final packets use this self-contained form. A project may choose a different parent directory; keep the internal contract.

```text
docs/superpowers/specs/YYYY-MM-DD--<slug>--frontend/
  packet.md                    # sole human implementation entry; format marker
  packet.json                  # schema, approval/revision, references, file hashes
  screen-index.md              # important states, setup, acceptance, actual checks
  brownfield-ui-extraction.md  # required for brownfield; absent for greenfield
  prototype/                  # current approved source only, when in scope
  references/                 # current scoped images/captures
  history/                    # earlier concepts, prompts, prototypes, original packets
```

Keep reusable assets needed to launch inside `prototype/`; write setup and commands in `packet.md`. Explicit references-only scope may omit the prototype as described in the [schema](packet-schema.md). Additional supporting current files are allowed and included in the inventory. README or former entry files may point to `packet.md`; do not create competing implementation briefs.

Standalone brief lives in `packet.md`. Link a supplied approved spec/follow-on; GSD artifacts are supplemental only for an already confirmed route. Preserve superseded artifacts and their internal relationships in `history/`, identifying relocation and supersession. Current references live outside history even when copied from an earlier concept for a surviving scoped purpose.

Retain final binding sources/captures according to project policy. Temporary logs and traces remain local by default. Existing approved outer `--frontend-direction.md` documents, `chatgpt-image-2/` images and other legacy layouts remain readable without forced conversion. Only newly finalized or explicitly normalized packets use this canonical form. No external upload-pack authoring returns.
