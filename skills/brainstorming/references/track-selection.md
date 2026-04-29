# Track Selection

Use this file **before** deep questioning. Pick one track early so the questions, artifacts, and review bar fit the job.

## Decision order

Choose the first track that clearly fits.

1. **Bugfix / regression**
   - The problem is existing behavior that is wrong, broken, unstable, or inconsistent.
   - The main question is "what changed or must stop changing?"
   - You care about current behavior, expected behavior, and unchanged behavior.

2. **Architecture-led change**
   - The main uncertainty is system shape, boundary placement, migration strategy, or enabling infrastructure.
   - The core decision is technical direction more than feature detail.

3. **Greenfield**
   - There is no meaningful existing implementation for this scope.
   - You are defining the initial shape of a feature, subsystem, or product.

4. **Brownfield major feature**
   - The request adds substantial new behavior into an existing system.
   - Multiple integrations, workflows, roles, data boundaries, or rollout concerns are likely.

5. **Brownfield small feature**
   - The request is real but constrained.
   - You expect a short spec, limited integration surface, and a small first delivery boundary.

If multiple tracks seem plausible, choose the **more constrained** one first. You can always expand later.

## Second axis: frontend intensity

After picking the track, decide whether the work also needs the **frontend-direction phase**.

Read `../frontend-direction/references/frontend-direction-phase.md` and treat that decision as orthogonal to the track:

- the track controls discovery and delivery weight
- brainstorming marks frontend direction as required when UI/UX materially shapes implementation
- the frontend-direction phase runs separately after the spec and GSD handoff are approved, usually in a fresh or manually compacted session

---

## Track summaries

## Greenfield

### Goal
Shape a new capability from user/problem framing through first delivery boundary.

### Emphasis
- user and operator clarity
- desired outcome
- first release scope
- milestone candidates
- architecture and interface boundaries

### Required artifacts emphasis
- framing brief
- option cards
- explicit appetite / no-gos
- spec
- example mapping
- GSD handoff
- frontend-direction follow-on prompt **when UI is implementation-shaping**

### Typical question themes
- who is this for?
- what problem are they solving today?
- what should the first release absolutely do?
- what can wait?
- what would make the first milestone feel successful?

---

## Brownfield major feature

### Goal
Add substantial new behavior without breaking existing system integrity.

### Emphasis
- current behavior and current constraints
- integration points
- data ownership and boundary fit
- rollout / migration / compatibility concerns
- observability and failure handling

### Required artifacts emphasis
Everything from greenfield **plus**:
- brownfield context appendix
- invariants
- rollout constraints
- explicit interaction with existing workflows
- frontend-direction follow-on prompt **when new or changed screens materially affect delivery**

### Typical question themes
- where does this hook into the current system?
- what must not break?
- what existing patterns should we preserve?
- what rollout, migration, or support burden does this create?
- what is the safest first slice?

### Guardrails
- inspect current patterns before committing to solution shape
- make the first design-shaping question surface the workflow insertion point plus at least one of: invariant, rollout constraint, migration concern, or compatibility constraint
- do not jump to architecture-heavy options before those constraints are explicit

---

## Brownfield small feature

### Goal
Clarify a small change without turning it into a heavyweight process.

### Emphasis
- smallest safe boundary
- safest integration point
- acceptance examples
- explicit non-goals

### Workflow mode
Use the **lite path**:
- compact framing brief
- one recommended option + one fallback is often enough
- mini boundaries
- short spec
- mini example map
- GSD handoff
- frontend-direction follow-on prompt only when the UI change introduces meaningful new hierarchy, state, or visual-contract ambiguity

### Typical question themes
- what exact behavior should change?
- what should remain unchanged?
- what is the smallest useful first version?
- what existing surface is safest to extend?

### Guardrails
- stay on the lite path
- ask only for the minimum behavior change, the unchanged behavior, and the safest extension point
- prefer one recommended option plus one fallback unless the extra branch is genuinely necessary

---

## Bugfix / regression

### Goal
Stabilize behavior and prevent recurrence.

### Emphasis
- current behavior
- expected behavior
- unchanged behavior
- reproduction
- root-cause hypotheses
- regression coverage

### Required artifacts emphasis
The spec can be short, but it must include:
- reproduction or failure shape
- safety constraints
- acceptance and non-regression examples
- rollout / verification notes if needed
- frontend-direction follow-on prompt only when the fix changes meaningful screen behavior and the visual contract must be re-established

### Typical question themes
- what is failing now?
- how should it behave instead?
- what related behavior must remain unchanged?
- how will we know the fix is complete?
- what tests or examples prevent recurrence?

### Guardrails
- treat the first discovery turn as behavior clarification, not feature ideation
- confirm both the target behavior and the non-regression boundary before discussing solution shape
- ask what must keep working, what reproduces the issue, or what verification would prove the fix is safe
- prefer a recommended target rule over speculative root-cause architecture

---

## Architecture-led change

### Goal
Choose a technical direction, then bound the implementation implications.

### Emphasis
- alternatives considered
- trade-offs and consequences
- migration strategy
- compatibility
- operability
- reversibility

### Required artifacts emphasis
- strong option cards
- decision rationale
- ADR-style appendix in the spec
- explicit GSD milestone recommendation
- frontend-direction follow-on prompt only when architectural choices change how key screens, navigation, or interaction boundaries must work

### Typical question themes
- what is the architectural pain?
- what constraints are already forcing this choice?
- what does each option optimize for?
- what becomes harder under each option?
- how reversible is the choice?

---

## Escalation / decomposition rules

Escalate to decomposition when the request clearly contains several independently shippable systems or domains.

Signs:
- separate user groups with separate workflows
- separate infrastructure concerns
- multiple subsystems that could each produce their own spec
- requests like "build the whole platform" without a clear first milestone

When this happens:
1. name the subsystems
2. describe how they relate
3. suggest an order
4. brainstorm the **first** sub-project only

## Output expectation by track

| Track | Path | Typical spec size | Option format |
|------|------|-------------------|---------------|
| greenfield | full | medium to long | 2–3 option cards |
| brownfield-major-feature | full | medium to long | 2–3 option cards |
| brownfield-small-feature | lite | short | recommended default + fallback |
| bugfix-regression | lite or focused full | short to medium | root-cause / fix strategy options |
| architecture-led-change | full | medium | 2–3 option cards with stronger ADR rationale |
