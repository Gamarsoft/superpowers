---
name: frontend-direction
description: Use after product direction is stable but visual direction is not, especially when brownfield UI work needs a durable frontend contract, screen inventory, or repo-local Pencil workset before implementation.
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
2. Read `references/use-cases-prompts-and-flows.md` when you need a concrete scenario flow or prompt shape.
3. Read `references/pencil-skill-selection.md`.
4. Read `references/browser-surface-selection.md` when browser interaction is needed.
5. Read `references/impeccable-brownfield-quality-layer.md` when brownfield quality refinement is in scope.
6. Read `references/frontend-packet-folder-template.md`.
7. Read `references/brownfield-ui-extraction-template.md` when the work is brownfield.
8. Read `references/screen-index-template.md`.
9. Read `references/pencil-workset-template.md`.
10. Read `references/frontend-direction-template.md`.
11. Read `references/frontend-review-checklist.md`.
12. Read `references/frontend-packet-completeness-checklist.md` before finalizing.

## Workflow

1. Gather the approved or near-approved spec, durable wireframes, current screenshots, and design-system context.
2. In brownfield work, decide whether a runtime baseline capture pass is required:
   - read `references/browser-surface-selection.md` before browser interaction
   - if the current screen truth exists only in source code and the running app, capture browser-grounded evidence before inventing any packet artifacts
   - gather desktop and narrow/mobile screenshots for the current screen
   - gather key states for the changed area: loading, empty, validation/error, disabled/permission when relevant
   - capture focused close-ups for high-risk regions and record short notes on hierarchy, spacing, density, and action placement
   - use the running app as the layout truth; use source code as support, not as the only visual source
3. Decide the design-truth source:
   - brownfield default: preserve and extend the current product language
   - redesign: only when explicitly intended
   - degraded mode: when richer design context is unavailable
4. Choose the downstream stack adapter via `references/pencil-skill-selection.md`.
5. In brownfield work, create `brownfield-ui-extraction.md` before asking for visual variants.
   - separate `observed current truth`, `conservative normalization target`, and `optional exploration`
   - for existing-screen work with no prior durable evidence, the first packet job is faithful reproduction, not improvement
6. Build the screen index for the key screens and key states only.
7. Create or refresh the Pencil workset:
   - foundations
   - shell
   - shared patterns
   - feature-specific boards
8. In Pencil, use `pencil-design-core` plus the chosen adapter to:
   - recreate the current structure first
   - keep the workset faithful to the target stack
   - generate or edit only 1–2 bounded variants for the real decision axis
9. If UI/UX quality work is needed beyond faithful reproduction, run it as a bounded layer on top of the baseline:
   - read `references/impeccable-brownfield-quality-layer.md`
   - if a project-level `.impeccable.md` already exists, do not re-run `impeccable teach`
   - use `impeccable extract`, `critique`, and `audit` after the baseline exists, not before
   - treat Impeccable findings as refinement input, not as permission to outrank brownfield truth
10. Select the preferred directions and record why they won.
11. Use the HTML visual companion only for temporary comparison artifacts when a choice is materially easier to judge in-browser than in prose.
12. If an HTML companion artifact influenced a choice, translate the chosen concept back into Pencil boards, screenshots, and packet prose before treating it as durable direction.
13. Expand the implementation contract:

- responsive behavior
- interaction cues
- state coverage
- accessibility constraints
- must preserve vs may adapt
- explicit no-gos
- downstream skills and adapter to load

14. Review against the checklist until the packet is implementation-usable.

## Tooling preference

- Prefer Pencil.
- Prefer repo-local `.pen` files.
- For downstream GSD workflows, plan around Pencil CLI interactive mode only.
- Do not require or recommend Pencil MCP in GSD-facing packet guidance.
- Treat a Copilot/Codex + Pencil workflow as the default operating model.
- If Pencil is unavailable, stay honest about degraded mode and still produce a usable packet from repo context, screenshots, and wireframes.

## Operating rules

- Current product truth outranks generated imagery in brownfield work.
- When no durable baseline exists, create one from browser-grounded evidence before you explore improvements.
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
