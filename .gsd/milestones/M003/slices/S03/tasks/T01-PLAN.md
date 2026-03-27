---
estimated_steps: 4
estimated_files: 4
---

# T01: Add conditional protocol-regression gates to the spec review checklist

**Slice:** S03 — Review loop hardening around the named regression family
**Milestone:** M003

## Description

Turn the checklist into the detailed, conditional source of truth for the M003 review bar so relevant specs and handoffs fail on the same named protocol gaps the authored contract now catches.

## Steps

1. Read `skills/brainstorming/references/spec-review-checklist.md` together with `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md`, `skills/brainstorming/SKILL.md`, and `skills/brainstorming/visual-companion.md`.
2. Add a clearly labeled blocking subsection for visual-companion protocol regression checks that applies only when the reviewed spec or handoff changes, describes, or depends on the visual-companion workflow.
3. Point that subsection to `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md` and list the four required outcomes using the same S02-proved vocabulary: first-turn startup, artifact-first sequencing, terminal question-tool continuity, and explicit degraded fallback.
4. Require the reviewer to compare both the design spec and the GSD handoff against those outcomes, then read back the checklist to confirm the new gate is blocking when relevant and silent when not relevant.

## Must-Haves

- [ ] `skills/brainstorming/references/spec-review-checklist.md` contains a relevance-gated blocking check for visual-companion workflow reviews.
- [ ] The checklist points directly to `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md` and treats all four named protocol outcomes as blocking when missing from the spec or handoff.

## Verification

- Read back `skills/brainstorming/references/spec-review-checklist.md` and confirm the new subsection is explicitly relevance-gated and references the pressure-scenario artifact.
- Read back the same subsection and confirm it tells reviewers to fail missing first-turn startup, artifact-first sequencing, terminal question-tool continuity, and explicit degraded fallback coverage across both the design spec and the GSD handoff.

## Observability Impact

- Signals changed: the blocking review surface in `skills/brainstorming/references/spec-review-checklist.md` gains a conditional visual-companion protocol gate that future reviewers can inspect directly.
- How to inspect later: read the new checklist subsection and confirm it is relevance-gated, points to `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md`, and names the four blocking outcomes across both the design spec and the GSD handoff.
- Failure visibility: missing relevance gating, missing pressure-scenario linkage, or missing coverage for any named outcome should be visible by checklist readback alone.

## Inputs

- `skills/brainstorming/references/spec-review-checklist.md` — the live review checklist that needs the new conditional gate
- `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md` — the authoritative names and expected outcomes for the regression family
- `skills/brainstorming/SKILL.md` — the S02-proved workflow wording the checklist should mirror
- `skills/brainstorming/visual-companion.md` — the S02-proved per-question protocol wording the checklist should mirror

## Expected Output

- `skills/brainstorming/references/spec-review-checklist.md` — updated with a conditional blocking subsection that audits the named M003 pressure scenarios across both spec and handoff review
