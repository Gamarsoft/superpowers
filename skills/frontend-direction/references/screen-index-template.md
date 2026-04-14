# Screen Index Template

Use this file to keep screen coverage explicit.

Default file:
`docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend/screen-index.md`

## Template

```markdown
# Screen Index

| ID  | Screen / State | User goal | Priority | Source / trigger                       | Stitch source | Screen key     | Project ID | Screen ID | Device  | Size      | Screenshot mirror | HTML mirror | Key references           | Notes  |
| --- | -------------- | --------- | -------- | -------------------------------------- | ------------- | -------------- | ---------- | --------- | ------- | --------- | ----------------- | ----------- | ------------------------ | ------ |
| S1  | [screen]       | [goal]    | P0       | [route / flow step]                    | yes           | [s1-preferred] | [...]      | [...]     | DESKTOP | 1440×1024 | [path]            | [path]      | [wireframe / screenshot] | [note] |
| S2  | [state]        | [goal]    | P0       | [loading / empty / error / permission] | partial       | [s2-state]     | [...]      | [null]    | DESKTOP | [unknown] | [path]            | [none]      | [reference]              | [note] |
| S3  | [screen]       | [goal]    | P1       | [route / flow step]                    | no            | [none]         | [n/a]      | [n/a]     | [n/a]   | [n/a]     | [n/a]             | [n/a]       | [reference]              | [note] |
```

## Coverage rule

Include:

- the primary screen or entry point
- the most important completion screen or outcome state
- the most important supporting screen or dialog
- loading, empty, error, validation, and permission states when they matter

Do not create exhaustive paperwork for every trivial route. Focus on what shapes implementation.

## Stitch source rule

- `Stitch source` should be `yes`, `partial`, or `no`.
- `partial` means the packet has a preview image or partial metadata but is missing some live source details or mirrors.
- `Screen key` must match the packet gallery and `stitch-sources.json` when Stitch is used.
