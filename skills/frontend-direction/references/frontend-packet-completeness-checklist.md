# Frontend Packet Completeness Checklist

Use before handing a packet to implementation.

## Blocking Checks

- Packet links the approved spec and handoff.
- Brownfield work includes current UI evidence or explicitly states degraded mode.
- `screen-index.md` names only key screens and important states.
- `brownfield-ui-extraction.md` separates must-preserve, safe improvements, and no-gos when brownfield.
- Every implementation-facing screenshot, browser capture, generated image, or retained reference has intent: `visual-truth`, `semantic-guidance`, or `reference-only`.
- Implementation-affecting intent is approved or marked as a blocker.
- Approved visible copy source is named, including terminology, i18n variables, and accessibility labels when relevant.
- `Must preserve`, `May adapt`, and `Explicit no-gos` are concrete.
- Required runtime screenshots/captures and checks are named.
- ChatGPT Images 2 files are listed only when generated references were actually approved.

## Concision Check

- Remove duplicated product requirements already covered by the spec.
- Remove exploratory options that were rejected.
- Prefer one screenshot or row over a paragraph when it communicates the same decision.
