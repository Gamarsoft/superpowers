# Brainstorming Visual Companion Protocol Hardening

## 1. Executive Summary
- This hardens the brainstorming workflow after real brownfield use exposed protocol regressions in the visual-companion path.
- It is for the agent authoring and running brainstorm sessions with terminal plus visual companion.
- Why now: M002 improved routing language and authoring quality, but live use still showed execution drift around startup, sequencing, and terminal confirmation continuity.
- First delivery boundary: codify a strict per-visual-turn protocol, add reviewable pressure scenarios for that protocol, and allow selective durable wireframe appendices for layout-heavy decisions without reopening the runtime contract.

## 2. Framing Brief
- Primary user / operator: the agent running brainstorming and deciding when to use the visual companion.
- Job / problem: keep visual turns trustworthy by making startup, sequencing, and terminal confirmation behavior deterministic once the companion is accepted.
- Current workaround / current behavior: an accepted visual-companion session can still fail to start on the first qualifying visual question, can ask a layout/UI question before authoring the visual artifact, and can stop using the platform question tool once browser turns begin.
- Desired outcome: every genuinely visual question in an accepted session follows the same artifact-first, browser-visible, terminal-confirmed protocol, and key spatial decisions can survive into the written spec as low-fidelity wireframe appendices when needed.
- Success signal: the same real brownfield scenario no longer needs manual nudges to start the companion, generate visuals before asking, or restore terminal confirmations after browser use begins.
- Constraints:
  - Keep the browser optional and per-question.
  - Keep conceptual, scope, and text-first turns in terminal.
  - Keep the runtime, helper, metadata, and archetype contract unchanged in this slice.
  - Fit the existing brainstorming workflow rather than inventing a separate visual mode.
- Non-goals:
  - Reopening `server.cjs`, `helper.js`, or frame-template behavior in this slice.
  - Making browser-first interaction the default.
  - Requiring durable wireframes for every visual turn.

## 3. Chosen Direction
- Recommended option: treat this as a workflow regression-hardening slice that tightens the operator protocol in `skills/brainstorming/SKILL.md` and `skills/brainstorming/visual-companion.md`, then backs that protocol with pressure scenarios and review checks.
- Skill-authoring rule: use `writing-skills` to guide the skill-document update and its validation path so the workflow hardening is tested as process behavior, not only rewritten as prose.
- Minimum `writing-skills` loop:
  - follow the `writing-skills` prerequisite that skill validation is grounded in `test-driven-development`
  - run one baseline pressure scenario that reproduces the live-use regression before editing the skill
  - verify the baseline scenario fails for the expected reason
  - edit the skill documents and review assets
  - rerun the same pressure scenario and capture evidence that the protocol now holds
- Why it wins now:
  - It targets the observed failure directly instead of inferring a runtime defect too early.
  - It preserves the proven terminal-first plus browser-optional model.
  - It creates a reviewable bar for future skill changes rather than relying on operator memory.
- What is consciously deferred:
  - runtime/helper enforcement hooks
  - new archetypes
  - mandatory durable artifacts for every browser turn

## 4. Scope and Boundaries
- In scope:
  - explicit first-visual-turn startup behavior after consent
  - explicit artifact-first sequencing for every genuinely visual question
  - continued use of the platform question tool in terminal for each genuinely visual question
  - selective wireframe appendix rules for layout and UI structure decisions that need to persist into the written artifacts
  - a named pressure-scenario artifact and review guidance that exercise the protocol
- Out of scope:
  - runtime/server/helper changes
  - new required metadata beyond `data-choice`
  - new browser-only response loops
  - mandatory appendices for every visual turn
- Rabbit holes:
  - treating acceptance as a switch into browser mode for the rest of the session
  - solving workflow drift by smuggling in runtime changes without first proving the docs path is insufficient
  - converting every UI-adjacent question into a wireframe requirement
- No-gos:
  - no visual question should be asked in terminal before the corresponding visual artifact exists and is ready to view
  - no accepted visual session should silently drop the terminal question-tool cadence for qualifying visual turns
  - no durable wireframe appendix should pretend to be high-fidelity design
- Invariants / unchanged behavior:
  - visual companion use remains optional and question-by-question
  - conceptual, scope, and text-first decisions stay in terminal
  - the four existing archetypes remain the visual-companion surface
  - terminal feedback remains primary even when browser events are present

## 5. Current, Expected, and Unchanged Behavior
### Current behavior
- The user can explicitly accept the visual companion, but the first qualifying visual question may still stay entirely in terminal until manually corrected.
- A layout or UI question can be asked before a concrete companion artifact is authored and shown.
- Once browser work begins, the workflow can stop using the platform question tool for visual decision checkpoints.

