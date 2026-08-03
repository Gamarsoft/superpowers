# Frontend Skill Stack Reference

Use this when choosing frontend skills after product direction is stable.

## Current Stack

- `superpowers:brainstorming` stabilizes product direction, the approved neutral spec, and route-neutral follow-on context.
- `superpowers:frontend-direction` creates the concise frontend packet once screens/states need implementation-grade direction.
- `superpowers:creating-chatgpt-image-upload-packs` optionally prepares ChatGPT Images 2 prompts when image-native references would clarify a real design decision.
- After the packet is approved, the confirmed delivery route owns planning and execution; use the appropriate frontend implementation or verification skill inside that one lane.
- Mobile skills are composed only when native/mobile-first surfaces are actually in scope.

## Source Model

The durable frontend contract is:

1. approved neutral spec and frontend-direction follow-on context
2. current product UI, design system, components, and tokens
3. concise frontend packet
4. `brownfield-ui-extraction.md`
5. `screen-index.md`
6. retained runtime screenshots, browser captures, simulator/device captures, and optional approved ChatGPT Images 2 files

Delivery routing follows packet approval. A GSD handoff exists only when GSD is the selected route; unselected adapters are absent.

Temporary HTML companion screens are comparison aids only. They become durable only when their chosen decision is captured in packet prose, screenshots/captures, or approved generated images.

## Packet Shape

The default packet should stay short:

1. Summary
2. Source Evidence
3. Screens And States
4. Visual References
5. Implementation Contract
6. Verification
7. Open Questions

Required gates:

- source evidence and degraded-mode honesty
- `Must preserve`, `May adapt`, and `Explicit no-gos`
- UX copy source or copy gap
- reference intent: `visual-truth`, `semantic-guidance`, or `reference-only`
- implementation verification with runtime evidence

## Decision Rules

- Brownfield default: preserve current product language first, improve only inside approved scope.
- Use ChatGPT Images 2 only when a visual decision benefits from generated references; do not make it the default.
- If no approved visual evidence exists, use degraded current-UI mode and keep changes conservative.
- If visible UI copy changes, use `writing-ux-copy` or an approved copy deck.
- For non-trivial UI implementation, require runtime/reference verification and fresh visual review.

## Skill Selection

Use `frontend-direction` when:

- implementation would otherwise invent screen structure, hierarchy, states, or visual treatment
- a brownfield baseline needs capture before change
- a greenfield feature needs an implementation contract
- a temporary companion choice must become durable packet evidence

Use `creating-chatgpt-image-upload-packs` when:

- the packet has a concrete unresolved visual question
- current screenshots and prose are not enough to choose a direction
- the human can generate, save, approve, and classify the resulting files

Use `gsd-frontend-design` inside the selected delivery lane when:

- approved artifacts exist and the task is implementation, verification, or refinement
- the repo needs runtime evidence and reference-intent checks
- source evidence is missing and the task must proceed in degraded current-UI mode

Do not create auxiliary README files inside skill folders. Put durable guidance in `SKILL.md` or targeted `references/` files only.
