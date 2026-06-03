# Screen Index Template

Default file:
`docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend/screen-index.md`

```markdown
# Screen Index

| ID | Screen / State | User goal | Priority | Source / trigger | Primary reference | Intent | Approval | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| S1 | [screen] | [goal] | P0 | [route / flow] | [screenshot / approved image / current UI] | visual-truth / semantic-guidance / reference-only | approved / pending | [note] |
| S2 | [state] | [goal] | P0 | [loading / error / permission] | [screenshot / current UI / generated image] | visual-truth / semantic-guidance | approved / pending | [note] |
```

Include only screens and states that shape implementation:

- primary entry screen
- important outcome or completion state
- important dialog or supporting view
- loading, empty, error, validation, permission, destructive, or mobile states when they matter

Do not make exhaustive route inventories.
