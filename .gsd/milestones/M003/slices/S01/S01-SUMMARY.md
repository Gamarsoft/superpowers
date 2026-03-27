---
id: S01
parent: M003
milestone: M003
provides:
  - Named visual-companion protocol pressure scenarios and an authored-contract RED baseline for the M003 regression family
affects:
  - S02
  - S03
key_files:
  - skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md
  - tests/brainstorm-server/visual-companion-contract.test.js
  - .gsd/DECISIONS.md
observability_surfaces:
  - skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md
  - node tests/brainstorm-server/visual-companion-contract.test.js
key_decisions:
  - D030: Keep M003 authored-contract anchors section-scoped and require an exact pressure-scenario artifact schema
  - D031: Use index-based H2 section slicing so the contract harness can parse the final pressure-scenario section reliably
patterns_established:
  - Extend the markdown contract harness with narrow section and heading assertions instead of broad whole-document phrase matching
  - Model protocol pressure scenarios as exact H2 headings with shared H3 blocks for setup, required outcome, failure signature, and authored-gap rationale
drill_down_paths:
  - .gsd/milestones/M003/slices/S01/tasks/T01-SUMMARY.md
  - .gsd/milestones/M003/slices/S01/tasks/T02-SUMMARY.md
duration: 1h15m
verification_result: passed
completed_at: 2026-03-30 12:02:15 CEST
---

# S01: Named pressure scenarios and RED proof surface

**Shipped the named M003 pressure-scenario artifact and a deliberate authored-contract RED baseline that now fails on missing protocol wording instead of missing proof coverage.**

## What Happened

This slice closed the blind spot in the authored proof surface before any protocol wording was hardened. First, the existing `tests/brainstorm-server/visual-companion-contract.test.js` regression was extended with M003-specific anchors. Those checks stay narrow: they inspect the visual-companion section in `skills/brainstorming/SKILL.md`, the per-question protocol section in `skills/brainstorming/visual-companion.md`, and the exact heading schema of the new pressure-scenario artifact.

That made the suite fail for the right reason. The first RED run stopped on the missing `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md` file instead of passing green on an incomplete contract surface.

Next, the slice added `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md` and named the four M003 pressures: first-turn startup, artifact-first sequencing, question-tool continuity, and explicit degraded fallback. Each scenario uses the same structure — `Setup`, `Required outcome`, `Failure signature`, and `Why current docs miss this` — so later protocol and review work can reference the same vocabulary directly.

During the rerun, the harness exposed one parser edge case: the final H2 section in the new artifact was not being sliced reliably. The fix stayed inside the test harness and kept scope above runtime behavior. After that adjustment, the contract test advanced to the intended RED baseline in `skills/brainstorming/SKILL.md`, proving the slice now fails on real missing protocol wording rather than on missing files or parser noise.

## Verification

- Ran `node tests/brainstorm-server/visual-companion-contract.test.js`
  - Confirmed the suite is intentionally RED.
  - Confirmed the current failure is the expected authored-protocol gap:
    - `Expected SKILL.md first qualifying visual turn startup rule to include "the first later genuinely visual question must start the companion path instead of remaining terminal-only."`
- Read back `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md`
  - Confirmed all four named scenarios exist in order.
  - Confirmed each scenario includes `### Setup`, `### Required outcome`, `### Failure signature`, and `### Why current docs miss this`.
  - Confirmed each `Failure signature` block contains explicit `Failure if:` language.
- Confirmed the observability surfaces work:
  - the scenario artifact is a stable human-readable regression reference
  - the contract test now distinguishes missing artifact coverage from missing protocol wording

## Requirements Advanced

- R039 — Gave later review hardening a stable named pressure-scenario vocabulary to audit instead of relying on generic review prose.
- R040 — Established the required RED side of the writing-skills plus TDD loop by proving the authored protocol still fails before S02 edits the workflow docs.

## Requirements Validated

- R038 — The named pressure-scenario artifact now exists, and the authored-contract rerun proves it is wired into a real non-regression surface rather than sitting as unreferenced prose.

## New Requirements Surfaced

- none

## Requirements Invalidated or Re-scoped

- none

## Deviations

- Added the missing `## Observability Impact` section to `.gsd/milestones/M003/slices/S01/tasks/T02-PLAN.md` during execution so the task plan matched the local pre-flight contract.
- Replaced the contract test's brittle regex-based final-section extraction with index-based H2 slicing after the new artifact exposed an end-of-file parsing edge case.

## Known Limitations

- `node tests/brainstorm-server/visual-companion-contract.test.js` remains intentionally RED until S02 hardens `skills/brainstorming/SKILL.md` and `skills/brainstorming/visual-companion.md`.
- This slice does not change runtime, helper, frame-template, review-checklist, reviewer-prompt, or wireframe-appendix behavior.

## Follow-ups

- Update `skills/brainstorming/SKILL.md` and `skills/brainstorming/visual-companion.md` so the named M003 protocol family turns GREEN in S02.
- Reuse the four named pressure scenarios when hardening `skills/brainstorming/references/spec-review-checklist.md` and `skills/brainstorming/spec-document-reviewer-prompt.md` in S03.

## Files Created/Modified

- `tests/brainstorm-server/visual-companion-contract.test.js` — added section-scoped M003 contract anchors and fixed final-H2 parsing so RED failures localize to real authored gaps.
- `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md` — added the four named M003 protocol pressure scenarios with reusable setup, outcome, failure, and rationale blocks.
- `.gsd/DECISIONS.md` — recorded D030 and D031 for the section-scoped proof surface and parser-boundary choice.

## Forward Intelligence

### What the next slice should know
- The authoritative S02 starting point is the exact RED message from `node tests/brainstorm-server/visual-companion-contract.test.js`; do not treat the scenario artifact as closure on its own.
- The four scenario names and their required outcomes are now the shared vocabulary for protocol wording and later review assets.

### What's fragile
- `tests/brainstorm-server/visual-companion-contract.test.js` depends on exact section and heading structure — if S02 restructures headings casually, it may create parser drift instead of genuine protocol progress.

### Authoritative diagnostics
- `node tests/brainstorm-server/visual-companion-contract.test.js` — this is the fastest trustworthy signal for whether authored protocol wording is still missing.
- `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md` — this is the authoritative human-readable statement of the M003 regression family.

### What assumptions changed
- The original assumption was that adding the scenario artifact would immediately reveal only doc-wording gaps; in practice, the artifact also exposed a final-section parser edge case, so the harness had to be tightened before the true authored RED baseline was visible.
