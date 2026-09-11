# Frontend direction with visual exploration

Status: approved by the user on 2026-09-11 ("I approve this design spec"). Review: `visual_spec_review`, 2026-09-10, verdict READY including standalone entry, upload-pack retirement, implementation-skill replacement, migration alternatives, and optional Impeccable integration. Matched no-guidance/current/candidate decision probes have been assessed (five per variant, for each of the two skills). The live DashPark pilot reached explicit user approval of prototype-v2 revision v2.1. See the [evaluation record](../evaluations/2026-09-11-frontend-direction.md) for evidence and limits; final review and complete-suite results belong to the execution report. Workflow track: brownfield-major-feature. A separate frontend-direction packet is not required for this skill change; this specification changes the workflow that creates those packets.

## Delivery Route

- Recommendation: Superpowers, because this bounded skill rework needs a durable plan, test-first execution, and independent behavioral/review evidence without milestone governance.
- Confirmed route: Superpowers.
- Neutral artifact approval: independent `visual_spec_review` READY and the user's explicit approval on 2026-09-11.
- Confirmation: the user selected "Superpowers: durable plan, test-first implementation, and reviews (Recommended)" on 2026-09-11.
- Delivery output: `docs/superpowers/plans/2026-09-11-frontend-direction-rework.md`.
- Delivery review: approved; independent `plan_readiness` returned READY on 2026-09-11 for the full plan and selected Superpowers adapter.

## Problem and intended outcome

The user reports that Superpowers produces detailed feature specifications but repeatedly delivers poor UI/UX in brownfield applications, particularly DashPark. Feature implementations inherit weak existing layouts and interactions despite accurate business requirements.

The current workflow contributes to this outcome. `skills/frontend-direction/SKILL.md` prioritizes current product UI over generated imagery, limits HTML to temporary decision aids, and routes image exploration through manual external generation. Its templates and reviews emphasize preservation. Downstream implementation guidance repeats that priority. These are supported policy findings, not proof that a replacement has improved visual quality.

Frontend direction should produce a chosen design the human has seen and exercised. Its written packet records the visual and interaction decisions and makes them survive the handoff to implementation.

Success means agents demonstrate materially different design alternatives, refine the selected design in a browser, and implement against the approved target without reverting to legacy composition. Better-looking prose or passing keyword tests does not establish success.

## Confirmed direction

The user selected these defaults and requirements in this conversation:

- For substantial brownfield features, preserve the established brand and app shell while reconsidering the feature's layout and interactions.
- Generate three distinct image concepts, refine the selected concept, then build and iterate a high-fidelity browser prototype.
- Support direct invocation for improving an existing screen without requiring a full Superpowers brainstorming pass.
- Retire ChatGPT upload-pack authoring while keeping existing approved images and packets readable.
- Reevaluate the relevance and design of `gsd-frontend-design`.
- Use Impeccable complementarily when available, especially for standalone screen assessment and implementation quality. It is installed project-locally in DashPark.

These defaults apply when frontend direction is unresolved and substantial. Existing approved direction, mechanical UI edits, explicit user choices, and strict project constraints retain their appropriate scope. The workflow must not turn every copy fix into a design exploration.

## First delivery boundary

Rework the frontend-direction skill, its directly coupled references and image-generation guidance, and the minimum upstream/downstream contracts needed to carry approved visual evidence into implementation. Validate behavior before and after the edits.

DashPark is the initial real-world evaluation case. Its source and existing artifacts provide business and technical context. This change does not authorize a production redesign of DashPark, framework upgrades, new application dependencies, external publication, or an upstream Superpowers PR.

Preserve the neutral specification and separate frontend-direction session for work entering through brainstorming. Direct invocations use the small brief described below. Both entries retain the copy contract, reference intent, packet approval, and implementation verification gates. Avoid an additional orchestration family or duplicate review sequence.

## Two entry points, one design workflow

`frontend-direction` owns a short discovery step as well as visual exploration. It is usable directly and as a follow-on. Do not create a separate light-brainstorming skill or require the full brainstorming workflow for a bounded screen improvement.

