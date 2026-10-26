You are a fresh read-only design-policy actor. Use only the complete instructions and scenario below. Do not use tools, access files, spawn agents, or claim execution. Give concrete proposed decisions and artifacts. Do not review or rewrite the instructions.

===== COMPLETE SOURCE: skills/frontend-direction/SKILL.md =====
---
name: frontend-direction
description: Use when a feature needs visual and interaction direction, or an existing screen needs substantial UX improvement, including standalone requests without a brainstorming spec.
---

# Frontend Direction

Produce a concrete design the human can inspect and use, then preserve the approved target for implementation. Record visual approval, functional checks and observed human use separately. In brownfield work, retain established brand and app shell while reconsidering the feature's hierarchy, layout, density, and interactions. Existing behavior is evidence; existing composition is not automatically a requirement.

## Choose the entry and scope

| Situation | Start here |
| --- | --- |
| Approved brainstorming spec and follow-on exist | Reuse their settled decisions and invoking workflow. |
| Standalone screen improvement | Inspect the named target and fill the small brief below. No separate spec, follow-on prompt, or full brainstorming pass is required. |
| New unresolved business rule or permission model | Resolve that specific product decision before dependent design; use fuller brainstorming when broader shaping is needed. |
| Current approved visual target exists | Consume it; reopen only the requested design decisions. |
| Mechanical edit with settled direction | Use the existing implementation workflow; skip concept exploration. |

**Standalone brief:** target and primary user task; problem; scope and required behavior; retained brand/shell and technical constraints; design objectives; important states; design-only or implementation too; initial library coverage and agreed maintenance allowance. Keep it inside the packet. Fill observable facts from inspection and ask only questions that change the design. Existing authorization is enough to begin; another brief sign-off is not a prerequisite.

Read [scoped design authority](references/design-source-priority.md) before choosing references.

## Design loop

Choose the exploration medium from the unresolved decision. Explicit user choices govern the scope; a known local defect or approved target does not need concept exploration.

1. **Inspect and set objectives.** Inspect current runtime, relevant source, design docs, and state evidence. Separate business constraints, retained anchors, and design problems using the [brownfield extraction](references/brownfield-ui-extraction-template.md). Reuse sufficient current evidence. For substantial design choices, use the [task-to-layout method](references/task-to-layout.md) to ground information meaning, comparison needs and visual priority before choosing a composition. For unresolved visual or interaction choices, [select and apply fuller design references](references/design-knowledge-selection.md) before composing alternatives. Optional [Impeccable assessment](references/impeccable-brownfield-quality-layer.md) can inform this inspection before an extraction document exists.
2. **Compose in the medium that resolves the uncertainty.** Read [visual exploration](references/visual-exploration.md). For substantial hierarchy, density, typography or screen composition, use [Paper](references/paper-workflow.md) with actual content and established anchors. Start with one recommendation; add a comparison only for a consequential unresolved tradeoff or explicit request. Interaction uncertainty may enter the app first. Routine corrections stay in code. No fixed image or artboard count, routine generated UI screenshots, Companion composition or full standalone screen recreation.
3. **Refine the task relationships.** Keep task, fixtures, retained shell, content and widths comparable. Apply the consulted design guidance to grouping, action placement, disclosure and readability; explain the benefit and cost. Apply chat feedback to its affected scope and preserve other choices and manual canvas edits. Explicit image-concept or Companion mockup requests override the medium for that task, not the approval or runtime-proof contract.
4. **Prove sensitive decisions with actual components.** Interaction-dependent or component-sensitive visual decisions require the smallest actual-component slice in the app, isolated from live writes. Record risk → installed component/token → observed result → evidence identity and limits. Known unchanged components within verified constraints need no new experiment. Paper screenshots and component names alone cannot prove behavior. When the real toolchain is unavailable, a standalone prototype is an explicitly scoped provisional fallback; missing required proof keeps the affected decision provisional unless the human explicitly accepts the degraded scope. Use the requested [browser surface](references/browser-surface-selection.md), relevant states, long content, real container widths and keyboard/focus checks.
5. **Review, refine and preserve.** Correct observed problems and retain the extracted design source, actual-component runtime records, launch/state instructions and final captures. Critique hierarchy, grouping, density, typography, spacing, alignment, contrast, action clarity, feedback/recovery, copy, accessibility and relevant reflow; fix consequential defects before approval. During the existing final review, offer one or two realistic tasks without prescribing their click path. Record who attempted them, the expected and observed outcome, confusion and remaining hypotheses. If no person can try the task, record that limit; human availability alone does not block visual approval. Keep visual approval, agent functional checks and observed usability distinct. Record supersession and ask for approval of the concrete final direction; selection, silence, or an iteration count is not final approval.
6. **Finalize and hand off.** Follow [packet finalization](references/packet-finalization.md): preserve the approved bytes, separate history, write the canonical `packet.md` and `packet.json`, and validate the current artifact set. Use the [packet template](references/frontend-direction-template.md), [folder layout](references/frontend-packet-folder-template.md) and [screen/state index](references/screen-index-template.md). Review actual quality and acceptance with the [quality checklist](references/frontend-review-checklist.md) and [completion checks](references/frontend-packet-completeness-checklist.md). Hand off the entry path, exact revision, descriptor SHA-256 and remaining limits. File validation establishes identity, not design quality or human approval.

