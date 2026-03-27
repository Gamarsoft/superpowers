# Visual Companion Comparison-First Upgrade

## 1. Executive Summary
- Design a comparison-first upgrade for the brainstorming visual companion.
- It is for the agent shaping a brainstorm and the human reviewing alternatives in the browser.
- It matters now because the current companion can show screens and capture simple choices, but it is still a relatively thin decision aid.
- The first delivery boundary is a reusable comparison-oriented authoring kit with lightweight decision carry-forward, while preserving the current non-blocking terminal-first workflow and runtime contract.

## 2. Framing Brief
- Primary user / operator: the agent running the brainstorm, with the human reviewer as the second user of the browser surface.
- Job / problem: help the human compare alternatives faster, understand what is being recommended, and carry the winning direction forward without ambiguity.
- Current workaround / current behavior: the companion serves HTML screens, supports fragment/full-document rendering, and records choice-bearing browser events, but authors must still assemble strong comparison screens manually and the carry-forward of decisions is mostly implicit.
- Desired outcome: the companion becomes a deliberate design instrument for visual comparisons rather than a generic HTML display surface.
- Success signal: brainstorming sessions converge faster on a direction, with less ambiguity about differences, winners, and what the next screen is building on.
- Constraints:
  - Preserve the non-blocking browser-plus-terminal model.
  - Preserve the current HTML authoring contract, including fragment and full-document support.
  - Avoid deep server or lifecycle rewrites in the first release.
  - Fit the current brainstorming skill and server layout under `skills/brainstorming/`.
- Non-goals:
  - building a workflow engine with branching, gating, or approvals
  - introducing mandatory structured authoring formats for every screen
  - replacing terminal reasoning and recommendations with browser-native logic

## 3. Chosen Direction
- Recommended option: a comparison-first companion kit layered on top of the existing runtime.
- Why it wins now:
  - It increases user value at the point where the companion matters most: comparing options and reducing ambiguity.
  - It fits the current codebase and runtime contract.
  - It is more reversible and lower-risk than redesigning the session model or building a session-wide decision system.
- What it makes harder:
  - It does not solve deeper session memory or workflow orchestration in v1.
  - It gives diagram-heavy brainstorming less attention than comparison-first use cases in the first milestone.
- What is consciously deferred:
  - session-wide decision ledgers
  - workflow orchestration and branching
  - server-heavy architecture changes
  - optional metadata or DSL work beyond existing `data-choice`

## 4. Scope and Boundaries
### In scope
- exactly four v1 screen archetypes:
  - side-by-side comparison
  - ranked alternatives
  - annotated recommendation / current winner
  - carry-forward summary
- an explicit runtime authoring rule: when creating visual companion screens, the agent invokes `/frontend-design` or `$frontend-design` as the screen-structuring sub-step
- stronger visual hierarchy for recommendation, alternatives, and trade-off framing
- clearer selected-state behavior and “current winner” treatment
- lightweight carry-forward patterns that make the chosen direction explicit on later screens
- stronger guidance in `visual-companion.md` around when and how to use comparison-oriented screens
- fragment-first comparison-kit defaults for screens that use the shared frame

### Out of scope
- persistent cross-session state
- a new structured DSL or required metadata format for all screens
- server protocol redesign
- replacing generic brainstorming with a visual-only workflow
- automatic comparison-kit behavior for full-document screens

### Rabbit holes
- turning the companion into a general-purpose frontend generation framework
- over-optimizing for long multi-step session memory before the comparison layer is strong
- adding “smart” helper behavior that obscures plain HTML authoring

### No-gos
- breaking existing valid authored screens
- requiring the browser to become the primary feedback channel
- mixing unrelated server refactors into this effort

### Invariants / unchanged behavior
- The terminal remains the primary conversation and recommendation channel.
- The browser remains optional and question-by-question.
- The runtime still serves authored HTML from `screen_dir` and reads browser interaction from `state_dir`.
- Fragment and full-document screen authoring both continue to work.
- V1 comparison-kit defaults apply to fragment screens wrapped in the shared frame; full-document screens remain compatibility-supported but must author comparison presentation explicitly.
- Existing lifecycle behavior around startup, reload, idle shutdown, and owner PID remains intact unless a specific bugfix requires otherwise.

## 5. User Experience / Behavior
### Primary flows
1. The agent decides a question is genuinely visual and uses the companion.
2. The agent authors a comparison-oriented screen using a clearer archetype rather than ad hoc layout.
3. The human can immediately see:
   - what options are being compared
   - which option is recommended
   - what the major trade-off is
   - what is currently selected