| Entry | Required context | Behavior |
| --- | --- | --- |
| After brainstorming | Existing approved spec and follow-on context | Consume settled decisions without asking again. Preserve the invoking workflow's scope and handoff expectations. |
| Standalone screen improvement | A named screen, route, screenshot, or sufficiently clear target and intended outcome | Inspect relevant context, fill a small brief, ask only for information that changes the design, then enter the same exploration loop. No pre-existing spec or follow-on prompt is required. |

The standalone brief records the target and primary user task, the problem to improve, scope, required behavior and constraints, retained brand/shell, design objectives, important states, and whether the user requested design only or implementation too. Keep it in the direction packet rather than requiring another document. An initial user request may provide most of it; inspection should fill observable facts.

Scale discovery to uncertainty. A request to make an existing screen easier to scan can proceed with its existing business behavior. A request that introduces a new business process, permission model, or cross-system behavior requires those unresolved product decisions to be settled before dependent design. Offer the fuller brainstorming workflow when that broader shaping is useful; do not force it because a spec file is missing.

The workflow may begin inspection and prepare concepts once the brief is sufficient and the requested exploration is authorized. Do not add a ceremonial approval for a restatement of decisions already supplied. Concept selection and final design review remain concrete interaction points.

At completion, return the approved packet to the invoking workflow if there is one. In standalone mode, a design-only request ends with the approved design and its evidence. If the user also asked for implementation, continue through the appropriate implementation capability within that authorization. Do not insert a mandatory GSD/Superpowers delivery-route ceremony into a direct screen-improvement request or silently start a second orchestrator.

## Proposed experience

### 1. Establish the design brief and inspect the current experience

Consume the approved feature spec and follow-on context when supplied; otherwise establish the standalone brief. Inspect the relevant running route, important states, screenshots, design documents, and implementation constraints. Reuse sufficient current evidence rather than repeating a whole-app audit.

Record separately:

| Category | Meaning |
| --- | --- |
| Business and technical constraints | Data, permissions, validation, workflows, integration, supported components, and required behavior. Existing behavior is evidence; conflicts with the approved spec must be resolved. |
| Retained visual anchors | Established brand, shell, typography or tokens, and useful conventions that actually apply. Record the source and scope. |
| Design problems and freedom | Feature hierarchy, composition, grouping, density, disclosure, component choice, and interactions to reconsider. Existing implementation alone does not make these mandatory. |

Translate the audit into concrete design objectives tied to the user's task. For example, make customer identity and available balance easy to find, preserve scope context while inspecting movements, and keep the primary action accessible with long content.

If examples from other products would resolve a specific design uncertainty, inspect a small set and record the relevant pattern and its applicability. Research supports a decision; browsing galleries is not a required ritual. Do not send private application content to external research services.

### 2. Generate three actual visual concepts

Use the available built-in image-generation capability by default. Retire external ChatGPT upload-pack authoring while preserving consumption of already approved images and packets, as selected by the user. Product Design may provide suitable capabilities when installed; it is not a required dependency.

Each concept is a separate high-fidelity image using the same representative content, task, viewport, retained brand/shell, and business constraints. Vary information hierarchy, composition, disclosure, or interaction strategy in ways the human can compare. Color-only variants and three copies of the existing layout do not meet the default.

Inspect and attach actual visual references when supported. Distinguish brand/shell references from legacy layouts being critiqued. Prompts must not ask the model to preserve the whole legacy screenshot while also expecting a new feature composition.

Give each concept a stable identifier and a short explanation of its task-related tradeoff. Show the images. Inspect for invented data, missing essential content, implausible controls, unreadable density, and departures from scope before asking for selection.

Use approved copy and realistic synthetic data. Generated text and controls remain concepts; they are not permission to change business requirements or authoritative application copy.

### 3. Refine the chosen concept

Support selection, targeted feedback, additional exploration, and combinations of ideas. Resolve a selected image by exact artifact identity rather than submission order alone.

