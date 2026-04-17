---
name: gsd-frontend-design
description: Implement UI from packet, Pencil worksets, repo design truth, and the correct stack adapter. Preserve what is fixed, adapt only where approved, and use Pencil CLI interactive mode only for `.pen` work in GSD workflows.
---

# Frontend Design

Implement UI from the strongest available design truth.

## Source-of-truth order

Read `references/source-of-truth.md` first.

Use this precedence order:

1. Approved spec, handoff, and acceptance criteria
2. Existing product UI and design system for brownfield work
3. Approved frontend direction packet
4. `pencil-workset.md`, `brownfield-ui-extraction.md`, and `screen-index.md`
5. Relevant `.pen` files in `design/pencil/` or packet-linked paths
6. Retained screenshots, browser captures, or Pencil exports that the packet treats as binding evidence
7. Existing component library, tokens, and app-shell conventions
8. The implementation-quality reference files in this skill
9. Freeform invention only for genuinely unspecified gaps

## Skill composition

When Pencil-backed sources exist:

- load `pencil-design-core`
- load the correct stack adapter for the implementation target
  - `pencil-design-angular-nebular` for Angular + Nebular / similar brownfield operator UIs
  - `pencil-design-react-tailwind` only when the actual target stack is React / Next / Tailwind / shadcn
- use Pencil CLI interactive mode as the only allowed Pencil transport in GSD workflows

Read `references/pencil-skills-integration.md` before implementation when `.pen` files are in scope.

## Workflow

1. Locate the current spec, frontend direction packet, `pencil-workset.md`, `brownfield-ui-extraction.md`, `screen-index.md`, the relevant `.pen` files, retained screenshots, and existing component patterns.
2. Extract **Must preserve**, **May adapt**, and **Explicit no-gos** before touching code.
3. If Pencil artifacts exist, load `pencil-design-core` and use Pencil CLI interactive mode before touching app code:
   - use Pencil CLI interactive mode for inspection, export, and modification
   - for CLI interactive edits, prefer a distinct output path rather than in-place save-back to the same `.pen` file
4. Open the relevant `.pen` files and retained screenshots before editing application code.
5. Load the correct stack adapter for the implementation target.
6. Inspect the existing codebase and reuse its components, tokens, spacing system, interaction patterns, and shell conventions unless the packet explicitly changes them.
7. Implement the required screens, states, and responsive behavior.
8. Use the reference files in `references/` as fallback heuristics and quality checks, not as permission to redesign the product.
9. If the packet or workset is incomplete, fill gaps conservatively and keep new invention tightly bounded.
10. If you must deviate from the packet, `.pen` files, or existing system, make the deviation explicit and explain why.
11. Read `references/pencil-source-consumption.md` when Pencil-backed sources exist.
12. Read `references/implementation-review-checklist.md` before considering the work done.

## Reference loading guide

- Read `references/source-of-truth.md` for precedence and conflict handling.
- Read `references/implementation-modes.md` to decide whether this task is preserve, adapt, normalize, or controlled divergence.
- Read `references/pencil-skills-integration.md` to decide which Pencil skills to compose.
- Read `references/pencil-source-consumption.md` when the packet includes machine-usable Pencil worksets or `.pen` files.
- Read `references/typography.md` for type hierarchy, data density, numeric treatment, and conservative extension of the current scale.
- Read `references/color-and-contrast.md` for token alignment, semantic color roles, contrast, and normalization of hard-coded colors.
- Read `references/spatial-design.md` for layout rhythm, card structure, density, and shell preservation.
- Read `references/interaction-design.md` for states, forms, overlays, error handling, and accessibility-sensitive controls.
- Read `references/motion-design.md` for transition restraint and framework-safe motion usage.
- Read `references/responsive-design.md` for desktop continuity and mobile adaptation.
- Read `references/ux-writing.md` for action labels, errors, empty states, confirmations, and terminology consistency.

## Guardrails

- Default to preservation in brownfield projects.
- Treat the frontend direction packet and approved Pencil worksets as primary intent, not optional inspiration.
- Treat `.pen` files and retained screenshots as implementation evidence, not as generated production code.
- Treat HTML visual-companion artifacts as temporary comparison aids only; once a direction is translated into `.pen` files and packet prose, those durable artifacts win.
- Do not let a stack adapter overrule the packet or the current product system.
- Do not replace an explicit visual direction with a new aesthetic thesis unless the human explicitly asks for redesign.
- Do not use the reference files to overrule product constraints, accessibility constraints, framework constraints, or existing design-system rules.
- When no packet or workset exists, say so and operate in degraded mode rather than pretending the direction is settled.
- Do not translate generic React, Tailwind, or design-tool output directly into production Angular or Nebular code without adapting it to the repo’s real primitives.
- Do not use Pencil MCP in GSD workflows.
- In GSD-2 or other headless contexts, do not treat a small `.pen` text edit as a reason to bypass Pencil CLI when CLI is available.
- If CLI interactive persistence fails, say that interactive mode failed and why. Only fall back to direct text editing in explicit degraded mode.
- Do not use Pencil CLI agent mode in this workflow.

## Quality bar

A strong result:

- matches the approved direction and existing system where required
- covers the main states and responsive behavior
- preserves the current shell and component language unless change is explicitly approved
- improves accessibility and implementation quality without drifting into redesign
- records the exact `.pen` files, screenshots, Pencil CLI usage, and Pencil skills used for later verification
