# Paper in the frontend design workflow

Date: 2026-10-23  
Track: architecture-led-change  
Status: approved by the user on 2026-10-23; Superpowers planning handoff approved.  
Frontend packet for this change: not-required. This changes skills and their evidence contracts; it does not design a product screen.

## Experience amendment — 2026-10-26

The user rejected `branding-paper-r1-20261026` and requested the targeted experience correction recorded in [diagnosis](../reviews/2026-10-26-paper-experience-correction.md). The original approval and review identities below remain historical evidence; they did not review this amendment. U1–3 and their evaluations remain intact. No current pilot design is approved. This amendment changes experience framing, exploration and quality review within the existing workflow; v2 identity, maintenance limits, fixture prerequisites and exact human approval remain unchanged.

## Chosen direction

Use Paper for substantial screen composition and visual refinement. Use the real application for interaction experiments, component feasibility and delivery. Grow a maintained Paper library through relevant feature work, retaining exact approval snapshots. Each new task starts from the current application when one exists.

Retire Visual Companion screen mockups and routine generated UI screenshots from the default process. Keep the Companion for useful diagrams and product comparisons, and image generation for assets or deliberate brand exploration. Remove the default full-screen standalone HTML recreation between Paper and the application.

The human primarily gives feedback in chat while the agent operates Paper. The workflow must produce better implemented UI with fewer repeated design passes. Preserve the existing task-to-layout reasoning and design-quality checks so Paper improves design decisions as well as carrying them into code. A maintained library should save work across features without requiring complete product coverage.

Before this becomes the default, run one representative screen through the complete candidate workflow: Paper design, version-2 snapshot export, actual-component implementation, verification and library reconciliation. Assess fidelity and maintenance effort against the agreed pilot scope. Until that evidence is sufficient, keep the candidate outside the installed default workflow.

## Decision ownership and framing

The user confirmed these decisions in this chat:

- Paper handles substantial visual design; the real app handles behavior and delivery. Routine changes stay in code.
- Feedback is primarily through chat; direct canvas editing remains supported.
- Paper owns screen composition. The other media keep the narrower purposes above.
- Incremental library maintenance belongs in relevant feature work. Broad library catch-up is separately scoped.
- Greenfield, small brownfield and large brownfield work need different initial coverage. Existing application truth remains the starting point.
- One small end-to-end pilot must establish implementation fidelity and maintenance effort before default adoption.
- The pilot screen is DashPark admin's parking Branding step, using parking 104 at the supplied local route as the starting point. Inspect it with the documented local admin account.
- Library upkeep stops at the task's agreed effort limit. Record pending work and retain last verified revisions; housekeeping does not block an otherwise verified application delivery.
- The new workflow generates, validates and consumes version-2 packets only. Historical packets remain untouched reference material outside its implementation handoff.
- Existing task-to-layout reasoning and design-quality checks remain required for substantial design work.

The later library decision supersedes the earlier preference for feature snapshots alone. Feature snapshots remain part of the maintained-library design.

Implementation defaults proposed by the author for review:

- Keep frontend-direction as the design coordinator and implementing-frontend-design as the implementation owner. Load Paper operating instructions on demand from a dedicated reference; do not add another lifecycle coordinator.
- Retain the packet identity and approval protections in the user-selected version-2-only contract, separating design source from runtime evidence. Exact field names remain an implementation-planning choice.
- Keep a small project-local library index. Reuse an existing suitable project record where possible; otherwise use docs/design/paper/library.json. Do not require installation of the entire Jalco pack or a second approval manifest.
- Treat this as an optional Paper integration in the user's local Superpowers fork. The implementation scope includes the selected DashPark pilot screen and affected library entries after its effort and execution setup are agreed. Upstream publication, plugin installation, unrelated app changes and broad library backfill remain outside scope. This spec-revision task changes documents only.

The motivating problem is poor frontend design and loss of decisions during translation into code. The preceding audit fixes improved medium selection, exact packet handoffs and runtime review. Adding Paper must preserve those protections and remove duplicated composition work.

Success means that a task uses each medium for a stated unresolved decision, improves the task through justified design choices, carries the selected design into actual components, and updates relevant library entries within the agreed effort. Faster artifact creation or faithful reproduction of a weak design alone does not demonstrate better UI or usability.

## Medium selection

| Unresolved work | Default action | Exit condition |
| --- | --- | --- |
| Product goals, scope or business behavior | Brainstorm in chat; use a diagram or comparison only when it clarifies the decision | A usable brief with scope, behavior and constraints |
| Substantial hierarchy, density, typography or screen composition | Compare inexpensive structural approaches when composition is unresolved, then refine the selected direction in Paper using actual content and established anchors | Selected direction with consequential visual decisions resolved |
| Interaction, focus, disclosure, scrolling or uncertain component behavior | Exercise a focused slice in the actual app, isolated from live writes | Evidence sufficient to choose the behavior and identify implementation work |
| Imagery or deliberate brand exploration | Use image generation when requested or authorized for that task | Selected assets or scoped visual references feeding Paper |
| Settled local defect or established mechanical change | Correct the actual app directly | Relevant verification; update a maintained entry only if its representation changed |
| Current approved version-2 design | Consume its exact packet in implementation | Verified implementation, with library reconciliation completed or explicitly pending under the stopping rule |