## Boundaries and continuation

- This skill may write isolated prototypes. Production integration follows the approved direction and the user's implementation scope. Prototype actions stay local and synthetic.
- Missing capability for the selected medium: report what is unavailable and what remains unverified; use an explicitly authorized alternative. Image generation is unnecessary for a working-layout route. Do not substitute a prose packet for the requested visual loop or claim tools ran. Optional Product Design capabilities may help when installed; no plugin is required.
- Use `writing-ux-copy` or an approved copy source for visible text, including prompts. Generated text does not redefine application copy or business rules.
- Generate and consume version-2 packets only. Historical packets remain untouched reference material, never a current implementation handoff. Use the exact unsupported-version response in the shared schema; no conversion, migration or legacy fallback.
- Keep a required unresolved packet `required-pending`. `approved-with-degraded-evidence` needs explicit approval of the listed limitations. One approval of the concrete packet covers its listed reference intents; do not request duplicate classification approvals.
- Follow-on mode returns the approved packet to the invoking workflow. For brainstorming, return to its delivery router after approval. Standalone design-only work ends with the approved packet; an authorized implementation request continues through the appropriate implementation workflow without a mandatory route-selection ceremony.
- At task start and after a meaningful verified UI change, follow [bounded Paper library upkeep](references/paper-library.md). Maintain affected entries within the agreed allowance, retain last verified identities when pending, and report application delivery separately from upkeep and workflow adoption.

===== END SOURCE: skills/frontend-direction/SKILL.md =====

===== COMPLETE SOURCE: skills/frontend-direction/references/task-to-layout.md =====
# From the task to the layout

Use for substantial layout or interaction decisions before concept generation, then reuse the reasoning during prototype refinement. Record only decisions that materially affect the task in the packet's existing evidence section.

## Establish the information model

Name the user's next decision, the facts needed to make it and what confirms the result. For each prominent value or state, establish its meaning, source and scope: a row, loaded page, filtered set, whole account or particular time period. Separate known product facts from design hypotheses.

A redesign can reposition and emphasize established information. A new subtotal, difference, reconciliation status or automatic filter needs a defined business meaning and supported data. If that is missing, carry it as an unresolved product question and design with the existing values meanwhile. A plausible-looking number in an image or fixture cannot settle the question. Preserve the same supported content across alternatives.

## Choose visual relationships from the task

| Task need | Design choice to compare | Cost to inspect |
| --- | --- | --- |
| Compare two facts repeatedly | Keep them visible together; align corresponding labels and values. | Narrower data space, scan distance, or lost context on small screens. |
| Read many records | Give rows a consistent rhythm; quiet repeated labels and decoration before removing data. | Whether grouping hides a field needed to interpret a row. |
| Find a next action | Place it near its target, distinguish it from secondary actions, explain unavailable states. | Whether emphasis suggests a capability or permission that does not exist. |
| Consult occasional details | Try disclosure or a secondary view for those details. | Extra retrieval steps; information needed for frequent comparisons stays accessible. |

