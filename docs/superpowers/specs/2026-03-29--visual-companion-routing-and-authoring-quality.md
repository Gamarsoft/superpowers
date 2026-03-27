# Visual Companion Routing And Authoring Quality

## 1. Executive Summary
- This improves how the brainstorming workflow decides to use the visual companion and how companion screens are authored before they are shown.
- It is for the operator authoring brainstorm screens and for future agents following [SKILL.md](/Users/gamarsoft/.codex/superpowers/skills/brainstorming/SKILL.md) and [visual-companion.md](/Users/gamarsoft/.codex/superpowers/skills/brainstorming/visual-companion.md).
- Why now: the M001 upgrade proved the companion runtime and comparison-first shell, but live trials showed that usefulness still depends mostly on routing discipline and artifact quality.
- First delivery boundary: tighten skill guidance and example quality inside the existing four archetypes, without changing the runtime contract.

## 2. Framing Brief
- Primary user / operator: the agent authoring and presenting visual companion screens during brainstorming sessions.
- Job / problem: decide when the companion should be used and ensure that any screen shown is concrete enough to support a real visual decision.
- Current workaround / current behavior: the companion can be invoked correctly at the runtime level, but weak authored artifacts can still slip through and reduce trust in the tool.
- Desired outcome: the companion is used only for genuinely visual questions, and any shown screen contains decision-capable, subject-specific artifacts rather than placeholders.
- Success signal: companion sessions more reliably help with layout, hierarchy, and similar visual questions while avoiding low-value or misleading browser detours.
- Constraints:
  - Preserve the current four archetypes.
  - Preserve the current runtime contract and `data-choice` interaction boundary.
  - Keep runtime guidance changes out of the first delivery unless the rules/templates still prove insufficient.
  - Fit the existing brainstorming workflow rather than inventing a separate companion workflow.
- Non-goals:
  - Expanding the archetype set in this slice.
  - Changing server, helper, or frame behavior.
  - Replacing terminal-first reasoning with browser-first reasoning.

## 3. Chosen Direction
- Recommended option: improve routing rules in [SKILL.md](/Users/gamarsoft/.codex/superpowers/skills/brainstorming/SKILL.md), improve artifact-quality rules in [visual-companion.md](/Users/gamarsoft/.codex/superpowers/skills/brainstorming/visual-companion.md), and strengthen example templates inside the current archetypes.
- Why it wins now:
  - It targets the highest-leverage failure seen in trials: valid companion usage with weak or placeholder artifacts.
  - It improves real usefulness without reopening runtime or metadata design.
  - It is reversible and low-risk compared with adding new archetypes or runtime behavior.
- What is consciously deferred:
  - runtime guidance changes
  - new archetypes such as a dedicated diagram or wireflow archetype
  - broader visual catalog expansion

## 4. Scope and Boundaries
- In scope:
  - explicit routing guidance for when the companion should and should not be used
  - a short pre-display checklist before any screen is shown
  - a hard `no placeholder screens` rule
  - stronger concrete examples for layout, hierarchy, and flow-style cases within the existing archetypes
- Out of scope:
  - runtime/server modifications
  - helper or frame-template behavior changes
  - new metadata requirements
  - a larger pattern library beyond the strongest observed use cases
- Rabbit holes:
  - adding new archetypes too early
  - trying to solve weak authoring with runtime automation
  - turning every borderline flow question into a browser requirement
- No-gos:
  - do not allow screens that only restate prose in boxes
  - do not treat the companion as mandatory for all UI-adjacent questions
  - do not weaken the terminal-first reasoning model
- Invariants / unchanged behavior:
  - the companion remains optional and per-question
  - the terminal remains primary for conceptual, scope, and text-heavy decisions
  - the four existing archetypes remain the v1 surface

## 5. User Experience / Behavior
- Primary flow:
  - The agent evaluates a question.
  - If the question is genuinely visual, the agent may use the companion.
  - Before writing a screen, the agent performs a short checklist.
  - If the screen fails the checklist, the agent strengthens the artifact or falls back to terminal.
  - If the screen passes, the agent shows it and explains what decision the user should be able to make from it.
- Key states:
  - terminal-only: conceptual, textual, or weakly visual questions stay out of the browser
  - eligible visual question: the browser is allowed, but only after the artifact-quality gate passes
  - borderline case: browser allowed only if the artifact becomes genuinely visual enough; otherwise terminal fallback
- Pre-display checklist:
  - The question is genuinely visual rather than conceptual or text-first.
  - The screen contains concrete, subject-specific visual content; no placeholder screens are allowed.
  - The visible differences between options support the intended decision.
  - The current recommendation or comparison status is visually legible without hiding honest alternatives.
  - If any item fails, the agent must revise the screen or fall back to terminal instead of showing it.