A task may enter Paper or the app first according to its uncertainty. There is no mandatory sequence through every medium. When substantial composition is unresolved, compare a small useful set of rough sketches or Paper structures before polish. Alternatives differ in task flow, hierarchy or interaction; select by ease, clarity, visual quality and product fit. Settled patterns and mechanical work keep their direct path; narrow feedback reopens only its affected decision. Do not impose a fixed image or artboard count.

A working slice checks a specific risk and should be reusable in the final implementation when appropriate. Avoid building a complete second screen solely to repeat composition approval. A standalone prototype remains an explicitly scoped fallback when the real toolchain is unavailable; its limitations remain visible.

The Companion keeps consent, artifact-first presentation, chat decision prompts and its temporary-artifact boundary. A qualifying Companion turn now means an explanation, flow or product comparison suited to that medium. Screen composition belongs in Paper even if Companion consent was already given. Update the existing onboarding-layout pressure scenario accordingly rather than requiring two copies of the layouts. For retained Companion turns, the first qualifying turn must still start the artifact path; every such turn must show the artifact before its question, use the dedicated question tool when available and identify plain-text fallback as degraded when unavailable.

Explicit requests for image-based UI concepts or Companion mockups override the default routing for that task. Preserve their scoped intent; they do not silently become implementation truth or impose a permanent extra stage. Do not remove the Companion runtime or break historical artifacts simply because default authoring policy changes.

## Paper library coverage

Library setup is driven by the first useful task. Record the initial coverage and the maintenance allowance from the agreed task scope or effort budget in its brief; ordinary scoped maintenance needs no additional project-wide approval ceremony. Do not silently extend the task to complete the library.

| Context | Initial coverage | Growth rule |
| --- | --- | --- |
| Greenfield | Approved brief, chosen stack/component system, a small foundation and components required by the first flow | Establish the app baseline with an early working slice; add entries as real features require them |
| Small brownfield | Relevant tokens, common components and representative screens | Broader catch-up is optional when its scope and reuse justify the effort |
| Large brownfield | The touched screens and their relevant shared components | Expand screen by screen; report partial coverage and stale entries explicitly |

Project size informs scope; expected reuse and available evidence determine what is maintained. Do not invent a full component catalog, new palette or unsupported API to fill a library. A greenfield design may propose a component, but it cannot be recorded as implemented until it exists and is verified.

The library has three logical roles, which can share one Paper file:

- Maintained entries: reusable tokens, components, patterns and selected representative screens, with their recorded implementation and review state.
- Feature drafts: proposed changes and the comparisons needed to choose among them.
- Approved snapshots: locally recoverable, immutable evidence of an agreed revision. Live token-bound Paper copies alone cannot provide this guarantee.

Preserve manual organization and edits. Read the current selection, affected nodes, tokens and source before revising. Use targeted changes; clone only when needed to preserve an approved baseline or a useful comparison. Do not recreate unrelated regions after narrow feedback.

## Lifecycle and synchronization

### Start from current evidence

Read the brief, current application, relevant source and tokens, affected library entries and applicable version-2 approval records. Historical packets may inform context but cannot serve as the new implementation handoff. Inspect the real screen when available. Distinguish implemented behavior from accidental defects; an existing regression is not a new design requirement.

For each affected entry, compare its recorded source and design with the current versions. Refresh the relevant baseline within the maintenance allowance without overwriting pending proposals or manual edits. If library refresh must be deferred, work from directly inspected application/source evidence and retain the library's pending status. Unrelated code changes do not automatically invalidate every entry. Missing mappings or untraceable source produce an explicit unknown status, not a claim of freshness.

If code and Paper both changed, compare each against the last recorded baseline. Preserve non-conflicting edits. Carry an unresolved design conflict to the affected decision; do not choose whichever file was edited last.

### Explore and check

For both standalone and approved-spec follow-on routes, record a short experience brief inside existing evidence: user/frequency/familiarity, job and decisions, information priority/disclosure, feedback for judging results, and interaction/density/vocabulary/visual character. Reuse settled product facts; ask only experience-changing questions with recommendations and tradeoffs. Distinguish business invariants from inherited presentation and implementation; significant business-rule friction needs a separate explicit decision, not silent changes or compensating paragraphs.

Apply the existing [task-to-layout method](../../../skills/frontend-direction/references/task-to-layout.md) before substantial Paper composition. Establish the user's next decision, the facts needed, their meaning/source/scope and the result the user needs to recognize. Separate supported product facts from design hypotheses. Choose grouping, comparison, action placement and disclosure for those task relationships; record their benefit and cost. Do not invent data, capabilities or business semantics to make a composition look complete.

Keep [design-knowledge selection](../../../skills/frontend-direction/references/design-knowledge-selection.md) and its substantive references in the workflow. Read the relevant sections before composing or refining an unresolved design. Carry the actual application into the existing rationale: observed problem, task and supported facts, consulted guidance, proposed relationship/tradeoff, and what visual or runtime evidence established. Naming a source or exporting an exact snapshot does not substitute for this reasoning. Mechanical corrections and already approved decisions keep their shorter routes.

Keep fixtures, task, retained shell, content and comparison widths consistent. Paper provides composition, state layouts and visual refinement. Test relevant long content and actual container widths. A scaled screenshot does not establish reflow.

