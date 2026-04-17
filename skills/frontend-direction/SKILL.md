---
name: frontend-direction
description: Use after product direction is stable to create the frontend direction packet, the supporting frontend folder, and the repo-local Pencil workset that downstream GSD/Codex implementation should follow.
---

# Frontend Direction

Create explicit visual direction before production frontend code is written.

This skill is for the design-direction step between product discovery and implementation. It produces the packet and reference assets that later implementation agents should follow.
For downstream GSD workflows, assume Pencil CLI interactive mode is the only allowed Pencil transport.

Do **not** use this skill as a frontend coding skill.

## Outputs

Write:

- `docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend-direction.md`
- `docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend/screen-index.md`
- `docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend/brownfield-ui-extraction.md` _(brownfield default)_
- `docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend/pencil-workset.md`

When you generated or gathered reference imagery, also write:

- `docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend/screenshots/`

When Pencil is available, also maintain:

- `design/pencil/_shared/00-foundations.pen`
- `design/pencil/_shared/10-shell.pen`
- `design/pencil/_shared/20-patterns.pen`
- `design/pencil/{slug}/30-{slug}.pen`

## Read order

1. Read `references/design-source-priority.md`.
2. Read `references/pencil-skill-selection.md`.
3. Read `references/frontend-packet-folder-template.md`.
4. Read `references/brownfield-ui-extraction-template.md` when the work is brownfield.
5. Read `references/screen-index-template.md`.
6. Read `references/pencil-workset-template.md`.
7. Read `references/frontend-direction-template.md`.
8. Read `references/frontend-review-checklist.md`.
9. Read `references/frontend-packet-completeness-checklist.md` before finalizing.

## Workflow

1. Gather the approved or near-approved spec, durable wireframes, current screenshots, and design-system context.
2. Decide the design-truth source:
   - brownfield default: preserve and extend the current product language
   - redesign: only when explicitly intended
   - degraded mode: when richer design context is unavailable
3. Choose the downstream stack adapter via `references/pencil-skill-selection.md`.
4. In brownfield work, create `brownfield-ui-extraction.md` before asking for visual variants.
5. Build the screen index for the key screens and key states only.
6. Create or refresh the Pencil workset:
   - foundations
   - shell
   - shared patterns
   - feature-specific boards
7. In Pencil, use `pencil-design-core` plus the chosen adapter to:
   - recreate the current structure first
   - keep the workset faithful to the target stack
   - generate or edit only 1–2 bounded variants for the real decision axis
8. Select the preferred directions and record why they won.
9. Use the HTML visual companion only for temporary comparison artifacts when a choice is materially easier to judge in-browser than in prose.
10. If an HTML companion artifact influenced a choice, translate the chosen concept back into Pencil boards, screenshots, and packet prose before treating it as durable direction.
11. Expand the implementation contract:

- responsive behavior
- interaction cues
- state coverage
- accessibility constraints
- must preserve vs may adapt
- explicit no-gos
- downstream skills and adapter to load

12. Review against the checklist until the packet is implementation-usable.

## Tooling preference

- Prefer Pencil.
- Prefer repo-local `.pen` files.
- For downstream GSD workflows, plan around Pencil CLI interactive mode only.
- Do not require or recommend Pencil MCP in GSD-facing packet guidance.
- Treat a Copilot/Codex + Pencil workflow as the default operating model.
- If Pencil is unavailable, stay honest about degraded mode and still produce a usable packet from repo context, screenshots, and wireframes.

## Operating rules

- Current product truth outranks generated imagery in brownfield work.
- HTML companion screens are temporary decision artifacts, not durable packet artifacts.
- The packet should point to stable repo artifacts first:
  - `brownfield-ui-extraction.md`
  - `screen-index.md`
  - `pencil-workset.md`
  - repo-local `.pen` files
  - screenshots
- Record the exact Pencil skills downstream agents should load.
- Record that Pencil CLI interactive mode is the intended downstream transport when it matters for reproducibility.
- Treat generated code from design tools as reference evidence, not production-ready output for legacy Angular stacks.
- If exact visual direction cannot be stabilized, record the gap explicitly instead of pretending the packet is complete.

## Quality bar

A strong result:

- makes the intended visual direction obvious
- covers the main screens and key states
- preserves or intentionally updates the current design system
- gives implementation agents enough direction to build without inventing the UI from scratch
- tells downstream agents which `.pen` files, board names, screenshots, and Pencil skills to use
- stays consistent with the product spec and handoff
