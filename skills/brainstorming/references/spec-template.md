# Design Spec Template

Use this for the main written artifact.

Default path:
`docs/superpowers/specs/YYYY-MM-DD--{slug}.md`

## Authoring Rules

- Reader-first, not writer-first.
- Put the chosen direction early.
- Keep sections as short as the complexity allows.
- Compact does not mean lossy: preserve implementation-shaping details, constraints, states, copy sources, and open questions.
- For simple work, a short spec is fine.
- For nuanced work, add appendices rather than bloating the main narrative.
- If frontend direction is required, keep this spec structural and behavioral; link the follow-on prompt or later packet instead of duplicating detailed visual-system guidance.
- A durable wireframe appendix is optional. Add one only when a spatial or layout decision materially affects later implementation or review.
- Store durable wireframes as separate markdown files in a dedicated sibling folder named after the spec slug, for example `{spec-slug}-wireframes/`.
- Keep each wireframe low-fidelity and structure-first: ASCII sketches, block diagrams, or equivalent are preferred over polished mockups.
- If a frontend direction packet exists later, let the packet inherit from or link back to those wireframes rather than rewriting them.

## Main Template

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
- Invariants / unchanged behavior, if applicable

## 5. User Experience / Behavior
- Primary flows
- Key screens or views, only the structural overview
- Key states
- Failure / edge cases
- Error handling
- Operational or admin behavior, if relevant
- UX writing / copy contract:
  - copy deck path or inline copy table
  - missing copy states
  - terminology rules
  - i18n variables and formatting notes
  - copy acceptance criteria
- Link to frontend-direction follow-on prompt or packet, if applicable

## 6. System Design
- Components / units
- Responsibilities
- Data flow
- Interfaces / boundaries
- Dependencies and integration points
- Rollout / migration / compatibility notes, if applicable

## 7. Risks and Unknowns
- Known risks
- Assumptions
- Open questions
- Mitigations or follow-up checks

## 8. Validation Plan
- What must be tested or verified
- Key acceptance checks
- Observability / rollout checks, if needed
- Frontend verification link, if a frontend direction packet exists later

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

## Appendix E. Frontend Direction
[Only if applicable. Link to the follow-on prompt now, and later to `{spec-slug}--frontend-direction.md` and the supporting asset folder.]

Example:
- [Frontend-direction follow-on prompt](#) - prompt to create the frontend packet in a separate session
- [Frontend direction packet]({spec-slug}--frontend-direction.md) - selected visual direction, state coverage, responsive rules, and implementation contract
- [Screen index]({spec-slug}--frontend/screen-index.md) - key screens and state coverage
- [Brownfield UI extraction]({spec-slug}--frontend/brownfield-ui-extraction.md) - preserve vs improve analysis for current product truth
- [Runtime screenshots and browser captures]({spec-slug}--frontend/) - retained current UI evidence and implementation proof
- [Approved generated image references]({spec-slug}--frontend/) - optional ChatGPT Images 2 references, if explicitly used and approved
- [Reference intent notes]({spec-slug}--frontend-direction.md) - visual-truth, semantic-guidance, reference-only, or degraded current-UI mode decisions

## Appendix F. Decisions / ADR Notes
[Only if architectural trade-offs matter]

## Appendix G. GSD Handoff Seed
[Short seed or link to the handoff file.]
```

## Optional Track-Specific Sections

### Bugfix / Regression

Add:
- current behavior
- expected behavior
- unchanged behavior
- reproduction shape
- non-regression plan

### Architecture-Led Change

Add:
- alternatives considered
- consequences
- migration path
- reversibility

### Brownfield Major Feature

Add:
- current integration points
- ownership and boundary fit
- rollout and support implications

## Quality bar

A strong spec:

- says who it is for
- says what problem it solves
- makes the chosen direction explicit
- says what is not in scope
- preserves relevant constraints, no-gos, and unchanged behavior
- names risks and assumptions honestly
- includes enough behavior detail to build or hand off safely
- captures important states, failure behavior, rollout concerns, and UX copy sources when applicable
- links frontend direction, runtime evidence, screenshots, and approved generated image references when applicable
- stays consistent with the handoff file
