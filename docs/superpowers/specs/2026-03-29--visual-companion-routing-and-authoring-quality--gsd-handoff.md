# GSD Handoff

## 1. Project Brief
### Vision
Improve the brainstorming visual companion by making it harder to misuse and easier to trust: route it only to genuinely visual questions, block low-information screens, and strengthen the examples that agents use as starting points.

### Primary user-visible outcome
Browser turns become more reliable and higher-value because the companion appears in the right situations and the screens shown are concrete enough to support real visual decisions.

### Why now
The M001 milestone validated the runtime and comparison-first shell, but live trials exposed the next bottleneck: routing discipline and artifact quality now matter more than runtime behavior.

## 2. Requirements Seed
### Active
- R1. Update [SKILL.md](/Users/gamarsoft/.codex/superpowers/skills/brainstorming/SKILL.md) so it routes the companion only to genuinely visual questions and preserves terminal-first handling for conceptual or textual decisions.
- R2. Update [visual-companion.md](/Users/gamarsoft/.codex/superpowers/skills/brainstorming/visual-companion.md) with a committed pre-display checklist: genuinely visual question, concrete subject-specific visual content, visible differences that support the decision, and recommendation/comparison clarity.
- R3. Make `no placeholder screens` an explicit hard rule in the companion guidance.
- R4. Require checklist failure behavior: if any checklist item fails, the agent must revise the artifact or stay in terminal instead of showing the screen.
- R5. Strengthen examples within the current four archetypes for the strongest observed use cases: layout comparison, hierarchy critique, and flow-style comparison.
- R6. Make the example refresh boundary explicit per existing file: `side-by-side-comparison.html`, `ranked-alternatives.html`, and `annotated-recommendation.html` are active in milestone 1; `carry-forward-summary.html` remains untouched.
- R7. Keep the current runtime contract, metadata boundary, and archetype count unchanged in this slice.

### Deferred
- D1. Runtime guidance changes if rules and examples still prove insufficient.
- D2. New archetypes for wireflow or diagram-heavy cases.
- D3. Larger visual pattern catalog expansion.

### Out of Scope
- O1. Server, helper, or frame-template changes.
- O2. New required metadata beyond the current contract.
- O3. Replacing terminal-first reasoning with browser-first behavior.

## 3. Milestone Recommendation
### First milestone
Ship a documentation-and-examples slice that tightens companion routing, commits an explicit pre-display checklist with pass/fail behavior, forbids placeholder screens, and upgrades the active example artifacts inside the current archetypes.

### Why first
This is the smallest change that directly addresses the trial failures while preserving the proven runtime and avoiding premature surface expansion.

### Success criteria
- Agents are instructed to use the companion only for genuinely visual questions.
- The companion guide explicitly blocks placeholder or low-information screens.
- The committed checklist is explicit and tells the agent to revise or fall back to terminal when it fails.
- Strengthened examples make layout and hierarchy cases visibly more decision-capable.
- Flow-style examples are either improved enough to justify browser use or clearly bounded as conditional.
- No runtime or compatibility contract changes are needed for the first slice.

### Key risks / unknowns
- The routing language may still be interpreted too loosely if the checklist is not sharp enough.
- Flow-style cases may remain ambiguous even with stronger examples.
- Example upgrades could improve apparent quality without fully fixing judgment about when to stay in terminal.

## 4. Context Seed
### Relevant codebase / prior art
- [skills/brainstorming/SKILL.md](/Users/gamarsoft/.codex/superpowers/skills/brainstorming/SKILL.md)
- [skills/brainstorming/visual-companion.md](/Users/gamarsoft/.codex/superpowers/skills/brainstorming/visual-companion.md)
- [skills/brainstorming/examples/visual-companion](/Users/gamarsoft/.codex/superpowers/skills/brainstorming/examples/visual-companion)
- [docs/superpowers/specs/2026-03-27--visual-companion-comparison-first-upgrade--gsd-handoff.md](/Users/gamarsoft/.codex/superpowers/docs/superpowers/specs/2026-03-27--visual-companion-comparison-first-upgrade--gsd-handoff.md)
- [.gsd/milestones/M001/M001-SUMMARY.md](/Users/gamarsoft/.codex/superpowers/.gsd/milestones/M001/M001-SUMMARY.md)

