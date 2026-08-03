# GSD Handoff Template

Use this only after the neutral design spec and example mapping are approved, the user has confirmed GSD as the delivery route, and the frontend packet gate is satisfied. For UI-heavy work, this handoff is generated only after packet status is `approved` or `approved-with-degraded-evidence`; it consumes that packet and never sends work back to frontend direction. For work that does not require frontend direction, packet status is `not-required`.

Default path:
`docs/superpowers/specs/YYYY-MM-DD--{slug}--gsd-handoff.md`

This file is the primary implementation-shaping vision input when starting or extending work in GSD, alongside the linked spec and, when UI is implementation-shaping, the approved frontend direction packet.

## Template

```markdown
# GSD Handoff

## 1. Project Brief

### Vision
[Short statement of the outcome]

### Primary user-visible outcome
[What changes for users or operators]

### Why now
[Why this matters now]

## 2. Requirements Seed

### Active
- R1. [required capability / behavior]
- R2. [required capability / behavior]

### Deferred
- D1. [explicitly deferred]
- D2. [explicitly deferred]

### Out of Scope
- O1. [explicitly excluded]
- O2. [explicitly excluded]

## 2a. Requirements Reconciliation

Fill this section whenever an existing `.gsd/REQUIREMENTS.md` or prior milestone requirements already cover part of the same domain.

### Reused unchanged
- [existing requirement ID] - [why it still applies as-is]

### Reactivated from deferred
- [existing requirement ID] - [what is now active and why]

### Narrowed / split / clarified
- [existing requirement ID] - [how this handoff narrows or splits it]

### Superseded for this scope
- [existing requirement ID] - [what older wording no longer fits and what replaces it]

### Still deferred
- [existing requirement ID] - [what remains deferred after this handoff]

Do not leave overlap implicit. If a new Active item touches a previously active, validated, or deferred requirement, explain the relationship here.

## 3. Milestone Recommendation

### First milestone
[What should milestone 1 accomplish?]

### Why first
[Why this is the right first milestone]

### Success criteria
- [observable success]
- [observable success]

### Key risks / unknowns
- [risk]
- [risk]

## 4. Context Seed

### Relevant codebase / prior art
- [file, system, pattern, or repo area]
- [file, system, pattern, or repo area]

### Constraints
- [technical]
- [product]
- [brownfield / rollout / support]

### Integration points
- [surface]
- [surface]

### Open questions
- [question]
- [question]

## 5. Frontend Build Inputs

### Packet status
not-required | required-pending | approved | approved-with-degraded-evidence

`required-pending` is part of the shared vocabulary but is invalid in a generated GSD handoff. Stop before generating this template until the packet becomes `approved` or the user explicitly approves every degraded constraint as `approved-with-degraded-evidence`.

### Frontend direction packet
- [path or none]

### Supporting frontend artifacts
- `brownfield-ui-extraction.md`:
- `screen-index.md`:
- retained current UI screenshots / browser captures:
- implementation runtime screenshots / browser captures:
- approved generated image references:
- visual reference intent approvals:
  - `visual-truth`:
  - `semantic-guidance`:
  - `reference-only`:
  - degraded current-UI mode:
  - pending / blocker:

### Downstream frontend guidance
- Skills / docs to load:
  - `gsd-frontend-design`
  - [repo-local framework or design-system guidance]
- Evidence to preserve:
  - approved packet path
  - retained screenshots and runtime captures
  - approved generated image paths and prompt pack metadata, if used
  - source evidence from current UI, product docs, or design docs

### UX implementation contract
- Must preserve:
- May adapt:
- Explicit no-gos:
- UX copy source:
  - approved copy deck:
  - missing copy states:
  - terminology rules:
  - i18n variables / formatting:
  - copy acceptance criteria:

### Frontend implementation gate
- `not-required` means no frontend packet is needed for this scope.
- `approved` means the linked frontend packet is the durable UI implementation contract.
- `approved-with-degraded-evidence` means the linked packet and every explicitly approved degraded constraint are the durable UI implementation contract.
- `required-pending` must never reach this generated handoff; resolve that gate in brainstorming before GSD routing or generation.
- Do not treat unapproved screenshots, temporary companion screens, or generated images as visual truth.
- If approved degraded evidence limits visual certainty, preserve those explicit limits rather than inventing missing evidence.

## 6. Roadmap Seed

### Slice candidates
1. [slice]
2. [slice]
3. [slice]

### Risk order
[Which slices first and why]

### Depends-on notes
- [dependency]
- [dependency]

### Boundary map hints
- [produces]
- [consumes]

## 7. Acceptance Seed

### Rules
- [rule]
- [rule]

### Examples
1. Given ...
   When ...
   Then ...

2. Given ...
   When ...
   Then ...

### Validation ideas
- [test/proof]
- [test/proof]

### UAT notes
- [operator/user check]
- [operator/user check]

## 8. Decisions Register Seed

### Chosen direction
[summary]

### Alternatives rejected
- [alternative] - [why rejected]
- [alternative] - [why rejected]

### Trade-offs accepted
- [trade-off]
- [trade-off]
```

