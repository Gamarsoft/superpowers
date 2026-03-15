# GSD Handoff Template

Use this after the design spec is stable and example mapping is complete.

Default path:
`docs/superpowers/specs/YYYY-MM-DD--{slug}--gsd-handoff.md`

This file is designed to be the primary vision input when starting or extending work in GSD-2.

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

## 5. Roadmap Seed
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

## 6. Acceptance Seed
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

## 7. Decisions Register Seed
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
- suggests a sensible first milestone
- points to real constraints and integration points
- seeds slice thinking without over-planning every detail

## Using this with GSD-2

For a new GSD project:

1. Start GSD normally.
2. Run `/gsd`.
3. Answer the initial vision prompt by pointing GSD to this file.
4. Tell GSD to treat this file as the primary vision input and only ask follow-ups for contradictions, unresolved unknowns, or missing implementation-shaping decisions.

A good steering note is:

```text
Use docs/superpowers/specs/YYYY-MM-DD--{slug}--gsd-handoff.md as the primary vision input.

Treat the Active requirements as the starting candidate requirements.
Treat Deferred and Out of Scope exactly as written unless you find a contradiction.
Seed the first milestone around the Milestone Recommendation section.
Only ask follow-up questions about unresolved items, contradictions, or missing implementation-shaping decisions.
```

For an existing GSD project, use the handoff with the current discussion flow rather than pretending it is a fresh project vision.