### Expected behavior
- After the user accepts the visual companion, the next genuinely visual question must start the companion flow instead of deferring it.
- For every genuinely visual question, the agent must create or refresh the visual artifact first, let it become viewable, then ask the terminal decision prompt with the platform question tool.
- The terminal decision prompt must stay present for qualifying visual turns even after the companion has already been opened earlier in the session.
- If a visual artifact fails the pre-display quality gate, the agent must revise it or stay in terminal rather than asking the visual question against an unseen or weak artifact.

### Unchanged behavior
- Acceptance does not force browser use for later conceptual turns.
- Browser events remain supplemental context, not the primary decision channel.
- The workflow may still return to terminal-only discussion between visual turns.

### Reproduction shape
1. User accepts the visual companion via the dedicated question tool.
2. The next brainstorm decision is a layout or UI/UX question that is materially easier to judge by seeing.
3. The agent asks the question in terminal without first opening the companion and showing the artifact, or stops using the dedicated terminal question tool after browser work begins.

### Non-regression target
- A future skill edit should fail review if it permits:
  - post-consent deferral of the first qualifying visual turn
  - asking a qualifying visual question before the artifact is visible
  - dropping terminal question-tool prompts for qualifying visual turns

## 6. User Experience / Behavior
### Accepted visual-companion session protocol
1. Ask for visual-companion consent once, only when an upcoming question is genuinely visual.
2. Acceptance makes browser use available; it does not switch the rest of the brainstorm into browser mode.
3. On each later turn, first decide whether the question is genuinely visual.
4. If the question is conceptual, scope-setting, or text-first, stay in terminal.
5. If the question is genuinely visual:
   - start or confirm the companion session is active
   - author or refresh the visual artifact first
   - pass the pre-display quality gate before showing it
   - tell the user what they are viewing and what decision it supports
   - ask the decision or confirmation in terminal with the platform question tool
6. On the next turn, merge browser events with terminal feedback, keeping terminal feedback primary.

### Artifact-first rule
- For layout, hierarchy, workflow-structure, or other genuinely visual decisions, the artifact must appear before the terminal decision prompt.
- The terminal prompt should assume the user can already see the artifact being discussed.
- If the artifact is not ready, the agent is not ready to ask the visual question.

### Terminal confirmation continuity
- The same dedicated question-tool discipline used for reflection and discovery must continue on qualifying visual turns.
- Opening the companion does not authorize a switch to freeform-only terminal questioning for those turns.
- If the platform question tool is unavailable, the agent may fall back to plain terminal text, but that is degraded behavior and should be named as such.

### Selective wireframe appendix behavior
- Create a durable wireframe appendix entry only when:
  - the decision is materially about spatial structure or layout
  - the structure needs to survive into the written spec or handoff
  - a low-fidelity representation is enough to preserve the decision
- Do not create a durable wireframe appendix for every visual turn.
- Durable wireframes should stay low-assumption and low-fidelity: ASCII, markdown block diagrams, or equivalent structure-first representations are preferred.
- The appendix should capture the chosen structure and the key visual reasoning, not replace the main narrative spec.
- First-slice boundary: add this guidance to the design spec path and allow the GSD handoff to link to an existing wireframe appendix when relevant, but do not change the handoff template itself in this slice.

### Failure / edge cases
- Accepted session but first qualifying visual turn remains terminal-only: protocol failure.
- Visual artifact drafted but not yet concrete enough to pass the pre-display gate: revise or stay in terminal.
- Later conceptual turn after several browser turns: return to terminal-only behavior without forcing the companion.
- Platform question tool unavailable: continue with named degraded behavior, not silent drift.

## 7. System Design
- Components / units:
  - `skills/brainstorming/SKILL.md`: owns the per-turn workflow contract and question-tool continuity.
  - `skills/brainstorming/visual-companion.md`: owns artifact-first behavior, pre-display gating, and when durable wireframes are appropriate.
  - `skills/writing-skills/SKILL.md`: governs how the skill update is pressure-tested and validated before it is considered complete.
  - `skills/test-driven-development/SKILL.md`: provides the red-green bar that the `writing-skills` validation loop must follow.
  - `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md`: should capture the concrete baseline and rerun scenarios for the observed regression family.
  - `skills/brainstorming/references/spec-template.md`: should acknowledge that wireframe appendices are allowed when spatial decisions need to persist.
  - `skills/brainstorming/references/spec-review-checklist.md`: should name the protocol regression checks explicitly.
  - `skills/brainstorming/spec-document-reviewer-prompt.md`: should require reviewers to check the protocol failure family directly.
- Responsibilities:
  - `SKILL.md` answers whether the turn stays in terminal or enters the visual path and what the sequence must be.
  - `visual-companion.md` answers whether the artifact is ready to show and whether a durable wireframe should also be written down.
  - review assets answer whether a future edit preserves or weakens the protocol.
