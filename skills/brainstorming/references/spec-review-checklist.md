# Spec Review Checklist

Use this as the blocking quality bar for the approved neutral spec, optional frontend-direction follow-on prompt, frontend packet status, and any adapter created after route confirmation.

## Finding dispositions

- `BLOCKING` — a proved, causally connected defect that can make the current
  artifact stage violate its approved product contract, safety boundary, or
  required handoff contract.
- `DECISION` — unresolved observable WHAT, route authority, or protected,
  destructive, or external authority the author cannot choose.
- `FOLLOW_UP` — a real adjacent issue or improvement outside the first delivery
  boundary that does not block this artifact stage.
- `INVALID` — unsupported, contradicted, already covered, HOW-only, or a style
  preference with no concrete failure.

Every `BLOCKING` or `DECISION` item must include proof from the reviewed
artifacts, a candidate causal connection to the artifact or handoff being
changed, and a concrete failure. Use `READY` only when no supported `BLOCKING`
or `DECISION` remains; otherwise use `NOT READY`. Do not add another severity
scale.

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
- Any mismatch between the neutral spec and the artifacts valid for the current stage?

## 9. Delivery adapter validity (conditional, blocking when relevant)
- Before route confirmation, are both the `## Delivery Route` metadata and all adapters absent?
- For UI-heavy work, is routing deferred until the frontend packet is approved, including explicit approval of any degraded evidence?
- After route confirmation, does exactly one adapter match the selected route?
- Is every unselected adapter and unselected route artifact absent?
- Does the Delivery Route section record the recommendation and concrete fit evidence, the neutral-review and user-approval references, and the confirmation reference?
- During selected-adapter review, is `Delivery review` still `pending` so this review can independently decide it?
- Before transition, is that status replaced by `approved` with the independent reviewer reference?

## 9a. GSD handoff completeness (only when GSD is the selected route)
- Are Active / Deferred / Out of Scope separated?
- If existing `.gsd/REQUIREMENTS.md` or prior milestone requirements overlap, does the handoff reconcile them explicitly?
- Does the handoff say which requirements are reused, reactivated, narrowed, superseded, or still deferred?
- Is the first milestone recommendation clear?
- Are constraints and integration points explicit?
- Are slice candidates or boundary hints strong enough to seed GSD planning?

## 10. Frontend-direction follow-on prompt quality (conditional, blocking when relevant)
Apply this section when the work clearly depends on frontend direction.

- Does the follow-on context mark frontend packet status as `required-pending` when no packet exists yet?
- Does the follow-on prompt link the approved neutral spec and remain route-neutral?
- Does it carry screen families, primary flows, key states, first delivery boundary, and brownfield invariants?
- Does it preserve visual-companion decisions as context rather than durable design truth?
- Does it require reference-intent approval for every implementation-facing screenshot, generated image, or retained visual reference?
- Does it block both delivery routing and UI implementation until the separate frontend-direction packet is approved?

## 10a. UX writing readiness (conditional, blocking when relevant)
Apply this section when the work includes meaningful user-visible UI copy.

- Did the author invoke `writing-ux-copy` or otherwise provide an equivalent copy deck?
- Does the spec or follow-on context identify copy-bearing states: default, loading, empty, validation, warning, error, permission, destructive confirmation, pending, and success where relevant?
- Are final or explicitly pending visible strings captured for labels, CTAs, warnings, errors, empty states, confirmations, helper text, and onboarding?
- Are technical terms, backend service names, and internal state names kept out of user-facing copy unless they are established product terminology?
- Are terminology, i18n variables, plural/date/number formatting, translation expansion, and accessibility labels covered?
- If ChatGPT Images 2 prompts are expected, does the follow-on prompt require production-quality visible text in the prompts before image generation?
- Are copy acceptance criteria included so implementation and review can verify the approved words, not invent new ones?

## 11. Cross-artifact UI alignment (conditional, blocking when relevant)
- Do the spec, follow-on prompt, frontend packet, and selected adapter (when one exists) agree on scope and behavior?
- Are deferred visual ideas kept out of Active requirements?
- Can the next frontend-direction agent tell what product decisions are settled and what visual work remains?

## 11a. Requirement lineage alignment (blocking only for the selected GSD route)
Apply this subsection when the new work overlaps with an existing `.gsd/REQUIREMENTS.md`, earlier milestone requirements, or previously deferred work in the same area.

- Does the selected GSD handoff avoid silently duplicating or contradicting existing requirements?
- If a formerly deferred requirement is now partly active, is the reactivated subset explicit and is the remainder still deferred explicitly?
- If older active or validated wording is now too broad, does the handoff mark the new narrower rule as a clarification or supersession for this scope?

## 12. Visual-companion protocol regression checks (conditional, blocking when relevant)
Apply this subsection only when the reviewed artifacts change, describe, or depend on the visual-companion workflow. If the workflow is not in scope, skip this subsection silently.

Before approving, compare the relevant artifacts against `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md`.

Fail the review if the artifacts are missing, weaken, or contradict any required outcome below:
- **first-turn startup** — the first later genuinely visual turn must start the companion path instead of remaining terminal-only
- **artifact-first sequencing** — for each qualifying visual turn, the visual artifact must be authored or refreshed, made viewable, and explained before the terminal decision or confirmation prompt
- **terminal question-tool continuity** — even after earlier browser use, each qualifying visual turn must still deliver the terminal decision or confirmation prompt through the dedicated question tool when available
- **explicit degraded fallback** — if the dedicated question tool is unavailable, plain terminal fallback must be named as degraded behavior explicitly rather than normalized as the standard path

Treat drift among the spec, packet, and the selected adapter (when one exists) on any of these outcomes as a blocking issue even if one artifact is correct.

## Follow-up checks

- Could any section be shorter and clearer?
- Are there optional diagrams or screenshots that would materially improve understanding?
- Is there over-engineering not justified by current needs?
- Are there assumptions that deserve stronger evidence?

## Reviewer output format

```markdown
## Spec Review

ID | Disposition | Location | Proof | Candidate causal connection | Concrete failure | Required resolution

Verdict: READY | NOT READY
```

## Escalation rule

If the same class of blocking issue survives repeated revisions, surface it to the human rather than endlessly polishing around it.