When feedback materially changes the chosen concept, produce the revised visual and show it before building. The human's selection approves exploration of that direction; it does not mark an unbuilt interaction as verified or authorize production integration.

### 4. Build a high-fidelity interactive prototype

Frontend direction may write isolated prototype code before production implementation. Clarify the existing prohibition on coding so it protects production changes without preventing this design work.

Prefer an isolated development surface in the target stack when it is practical and authorized. An isolated HTML/CSS/JavaScript prototype is suitable when the old toolchain would obstruct exploration. State the translation work that remains. Keep prototype state synthetic and local; do not connect exploratory actions to live writes or production routing.

Open the prototype in the user's requested browser, using the Codex in-app browser for `@Browser` when available. Follow the session's actual tool documentation rather than hard-coding obsolete browser API names.

Match the selected visual direction with real elements and working representative interactions. An image with invisible click regions or a polished static happy path is insufficient. Exercise the primary task, important disclosure/navigation behavior, long content, empty/loading/error states where relevant, narrow layout, and keyboard/focus behavior.

The prototype is design evidence, not proof of backend integration or production component compatibility. Check feasibility against the installed frontend stack before approval; identify required component work without using the legacy composition as the automatic fallback.

### 5. Iterate in the browser

Inspect rendered screenshots at comparable viewport and data settings. Compare them with the selected concept and the task objectives. Correct supported visual and interaction problems before presenting the prototype for review.

Apply browser annotations to the identified element and surrounding context. Preserve already approved choices outside the feedback's scope. Iterate until the human accepts the resulting direction; elapsed time, silence, or an iteration count is not approval.

Changes discovered through the browser may supersede details of the original image. Record the final version and what it replaces so implementation never has to guess between competing targets.

### 6. Preserve the approved target and hand it off

Retain a compact packet containing:

- The approved neutral spec or standalone brief, and exact selected concept/version.
- The approved prototype source or durable snapshot, launch instructions, representative data/state setup, and captured desktop/narrow states.
- Reference intent and scope for each binding target, including which final browser captures supersede earlier concepts.
- Business invariants, retained brand/shell, approved design changes, copy source, responsive rules, important interactions, and outstanding limitations.
- Verification expectations for comparing production rendering and interactions against this target.

Approval of the concrete packet covers the listed reference intents; do not ask separately for each routine classification when the approval already covers it. Earlier selections do not imply approval of later unreviewed revisions.

Use the existing `visual-truth`, `semantic-guidance`, and `reference-only` vocabulary. Legacy screenshots normally document the baseline and retained anchors. Final approved browser captures define visual targets within their stated scope. Generated concepts remain historical/reference evidence where the browser iteration supersedes them. Behavioral requirements and accessibility constraints remain authoritative when raster details conflict.

Plans must explicitly consume the packet and binding artifacts in their existing task input fields. Implementation must inspect those artifacts, preserve the chosen hierarchy and interactions, and compare its runtime output before claiming completion. Existing visual verification and fresh-review gates remain in force; do not add review passes merely because a different model implemented the work.

Feed stable, reusable approved decisions into the project's design memory when authorized. Record their scope and provenance. Do not turn one prototype into a global design-system rewrite or overwrite legacy evidence as though it had always described the new direction.

## Optional Impeccable integration

Discover relevant capabilities in the target project's skill locations as well as the session and global catalog. Absence from the current session list alone does not establish absence from the project. Read the installed skill and only the command references needed for the current stage. Command names below describe the inspected installation; resolve actual availability and invocation from the installed version rather than assuming a universal interface.

DashPark's `.agents/skills/impeccable/SKILL.md` reports version 4.3.1. Its `reference/routing.md` distinguishes workflow advice from command execution, and its command references distinguish critique, audit, and polish. This installation is the initial integration test target, not a minimum version or a new dependency.

