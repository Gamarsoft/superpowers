# Visual Exploration

Read when choosing how to explore, comparing alternatives or refining the interactive target.

## Choose the first artifact

| Unresolved question | First artifact |
| --- | --- |
| Substantial hierarchy, density, typography or screen composition | Rough sketches or [Paper](paper-workflow.md) structures comparing the unresolved composition choices, using actual content and established anchors. |
| Interaction, focus, disclosure, scrolling or uncertain component behavior | Small focused slice in the actual app, isolated from live writes. |
| Imagery or deliberate brand exploration | Assets or scoped visual references when requested or authorized. |
| Known local defect with settled direction | Direct correction and relevant runtime verification. |
| Current approved v2 target | Consume its exact packet in implementing-frontend-design. |

There is no required sequence through all media. When substantial composition is unresolved, compare a small useful set of inexpensive structures before polishing one. Alternatives change task flow, hierarchy or interaction, not merely color or card styling. Select by ease of use, clarity, visual quality and product fit, stating the benefit and cost. Settled patterns and mechanical changes use the direct path; no fixed image or artboard count. Narrow feedback reopens only the affected decision, not the whole exploration. Hold task, fixtures, shell, content and widths constant. Compare grouping, action placement and disclosure by task benefit and cost. Keep supported facts and business semantics separate from design hypotheses. Apply [task-to-layout](task-to-layout.md) and the relevant [design knowledge](design-knowledge-selection.md) before composing. Refine typography, spacing, alignment, contrast and emphasis with the task relationships in view.

Routine generated UI screenshots, Companion screen composition and a full standalone recreation are not stages in this workflow. If the user explicitly requests image-based UI concepts or Companion mockups, honor that scoped medium and count. The override does not waive final approval, exact copy or actual-component evidence.

## Comparable image concepts

For an explicit image-based UI concept request, read the available image-generation skill and current tool schema. Use built-in generation directly; generate separate images, not a contact sheet. Inspect local reference images before attaching them. Name each attachment's role: retained shell/brand, content/state evidence, or legacy composition to reconsider. Preserve only the named anchors; asking to preserve an entire weak screenshot defeats composition exploration.

Hold task, content, viewport, brand and constraints constant. Each alternative has a clear design idea and a task-related tradeoff. For example, a financial detail could compare a balance-led statement, an identity/context rail with ledger, and a scope-led account workspace. These are alternatives only when the available behavior supports them; a render cannot invent filters, scope switching or actions.

A useful prompt contains:

1. Flat, front-facing, high-fidelity UI screenshot; viewport and product task.
2. Reference roles and retained brand/shell.
3. This concept's hierarchy/composition/disclosure idea.
4. Exact representative synthetic content and approved visible labels.
5. Required data, states, controls and technical limits.
6. Distinctions the image must preserve and specific likely mistakes to avoid.

Keep technical state semantics separate from visible copy. If related states need images, reference the selected parent and change only state-specific content/affordances; preserve approved structure. Distinguish empty, unavailable, loading, permission-limited, partial failure and success according to the real screen contract. Explicitly identify hidden, disabled and read-only controls when relevant. Do not generate every state when the actual-app slice can demonstrate it better.

Before showing concepts, inspect missing information, invented controls, readability, density and scope. Record limitations; a beautiful render with missing essential content is not a viable choice. Name images A-v1/B-v1/C-v1 (or equivalent stable IDs) and show actual outputs with concise tradeoffs. Save output files or durable identities and prompt provenance.

## Selection and refinement

Record the exact chosen file/version and scoped feedback. A combined choice names what is inherited from each source. Show material revisions before final approval. A concept choice authorizes building that direction; the concrete final design and required interaction evidence still need review.

## Actual-component and browser evidence

For interaction-dependent or component-sensitive visual decisions, build the smallest risk-resolving actual-component slice with working controls and representative data. A known unchanged component used within verified constraints does not need another experiment. No screenshot background with invisible click regions. For existing applications, use an isolated route, component preview or worktree with the actual stack, installed primitives and product styles. Keep exploration isolated from live writes. Record the checkout/dependency versions and reproducible setup needed to restore the prototype.

When the toolchain blocks exploration, standalone prototypes may establish a
provisional direction. Before final approval of sensitive details as
`visual-truth`, demonstrate a representative slice with the actual components:
the densest table/form section, important overlay/disclosure, long content at a
narrow viewport, and relevant focus/validation states. Record decision → actual
component/token → observed result or required change in the existing component
mapping. Names alone do not prove fidelity. If this proof cannot be obtained,
list the missing evidence and obtain explicit acceptance of that limited scope;
keep unsupported details provisional otherwise.

Use the session's actual browser APIs and respect the user's browser choice. Compare rendered alternatives or the selected image at equal viewport/content. Exercise primary task, disclosure/scrolling, long content, empty/loading/error where relevant, narrow layout and keyboard/focus. Document fixture states as fixtures, not backend proof. Required component work is a planning input, not a reason to revert to the legacy composition.

Apply annotations to their actual element/context and preserve choices outside the feedback. Optional focused Impeccable findings feed the same iteration. Batch supported corrections and confirm them; do not run an endless automatic polish loop. New human feedback may start another scoped iteration.

Retain the v2 design manifest and extracted payload separately from runtime evidence. Runtime records retain recoverable code, all seven runtime handoff fields, source version, state setup and relevant captures. Record final browser targets that replace earlier images and their approved intent. Keep final approval distinct from concept selection. Capture alone is not verification: say what was inspected, changed and remains uncertain.

## Human task evidence in the existing review

Offer one or two realistic tasks without explaining the intended click path.
For a ledger, ask the person to identify the balance's account scope and find a
movement that explains it. Record task, person/role, expected outcome, observed
outcome or confusion, and correction or unresolved hypothesis. A builder's
walkthrough is evidence about that builder, not representative-user validation.

Record separate conclusions for visual approval, agent functional verification,
and observed human usability. Watching a recording does not establish task
completion. If a person is unavailable or declines, record "not observed" and
the remaining hypothesis; do not invent success or add a compulsory study or
second approval gate. Missing required browser/component proof still follows
the explicit degraded-evidence rule.

If a capability needed by the selected medium is unavailable, distinguish that
gap from a design decision. Continue independent inspection; propose a concrete
alternative for authorization if the requested loop cannot run. Imagegen is
not required for Paper composition or actual-app checks. Never invent a screenshot or quietly turn
an explicit image-concept request into prose.