- Data flow:
  - consent decision -> per-turn routing -> artifact authoring -> pre-display gate -> terminal decision prompt -> terminal plus browser feedback -> optional durable wireframe appendix in the written artifacts
- Interfaces / boundaries:
  - do not rely on runtime state to remember whether a terminal confirmation is still required
  - do not expand the runtime metadata boundary
  - do not turn durable appendices into a fifth visual-companion archetype
- Dependencies and integration points:
  - existing brainstorming workflow
  - existing visual-companion guide
  - `writing-skills` process for skill-update validation
  - `test-driven-development` as the baseline/rerun discipline required by `writing-skills`
  - reviewer workflow for written specs and handoffs
  - contract and acceptance tests that already lock parts of the companion behavior
- Rollout / compatibility notes:
  - start with documentation plus review-hardening
  - only open a runtime follow-up if the same live scenario still fails after the hardened guidance is applied

## 8. Risks and Unknowns
- Known risks:
  - prose changes alone may still be interpreted loosely unless pressure scenarios are concrete enough
  - visual questions at the boundary between flow and concept can still create judgment drift
  - wireframe appendices can sprawl if the trigger rule is not narrow
- Assumptions:
  - the observed failure is primarily a workflow-contract problem rather than a missing runtime primitive
  - the platform question tool remains available in normal Codex/OpenCode brainstorming sessions
- Open questions:
  - whether a later runtime slice should add explicit diagnostics for skipped first-visual-turn startup
- Mitigations or follow-up checks:
  - pressure-test the exact real-use-case failure path during review
  - keep the first slice narrow and explicit
  - defer runtime work until the hardened workflow is shown insufficient

## 9. Validation Plan
- What must be tested or verified:
  - the workflow text explicitly requires first-visual-turn startup after consent
  - the workflow text explicitly requires artifact-first sequencing for every qualifying visual turn
  - the workflow text explicitly preserves terminal question-tool prompts on qualifying visual turns
  - the spec and handoff clearly scope durable wireframe appendices as selective, low-fidelity artifacts and keep handoff-template changes deferred
  - the implementation path explicitly calls for `writing-skills` plus its `test-driven-development` prerequisite to guide skill updating and validation
  - `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md` defines at least one baseline failure scenario and one post-edit rerun using the same live-use regression family
  - `skills/brainstorming/references/spec-review-checklist.md` includes explicit checks for first-visual-turn startup, artifact-first sequencing, terminal confirmation continuity, and named degraded fallback
  - `skills/brainstorming/spec-document-reviewer-prompt.md` tells reviewers to look for the same regression family directly
- Key acceptance checks:
  - a reviewer can point to the exact rule that forbids asking a qualifying visual question before the artifact is viewable
  - a reviewer can point to the exact rule that keeps the terminal question tool in play after browser turns begin
  - a reviewer can point to the exact fallback wording requirement when the question tool is unavailable
  - the baseline pressure scenario is recorded as failing before the skill edits
  - the same pressure scenario is rerun after the edits and recorded as passing for the targeted protocol checks
  - the durable wireframe rule is narrow enough that not every visual turn creates appendix churn
  - no runtime/helper change is required to complete this slice
- Observability / rollout checks:
  - rerun the same real-use-case scenario against the updated workflow
  - if the scenario still fails, document the failure as evidence for a runtime follow-up rather than silently stretching this slice

## 10. Open Questions
- If the platform question tool is unavailable in a future environment, how explicit should the degraded terminal fallback wording be?
  - This does not block the first slice.

## Appendix A. Options Considered
- Option A: harden the workflow contract and back it with pressure scenarios, while keeping runtime changes deferred. Chosen because it addresses the observed failure directly and preserves reversibility.
- Option B: add runtime or helper enforcement now. Rejected for the first slice because the live failure does not yet prove the docs-and-review layer is insufficient.
- Option C: keep the changes prose-only. Rejected because the failure already slipped past prose and needs a reviewable non-regression bar.

## Appendix B. Brownfield Context
- Relevant existing surfaces:
  - `skills/brainstorming/SKILL.md`
  - `skills/brainstorming/visual-companion.md`
  - `skills/writing-skills/SKILL.md`
  - `skills/test-driven-development/SKILL.md`
  - `tests/brainstorm-server/visual-companion-contract.test.js`
  - `tests/brainstorm-server/live-companion-acceptance.test.js`
  - `docs/superpowers/specs/2026-03-29--visual-companion-routing-and-authoring-quality.md`
  - `.gsd/milestones/M002/M002-SUMMARY.md`