Preserve the existing [frontend design review](../../../skills/frontend-direction/references/frontend-review-checklist.md) and [implementation quality checks](../../../skills/implementing-frontend-design/references/implementation-review-checklist.md), updating their medium-specific wording without weakening their design criteria. Critique hierarchy, grouping, useful density, typography, spacing, alignment, contrast, action clarity, feedback/recovery, state coverage, responsive behavior, copy and accessibility as relevant to the task. Apply the visual checks to the Paper design and repeat the applicable checks on the rendered app. Behavioral claims require runtime evidence. Keep findings tied to an observed problem, task impact and correction; fix consequential defects before approval rather than treating polished artwork or fidelity alone as success.

Record a concrete rendered quality verdict in the existing review: ready for human review or requires changes, with visible problem → task consequence → correction and unresolved limits. Valid packets and functioning controls can fail this review. Judge useful visual feedback beyond duplicated values, hierarchy/next action, interaction load, concise copy, type/spacing/alignment/grouping, responsive task ordering and empty/edit/error/completion states. Adapt subject grounding and restraint to existing admin vocabulary; no mandatory hero, font change, animation or rebrand. Keep the existing review cadence and final human approval.

Load the installed Paper guide and schemas when using Paper. Use available tokens, fonts and direct structure/style extraction. Tool-specific canvas restrictions govern authoring in Paper; they do not force the application to abandon semantic tables, its grid system or established components. Product requirements, existing anchors and accessibility govern design choices. General aesthetic suggestions do not authorize arbitrary palettes, asymmetric data rows, unreadable labels or a different component system.

Pre-approval runtime checks are required when the proposed decision depends on interaction behavior or component-sensitive visual feasibility. Examples include a dense table with a detail panel, long validation text in a real form, a custom overlay, keyboard navigation and layout under an important narrow container. Exercise the smallest actual-component slice that resolves the risk. A known, unchanged component used within verified constraints does not need a new experiment merely because Paper was used.

Record each risk, its actual component/token, observed result, evidence identity and any remaining limitation. A Paper screenshot cannot establish application behavior. Synthetic fixtures demonstrate only their recorded scope. Missing required proof keeps the affected decision provisional unless the user explicitly accepts the missing evidence under the existing degraded-evidence mechanism.

### Approve and hand off

Converge to one selected design, capture its exact scope and evidence, and use the existing final design approval. Selecting an early concept is not final approval. Do not add separate approvals for the canvas, library and packet when they describe the same decision.

Keep visual approval, agent functional checks and observed human task outcomes separate. Human task observation remains optional within the existing review; unavailable participants are recorded as not observed. A recording or builder walkthrough does not establish representative-user success.

The approved packet binds the proposed change. The existing app supplies baseline facts and unspecified conventions; it cannot veto an approved redesign simply because its old composition differs. Technical or accessibility conflicts require reconciliation in the affected scope.

### Implement and reconcile

Implement using actual project components and conventions. Read design structure, computed styles, token values and assets directly; use screenshots to compare results. JSX extracted from Paper is design evidence, not an instruction to replace Angular or copy a generated div tree into production.

Verify the implementation at the same relevant content, states and widths. Preserve the independent fresh-context browser review and the implementation runtime handoff. Compiling or updating Paper is insufficient evidence of completion.

Small fidelity corrections happen in the app when they satisfy the approved contract. A changed hierarchy, interaction, token meaning, component API or material visual treatment reopens only the affected design decision and produces a new approved revision where required. Do not silently normalize implementation drift into the library.

After verification, update the affected maintained entries from the verified implementation within the agreed maintenance allowance and record their source identity, evidence and accepted differences. Reconcile approved adaptations without rerunning the whole design process. Retain the original approval snapshot. If Paper is temporarily unavailable or the allowance is exhausted, report application verification separately from pending library synchronization; do not claim the entry is current.

Library upkeep happens at task start and after a meaningful verified UI change. There is no mandatory sync after each chat turn, commit or backend-only change. Broad backfill, automatic watchers, continuous two-way synchronization and full product mirroring are outside the first delivery boundary.

Shared-token or shared-component changes require impact inspection. Check affected uses relevant to the change and mark other dependent entries as needing review when their validity is unknown. Updating one entry must not mark all consumers as checked. Unrelated library cleanup remains outside the task.

### Maintenance stopping rule

Limit updates to affected entries and the agreed task effort or bounded maintenance scope. Stop further housekeeping when the allowance is reached or further work would exceed it. If an overrun is discovered after work starts, stop on discovery and record the remaining work rather than extending the task silently.

For each deferred entry, record the pending change, reason, verified application revision it needs to reflect, and its last verified library revision/source/evidence. Keep those last verified identities unchanged until reconciliation is actually verified. New entries with no verified baseline say so explicitly. Partial or draft canvas edits remain unverified; they must not replace or be presented as the last verified entry. Preserve a checkpoint before changing maintained artwork.

Pending library housekeeping does not block an otherwise verified application delivery. Report application completion and library upkeep separately. This stopping rule cannot waive application tests, design fidelity, approval identity, required evidence or an unresolved design/behavior defect. Complete the minimum pending/freshness record when deferring; broader catch-up is a separate task or a later use of that entry.

## Durable records and authority

### Library index

The index is a navigation and freshness record, not a second approval authority. Each maintained entry records:

- Stable subject identity, kind and scoped Paper file/page/node locators.
- Source component, token or route mapping; relevant dependencies; last checked source identity and date.
- Recorded design revision, implemented revision if any, and freshness such as checked, needs-review or unknown.
- Links to the exact approved packet identity and verification evidence, plus remaining differences and coverage limits.
- Pending maintenance, its reason and intended verified application revision, while retaining the last verified library revision and evidence.

