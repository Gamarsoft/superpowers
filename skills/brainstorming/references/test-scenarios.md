# Test Scenarios

Use these pressure scenarios when evolving the skill. They are not part of the runtime flow; they exist to keep the skill aligned with `writing-skills` discipline.

## Scenario 1 — vague greenfield
User says:
> I want to build a smart internal portal for the team.

Failure if:
- the skill asks several open-ended questions in a row
- no framing brief appears
- no recommended option is given

## Scenario 2 — too-big platform request
User says:
> Build a full marketplace with chat, billing, reviews, analytics, and admin.

Failure if:
- the skill tries to spec the whole thing at once
- it does not decompose into sub-projects
- it does not choose the first sub-project

## Scenario 3 — major brownfield feature
User says:
> Add approval workflows to the existing invoicing system.

Failure if:
- the skill does not inspect current patterns
- it ignores rollout / migration / invariant questions
- it jumps straight to abstract architecture

## Scenario 4 — small brownfield feature
User says:
> Add a duplicate button to the current template screen.

Failure if:
- the workflow becomes heavyweight
- the skill asks broad platform questions
- it fails to use the lite path

## Scenario 5 — indecisive user
User says:
> I don't know, what do you think is best?

Failure if:
- the skill responds with another open-ended question
- it does not sharpen the recommendation

## Scenario 6 — bugfix
User says:
> Saving a draft sometimes wipes the assignee.

Failure if:
- the skill treats it like a brand-new feature
- it fails to capture current / expected / unchanged behavior
- it does not ask about regression safety

## Scenario 7 — visuals would help
User says:
> I'm torn between two onboarding layouts.

Failure if:
- the skill does not offer the visual companion as its own message
- it uses the browser for non-visual trade-offs

## Scenario 8 — platform question tool
User says:
> I want to build a smart internal portal for the team.

Failure if:
- the skill uses a plain-text guided question when the platform question tool is available
- the skill does not steer the first confirmation or discovery turn through the current platform's dedicated question tool

## Scenario 9 — repo-specific brainstorming context
User says:
> Add OAuth login to the existing app in this repo.

Failure if:
- the skill skips `gathering-topic-context` and jumps straight to generic design questions
- it does not use topic-specific codebase context before reflection or track selection
- it treats the request like pure greenfield ideation

## Scenario 10 — outcome-first does not mean premature convergence
User says:
> Use the newer GPT guidance and keep this brainstorming session efficient. I want approval workflows in the existing invoicing system.

Failure if:
- the skill treats efficiency as a reason to skip guided discovery
- it writes the spec before user value, first delivery boundary, invariants, rollout concerns, and failure behavior are stable
- it fails to carry remaining implementation-shaping unknowns as explicit open questions

## Scenario 11 — no workflow preference
User says:
> The spec looks good. What should happen next?

Failure if:
- the skill creates any adapter before route confirmation
- it adds `## Delivery Route` metadata before the user confirms exactly one route
- it recommends from route availability alone instead of explaining which delivery-shape evidence in the approved spec determines the best fit
- it does not ask the user to confirm exactly one available route

## Scenario 11a — contained immediate delivery
Approved spec says:
> Add one backward-compatible flag to an existing script. Keep the plan inline and implement it in this task.

Failure if:
- it recommends GSD or Superpowers merely because those routes are available
- it fails to recommend Native Codex as the immediate contained-slice fit

## Scenario 11b — bounded durable planned delivery
Approved spec says:
> Build this bounded validator from a durable implementation plan with TDD, task-by-task execution, and review.

Failure if:
- it recommends GSD merely because GSD is available
- it fails to recommend Superpowers as the bounded task-planned delivery fit

## Scenario 11c — milestone continuity
Approved spec says:
> Deliver the catalog across independently shippable milestones and preserve roadmap lineage into later workstreams.

Failure if:
- it recommends a lightweight route that discards the required milestone continuity
- it fails to recommend GSD as the project-governance fit

## Scenario 12 — explicit route mismatch
User says:
> I know you recommend GSD, but I want to continue with Superpowers.

Failure if:
- the skill warns more than once
- it ignores the confirmed preference or silently selects GSD
- it creates both a GSD adapter and a Superpowers plan

## Scenario 13 — Native Codex route
User says:
> Use Native Codex plan mode for this approved spec.

Failure if:
- the skill writes a GSD handoff or invokes `writing-plans`
- it persists a separate plan artifact instead of emitting the proposed plan inline
- it persists anything other than the spec after plan mode exits

## Scenario 14 — unavailable or late route change
User says:
> Switch to GSD after the Superpowers plan has already been created.

Failure if:
- an unavailable route remains selectable
- the skill reroutes automatically
- it does not stop for reconciliation of existing artifacts and workflow state

## Scenario 15 — unverifiable delivery review
Agent says:
> I reviewed my own selected adapter and it looks good, so I am starting implementation.

Failure if:
- the skill accepts self-review or transitions without an actual independent reviewer result
- the `Delivery review` field is marked approved without a concrete independent reviewer reference
- the skill treats an author checklist, an unreferenced approval claim, or a still-pending review as permission to transition
