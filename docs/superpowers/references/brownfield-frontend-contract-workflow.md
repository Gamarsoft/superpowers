# Brownfield Frontend Contract Workflow

Use this for brownfield UI work where the running product is part of the design truth.

## Principle

Do not start from code alone and do not start from imagined mockups. Capture the current screen, extract the product system, approve the bounded change, then implement from a compact packet plus runtime evidence.

## Evidence Order

1. approved neutral spec and frontend-direction follow-on context
2. current route/screen in the running app
3. existing components, tokens, theme files, and neighboring screens
4. `brownfield-ui-extraction.md`
5. `screen-index.md`
6. retained screenshots/browser captures
7. optional approved ChatGPT Images 2 files

A GSD handoff is supplemental evidence only for a confirmed GSD route. It is not required while shaping the frontend packet.

If evidence is missing, record degraded current-UI mode and keep the change conservative.

## Workflow

1. Capture the baseline: desktop, narrow/mobile, and required states.
2. Extract `Must preserve`, `May adapt`, and `Explicit no-gos`.
3. Identify source of UX copy or mark copy gaps.
4. Decide whether generated image references are useful. If not, stay with screenshots/captures and packet prose.
5. Classify every reference as `visual-truth`, `semantic-guidance`, or `reference-only`.
6. Write or update the concise frontend packet.
7. After the packet is approved, confirm one delivery route using `skills/brainstorming/references/delivery-routing.md`.
8. Implement through the selected lane, using its appropriate frontend implementation skill.
9. Verify with runtime evidence and the reference-intent checklist.
10. For non-trivial UI, run fresh visual review before completion.

## Brownfield Boundaries

Preserve:

- product shell and navigation model
- core workflows and data density
- design-system tokens and shared components
- known accessibility and interaction contracts

May adapt when approved:

- local layout rhythm
- state presentation
- copy clarity
- responsive prioritization
- visual hierarchy inside the affected scope

No-gos unless explicitly approved:

- new product-wide visual language
- unrelated screen redesign
- replacing shared primitives for local taste
- treating optional generated images as binding without reference intent

## Verification

Completion requires:

- browser or platform runtime evidence
- source/reference paths recorded in the task or context artifact
- reference-intent parity or intent-fit checklist
- live-vs-fixture claim boundaries when fixtures are used
- waiver for any unresolved mismatch, naming the source, intent, mismatch, constraint, accepted fallback, and follow-up

Captured screenshots are evidence inputs, not proof by themselves.
