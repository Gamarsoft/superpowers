# GSD Handoff

## 1. Project Brief
### Vision
Make the brainstorming visual-companion workflow reliable in live use by hardening the protocol around startup, sequencing, and terminal confirmations, while preserving optional low-fidelity wireframe appendices for key spatial decisions.

### Primary user-visible outcome
When a brainstorm turn is genuinely visual, the companion opens at the right time, shows the artifact before the question is asked, and still keeps the decision prompt anchored in terminal.

### Why now
M002 improved routing and authoring quality, but the first real brownfield trial showed protocol drift that still forces manual correction and weakens trust in the workflow.

## 2. Requirements Seed
### Active
- R1. Update `skills/brainstorming/SKILL.md` so an accepted visual-companion session requires the first later genuinely visual question to start the companion path instead of remaining terminal-only.
- R2. Update `skills/brainstorming/SKILL.md` and `skills/brainstorming/visual-companion.md` so every qualifying visual turn is artifact-first: the visual artifact must be created and viewable before the terminal question is asked.
- R3. Preserve the dedicated terminal question-tool prompt for qualifying visual turns even after the companion has already been opened earlier in the session.
- R4. Add explicit degraded-mode wording for environments where the platform question tool is unavailable, instead of allowing silent drift to freeform-only handling.
- R5. Create `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md` with the concrete live-use regression family: baseline first-visual-turn startup failure, artifact-first sequencing, terminal confirmation continuity, and degraded fallback when the question tool is unavailable.
- R6. Update `skills/brainstorming/references/spec-review-checklist.md` and `skills/brainstorming/spec-document-reviewer-prompt.md` so review explicitly checks the named pressure scenarios and their expected protocol outcomes.
- R7. Use `skills/writing-skills/SKILL.md`, with its `skills/test-driven-development/SKILL.md` prerequisite, to drive the validation loop: baseline scenario run before edits, verified failure, post-edit rerun, and recorded evidence.
- R8. Add selective durable wireframe appendix guidance to `skills/brainstorming/references/spec-template.md`, and allow the GSD handoff to link to an existing appendix when relevant, while keeping handoff-template changes deferred.

### Deferred
- D1. Runtime or helper enforcement hooks if the hardened workflow still fails the same live scenario.
- D2. Any new archetype or browser-native confirmation flow.
- D3. Broader template/catalog work for wireframes, including any GSD handoff template change beyond simple linkage to an existing appendix.

### Out of Scope
- O1. Changes to `skills/brainstorming/scripts/server.cjs`, `helper.js`, or the frame template in this slice.
- O2. New required metadata beyond `data-choice`.
- O3. Making browser interaction the primary reasoning or confirmation channel.

## 3. Milestone Recommendation
### First milestone
Ship a documentation-and-review hardening slice that makes the per-visual-turn protocol explicit, pressure-tests the observed regression path, and adds selective wireframe appendix guidance to the written artifacts.

### Why first
This is the smallest reversible change that directly addresses the live-use failure without assuming the runtime is the root cause.

### Success criteria
- A reviewer can point to explicit wording that requires first-visual-turn startup after consent.
- A reviewer can point to explicit wording that forbids asking a qualifying visual question before the artifact is viewable.
- A reviewer can point to explicit wording that preserves terminal question-tool prompts on qualifying visual turns.
- `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md` exists and names the live-use regression family explicitly.
- The spec-review checklist and reviewer prompt both name the regression family directly.
- A reviewer can point to explicit degraded fallback wording for question-tool unavailability.
- The `writing-skills` validation loop records a baseline failure before edits and a successful rerun after edits.
- Durable wireframe appendices are allowed for relevant spatial decisions but are clearly optional and low-fidelity.
- The handoff can reference an existing appendix when needed without requiring a handoff-template change.
- No runtime/helper changes are needed to close the milestone.

### Key risks / unknowns
- The workflow text may still be interpreted too loosely without sharp enough pressure scenarios.
- The question-tool availability boundary may need clearer degraded wording than expected.
- Some live failures may still require runtime instrumentation after the docs-and-review slice lands.

## 4. Context Seed
### Relevant codebase / prior art
- `skills/brainstorming/SKILL.md`
- `skills/brainstorming/visual-companion.md`
- `skills/brainstorming/references/spec-template.md`
- `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md`
- `skills/brainstorming/references/spec-review-checklist.md`
- `skills/writing-skills/SKILL.md`
- `skills/test-driven-development/SKILL.md`
- `tests/brainstorm-server/visual-companion-contract.test.js`
- `tests/brainstorm-server/live-companion-acceptance.test.js`
- `docs/superpowers/specs/2026-03-29--visual-companion-routing-and-authoring-quality.md`
- `.gsd/milestones/M002/M002-SUMMARY.md`

