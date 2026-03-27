# GSD Handoff

## 1. Project Brief
### Vision
Upgrade the brainstorming visual companion so it becomes a comparison-first design aid that helps users see differences, understand recommendations, and carry decisions forward without ambiguity.

### Primary user-visible outcome
Browser screens become much better at helping the human compare alternatives and understand the currently winning direction, while the terminal continues to carry the reasoning and conversation.

### Why now
The current companion runtime is functional, but the product value is still under-realized because strong comparison screens and lightweight decision carry-forward are not yet systematized.

## 2. Requirements Seed
### Active
- R1. Provide a comparison-first authoring kit for the visual companion, centered on clear side-by-side or ranked alternative screens.
- R2. Make recommendation, alternative visibility, and selected-state behavior visually legible by default.
- R3. Support lightweight carry-forward of a chosen direction into later screens without requiring a new workflow engine.
- R4. Preserve the current non-blocking terminal-first workflow and current HTML authoring/runtime contract.
- R5. Update guidance and patterns so authors can consistently produce stronger comparison screens.
- R6. Treat fragment screens as the v1 target for comparison-kit defaults; keep full-document screens compatibility-supported without automatic parity.
- R7. Require the runtime screen-authoring flow to invoke `/frontend-design` or `$frontend-design` when creating companion screens.
- R8. Define a bounded, one-time session workflow for satisfying `frontend-design`'s design-context requirement before the first invocation.

### Deferred
- D1. Session-wide decision ledger with explicit rationale history.
- D2. Branching or gated workflow orchestration.
- D3. Broader diagram-first pattern expansion beyond the comparison-first priority.

### Out of Scope
- O1. Deep server architecture rewrite.
- O2. Mandatory new authoring DSL or schema.
- O3. Replacing the terminal as the primary reasoning channel.

## 3. Milestone Recommendation
### First milestone
Deliver a small but coherent comparison-first kit with four archetypes only: side-by-side comparison, ranked alternatives, annotated recommendation/current winner, and carry-forward summary. Update guidance in `visual-companion.md`, add fragment-only comparison defaults in `frame-template.html`, keep `helper.js` limited to additive selected-state clarity, and define the one-time session workflow for using `/frontend-design` or `$frontend-design` during screen creation.

### Why first
This produces the highest user-visible value with the lowest delivery risk and stays above the existing runtime contract instead of reopening the server/session architecture.

### Success criteria
- Users can compare 2–3 options faster and with less ambiguity.
- Recommended direction is visually obvious on comparison screens.
- Ranked alternatives show a visible current winner and visible lower-ranked options.
- Selected direction can be carried forward visibly into the next screen.
- Terminal-only decisions can still produce a clear carry-forward screen.
- Existing authored screens continue to work.
- Full-document screens remain valid, but only fragment screens receive comparison-kit defaults automatically.

### Key risks / unknowns
- Patterns may help layout comparison more than diagram-heavy brainstorming.
- Helper/template changes may drift into implicit behavior if not kept explicit.
- The pattern set may be too thin or too broad on the first attempt.
- `frontend-design` requires confirmed design context, which may add friction unless the session workflow keeps that step minimal and one-time.

## 4. Context Seed
### Relevant codebase / prior art
- `skills/brainstorming/SKILL.md`
- `skills/brainstorming/visual-companion.md`
- `skills/brainstorming/scripts/server.cjs`
- `skills/brainstorming/scripts/helper.js`
- `skills/brainstorming/scripts/frame-template.html`
- `tests/brainstorm-server/server.test.js`

### Constraints
- Preserve the current browser-plus-terminal non-blocking model.
- Preserve current HTML authoring compatibility, including fragment/full-document support.
- Keep server/runtime changes limited and additive in the first milestone.
- Avoid smuggling unrelated lifecycle or transport refactors into the work.
- Do not add new required metadata beyond existing `data-choice` in milestone 1.
- Treat `/frontend-design` or `$frontend-design` as part of the runtime authoring workflow, not just as inspiration.
- Use `frontend-design` in brainstorming primarily for structure quality and deliberate composition, not as a promise of near-final mockups.

### Integration points
- skill guidance for when and how to use the companion
- `/frontend-design` or `$frontend-design` during runtime screen creation
- browser frame and helper behavior
- authored screen patterns in `screen_dir`
- existing choice event flow via `state_dir/events`

