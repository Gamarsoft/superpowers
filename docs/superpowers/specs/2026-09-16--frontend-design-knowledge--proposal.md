# Frontend design knowledge integration proposal

Status: approved for implementation by the user's 2026-09-16 instruction to commit this proposal, merge the current branch into `gamarsoft`, create a new feature branch and proceed.

## Objective and selected approach

Improve the design decisions and implemented interfaces produced by `frontend-direction` and `implementing-frontend-design`. Preserve the existing visual exploration, approved packet, delivery ownership and independent runtime review.

The user selected reviewed references on 2026-09-16: maintain focused knowledge within Superpowers references, with optional installed helpers supplying additional findings. Do not install a collection of new design workflows.

This proposal follows `skill-creator` and `superpowers:writing-skills`. Suspected gaps below are hypotheses to test, not demonstrated behavioral failures. No candidate skill wording should be authored before the relevant baseline evaluation.

## Evidence inspected

- User research: `docs/superpowers/references/ui-ux-fondamental-skills-research.md`.
- Current frontend direction skill, packet template, review checklist and shared Impeccable integration.
- Current frontend implementation skill and implementation review checklist.
- DashPark's installed Impeccable 4.3.1 entry point and `reference/operate.md`.
- Upstream `wondelai/skills` design-everyday-things and refactoring-ui entry points, Vercel web-design-guidelines and ibelick fixing-accessibility, inspected on 2026-09-16.
- W3C's contrast-minimum guidance, as an authoritative source for reviewing accessibility claims.

The current workflow provides strong artifact identity, approval and fidelity checks. Its direction review asks whether the primary task improves, but offers limited method for comparing competing interaction and visual choices. Its implementation review includes accessibility and interaction checks, but many remain broad questions. These observations justify evaluation, not an assumption that adding instructions will improve results.

Impeccable is present in DashPark, including operational-interface guidance. Discovery alone does not prove its relevant knowledge is used in a design session. Its entry point also owns orchestration and tooling; reading a reference and running an Impeccable command must remain distinct.

## Proposed integration

| Existing point of work | Knowledge to supply selectively | Observable contribution |
| --- | --- | --- |
| Inspect target and set objectives | Task model, discoverability, control-to-effect mapping, feedback, recovery; operational-interface guidance where applicable | Identify where the user cannot decide, act, understand the result or recover. Connect each objective to observed evidence or an explicit hypothesis. |
| Generate concepts and refine selection | Visual priority, grouping, density, type, spacing, semantic color and disclosure | Alternatives differ in how they support the task. Explain a concrete benefit and cost of each; avoid cosmetic variants with identical interaction problems. |
| Exercise prototype before approval | Task walkthrough and focused usability critique | Test the suspected problem, including relevant failure and recovery states, in the existing prototype iteration. |
| Implement approved target | Semantic controls, component-specific keyboard/focus behavior, long content, responsive layout, feedback and motion | Apply checks relevant to the actual changed controls, with source findings and runtime checks. |
| Existing independent review | Exact-reference fidelity plus task and implementation evidence | Distinguish faithful rendering from usable behavior and distinguish observed facts from inferred benefits. Reuse existing review and approval gates. |

Keep `writing-ux-copy` authoritative for terminology, localization and state copy. Consult it through existing entry points; do not introduce a competing copy framework.

### Knowledge ownership

Add concise supporting references only where baseline failures justify them. Likely responsibilities are interaction reasoning, visual composition and web implementation checks. Keep shared authority and source provenance in one place. Link references from the relevant stage rather than loading every source for every frontend request.

Use original, task-focused explanations and small reviewed adaptations. Before retaining adapted source material, inspect its license, record repository/path and immutable revision, preserve required notices and document corrections. An upstream skill name alone does not establish provenance for its supporting references.

Source candidates:

- `design-everyday-things`: interaction diagnosis. Exclude self-assigned perfection scores and arbitrary universal timing tests.
- `refactoring-ui`: hierarchy, grouping and visual relationships. Review accessibility claims and density assumptions; examples do not authorize Tailwind or token changes.
- Impeccable: operational-product and relevant craft guidance, plus focused optional critique/audit. Do not inherit categorical preferences without checking their fit to the task.
- Vercel Web Interface Guidelines: implementation review material. Review and pin the actual guidelines, not merely the small skill that fetches them from `main`.
- `fixing-accessibility`: focused control-level checks. Verify simplified rules against W3C/WAI guidance and component interaction patterns before adoption.

Defer UI UX Pro Max, interface-design, ux-heuristics and motion specialists until evaluations reveal a specific uncovered need. Their absence must not block the core path.

### Applied reasoning and findings

For a consequential design decision, retain a short chain in the existing evidence/decisions section:

Observed problem or hypothesis → affected user task → relevant principle → proposed change and tradeoff → verification result or remaining uncertainty.

For example, the Credipark pager required scrolling to reach it and then moved the user back up. A candidate correction separates parking breakdown from movements and reserves space for pagination. Its tradeoff is an extra tab switch for parking information. Verification checks pager visibility, scrolling, focus and page-change feedback at the required viewport sizes. Do not claim measured task-speed gains from this walkthrough.

Use this where it clarifies a meaningful choice, not as paperwork for every color or spacing value. Carry the important rationale into the packet's existing sections. Do not create a second design-system authority or require a new packet schema solely for prose reasoning. Existing approved packets remain consumable without regeneration.

