---
name: brainstorming
description: Use when shaping new features, behavior changes, product ideas, or brownfield enhancements before implementation—especially when user value, scope, constraints, trade-offs, or requirements need to be turned into an approved design spec.
---

# Brainstorming

## Overview

Brainstorming is guided discovery that turns an idea into:

1. an approved design spec, and
2. a GSD-ready handoff packet.

Do **not** write code, scaffold projects, or invoke implementation skills until the design spec is approved and the next-step handoff is ready.

### Default terminal state

The default terminal state is:

- a reviewed design spec written to `docs/superpowers/specs/YYYY-MM-DD--{slug}.md`
- a reviewed GSD handoff written to `docs/superpowers/specs/YYYY-MM-DD--{slug}--gsd-handoff.md`

Only invoke `writing-plans` if the user **explicitly** wants to continue inside Superpowers instead of handing off to GSD-2.

## When to Use

Use this skill when:

- a user wants to create a new feature, project, workflow, UI, API, integration, automation, or behavior change
- the user has an idea but the scope, requirements, or trade-offs are still fuzzy
- the request touches an existing codebase and you need to understand current constraints before proposing a solution
- the user wants a design spec, proposal, plan-ready design, or GSD handoff
- the user asks for implementation work that would benefit from a design first

## When NOT to Use

Do **not** use this skill when:

- there is already a current, approved spec and the user wants pure implementation against that spec
- the task is purely mechanical, tightly bounded, and already governed by a validated plan
- the user only wants analysis or research with no design/spec output

## Core principle

**Guided choices beat open-ended interrogation.**

You are not here to make the user invent the design from scratch. Your job is to:

- understand the real goal
- retrieve context before guessing
- frame decisions as 2–3 viable options
- recommend a default with reasoning
- bound the work before the spec hardens
- turn the result into a spec and a GSD-ready handoff

## Required workflow

Create a task for each of the following and complete them in order.

1. **Explore project context**
   - If the request is tied to this repo and likely needs topic-specific codebase context, invoke `gathering-topic-context` before reflection.
   - Use `gathering-topic-context` by default for brownfield work, bugfixes, architecture-led changes, and repo-specific feature requests.
   - Skip `gathering-topic-context` for pure greenfield/product ideation that is not grounded in this repo.
   - Use the returned Topic Context Bundle to ground track selection, framing, and the first guided question.
   - If `gathering-topic-context` cannot run, fall back to local inspection and say why.

2. **Offer the visual companion** *(only if an upcoming question is genuinely visual)*
   - This must be its own message.
   - Do not combine it with summaries or clarifying questions.
   - Use the current platform's dedicated question tool for the offer when available.
   - On Codex/OpenCode, that tool is `request_user_input`.
   - On Copilot, that tool is `ask_questions`.
   - If accepted, read `visual-companion.md` before using it.

3. **Reflect before questioning**
   - Restate what you think the user wants.
   - Name the major capabilities or moving pieces you heard.
   - Give a rough scope read.
   - Deliver the confirmation prompt with the current platform's dedicated question tool when available.
   - Ask if you got it right **before** diving into detailed questions.

4. **Choose a track**
   - Read `references/track-selection.md`.
   - Pick the best-fit track:
     - greenfield
     - brownfield-major-feature
     - brownfield-small-feature
     - bugfix-regression
     - architecture-led-change

5. **Build the framing brief**
   - Use `references/framing-brief-template.md`.
   - Capture user, problem, desired outcome, success signal, constraints, and non-goals.
   - Keep it concise and decision-oriented.

6. **Run guided discovery**
   - Read `references/guided-choice-protocol.md`.
   - Ask **one question per message**.
   - Use the current platform's dedicated question tool for discovery questions, boundary checks, and review gates when available.
   - Prefer **2–3 framed options** over open-ended questions.
   - Always include a recommendation when the choice is design-shaping.
   - If you ask an open-ended question, the **next turn** must reframe the answer into options.

7. **Present option cards**
   - Use `references/option-cards-template.md`.
   - Show 2–3 viable approaches with trade-offs.
   - Evaluate them using `references/decision-lens.md`.
   - Lead with your recommended option and why it wins **now**.

8. **Set boundaries and appetite**
   - Define first delivery boundary, rabbit holes, no-gos, and what must stay unchanged.
   - In brownfield work, explicitly capture invariants, rollout constraints, compatibility constraints, migration concerns, and integration risks before proposing architecture-heavy solutions.

9. **Present the design in sections**
   - Use `references/spec-template.md`.
   - Present the design incrementally.
   - After each major section, ask whether it looks right so far.
   - Revise before moving on.

10. **Add example mapping**
    - Use `references/example-mapping-template.md`.
    - For each major capability, capture:
      - rules
      - examples
      - open questions
      - out-of-scope / deferred items

11. **Write the design spec**
    - Save to `docs/superpowers/specs/YYYY-MM-DD--{slug}.md`
    - User preference overrides the default location.
    - Commit the spec to git.

12. **Write the GSD handoff**
    - Use `references/gsd-handoff-template.md`.
    - Save to `docs/superpowers/specs/YYYY-MM-DD--{slug}--gsd-handoff.md`
    - Commit the handoff to git.

13. **Run the review loop**
    - Read `references/spec-review-checklist.md`.
    - Dispatch the reviewer using `spec-document-reviewer-prompt.md`.
    - Review both the spec and the GSD handoff.
    - Fix blocking issues and re-dispatch.
    - Maximum 5 iterations, then surface to the human.

