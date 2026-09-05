---
name: brainstorming
description: Use when product or feature work is still being shaped before implementation, especially for repo-specific requests where scope, trade-offs, brownfield continuity, or UI direction are not yet stable.
---

# Brainstorming

## Overview

Brainstorming turns an idea into approved implementation inputs.

## Outcome-first success contract

A brainstorming session succeeds when another agent can continue with minimal rediscovery:

- the problem, user, success signal, first delivery boundary, non-goals, and open questions are explicit
- the chosen track and recommended direction are justified by real trade-offs
- brownfield invariants, rollout constraints, compatibility constraints, and integration risks are recorded when relevant
- each major capability has concrete examples or rules that make implementation testable
- the approved neutral spec and optional frontend-direction follow-on prompt agree with each other
- UI-heavy work is gated until the separate frontend-direction packet exists and is approved

Use this contract as the destination. The workflow below is the default path for reaching it without skipping required gates.

Compact does not mean lossy. Keep outputs concise, but preserve implementation-shaping details: user value, chosen direction, scope boundaries, invariants, state coverage, failure behavior, rollout constraints, integration risks, UX copy, verification expectations, and open questions with the decision each question blocks.

Default outputs:

1. an approved neutral spec
2. when UI/UX materially shapes implementation, a follow-on prompt to bootstrap a separate `frontend-direction` session
3. after explicit route confirmation, exactly one delivery adapter

Do **not** write production code, scaffold projects, or invoke implementation skills until the required written artifacts are approved.

Do **not** run the full frontend-direction phase inside brainstorming by default. Split it into a new session or a manually compacted continuation to avoid losing design decisions to context-window pressure.

## Default terminal states

### Non-UI-heavy work

- reviewed design spec written to `docs/superpowers/specs/YYYY-MM-DD--{slug}.md`
- approved neutral spec routed through exactly one confirmed lane

### UI-heavy work

- reviewed design spec written to `docs/superpowers/specs/YYYY-MM-DD--{slug}.md`
- frontend-direction follow-on prompt delivered to the user, linking the approved spec and carrying any visual-companion decisions
- approved neutral spec routed through exactly one confirmed lane after the frontend-direction gate is satisfied

Read `references/delivery-routing.md` before recommending a downstream lane. GSD produces the GSD handoff and steering note only after GSD is confirmed; Superpowers invokes `writing-plans`; Native Codex emits an inline proposed plan and, after plan mode exits, persists only the spec. Native Codex plan mode is a read-only authoring mode, not an execution workflow; do not execute implementation while in plan mode.

## Core principle

**Extract → explore → converge → route.**

Your job is to:

- understand the real goal
- retrieve context before guessing
- frame decisions as 2–3 viable options
- recommend a default with reasoning
- bound the work before the spec hardens
- when UI matters, capture enough product and experience intent to seed a later frontend-direction session
- when UI includes meaningful visible text, use `writing-ux-copy` to make copy a first-class state contract instead of leaving it to implementation
- when Impeccable v3 is present, treat `PRODUCT.md` and `DESIGN.md` as design-memory inputs, not as replacements for brownfield runtime truth
- use HTML browser artifacts only for temporary comparisons or decision support
- keep visual companion decisions inside brainstorming as decision context, not durable frontend packet artifacts
- turn the result into written artifacts that another agent can execute with minimal extra questioning

## Spec and Adapter Reviewer Dispatch

Neutral-artifact and selected-adapter reviews use the same fresh, read-only
reviewer responsibility with their stage-specific prompt. Do not pass session
history or let the reviewer spawn agents.

On Codex, inspect the runtime-advertised role list before dispatch:

- when `sp_reviewer` is present, use `agent_type: "sp_reviewer"` and
  `fork_turns: "none"`;
- when it is absent, omit `agent_type`, keep `fork_turns: "none"`, and send the
  same complete `spec-document-reviewer-prompt.md` message to a fresh generic
  agent; and
- never probe availability by intentionally dispatching an unknown role.

Other harnesses use one fresh read-only reviewer and the same prompt. Generic
fallback changes only role configuration; it never removes review coverage.

## UI-heavy work split

When frontend direction is required:

- stay in brainstorming long enough to stabilize product behavior, flows, states, constraints, and first delivery boundary
- allow the visual companion for decision support during brainstorming
- do not create the frontend direction packet or screenshots in the same default brainstorming session
- write the neutral spec with `packet status: required-pending`
- produce a follow-on prompt for a separate `frontend-direction` session
- include any visual-companion decisions as context for that follow-on prompt

## Visual Companion