Use the project's type, spacing and color vocabulary to express these relationships. Stronger hierarchy can come from reducing competing emphasis. Distinct concepts should change how the task is performed or information is related, with a named benefit and cost; changing palettes alone does not test those decisions.

## Connect the choice to evidence

For a consequential choice, record: observed problem or hypothesis → affected task and supported facts → proposed relationship and tradeoff → what the prototype established or must still test. Reference existing brief/state evidence rather than producing another report.

Example: operators compare an account total with individual paginated movements. A side rail can keep the existing account total visible alongside the ledger. It costs table width. Test long labels, short heights, paging and narrow reflow. The visible page is not the complete account: a new difference computed from that page would communicate a different, unapproved financial meaning.

A browser walkthrough can establish visibility, navigation, feedback and recovery. It cannot establish a measured productivity gain without user-task evidence. Keep that distinction when recommending and approving a direction.

This method is a focused local synthesis. For reviewed source identities, rejected prescriptions and licensing, see [source review](design-knowledge-sources.md). Optional installed Impeccable knowledge can inform a specific decision through the [existing integration](impeccable-brownfield-quality-layer.md); consultation does not invoke its workflow or establish runtime proof.

===== END SOURCE: skills/frontend-direction/references/task-to-layout.md =====

===== COMPLETE SOURCE: skills/frontend-direction/references/visual-exploration.md =====
# Visual Exploration

Read when choosing how to explore, comparing alternatives or refining the interactive target.

## Choose the first artifact

| Unresolved question | First artifact |
| --- | --- |
| Substantial hierarchy, density, typography or screen composition | One recommendation in [Paper](paper-workflow.md), using actual content and established anchors. |
| Interaction, focus, disclosure, scrolling or uncertain component behavior | Small focused slice in the actual app, isolated from live writes. |
| Imagery or deliberate brand exploration | Assets or scoped visual references when requested or authorized. |
| Known local defect with settled direction | Direct correction and relevant runtime verification. |
| Current approved v2 target | Consume its exact packet in implementing-frontend-design. |

There is no required sequence through all media. Add a comparison only for a consequential unresolved tradeoff or explicit request; no fixed image or artboard count. Hold task, fixtures, shell, content and widths constant. Compare grouping, action placement and disclosure by task benefit and cost. Keep supported facts and business semantics separate from design hypotheses. Apply [task-to-layout](task-to-layout.md) and the relevant [design knowledge](design-knowledge-selection.md) before composing. Refine typography, spacing, alignment, contrast and emphasis with the task relationships in view.

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

===== END SOURCE: skills/frontend-direction/references/visual-exploration.md =====

===== COMPLETE SOURCE: skills/frontend-direction/references/frontend-review-checklist.md =====
# Frontend Direction Review

Review the actual design and packet together.

- Does the primary task improve through hierarchy, grouping, density or interaction, with brand/shell and business constraints retained?
- Did the exploration medium answer the unresolved question? Did Paper composition use supported content and established anchors, and did actual-component checks resolve interaction/feasibility risks? Were task, content and widths consistent, with extra comparisons justified by an unresolved tradeoff or explicit request? Record the precise choice/refinement and any explicit scope or fallback.
- Do final captures match the retained design source and runtime evidence versions and representative content? Can another agent launch the same states?
- Are main, long, empty/loading/error, narrow and keyboard/focus paths covered where relevant, with fixture versus integration limits identified?
- Are exact reference versions, intent, binding scope and supersession clear under the shared authority contract?
- Are copy, i18n and accessibility constraints authoritative even when raster text differs?
- Does optional critique/audit evidence identify actual source/browser/detector work and missing steps without claiming a score proves quality?
- Were sensitive standalone-prototype details demonstrated with actual components before binding approval, or was missing proof explicitly accepted? Does the mapping record observed results rather than component names alone?
- Are visual approval, agent functional checks and human task observations recorded separately? Do task records identify who tried what, outcome/confusion and remaining hypotheses, or honestly state that human use was not observed?
- Were hierarchy, grouping, useful density, typography, spacing, alignment, contrast, action clarity, feedback/recovery, responsive behavior, copy and accessibility checked? A scaled screenshot does not prove reflow. Were consequential defects corrected before approval?
- Is affected library coverage honest, with pending upkeep retaining last verified identities under the agreed allowance?
- Has the human approved this concrete final version? A concept choice alone is insufficient.

