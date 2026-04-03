# Screen Index Template

Use this file to keep screen coverage explicit.

Default file:
`docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend/screen-index.md`

## Template

```markdown
# Screen Index

| ID | Screen / State | User goal | Priority | Source / trigger | Key references | Notes |
|----|----------------|-----------|----------|------------------|----------------|-------|
| S1 | [screen] | [goal] | P0 | [route / flow step] | [wireframe / screenshot] | [note] |
| S2 | [state] | [goal] | P0 | [loading / empty / error / permission] | [reference] | [note] |
| S3 | [screen] | [goal] | P1 | [route / flow step] | [reference] | [note] |
```

## Coverage rule

Include:

- the primary screen or entry point
- the most important completion screen or outcome state
- the most important supporting screen or dialog
- loading, empty, error, validation, and permission states when they matter

Do not create exhaustive paperwork for every trivial route. Focus on what shapes implementation.
