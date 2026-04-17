# Screen Index Template

Use this file to keep screen coverage explicit.

Default file:
`docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend/screen-index.md`

## Template

```markdown
# Screen Index

| ID  | Screen / State | User goal | Priority | Source / trigger | Primary visual source | Pencil file | Board / frame | Downstream adapter | Key references | Notes |
| --- | -------------- | --------- | -------- | ---------------- | --------------------- | ----------- | ------------- | ------------------ | -------------- | ----- |
| S1  | [screen]       | [goal]    | P0       | [route / flow]   | current UI + Pencil   | `design/pencil/{slug}/30-{slug}.pen` | [board name] | [adapter] | [screenshots / spec] | [note] |
| S2  | [state]        | [goal]    | P0       | [loading / error / validation] | Pencil | `design/pencil/{slug}/30-{slug}.pen` | [state board] | [adapter] | [references] | [note] |
| S3  | [screen]       | [goal]    | P1       | [route / flow]   | HTML companion concept translated into Pencil | `design/pencil/{slug}/30-{slug}.pen` | [comparison board] | [adapter] | [references] | [note] |
```

## Coverage rule

Include:

- the primary screen or entry point
- the most important completion screen or outcome state
- the most important supporting screen or dialog
- loading, empty, error, validation, and permission states when they matter

Do not create exhaustive paperwork for every trivial route. Focus on what shapes implementation.

## Source rule

- `Primary visual source` should be explicit:
  - `current UI`
  - `Pencil`
  - `current UI + Pencil`
  - `wireframe + Pencil`
  - `HTML companion concept translated into Pencil`
- The final packet should point to stable repo artifacts first.
- If an HTML companion artifact influenced a direction, record that influence in notes, but keep the converged Pencil board as the durable reference.
- The `Downstream adapter` column should match the packet and handoff.
