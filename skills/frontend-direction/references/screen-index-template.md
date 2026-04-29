# Screen Index Template

Use this file to keep screen coverage explicit.

Default file:
`docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend/screen-index.md`

## Template

```markdown
# Screen Index

| ID  | Screen / State | User goal | Priority | Source / trigger | Primary visual source | ChatGPT Images 2 file | Pencil file | Board / frame | Reference intent | Intent approval | Downstream adapter | Key references | Notes |
| --- | -------------- | --------- | -------- | ---------------- | --------------------- | -------------------- | ----------- | ------------- | ---------------- | --------------- | ------------------ | -------------- | ----- |
| S1  | [screen]       | [goal]    | P0       | [route / flow]   | current UI + approved ChatGPT Images 2 | `./chatgpt-image-2/01-screen.png` | not used | not used | visual-truth / semantic-guidance / reference-only | approved / pending | none / [adapter] | [screenshots / spec] | [note] |
| S2  | [state]        | [goal]    | P0       | [loading / error / validation] | Pencil | not used | `design/pencil/{slug}/30-{slug}.pen` | [state board] | visual-truth / semantic-guidance | approved / pending | [adapter] | [references] | [note] |
| S3  | [screen]       | [goal]    | P1       | [route / flow]   | HTML companion concept translated into approved visual-truth source | [image path or not used] | [Pencil path or not used] | [board/frame or not used] | reference-only / semantic-guidance | approved / pending | none / [adapter] | [references] | [note] |
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
  - `approved ChatGPT Images 2`
  - `current UI + approved ChatGPT Images 2`
  - `Pencil`
  - `current UI + Pencil`
  - `wireframe + Pencil`
  - `HTML companion concept translated into approved visual-truth source`
- The final packet should point to stable repo artifacts first.
- If an HTML companion artifact influenced a direction, record that influence in notes, but keep the converged approved image or Pencil board as the durable reference.
- The `Downstream adapter` column should match the packet and handoff; use `none` when ChatGPT Images 2 is the visual-truth source and no Pencil adapter should be loaded.
- The `Reference intent` column must be approved before implementation. If approval is pending, the implementation agent must ask before treating a board or image as visual truth.