Use the visual companion only when the decision is materially easier to judge by seeing than by reading. For conceptual, scope, and text-first turns, stay in terminal.

Before authoring, name the viewing task: what the user should inspect, understand, compare, or decide after seeing the artifact. Choose the smallest useful artifact intent—compare, explain, map, experience, or synthesize. These intents are examples, not a whitelist: a direct subject-specific diagram is appropriate when it explains structure or sequence better than prose. Keep the established comparison patterns first-class, but do not invent alternatives merely to force a comparison. Reject irrelevant decoration; revise a weak artifact or stay in terminal.

After the user accepts the companion, the first later genuinely visual question must start the companion path instead of remaining terminal-only. Each qualifying visual turn remains artifact-first: author or refresh the visual artifact, make it viewable, then ask the decision in terminal.

The terminal decision prompt must stay present for qualifying visual turns even after the companion has already been opened earlier in the session. If the platform question tool is unavailable, the agent may fall back to plain terminal text, but that is degraded behavior and should be named as such.

follow first-use workflow in order:

1. instruction context
2. repo design-context source if present
3. one-time minimal session capture
4. degraded mode

preserve compatibility boundary language:

- `full-document` compatibility support remains available, but fragment-first screens are the default.
- no new required metadata beyond `data-choice`.

Read `visual-companion.md` before the first browser turn.

## Common Mistakes to Avoid

- Treating temporary companion screens as durable frontend direction.
- Continuing browser work after the remaining decision is textual.
- Skipping the frontend-direction follow-on prompt when UI direction must become implementation evidence.

## Required workflow

Create a task for each of the following and complete them in order.

### Gate strength

- **Hard gates:** no production code during brainstorming; reflect before detailed questioning; one guided question per message; preserve the frontend-direction split; write the required artifacts; run the review loop; ask for user review before transition.
- **Default path:** follow the numbered sequence unless the selected track's lite path explicitly compresses artifact depth. Compression may shorten prose, but it must not remove decisions, examples, review, or handoff gates.
- **Stop rule:** after each discovery or artifact pass, ask whether the success contract above can be satisfied with current evidence. If yes, move to the next artifact or review step. If no, ask the smallest next framed question or retrieve the smallest missing evidence.

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
   - Mark frontend direction as required when pages, screens, flows, layout hierarchy, visual language, or interaction details materially shape implementation.
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
   - Do not optimize for the fewest questions. Ask enough guided questions to prevent a poorly framed feature, especially around user value, boundaries, invariants, rollout, state coverage, and failure behavior.
   - Stop discovery only when the remaining unknowns are either non-blocking or explicitly carried as open questions with the decision they block.

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
    - If frontend direction is required, capture the screen families, user goals, key states, current-product constraints, and any visual-companion decisions that the later frontend-direction session must inherit.
    - If the work includes user-visible labels, warnings, errors, empty states, confirmations, onboarding, helper text, or ChatGPT Images prompt visible text, invoke `writing-ux-copy` and draft a copy deck or explicit copy gaps before finalizing the spec.
    - Do **not** create the frontend direction packet in this session by default.

11. **Present the design in sections**
    - Use `references/spec-template.md`.
    - Present the design incrementally.
    - After each major section, ask whether it looks right so far.
    - Revise before moving on.

12. **Add example mapping**
    - Use `references/example-mapping-template.md`.
    - For each major capability, capture:
      - rules
      - examples
      - open questions
      - out-of-scope / deferred items

13. **Write the design spec**
    - Save to `docs/superpowers/specs/YYYY-MM-DD--{slug}.md`.
    - User preference overrides the default location.
    - If frontend direction is required, keep the spec structural and behavioral. Record that visual direction will be handled by a separate frontend-direction packet.

14. **Write the frontend-direction follow-on prompt** _(conditional)_
    - Required when step 5 marked frontend direction as required and no current approved packet exists.
    - Use `references/frontend-direction-follow-on-prompt-template.md`.
    - Include:
      - approved design spec path
      - feature slug and target repo
      - track and first delivery boundary
      - screen families, flows, and key states discovered during brainstorming
      - brownfield invariants and no-gos
      - visual companion decisions or artifacts, explicitly marked as non-durable decision context
      - UX writing decisions, copy deck path or copy gaps, and prompt-visible-text requirements for ChatGPT Images 2 prompts
      - likely target stack and adapter candidates
      - reference-intent approval requirement for the later packet
    - Prepare the prompt as part of the neutral artifact set. Deliver it as the next-session bootstrap only after the neutral artifact review and user approval gate pass.

