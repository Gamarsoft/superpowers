---
id: T01
parent: S01
milestone: M003
provides:
  - Authoritative M003 RED anchors in the visual-companion authored-contract regression
key_files:
  - tests/brainstorm-server/visual-companion-contract.test.js
  - .gsd/DECISIONS.md
key_decisions:
  - D030: Keep M003 authored-contract anchors section-scoped and require an exact pressure-scenario artifact schema
patterns_established:
  - Extend the existing markdown parser with narrow section/heading assertions instead of broad whole-document phrase matching
observability_surfaces:
  - node tests/brainstorm-server/visual-companion-contract.test.js
duration: 35m
verification_result: passed
completed_at: 2026-03-30 11:48:01 CEST
# Set blocker_discovered: true only if execution revealed the remaining slice plan
# is fundamentally invalid (wrong API, missing capability, architectural mismatch).
# Do NOT set true for ordinary bugs, minor deviations, or fixable issues.
blocker_discovered: false
---

# T01: Extend the authored-contract regression with M003 RED anchors

**Added section-scoped M003 RED anchors to the authored-contract regression so the current docs now fail on a named missing protocol surface instead of staying falsely green.**

## What Happened

I loaded the TDD and code-review skills first, read the existing contract test plus the M003 research/spec artifacts, and reused the current parser style rather than inventing a new proof harness. I extended `tests/brainstorm-server/visual-companion-contract.test.js` with three new kinds of checks: an exact contract for the new `visual-companion-protocol-pressure-scenarios.md` artifact, a startup anchor in `skills/brainstorming/SKILL.md` for the first qualifying visual turn, and protocol anchors for artifact-first sequencing plus question-tool continuity/degraded fallback in the existing guide/workflow sections.

The new assertions stay section-scoped: `SKILL.md` is parsed only inside the visual-companion section, `visual-companion.md` is parsed only inside the per-question protocol section, and the future scenario artifact is constrained to exact `##` scenario headings plus required `###` subsections. I then ran the contract test and confirmed the suite now fails for an M003-specific reason: the named pressure-scenario artifact is missing.

## Verification

- Ran `node tests/brainstorm-server/visual-companion-contract.test.js`
- Observed expected RED result:
  - `FAIL: visual companion contract + archetype kit assertions failed`
  - `Expected M003 pressure-scenario artifact to exist: /Users/gamarsoft/.codex/superpowers/skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md`
- Confirmed the failure is M003-specific and not a parser/runtime error.

## Diagnostics

- Primary inspection surface: `tests/brainstorm-server/visual-companion-contract.test.js`
- Re-run command: `node tests/brainstorm-server/visual-companion-contract.test.js`
- Current named failure surface: missing `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md`
- After T02 adds that file, the same test should advance to named protocol-wording failures in `skills/brainstorming/SKILL.md` or `skills/brainstorming/visual-companion.md`.

## Quality Check

**Diff reviewed:** working tree vs `HEAD` — 1 file, 112 insertions
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

None.

## Known Issues

- `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md` does not exist yet, so the RED failure currently stops at missing artifact coverage by design.
- The new M003 protocol wording anchors in `skills/brainstorming/SKILL.md` and `skills/brainstorming/visual-companion.md` are still unsatisfied by design; later tasks in the slice will turn those green.

## Files Created/Modified

- `tests/brainstorm-server/visual-companion-contract.test.js` — added section-scoped M003 RED assertions for the pressure-scenario artifact and the four protocol outcomes
- `.gsd/DECISIONS.md` — recorded D030 documenting the section-scoped M003 contract-anchor pattern
- `.gsd/milestones/M003/slices/S01/tasks/T01-SUMMARY.md` — captured implementation, verification, and review notes for T01
