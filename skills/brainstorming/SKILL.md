---
name: brainstorming
description: Use when shaping new features, behavior changes, product ideas, brownfield enhancements, or UI-heavy work before implementation—especially when scope, requirements, trade-offs, screen behavior, or frontend direction must be turned into an approved design spec, optional frontend direction packet, and GSD/Codex-ready handoff.
---

# Brainstorming

## Overview

Brainstorming is guided discovery that turns an idea into approved implementation inputs.

Default outputs:

1. a reviewed design spec
2. a reviewed GSD-ready handoff
3. a reviewed frontend direction packet **when UI/UX materially shapes implementation**

Do **not** write production code, scaffold projects, or invoke implementation skills until the required written artifacts are approved.

## Default terminal states

### Non-UI-heavy work

- reviewed design spec written to `docs/superpowers/specs/YYYY-MM-DD--{slug}.md`
- reviewed GSD handoff written to `docs/superpowers/specs/YYYY-MM-DD--{slug}--gsd-handoff.md`

### UI-heavy work

- reviewed design spec written to `docs/superpowers/specs/YYYY-MM-DD--{slug}.md`
- reviewed frontend direction packet written to `docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend-direction.md`
- reviewed GSD handoff written to `docs/superpowers/specs/YYYY-MM-DD--{slug}--gsd-handoff.md`
- supporting frontend assets written to `docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend/`

Only invoke `writing-plans` if the user **explicitly** wants to continue inside Superpowers instead of handing off to GSD-2 or Codex implementation.

## Core principle

**Guided choices beat open-ended interrogation.**

Your job is to:

- understand the real goal
- retrieve context before guessing
- frame decisions as 2–3 viable options
- recommend a default with reasoning
- bound the work before the spec hardens
- create visual direction when the implementation agent would otherwise have to invent UI
- turn the result into written artifacts that another agent can execute with minimal extra questioning

## Required workflow

Create a task for each of the following and complete them in order.

1. **Explore project context**
   - If the request is tied to this repo and likely needs topic-specific codebase context, invoke `gathering-topic-context` before reflection.
   - Use `gathering-topic-context` by default for brownfield work, bugfixes, architecture-led changes, and repo-specific feature requests.
   - Skip it for pure greenfield ideation that is not grounded in this repo.
   - If `gathering-topic-context` cannot run, fall back to local inspection and say why.

2. **Offer the visual companion** *(only if an upcoming question is genuinely visual)*
   - Offer it once for consent.
   - This must be its own message.
   - Do not combine it with summaries or clarifying questions.
   - Use the current platform's dedicated question tool for the offer when available.
   - On Codex/OpenCode, that tool is `request_user_input`.
   - On Copilot, that tool is `ask_questions`.
   - Wait for the user's answer before continuing.
   - If accepted, read `visual-companion.md` before the first browser turn.

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

5. **Decide whether a frontend-direction phase is required**
   - Read `references/frontend-direction-phase.md`.
   - Treat frontend intensity as a second axis, not a replacement for the chosen track.
   - Activate the phase when pages, screens, flows, layout hierarchy, visual language, or interaction details materially shape implementation.
   - Skip it for backend-only work, purely mechanical UI tweaks that already fit a stable pattern, or when an approved frontend direction packet already exists and remains current.

6. **Build the framing brief**
   - Use `references/framing-brief-template.md`.
   - Capture user, problem, desired outcome, success signal, constraints, and non-goals.
   - Keep it concise and decision-oriented.

7. **Run guided discovery**
   - Read `references/guided-choice-protocol.md`.
   - Ask **one question per message**.
   - Prefer **2–3 framed options** over open-ended questions.
   - Always include a recommendation when the choice is design-shaping.
   - If you ask an open-ended question, the **next turn** must reframe the answer into options.

8. **Present option cards**
   - Use `references/option-cards-template.md`.
   - Show 2–3 viable approaches with trade-offs.
   - Evaluate them using `references/decision-lens.md`.
   - Lead with your recommended option and why it wins **now**.

9. **Set boundaries and appetite**
   - Define first delivery boundary, rabbit holes, no-gos, and what must stay unchanged.
   - In brownfield work, explicitly capture invariants, rollout constraints, compatibility constraints, migration concerns, and integration risks before proposing architecture-heavy solutions.

10. **Stabilize the experience before final writing**
    - Confirm the primary flows, key states, and first delivery boundary.
    - If durable wireframes are needed, add them before the final writing pass.
    - Do **not** start the frontend-direction phase until the experience is stable enough to anchor screens.

11. **Run the frontend-direction phase** *(conditional)*
    - If step 5 activated it, read `references/frontend-direction-phase.md` fully.
    - Build the screen inventory using `references/screen-index-template.md`.
    - Build the prompt pack using `references/stitch-prompt-pack-template.md`.
    - Write the frontend direction packet using `references/frontend-direction-template.md`.
    - Prefer a local `frontend-direction` skill when installed; otherwise execute the phase directly from this skill.
    - Treat Stitch outputs as first-class visual references, not as permission to invent product requirements.

