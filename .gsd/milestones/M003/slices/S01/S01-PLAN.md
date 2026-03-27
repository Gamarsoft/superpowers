---
estimated_steps: 6
estimated_files: 2
---

# S01: Named pressure scenarios and RED proof surface

**Goal:** Add the named visual-companion protocol pressure-scenario artifact and an intentional RED authored-contract proof surface so the current docs can be shown failing on the motivating regression family before protocol wording changes.
**Demo:** A future agent can open `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md`, see the four named protocol pressures, run `node tests/brainstorm-server/visual-companion-contract.test.js`, and watch the current authored docs fail on first-turn startup, artifact-first sequencing, question-tool continuity, or degraded fallback gaps without touching runtime code.

## Description

This slice directly owns **R038** and supports **R039** and **R040**. The main risk is false confidence: the existing authored-contract test already passes, so later slices could rewrite docs without ever proving they fixed the real brownfield failure family. I’m grouping the work into two increments. First, make the blind authored-proof surface fail on the missing M003 protocol anchors. Second, add the named scenario artifact and rerun the same check so the failure survives as a deliberate RED target that later protocol and review work must satisfy.

## Must-Haves

- `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md` exists and names the four protocol pressures: missed first qualifying visual turn, artifact-before-prompt sequencing, question-tool continuity after earlier browser use, and explicit degraded fallback when the tool is unavailable.
- `tests/brainstorm-server/visual-companion-contract.test.js` grows M003-specific assertions that fail against the current authored docs before `skills/brainstorming/SKILL.md` or `skills/brainstorming/visual-companion.md` are edited.
- The RED rerun after the scenario artifact is added still points at missing protocol wording, giving S02 and S03 a stable named scenario target instead of a generic missing-file failure.
- The slice stays above runtime, helper, and frame-template scope.

## Proof Level

- This slice proves: contract
- Real runtime required: no
- Human/UAT required: no

## Verification

- `node tests/brainstorm-server/visual-companion-contract.test.js` — expected RED after S01: exits nonzero with an M003-specific assertion about the missing protocol family, not an unrelated runtime failure.
- Read back `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md` and confirm it names the four pressure scenarios plus the required outcome and failure signature for each.

## Observability / Diagnostics

- Runtime signals: none; this slice closes on authored artifacts and intentional RED contract-test output.
- Inspection surfaces: `tests/brainstorm-server/visual-companion-contract.test.js`, `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md`, and the existing `skills/brainstorming/SKILL.md` / `skills/brainstorming/visual-companion.md` sections the new assertions target.
- Failure visibility: the contract test should name whether the remaining gap is missing scenario coverage or missing protocol wording, so later slices can tell when they have moved from artifact absence to the real authored-contract failure.
- Redaction constraints: keep scenarios synthetic and protocol-focused; do not add secrets, user data, or runtime logs.

## Integration Closure

- Upstream surfaces consumed: `tests/brainstorm-server/visual-companion-contract.test.js`, `skills/brainstorming/references/test-scenarios.md`, `skills/brainstorming/SKILL.md`, `skills/brainstorming/visual-companion.md`, and the `writing-skills` + `test-driven-development` process expectations captured in M003 research.
- New wiring introduced in this slice: the existing authored-contract regression becomes aware of the M003 protocol family, and the new pressure-scenario artifact becomes the named vocabulary later protocol and review surfaces must reference.
- What remains before the milestone is truly usable end-to-end: S02 must turn the authored RED surface GREEN by hardening the protocol docs, S03 must wire the named scenario family into the review assets, and S04 must add narrow appendix guidance then re-run the unchanged runtime tie-breaker.

## Tasks

- [x] **T01: Extend the authored-contract regression with M003 RED anchors** `est:40m`
  - Why: R040 support starts with a failing proof surface; without it, S02 could “fix” wording on faith while the strongest authored check stays blind to the actual regression family.
  - Files: `tests/brainstorm-server/visual-companion-contract.test.js`
  - Do: Add section-scoped M003 assertions for the named pressure-scenario artifact and the four missing protocol outcomes — first qualifying visual turn starts the companion path, artifact becomes viewable before the terminal prompt, dedicated question-tool confirmation survives earlier browser use, and question-tool unavailability requires explicit degraded wording — while keeping the parser precise and above runtime scope.
  - Verify: `node tests/brainstorm-server/visual-companion-contract.test.js`
  - Done when: the contract test fails for an M003-specific missing-artifact or missing-protocol assertion rather than passing green or failing for an unrelated reason.

- [x] **T02: Create the named protocol pressure-scenario artifact and confirm the RED baseline** `est:45m`
  - Why: R038 requires a concrete non-regression artifact, and R039/R040 need a stable named scenario set the later review loop and doc hardening can reuse.
  - Files: `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md`
  - Do: Author a new reference file that extends the existing pressure-scenario idiom into four named visual-companion protocol pressures; for each scenario, capture the setup, required outcome, failure if, and why the current authored docs still miss the contract; then rerun the contract test without editing `SKILL.md` or `visual-companion.md` so the slice closes on an intentional RED baseline instead of a green assumption.
  - Verify: `node tests/brainstorm-server/visual-companion-contract.test.js`
  - Done when: the new scenario artifact exists with all four named cases, and the rerun still fails on missing protocol wording after the artifact exists, giving S02 a stable RED target.

## Files Likely Touched

- `tests/brainstorm-server/visual-companion-contract.test.js`
- `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md`
