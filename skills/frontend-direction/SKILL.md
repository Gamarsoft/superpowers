---
name: frontend-direction
description: Use when a feature needs visual and interaction direction, or an existing screen needs substantial UX improvement, including standalone requests without a brainstorming spec.
---

# Frontend Direction

Produce a design the human has seen and exercised, then preserve that target for implementation. In brownfield work, retain established brand and app shell while reconsidering the feature's hierarchy, layout, density, and interactions. Existing behavior is evidence; existing composition is not automatically a requirement.

## Choose the entry and scope

| Situation | Start here |
| --- | --- |
| Approved brainstorming spec and follow-on exist | Reuse their settled decisions and invoking workflow. |
| Standalone screen improvement | Inspect the named target and fill the small brief below. No separate spec, follow-on prompt, or full brainstorming pass is required. |
| New unresolved business rule or permission model | Resolve that specific product decision before dependent design; use fuller brainstorming when broader shaping is needed. |
| Current approved visual target exists | Consume it; reopen only the requested design decisions. |
| Mechanical edit with settled direction | Use the existing implementation workflow; skip concept exploration. |

**Standalone brief:** target and primary user task; problem; scope and required behavior; retained brand/shell and technical constraints; design objectives; important states; design-only or implementation too. Keep it inside the packet. Fill observable facts from inspection and ask only questions that change the design. Existing authorization is enough to begin; another brief sign-off is not a prerequisite.

Read [scoped design authority](references/design-source-priority.md) before choosing references.

## Design loop

For **substantial unresolved visual direction**, use this default sequence. Explicit user choices govern a different exploration scope.

1. **Inspect and set objectives.** Inspect current runtime, relevant source, design docs, and state evidence. Separate business constraints, retained anchors, and design problems using the [brownfield extraction](references/brownfield-ui-extraction-template.md). Reuse sufficient current evidence. Optional [Impeccable assessment](references/impeccable-brownfield-quality-layer.md) can inform this inspection before an extraction document exists.
2. **Generate three distinct image concepts.** Use built-in imagegen to render three separate high-fidelity UI alternatives with equal content, viewport, brand/shell, and constraints. Vary hierarchy, composition, disclosure, or interaction strategy. These are images **of the interface**, not decorative illustrations; an operator screen still benefits from comparing designs. Read [visual exploration](references/visual-exploration.md) for reference handling and prompting. Show actual images with stable IDs and task-related tradeoffs, then obtain a choice.
3. **Refine the selection.** Resolve exact concept/version. Incorporate scoped feedback or combinations; show a revised visual when feedback materially changes the selected concept. Selection approves exploration of that direction, not production integration.
4. **Build an isolated interactive prototype.** Use real elements and synthetic local state. Prefer the target stack when practical; standalone HTML/CSS/JS is acceptable when the legacy toolchain obstructs exploration. State the remaining translation work. Open in the requested [browser surface](references/browser-surface-selection.md), inspect the selected design, and exercise primary interactions, important states, narrow layout, and keyboard/focus behavior.
5. **Iterate and preserve the target.** Correct observed problems; use annotations and human feedback to refine the relevant area. Retain source, launch/state instructions and final captures. Record which browser version supersedes earlier imagery. Ask for approval of the concrete final direction; selection, silence, or an iteration count is not final approval.
6. **Finalize and hand off.** Follow [packet finalization](references/packet-finalization.md): preserve the approved bytes, separate history, write the canonical `packet.md` and `packet.json`, and validate the current artifact set. Use the [packet template](references/frontend-direction-template.md), [folder layout](references/frontend-packet-folder-template.md) and [screen/state index](references/screen-index-template.md). Review actual quality and acceptance with the [quality checklist](references/frontend-review-checklist.md) and [completion checks](references/frontend-packet-completeness-checklist.md). Hand off the entry path, exact revision, descriptor SHA-256 and remaining limits. File validation establishes identity, not design quality or human approval.

## Boundaries and continuation

- This skill may write isolated prototypes. Production integration follows the approved direction and the user's implementation scope. Prototype actions stay local and synthetic.
- Missing image/browser capability: report what is unavailable and what remains unverified; use an explicitly authorized alternative. Do not substitute a prose packet for the requested visual loop or claim tools ran. Optional Product Design capabilities may help when installed; no plugin is required.
- Use `writing-ux-copy` or an approved copy source for visible text, including prompts. Generated text does not redefine application copy or business rules.
- Legacy approved images and packets remain readable with their recorded scope. No upload-pack authoring or external generation handoff is needed.
- Keep a required unresolved packet `required-pending`. `approved-with-degraded-evidence` needs explicit approval of the listed limitations. One approval of the concrete packet covers its listed reference intents; do not request duplicate classification approvals.
- Follow-on mode returns the approved packet to the invoking workflow. For brainstorming, return to its delivery router after approval. Standalone design-only work ends with the approved packet; an authorized implementation request continues through the appropriate implementation workflow without a mandatory route-selection ceremony.
- Approved reusable decisions may update design memory when in scope; one prototype does not authorize a global design-system rewrite.
