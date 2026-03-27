---
estimated_steps: 4
estimated_files: 4
---

# T01: Add selective low-fidelity wireframe appendix guidance to the shared spec template

**Slice:** S04 — Selective wireframe appendix guidance and integrated closure
**Milestone:** M003

## Description

Teach the live spec template when a durable wireframe appendix is worth preserving so future specs can carry forward spatial decisions without normalizing wireframe appendices as routine output.

## Steps

1. Read `skills/brainstorming/references/spec-template.md` with the reusable pattern in `docs/superpowers/specs/2026-03-30--brainstorming-visual-companion-protocol-hardening.md` and the scope boundary in `skills/brainstorming/references/gsd-handoff-template.md`.
2. Add template guidance that a wireframe appendix is optional, only for durable spatial decisions that materially improve later implementation or review, and should not be created for every visual turn.
3. Define the expected form as low-fidelity and structure-first, tied to a specific decision and short rationale, and seed the note that the later GSD handoff may link back to an existing appendix when relevant.
4. Read back `skills/brainstorming/references/spec-template.md` and confirm the shared template now carries the optionality, guardrails, and handoff-link allowance without rewriting the shared handoff template.

## Must-Haves

- [ ] `skills/brainstorming/references/spec-template.md` says durable wireframe appendices are optional, selective, and reserved for spatial decisions that materially affect later implementation or review.
- [ ] The template keeps wireframes low-fidelity and decision-tied, makes clear they are not routine for every visual turn, and allows the handoff to link to an existing appendix when relevant.

## Verification

- Read back `skills/brainstorming/references/spec-template.md` and confirm it now states optional/selective use, dedicated sibling wireframe-folder plus linked-appendix pattern, low-fidelity structure-first form, durable spatial triggers, and handoff-link allowance.
- Confirm by readback that the guidance lives in the spec path and does not require edits to `skills/brainstorming/references/gsd-handoff-template.md`.

## Inputs

- `skills/brainstorming/references/spec-template.md` — the live shared spec template that currently lacks the narrow wireframe-appendix rule
- `docs/superpowers/specs/2026-03-30--brainstorming-visual-companion-protocol-hardening.md` — the reusable Appendix D pattern for low-fidelity, decision-tied wireframe carry-forward
- `skills/brainstorming/references/gsd-handoff-template.md` — the boundary reminder that the handoff template itself stays unchanged in this slice
- `.gsd/milestones/M003/slices/S04/S04-RESEARCH.md` — the slice-specific scope, risks, and proof reminders for R041

## Expected Output

- `skills/brainstorming/references/spec-template.md` — updated with selective low-fidelity wireframe appendix guidance and a spec-seeded handoff-link allowance for relevant handoffs

## Observability Impact

- Signals changed: the shared spec template now exposes explicit, inspectable authoring guidance for when a durable wireframe appendix should exist, what low-fidelity form it should take, and when a later handoff may link back to it.
- How to inspect later: read back `skills/brainstorming/references/spec-template.md` directly and run `rg -n "wireframe|low-fidelity|handoff" skills/brainstorming/references/spec-template.md` to localize the new guidance quickly.
- Failure visibility: if the task regresses, readback or targeted search will show which part is missing — optional/selective use, durable spatial trigger, low-fidelity structure-first form, or handoff-link allowance — without needing runtime debugging.
