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
