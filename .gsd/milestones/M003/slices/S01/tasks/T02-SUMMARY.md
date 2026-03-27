---
id: T02
parent: S01
milestone: M003
provides:
  - Named M003 visual-companion protocol pressure scenarios plus a stable RED wording target for S02/S03
key_files:
  - skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md
  - tests/brainstorm-server/visual-companion-contract.test.js
  - .gsd/milestones/M003/slices/S01/tasks/T02-PLAN.md
  - .gsd/DECISIONS.md
key_decisions:
  - D031: Use index-based H2 section slicing so the contract harness can parse the final pressure-scenario section reliably
patterns_established:
  - Model protocol pressure scenarios as exact H2 headings with shared H3 blocks for setup, required outcome, failure signature, and authored-gap rationale
observability_surfaces:
  - skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md
  - node tests/brainstorm-server/visual-companion-contract.test.js
duration: 40m
verification_result: passed
completed_at: 2026-03-30 11:53:13 CEST
# Set blocker_discovered: true only if execution revealed the remaining slice plan
# is fundamentally invalid (wrong API, missing capability, architectural mismatch).
# Do NOT set true for ordinary bugs, minor deviations, or fixable issues.
blocker_discovered: false
---

# T02: Create the named protocol pressure-scenario artifact and confirm the RED baseline

**Created the named M003 pressure-scenario artifact and advanced the contract test from missing-file RED to the intended missing-protocol-wording RED.**

## What Happened

I first fixed the pre-flight gap in `.gsd/milestones/M003/slices/S01/tasks/T02-PLAN.md` by adding the missing `## Observability Impact` section so the local execution contract explicitly described how this task should expose the RED state.

I then authored `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md` as a focused extension of the existing pressure-scenario idiom. The file names the four M003 protocol pressures in the exact contract-test order and gives each one a reusable setup, required outcome, failure signature, and explanation of the current authored gap.

On the first rerun, the contract test failed inside its own markdown-section parser instead of on the intended authored wording gap. I verified that the harness was mishandling the artifact's final `##` section, then made the smallest useful fix in `tests/brainstorm-server/visual-companion-contract.test.js`: replace the brittle regex-based section extractor with index-based H2 slicing. After that rerun, the suite stayed intentionally RED and localized to the expected authored-protocol gap in `skills/brainstorming/SKILL.md`:

- `Expected SKILL.md first qualifying visual turn startup rule to include "the first later genuinely visual question must start the companion path instead of remaining terminal-only."`

That closes S01 on the desired baseline: the scenario artifact exists, and the remaining failure is now real missing protocol wording rather than artifact absence or parser noise.

## Verification

- Read back `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md`
  - Confirmed all four named M003 scenarios exist in order.
  - Confirmed every scenario includes `### Setup`, `### Required outcome`, `### Failure signature`, and `### Why current docs miss this`.
  - Confirmed each section contains explicit `Failure if:` language.
- Ran `node tests/brainstorm-server/visual-companion-contract.test.js`
  - Observed intentional RED after artifact creation.
  - Confirmed the failure moved off the missing-file condition and now points at missing protocol wording in `skills/brainstorming/SKILL.md`.

## Diagnostics

- Primary inspection artifact: `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md`
- Primary proof surface: `node tests/brainstorm-server/visual-companion-contract.test.js`
- Current stable RED target:
  - `Expected SKILL.md first qualifying visual turn startup rule to include "the first later genuinely visual question must start the companion path instead of remaining terminal-only."`
- Downstream expectation: S02 should harden `skills/brainstorming/SKILL.md` and `skills/brainstorming/visual-companion.md` until this authored-contract rerun turns GREEN.

## Quality Check

**Diff reviewed:** working tree vs `HEAD` — 4 files changed (including 1 new file)
**Checklists applied:** security, code-quality

### Issues Found

#### Critical
- none

#### Important
- none

#### Minor
- none

**Verdict:** PASS

## Deviations

- Added the missing `## Observability Impact` section to `.gsd/milestones/M003/slices/S01/tasks/T02-PLAN.md` as required by the unit pre-flight checks.
- Fixed a contract-test markdown parsing edge case in `tests/brainstorm-server/visual-companion-contract.test.js` so the final pressure-scenario section can be parsed and the rerun can expose the intended authored wording failure.

## Known Issues

- `node tests/brainstorm-server/visual-companion-contract.test.js` remains intentionally RED until S02 adds the missing M003 protocol wording to `skills/brainstorming/SKILL.md` and likely related wording in `skills/brainstorming/visual-companion.md`.

## Files Created/Modified

- `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md` — added the four named M003 protocol pressure scenarios with reusable setup/outcome/failure/gap structure
- `tests/brainstorm-server/visual-companion-contract.test.js` — fixed H2 section parsing so the RED harness reaches real protocol-wording failures after the artifact exists
- `.gsd/milestones/M003/slices/S01/tasks/T02-PLAN.md` — added the missing observability-impact section required by pre-flight
- `.gsd/DECISIONS.md` — recorded D031 documenting the parser-boundary choice for the markdown contract harness
- `.gsd/milestones/M003/slices/S01/S01-PLAN.md` — marked T02 complete
- `.gsd/milestones/M003/slices/S01/tasks/T02-SUMMARY.md` — captured implementation, verification, and review notes for T02
