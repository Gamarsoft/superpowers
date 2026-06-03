# Source of Truth

Read this before planning, designing, or changing UI code.

## Functional Contract

1. Approved spec, handoff, and acceptance criteria.
2. Workflow context such as milestone or slice `CONTEXT.md`.
3. Current product behavior when the spec is silent.

## Visual Contract

1. Existing product UI and design system.
2. Approved frontend direction packet.
3. Current UI screenshots, browser captures, or simulator/device captures.
4. Approved generated image references when the packet selects them.
5. `brownfield-ui-extraction.md` and `screen-index.md`.
6. Approved UX copy deck and i18n notes.
7. `PRODUCT.md`, `DESIGN.md`, component library, tokens, and shell conventions.
8. Fresh-context visual review artifacts.
9. Impeccable critique/audit findings as quality review evidence.
10. Freeform invention only for unspecified gaps.

`DESIGN.json` is auxiliary tooling output.

## What To Extract Before Coding

- affected route, screen, component, and states
- must-preserve patterns
- may-adapt areas
- explicit no-gos
- binding screenshots, captures, or approved generated images
- reference intent and approval status
- copy source, terminology, and i18n variables
- responsive, interaction, accessibility, and verification expectations

## When Sources Disagree

- Preserve current product truth unless the packet intentionally changes it.
- Prefer existing system primitives when the packet is silent.
- If an approved reference conflicts with the product system, implement only the in-scope approved delta.
- If intent is missing, ask or record degraded mode.
- Treat HTML companion artifacts as temporary decision context, not durable implementation evidence.
- Use Impeccable findings as review input, not authority to redesign.

## Evidence Boundaries

- Live runtime proof shows integration, auth, routing, feature flags, tenant context, persistence, and service wiring for available states.
- Visual fixture proof shows hard-to-reach UI states, responsive behavior, copy, action hierarchy, and reference-intent fit.
- Runtime screenshots, traces, console logs, network dumps, Flutter logs, and device captures are not default commit artifacts.

## Degraded Mode

If no approved packet or visual reference exists, say so and preserve the existing product UI. Do not use degraded mode to bypass a handoff that requires a packet.
