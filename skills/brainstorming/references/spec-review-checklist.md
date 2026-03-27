# Spec Review Checklist

Use this as the blocking quality bar for both the design spec and the GSD handoff.

## Status language

- **Approved** — no blocking issues
- **Issues Found** — at least one blocking issue
- **Advisory** — useful improvement, but not blocking

## Blocking review categories

## 1. Framing quality
- Is the primary user or operator clear?
- Is the problem statement concrete?
- Is success defined in observable terms?
- Are non-goals explicit?

## 2. Scope and boundaries
- Is the first delivery boundary clear?
- Are rabbit holes and no-gos named?
- For brownfield work, are invariants and unchanged behavior explicit?

## 3. Chosen direction
- Is the recommendation explicit?
- Are alternatives summarized?
- Are trade-offs honest rather than one-sided?

## 4. Behavior and edge cases
- Are the main flows clear?
- Are failure modes or edge cases covered where relevant?
- Is there enough behavioral detail to implement safely?

## 5. System design clarity
- Are components or units understandable?
- Are interfaces and responsibilities clear?
- Are integration points and dependencies named?

## 6. Brownfield safety
- Does the design fit existing patterns?
- Are rollout, migration, compatibility, or support risks named if relevant?
- Is unrelated refactoring avoided?

## 7. Example mapping quality
- Does each major capability have concrete rules and examples?
- Are open questions clearly called out?
- Are deferred / out-of-scope discoveries separated from committed behavior?

## 8. Consistency and completeness
- Any TODO/TBD/placeholder content?
- Any contradictions between sections?
- Any mismatch between the design spec and the GSD handoff?

## 9. GSD handoff completeness
- Are Active / Deferred / Out of Scope separated?
- Is the first milestone recommendation clear?
- Are constraints and integration points explicit?
- Are slice candidates or boundary hints strong enough to seed GSD planning?

## 10. Visual-companion protocol regression checks (conditional, blocking when relevant)
Apply this subsection only when the reviewed design spec or GSD handoff changes, describes, or depends on the visual-companion workflow. If the workflow is not in scope, skip this subsection silently.

Before approving, compare **both** the design spec and the GSD handoff against `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md`.

Fail the review if either artifact is missing, weakens, or contradicts any required outcome below:
- **first-turn startup** — the first later genuinely visual turn must start the companion path instead of remaining terminal-only.
- **artifact-first sequencing** — for each qualifying visual turn, the visual artifact must be authored or refreshed, made viewable, and explained before the terminal decision or confirmation prompt.
- **terminal question-tool continuity** — even after earlier browser use, each qualifying visual turn must still deliver the terminal decision or confirmation prompt through the dedicated question tool when available.
- **explicit degraded fallback** — if the dedicated question tool is unavailable, plain terminal fallback must be named as degraded behavior explicitly rather than normalized as the standard path.

Treat spec↔handoff drift on any of these four outcomes as a blocking issue even if one artifact is correct.

## Advisory checks

- Could any section be shorter and clearer?
- Are there optional diagrams that would materially improve understanding?
- Is there over-engineering not justified by current needs?
- Are there assumptions that deserve stronger evidence?

## Reviewer output format

```markdown
## Spec Review

**Status:** ✅ Approved | ❌ Issues Found

### Blocking Issues
- [Section / file]: [specific issue]
- Why it matters:
- What needs to change:

### Advisory Suggestions
- [optional improvement]
```

## Escalation rule

If the same class of blocking issue survives repeated revisions, surface it to the human rather than endlessly polishing around it.
