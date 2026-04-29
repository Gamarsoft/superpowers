---
name: gsd-frontend-design
description: Use when implementing frontend work from an approved spec or packet, especially when approved ChatGPT Images 2 references, `.pen` files, brownfield preservation rules, or stack-specific design evidence must guide code changes.
---

# Frontend Design

Implement UI from the strongest available design truth.

## Visual-truth mode

Before planning or coding, read the frontend direction packet and determine its declared implementation visual-truth source:

- `chatgpt-image-2`: approved generated image files in the packet folder are the binding visual-truth references. Omit Pencil for that scope; do not load Pencil skills or ask for Pencil boards.
- `pencil`: approved Pencil boards and workset files are the binding visual-truth references. Use Pencil CLI interactive mode and the relevant Pencil skills.
- `current-ui/degraded`: no generated image or Pencil visual truth is approved. Preserve current product UI and record degraded mode.

Functional requirements still come from the spec, handoff, acceptance criteria, and current product behavior. The visual-truth mode controls which visual references may bind implementation.

## Source-of-truth order

Read `references/source-of-truth.md` first.

Use this precedence order:

1. Approved spec, handoff, and acceptance criteria
2. Existing product UI and design system for brownfield work
3. Approved frontend direction packet
4. The packet's declared implementation visual-truth source
5. Approved ChatGPT Images 2 generated image files when `chatgpt-image-2` is selected
6. `pencil-workset.md` and relevant `.pen` files when `pencil` is selected
7. `brownfield-ui-extraction.md` and `screen-index.md`
8. Retained screenshots, browser captures, or Pencil exports that the packet treats as binding evidence
9. Project-level `PRODUCT.md` and current `DESIGN.md` when present
10. Existing component library, tokens, and app-shell conventions
11. The implementation-quality reference files in this skill
12. Freeform invention only for genuinely unspecified gaps

## Skill composition

When the packet selects `chatgpt-image-2` visual truth:

- do not load `pencil-design-core`
- do not load a Pencil stack adapter
- do not require `pencil-workset.md` or `.pen` files
- use the approved generated image files as binding visual screenshots

When the packet selects `pencil` or Pencil-backed sources are in scope:

- load `pencil-design-core`
- load the correct stack adapter for the implementation target
  - `pencil-design-angular-nebular` for Angular + Nebular / similar brownfield operator UIs
  - `pencil-design-react-tailwind` only when the actual target stack is React / Next / Tailwind / shadcn
- use Pencil CLI interactive mode as the only allowed Pencil transport in GSD workflows

Read `references/pencil-skills-integration.md` before implementation when `.pen` files are in scope.

## Workflow

1. Locate the current spec, frontend direction packet, `brownfield-ui-extraction.md`, `screen-index.md`, retained screenshots, existing component patterns, and any project-level `PRODUCT.md` or `DESIGN.md`.
   - If the packet selects `chatgpt-image-2`, locate the approved generated image files and do not require Pencil artifacts.
   - If the packet selects `pencil`, locate `pencil-workset.md` and the relevant `.pen` files.
2. Extract **Must preserve**, **May adapt**, and **Explicit no-gos** before touching code.
   - If the packet distinguishes `observed current truth`, `conservative normalization target`, and `approved change`, carry those boundaries into implementation.
3. Determine the implementation visual-truth source from the packet.
   - If it is `chatgpt-image-2`, read the approved generated image files before editing application code, build an image-parity checklist, and skip Pencil-specific workflow steps.
   - If it is `pencil`, continue with Pencil-backed source consumption.
   - If it is missing or approval is pending, ask for confirmation before visual changes.
4. If the visual-truth source is `pencil`, load `pencil-design-core` and use Pencil CLI interactive mode before touching app code:
   - use Pencil CLI interactive mode for inspection, export, and modification
   - for CLI interactive edits, prefer a distinct output path rather than in-place save-back to the same `.pen` file
5. Open the approved visual references before editing application code:
   - for `chatgpt-image-2`: the approved generated image files saved beside matching prompts
   - for `pencil`: the relevant `.pen` files and retained screenshots
6. Load the correct stack adapter only when Pencil is selected.
7. Build a **visual implementation contract** before editing application code:
   - read the approved intent for each named image, board, or screenshot
   - use `visual-truth` when the image or board is binding for visual treatment and needs parity verification
   - use `semantic-guidance` when the image or board demonstrates behavior, layout intent, content priority, or workflow while allowing product-system adaptation
   - use `reference-only` when the image or board is inspiration, exploration, or a comparison aid
   - if intent is missing or pending, propose a classification and ask for confirmation before visual changes
   - if confirmation is unavailable, do not treat the reference as visual truth; implement only behavior clearly required by the spec and record degraded mode or a blocker
   - for `visual-truth`, extract the visible deltas the implementation must carry: surfaces, background containers, control emphasis, primary/secondary action hierarchy, spacing rhythm, typography emphasis, section backgrounds, and mobile flow
   - for `semantic-guidance`, extract required behavior, information hierarchy, state coverage, workflow, and adaptation boundaries
   - separate functional acceptance from visual acceptance
   - for Angular/Nebular work, name any Nebular defaults that must be neutralized or restyled to match `visual-truth` images or boards
