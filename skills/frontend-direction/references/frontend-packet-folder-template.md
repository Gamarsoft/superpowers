# Frontend Packet Folder Template

Use this to keep the packet layout predictable and implementation-friendly.

## Default written files

```text
docs/superpowers/specs/
├── YYYY-MM-DD--<slug>.md
├── YYYY-MM-DD--<slug>--frontend-direction.md
├── YYYY-MM-DD--<slug>--gsd-handoff.md
└── YYYY-MM-DD--<slug>--frontend/
    ├── brownfield-ui-extraction.md
    ├── screen-index.md
    ├── pencil-workset.md
    └── screenshots/
```

## Default repo-local Pencil files

```text
design/pencil/
├── _shared/
│   ├── 00-foundations.pen
│   ├── 10-shell.pen
│   └── 20-patterns.pen
└── <slug>/
    └── 30-<slug>.pen
```

## What belongs where

### `...--frontend-direction.md`
The human-readable implementation contract:
- visual thesis
- preserve vs change call
- chosen directions
- responsive contract
- state coverage
- accessibility notes
- must preserve / may adapt / no-gos
- exact Pencil skills to load downstream

### `brownfield-ui-extraction.md`
Current product truth:
- what is already strong
- what must be preserved
- what is drifting
- what is safe to improve now

### `screen-index.md`
Coverage map:
- key screens
- key states
- primary visual source
- exact `.pen` file / board references

### `pencil-workset.md`
The plan for durable repo-local design files:
- files to create or refresh
- shared vs feature-specific responsibilities
- boards to maintain
- decision axes to explore
- skill / adapter plan

### `screenshots/`
Retained visual evidence:
- browser captures
- Pencil exports
- comparison views
- annotated references when useful

## Quality bar

A good packet folder is:

- small enough to stay readable
- stable enough for another agent to reuse later
- explicit about what is durable evidence
- explicit about what was only optional exploration