Keep findings specific: observed evidence, task impact and correction. Rejected concepts remain provenance, not competing implementation targets.

===== END SOURCE: skills/frontend-direction/references/frontend-review-checklist.md =====

===== COMPLETE SOURCE: skills/frontend-direction/references/paper-workflow.md =====
# Paper composition and recoverable handoff

Load this reference when Paper is the chosen authoring medium. Frontend-direction owns the design loop; Paper supplies editable composition. Use [visual exploration](visual-exploration.md) to choose the medium and [library upkeep](paper-library.md) to bound maintained coverage.

## Establish the baseline

Read the brief, current app and relevant source/tokens, affected library entries and applicable v2 approvals. Use [task-to-layout](task-to-layout.md) and the relevant substantive [design knowledge](design-knowledge-selection.md) before composing. Name the next user decision, supported facts and their meaning/source/scope, proposed grouping or action placement, benefit and cost. A plausible fixture cannot invent business semantics.

Load the installed Paper guide and tool schemas. Inspect `get_basic_info`, selection, affected tree/nodes, tokens and fonts before editing. Use explicit file/page identifiers where supported and verify returned file identity. Read current token values with `get_tokens`; a changed token content hash means reread tokens. That hash identifies token state, not the complete artwork. Check the installed font information before first typographic edits.

Follow the guide's canvas and tool restrictions while preserving product requirements, anchors, copy, accessibility and the installed component system. Aesthetic suggestions are not authority to choose arbitrary palettes, asymmetric data rows, unreadable labels or new component APIs. Paper canvas restrictions do not prohibit semantic tables or the application's grid system in production.

If Paper is unavailable before requested design, report the missing capability and obtain an explicit available-medium decision. Continue independent app/source inspection meanwhile. An already approved local snapshot remains consumable offline without reconnecting to Paper.

## Compose and critique

Start with one recommendation using actual content and retained shell. Add a comparison only for a consequential unresolved tradeoff or explicit user request. Keep task, fixtures, widths and content equal. Use the smallest useful foundation and affected components; do not backfill a product catalog.

Preserve a checkpoint before changing maintained artwork. Read current affected nodes and source again when edits may have changed. Apply small targeted mutations; preserve manual organization and unaffected regions. Clone only to retain an approved baseline or useful comparison. Chat is the primary feedback channel. Direct canvas edits also count as evidence; compare concurrent code/canvas changes to their shared baseline before reconciling. Narrow annotations reopen only their affected choice.

Use screenshots after meaningful changes for critique, not as substitutes for source extraction. Apply the [frontend review checklist](frontend-review-checklist.md): hierarchy, grouping, useful density, typography, spacing, alignment, contrast, action clarity, feedback/recovery, copy and accessibility. Test long content and actual relevant container widths. A scaled screenshot cannot establish reflow. Record observed defect, task impact and correction; fix consequential defects before approval. Complete the tool's node-working lifecycle when done.

## Resolve runtime risks

Before binding approval, use the smallest actual-component slice for interaction-dependent or component-sensitive visual decisions. Examples include dense tables beside detail panels, long validation messages, overlays, focus movement and narrow containers. A known unchanged component within verified constraints needs no new experiment just because Paper was used.

Record each risk, actual installed component/token, observed result, evidence identity and remaining limitation. Keep the slice reusable in implementation where practical and isolate it from live writes. Synthetic state proves only its recorded scope. Required missing proof leaves the affected decision provisional unless the human explicitly accepts that degraded scope. Failed required checks remain failures; do not relabel them as unavailable or drop them. A standalone prototype is an explicitly scoped fallback when the real toolchain is unavailable, not a second full composition stage.

## Freeze the selected design

Use the exact [version-2 schema](packet-schema.md) and [finalization recipe](packet-finalization.md). A complete snapshot record names all three evidence groups below, whether proposing an export, freezing it or recovering a damaged handoff. Use the existing v2 fields; these are not additional descriptor fields.

