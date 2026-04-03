---
name: gsd-frontend-design
description: Implement or refine production frontend UI from an approved spec, frontend direction packet, selected Stitch references, DESIGN.md context, and existing product patterns. Use when writing or revising pages, screens, components, flows, responsive states, or UI polish and the goal is to faithfully realize an explicit visual direction instead of inventing one from scratch.
---

# Frontend Design

Implement UI from the strongest available design truth.

## Source-of-truth order

Read `references/source-of-truth.md` first.

Use this precedence order:

1. Existing product UI and design system for brownfield work
2. Frontend direction packet
3. `.stitch/DESIGN.md`
4. Selected Stitch screenshots or chosen variants
5. Existing component library, tokens, and app-shell conventions
6. The design-quality reference files in this skill
7. Freeform invention only for genuinely unspecified gaps

## Workflow

1. Locate the current spec, frontend direction packet, screen index, selected screenshots, `.stitch/DESIGN.md`, and existing component patterns.
2. Extract **Must preserve**, **May adapt**, and **Explicit no-gos** before touching code.
3. Inspect the existing codebase and reuse its components, tokens, spacing system, and interaction patterns unless the packet explicitly changes them.
4. Implement the required screens, states, and responsive behavior.
5. Use the reference files in `references/` as fallback heuristics and quality checks, not as permission to redesign the product.
6. If the packet is incomplete, fill gaps conservatively and keep new invention tightly bounded.
7. If you must deviate from the packet or existing system, make the deviation explicit and explain why.
8. Read `references/implementation-review-checklist.md` before considering the work done.

## Reference loading guide

- Read `references/typography.md` for type hierarchy, font choices, measure, and numeric features.
- Read `references/color-and-contrast.md` for palette roles, tokens, contrast, and theme handling.
- Read `references/spatial-design.md` for layout rhythm, composition, and density.
- Read `references/interaction-design.md` for states, forms, overlays, and accessibility-sensitive controls.
- Read `references/motion-design.md` for transitions and restraint.
- Read `references/responsive-design.md` for viewport behavior.
- Read `references/ux-writing.md` for action labels, errors, empty states, and confirmation copy.

## Guardrails

- Default to preservation in brownfield projects.
- Treat the frontend direction packet as primary intent, not optional inspiration.
- Do not replace an explicit visual direction with a new aesthetic thesis unless the user explicitly asks for redesign.
- Do not use the reference files to overrule product constraints, accessibility constraints, or existing design-system rules.
- When no packet exists, say so and operate in degraded mode rather than pretending the direction is settled.

## Quality bar

A strong result:

- matches the chosen direction and existing system where required
- covers the main states and responsive behavior
- avoids generic defaults without drifting off-brief
- is accessible, implementation-ready, and visually coherent