12. **Present the design in sections**
    - Use `references/spec-template.md`.
    - Present the design incrementally.
    - After each major section, ask whether it looks right so far.
    - Revise before moving on.

13. **Add example mapping**
    - Use `references/example-mapping-template.md`.
    - For each major capability, capture:
      - rules
      - examples
      - open questions
      - out-of-scope / deferred items

14. **Write the design spec**
    - Save to `docs/superpowers/specs/YYYY-MM-DD--{slug}.md`.
    - User preference overrides the default location.
    - If a frontend direction packet exists, keep the spec structural and behavioral; link to the packet instead of duplicating visual-system detail.
    - Commit the spec to git.

15. **Write the frontend direction packet** *(conditional)*
    - Save to `docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend-direction.md`.
    - Save supporting files to `docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend/`.
    - When Stitch MCP is available and the work is repo-tied, refresh `.stitch/DESIGN.md` if that improves reuse.
    - Commit all frontend-direction artifacts to git.

16. **Write the GSD handoff**
    - Use `references/gsd-handoff-template.md`.
    - Save to `docs/superpowers/specs/YYYY-MM-DD--{slug}--gsd-handoff.md`.
    - If a frontend direction packet exists, link it explicitly and tell downstream agents to treat it as first-class input for UI implementation.
    - Commit the handoff to git.

17. **Run the review loop**
    - Read `references/spec-review-checklist.md`.
    - If a frontend direction packet exists, also read `references/frontend-review-checklist.md`.
    - Dispatch the reviewer using `spec-document-reviewer-prompt.md`.
    - Review every written artifact in scope.
    - Fix blocking issues and re-dispatch.
    - Maximum 5 iterations, then surface to the human.

18. **User review gate**
    - Ask the user to review the written artifacts before proceeding.
    - Use the current platform's dedicated question tool for that review prompt when available.
    - If they request changes, make them and re-run the review loop.

19. **Transition**
    - Default: stop with approved artifacts.
    - If the user explicitly wants to continue inside Superpowers, invoke `writing-plans`.

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
- when UI direction is in scope, prefer clarity, hierarchy, and codebase/design-system fit over generic visual flourish

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
- when frontend direction is active, preserve the existing design system and surface language unless the user explicitly wants redesign

## Track-specific guardrails

Track summaries in `references/track-selection.md` do not replace the guardrails below.

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

## Output artifacts

### 1. Design spec

Use `references/spec-template.md`.

Default path:
`docs/superpowers/specs/YYYY-MM-DD--{slug}.md`

### 2. Frontend direction packet *(conditional)*

Use `references/frontend-direction-template.md`.

Default path:
`docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend-direction.md`

Supporting folder:
`docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend/`

Recommended contents:
- `screen-index.md`
- `stitch-prompt-pack.md`
- `screenshots/`
- `selected-direction/`

### 3. GSD handoff

Use `references/gsd-handoff-template.md`.

Default path:
`docs/superpowers/specs/YYYY-MM-DD--{slug}--gsd-handoff.md`

## Review loop

After writing the required artifacts:

1. Dispatch the reviewer using `spec-document-reviewer-prompt.md`
2. Use `references/spec-review-checklist.md` as the baseline quality bar
3. Use `references/frontend-review-checklist.md` as an additional blocking bar when a frontend direction packet exists
4. Fix blocking issues
5. Re-dispatch until approved or until 5 iterations are exhausted
6. Ask the user to review the written files

Do **not** proceed to implementation planning until the written artifacts are approved.

## Visual companion

The visual companion is a tool, not a mode. Offer it only when the upcoming question is materially easier to judge by seeing than by reading.

If accepted, follow the comparison-first contract in `visual-companion.md`.

Use browser screens for:

- visual direction contrasts
- screen hierarchy comparisons
- IA comparisons
- annotated recommendations
- selected Stitch or screenshot references that help settle a decision

Stay in terminal for:

- conceptual or scope questions
- backend-only design work
- requirements and boundary checks that do not benefit from visual contrast

A question about UI is not automatically a visual question.

## Common mistakes to avoid

- asking several open-ended questions in a row
- presenting more than 3 options
- presenting options without a recommendation
- skipping boundaries because the feature "seems simple"
- writing the spec before the key choice is actually settled
- handing UI-heavy work to implementation with only prose + low-fidelity wireframes when visual direction is still implicit
- treating Stitch outputs as the product decision instead of evidence inside the decision
- handing off to GSD-2 or Codex without explicit requirements seeds, milestone recommendations, and frontend inputs when relevant
- invoking implementation skills before the written artifacts are approved

## Terminal states

### Default
Approved required artifacts for the chosen scope.

### Optional
If the user explicitly says to keep going inside Superpowers after approval, invoke `writing-plans`.

Do **not** invoke implementation skills earlier than that.
