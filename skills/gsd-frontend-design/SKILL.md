---
name: gsd-frontend-design
description: Use when frontend work researches, plans, implements, verifies, or refines user-facing UI, UX, browser behavior, visual evidence, approved packets, images, or `.pen` sources.
---

# Frontend Design

Implement UI from the strongest available design truth.

## Visual-truth mode

Before planning or coding, read the frontend direction packet and determine its declared implementation visual-truth source:

- `chatgpt-image-2`: approved generated image files in the packet folder are the binding visual-truth references. Omit Pencil for that scope; do not load Pencil skills or ask for Pencil boards.
- `pencil`: approved Pencil boards and workset files are the binding visual-truth references. Use Pencil CLI interactive mode and the relevant Pencil skills.
- `current-ui/degraded`: no generated image or Pencil visual truth is approved. Preserve current product UI and record degraded mode.

Functional requirements still come from the spec, handoff, acceptance criteria, and current product behavior. The visual-truth mode controls which visual references may bind implementation.

If a handoff, `CONTEXT.md`, or equivalent workflow artifact says frontend packet status is `required` and no approved packet exists, stop frontend planning or implementation. Run the referenced frontend-direction follow-on prompt first; do not treat this as degraded-mode permission to invent UI.

## Source-of-truth order

Read `references/source-of-truth.md` first.

Use this precedence order:

1. Approved spec, handoff, and acceptance criteria
2. Existing product UI and design system for brownfield work
3. Relevant workflow context such as milestone or slice `CONTEXT.md`, especially `Frontend References` when present
4. Approved frontend direction packet
5. The packet's declared implementation visual-truth source
6. Approved ChatGPT Images 2 generated image files when `chatgpt-image-2` is selected
7. `pencil-workset.md` and relevant `.pen` files when `pencil` is selected
8. `brownfield-ui-extraction.md` and `screen-index.md`
9. Retained screenshots, browser captures, or Pencil exports that the packet treats as binding evidence
10. Project-level `PRODUCT.md` and current `DESIGN.md` when present
11. Existing component library, tokens, and app-shell conventions
12. The implementation-quality reference files in this skill
13. Freeform invention only for genuinely unspecified gaps

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
- use Pencil CLI interactive mode as the only allowed Pencil transport in GSD workflows; outside GSD, follow the active workflow's Pencil transport policy

Read `references/pencil-skills-integration.md` before implementation when `.pen` files are in scope.

## Workflow

1. Locate the current spec, handoff, acceptance criteria, relevant workflow context such as milestone or slice `CONTEXT.md` when present, frontend direction packet, `brownfield-ui-extraction.md`, `screen-index.md`, retained screenshots, existing component patterns, and any project-level `PRODUCT.md` or `DESIGN.md`.
   - If the handoff, `CONTEXT.md`, or equivalent workflow artifact says packet status is `required` and no approved packet exists, stop and run the frontend-direction follow-on prompt before planning or implementing UI.
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
12. If live runtime data cannot produce every required visual state on demand, use visual fixture mode for state coverage.
   - Keep live mode for integration proof: auth, routing, feature flags, tenant context, real API composition, persistence, and service wiring.
   - Use fixture mode for visual proof: hard-to-reach states, responsive behavior, copy, action hierarchy, and reference-intent parity.
   - Prefer browser/e2e network fixtures or a local mock proxy that intercepts selected API responses while the frontend runs normally.
   - Keep fixtures contract-shaped, using the same DTO/API shape as the real service; do not invent UI-only blobs.
   - Label fixture evidence as fixture evidence in UAT, summaries, and visual review artifacts. Do not present fixture evidence as live integration proof.
   - Avoid app-level fixture switches. If unavoidable, guard them to dev/test builds, make the UI visibly marked as fixture data, disable real writes, and prove they cannot activate in production config.
13. If you must deviate from the packet, approved images, `.pen` files, or existing system, make the deviation explicit and explain why.
14. Read `references/pencil-source-consumption.md` when Pencil-backed sources exist.
15. Read `references/implementation-review-checklist.md` before considering the work done.
16. Run a fresh-context visual quality review before considering non-trivial UI work done.
   - Do not rely on implementer self-review as the final visual gate for non-trivial UI work.
   - In GSD-2, after implementation and browser/reference verification, spawn a fresh `worker` subagent reviewer.
   - Tell the reviewer to load Impeccable, apply `$impeccable critique` and `$impeccable audit` as applicable, inspect the approved packet, visual-truth sources, reference-intent checklist, and runtime evidence, then write one review artifact: `.gsd/{milestoneId}/slices/{sliceId}/tasks/{taskId}-VISUAL-REVIEW.md` or `.gsd/{milestoneId}/slices/{sliceId}/VISUAL-REVIEW.md`.
   - The artifact should name the target, evidence inspected, checks applied, findings by severity, `Verdict: APPROVE | REQUEST_CHANGES | ESCALATE`, and `Review Decision: no_action | remediate_and_rereview | escalate_replan`.
   - In GSD-2 implementation-end review, the visual review pass is evidence collection. If a paired review-and-resolve task exists, unresolved blocking or important visual findings belong there unless they prevent basic verification from running.
   - Outside GSD-2, use the active workflow's equivalent fresh-context reviewer, or record why fresh-context review was unavailable.
   - The reviewer reports blocking, important, and minor visual findings; it does not rewrite the UI.
   - Treat Impeccable findings as review evidence and refinement input, not as authority to override the approved packet, visual-truth source, or brownfield baseline.
   - If Impeccable cannot run or its preflight gates cannot pass, record why and use the implementation review checklist plus browser evidence as the fallback.
17. Do not report completion for image-backed or Pencil-backed UI work until runtime browser evidence and the approved reference-intent checklist are complete.
   - Completion is allowed with visual mismatches only by explicit waiver: list the mismatch, source image or board, implementation constraint, accepted fallback, and follow-up owner.
   - Runtime screenshots, traces, console logs, and network dumps are verification inputs, not default commit artifacts.
   - Persist raw browser evidence only when needed for review or replay, and place it under `/tmp`, another temporary directory, an ignored local path, or an external redaction-safe artifact location unless the task explicitly says to commit those files.
18. Record the frontend sources, visual review findings, and proof in the relevant task, slice, or implementation summary. Keep `Frontend References` in `CONTEXT.md` current when those workflow artifacts are in scope.

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
- Do not use Impeccable critique or audit findings to silently redesign approved work. Turn findings into bounded fixes or explicit follow-up questions.
- Do not treat fixture visual-state proof as live integration proof.
- Do not commit raw runtime evidence directories unless the task or human explicitly says those files are commit artifacts.
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
- includes visual review evidence from Impeccable critique/audit when available, or a recorded fallback when unavailable
- distinguishes live runtime proof from fixture visual-state proof when fixtures are used
- improves accessibility and implementation quality without drifting into redesign
- records the exact selected visual-truth source, approved images or `.pen` files, screenshots, reference intent modes, Pencil CLI usage only when Pencil was selected, reference-intent checks, and any waived mismatches used for later verification
