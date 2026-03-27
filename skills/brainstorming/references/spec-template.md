# Design Spec Template

Use this for the main written artifact.

Default path:
`docs/superpowers/specs/YYYY-MM-DD--{slug}.md`

## Authoring rules

- Reader-first, not writer-first
- Put the chosen direction early
- Keep sections as short as the complexity allows
- For simple work, a short spec is fine
- For nuanced work, add appendices rather than bloating the main narrative
- A durable wireframe appendix is optional. Add one only when a spatial or layout decision materially affects later implementation or review.
- Store durable wireframes as separate markdown files in a dedicated sibling folder named after the spec slug, for example `{spec-slug}-wireframes/`.
- Keep each wireframe low-fidelity and structure-first: ASCII sketches, block diagrams, or equivalent are preferred over polished mockups.
- Name wireframe files in a stable review order such as `01-screen-name.md`, `02-dialog-name.md`, and tie each file to a specific decision and short rationale.
- In the spec doc, add an appendix that links to the wireframe files with one-line descriptions of the screen or state each file preserves.
- Do not create wireframe files for every visual turn or as routine paperwork.
- If a later GSD handoff depends on those wireframes, link back to the existing appendix rather than duplicating it.

## Main template

```markdown
# [Feature / Project Name]

## 1. Executive Summary
- What this is
- Who it is for
- Why now
- What the first delivery boundary is

## 2. Framing Brief
- Primary user / operator
- Job / problem
- Current workaround / current behavior
- Desired outcome
- Success signal
- Constraints
- Non-goals

## 3. Chosen Direction
- Recommended option
- Why it wins now
- What is consciously deferred

## 4. Scope and Boundaries
- In scope
- Out of scope
- Rabbit holes
- No-gos
- Invariants / unchanged behavior (if applicable)

## 5. User Experience / Behavior
- Primary flows
- Key states
- Failure / edge cases
- Error handling
- Operational or admin behavior if relevant

## 6. System Design
- Components / units
- Responsibilities
- Data flow
- Interfaces / boundaries
- Dependencies and integration points
- Rollout / migration / compatibility notes (if applicable)

## 7. Risks and Unknowns
- Known risks
- Assumptions
- Open questions
- Mitigations or follow-up checks

## 8. Validation Plan
- What must be tested or verified
- Key acceptance checks
- Observability / rollout checks if needed

## 9. Open Questions
- Questions intentionally left open
- What decision they block, if any

## Appendix A. Options Considered
[Summarized option cards]

## Appendix B. Brownfield Context
[Only if applicable]

## Appendix C. Example Mapping
[Use the example-mapping template]

## Appendix D. Wireframes
[Optional. Link to durable wireframe files in a sibling `{spec-slug}-wireframes/` folder. Use one bullet per file with a short description.]

Example:
- [Master-detail layout]({spec-slug}-wireframes/01-master-detail-layout.md) — overall page structure with search, results list, and detail pane
- [Profile stacked sections]({spec-slug}-wireframes/02-profile-stacked-sections.md) — header, metrics, bookings, note, and merge candidates

## Appendix E. Decisions / ADR Notes
[Only if architectural trade-offs matter]

## Appendix F. GSD Handoff Seed
[Short seed or link to the handoff file. If existing wireframe files materially shape implementation, the later handoff may link back to this appendix.]
```

## Optional track-specific sections

### Bugfix / regression
Add:
- current behavior
- expected behavior
- unchanged behavior
- reproduction shape
- non-regression plan

### Architecture-led change
Add:
- alternatives considered
- consequences
- migration path
- reversibility

### Brownfield major feature
Add:
- current integration points
- ownership and boundary fit
- rollout and support implications

## Quality bar

A strong spec:

- says who it is for
- says what problem it solves
- says what is not in scope
- makes the chosen direction explicit
- names risks honestly
- includes enough behavior detail to build or hand off safely
- is consistent with the handoff file