- Failure / edge cases:
  - valid visual topic but placeholder artifact: block the screen from being shown
  - weakly visual flow question: require calmer, diagram-like sequence treatment or stay in terminal
  - artifact too dense or rushed: treat as failing the quality bar even if it is technically visual
- Error handling:
  - when the pre-display checklist fails, the agent should revise or decline to show the screen rather than presenting low-value output
  - when the companion is no longer helpful, the agent should unload and return to terminal discussion
- Operator behavior:
  - the author must know what the user should be able to judge from the screen before the file is written

## 6. System Design
- Components / units:
  - [SKILL.md](/Users/gamarsoft/.codex/superpowers/skills/brainstorming/SKILL.md): owns routing decisions and the broader brainstorming workflow contract
  - [visual-companion.md](/Users/gamarsoft/.codex/superpowers/skills/brainstorming/visual-companion.md): owns screen-authoring quality, the pre-display checklist, and authoring examples
  - example HTML fragments under [examples/visual-companion](/Users/gamarsoft/.codex/superpowers/skills/brainstorming/examples/visual-companion): own concrete starting points for strong-fit cases
- Responsibilities:
  - `SKILL.md` answers: should the browser be used at all for this question?
  - `visual-companion.md` answers: is this authored screen good enough to show?
  - examples answer: what does a strong starting artifact look like for this case?
- Data flow:
  - user question -> routing decision in `SKILL.md` -> pre-display check in `visual-companion.md` -> authored example/template -> live screen
- Interfaces / boundaries:
  - routing rules must not duplicate every authoring detail
  - authoring rules must not redefine the whole brainstorming workflow
  - examples must demonstrate the rules but not become new hidden runtime requirements
- Dependencies and integration points:
  - existing brainstorming workflow
  - current visual companion authoring contract
  - current example kit and M001 comparison-first language
- Rollout / compatibility notes:
  - existing runtime behavior remains unchanged
  - existing archetype structure remains unchanged
  - examples can be strengthened without changing compatibility boundaries

## 7. Risks and Unknowns
- Known risks:
  - the quality bar could become too vague unless the checklist is explicit
  - better examples could still be misused if routing remains loose
  - flow-style cases may remain borderline even after stronger examples
- Assumptions:
  - the trials correctly identified authoring quality and routing as the highest-leverage problems
  - runtime behavior is sufficient for the next slice
- Open questions:
  - whether the existing carry-forward example also needs stronger artifact-quality rules in the same slice
  - whether any flow-style examples need separate diagram conventions later
- Mitigations or follow-up checks:
  - keep the first slice narrow and review examples against the same trial questions
  - defer runtime guidance changes unless the improved docs still leave repeated ambiguity

## 8. Validation Plan
- What must be tested or verified:
  - routing guidance clearly distinguishes visual from non-visual questions
  - the checklist blocks placeholder or low-information screens
  - strengthened examples make layout and hierarchy cases visibly more decision-capable
  - flow-style examples are either strong enough or explicitly bounded as borderline
- Key acceptance checks:
  - the skill text clearly says the companion is for genuinely visual questions only
  - the companion guide clearly forbids placeholder screens
  - the companion guide includes the committed checklist items and fallback behavior
  - example screens contain concrete, subject-specific content rather than labeled empty containers
- Pass / fail bar:
  - Pass: a valid visual question produces a screen that satisfies all checklist items.
  - Fail: the question is routed to the browser without satisfying the checklist, or the examples remain too generic to support the intended decision.
- Observability / rollout checks:
  - pressure-test the updated skills against the same three trial families used here
  - verify that the strengthened examples reduce ambiguity without runtime changes

## 9. Open Questions
- Should carry-forward examples be strengthened in the same slice or a follow-up?
  - Blocks only completeness of the example refresh, not the main routing/rules update.
- Should flow-style examples stay under the existing archetypes indefinitely?
  - Does not block the first slice.

## Appendix A. Options Considered
- Option A: rules plus stronger examples inside the existing four archetypes. Chosen because it directly addresses routing and artifact quality without expanding surface area.
- Option B: add a new wireflow or diagram archetype now. Rejected for the first slice because the evidence supports better examples before broader structure changes.
- Option C: change runtime/shell behavior first. Rejected because trials showed the shell is not the main bottleneck.

## Appendix B. Brownfield Context
- Existing prior art:
  - [visual-companion.md](/Users/gamarsoft/.codex/superpowers/skills/brainstorming/visual-companion.md)
  - [SKILL.md](/Users/gamarsoft/.codex/superpowers/skills/brainstorming/SKILL.md)
  - [2026-03-27--visual-companion-comparison-first-upgrade--gsd-handoff.md](/Users/gamarsoft/.codex/superpowers/docs/superpowers/specs/2026-03-27--visual-companion-comparison-first-upgrade--gsd-handoff.md)
  - [.gsd/milestones/M001/M001-SUMMARY.md](/Users/gamarsoft/.codex/superpowers/.gsd/milestones/M001/M001-SUMMARY.md)
