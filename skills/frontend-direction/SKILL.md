---
name: frontend-direction
description: Create or refresh a frontend direction packet before implementation when an approved or near-approved feature spec includes meaningful UI/UX work and the agent must turn product intent, wireframes, screenshots, design-system context, or Stitch outputs into explicit visual guidance. Use when producing `--frontend-direction.md`, `screen-index.md`, `stitch-prompt-pack.md`, selected screenshots, or `.stitch/DESIGN.md` support for later implementation. In brownfield work, bootstrap or refresh `.stitch/DESIGN.md` first when the current design system is missing, stale, or not based on representative screens.
---

# Frontend Direction

Create explicit visual direction before production frontend code is written.

This skill is for the design-direction step between product discovery and implementation. It produces the packet and reference assets that later implementation agents should follow.

Do **not** use this skill as a frontend coding skill.

## Outputs

Write:

- `docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend-direction.md`
- `docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend/screen-index.md`
- `docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend/stitch-prompt-pack.md`

When available, also write:

- `docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend/screenshots/`
- `docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend/selected-direction/`
- `.stitch/DESIGN.md`

## Read order

1. Read `references/screen-index-template.md`.
2. Read `references/stitch-prompt-pack-template.md`.
3. Read `references/frontend-direction-template.md`.
4. Read `references/frontend-review-checklist.md` before finalizing.

## Workflow

1. Gather the approved or near-approved spec, durable wireframes, current screenshots, and design-system context.
2. Decide the design-truth source:
   - brownfield default: preserve and extend the existing product language
   - redesign: only when explicitly intended
   - degraded mode: when richer design context is unavailable
3. Build the screen index for the key screens and key states only.
4. Capture or refresh design-system truth using `.stitch/DESIGN.md`.
   - In brownfield work, if `.stitch/DESIGN.md` is missing, stale, or based on non-representative screens, prefer `design-system-bootstrap` first.
   - Do not start screen generation from a weak or contradictory design baseline.
5. Prepare a self-contained prompt pack for Stitch or the equivalent design-generation workflow.
6. Generate or collect only the highest-signal references: usually 2–3 variants for the most important screen or decision axis.
7. Select a direction, record why it won, and record what remains flexible.
8. Write the packet so implementation agents know what must be preserved, what may adapt, and what to avoid.
9. Review against the checklist until the packet is implementation-usable.

## Tooling preference

- Prefer direct Stitch MCP when available.
- Treat a plugin as optional packaging only.
- Do not make the workflow depend on a plugin.
- For large brownfield products, prefer a local `design-system-bootstrap` skill to create or refresh `.stitch/DESIGN.md` before generating new screens.
- If Stitch is unavailable, stay honest about degraded mode and still produce a usable packet from repo context, screenshots, and wireframes.

## Quality bar

A strong result:

- makes the intended visual direction obvious
- covers the main screens and key states
- preserves or intentionally updates the current design system
- gives implementation agents enough direction to build without inventing the UI from scratch
- stays consistent with the product spec and handoff