Track draft, approved and implemented states separately. Coverage can be partial. Adding an entry or importing old artwork does not mark it approved, implemented or current. If an existing Paper manifest is used, new implementation work links to the same version-2 packet authority rather than maintaining competing approval histories. Older packet links remain historical references; reusing the index does not migrate or admit those packets into the new handoff. Internal locators belong in machine-facing records; user-facing summaries use meaningful names.

### Approved design snapshot

For each approved version-2 packet, keep its entry, revision, descriptor hash, approval reference, status and accepted limitations flowing unchanged through specs, plans and implementation tasks. The Paper library links to that identity.

For Paper-authored designs, the packet must retain locally:

- Selected screen/state/viewport captures with scoped reference intent.
- Directly extracted structure, relevant computed styles, resolved token values and required assets. Preserve exact approved visible copy and its state mapping.
- Provenance identifying the Paper file/page/nodes and captured design revision, together with the relevant application source and component mappings.
- Runtime evidence required for consequential decisions, or its explicitly accepted limits.

Approval applies to the local snapshot. A mutable Paper URL or node ID is a locator, not an immutable revision. The installed MCP's token content hash identifies tokens; it must not be treated as a hash of the entire design. Hash the actual local snapshot payload. A token-bound canvas duplicate can change when tokens change; frozen snapshots retain the values that were approved.

Re-read the selected design and tokens before final capture. If concurrent edits prevent a coherent snapshot, preserve the draft and resolve the mismatch before attaching approval. Export or asset failures remain specific evidence gaps. Do not freeze a screenshot-only approximation while claiming exact source recovery. Local extractions are sufficient for implementation evidence; native editable-file round-trip restoration has not been verified and is not promised.

### Version-2-only packet cutover

The new workflow generates, validates and consumes version-2 packets only. Remove version-1 acceptance from the new producer, validator and every implementation-handoff consumer. Do not build compatibility branches, dual-format workflows or automatic migration. Reject version-1 input with a clear message: "Unsupported packet schema version 1. This workflow requires version 2; historical packets are reference material only." Missing and other unsupported versions also fail closed with an actionable version error; do not fall back to legacy handling.

Leave historical packets untouched as reference material outside the new implementation handoff. Their historical approvals remain part of the record but do not authorize a new version-2 delivery. New work informed by history must establish its own current evidence and approval under version 2; changing a version field or copying an old approval is not sufficient.

Update all active producer, validator, consumer, template and documentation references consistently, along with their test fixtures. Port relevant integrity scenarios to version-2 fixtures and keep explicit version-1 rejection tests. Do not retain a version-1 success path merely to preserve an old test. Historical examples may stay archived if clearly identified as reference-only and excluded from current handoff instructions.

Version 2 separates the approved design source from runtime evidence. The implementation planner owns exact field names, but these semantics are required:

- A design source identifies its medium and locally recoverable source material. Paper snapshots carry the payload above; runtime-authored designs retain their actual source and captures.
- The packet records which pre-approval runtime checks were required, their results and source/state identities, or why none were needed. Required missing evidence cannot be converted into an optional omission.
- Runtime evidence can refer to a focused actual-app slice. Record checkout/build, revision plus any dirty-source snapshot, dependencies, launch/setup, route and concrete state preparation. Preserve the relevant source locally or through a verified recoverable immutable source reference with locally retained uncommitted changes; an ephemeral path alone is insufficient.
- A full standalone prototype is not required for a Paper design. Explicit references-only scopes and degraded evidence remain distinct cases.
- All local binding payloads remain inside the verified inventory; preserve path containment, exclusion rules, target/state agreement, source identity and exact descriptor-hash checks.
- Structural validation establishes record/file consistency. It never claims that behavior, visual quality or human usability passed.

## Responsibilities and first delivery boundary

| Area | Required change |
| --- | --- |
| Brainstorming and Visual Companion | Narrow medium routing, preserve product discovery and retained Companion protocol, carry decisions into the separate design session |
| Frontend direction | Preserve task-to-layout reasoning and design-quality review while coordinating Paper design, scoped actual-app checks, bounded library maintenance and final approval |
| Paper operating reference | Read current artwork, preserve edits, use current MCP capabilities, extract exact values and record snapshots |
| Packet helper, schema and handoff references | Use version 2 exclusively, separate design source from runtime evidence, reject version 1 and preserve integrity checks |
| Planning and implementation | Preserve exact approval identity, consume Paper extraction through the project's real components, verify runtime and reconcile touched library entries |
| Existing workflow guides and tests | Apply the version-2 cutover consistently, remove contradictory mandatory medium stages and exercise design quality and the maintenance stopping rule |

Implement the complete bounded candidate workflow across these areas, including regression tests, fresh-session behavior evaluations and the single-screen end-to-end pilot below. Keep it outside the installed defaults until the adoption criteria pass. Avoid an isolated Paper skill whose handoff still forces the old repeated-screen pipeline.

The change requires no new runtime dependency or mandatory community skill pack. Paper is an optional capability of the environment. When unavailable before design work, report that limitation and agree on a concrete available medium if Paper was requested. Approved local version-2 snapshots remain usable without a live Paper connection. Do not turn a tool failure into an approved scope decision or regenerate approved artifacts silently.

Explicit user medium preferences, scope boundaries, application stacks, retained anchors, accessibility requirements and runtime review gates remain valid. The new implementation handoff accepts version 2 only. Preserve historical packet files and paths as reference material without migrating or rewriting them. Apply the new defaults only after the pilot and other adoption checks pass; do not backfill libraries automatically.