| Stage and need | Complementary capability | How the result is used |
| --- | --- | --- |
| Standalone substantial screen improvement, before choosing a direction | `critique` for hierarchy, information architecture, cognitive load, and visual quality; `audit` when technical evidence is also needed | Inspect the current target and turn supported findings into design objectives. Do not require a completed brownfield extraction document before the assessment that helps produce it. |
| Interactive prototype review, before final design approval | Targeted `critique`; `audit` for relevant keyboard, state, responsive, or implementation concerns | Use the actual prototype, brief, synthetic-state context, and retained anchors. Feed actionable findings into the existing iteration; reuse current findings rather than starting an automatic full command chain. |
| Production implementation with an approved target | `audit` plus targeted `polish`, `adapt`, `harden`, `clarify`, or another available capability matching an observed issue | Fix in-scope defects, then recheck the changed rendering and interactions against the approved target. An audit reports issues; it does not itself implement fixes. |
| Reusable design decisions have stabilized | `extract` or `document` only when updating design memory is part of the authorized task | Record approved reusable decisions with their scope; do not extract the legacy screen into a new normative design system before redesign. |

Pass the current target, task, retained brand/shell, approved design delta, copy source, implementation constraints, and stage to each invoked capability. During implementation, the approved prototype and its final captures are the visual target. A normalization or polish recommendation must not restore the old layout because neighboring screens or an older DESIGN.md still use it. Use the installed guidance for operational product UI where relevant; decorative novelty is not the goal of an operator screen.

Frontend direction continues to own design selection and the implementation skill owns integration and verification. Focused Impeccable commands supply assessments and corrections inside those scopes. Do not invoke its general shape/redesign workflow to rediscover settled requirements, regenerate the selected concepts, replace the app shell, or rewrite global design documents as an incidental effect. Supported in-scope corrections proceed within existing authorization; a proposed change to the approved direction is returned to the design decision instead of applied silently.

Honor the installed command's actual execution, evidence, and reporting requirements. Record target/version and whether findings came from source inspection, browser observation, detector output, or fixture states. Do not label a manual review as an Impeccable run, or turn an image-only critique into proof of keyboard access, responsive behavior, or accessibility conformance. Scores and clean detector output do not replace specific findings and runtime checks. Reuse equivalent evidence within the active review, while preserving any required reviewer independence.

Choose passes for an observable need, not because every command exists. Keep each automatic assess/fix/confirm pass bounded; new human feedback can start another scoped design iteration. Impeccable's automatic self-QA limits do not imply approval, and user-driven iteration is not an excuse to restart endless automatic polishing.

When the skill or a required capability is unavailable, continue with the core inspection, visual critique, and runtime verification responsibilities using available tools. State the relevant limitation once. Do not auto-install Impeccable, enable hooks, repair its configuration, or block the task merely because optional tooling is absent. Run no initialization or context-document rewrite as a per-feature ritual. A partial or degraded command run is reported as such, without weakening the core quality bar.

Keep this integration in one maintained conditional reference shared by both skills. Rework the existing `impeccable-brownfield-quality-layer.md`, whose current preconditions and preservation bias conflict with standalone assessment and the approved feature-redesign scope. Do not copy the Impeccable playbooks into Superpowers.

## Capability gaps and exceptions

- If sufficient current evidence is unavailable, identify exactly what is missing and which decisions remain uncertain. Never report source inspection as a live browser audit.
- If image generation fails or is unavailable, report it. Offer a browser-first alternative or the image skill's supported fallback; do not silently replace requested images with prompt files or claim generation occurred.
- If the browser cannot run, images may still support exploration. Interaction and responsive verification remain incomplete, and the normal verified packet cannot be claimed. Existing explicitly approved degraded-evidence handling remains available with precise limitations.
- If a user supplies an approved visual target or explicitly chooses another exploration method/count, honor it rather than repeating the default three concepts.
- If the requested scope is a mechanical change within a current approved pattern, use that pattern and proportionate verification.
- If a project instruction protects a feature interaction or component, respect that actual constraint. Distinguish it from an agent's assumption that familiar UI must remain.

## Integration and compatibility

### Reevaluate the implementation skill

The existing `gsd-frontend-design` description spans research, planning, implementation, verification, and refinement. Its source order places existing UI ahead of the approved packet. It also contains useful runtime fidelity checks and evidence boundaries that should survive the redesign.