8. Inspect the existing codebase and reuse its components, tokens, spacing system, interaction patterns, and shell conventions unless the packet explicitly changes them.
9. Implement the required screens, states, and responsive behavior.
   - Brownfield preservation means preserve shell, behavior, contracts, and product family.
   - It does not mean preserving flawed local styling that the approved packet explicitly changes.
   - When a `visual-truth` image or board changes a local surface, control treatment, spacing, or action priority, implement that visual delta with the repo’s primitives and scoped styles.
   - When a `semantic-guidance` image or board demonstrates a capability, implement the capability and intent without unnecessary visual redesign.
10. Use the reference files in `references/` as fallback heuristics and quality checks, not as permission to redesign the product.
   - treat `PRODUCT.md` as audience/register context and `DESIGN.md` as system documentation, not as permission to outrank the packet or brownfield baseline
11. If the packet or selected visual-truth source is incomplete, fill gaps conservatively and keep new invention tightly bounded.
   - If the current screen baseline is incomplete, prefer the retained browser evidence and current product behavior over code-only visual inference.
12. If you must deviate from the packet, approved images, `.pen` files, or existing system, make the deviation explicit and explain why.
13. Read `references/pencil-source-consumption.md` when Pencil-backed sources exist.
14. Read `references/implementation-review-checklist.md` before considering the work done.
15. Do not report completion for image-backed or Pencil-backed UI work until the approved reference-intent checklist is complete.
   - Completion is allowed with visual mismatches only by explicit waiver: list the mismatch, source image or board, implementation constraint, accepted fallback, and follow-up owner.

## Reference loading guide

- Read `references/source-of-truth.md` for precedence and conflict handling.
- Read `references/implementation-modes.md` to decide whether this task is preserve, adapt, normalize, or controlled divergence.
- Read `references/chatgpt-image-source-consumption.md` when the packet declares `chatgpt-image-2` as the implementation visual-truth source.
- Read `references/pencil-skills-integration.md` to decide which Pencil skills to compose only when Pencil is selected.
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
- Treat the frontend direction packet and its selected visual-truth source as primary intent, not optional inspiration.
- When `chatgpt-image-2` is selected, approved generated image files are implementation evidence, not generated production code; no Pencil workset is required for that scope.
- When `pencil` is selected, treat `.pen` files and retained screenshots as implementation evidence, not as generated production code.
- Images and Pencil boards do not all mean the same thing. Use approved reference intent before implementation:
  - `visual-truth` images or boards bind visual hierarchy, surface treatment, control emphasis, spacing rhythm, and primary/secondary action priority.
  - `semantic-guidance` images or boards bind capability, workflow, content priority, and state coverage while allowing product-system visual adaptation.
  - `reference-only` images or boards are not acceptance targets unless promoted by the packet or human.
- If intent is unclear, ask for approval before visual changes. Do not silently infer whether an image or board is a redesign target or visual parity target.
- Treat HTML visual-companion artifacts as temporary comparison aids only; once a direction is translated into the selected visual-truth source and packet prose, those durable artifacts win.
- Do not let a stack adapter overrule the packet or the current product system.
- Do not replace an explicit visual direction with a new aesthetic thesis unless the human explicitly asks for redesign.
- Do not use the reference files to overrule product constraints, accessibility constraints, framework constraints, or existing design-system rules.
- When no packet or approved visual-truth source exists, say so and operate in degraded mode rather than pretending the direction is settled.
- Do not translate generic React, Tailwind, or design-tool output directly into production Angular or Nebular code without adapting it to the repo’s real primitives.
- Do not use Pencil MCP in GSD workflows.
- In GSD-2 or other headless contexts, do not treat a small `.pen` text edit as a reason to bypass Pencil CLI when Pencil is selected and CLI is available.
- If CLI interactive persistence fails, say that interactive mode failed and why. Only fall back to direct text editing in explicit degraded mode.
- Do not use Pencil CLI agent mode in this workflow.

## Quality bar

A strong result:

- matches the approved direction and existing system where required
- covers the main states and responsive behavior
- preserves the current shell and component language unless change is explicitly approved
- carries `visual-truth` deltas through the real stack and treats `semantic-guidance` images or boards as behavior/workflow evidence, not automatic redesign targets
- improves accessibility and implementation quality without drifting into redesign
- records the exact selected visual-truth source, approved images or `.pen` files, screenshots, reference intent modes, Pencil CLI usage only when Pencil was selected, reference-intent checks, and any waived mismatches used for later verification
