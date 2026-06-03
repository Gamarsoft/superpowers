---
name: gsd-frontend-design
description: Use when frontend work researches, plans, implements, verifies, or refines user-facing UI, UX, mobile app design, browser behavior, visual evidence, approved packets, screenshots, or generated image references.
---

# Frontend Design

Implement UI from the strongest available product and visual evidence.

## Source Order

Read `references/source-of-truth.md` first.

Use this order:

1. approved spec, handoff, and acceptance criteria
2. existing product UI and design system for brownfield work
3. relevant workflow `CONTEXT.md` or task notes
4. approved frontend direction packet
5. current UI screenshots, browser captures, or simulator/device captures
6. approved ChatGPT Images 2 generated files when the packet selects them
7. `brownfield-ui-extraction.md` and `screen-index.md`
8. approved UX copy deck, terminology, and i18n notes
9. `PRODUCT.md`, `DESIGN.md`, component library, tokens, and app-shell conventions
10. freeform invention only for genuinely unspecified gaps

## Workflow

1. Locate the spec, handoff, packet, screen index, brownfield extraction, screenshots/captures, generated images if any, and existing component patterns.
2. If a workflow artifact says frontend packet status is `required` and no packet exists, stop and run the frontend-direction follow-on prompt first.
3. Extract `Must preserve`, `May adapt`, and `Explicit no-gos`.
4. Build a short visual implementation contract:
   - target route/screen/component
   - binding screenshots, captures, or approved generated images
   - reference intent for each item: `visual-truth`, `semantic-guidance`, or `reference-only`
   - copy source and missing copy states
   - responsive, interaction, accessibility, and state expectations
5. Reuse existing components, tokens, shell, and interaction patterns unless the packet explicitly changes them.
6. Implement the required screens, states, and responsive behavior.
7. Verify with platform-appropriate runtime evidence.
8. For non-trivial UI work, run a fresh-context visual review before completion.

## Runtime Evidence

- Web: browser screenshots, route checks, console/network checks, traces when useful.
- Native Flutter/mobile: widget or golden tests, simulator/device screenshots, `flutter analyze`, `flutter test`, accessibility checks, and UI gallery evidence when available.
- Fixture visual states are allowed for hard-to-reach UI states, but label them as fixture evidence. Do not use fixture evidence to claim backend integration, auth, persistence, or service wiring.
- Raw screenshots, traces, logs, and dumps are verification inputs, not default commit artifacts.

## Reference Intent

- `visual-truth`: visual treatment is binding; compare runtime output against the reference.
- `semantic-guidance`: behavior, hierarchy, content priority, workflow, or state coverage is binding; adapt visuals to the product system.
- `reference-only`: context or exploration, not an acceptance target.

If reference intent is missing or pending, ask before visual changes or record degraded mode.

## Fresh Visual Review

For non-trivial UI work, after implementation and runtime/reference verification:

- spawn a fresh reviewer in the active workflow
- reviewer reads project instructions first: `AGENTS.md`, relevant `.gsd/**/CONTEXT.md`, `PRODUCT.md`, `DESIGN.md`, the task file, slice/milestone instructions, packet, references, and runtime evidence
- for web targets, reviewer uses a fresh browser context when supported; do not reuse the implementer's browser session, storage, console state, or previously opened page
- reviewer independently opens the target route/screen and recaptures required platform evidence for desktop/mobile scope
- implementer screenshots, assertions, or summaries are comparison inputs, not a substitute for reviewer runtime proof
- if the target cannot run or be recaptured due to `ERR_CONNECTION_REFUSED`, connection refused, server unavailable, simulator/device unavailable, route failure, or test harness failure, reviewer must not approve and must use `REQUEST_CHANGES` or `ESCALATE`
- reviewer writes the visual review artifact with findings, verdict, review decision, and `Visual Review Completion Gates`: project instructions read, fresh runtime isolation or recorded fallback, independent runtime recapture, approved reference checklist completion, desktop/mobile platform scope, console/network or Flutter test/log checks, and missing gates

## Guardrails

- Default to brownfield preservation.
- Do not treat generated images as production code.
- Do not let temporary HTML companion artifacts outrank packet prose or approved screenshots/images.
- Do not invent visible copy during coding; use `writing-ux-copy` when copy is missing.
- Do not claim completion for image-backed or screenshot-backed UI until runtime evidence and the reference-intent checklist are complete.

## Quality Bar

A strong implementation:

- matches approved behavior and visual direction
- preserves the current system where required
- covers main states and responsive behavior
- distinguishes live runtime proof from fixture visual proof
- records references used, intent checks, visual waivers, and verification evidence