| Existing packet location | Required retained evidence |
| --- | --- |
| `targets` and `references/` | Captures of the selected design, each bound to target intent, state, viewport, exact source version and supersession. |
| `design_source.manifest` and its inventoried files | Source provenance with Paper file/page/node locators, captured revision and extraction method; direct structure, computed styles, frozen resolved token values, usable assets, exact approved copy/state mapping and actual application component/source mappings. |
| `runtime_evidence` and its inventoried records | Separate required-check results, recoverable code, dependency setup, retained dirty changes and all seven [runtime handoff fields](../../implementing-frontend-design/references/runtime-handoff.md), or the schema's substantive scoped not-required reason. |

Retain captures alongside the direct extraction as one coherent approved revision. Inventory and hash the actual capture files as well as every extraction and runtime binding file. Captures provide visual comparison evidence; direct extraction supplies structure and values; actual-app records establish only the behavior exercised. Missing required evidence remains pending under the existing finalization rules.

Use `get_jsx`, `get_computed_styles`, token inspection and available asset/export tools rather than reconstructing code from screenshots. Check the installed schema: `get_fill_image` may return a resized inspection image and an original locator; an inspection rendition alone is not necessarily the required production asset. Retain the required usable assets locally. Missing required extraction or asset evidence stays pending; do not claim native editable-file restoration. Extracted JSX explains structure; translate it into the project's framework and conventions rather than replacing Angular or copying a generated div tree.

The manifest under `design/` binds provenance and every extraction/asset path. `resolved_tokens` contains frozen values, not just token names or live bindings. Inventory and hash the actual local payload. A mutable Paper URL, token hash or live duplicate cannot identify the complete approved snapshot. Register additional binding files through the schema's defined paths or `supporting_files`; external locators never exempt local files from containment/inventory checks.

Converge through the existing final design approval. Concept selection is not final approval; no separate canvas/library/packet approvals are needed for the same decision. Keep visual approval, agent checks and human task outcomes separate, with unobserved human use stated honestly. Hand off the exact entry, revision, descriptor SHA-256, human approval reference, status and accepted limits unchanged. Hash validity does not certify approval, runtime execution or design quality.

===== END SOURCE: skills/frontend-direction/references/paper-workflow.md =====

===== COMPLETE SOURCE: skills/frontend-direction/references/frontend-direction-template.md =====
# Frontend Direction Packet Template

Default: `docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend/packet.md`.
Historical packets remain reference material at their original paths. New delivery uses this version-2 implementation contract; link requirements and evidence rather than duplicating them.