14. **User review gate**
    - Ask the user to review the written spec and handoff before proceeding.
    - Use the current platform's dedicated question tool for that review prompt when available.
    - If they request changes, make them and re-run the review loop.

15. **Transition**
    - Default: stop with approved spec + approved GSD handoff.
    - If the user explicitly wants to continue inside Superpowers, invoke `writing-plans`.

## Track routing

Read `references/track-selection.md` before deep questioning.

### Decomposition rule

If the request really describes multiple independent subsystems, do **not** force a single giant spec.

Instead:

- identify the independent pieces
- explain how they relate
- suggest an order
- brainstorm the **first** sub-project through the normal flow

Each sub-project gets its own spec and handoff.

## Guided discovery rules

Read `references/guided-choice-protocol.md`.

These rules are non-negotiable:

- **One question per message**
- **Use the current platform's dedicated question tool whenever a guided question or review gate is needed and the tool is available**
- **2–3 options max**
- **Recommendation included**
- **No more than one open-ended question in a row**
- **Synthesize every 2–3 turns**
- **Never leave the user holding an unframed decision**

If you need concrete question shapes, use `references/question-bank.md`.

Current platform question tools:

- Codex/OpenCode: `request_user_input`
- Copilot: `ask_questions`

When using the platform question tool:

- keep it to one decision at a time
- put the recommended option first
- use `Other` only for genuine escape hatches or corrections
- prefer `yes / adjust / no` style confirmation for reflection checks
- if the tool is unavailable, fall back to a plain-text question with the same framing

## Decision quality rules

When comparing options:

- optimize for user value and codebase fit first
- avoid cleverness that increases delivery or operational risk without strong payoff
- prefer reversible choices when confidence is low
- name what each option makes harder, not just what it makes possible

Use `references/decision-lens.md` for a consistent rubric.

## Brownfield rules

In existing codebases:

- prefer `gathering-topic-context` over ad hoc scanning when topic-specific codebase context is needed
- inspect the current structure before proposing changes
- follow existing patterns unless there is a strong reason not to
- include targeted cleanup only when it directly reduces risk for the current goal
- do not smuggle in unrelated refactors
- explicitly call out invariants and rollout constraints
- if inspection has not happened yet, the next guided question must focus on current behavior, existing workflow boundaries, and what must stay unchanged rather than jumping to architecture

## Track-specific guardrails

### Brownfield major feature

- after the reflection turn, inspect current patterns before committing to solution shape
- the first design-shaping question must surface the workflow insertion point plus at least one of: invariant, rollout constraint, migration concern, or compatibility constraint
- do not jump to workflow-engine or architecture-heavy options until those constraints are explicit

### Brownfield small feature

- stay on the lite path
- ask only for the minimum behavior change, the unchanged behavior, and the safest extension point
- one recommended option plus one fallback is usually enough

### Bugfix / regression

- treat the first discovery turn as behavior clarification, not feature ideation
- capture current behavior, expected behavior, and unchanged behavior before discussing solution shape
- the first guided question after reflection must confirm both the target behavior and the non-regression boundary in the same turn
- ask about regression safety explicitly: what must keep working, what reproduces the issue, or what verification would prove the fix is safe
- prefer a recommended target rule over speculative root-cause architecture

## Design quality bar

Your design is not done when it sounds plausible. It is done when:

- the framing is clear
- the scope is bounded
- the chosen direction is justified
- edge cases and failure modes are covered
- acceptance examples exist
- the spec can be handed to GSD-2 with minimal extra questioning

## Output artifacts

### 1. Design spec

Use `references/spec-template.md`.

Default path:
`docs/superpowers/specs/YYYY-MM-DD--{slug}.md`

### 2. GSD handoff

Use `references/gsd-handoff-template.md`.

Default path:
`docs/superpowers/specs/YYYY-MM-DD--{slug}--gsd-handoff.md`

The handoff must be strong enough that a fresh GSD project can start with `/gsd` and use the handoff file as the primary vision input.

## Review loop

After writing both artifacts:

1. Dispatch the reviewer using `spec-document-reviewer-prompt.md`
2. Use `references/spec-review-checklist.md` as the quality bar
3. Fix blocking issues
4. Re-dispatch until approved or until 5 iterations are exhausted
5. Ask the user to review the written files

Do **not** proceed to implementation planning until the written artifacts are approved.

## Visual companion

Offer the visual companion only when the upcoming question is easier to understand by **seeing** than by reading.

Examples:

- visual layouts
- wireframes
- journey maps
- architecture diagrams
- side-by-side UI or information architecture comparisons

Do **not** use the browser for:

- trade-off lists
- conceptual scope choices
- constraints questions
- most architecture or API decisions unless a diagram materially clarifies the choice

If the user accepts the visual companion, read `visual-companion.md`.

## Common mistakes to avoid

- asking several open-ended questions in a row
- presenting more than 3 options
- presenting options without a recommendation
- skipping boundaries because the feature "seems simple"
- writing the spec before the choice is actually settled
- writing a polished spec without acceptance examples
- handing off to GSD-2 without explicit requirements seeds and milestone recommendations
- invoking implementation skills before the written artifacts are approved

## Terminal states

### Default
Approved spec + approved GSD handoff.

### Optional
If the user explicitly says to keep going inside Superpowers after approval, invoke `writing-plans`.

Do **not** invoke implementation skills earlier than that.