### Constraints
- Keep the browser optional and per-question.
- Keep conceptual, scope, and text-first turns in terminal.
- Preserve the current runtime, metadata, and four-archetype contract.
- Treat durable wireframes as appendix artifacts, not as a new companion archetype.

### Integration points
- brainstorming workflow routing
- visual companion authoring flow
- spec-review loop
- design spec and handoff artifact structure

### Open questions
- Whether a later runtime slice should emit better diagnostics for skipped first-visual-turn startup.

## 5. Roadmap Seed
### Slice candidates
1. Create `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md` from the real-use-case failure family and record the baseline run before editing the skill.
2. Use `writing-skills` plus its `test-driven-development` prerequisite while tightening `SKILL.md` and `visual-companion.md`, then rerun the same scenarios after the edits.
3. Update `skills/brainstorming/references/spec-review-checklist.md` and `skills/brainstorming/spec-document-reviewer-prompt.md` so the named scenarios are enforced during review.
4. Add selective durable wireframe appendix guidance to `skills/brainstorming/references/spec-template.md` and handoff-linking guidance for cases where an appendix already exists.

### Risk order
Start with protocol wording, then the review pressure scenarios, then the appendix guidance. The appendix work should depend on the workflow contract rather than define it indirectly.

### Depends-on notes
- Review pressure scenarios should use the same real-use-case failure family that exposed the gap.
- The skill-edit implementation path should explicitly follow `writing-skills`, not an ad hoc docs-edit flow.
- The `writing-skills` loop should show evidence of red then green on the same named scenario family.
- Appendix guidance should stay scoped to durable spatial decisions, not general browser turns, and should avoid handoff-template changes in this slice.
- Runtime follow-up should depend on the hardened workflow still failing in practice.

### Boundary map hints
- Produces: explicit operator protocol, stronger workflow-review bar, optional durable wireframe artifacts for key spatial decisions
- Consumes: existing brainstorming skill flow, visual-companion guide, review workflow, and written artifact templates

## 6. Acceptance Seed
### Rules
- Acceptance of the visual companion does not switch the entire brainstorm into browser mode.
- The first later genuinely visual question after acceptance must start the companion path.
- Every qualifying visual turn must create and show the artifact before the terminal decision prompt is asked.
- Qualifying visual turns must preserve the dedicated terminal question-tool prompt when the tool is available.
- If the question tool is unavailable, the degraded fallback must be explicit rather than silent.
- Durable wireframe appendices are selective, low-fidelity, and tied to spatial decisions that need to persist into the design spec; the handoff may link to them when relevant.
- Runtime/helper behavior stays unchanged in this milestone.

### Examples
1. Given the user accepted the companion
   When the next decision is a master-detail layout comparison
   Then the agent starts the companion, shows the comparison, and only then asks the terminal decision prompt.

2. Given the companion is already open
   When the next qualifying visual turn compares hierarchy treatments
   Then the agent refreshes the artifact and still uses the dedicated terminal question tool for the decision.

3. Given a visual turn whose decision does not need durable spatial carry-forward
   When the spec is written
   Then no wireframe appendix is added.

4. Given the companion is open but the platform question tool is unavailable
   When the agent asks the visual decision in terminal text
   Then the agent explicitly names degraded fallback, confirms the artifact is already viewable, and preserves framed options or a framed confirmation prompt.

### Validation ideas
- Re-run the same brownfield UI/UX scenario that exposed the problem and verify the protocol now holds without manual nudges.
- Verify that the named pressure-scenario file captures the baseline regression family before any skill edits.
- Review the updated artifacts against explicit checklist and reviewer-prompt checks for startup, artifact-first behavior, terminal confirmation continuity, and degraded fallback wording.
- Verify that the skill-update work explicitly follows the `writing-skills` validation approach, including a recorded baseline failure and a recorded post-edit rerun.
- Confirm that the written spec can include a low-fidelity appendix for a major layout decision without implying a new archetype.

### UAT notes
- Check that the operator never has to remind the workflow to open the companion for the first qualifying visual turn.
- Check that the user always sees the visual artifact before being asked to judge it in terminal.
- Check that appendix wireframes feel useful for handoff without bloating simple visual turns.

## 7. Decisions Register Seed
### Chosen direction
Harden the workflow contract and review pressure first, explicitly using `writing-skills` to guide the skill update and validation path, then add selective durable wireframe appendices for spatial decisions while keeping runtime work deferred.

### Alternatives rejected
- Runtime enforcement now — rejected because the observed failure does not yet prove the runtime is the first leverage point.
- Prose-only fix — rejected because the workflow already drifted past prose and needs a reviewable non-regression bar.
- Mandatory wireframe appendices on every visual turn — rejected because it adds churn and blurs the distinction between ephemeral browser help and durable handoff artifacts.

### Trade-offs accepted
- Accept a narrower first slice so the change stays reversible.
- Accept that some future live failures may still justify a runtime follow-up.
- Accept extra review discipline now in exchange for lower workflow drift later.