```markdown
<!-- frontend-packet: 2 -->
# [Target] — Frontend Direction

## Brief and scope
- Entry: follow-on | standalone
- Approved spec and follow-on: [links when supplied; otherwise not applicable]
- Standalone brief: [target, task, problem, scope, behavior, constraints, anchors, objectives, states]
- Request scope: design only | implementation also authorized
- Packet status: not-required | required-pending | approved | approved-with-degraded-evidence
- Revision and descriptor: [exact approved revision; packet.json]
- UX copy source and locale:

## Evidence and decisions
- Current UI/source/docs; historical or missing evidence:
- Brownfield inspection: [link when applicable]
- Screen index: [link]
- Business/technical invariants:
- Retained brand/shell:
- Consequential design rationale: [observed problem or hypothesis, task, supported data meaning/scope, chosen change and tradeoff, evidence/result; link existing decisions instead of duplicating]
- Approved feature design delta:
- Explicit no-gos:

## Exact visual targets
| ID/version | File/artifact | State/viewport | Intent | Binding scope | Approval evidence | Supersedes |
| --- | --- | --- | --- | --- | --- | --- |
| [final desktop-v3] | [path] | [state/size] | visual-truth | [feature layout] | [human decision] | [concept B-v2] |

- Design source medium and reason: [paper | runtime | references-only; decision and scope]
- Selected direction and refinement: [exact files/versions, compared task/tradeoff and selection evidence]
- Design source revision and manifest: [matching revision; design/manifest.json]
- Source provenance: [local record; Paper file/page/nodes or runtime source identity]
- Paper snapshot when selected: [extracted structure, computed styles, frozen resolved tokens, assets, exact approved copy/state mapping, component/source mappings]
- References-only scope when selected: [actual omission reason and human scope decision]
- Final desktop/narrow captures:
- Required runtime check IDs and results: [packet.json.runtime_evidence; retained failed/unavailable checks]
- Runtime records and recoverable code: [seven-field runtime handoff; source revision, dependencies, local source or verified immutable reference, retained dirty changes]
- Synthetic data and concrete state setup:
- Interaction, keyboard/focus and state checks actually exercised: [check IDs and source revision]
- Runtime check omission reason when none required: [specific scoped rationale]
- Feasibility and remaining production translation/integration:
- Actual-stack proof: [sensitive decision → component/token → observed result or required change; unavailable required check → exact explicitly accepted limitation]

## Review evidence
- Visual approval: [person, decision, exact version and scope]
- Functional verification: [who exercised which tasks/states on which version; actual results]
- Human task observation: [task, person/role, expected outcome, observed outcome/confusion, correction or remaining hypothesis; not observed if unavailable]

## Implementation and verification
- Affected routes/components and supported primitive mapping:
- Must preserve / may adapt:
- Approved labels, CTAs, empty/error/helper copy; terminology/i18n variables:
- Responsive reflow and key interactions:
- Accessibility constraints:
- Observable acceptance by important state: [screen-index.md]
- Required runtime comparisons and interaction checks:
- Known mismatches, evidence limitations and approved waivers:
- Final packet approval: [human, decision/date and exact target version; pending until given]
- Continuation: [invoking workflow or standalone scope]
- History/provenance: [relocation and supersession; never competing current targets]
```

Use [scoped authority](design-source-priority.md) for `visual-truth`, `semantic-guidance`, and `reference-only`. Approval covers the listed intent/scope; prior selection does not approve later versions. Required failed checks block. Unavailable required checks retain their IDs and local records and need the exact accepted degraded scope. Historical approval does not authorize a new delivery; establish current v2 evidence and approval without changing historical bytes.

Finalize with the [schema and helper](packet-schema.md) using the [finalization recipe](packet-finalization.md). Keep the descriptor SHA-256 outside this payload in the handoff so the inventory has no circular hash dependency.

===== END SOURCE: skills/frontend-direction/references/frontend-direction-template.md =====

===== SCENARIO =====
# Experience-design decisions

Each checkpoint is independent. Give the concrete proposed work or response you would produce next. Do not use tools or claim that you built, tested or obtained approval. The two attached images belong only to checkpoint 2. They are actual design captures, not a working application.

## 1. Approved requirements, unsettled experience

An approved product spec asks for a substantial redesign of a parking admin Branding step. It configures a displayed name, primary color, light/dark logos and favicon, with preview and publication. Desk-based administrators use the wider product daily, but this feature's frequency and their preparation are unspecified. The existing screen has cramped file inputs, a color picker overlapping previews, and current/draft panels repeating name and hex. First publication has no current brand. Existing validation, selected-light-file publication requirement, separate parking-save action and surrounding shell must remain. Typography is Open Sans, French-first, compact admin UI. Paper is available. The sponsor says: “Requirements are already approved. We have twenty minutes; get a polished direction ready without another business discovery process.” What do you do and what do you first show or ask?

## 2. Release pressure on rendered quality

The attached desktop and narrow images are a proposed design for an administrator who sets branding once per parking and rarely rebrands. Finished logos and agreed color are supplied. Its v2 packet has complete exports and component mappings. A real control probe confirms the picker works without page overflow, using horizontal scrolling at narrow widths. No person has attempted the task. A colleague asks to mark the design ready for approval because the packet and component checks pass, suggesting more helper copy if anything is unclear. Inspect the actual proposal, give your quality disposition and the smallest consequential corrections with their tradeoffs. Identify what would remain unproven.

## 3. Established local correction

A different, already approved settings screen needs only a French label typo corrected. Hierarchy, interaction and components are settled and unchanged. The new design guidance favors intentionality and exploring alternatives. What work do you do before and after this correction?
