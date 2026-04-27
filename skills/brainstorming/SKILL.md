---
name: brainstorming
description: Use when product or feature work is still being shaped before implementation, especially for repo-specific requests where scope, trade-offs, brownfield continuity, or UI direction are not yet stable.
---

# Brainstorming

## Overview

Brainstorming turns an idea into approved implementation inputs.

Default outputs:

1. a reviewed design spec
2. a reviewed GSD-ready handoff
3. a reviewed frontend direction packet **when UI/UX materially shapes implementation**

Do **not** write production code, scaffold projects, or invoke implementation skills until the required written artifacts are approved.

## Default terminal states

### Non-UI-heavy work

- reviewed design spec written to `docs/superpowers/specs/YYYY-MM-DD--{slug}.md`
- reviewed GSD handoff written to `docs/superpowers/specs/YYYY-MM-DD--{slug}--gsd-handoff.md`
- ready-to-paste GSD steering note delivered to the user, linking the spec and handoff

### UI-heavy work

- reviewed design spec written to `docs/superpowers/specs/YYYY-MM-DD--{slug}.md`
- reviewed frontend direction packet written to `docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend-direction.md`
- supporting frontend artifacts written to `docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend/`
- repo-local Pencil workset created or refreshed under `design/pencil/` when Pencil is available
- reviewed GSD handoff written to `docs/superpowers/specs/YYYY-MM-DD--{slug}--gsd-handoff.md`
- ready-to-paste GSD steering note delivered to the user, linking the spec, handoff, frontend direction packet, and primary frontend artifacts

Only invoke `writing-plans` if the user **explicitly** wants to continue inside Superpowers instead of handing off to GSD-2 or Codex implementation.

## Core principle

**Extract → choose adapter → explore → converge.**

Your job is to:

- understand the real goal
- retrieve context before guessing
- frame decisions as 2–3 viable options
- recommend a default with reasoning
- bound the work before the spec hardens
- when UI matters, extract current product truth before exploring visual deltas
- when Impeccable v3 is present, treat `PRODUCT.md` and `DESIGN.md` as design-memory inputs, not as replacements for brownfield runtime truth
- use HTML browser artifacts only for temporary comparisons or decision support
- use Pencil as the primary visual workspace when available
- pick the correct Pencil adapter for the target stack
- translate any chosen HTML companion idea back into `.pen` files before treating it as durable direction
- turn the result into written artifacts that another agent can execute with minimal extra questioning

## Skill composition for UI-heavy work

When the frontend-direction phase is active:

- use `pencil-design-core` for repo-grounded `.pen` work, visual extraction, screenshots, and design-to-code preparation
- choose the adapter via `references/pencil-skill-selection.md`
  - default to `pencil-design-angular-nebular` for Angular + Nebular, brownfield operator UIs, and dense administrative products
  - use `pencil-design-react-tailwind` only when the actual target stack is React / Next / Tailwind / shadcn
- prefer a local `frontend-direction` skill when installed; otherwise execute the phase directly from this skill
- treat the visual companion as an HTML comparison surface, not as a durable packet artifact
- use `../frontend-direction/references/use-cases-prompts-and-flows.md` when you need a concrete frontend workflow for brownfield existing-screen work, brownfield new-screen work, or greenfield screen creation

## Required workflow

Create a task for each of the following and complete them in order.

1. **Explore project context**
   - If the request is tied to this repo and likely needs topic-specific codebase context, invoke `gathering-topic-context` before reflection.
   - Use `gathering-topic-context` by default for brownfield work, bugfixes, architecture-led changes, and repo-specific feature requests.
   - Skip it for pure greenfield ideation that is not grounded in this repo.
   - If `gathering-topic-context` cannot run, fall back to local inspection and say why.

2. **Offer the visual companion** _(only if an upcoming question is genuinely visual)_
   - Offer it once for consent.
   - This must be its own message.
   - Do not combine it with summaries or clarifying questions.
   - Use the current platform's dedicated question tool for the offer when available.
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
   - Read `../frontend-direction/references/frontend-direction-phase.md`.
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
    - If UI boards, mockups, screenshots, or Pencil artifacts will be used, confirm whether they are intended as visual truth, semantic guidance, or reference-only evidence before final writing.
    - Do **not** start the frontend-direction phase until the experience is stable enough to anchor screens.