### Artifact matrix
- `visual-companion.md` -> owns the four archetypes, authoring rules, the explicit full-document compatibility rule, and the `/frontend-design` or `$frontend-design` runtime instruction -> verify via documentation review and scenario examples
- `frontend-design` skill + references -> own the runtime screen-structuring pass and quality bar -> verify via authored-screen review and scenario examples
- `frame-template.html` -> owns fragment-only comparison defaults -> verify via fragment rendering examples and tests
- `helper.js` -> owns additive selected-state clarity for `data-choice` interactions -> verify via interaction tests and comparison screen behavior
- authored HTML patterns -> own recommendation, ranking, and carry-forward content structure -> verify via scenario-based acceptance checks

### Open questions
- Whether optional metadata is needed for recommendation/carry-forward semantics
- How much pattern scaffolding should live in the frame template versus the authoring guide
- Whether diagram-oriented patterns belong in the same milestone

## 5. Roadmap Seed
### Slice candidates
1. Define and document the four archetypes plus the fragment-first/full-document compatibility rule in `visual-companion.md`, including the explicit `/frontend-design` or `$frontend-design` runtime step and the one-time session design-context workflow.
2. Add fragment-only defaults in `frame-template.html` for recommendation emphasis, ranked alternatives, and carry-forward summary presentation.
3. Keep `helper.js` additive and limited to selected-state clarity; validate terminal-only and click-assisted flows against the new patterns and the `frontend-design`-driven authoring flow.

### Risk order
Start with pattern and guidance definition first, then add the minimum helper/frame support needed, because that keeps the architecture stable and exposes any over-design early.

### Depends-on notes
- Archetype design should precede helper affordances so helper behavior serves explicit patterns rather than inventing them.
- Validation scenarios should reflect real brainstorming prompts, not just UI demos.
- Full-document compatibility rule should be fixed before implementation so fragment defaults are not mistaken for universal behavior.

### Boundary map hints
- Produces: clearer authored comparison screens, explicit carry-forward screens, updated guidance
- Consumes: current runtime contract, current helper interaction model, existing brainstorming workflow rules

## 6. Acceptance Seed
### Rules
- Companion screen creation invokes `/frontend-design` or `$frontend-design`.
- The first `frontend-design` invocation in a session satisfies the design-context gate through the bounded workflow: instructions, `.impeccable.md`, then one-time minimal context capture.
- Recommendation must be visually legible on comparison screens.
- Alternatives must remain visible enough for honest comparison.
- Ranked alternatives must show a visible current winner and readable lower-ranked options.
- The terminal remains the primary reasoning channel.
- A carried-forward decision must be explicit on later screens.
- Existing valid screens must continue to render.
- Full-document screens are compatibility-supported, not parity targets for fragment defaults in v1.

### Examples
1. Given two onboarding layouts
   When the agent shows a comparison screen
   Then the human can identify the recommended direction, the alternatives, and the main trade-off at a glance.

2. Given the human selects Option B and confirms it in terminal
   When the next screen is shown
   Then the new screen clearly states that it is building on Option B.

3. Given the human never clicks in the browser and only replies in terminal
   When the next screen is shown
   Then the screen still communicates the chosen or still-open direction clearly.

4. Given the agent authors a full HTML document
   When the browser renders it
   Then the document remains valid, helper injection still works, and fragment-only comparison defaults are not assumed.

5. Given the agent is creating a new companion screen
   When the design step runs
   Then `/frontend-design` or `$frontend-design` is invoked explicitly rather than relying on generic HTML generation.

6. Given the first `frontend-design` invocation in a session lacks design context
   When the agent prepares to create the screen
   Then it resolves that through the bounded one-time workflow or uses explicit degraded mode if the user declines.

### Validation ideas
- Scenario-based evaluation of comparison clarity on real brainstorm prompts
- Compatibility checks against existing fragment and full-document screens
- Focused tests for any helper/frame behavior added for selection or carry-forward treatment

### UAT notes
- Check whether a real brainstorm reaches a decision with fewer clarification loops.
- Check whether humans can describe the difference between options without additional terminal explanation.

## 7. Decisions Register Seed
### Chosen direction
Build a comparison-first companion kit above the existing runtime, with lightweight decision carry-forward and stronger visual authoring patterns.

### Alternatives rejected
- Visual polish pack only — rejected because it improves appearance more than decision support.
- Session decision system — rejected because it expands scope too early and increases delivery risk.

### Trade-offs accepted
- Defer richer session memory in favor of a smaller, more reversible first milestone.
- Bias toward comparison-heavy use cases before broader diagram-oriented ambitions.
- Accept fragment-first comparison defaults instead of promising automatic full-document parity in v1.
- Accept the extra runtime step and one-time design-context requirement that comes with explicitly invoking `/frontend-design` or `$frontend-design`.
