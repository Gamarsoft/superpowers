# GSD Handoff Template

Use this after the design spec is stable and example mapping is complete.

Default path:
`docs/superpowers/specs/YYYY-MM-DD--{slug}--gsd-handoff.md`

This file is designed to be the primary implementation-shaping vision input when starting or extending work in GSD-2, alongside the linked spec and, when UI is implementation-shaping, the separate frontend direction packet created after brainstorming.

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
- [existing requirement ID] — [why it still applies as-is]

### Reactivated from deferred
- [existing requirement ID] — [what is now active and why]

### Narrowed / split / clarified
- [existing requirement ID] — [how this handoff narrows or splits it]

### Superseded for this scope
- [existing requirement ID] — [what older wording no longer fits and what replaces it]

### Still deferred
- [existing requirement ID] — [what remains deferred after this handoff]

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
none | required | attached

Use `required` when brainstorming determined that UI/UX materially shapes implementation but the frontend-direction phase has intentionally been deferred to a separate session.

### Frontend direction packet
- [path or none]

### Frontend-direction follow-on prompt
- [paste/link prompt or none]

### Supporting frontend artifacts
- `brownfield-ui-extraction.md`:
- `screen-index.md`:
- `pencil-workset.md`:
- repo-local `.pen` files:
- retained screenshots:
- board intent approvals:
  - `visual-truth`:
  - `semantic-guidance`:
  - `reference-only`:
  - pending / blocker:

### Pencil skills to load downstream
- `gsd-frontend-design`
- `pencil-design-core`
- [chosen adapter]

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
- Frontend implementation gate:
  - If packet status is `required`, do not implement frontend UI yet.
  - Run the separate frontend-direction phase first and attach its approved packet.
- Board intent rule:
  - Do not treat an unapproved board as visual truth.
  - If board intent is missing or pending, ask for confirmation before visual changes.

## 6. Roadmap Seed

### Slice candidates
1. [slice]
2. [slice]
3. [slice]

### Risk order
[Which slices should come first and why]

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
- [test or proof]
- [test or proof]

### UAT notes
- [operator or user checks]
- [operator or user checks]

## 8. Decisions Register Seed

### Chosen direction
[summary]

### Alternatives rejected
- [alternative] — [why rejected]
- [alternative] — [why rejected]

### Trade-offs accepted
- [trade-off]
- [trade-off]
```

## Quality bar

A strong handoff:

- lets GSD reflect the vision back with minimal reinterpretation
- already distinguishes active vs deferred vs out of scope
- explicitly reconciles overlapping existing requirements instead of silently creating parallel truths
- suggests a sensible first milestone
- points to real constraints and integration points
- points to frontend inputs explicitly when UI work is in scope
- names the exact downstream Pencil skills and adapter
- seeds slice thinking without over-planning every detail

## Using this with GSD-2

For a new GSD project:

1. Start GSD normally.
2. Run `/gsd`.
3. Answer the initial vision prompt by pointing GSD to this file.
4. Tell GSD to treat this file as the primary vision input and only ask follow-ups for contradictions, unresolved unknowns, or missing implementation-shaping decisions.

A good steering note is:

```text
Primary artifacts for this work:
- Spec: docs/superpowers/specs/YYYY-MM-DD--{slug}.md
- GSD handoff: docs/superpowers/specs/YYYY-MM-DD--{slug}--gsd-handoff.md
- Frontend direction: docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend-direction.md (if present)
- Frontend-direction follow-on prompt: included below / linked separately (if packet status is required)

Use the GSD handoff as the primary milestone/requirements seed.
Use the spec as the canonical product and behavior contract.
If the frontend direction packet exists, use it as the canonical UI implementation contract.
If packet status is `required`, do not implement frontend UI yet. First run the follow-on frontend-direction prompt in a fresh or compacted session, then return to GSD with the approved packet.

Treat the Active requirements in the handoff as the starting candidate requirements.
Treat Deferred and Out of Scope exactly as written unless you find a contradiction.
If an existing `.gsd/REQUIREMENTS.md` already covers related capabilities, use the Requirements Reconciliation section to decide what is reused, reactivated, narrowed, superseded, or still deferred before creating parallel requirements.
Seed the first milestone around the Milestone Recommendation section.
Keep the three primary artifacts aligned:
- the spec owns product scope, behavior, and rules
- the handoff owns GSD seeding, milestone framing, and implementation intake guidance
- the frontend direction packet, when present, owns layout, hierarchy, states, responsive behavior, and UI implementation constraints
- the frontend-direction follow-on prompt owns the next-session bootstrap only until the packet exists

After the frontend direction packet exists, also consume:
- brownfield-ui-extraction.md
- screen-index.md
- pencil-workset.md
- repo-local Pencil `.pen` files
- retained screenshots

For frontend implementation after the packet exists, load:
- gsd-frontend-design
- pencil-design-core
- the adapter named in the packet

Use the frontend packet and Pencil workset as the durable UI references after they exist.
Respect approved board intent modes in the packet after it exists. `visual-truth` boards require visual parity; `semantic-guidance` boards require behavior, content-priority, and state-fit; `reference-only` boards are not acceptance targets.
If board intent is missing or pending after frontend-direction, ask for confirmation before treating the board as a redesign or visual parity target.
Do not treat temporary HTML companion screens from brainstorming as binding unless the separate frontend-direction packet translates them into durable Pencil and packet artifacts.
Do not invent a new visual direction unless the handoff explicitly says redesign.
Only ask follow-up questions about unresolved items, contradictions, or missing implementation-shaping decisions.
```

When handing this off to a human or to GSD, always include the corresponding steering note with the real artifact paths filled in.

For an existing GSD project, use the handoff with the current discussion flow rather than pretending it is a fresh project vision.
