# Design Spec Template

Use this for the main written artifact.

Default path:
`docs/superpowers/specs/YYYY-MM-DD--{slug}.md`

## Authoring rules

- Reader-first, not writer-first.
- Put the chosen direction early.
- Keep sections as short as the complexity allows.
- For simple work, a short spec is fine.
- For nuanced work, add appendices rather than bloating the main narrative.
- If a frontend direction packet exists, keep this spec structural and behavioral; link to the packet instead of duplicating detailed visual-system guidance.
- A durable wireframe appendix is optional. Add one only when a spatial or layout decision materially affects later implementation or review.
- Store durable wireframes as separate markdown files in a dedicated sibling folder named after the spec slug, for example `{spec-slug}-wireframes/`.
- Keep each wireframe low-fidelity and structure-first: ASCII sketches, block diagrams, or equivalent are preferred over polished mockups.
- If a frontend direction packet exists later, let the packet inherit from or link back to those wireframes rather than rewriting them.

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
- Key screens or views (only the structural overview)
- Key states
- Failure / edge cases
- Error handling
- Operational or admin behavior if relevant
- Link to frontend direction packet if one exists

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
- Frontend verification link if a frontend direction packet exists

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
[Optional. Link to durable wireframe files in a sibling `{spec-slug}-wireframes/` folder.]

## Appendix E. Frontend Direction Packet
[Only if applicable. Link to `{spec-slug}--frontend-direction.md` and the supporting asset folder.]

Example:
- [Frontend direction packet]({spec-slug}--frontend-direction.md) — selected visual direction, state coverage, responsive rules, and implementation contract
- [Screen index]({spec-slug}--frontend/screen-index.md) — key screens and state coverage
- [Prompt pack]({spec-slug}--frontend/stitch-prompt-pack.md) — reusable generation prompts and review notes
- [Stitch source manifest]({spec-slug}--frontend/stitch-sources.json) — exact Stitch screen mapping and mirror paths when Stitch is used

## Appendix F. Decisions / ADR Notes
[Only if architectural trade-offs matter]

## Appendix G. GSD Handoff Seed
[Short seed or link to the handoff file.]
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
- stays consistent with the frontend direction packet when one exists
- is consistent with the handoff file