The proposed replacement is `implementing-frontend-design`, a workflow-independent skill for implementing or verifying an approved visual/interaction target. Its job is to carry design decisions into working code. It does not run open-ended design exploration, require GSD context, or impose a full frontend-direction cycle on a mechanical UI edit.

| Responsibility | Decision |
| --- | --- |
| Design discovery, alternatives, concept refinement, prototype approval | Own in `frontend-direction`. Avoid duplicate orchestration in the implementation skill. |
| Exact approved target, reference scope, state/copy/responsive requirements | Retain in the implementation skill, with a single canonical definition of reference intent and authority. |
| Source precedence | Approved behavior and the current approved design delta govern their scope; retained brand/shell and technical constraints govern theirs. Old UI does not override the approved redesign. |
| Component mapping, production integration, runtime comparison | Retain and focus on implementation. Inspect the actual stack without treating reuse as a requirement to copy old composition. |
| Fixture versus integration proof, unresolved mismatches, fresh visual review | Retain useful existing gates. Fit them into the active workflow without duplicating equivalent review passes. |
| Broad aesthetic tutorials and domain-specific guidance | Keep only material with a demonstrated decision-changing role; route optional platform details progressively. Inspect callers before moving or removing resources. |
| GSD-specific naming and assumed milestone inputs | Remove from the new skill's identity and required inputs. Accept relevant workflow context when present, including from GSD. |

Approved target inputs may come from frontend-direction, an existing current packet, or explicit user-supplied visual/interaction references. Do not require regenerating artifacts solely to satisfy one workflow's filename convention. Clarify genuinely missing requirements before changing their scope.

### Retire machinery without discarding useful evidence

Remove upload-pack authoring's active routing and discoverable skill. Reuse only useful prompt guidance inside the visual-exploration reference; do not move the full old workflow into another file under a new name. Existing images, prompt provenance, packet links, and approved intent remain consumable. Historical documents are not rewritten merely because their generating workflow was retired.

Update actual callers and installation/discovery references when replacing a skill. The local caller inventory found no technical need for aliases, so perform a coordinated rename without shipping a second discoverable skill. Compatibility covers existing design artifacts, not continued invocation of retired skill names. If implementation discovers an active caller outside the writable scope, identify it and provide the required migration rather than silently editing that project or leaving a broken dependency unreported.

The installation at `/Users/gamarsoft/.codex/skills/superpowers` links to this repository's `skills/`; there is no second copy to rewrite. Plugin packaging discovers every top-level skill and requires `agents/openai.yaml`. Update metadata with the standalone entry and narrowed implementation trigger. Migrate active callers in the bootstrap, brainstorming's GSD handoff template, `.github/agents/ui-refinery.agent.md`, `.github/agents/ui-packet-guardian.agent.md`, `docs/gsd/AGENTS.md`, `docs/gsd/preferences.md`, and current frontend-stack documentation. Updating GSD-facing compatibility references is part of this migration, not permission to run GSD orchestration.

The following are the expected change areas. Behavioral evidence and the caller inventory determine the minimum actual edits:

| Area | Required effect |
| --- | --- |
| `skills/frontend-direction/` | Support standalone and follow-on entry; make visual exploration, prototype iteration, and the approved target the outcome. Revise input assumptions, source priority, extraction, packet, and review guidance consistently. |
| `skills/creating-chatgpt-image-upload-packs/` | Retire upload-pack authoring and migrate useful prompt guidance; preserve consumption of existing approved files. |
| `skills/brainstorming/` | Carry design ambition and settled constraints into the follow-on without automatically freezing layout/density/components. Preserve its separate-session and visual-companion contracts. |
| `skills/gsd-frontend-design/` and proposed `skills/implementing-frontend-design/` | Replace the broad legacy skill with focused, workflow-independent implementation guidance; preserve useful fidelity and runtime checks and migrate real callers. |
| `skills/frontend-direction/references/impeccable-brownfield-quality-layer.md` and its callers | Provide a shared optional integration with installed-capability discovery, stage-specific use, approved-target authority, and a complete core path when absent. |
| `skills/writing-plans/` and execution handoffs | Carry packet, binding references, and visual verification through existing input/output and acceptance fields. Change only where omission is demonstrated. |
| Relevant tests and metadata | Retain routing, intent, approval, copy, and runtime-review coverage; update obsolete external-generation assumptions. Preserve unrelated invocation policy and configuration. |

