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