4. The human optionally clicks a choice in the browser and replies in the terminal.
5. The next screen explicitly carries forward the selected direction or labels the comparison as still open.

### Key states
- No screen yet: waiting page remains available.
- Fresh comparison: options are visible, recommendation is legible, no winner selected yet.
- Ranked comparison: alternatives have a visible order and a visually legible “current best” treatment without hiding lower-ranked options.
- Selection made: selected state is obvious and visually distinct.
- Carry-forward screen: previous winner is shown explicitly so the next screen does not feel disconnected.
- Open comparison: when no final choice has been made, the screen should communicate that the comparison is still exploratory.

### Failure / edge cases
- If the user does not click in the browser, the terminal response still drives the session.
- If a screen is authored as a full document, it remains valid in v1 but does not get comparison-kit defaults automatically; the author must provide comparison structure explicitly.
- If the brainstorm involves diagrams rather than layout comparisons, the comparison-first kit should not block those use cases, but v1 does not need to optimize for every diagram style equally.
- If the user changes their mind after selecting an option, the next screen should be able to show the new carried-forward direction without pretending the earlier selection never happened.
- If the user only replies in the terminal and never clicks in the browser, the next screen must still be able to show a chosen or still-open direction without depending on browser event state.

### Error handling / operator behavior
- Authors should not need hidden runtime knowledge to create a good comparison screen.
- Guidance should prefer a small number of named patterns over broad stylistic freedom.
- The browser helper should remain lightweight; behavior that affects decision state must be predictable and visible.
- Full-document authors should have a documented compatibility rule, not an implicit promise of feature parity with fragment defaults.
- Screen creation should explicitly route through `/frontend-design` or `$frontend-design` so structure and layout quality come from a named skill rather than ad hoc styling.
- In brainstorming, the role of `frontend-design` is to produce well-structured, deliberate screens for comparison, not near-final product mockups to copy verbatim.

## 6. System Design
### Components / units
- `skills/brainstorming/visual-companion.md`
  - owns the product guidance and authoring contract for v1
  - documents when to use the companion, when to choose each of the four archetypes, the fragment-first/full-document compatibility rule, and the explicit `/frontend-design` or `$frontend-design` invocation during screen creation
- `frontend-design` skill and its references
  - own the runtime screen-structuring step for companion screens
  - provide the quality bar and references for typography, color, layout, motion, interaction, responsive behavior, and UX writing
  - are used to avoid generic or sloppy screen composition during brainstorming
- `skills/brainstorming/scripts/frame-template.html`
  - owns fragment-screen defaults only
  - provides stronger default presentation scaffolding for recommendation, alternative visibility, ranked order emphasis, and carry-forward summary treatment
- `skills/brainstorming/scripts/helper.js`
  - owns lightweight interactive feedback only
  - keeps selected-state behavior clear and compatibility-safe for `data-choice` interactions
  - does not become a session workflow engine and does not introduce new required metadata in v1
- Authored HTML in `screen_dir`
  - remains the source of truth
  - must use one of the four archetypes when the goal is comparison-first decision support
  - carries carry-forward content explicitly in the authored markup rather than relying on hidden runtime state
- Existing `server.cjs` session/runtime
  - remains the transport and serving layer rather than the main product surface for this change

### Responsibilities
- Brainstorming guidance owns when to use the companion and which pattern to choose.
- `/frontend-design` or `$frontend-design` owns the runtime screen-structuring pass when the agent creates companion screens.
- Authored HTML owns the visible comparison and explanation structure.
- Helper behavior owns lightweight interaction capture and visible selected-state feedback.
- The server owns file serving, reload, and event capture, not workflow logic.

### V1 artifact boundary
- Required file changes in milestone 1:
  - `skills/brainstorming/visual-companion.md`
    - add the four archetypes
    - add authoring rules for recommendation, ranked order, and carry-forward summary
    - add the explicit full-document compatibility rule
    - add the explicit runtime instruction to invoke `/frontend-design` or `$frontend-design` when creating screens
    - add the bounded design-context workflow for satisfying `frontend-design`'s precondition during a brainstorming session
  - `skills/brainstorming/scripts/frame-template.html`
    - strengthen fragment-only visual defaults so recommendation, current winner, and carry-forward summary are more legible
  - `skills/brainstorming/scripts/helper.js`
    - keep or slightly refine selected-state feedback for comparison screens
    - remain `data-choice`-based and additive
- Not required in milestone 1:
  - `skills/brainstorming/scripts/server.cjs`, unless a small compatibility bug blocks the above behavior
  - new session storage, branching state, or metadata parsing


