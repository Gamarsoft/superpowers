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
    ├── chatgpt-image-2/          # when image reference generation is used before visual-truth selection
    ├── pencil-workset.md         # only when Pencil is the selected visual-truth source
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
- selected visual-truth source
- exact Pencil skills to load downstream only when Pencil is selected

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
- primary visual source: approved ChatGPT Images 2 image, Pencil board, or current UI capture
- exact approved image, `.pen` file, or board references

### `chatgpt-image-2/`
ChatGPT Images 2 reference prompt pack:
- shared image-generation context
- prompt files per screen/state
- attachment map for `design/baseline/*` screenshots
- generated reference images saved beside matching prompt files after human generation
- approval notes before any generated image becomes visual truth or influences Pencil
- selected approved images when the human chooses image-only implementation visual truth

### `pencil-workset.md`
The plan for durable repo-local design files:
- files to create or refresh
- shared vs feature-specific responsibilities
- boards to maintain
- decision axes to explore
- skill / adapter plan

Omit this file when the human selects approved ChatGPT Images 2 references as the implementation visual truth.

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
