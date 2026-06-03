# Frontend Packet Folder Template

Use a small, predictable folder.

```text
docs/superpowers/specs/
├── YYYY-MM-DD--<slug>.md
├── YYYY-MM-DD--<slug>--gsd-handoff.md
├── YYYY-MM-DD--<slug>--frontend-direction.md
└── YYYY-MM-DD--<slug>--frontend/
    ├── brownfield-ui-extraction.md
    ├── screen-index.md
    ├── screenshots/
    └── chatgpt-image-2/          # only when generated image references are used
```

## What Belongs Where

- `--frontend-direction.md`: concise implementation contract.
- `brownfield-ui-extraction.md`: current truth, safe improvements, no-gos.
- `screen-index.md`: key screens, states, references, and intent.
- `screenshots/`: retained browser/runtime evidence when useful.
- `chatgpt-image-2/`: prompt pack and approved generated references, only when requested or useful.

Raw runtime evidence is local by default. Commit only durable, intentionally retained screenshots or prompt packs.