Keep existing approved packets usable under their recorded scope. Do not retroactively reinterpret preservation decisions as redesign authority. Old paths and existing image-pack references require compatible reading or an explicit migration, not broken links.

The brainstorming visual companion continues to support early structural decisions. Its temporary artifacts do not become the final design merely because they were shown in a browser. The dedicated frontend prototype has a different purpose and becomes durable only through the packet's approval and capture process.

## Validation plan

Use `skill-creator` and `superpowers:writing-skills` throughout. Keep the entrypoint focused, load conditional details progressively, and preserve supported metadata. Run the skill creator validator on every changed skill. Structural validation does not establish behavioral quality.

Before changing skill instructions, run and retain fresh-context baseline scenarios against the current workflow and a no-new-guidance control. Use at least five samples per wording variant when micro-testing behavior-shaping wording. Do not expose the intended answer, proposed fix, or previous verdicts to forward-test agents. Record exact actions, artifacts, and relevant rationalizations, and inspect each result manually.

Baseline and candidate runs use the same task and input evidence. Hold the evaluator model/effort, capability access, and task budget constant when comparing variants. Do not score a missing tool as an instruction failure. Fix only demonstrated failures; do not accumulate speculative prohibitions.

Cover these observable cases:

| Scenario | Acceptance evidence |
| --- | --- |
| Substantial legacy feature | Actual distinct image concepts followed by a selected/refined design and interactive browser iteration; brand/shell and business invariants retained. |
| Attractive legacy screenshot with weak workflow | Existing composition is evaluated rather than automatically promoted to a requirement. |
| Approved target handed to a fresh implementation agent | Exact artifacts are inspected and the chosen hierarchy/interactions survive; runtime comparison identifies deviations. |
| Deadline, existing component reuse pressure, and a detailed written packet | The agent does not substitute a legacy reskin or prose-only packet for unresolved design exploration. |
| Selection plus mixed feedback | Exact selected version is resolved; revised visual is shown; final browser target supersedes stale imagery explicitly. |
| Missing image/browser capability | Agent states the real limitation and uses only an authorized fallback; no fabricated screenshots, generation, or verification. |
| Mechanical edit or user-supplied approved target | Agent honors scope without forcing the full exploration loop. |
| Standalone existing-screen improvement with no spec | Agent inspects the target, establishes only the missing brief, and proceeds without requiring a full brainstorming run or fabricated spec approval. |
| Standalone request with an unresolved business rule | Agent identifies the specific blocked product decision instead of inventing behavior or forcing unrelated discovery. |
| Direct invocation versus brainstorming handoff | Both reach the same design-quality bar; settled context is reused and the original implementation/design-only scope is preserved. |
| Replacement implementation skill with no GSD context | Agent consumes the approved target, integrates and verifies it, without requesting milestone files or reopening approved design exploration. |
| Historical image-pack evidence after authoring retirement | Existing approved images and intent are still consumed; the agent does not restart external generation. |
| Impeccable installed only in the target project | Agent discovers and reads the installed capability, then uses appropriate focused assessment/refinement within the current stage. No automatic install or full workflow restart. |
| Impeccable absent or a sub-capability unavailable | Core design and verification continue; the agent accurately reports any command limitation and does not invent an Impeccable result. |
| Impeccable polish suggests legacy normalization contrary to the approved prototype | Agent preserves the approved visual delta, accepts supported in-scope fixes, and surfaces a real design conflict without silently reverting the chosen layout. |
| Optional audit/critique versus actual rendering proof | Reports identify inspected evidence, command/degraded status, and remaining gaps; plugin scores alone never mark the implementation complete. |