### Data flow
1. Agent starts the session and receives `url`, `screen_dir`, and `state_dir`.
2. Agent writes a comparison-oriented screen to `screen_dir`.
3. Browser renders the newest screen and helper behavior captures user choice interactions.
4. Choice-bearing events still append to `state_dir/events`.
5. Agent merges browser interactions with terminal feedback and authors the next screen.
6. If carrying a winner forward, the new screen makes that state explicit in its content rather than requiring implicit memory.

### Interfaces / boundaries
- Preserve the current `screen_dir` and `state_dir/events` contract.
- Any new authoring helper should be additive and optional.
- Existing screens should not be forced to adopt a new schema to remain valid.
- Full-document screens are compatibility-supported, not feature-parity targets for fragment defaults in v1.
- Screen generation quality should come from invoking `/frontend-design` or `$frontend-design`, not from expanding server/runtime responsibilities.
- `frontend-design` is used for structure quality during brainstorming; it is not a commitment that every screen is a near-final artifact.

### Runtime design-context workflow
Before the first `/frontend-design` or `$frontend-design` invocation in a visual companion session, satisfy the skill's context gate using this bounded order:
1. Check for an already-loaded `Design Context` section in current instructions.
2. Check project `.impeccable.md` for the required design context.
3. If neither exists, gather a minimal one-time session design context from the user:
   - target audience
   - use case / job to be done
   - brand personality / tone

This context is captured once per visual-companion brainstorming session and reused for later screen-authoring turns.

Fallback rule:
- If the user does not want to provide design context mid-session, the agent may produce a plain archetype-based companion screen without `/frontend-design`, but that is an explicit degraded mode rather than the preferred path.
- The preferred path for companion screen creation remains invoking `/frontend-design` or `$frontend-design` after the minimal context bundle exists.

### Dependencies and integration points
- Current runtime files:
  - `skills/brainstorming/visual-companion.md`
  - `skills/brainstorming/scripts/server.cjs`
  - `skills/brainstorming/scripts/helper.js`
  - `skills/brainstorming/scripts/frame-template.html`
- Current tests:
  - `tests/brainstorm-server/server.test.js`
  - `tests/brainstorm-server/ws-protocol.test.js`
  - scenario discipline in `skills/brainstorming/references/test-scenarios.md`

### Rollout / migration / compatibility notes
- Default approach is compatibility-preserving: improve patterns above the current contract.
- If new helper conventions are added, they should be optional and documented as enhancements, not requirements.
- Existing hand-authored screens remain valid, even if they do not benefit from the new comparison kit immediately.
- V1 full-document rule: full documents remain valid and still receive helper injection, but comparison-kit defaults are fragment-first and do not auto-apply to full docs.
- Runtime authoring rule: when the agent creates a companion screen, it should invoke `/frontend-design` or `$frontend-design` for structure quality; if the required design context is missing, the flow follows the bounded design-context workflow above.

### Brownfield context appendix summary
- Current implementation already supports a non-blocking loop, a shared frame for fragments, and choice event capture.
- The gap is mostly in authoring quality, decision legibility, and carry-forward clarity rather than missing runtime primitives.

## 7. Risks and Unknowns
### Known risks
- The design over-indexes on layout comparison and under-serves architecture-diagram or flow-heavy brainstorming.
- The new guidance becomes too prescriptive and discourages flexible authoring when needed.
- The feature drifts into hidden statefulness without clear user-visible value.

### Assumptions
- Stronger comparison patterns will improve decision quality more than pure visual polish.
- Keeping the current runtime contract stable lowers delivery risk materially.
- Lightweight decision carry-forward is enough for a first release.

### Mitigations / follow-up checks
- Validate against real scenario prompts centered on side-by-side decisions.
- Keep all additive behavior reversible.
- Review whether diagram-heavy use cases are materially blocked; if so, capture them for a follow-up spec rather than stretching v1.

## 8. Validation Plan
### What must be tested or verified
- Comparison screens make recommendation, alternatives, and selected state legible at a glance.
- Existing authored screens still render correctly.
- Carry-forward screens make the chosen direction explicit without requiring deep hidden state.
- The terminal remains the primary reasoning channel.

