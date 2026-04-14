---
name: frontend-direction
description: Create or refresh a frontend direction packet before implementation when an approved or near-approved feature spec includes meaningful UI/UX work and the agent must turn product intent, wireframes, screenshots, design-system context, or Stitch outputs into explicit visual guidance. Use when producing `--frontend-direction.md`, `screen-index.md`, `stitch-prompt-pack.md`, selected screenshots, Stitch source manifests, per-screen Stitch IDs, full-resolution screenshot mirrors, HTML mirrors, or `.stitch/DESIGN.md` support for later implementation. In brownfield work, bootstrap or refresh `.stitch/DESIGN.md` first when the current design system is missing, stale, or not based on representative screens.
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

When Stitch is used, also write:

- `docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend/stitch-sources.json`
- `docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend/selected-direction/*.png` _(full-resolution mirrors, not 512px previews)_
- `docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend/selected-direction/*.html`
- `docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend/selected-direction/*.meta.json`

When available, also maintain:

- `docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend/screenshots/`
- `docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend/selected-direction/`
- `.stitch/DESIGN.md`
- `.stitch/BOOTSTRAP.md`

## Read order

1. Read `.stitch/BOOTSTRAP.md` when it exists.
2. Read `.stitch/DESIGN.md` when it exists.
3. Read `references/stitch-source-capture-workflow.md` whenever Stitch is involved.
4. Read `references/stitch-sources-manifest-template.json` when shaping the machine-usable source manifest.
5. Read `references/screen-index-template.md`.
6. Read `references/stitch-prompt-pack-template.md`.
7. Read `references/frontend-direction-template.md`.
8. Read `references/frontend-review-checklist.md` before finalizing.

## Workflow

1. Gather the approved or near-approved spec, durable wireframes, current screenshots, and design-system context.
2. Decide the design-truth source:
   - brownfield default: preserve and extend the current product language
   - redesign: only when explicitly intended
   - degraded mode: when richer design context is unavailable
3. Build the screen index for the key screens and key states only.
4. Capture or refresh design-system truth using `.stitch/DESIGN.md`.
   - In brownfield work, if `.stitch/DESIGN.md` is missing, stale, or based on non-representative screens, prefer `design-system-bootstrap` first.
   - Do not start screen generation from a weak or contradictory design baseline.
5. Prepare a self-contained prompt pack for Stitch or the equivalent design-generation workflow.
6. Generate or collect only the highest-signal references: usually 2–3 variants for the most important screen or decision axis.
7. Select the preferred directions and record why they won.
8. When Stitch is used, always capture machine-usable source references for each selected or retained screen:
   - `projectId`
   - `screenId`
   - full Stitch resource name
   - screen title
   - device type
   - width and height
   - local full-resolution screenshot mirror path
   - local HTML mirror path when available
   - local metadata JSON mirror path
   - reason selected and selection status
   - When the screenshot URL is on `lh3.googleusercontent.com`, append `=s0` before downloading the PNG mirror. The default MCP URL is typically a 512px-wide preview; `=s0` requests the original-resolution asset.
9. Write `stitch-sources.json` so later implementation and refinement agents can fetch the exact selected screens instead of relying on packet preview images.
10. In the packet summary and screen sections, include both the human-readable preview images and the machine-usable Stitch source metadata.
11. Review against the checklist until the packet is implementation-usable.

## Tooling preference

- Prefer direct Stitch MCP when available.
- Treat a plugin as optional packaging only.
- Do not make the workflow depend on a plugin.
- For large brownfield products, prefer a local `design-system-bootstrap` skill to create or refresh `.stitch/DESIGN.md` before generating new screens.
- If Stitch is unavailable, stay honest about degraded mode and still produce a usable packet from repo context, screenshots, and wireframes.

## Operating rules

- A markdown-embedded preview image is **not** the primary source when Stitch is used.
- Stitch screenshot URLs served from `lh3.googleusercontent.com` default to preview-sized images. Append `=s0` before mirroring them locally so `selected-direction/*.png` stores the original resolution instead of the 512px preview.
- The primary source order for selected Stitch-backed screens is:
  1. live Stitch screen by `projectId` + `screenId`
  2. local HTML mirror
  3. local full-resolution screenshot mirror
  4. embedded markdown preview image
- Persist local mirrors even when live Stitch retrieval works.
- Treat Stitch HTML as reference evidence, not implementation code.
- If exact screen IDs, HTML mirrors, or dimensions cannot be fetched, record that gap explicitly in the packet instead of pretending the preview image is sufficient.

## Quality bar

A strong result:

- makes the intended visual direction obvious
- covers the main screens and key states
- preserves or intentionally updates the current design system
- gives implementation agents enough direction to build without inventing the UI from scratch
- gives implementation and refinement agents enough source metadata to fetch or mirror exact Stitch screens later
- stays consistent with the product spec and handoff