- Real-use-case findings to preserve:
  - explicit consent is not sufficient if the first qualifying visual turn can still remain terminal-only
  - asking the visual question before showing the artifact breaks the companion’s value proposition
  - losing the dedicated terminal question tool after browser startup weakens guided discovery discipline
  - low-fidelity wireframes can be useful as durable appendices when spatial structure is itself part of the decision

## Appendix C. Example Mapping
### Example Map — First Qualifying Visual Turn

#### Story
Start the visual path correctly after the user has accepted the companion.

#### Rules
- Acceptance alone does not make all later turns visual.
- The first later genuinely visual question must start the companion flow rather than remaining terminal-only.
- The terminal decision prompt happens after the artifact is viewable, not before.

#### Examples
1. Given the user accepted the companion
   When the next decision is which master-detail layout is clearer
   Then the agent starts or confirms the companion, renders the comparison, and only then asks the terminal decision prompt.

2. Given the user accepted the companion
   When the next decision is which product principle should drive the feature
   Then the agent stays in terminal because the turn is conceptual rather than genuinely visual.

#### Open Questions
- None blocking.

#### Out of Scope / Deferred
- Runtime enforcement of startup order.

### Example Map — Terminal Confirmation Continuity

#### Story
Keep the dedicated question-tool cadence even after browser turns begin.

#### Rules
- Qualifying visual turns still end in a dedicated terminal decision prompt.
- Browser clicks supplement but do not replace the terminal decision prompt.
- Plain terminal text is a degraded fallback only when the question tool is unavailable.
- When degraded fallback is used, the agent must explicitly say the question tool is unavailable, say the artifact is already ready to view, and keep the same framed options or confirmation shape.

#### Examples
1. Given the companion is already open from an earlier turn
   When the next qualifying visual question compares two hierarchy treatments
   Then the agent refreshes the artifact and asks the decision in terminal with the platform question tool.

2. Given the companion is open
   When the agent asks for the user’s choice only in freeform prose without using the question tool even though it is available
   Then the turn fails the protocol.

3. Given the companion is open but the platform question tool is unavailable
   When the agent asks the terminal decision in plain text
   Then the agent explicitly names the degraded fallback, confirms the artifact is already viewable, and preserves the same framed options or confirmation choices in terminal text.

#### Open Questions
- None blocking.

#### Out of Scope / Deferred
- Browser-native confirmation flows.

### Example Map — Selective Wireframe Appendix

#### Story
Preserve spatial decisions in durable written artifacts without turning every visual turn into appendix churn.

#### Rules
- Create a durable wireframe appendix only when the spatial structure matters to later implementation or review.
- Use low-fidelity, structure-first formatting.
- Keep the appendix tied to the decision it preserves.

#### Examples
1. Given a major layout decision between master-detail and stacked-detail views
   When the chosen direction must survive into the handoff
   Then the spec includes a low-fidelity wireframe appendix entry that records the chosen structure and its key visual rationale.

2. Given a visual turn that is mainly about annotation emphasis on an already chosen screen
   When the structure does not need durable preservation
   Then no wireframe appendix is added.

#### Open Questions
- Whether the handoff template should mention appendix linkage explicitly.

#### Out of Scope / Deferred
- Mandatory appendices for every visual turn.

## Appendix D. Wireframe Appendix Pattern
- Purpose: preserve layout or spatial reasoning that would be awkward to reconstruct from prose alone.
- Recommended form:
  - short title
  - low-fidelity diagram or ASCII wireframe
  - 3-6 bullets naming the key structural decisions
- Recommended placement:
  - appendix section in the design spec
  - linked from the relevant GSD handoff section when it materially shapes implementation, without changing the handoff template in this slice
- Guardrails:
  - keep it low-fidelity
  - keep it tied to a specific decision
  - do not create one unless it materially improves handoff clarity

## Appendix E. Pressure Scenario Validation Loop
- Required scenario artifact: `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md`
- Minimum scenarios:
  - accepted-companion session where the first later qualifying visual turn must start the companion and show the artifact before the terminal question
  - qualifying visual turn after the companion is already open where terminal question-tool continuity must be preserved
  - qualifying visual turn where the question tool is unavailable and degraded fallback must be named explicitly
- Required validation cycle:
  - record a baseline run before editing and verify the expected failure
  - update the skill documents and review assets
  - rerun the same scenarios after editing
  - capture pass/fail evidence in the milestone or review notes

## Appendix F. Decisions / ADR Notes
- Decision: use docs-and-review hardening before any runtime change.
- Decision: preserve terminal-first reasoning and question-tool discipline on qualifying visual turns.
- Decision: allow selective durable wireframes without turning them into a new companion archetype.

## Appendix G. GSD Handoff Seed
- Active requirements should focus on explicit protocol language, review pressure scenarios, and selective wireframe appendix guidance.
- Deferred requirements should keep runtime/helper enforcement as a follow-up only if the hardened workflow still fails the real scenario.