### Key acceptance checks
- A/B or A/B/C layout comparisons are easier to parse than in the current system.
- Ranked alternatives clearly show order and current winner without hiding lower-ranked options.
- Annotated recommendation screens make both the recommendation and the main trade-off immediately visible.
- A selected choice is visually obvious and reflected in the next authored screen when carried forward.
- Terminal-only decisions still support a clear carry-forward screen even with no browser click event.
- Full-document screens remain valid, but fragment screens are the only screens that receive comparison-kit defaults automatically.
- Screen creation flow explicitly calls `/frontend-design` or `$frontend-design` rather than relying on generic HTML generation.
- The first `/frontend-design` or `$frontend-design` call in a session uses an explicit, bounded design-context source or a documented degraded-mode fallback.
- The first release does not require a server rewrite or a session-state product.
- The documented patterns are easy enough to use that authors can consistently produce stronger screens.

### Observability / rollout checks
- Validate with representative brainstorm scenarios rather than only file-level runtime tests.
- Confirm any helper changes remain additive and do not break existing screens.

## 9. Open Questions
- Whether diagram-centric patterns belong in the same first release or a later follow-up
- Whether the four archetypes cover enough real brainstorming use cases without adding a fifth pattern
- Whether any helper refinement beyond selected-state treatment is needed after the first authoring pass
- Whether the repo should provide design context centrally so `/frontend-design` can run without extra prompting during brainstorming

## Appendix A. Options Considered
### Option A — Visual Polish Pack
- Optimizes for: stronger-looking screens and better presentation
- Rejected for now because: it risks improving appearance more than decision support

### Option B — Comparison-First Companion Kit
- Optimizes for: user value, codebase fit, and low-risk improvement to the actual decision workflow
- Chosen because: it improves comparisons, preserves the current contract, and keeps the first milestone reversible

### Option C — Session Decision System
- Optimizes for: continuity and structured decision tracking
- Rejected for now because: it adds too much product and technical scope before the comparison layer is strong enough

## Appendix B. Brownfield Context
- Current offer rules and workflow fit are in `skills/brainstorming/SKILL.md`.
- Current operating guide is `skills/brainstorming/visual-companion.md`.
- Runtime transport and lifecycle live in `skills/brainstorming/scripts/server.cjs`.
- Browser-side interaction behavior lives in `skills/brainstorming/scripts/helper.js`.
- Fragment wrapping and shared visual shell live in `skills/brainstorming/scripts/frame-template.html`.
- Existing tests already validate startup, rendering, reload, and event persistence in `tests/brainstorm-server/server.test.js`.

## Appendix C. Example Mapping
### Example Map — Compare Alternatives
#### Story
The agent wants to show multiple directions and help the user decide which one is strongest.

#### Rules
- The screen is authored through `/frontend-design` or `$frontend-design`.
- The recommendation must be visually legible.
- Alternatives must remain visible enough for honest comparison.
- Selected state must be obvious without reading raw markup.
- Terminal reasoning remains the final source of recommendation text.

#### Examples
1. Given two onboarding layouts
   When the companion shows a comparison screen
   Then the user can identify the recommended option, the key trade-off, and the visible alternatives at a glance.

2. Given three alternatives and no settled winner
   When the screen is shown
   Then the screen communicates that the comparison is still open instead of implying a false final decision.

#### Open Questions
- Do we need a standard visual slot for trade-off text?
- How strongly should recommendation be visually emphasized relative to alternatives?

#### Out of Scope / Deferred
- branch-based multi-step comparison flows
- rich diagramming beyond the comparison-first priority

### Example Map — Ranked Alternatives
#### Story
The agent wants to show three or more directions with an explicit current best option and visible ordering.

#### Rules
- Ranked order must be visually legible.
- The current winner must be obvious without hiding lower-ranked options.
- Lower-ranked options must remain readable enough for honest trade-off review.

#### Examples
1. Given three candidate directions
   When the agent shows a ranked-alternatives screen
   Then the user can tell which option is currently strongest, which is second, and why the ordering exists.

2. Given the ranking is provisional
   When the screen is shown
   Then the screen communicates that the order is current guidance rather than a final locked decision.

#### Open Questions
- What is the minimum visual treatment needed for ranked order clarity?

#### Out of Scope / Deferred
- dynamic drag-to-rank interaction

### Example Map — Annotated Recommendation / Current Winner
#### Story
The agent wants to show one recommended direction with visible rationale while still keeping alternatives in view.

#### Rules
- The recommendation must be visually emphasized.
- The main trade-off must be visible near the recommendation.
- Alternatives must remain visible enough that the recommendation does not feel like a hidden default.

#### Examples
1. Given Option B is recommended over Option A
   When the screen is shown
   Then the user can identify Option B as the current winner and see the main reason it wins now.

2. Given the user disagrees with the recommendation
   When they inspect the screen
   Then the alternative remains visible enough to support that disagreement and continued discussion in the terminal.