- Trial outcomes that shaped this spec:
  - layout comparison and hierarchy critique became strong-fit once artifacts were concrete
  - flow-style comparisons remained more conditional and sensitive to presentation quality
  - placeholder or rushed screens undermined trust even when the topic was valid
- Milestone-1 example-to-file mapping:
  - `Active` — [side-by-side-comparison.html](/Users/gamarsoft/.codex/superpowers/skills/brainstorming/examples/visual-companion/side-by-side-comparison.html): strengthen as the canonical two-option layout comparison example and the default entry point for two-option flow-style comparisons when the artifacts are shown as real wireflows rather than prose lists.
  - `Active` — [ranked-alternatives.html](/Users/gamarsoft/.codex/superpowers/skills/brainstorming/examples/visual-companion/ranked-alternatives.html): strengthen as the canonical current-winner example for hierarchy-heavy visual comparisons with 3+ visible alternatives.
  - `Active` — [annotated-recommendation.html](/Users/gamarsoft/.codex/superpowers/skills/brainstorming/examples/visual-companion/annotated-recommendation.html): strengthen as the follow-up recommendation pattern after a comparison has produced a winning visual direction, especially for hierarchy/polish decisions.
  - `Untouched` — [carry-forward-summary.html](/Users/gamarsoft/.codex/superpowers/skills/brainstorming/examples/visual-companion/carry-forward-summary.html): remains valid in milestone 1 but is not part of the example-refresh slice unless later review shows carry-forward quality is the next blocker.

## Appendix C. Example Mapping
### Example Map — Routing A Visual Question

#### Story
Decide whether a brainstorm turn should use the visual companion or remain in terminal.

#### Rules
- Use the companion only when the user would understand the decision better by seeing it than reading it.
- Do not use the companion for conceptual, textual, or scope-only decisions.
- Borderline flow questions require a genuinely visual artifact; otherwise stay in terminal.

#### Examples
1. Given a choice between two onboarding layouts
   When the agent is comparing spatial structure and hierarchy
   Then the companion is allowed.

2. Given a question about which product principle should drive onboarding
   When the decision is conceptual rather than visual
   Then the companion should not be used.

#### Open Questions
- How much diagram structure is enough to classify a flow question as genuinely visual?

#### Out of Scope / Deferred
- New archetypes for every sub-type of visual question.

### Example Map — Pre-Display Quality Gate

#### Story
Prevent low-value screens from being shown for otherwise valid visual questions.

#### Rules
- No placeholder screens.
- The screen must contain concrete, subject-specific visual content.
- The visible differences between options must support the intended decision.
- The agent must know what the user should be able to judge from the screen before showing it.
- If any check fails, the agent must revise the artifact or stay in terminal.

#### Examples
1. Given a valid layout comparison
   When the cards only contain labels and empty containers
   Then the screen fails the gate and must be revised.

2. Given a hierarchy comparison with real tasks, metrics, and visible emphasis differences
   When the user can judge the scan path at a glance
   Then the screen passes the gate.

#### Open Questions
- Whether density/readability should be named as a separate checklist item or treated as part of artifact quality.

#### Out of Scope / Deferred
- Runtime enforcement of the checklist.

### Example Map — Stronger Example Templates

#### Story
Provide stronger starting examples for the strongest observed visual use cases without changing the archetype set.

#### Rules
- Improve examples inside the existing four archetypes.
- Prioritize layout, hierarchy, and flow-style examples.
- Do not let examples silently redefine runtime requirements.

#### Examples
1. Given a side-by-side layout comparison
   When the example includes actual fields, copy, and decisions tied to the subject
   Then it provides a credible starting point for a visual choice.

2. Given a flow-style comparison
   When the example is still only a dressed-up list
   Then it should be improved further or treated as borderline.

#### Open Questions
- Whether carry-forward examples need equal strengthening in the first slice.

#### Out of Scope / Deferred
- Large-scale template catalog expansion.

## Appendix D. Decisions / ADR Notes
- Decision: split routing and authoring-quality responsibilities across `SKILL.md` and `visual-companion.md`.
- Decision: keep runtime guidance changes out of the first slice.
- Decision: keep the current four archetypes and improve example strength rather than adding new ones.

## Appendix E. GSD Handoff Seed
- Follow-on handoff file: [2026-03-29--visual-companion-routing-and-authoring-quality--gsd-handoff.md](/Users/gamarsoft/.codex/superpowers/docs/superpowers/specs/2026-03-29--visual-companion-routing-and-authoring-quality--gsd-handoff.md)