### Conflict handling

- Approved business behavior, technical constraints, copy and retained brand/shell continue to govern.
- During exploration, a heuristic informs the tradeoff; it does not automatically ban density, modals, familiar controls or an established component.
- During implementation, fix defects within the approved scope. If a supported accessibility or usability finding requires changing the approved behavior or composition, describe the conflict and proposed resolution for a focused design decision. Do not silently redesign or hide the issue behind reference fidelity.
- Separate normative requirements, contextual heuristics and aesthetic preferences. Neither an external score nor a visual preference establishes compliance.
- Preserve explicit exploration limits, standalone entry, small-edit routing and the image-concept/browser-prototype default for substantial unresolved direction.
- Keep in-app browser selection under the existing browser guidance. Use additional testing capabilities when a concrete required check warrants them; this proposal does not broaden into a browser-tooling rewrite.

## Delivery sequence after proposal approval

1. **Source and coverage audit.** Review the candidate sources and relevant installed references. Record immutable provenance, license requirements, rejected prescriptions and overlap with current guidance. Produce a small mapping of hypothesized gaps to source material and observable evaluations.
2. **Direction skill baseline.** Use isolated scenarios with no new guidance and the current skill. Capture actual choices and artifacts. Classify demonstrated failures using writing-skills before selecting the minimum correction. If a hypothesized failure does not occur, do not add its guidance.
3. **Direction candidate and verification.** Add only supported references, stage links and any necessary packet-template/checklist adjustments. Use five or more fresh-context samples per wording variant, manually inspect outputs and run held-out application scenarios. Validate and complete this skill's deployment checks before editing the implementation skill.
4. **Implementation skill baseline and candidate.** Repeat the same cycle against approved targets, preserving packet authority. Add component-specific checks where demonstrated failures warrant them. Feed results into the existing implementation review instead of adding a new mandatory reviewer or approval stage.
5. **Artifact-level pilot.** Compare actual designs and implemented interfaces under matched tasks, content, constraints and viewports. Keep evaluation artifacts isolated from DashPark production and its approved Credipark packet. Review the results before broad adoption.

Create the full per-skill writing-skills checklist during execution. Run quick_validate and applicable packet/helper or infrastructure regressions for changed contracts. Do not replace behavioral evidence with wording/heading assertions. Version-control the evaluated changes through the agreed delivery workflow; no upstream publication is implied.

## Evaluation cases and acceptance

| Case | What the evaluation must distinguish |
| --- | --- |
| Dense operator ledger with hidden pagination | Task-efficient density, stable controls and context versus decorative whitespace or superficial restyling. |
| Unavailable action and recoverable failure | Understandable prerequisite/result/recovery versus a merely attractive disabled control. |
| Three concepts for the same task | Meaningful alternatives and explicit tradeoffs versus cosmetic changes or invented business behavior. |
| Approved dialog with custom tabs and asynchronous paging | Correct control semantics, focus and feedback versus screenshot fidelity alone. |
| Long translated labels and narrow layout | Usable reflow and retained information versus clipping or hiding essential data. |
| Helper advice conflicts with brand, stack or approved target | Appropriate scoped resolution versus silent migration, normalization or redesign. |
| No Impeccable installed; mechanical copy edit; legacy approved packet | Useful core behavior without setup, unnecessary exploration or artifact regeneration. |

Use fresh evaluators without the intended answer or previous conclusions. For visual artifact comparison, conceal which instruction variant produced each candidate where practical. Evaluate task clarity, hierarchy/grouping, information access, interaction completion, responsive behavior and scoped implementation fidelity. Record concrete findings and preference reasons rather than a universal numerical beauty score.

Use Credipark as a known regression example and include an unfamiliar form or operational screen to test transfer. The existing approved design is a protected reference, not permission to reopen or replace it. Browser walkthroughs and agent judgments are useful evidence but do not establish real-user usability or productivity gains.

Acceptance requires demonstrated improvement on the targeted baseline failures, no critical regression in scope/authority/behavior cases, and an independently inspected artifact result. Small sample sizes and unresolved findings must remain visible. If a source adds volume without improving decisions or artifacts, remove it.

## Decisions and boundaries

- Selected: reviewed references within the existing workflows, with optional helpers.
- Proposed first delivery: direction knowledge first, then implementation checks, each independently evaluated.
- Preserve: current approval gates, canonical packet identity, backward compatibility, stack, copy ownership and reviewer independence.
- Not authorized by this proposal: production UI changes, modifying approved DashPark artifacts, bulk skill installation, changing helper invocation policies, hooks or global configuration.
- Proposal approved on 2026-09-16. Continue on a new feature branch from `gamarsoft`, with a durable implementation plan and the per-skill evaluation sequence above. This document remains the design specification, not the implementation plan.

## External sources

- https://github.com/wondelai/skills/blob/main/design-everyday-things/SKILL.md
- https://github.com/wondelai/skills/blob/main/refactoring-ui/SKILL.md
- https://github.com/vercel-labs/agent-skills/blob/main/skills/web-design-guidelines/SKILL.md
- https://github.com/vercel-labs/web-interface-guidelines/blob/main/command.md
- https://github.com/ibelick/ui-skills/blob/main/skills/fixing-accessibility/SKILL.md
- https://www.w3.org/WAI/WCAG22/Understanding/contrast-minimum.html

These discovery links are mutable. Pin reviewed revisions before incorporating external material into maintained references.