Micro-tests prove decisions and instruction clarity, not visual quality. A separate end-to-end pilot must produce images and a runnable prototype, exercise interactions, and retain screenshots. Use the DashPark customer loyalty detail experience as the initial candidate because its existing spec, brownfield packet, and screenshot provide concrete inputs. Confirm the current feature boundary from its source before running the pilot; do not assume historical artifacts describe today's implementation.

For visual comparison, use equal content and viewports and review both baseline and candidate for task clarity, hierarchy, density, consistency with retained anchors, legibility, and state/interaction completeness. Ask the human to judge the actual alternatives and result. Record specific improvements and remaining faults, rather than an invented aggregate beauty score. Human preference alone does not prove usability or backend correctness.

The rewrite is not validated by policy tests alone. Report separately: structural checks, repeated behavioral results, actual image/browser pilot evidence, and human visual review. Mark unfinished evidence honestly.

## Alternatives considered

For skill responsibilities and migration:

| Approach | Benefit | Cost / decision |
| --- | --- | --- |
| Keep `gsd-frontend-design` and narrow its behavior | Existing invocations and external callers continue working. | The GSD-specific name remains misleading for an independent implementation capability. Viable if retaining invocation compatibility is the priority. |
| Replace it with `implementing-frontend-design`, update known callers, no alias | Discovery reflects its specific job; design and implementation have separate entry points without duplicate guidance. | Recommended. Old explicit skill invocations in saved prompts or external configuration need migration. Approved design artifacts remain readable. The known local callers can migrate together. |
| Replace it and retain a forwarding alias | Gives external callers a transition period. | Packages and exposes another skill with ongoing compatibility maintenance and possible duplicate triggering. No discovered local caller requires it; reserve for a concrete compatibility commitment. |
| Merge design and implementation into `frontend-direction` | One skill name and one entry point for end-to-end work. | Broadens the design skill again and loads exploration guidance for agents that only need to execute an approved target. Keep a focused implementation skill instead. |

The recommended clean replacement accepts an invocation-name migration, not an artifact migration. Report the old-to-new name change in the implementation handoff. Do not silently modify other projects' instructions or claim all external callers were discovered.

For visual exploration sequencing:

| Approach | Benefit | Cost / reason not selected as default |
| --- | --- | --- |
| Three image concepts, then refine and prototype the selection | Broad visual exploration before investing in interaction code; selected by the user. | Images can imply infeasible interactions, so browser and stack validation remain necessary. |
| Two browser prototypes first | Earlier interaction comparison and direct code reuse. | More work before visual direction settles; available when explicitly preferred or needed as an approved fallback. |
| Build every generated concept interactively | Strongest side-by-side interaction comparison. | Unnecessary prototype work for rejected directions; reserve for a decision that needs it. |

## Evidence and remaining decisions

Local findings: `skills/frontend-direction/SKILL.md:51`, `skills/frontend-direction/SKILL.md:60`, `skills/frontend-direction/references/design-source-priority.md`, and `skills/creating-chatgpt-image-upload-packs/SKILL.md:20`. DashPark example: `docs/superpowers/specs/2026-06-26--customer-loyalty-detail-dialog--frontend/brownfield-ui-extraction.md` in `/Volumes/Workspace/Development/SolutionPark/DashPark`.

OpenAI Product Design was inspected as a reference, not installed or invoked. Its [ideation source](https://github.com/openai/role-specific-plugins/blob/main/plugins/product-design/skills/ideate/SKILL.md) describes separate image concepts and refinement; its [image-to-code source](https://github.com/openai/role-specific-plugins/blob/main/plugins/product-design/skills/image-to-code/SKILL.md) describes implementing a selected visual. Use current session capabilities and the installed image skill rather than importing every external plugin rule.

No unresolved user preference blocks implementation planning. The user approved the complete specification and selected the Superpowers delivery route on 2026-09-11. Exact resource organization and minimal handoff changes are implementation decisions informed by the baselines. Do not repeat either approval request on resume.