### Constraints
- Preserve the existing four archetypes.
- Preserve the runtime contract and `data-choice` interaction boundary.
- Keep changes above the runtime for the first slice.
- Keep the companion optional and per-question.

### Integration points
- brainstorming routing rules
- visual companion guide
- example fragments used as starting points for authored screens
- exact example files:
  - `skills/brainstorming/examples/visual-companion/side-by-side-comparison.html` — active
  - `skills/brainstorming/examples/visual-companion/ranked-alternatives.html` — active
  - `skills/brainstorming/examples/visual-companion/annotated-recommendation.html` — active
  - `skills/brainstorming/examples/visual-companion/carry-forward-summary.html` — untouched in milestone 1

### Open questions
- Whether carry-forward examples should also be upgraded in the first slice.
- Whether any flow-style examples should later justify a dedicated archetype.

## 5. Roadmap Seed
### Slice candidates
1. Tighten routing rules in `SKILL.md` so companion use is restricted to genuinely visual questions.
2. Add the committed pre-display checklist plus the explicit `no placeholder screens` rule in `visual-companion.md`, including the rule that failed checks force revision or terminal fallback.
3. Upgrade the active example files inside the existing archetypes:
   - `side-by-side-comparison.html` for stronger two-option layout and flow-style comparisons
   - `ranked-alternatives.html` for stronger hierarchy/current-winner comparisons
   - `annotated-recommendation.html` for stronger follow-up recommendation artifacts

### Risk order
Start with rule text before examples so example changes are anchored to explicit guidance rather than becoming accidental policy.

### Depends-on notes
- Checklist language should be finalized before examples are treated as authoritative.
- Example upgrades should be validated against the same trial questions used in this brainstorming session.
- Runtime guidance follow-up should depend on whether the documentation-and-example pass materially improves behavior.

### Boundary map hints
- Produces: stronger routing behavior, stronger artifact-quality gate, better example starting points
- Consumes: current brainstorming workflow, current companion guide, current example kit

## 6. Acceptance Seed
### Rules
- The companion is used only for genuinely visual questions.
- Placeholder or low-information screens are not shown.
- A short pre-display checklist exists and is explicit.
- The checklist requires:
  - a genuinely visual question
  - concrete subject-specific visual content
  - visible differences that support the intended decision
  - clear recommendation or comparison legibility
- If any checklist item fails, the agent must revise the artifact or stay in terminal.
- The four current archetypes remain the only archetypes in this slice.
- Runtime/server behavior remains unchanged.

### Examples
1. Given a conceptual scope question
   When the agent decides how to continue
   Then it stays in terminal rather than opening the companion.

2. Given a valid layout comparison
   When the authored screen contains only labels and empty containers
   Then the screen fails the checklist and must be revised before display.

3. Given a hierarchy comparison with real tasks, metrics, and emphasis differences
   When the screen is shown
   Then the user can judge the recommendation visually rather than relying on prose alone.

4. Given a borderline flow question
   When the authored artifact is still only a dressed-up prose list rather than a clear wireflow
   Then the agent must revise it into a genuinely visual comparison or keep the interaction in terminal.

### Validation ideas
- Re-run the onboarding layout and dashboard hierarchy trial families against the updated guidance.
- Pressure-test a borderline flow case to confirm the guidance either improves the artifact or keeps the interaction in terminal.
- Reopen runtime-guidance work only if the updated rules and examples still fail the same trial families.

### UAT notes
- Check whether the companion feels more trustworthy after the rule changes.
- Check whether agents show fewer low-value browser turns.

## 7. Decisions Register Seed
### Chosen direction
Improve routing discipline and artifact-quality guidance first, while strengthening examples inside the current archetypes.

### Alternatives rejected
- New archetype now — rejected because the first need is discipline, not expansion.
- Runtime-first changes — rejected because the runtime is not the main bottleneck shown by the trials.

### Trade-offs accepted
- Accept a narrower first slice to keep the change reversible.
- Accept that flow-style cases may remain conditional even after example improvements.
- Accept runtime-guidance follow-up as a separate decision rather than bundling everything now.