#### Open Questions
- Should the recommendation reason have a standard placement across all fragment archetypes?

#### Out of Scope / Deferred
- automated scoring or ranking logic

### Example Map — Carry Forward a Chosen Direction
#### Story
The agent wants the next screen to clearly build on a previously selected direction.

#### Rules
- A carried-forward choice must be named explicitly on the next screen.
- The next screen must not require a session ledger to remain understandable.
- Changing the chosen direction later must remain possible.

#### Examples
1. Given the user selected Option B in one screen and confirms it in terminal
   When the next screen is shown
   Then the screen clearly states that it is building on Option B and shows what is being elaborated.

2. Given the user selected Option B but later prefers Option A
   When the next screen is authored
   Then the new carried-forward choice is explicit and the interaction does not depend on hidden state migration.

#### Open Questions
- Should the carry-forward marker be purely visual, or also backed by optional metadata?
- Should previous rejected options remain summarized on carry-forward screens?

#### Out of Scope / Deferred
- session-wide decision histories
- cross-session persistence

### Example Map — Terminal-Only / No-Click Path
#### Story
The agent wants to keep the companion useful even when the human never clicks in the browser.

#### Rules
- Terminal feedback alone must be enough to continue the flow.
- Carry-forward presentation must not depend on the existence of `state_dir/events`.
- The browser must still reflect the chosen or open state clearly on the next screen.

#### Examples
1. Given the human only replies in the terminal that Option A is better
   When the next screen is authored
   Then the carried-forward screen explicitly names Option A without depending on a recorded browser selection.

2. Given the human only replies in the terminal that no option is settled yet
   When the next screen is shown
   Then the browser screen communicates that the comparison remains open.

#### Open Questions
- Should terminal-only carry-forward screens use different copy from click-confirmed carry-forward screens?

#### Out of Scope / Deferred
- inferring confidence from browser inactivity

### Example Map — Runtime `/frontend-design` Invocation
#### Story
The agent wants to create a companion screen with explicit use of the design skill for structure quality rather than improvised HTML styling.

#### Rules
- Companion screen creation invokes `/frontend-design` or `$frontend-design`.
- The `frontend-design` context requirement must be satisfied through the bounded session workflow.
- The resulting screen still follows one of the four companion archetypes.
- In brainstorming, the goal is a well-structured comparison screen, not a near-final visual deliverable.

#### Examples
1. Given the agent is about to author a side-by-side comparison screen
   When it creates the screen
   Then it invokes `/frontend-design` or `$frontend-design` as the design step before writing the HTML.

2. Given no valid design context exists for `frontend-design`
   When the agent prepares to create the screen
   Then it first checks instructions and `.impeccable.md`, and if still missing gathers a one-time minimal design context for the session.

3. Given the user does not want to provide design context mid-session
   When the agent still needs to show a visual comparison
   Then it falls back to a plain archetype-based screen in explicit degraded mode rather than pretending `frontend-design` ran successfully.

#### Open Questions
- Should the repo provide a standard design-context source to make this step frictionless?

#### Out of Scope / Deferred
- changing `frontend-design`'s own context protocol

### Example Map — Full-Document Compatibility Rule
#### Story
The agent wants to author a full HTML document without breaking compatibility in the first release.

#### Rules
- Full-document screens remain valid in v1.
- Full-document screens do not receive comparison-kit defaults automatically.
- Full-document authors must provide comparison structure explicitly if they want comparison-first behavior.

#### Examples
1. Given a full-document screen is authored
   When the browser renders it
   Then the screen still works and helper injection still occurs, but fragment-only comparison defaults do not appear automatically.

2. Given the agent needs comparison-first behavior in a full-document screen
   When the screen is authored
   Then the comparison treatment must be included explicitly in that document rather than assumed from the frame.

#### Open Questions
- Do we need a follow-up path for optional full-document comparison helpers after v1?

#### Out of Scope / Deferred
- automatic parity between fragment defaults and full-document rendering

## Appendix D. Decisions / ADR Notes
- Decision: preserve the current HTML/runtime contract for the first release.
  - Why: it maximizes codebase fit and reversibility.
- Decision: prioritize comparison quality over deep state management.
  - Why: the biggest current gap is decision support, not storage or orchestration.

## Appendix E. GSD Handoff Seed
See [2026-03-27--visual-companion-comparison-first-upgrade--gsd-handoff.md](/Users/gamarsoft/.codex/superpowers/docs/superpowers/specs/2026-03-27--visual-companion-comparison-first-upgrade--gsd-handoff.md).