No application-facing UI copy is introduced by this workflow change. Future design work retains the existing UX copy contract, including real labels, error/empty states and accessibility text. Report the subject, actual changes, evidence, approval state, implementation state and pending library work in plain language; do not label a proposal shipped.

## Evidence behind the decision

Sources were inspected on 2026-10-23. Community skill files report version 0.2.0. They are implementation references, not evidence that this workflow improves the user's application.

| Finding and source | Applicability and limits | Design consequence |
| --- | --- | --- |
| [Paper MCP documentation](https://paper.design/docs/mcp) describes HTML/CSS-based design access and design-to-website work. Its example uses a small structured section and additional responsive frames. | Official product guidance; the example does not establish behavior or fidelity in the user's stack. | Use direct design values and bounded sections, followed by real-app verification. |
| Installed Paper MCP get_guide for paper-mcp-instructions and tool schemas expose tokens, structure/style extraction, exports, targeted edits and review screenshots. | Observed in this chat. Canvas restrictions and general aesthetic suggestions exist; native editable round-trip recovery and automatic app synchronization were not established. | Load current tools on demand; preserve project conventions; retain local snapshots and explicit agent-performed reconciliation. |
| [Jalco iteration](https://github.com/jal-co/jalco-paper-skills/blob/main/skills/paper-ds-iterate/SKILL.md) starts from current artwork, preserves edits and limits changes to feedback. | Authored workflow guidance, not measured outcome evidence. | Adopt the bounded revision and preservation rules. |
| [Jalco review](https://github.com/jal-co/jalco-paper-skills/blob/main/skills/paper-ds-review/SKILL.md) distinguishes visual checks from real-product behavioral checks. | Static canvas evidence has a narrower scope than application verification. | Keep Paper state layouts, runtime checks and human task evidence distinct. |
| [Jalco adoption](https://github.com/jal-co/jalco-paper-skills/blob/main/skills/paper-ds-land/SKILL.md) separates approved and implemented revisions and refreshes artwork from verified implementation within scope. | This is a deliberate workflow; no cost-free continuous sync is established. | Maintain relevant library entries at task boundaries and preserve immutable approval history. |
| [Jalco management](https://github.com/jal-co/jalco-paper-skills/blob/main/skills/paper-ds-manage/SKILL.md) uses its own manifest and routes a full lifecycle. | Its orchestration overlaps the existing Superpowers workflow. | Borrow operating rules while retaining one coordinator and one approval authority. |

The current implementation is described by [scoped design authority](../../../skills/frontend-direction/references/design-source-priority.md), [current exploration](../../../skills/frontend-direction/references/visual-exploration.md), the [current packet schema](../../../skills/frontend-direction/references/packet-schema.md), [exact handoff](../../../skills/frontend-direction/references/packet-handoff.md) and [implementation runtime evidence](../../../skills/implementing-frontend-design/references/runtime-handoff.md). This specification supersedes their version-1/legacy handoff acceptance and repeated-medium requirements where they conflict. Preserve their relevant integrity, scoped approval and runtime-review protections when updating them for version 2.

## Acceptance examples

| Case | Given / when | Required outcome |
| --- | --- | --- |
| Dense brownfield screen | An existing ledger needs a new comparison/detail composition | Start from its real data shape and components; design in Paper; test the consequential detail interaction in a focused actual-app slice; do not add Companion or generated UI copies |
| Faithful but weak design | A polished Paper ledger hides information needed for repeated comparisons, and the implementation matches it exactly | Task-to-layout reasoning and quality review identify the lost context, compare a justified correction and verify it; export fidelity alone cannot pass design review |
| Interaction-led work | The main uncertainty is keyboard behavior in a picker | Test the real picker first; enter Paper only if visual decisions remain |
| Mechanical correction | A label changes within an established pattern | Correct and verify in code; update a maintained reference only if the change affects it; no new design exercise |
| Diagram after Companion consent | A user needs to see a data flow with no competing alternatives | Show the relevant map before asking the chat question; do not invent options or route it into screen design |
| Screen comparison after Companion consent | A user needs two onboarding compositions | Show the Paper alternatives before asking; prior Companion consent does not require a second rendering |
| Explicit image request | The user asks for three generated screen concepts | Honor the request and label their intent; do not treat a concept choice as verified application behavior |
| Greenfield | No implementation or component library exists yet | Establish only the first flow's foundations; mark proposed APIs as proposals; use an early working slice to establish feasibility and the subsequent app baseline |
| Small-app catch-up | A feature needs components missing from the Paper library | Import relevant entries; scope any wider catch-up separately rather than adding every screen automatically |
| Large-app partial coverage | The order-details screen and a shared status indicator change | Reconcile those entries and affected dependencies; leave unrelated screens alone and make partial coverage visible |
| Maintenance allowance exhausted | The app passes its required checks but further library updates would exceed the agreed effort | Stop housekeeping, record affected pending updates and preserve their last verified revisions; the verified app remains deliverable |
| Concurrent edits | The human changes Paper padding while code changes a component variant | Read both against the last baseline, preserve edits and resolve conflicting decisions before claiming freshness |
| Shared token change | A changed token affects several maintained entries | Inspect impact, verify relevant uses and mark unchecked dependents as needing review; keep old approved snapshot values stable |
| Stale or replaced design | Live Paper changes after approval or a local binding file is replaced | Implementation uses the approved snapshot identity; a changed local payload fails validation; new design scope needs a new revision |
| Missing component proof | A Paper overlay depends on an unavailable actual component | Keep the affected decision provisional or record explicit degraded acceptance; never call the canvas behavioral proof |
| Paper unavailable after delivery checks | App verification passes but library reconciliation cannot run | Report the app as verified and deliverable with pending library sync; preserve the last checked library identity |
| Human participant unavailable | Only the agent exercises a task | Record functional results and human usability as not observed; do not add a compulsory study or invent human success |
| Historical packet submitted for delivery | An approved version-1 or legacy packet is supplied to the new handoff | Reject it with the unsupported-version message, leave its files unchanged as references and require independently established version-2 evidence and approval for new implementation work |
| Pilot not complete | Structural tests pass but the candidate has not completed snapshot export, real-component verification or a bounded library reconciliation | Keep it outside the defaults; passing document or mock-tool tests cannot substitute for the end-to-end pilot |
| DashPark Branding pilot | An admin opens parking 104's Branding step, edits the displayed brand identity and compares its draft with the published state | Use the existing Angular controls and publication contract; make the first-publication state, field/preview relationships and publication requirements clear; verify the result and reconcile only affected library entries |

## Validation and rollout

During implementation, use writing-skills and the existing skill-evaluation process. Run focused structural tests and before/after behavior scenarios in fresh sessions. Preserve transcripts or outputs and the actual tested source identities; report failures and limits. Do not infer product-quality gains from wording checks.

For the experience amendment, preserve the rejected r1 captures and self-review as observed RED. Add focused fresh transfer/pressure decisions and affected handoff regression; do not rewrite historical campaign outcomes or call a policy score design-quality evidence. A later rendered r2 comparison and exact human approval remain required to demonstrate product improvement.

Structural regression coverage uses version-2 fixtures for valid packets and tests rejection of version 1, missing versions and unsupported versions. Preserve tests for source/evidence combinations, missing required proof, file identity and tampering, path containment and excluded binding paths, state/reference agreement, snapshot token stability and exact handoff identity. Update affected active documentation and fixtures together; remove obsolete version-1 success expectations and compatibility paths. Library tests cover stale dependencies, an exhausted maintenance allowance, pending updates that retain last verified revisions, and approved-versus-implemented state. Avoid a new general synchronization engine just to test these records.

Behavior scenarios must pressure the agent to stack all media, skip task-to-layout reasoning or actual-component proof under a deadline, reproduce a polished but task-inappropriate design faithfully, regenerate after narrow feedback, adopt a global aesthetic over a dense table, overwrite human edits, mark a partially covered library current, sync unrelated screens, exceed the maintenance allowance, block a verified delivery on housekeeping, treat a token hash as artwork identity, consume a historical packet or force Paper on a mechanical change. Exercise retained Companion protocol and explicit user medium overrides too. Check that the agent applies relevant design knowledge and substantive critique rather than merely naming the references.

Use the existing relevant tests as the starting suite:

- tests/claude-code/test-frontend-packet.py
- tests/claude-code/test-frontend-direction-contract.py
- tests/claude-code/test-frontend-visual-review-policy.sh
- tests/claude-code/test-no-pencil-frontend-policy.sh
- tests/brainstorm-server/visual-companion-contract.test.js
- tests/brainstorm-server/visual-companion-design-kit.test.js
- tests/claude-code/test-brainstorming-artifact-quality.sh
- tests/claude-code/test-custom-policy-contracts.sh
- tests/claude-code/test-lean-delivery-contracts.sh

### Required single-screen pilot

Run the candidate in an isolated checkout or test installation so developing and exercising it does not change the installed default skills prematurely. The candidate has one version-2 path throughout; isolation must not introduce a dual-format runtime or a version-1 compatibility branch. Cut over the installed workflow once after the adoption criteria pass.

#### Selected use case: DashPark parking Branding

The user selected the **Branding** step at [parking 104's edit page](http://localhost:4200/#/admin/parking/104/edit) in `/Volumes/Workspace/Development/SolutionPark/DashPark`. Start with the existing [template](/Volumes/Workspace/Development/SolutionPark/DashPark/gateway/src/main/webapp/app/admin/parking/admin-parking-update.component.html), its [component logic](/Volumes/Workspace/Development/SolutionPark/DashPark/gateway/src/main/webapp/app/admin/parking/admin-parking-update.component.ts) and [styles](/Volumes/Workspace/Development/SolutionPark/DashPark/gateway/src/main/webapp/app/admin/parking/admin-parking-update.component.scss). Use the documented local admin account through Gateway's normal login flow; keep credentials out of design artifacts.

The primary task is to configure the parking's displayed brand name, primary color and logo, understand the draft relative to the published identity, and publish when the required inputs are ready. The Branding `displayName` is distinct from the parking record's `name` in the Infos step. Preserve that distinction and the separate Branding publication action.

Read-only inspection on 2026-10-23 reached this screen under the admin account. Parking 104 showed the unconfigured-branding warning, `ACCES PARK`, `#3EAAFA`, no logo/favicon, both current and draft fallback previews, and a disabled publication button. At the inspected desktop width, the color picker extended beneath the preview cards. These are baseline observations, not a completed pilot or user-usability results. The served build's exact correspondence to the source checkout was not established; capture that identity before relying on runtime evidence for implementation approval.

The bounded design question is how to group identity inputs, asset requirements, previews and publication feedback so the admin can understand what will change and why publication is available or unavailable. Correct the observed control/preview overlap. Investigate whether the identical fallback previews in the unconfigured state obscure first publication; this is a design hypothesis, not evidence of user confusion. Use task-to-layout reasoning to justify comparison placement and disclosure, then apply the existing design-quality checks. Retain the shell, stepper, French-first labels, compact operator density and Gateway's [product](/Volumes/Workspace/Development/SolutionPark/DashPark/gateway/PRODUCT.md) and [design conventions](/Volumes/Workspace/Development/SolutionPark/DashPark/gateway/DESIGN.md). Paper should resolve this screen's composition, not redesign the surrounding admin application.

Source inspection establishes the following constraints to check in the pilot:

- The existing shared [color picker](/Volumes/Workspace/Development/SolutionPark/DashPark/gateway/src/main/webapp/app/@theme/components/color-picker/color-picker.component.ts) and editable hex field feed the draft. The component accepts six hex digits with an optional `#`, normalizes valid input to uppercase `#RRGGBB`, and uses the current color as the preview fallback for invalid input. Preserve validation and accessible error feedback while checking actual control behavior.
- The screen includes required light-logo selection, optional dark-logo and favicon inputs. [File validation](/Volumes/Workspace/Development/SolutionPark/DashPark/gateway/src/main/webapp/app/admin/parking/branding-file-validation.util.ts) accepts SVG/PNG/JPG/WebP logos and ICO/PNG/SVG favicons, with separate size limits. Keep those controls and constraints; an attractive three-field mockup must not omit them.
- The current client publication gate requires valid fields, no asset errors, a selected light-logo file and changes, and blocks while publishing. Even name/color-only edits currently need a selected light logo. Treat that as observed implementation behavior to explain and verify, not permission to silently change the product rule. Any proposed rule change needs separate scope agreement.
- The [branding service](/Volumes/Workspace/Development/SolutionPark/DashPark/gateway/src/main/webapp/app/core/services/tenant-branding-admin.service.ts) publishes independently of the stepper's `Terminer` action. Preserve the service contract, current/draft distinction and success/error handling. Backend changes, other parking steps, new preview destinations and a replacement component system are outside this pilot.

Before execution, agree the total effort allowance and library-upkeep share, establish a resettable local fixture for publication checks, and record the runtime handoff and exact source state. Parking 104 is the inspected baseline; this proposal does not authorize publishing changes to it. Do not turn a visual fixture into persistence proof. DashPark prohibits worktrees: isolate candidate skills through a separate test installation and use the project's permitted feature-branch/submodule workflow for eventual application changes. This spec revision does not start the pilot or modify application code or parking data. There is no required second greenfield pilot or whole-product import.

#### Pilot execution and evidence

The rejected r1 is retained unchanged as a failing design baseline. Newly confirmed pilot context: Branding is configured once per parking, rebranding is rare, and logos plus the agreed brand color are ready. These are pilot facts, not global defaults. Before the next proposal, lead focused experience framing and compare unresolved structures. Reconsider useful identity preview, current/draft prominence and duplication, visual logo selection, repeated or technical instructions, first publication versus editing, mobile order and the narrow-picker compromise. Preserve publication and parking-save semantics unless the user explicitly changes them. Geometry success alone does not resolve the narrow interaction cost.

Exercise the complete path with real tools and components:

1. Refresh the Branding baseline and source identity. Apply task-to-layout reasoning and relevant design knowledge; record which observed problem or hypothesis each proposed change addresses.
2. Design and critique the selected direction in Paper with representative content, states and widths. Exercise consequential picker, validation, asset-input and responsive-layout questions using the actual Angular components before approving dependent decisions.
3. Export and approve a locally recoverable version-2 snapshot with direct structure/style/token/asset evidence and captures. Validate it, then hand off its exact identity to the implementation step.
4. Implement the selected change in the application's actual components. Verify behavior, design quality and fidelity, including the existing independent runtime review. Record corrections and any explicitly accepted design changes.
5. Reconcile the maintained Branding screen/pattern entry from the verified implementation, including its preview states and source/component mappings. Reference the existing shared color picker and relevant tokens; update their maintained entries only if affected. No shared-component extraction is required just to populate the library. Record source, snapshot identity and evidence. Apply the stopping rule to remaining housekeeping and preserve pending entries' last verified revisions.

Use the same content and dimensions for Paper review and application comparisons. Proposed test widths are a 1440 × 900 desktop viewport, a 1024 × 768 constrained desktop viewport and a 390 × 844 narrow viewport; record actual content widths inside the retained shell and the original overlap's reproduction width. These are author-proposed pilot checks, not claims that the current screen already works at those sizes. Cover:

| State or task | Evidence required |
| --- | --- |
| First publication and unchanged published identity | Missing-branding messaging, meaningful preview labels/fallbacks, required asset guidance and correct publication availability |
| Draft name/color/logo changes | Current identity stays distinguishable from the draft; picker and typed hex changes reach the expected draft; supported logo variants and favicon remain accessible |
| Invalid or missing inputs | Empty name, invalid hex, unsupported/oversized files and missing required light logo produce understandable feedback and preserve publication gating; include valid SVG and raster paths |
| Publication lifecycle on the resettable local fixture | In-progress gating, error recovery, success reload and resulting published state, without confusing `Terminer` with Branding publication; use live service evidence for persistence claims |
| Responsive and keyboard use | No picker/preview overlap, clipped fields or unreachable actions; sensible reflow, long-name/French-label wrapping, visible focus, usable labels and readable contrast |

Use the component, branding-file-validation, branding-URL and branding-service specs as the existing regression starting point. Add targeted tests where the approved change affects behavior or exposes an uncovered contract. Follow [Gateway's instructions](/Volumes/Workspace/Development/SolutionPark/DashPark/gateway/AGENTS.md) and its [verification procedure](/Volumes/Workspace/Development/SolutionPark/DashPark/docs/agents/TESTING.md): Node 12/Jest, applicable formatting and lint, fresh LSP diagnostics or the required fallback, and runtime evidence. Verify installed Nebular APIs before changing their use. Retain the independent runtime review and full design-quality checks; these screen-specific checks supplement them.

The pilot report assesses both design decisions and the result in code: primary-task support, hierarchy/readability, relevant state and responsive behavior, fidelity to the approved snapshot, and the corrections needed during implementation. Record observed human task results only when someone actually performs the task; otherwise distinguish agent checks and remaining usability hypotheses.

Record actual effort for initial setup, Paper iteration, export/handoff, implementation corrections and library reconciliation separately. Compare maintenance effort and useful coverage with the agreed allowance. This distinguishes first-use setup from upkeep; if repeated-use savings were not observed, say so. Document repeated screen-authoring work, export friction, manual repairs and deferred updates rather than hiding them in a completion claim.

### Adoption criteria

Make the new workflow the default only when the relevant regression and fresh-session behavior checks pass and the pilot report demonstrates the full version-2 path, an actual scoped library reconciliation, acceptable implementation fidelity and useful maintenance within the agreed effort. Required application checks must pass; material design or fidelity defects must be corrected or resolved through the existing scoped approval process. Assess the evidence before adoption; do not enable defaults automatically just because scripts pass.

If the pilot is incomplete, reconciliation has never been demonstrated, required checks fail, or maintenance effort shows the proposed scope is impractical, retain candidate status, narrow or correct the workflow and rerun only affected checks before adoption. Pending additional library housekeeping can coexist with a successful pilot and a verified app delivery once the bounded reconciliation and other adoption criteria are met. A verified pilot app may also be delivered while workflow adoption remains pending; these are separate outcomes.

At cutover, active generation, validation, consumption, documentation and test fixtures all use version 2 exclusively. Leave historical packets untouched outside the handoff. Keep rollout local and reversible through Git; do not implement runtime fallback to an old packet format. Report the limits of a one-screen trial and any unmeasured long-term quality or maintenance-cost assumptions explicitly.

## Alternatives and remaining limits

The initial feature-snapshots-only approach has low maintenance cost but misses cross-feature reuse. A complete continuously synchronized product mirror provides broader coverage but creates ongoing reconciliation work. The chosen incremental library retains reuse while bounding coverage and upkeep to actual tasks.

Making Paper mandatory for every change would slow routine corrections and interaction-led exploration. Keeping every old medium as another normal stage would preserve the repeated composition problem. Both conflict with the agreed goal.

No unresolved product-policy decision blocks final review of this written proposal. Field names, helper organization and bounded test fixtures belong to implementation planning. The DashPark Branding screen is selected; agree its effort allowance and establish the resettable local publication fixture and runtime identity before executing the pilot. Those execution inputs block the pilot and default adoption until resolved. Current MCP export and token behavior must be checked in the pilot; any incompatibility must preserve the recoverable-snapshot contract or return a concrete limitation. Native editable-file recovery is outside the initial guarantee. The pilot is required before default adoption, and broader UI-quality or long-term time-saving claims still need evidence beyond that one-screen result.

## Delivery Route

- Recommendation: Superpowers. This is one bounded workflow change with coupled packet, skill, evaluation and pilot contracts; it benefits from a durable task plan and risk-scaled review without milestone governance.
- Confirmed route: Superpowers, explicitly selected by the user on 2026-10-23.
- Neutral artifact approval: [independent review](../evaluations/2026-10-23--paper-frontend-workflow-review.md), READY for neutral spec SHA-256 `7bfe8f51dd5b096282be002747953aee4a16658af868c8ab4cd467c1c813e2e8`; user message: "I approve the reviewed Paper frontend workflow spec and choose the Superpowers implementation-plan route."
- Confirmation: the same user message requests delivery-route review followed by a compact writing-plans plan, for planning only.
- Delivery output: [single writing-plans invocation](../handoffs/2026-10-23--paper-frontend-workflow-superpowers.md).
- Delivery review: approved; `paper_workflow_spec_review` returned READY on 2026-10-23 ([selected-adapter review](../evaluations/2026-10-23--paper-frontend-workflow-review.md#selected-adapter-review)).

Frontend handoff for this workflow change:

```text
Frontend packet entry: not applicable — workflow/skills change
Expected revision: not applicable
Expected descriptor SHA-256: not applicable
Approval reference: not applicable — no pilot screen design approved
Status and accepted limitations: not-required for workflow planning; no product-design authority granted
```

The Branding pilot design remains required-pending within the plan. Its producing session must obtain design approval and supply the complete exact version-2 handoff before application implementation. Planning may establish the work needed to reach that gate; it cannot supply an invented packet or waive the gate. Pilot effort, the resettable publication fixture and runtime/source identity remain execution prerequisites. This route approval authorizes planning only.