15. **Run the neutral artifact review**
    - Read `references/spec-review-checklist.md`.
    - Dispatch the reviewer using `spec-document-reviewer-prompt.md`.
    - Review only the neutral design spec and frontend-direction follow-on prompt if one is required. At this stage, Delivery Route metadata and every route adapter must still be absent.
    - Fix supported `BLOCKING` issues and re-dispatch. When a supported `DECISION` remains, ask one bounded human question, update the artifact with the answer, and re-dispatch within the same correction budget. Permit at most two correction plus re-review rounds; if a supported `BLOCKING` or `DECISION` remains, stop and surface the unresolved conflict to the human.

16. **User approval gate**
    - Ask the user to review the written artifacts before proceeding.
    - Use the current platform's dedicated question tool for that review prompt when available.
    - If they request changes, make them and re-run the neutral artifact review.

17. **Complete frontend packet approval** _(conditional)_
    - When frontend direction is not required, record packet status as `not-required` and continue.
    - When frontend direction is required and no current packet exists, keep packet status as `required-pending`, deliver the follow-on prompt, and stop this workflow until the separate frontend-direction session returns an approved packet.
    - Resume only when the user explicitly approves the packet as `approved` or explicitly approves every degraded constraint and records `approved-with-degraded-evidence`.
    - A degraded evidence note without explicit approval does not satisfy this gate.

18. **Confirm the delivery route**
    - Read `references/delivery-routing.md`.
    - Route only after the neutral artifacts have passed review and user approval, and after step 17 has resolved packet status to `not-required`, `approved`, or `approved-with-degraded-evidence`.
    - Recommend by delivery fit, using the approved spec and the user's stated working preference. Availability only removes routes; it never makes one preferable.
    - Use GSD for milestone continuity or cross-workstream governance, Superpowers for bounded durable task-planned delivery, and Native Codex for an immediate contained slice.
    - Resolve mixed signals with the deterministic rules in `references/delivery-routing.md`.
    - Ask the user to confirm exactly one route before creating any adapter or adding the compact Delivery Route section to the spec.
    - Warn once only when an explicit preference conflicts with a concrete need in the approved spec, then honor the confirmed preference.
    - After confirmation, record the recommendation with its concrete fit evidence, the neutral-review and user-approval references, the confirmed route, its confirmation reference, the expected delivery output, and `Delivery review` status `pending`.

19. **Create the selected adapter**
    - Append the compact Delivery Route section to the approved spec.
    - Produce exactly one adapter for the confirmed route: GSD handoff and steering note, a single Superpowers `writing-plans` invocation bound to the approved spec, or a Native Codex inline proposed plan.
    - Do not create or retain any adapter for an unselected route.
    - Generate the GSD handoff only when GSD is confirmed and packet status is `not-required`, `approved`, or `approved-with-degraded-evidence`; for UI-heavy work it consumes the approved packet and never sends work back to frontend direction.
    - If a route change is requested after adapter or workflow state exists, stop for reconciliation; never reroute automatically.

20. **Review the selected adapter**
    - Dispatch an independent reviewer with review stage `selected-adapter`, the confirmed route, and the selected adapter populated. Do not self-review or treat an author checklist as reviewer approval.
    - During the selected-adapter review, validate the compact Delivery Route metadata matches the user's confirmed route.
    - During the selected-adapter review, validate exactly one adapter exists and matches that route.
    - During the selected-adapter review, reject every unselected adapter or unselected route artifact.
    - During the selected-adapter review, validate route-specific completeness and cross-artifact agreement before transition.
    - Fix supported `BLOCKING` issues and re-dispatch. When a supported `DECISION` remains, ask one bounded human question, update the artifact with the answer, and re-dispatch within the same correction budget. Permit at most two correction plus re-review rounds; if a supported `BLOCKING` or `DECISION` remains, stop and surface the unresolved conflict to the human.
    - After approval, replace the Delivery Route section's `Delivery review: pending` with `Delivery review: approved` and a concrete reviewer reference. A claim without a reviewer result is not approval evidence.

21. **Transition through the confirmed route**
    - Transition only after the selected-adapter review approves the route metadata, adapter cardinality, and route-specific completeness, and the Delivery Route section records that approval reference.
    - Hand the approved GSD adapter to GSD, invoke the approved Superpowers `writing-plans` adapter, or present the approved Native Codex inline proposed plan according to the confirmed route.
    - Preserve Native Codex as read-only planning and do not start either unselected workflow family.

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
- when HTML companion screens are used, prefer them for comparison speed only; durable truth must still converge into packet prose, screenshots, browser captures, or approved generated images

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
- when frontend direction is required, preserve the existing design system and surface language unless the user explicitly wants redesign
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
