---
name: frontend-direction
description: Use after product direction is stable but UI/UX direction is not, especially when brownfield frontend work needs a concise implementation packet, screen inventory, screenshots, visual-reference intent, or browser-grounded evidence before code changes.
---

# Frontend Direction

Create a compact UI implementation contract before frontend code is written.

Default durable evidence is:

1. approved neutral spec and frontend-direction follow-on context
2. current product UI and design system
3. browser/runtime screenshots or simulator/device captures
4. concise packet prose
5. optional approved ChatGPT Images 2 references when image exploration is explicitly useful

A GSD handoff is supplemental input only when one already exists for a confirmed GSD route, such as when refreshing a packet. Initial UI-heavy shaping normally finishes before delivery routing.

Do not use this as a coding skill.

## Outputs

Write only what the implementation agent needs:

- `docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend-direction.md`
- `docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend/screen-index.md`
- `docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend/brownfield-ui-extraction.md` for brownfield work
- `docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend/screenshots/` when visual evidence is gathered
- `docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend/chatgpt-image-2/` only when generated image references are requested or materially reduce ambiguity

## Read Order

1. `references/design-source-priority.md`
2. `references/frontend-packet-folder-template.md`
3. `references/brownfield-ui-extraction-template.md` for brownfield work
4. `references/screen-index-template.md`
5. `references/frontend-direction-template.md`
6. `../creating-chatgpt-image-upload-packs/SKILL.md` only when image references are needed
7. relevant mobile skills only when native or mobile-first direction is in scope
8. `references/frontend-review-checklist.md`
9. `references/frontend-packet-completeness-checklist.md`

## Workflow

1. Gather the approved neutral spec, frontend-direction follow-on context, acceptance criteria, current screenshots if present, relevant `PRODUCT.md`/`DESIGN.md`, component patterns, and running-app evidence. Include a GSD handoff only for an already confirmed GSD route.
2. For brownfield work, capture current runtime truth before improving anything: desktop, narrow/mobile, and key states when they affect the change.
3. Create `brownfield-ui-extraction.md` that separates must-preserve patterns, safe improvements, and no-gos.
4. Build a small `screen-index.md` for only key screens and implementation-shaping states.
5. If visible text changes or appears in image prompts, use `writing-ux-copy` and record the copy source.
6. Decide whether ChatGPT Images 2 references are useful. If yes, create the prompt pack, stop for human generation/approval, then list approved images in the packet.
7. Write the frontend direction packet using the compact template.
8. Classify every implementation-facing screenshot, generated image, browser capture, or retained reference as `visual-truth`, `semantic-guidance`, or `reference-only`.
9. Ask for human approval when a reference-intent classification will affect implementation.
10. Review the packet against the checklist, remove redundant prose, and obtain packet approval.
11. Only after the packet is approved, return to `../brainstorming/references/delivery-routing.md` for route confirmation and the single selected adapter. Do not create routing metadata or start implementation from this phase.

## Operating Rules

- Current product UI outranks generated imagery in brownfield work unless the human explicitly approves a visual change.
- Use screenshots and browser captures as evidence; use prose to state decisions.
- HTML companion artifacts are temporary decision aids. If an idea survives, summarize the decision in packet prose and attach durable screenshots or approved images.
- Generated images are `reference-only` until approved and assigned an intent mode.
- Keep `Must preserve`, `May adapt`, and `Explicit no-gos` short and concrete.
- Do not duplicate product requirements from the spec; link them.
- If direction cannot be stabilized, keep the packet `required-pending`. Use `approved-with-degraded-evidence` only after recording the degraded constraints and obtaining explicit approval instead of inventing certainty.

## Quality Bar

A strong packet lets another agent implement without asking:

- what screens and states are in scope
- what current UI patterns must remain
- what visual changes are approved
- which screenshots or generated images are binding
- what copy source to use
- how to verify the result