11. **Run the frontend-direction phase** _(conditional)_
    - If step 5 activated it, read:
      - `../frontend-direction/references/frontend-direction-phase.md`
      - `../frontend-direction/references/design-source-priority.md`
      - `../frontend-direction/references/use-cases-prompts-and-flows.md`
      - `references/pencil-skill-selection.md`
      - `../frontend-direction/references/frontend-packet-folder-template.md`
    - Build the screen inventory using `../frontend-direction/references/screen-index-template.md`.
    - In brownfield work with no durable design evidence yet, treat runtime baseline capture as mandatory before packet writing:
      - capture the current screen and key neighboring states from the running app
      - prefer browser-grounded evidence over code-only layout inference
      - treat the first frontend artifact as a faithful baseline, not an improved redesign
    - If the repo uses Impeccable v3, read any project-level `PRODUCT.md` and `DESIGN.md` before refinement:
      - use `PRODUCT.md` as audience, brand/personality, anti-reference, and register context
      - use `DESIGN.md` as reusable system evidence when it is current
      - treat `DESIGN.json` as auxiliary tooling output, not the primary durable contract
    - In brownfield work, create `brownfield-ui-extraction.md` using `../frontend-direction/references/brownfield-ui-extraction-template.md` before asking for variants.
    - Build the Pencil workset plan using `../frontend-direction/references/pencil-workset-template.md`.
    - Use Pencil as the primary workspace when available:
      - recreate the current shell and patterns first
      - choose the correct adapter for the target stack
      - explore only the decision-bearing deltas
      - keep `.pen` files in the repo
      - record board intent before handoff: `visual-truth`, `semantic-guidance`, or `reference-only`
    - Get explicit human approval for any board-intent classification that will affect implementation. Do not let downstream implementation agents infer whether a board is a redesign target.
    - Use the HTML visual companion only for temporary comparison artifacts when a decision is materially easier to judge in-browser than in prose.
    - If a companion artifact influences the choice, translate the chosen direction back into `.pen` boards, screenshots, and packet prose before treating it as durable.
    - Review the packet against `../frontend-direction/references/frontend-review-checklist.md` and `../frontend-direction/references/frontend-packet-completeness-checklist.md`.
    - Prefer a local `frontend-direction` skill when installed; otherwise execute the phase directly from this skill.
    - Treat generated visuals as references, not as permission to invent product requirements.

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

15. **Write the frontend direction packet** _(conditional)_
    - Save to `docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend-direction.md`.
    - Save supporting files to `docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend/`.
    - Default supporting files:
      - `screen-index.md`
      - `brownfield-ui-extraction.md`
      - `pencil-workset.md`
      - `screenshots/`
    - When Pencil is available, create or refresh repo-local `.pen` files under `design/pencil/`.
    - Name the Pencil skills downstream agents should load.
    - Record exact `.pen` files, board/frame names, and any HTML companion decisions that were translated back into durable artifacts.

16. **Write the GSD handoff**
    - Use `references/gsd-handoff-template.md`.
    - Save to `docs/superpowers/specs/YYYY-MM-DD--{slug}--gsd-handoff.md`.
    - If the repo already has `.gsd/REQUIREMENTS.md` or prior milestone requirements in the same domain, reconcile them explicitly in the handoff instead of introducing parallel truths.
    - For each overlapping requirement, state whether this handoff:
      - reuses it unchanged
      - reactivates it from deferred
      - narrows, splits, or clarifies it
      - supersedes earlier wording for this scope
      - leaves the remainder deferred
    - Prepare the corresponding steering note with the real artifact paths filled in.
    - If a frontend direction packet exists, link it explicitly and tell downstream agents to treat it as first-class input for UI implementation.
    - Make sure the steering note links all primary artifacts:
      - design spec
      - GSD handoff
      - frontend direction packet when present
      - primary frontend supporting artifacts when present
    - Record which Pencil skills and which exact `.pen` files are expected downstream.
    - Make clear that temporary HTML companion screens are not binding once the chosen direction has been translated into Pencil and packet artifacts.

17. **Run the review loop**
    - Read `references/spec-review-checklist.md`.
    - If a frontend direction packet exists, also read:
      - `../frontend-direction/references/frontend-review-checklist.md`
      - `../frontend-direction/references/frontend-packet-completeness-checklist.md`
    - Dispatch the reviewer using `spec-document-reviewer-prompt.md`.
    - Review every written artifact in scope.
    - Fix blocking issues and re-dispatch.
    - Maximum 5 iterations, then surface to the human.

18. **User review gate**
    - Ask the user to review the written artifacts before proceeding.
    - Use the current platform's dedicated question tool for that review prompt when available.
    - If they request changes, make them and re-run the review loop.

19. **Transition**
    - Default: stop with approved artifacts and give the user the ready-to-paste steering note.
    - The final response must include the steering note, not just mention that one exists.
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
- when UI direction is in scope, prefer clarity, hierarchy, brownfield continuity, and design-system fit over generic visual flourish
- when HTML companion screens are used, prefer them for comparison speed only; durable truth must still converge into `.pen` files and packet prose

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
- do not let generated concepts outrank observed product truth
- preserve shell, navigation, density, and shared component language before exploring cosmetic novelty

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