## Quality bar

A strong handoff:

- lets GSD reflect the vision back with minimal reinterpretation
- distinguishes Active, Deferred, and Out of Scope requirements before planning starts
- explicitly reconciles overlapping existing requirements instead of creating parallel truths
- suggests a sensible first milestone
- points to real constraints and integration points
- points to frontend inputs explicitly when UI work is in scope
- preserves UX copy, state coverage, rollout, evidence, and verification details needed for implementation
- preserves approved packet, runtime capture, screenshot, visual reference intent, and generated image details when frontend work is in scope
- seeds slice thinking without over-planning every task

## Using This With GSD

For a new GSD project:

1. Start GSD normally.
2. Run `/gsd`.
3. Answer the initial vision prompt by pointing GSD to this file.
4. Tell GSD to treat this file as the primary vision input and only ask follow-ups for contradictions, unresolved unknowns, or missing implementation-shaping decisions.

A good steering note is:

```text
Primary artifacts:
- Spec: docs/superpowers/specs/YYYY-MM-DD--{slug}.md
- GSD handoff: docs/superpowers/specs/YYYY-MM-DD--{slug}--gsd-handoff.md
- Frontend direction: docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend-direction.md (if present)
- Frontend packet status: not-required / approved / approved-with-degraded-evidence

Use the spec as the product and behavior contract.
Use the handoff as the milestone and requirements seed.
If the frontend direction packet exists, use it as the UI implementation contract.
This GSD handoff is generated only after the frontend packet gate is approved; if its status is `approved-with-degraded-evidence`, preserve every explicitly approved degraded constraint.

Treat the Active requirements in the handoff as the starting candidate requirements.
Treat Deferred and Out of Scope exactly as written unless you find a contradiction.
If an existing `.gsd/REQUIREMENTS.md` overlaps, use Requirements Reconciliation before creating parallel requirements.
Seed the first milestone around the Milestone Recommendation section.
Keep the primary artifacts aligned:
- the spec owns product scope, behavior, and rules
- the handoff owns GSD seeding, milestone framing, and implementation intake guidance
- the frontend direction packet, when present, owns layout, hierarchy, states, responsive behavior, and UI implementation constraints

After the frontend direction packet exists, also consume:
- brownfield-ui-extraction.md
- screen-index.md
- retained current UI screenshots and browser captures
- implementation runtime screenshots and browser captures
- approved generated image paths and prompt pack metadata, if used
- visual reference intent approvals

For frontend implementation after the packet exists, load:
- gsd-frontend-design
- any repo-local framework, design-system, or implementation guidance named in the packet

Use the frontend packet, runtime captures, retained screenshots, and approved generated image references as durable UI inputs after they exist.
Respect approved visual reference intent modes in the packet. `visual-truth` references require visual parity; `semantic-guidance` references require behavior, content-priority, and state-fit; `reference-only` references are not acceptance targets.
If visual reference intent is missing or pending after frontend-direction, ask for confirmation or record degraded current-UI mode before treating the reference as a redesign or visual parity target.
Do not treat temporary HTML companion screens from brainstorming as binding unless the separate frontend-direction packet captures the decision in durable prose, screenshots, browser captures, or approved generated images.
Do not invent a new visual direction unless the handoff explicitly says redesign.
Only ask follow-up questions about unresolved items, contradictions, or missing implementation-shaping decisions.
```

When handing this off to a human or to GSD, include the steering note with the real artifact paths filled in.

For an existing GSD project, use the handoff with the current discussion flow rather than pretending it is a fresh project vision.
