# Frontend Implementation Review Checklist

Use before declaring UI work done.

## 1. Input Fidelity

- Did you read the spec, handoff, acceptance criteria, workflow context, frontend direction packet, `screen-index.md`, `brownfield-ui-extraction.md`, selected visual-truth source, and available screenshots/captures first?
- If a handoff or `CONTEXT.md` said frontend packet status was `required`, did you stop instead of implementing from degraded assumptions?
- If ChatGPT Images 2 is selected, did you read the exact approved generated image files and their approved reference intent?
- If brownfield, did you inspect existing tokens, components, shell patterns, interaction patterns, and current rendered UI?
- If no packet or approved visual-truth source existed, did you state degraded mode honestly?

## 2. Reference-Intent Gate

For reference-backed UI work, completion requires an approved reference-intent checklist.

For each `visual-truth` image or retained screenshot, record `pass`, `mismatch`, or `waived` for:

- surfaces and containers
- control emphasis and button hierarchy
- typography and numeric emphasis
- spacing rhythm and alignment
- section order and section visual weight
- responsive/mobile flow
- key states named in the packet

For each `semantic-guidance` reference, record `pass`, `mismatch`, or `waived` for:

- required behavior or workflow
- information hierarchy and content priority
- state coverage
- product-system adaptation
- explicitly non-binding visual details

If reference intent is missing, ask for confirmation before visual changes. If confirmation is unavailable, do not treat the reference as visual truth; record degraded mode or a blocker.

Captured screenshots alone are not evidence. State what was visually inspected and whether it matches.

A waiver must name the source, approved intent, mismatch, implementation constraint, accepted fallback, and follow-up needed.

## 3. Preserve, Adapt, No-Gos

- Did you preserve the shared shell, product language, and current baseline unless change was explicitly approved?
- Did you implement approved visual changes rather than dismiss them as brownfield preservation?
- Did typography, spacing rhythm, color roles, and control priority stay consistent with the packet and existing system?
- Did you avoid drifting into a new aesthetic thesis?
- Did you change anything the packet marked as must-preserve?
- If yes, did you document the deviation and whether the packet needs a follow-up update?

## 4. Screen, State, And Copy Coverage

- Are key screens/components and required viewports implemented?
- Are loading, empty, error, validation, permission, destructive, disabled, hover, pressed, and focus states covered where required?
- If live data could not produce required visual states, were visual fixtures contract-shaped and clearly labeled as fixture proof?
- If new or changed copy was introduced, did you use `writing-ux-copy` or an approved copy deck before coding?
- Are i18n keys, formatting rules, translation expansion, accessible names, and missing copy states covered?

## 5. Interaction And Accessibility

- Are keyboard and screen-reader paths preserved?
- Are overlays, dialogs, forms, and responsive layouts usable and predictable?
- For native/mobile-first work, did mobile interaction guidance cover navigation, forms, gestures, permissions, text scaling, tap targets, semantics, safe areas, and compact constraints?

## 6. Verification

- Did runtime evidence support the reference-intent checklist?
- For web targets, did browser evidence include relevant screenshots, route checks, console/network checks, or traces?
- For native Flutter targets, did evidence include widget tests, golden tests, simulator/device screenshots, analysis/test commands, accessibility checks, or UI gallery verification?
- If fixture mode was used, did the artifact distinguish live runtime proof from fixture visual-state proof?
- If raw screenshots, traces, console logs, or network dumps were persisted, were they kept under temporary, ignored, or external redaction-safe storage unless explicitly requested as commit artifacts?

## 7. Fresh Visual Review

- For non-trivial UI work, did a fresh-context reviewer perform the final visual quality review?
- Did the reviewer read project instructions first, including `AGENTS.md`, `.gsd/**/CONTEXT.md`, `PRODUCT.md`, `DESIGN.md`, the task file, and slice or milestone instructions?
- For web targets, did the visual reviewer use a fresh browser context and avoid reusing the implementer's browser session, storage, console state, or previously opened page?
- Did the visual reviewer independently open the target route/screen and recapture required evidence?
- If the target route/screen could not be opened due to `ERR_CONNECTION_REFUSED`, connection refused, server unavailable, simulator/device unavailable, route failure, or test harness failure, did the review avoid approval and use `REQUEST_CHANGES` or `ESCALATE`?
- Did the visual review artifact include `Visual Review Completion Gates` with project instructions read, fresh runtime isolation or recorded fallback, independent runtime recapture, approved reference checklist completion, desktop/mobile platform scope, console/network or Flutter test/log checks, and every missing gate called out?

## 8. Recovery

- Can another agent recover the same frontend references from your recorded output?
- Did you keep `Frontend References` current when workflow artifacts are in scope?
- Did you avoid claiming completion from tests, DOM checks, or screenshot capture without reference-intent inspection?
