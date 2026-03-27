---
estimated_steps: 4
estimated_files: 1
---

# T02: Create the named protocol pressure-scenario artifact and confirm the RED baseline

**Slice:** S01 — Named pressure scenarios and RED proof surface
**Milestone:** M003

## Description

Create the named visual-companion protocol pressure-scenario reference and rerun the authored-contract check so S01 closes on a deliberate RED baseline rather than a missing-artifact guess.

## Steps

1. Author `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md` as a focused extension of the existing pressure-scenario pattern, with one named scenario each for missed first-turn startup, artifact-before-prompt sequencing, question-tool continuity after earlier browser use, and explicit degraded fallback when the question tool is unavailable.
2. For each scenario, document the setup, required protocol outcome, failure-if condition, and the current authored gap the scenario is meant to expose.
3. Rerun `node tests/brainstorm-server/visual-companion-contract.test.js` without editing `skills/brainstorming/SKILL.md` or `skills/brainstorming/visual-companion.md`.
4. Confirm the rerun stays intentionally RED and that the failure now localizes to missing protocol wording rather than the scenario artifact being absent.

## Must-Haves

- [ ] `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md` exists and captures all four named M003 protocol pressures in reusable form.
- [ ] The post-artifact rerun still fails on the current authored docs, giving S02 and S03 a stable RED target tied to the named scenario family.

## Verification

- `node tests/brainstorm-server/visual-companion-contract.test.js`
- Read back `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md` and confirm each scenario includes setup, required outcome, and failure-if language.

## Observability Impact

- Signals added/changed: `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md` becomes the named inspection artifact for the four M003 protocol pressures, while `node tests/brainstorm-server/visual-companion-contract.test.js` should advance from missing-artifact failure to missing-protocol-wording failure.
- How a future agent inspects this: open the new scenario artifact to verify the four reusable setup/outcome/failure signatures, then rerun `node tests/brainstorm-server/visual-companion-contract.test.js` and read which authored-contract anchor still fails.
- Failure state exposed: once the artifact exists, any remaining RED result should localize to missing protocol wording in `skills/brainstorming/SKILL.md` or `skills/brainstorming/visual-companion.md` instead of the scenario file being absent.

## Inputs

- `.gsd/milestones/M003/slices/S01/tasks/T01-PLAN.md` — defines the RED-proof expectations the new artifact must satisfy
- `skills/brainstorming/references/test-scenarios.md` — supplies the existing pressure-scenario style this artifact should extend
- `.gsd/milestones/M003/M003-RESEARCH.md` — names the exact brownfield failure family and the requirement to close on RED before doc edits

## Expected Output

- `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md` — named M003 pressure-scenario artifact ready for later protocol and review hardening
