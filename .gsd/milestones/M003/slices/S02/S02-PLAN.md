---
estimated_steps: 6
estimated_files: 4
---

# S02: Protocol wording hardening and GREEN rerun

**Goal:** Harden the authored visual-companion protocol so accepted visual sessions explicitly start on the first later qualifying visual turn, keep every qualifying turn artifact-first, preserve terminal question-tool confirmation discipline after earlier browser use, and name the degraded fallback when the question tool is unavailable.
**Demo:** A future agent can open `skills/brainstorming/SKILL.md` and `skills/brainstorming/visual-companion.md`, see the same M003 protocol outcomes stated in the expected sections, run `node tests/brainstorm-server/visual-companion-contract.test.js`, and watch the authored-contract surface turn GREEN without touching runtime, helper, or frame-template code.

## Description

This slice directly owns **R034**, **R035**, **R036**, **R037**, and **R040**. It also produces the stable wording that S03 will later audit for **R039**. I’m grouping the work into two increments because the main risk is false closure from a partial doc pass. First, land the smallest wording changes that satisfy the section-scoped contract anchors without disturbing the existing heading structure. Second, rerun the intentional RED proof surface to GREEN and record that evidence, so the slice closes on a real red→green loop instead of a prose-only claim.

## Must-Haves

- `skills/brainstorming/SKILL.md` states in `## Visual companion` that, after consent, the first later genuinely visual question must start the companion path instead of remaining terminal-only.
- `skills/brainstorming/SKILL.md` keeps qualifying visual turns terminal-led by preserving the dedicated terminal question-tool prompt after earlier browser use and by naming explicit degraded behavior when the question tool is unavailable.
- `skills/brainstorming/visual-companion.md` states in `## Per-question decision rule` that each qualifying visual turn is artifact-first: author or refresh the artifact first, make it viewable, explain what the user is seeing and what decision it supports, then ask the terminal decision prompt with the platform question tool.
- `node tests/brainstorm-server/visual-companion-contract.test.js` reruns GREEN after the doc edits, proving the named S01 pressure-scenario family is now satisfied by the authored protocol.
- The slice stays above runtime, helper, frame-template, and review-asset scope.

## Proof Level

- This slice proves: contract
- Real runtime required: no
- Human/UAT required: no

## Verification

- `node tests/brainstorm-server/visual-companion-contract.test.js` — expected GREEN after S02.
- If the contract test fails before closing the slice, capture the first missing authored anchor from its fail-fast output and confirm it points to one of the inspectable protocol gaps: startup, artifact-first sequencing, question-tool continuity, or degraded fallback.
- Read back `skills/brainstorming/SKILL.md` (`## Visual companion`) and `skills/brainstorming/visual-companion.md` (`## Per-question decision rule`) and confirm they mirror the S01 pressure-scenario outcomes without renaming or moving the contract-test headings.

## Observability / Diagnostics

- Runtime signals: none; this slice closes on authored sections plus the contract-test result.
- Inspection surfaces: `skills/brainstorming/SKILL.md`, `skills/brainstorming/visual-companion.md`, `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md`, and `node tests/brainstorm-server/visual-companion-contract.test.js`.
- Failure visibility: the contract test should identify the first missing authored anchor if the wording is still incomplete, making it clear whether the remaining gap is startup, artifact-first sequencing, question-tool continuity, or degraded fallback.
- Redaction constraints: keep the wording protocol-focused; do not introduce user data, secrets, or runtime traces.

## Integration Closure

- Upstream surfaces consumed: `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md`, `skills/brainstorming/SKILL.md`, `skills/brainstorming/visual-companion.md`, and `tests/brainstorm-server/visual-companion-contract.test.js`.
- New wiring introduced in this slice: the authored protocol sections now mirror the named pressure-scenario family closely enough for the existing section-scoped contract test to close GREEN.
- What remains before the milestone is truly usable end-to-end: S03 must harden the review checklist and reviewer prompt against the same named scenario family, and S04 must add the narrow wireframe-appendix guidance then rerun the unchanged live-runtime tie-breaker.

## Tasks

- [x] **T01: Mirror the M003 protocol rules into the authored workflow docs** `est:50m`
  - Why: R034, R035, R036, and R037 all depend on precise wording in the existing contract-test target sections; if the rules stay implied or drift between the two docs, the authored GREEN rerun will be meaningless.
  - Files: `skills/brainstorming/SKILL.md`, `skills/brainstorming/visual-companion.md`, `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md`
  - Do: Read the current `## Visual companion` and `## Per-question decision rule` sections plus the S01 pressure-scenario artifact; add minimal wording inside those existing sections so the protocol explicitly covers first-turn startup after consent, artifact-first sequencing, terminal question-tool continuity after earlier browser use, and explicit degraded fallback when the question tool is unavailable; preserve the browser-optional and terminal-primary model, and do not rename or move the parser-sensitive headings.
  - Verify: Read back the edited `## Visual companion` and `## Per-question decision rule` sections and confirm each named S01 outcome appears in the right place with consistent terminology.
  - Done when: both workflow docs contain mirrored M003 protocol wording strong enough that the contract-test anchors are satisfiable without widening scope into review assets or runtime code.

- [x] **T02: Turn the authored-contract surface GREEN and record the slice evidence** `est:30m`
  - Why: R040 requires an honest red→green loop, not just doc edits; the slice must finish with a passing proof surface and a record of what was verified.
  - Files: `tests/brainstorm-server/visual-companion-contract.test.js`, `.gsd/milestones/M003/slices/S02/S02-SUMMARY.md`, `skills/brainstorming/SKILL.md`, `skills/brainstorming/visual-companion.md`
  - Do: Run `node tests/brainstorm-server/visual-companion-contract.test.js` after the doc edits, fix any remaining missing anchor revealed by the fail-fast output without reopening scope, rerun until the suite is GREEN, and capture the final verification evidence and requirement closure in `S02-SUMMARY.md` so later slices can rely on the exact authored proof that passed.
  - Verify: `node tests/brainstorm-server/visual-companion-contract.test.js`
  - Done when: the contract suite passes, `S02-SUMMARY.md` records the green rerun and the mirrored protocol outcomes it proved, and no runtime/helper/frame-template changes were needed.

## Files Likely Touched

- `skills/brainstorming/SKILL.md`
- `skills/brainstorming/visual-companion.md`
- `.gsd/milestones/M003/slices/S02/S02-SUMMARY.md`
- `tests/brainstorm-server/visual-companion-contract.test.js`
