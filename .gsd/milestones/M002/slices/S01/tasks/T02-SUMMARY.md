---
id: T02
parent: S01
milestone: M002
provides:
  - Tightened authored routing so only genuinely visual questions route into the companion and conceptual, scope, and text-first turns stay in terminal
  - Added an explicit pre-display quality gate, placeholder-screen ban, revise-or-stay-terminal fallback, and M002 active-example refresh boundary to the visual companion guide
key_files:
  - skills/brainstorming/SKILL.md
  - skills/brainstorming/visual-companion.md
  - .gsd/milestones/M002/slices/S01/tasks/T02-PLAN.md
  - .gsd/milestones/M002/slices/S01/S01-PLAN.md
  - .gsd/STATE.md
key_decisions:
  - Mirror the exact routing threshold and terminal-fallback phrasing across `SKILL.md` and `visual-companion.md`, and encode the guide’s quality gate as ordered bold-numbered labels so the contract test remains the authoritative proof surface without changing runtime behavior.
patterns_established:
  - When authored-contract tests parse multiple docs, keep the operative routing and fallback language mirrored across both surfaces and anchor checklist-style rules in named markdown sections with ordered bold labels.
observability_surfaces:
  - node tests/brainstorm-server/visual-companion-contract.test.js
  - git diff --name-only -- skills/brainstorming/examples/visual-companion
  - skills/brainstorming/SKILL.md
  - skills/brainstorming/visual-companion.md
duration: ~20m
verification_result: passed
completed_at: 2026-03-29 23:13:53 CEST
# Set blocker_discovered: true only if execution revealed the remaining slice plan
# is fundamentally invalid (wrong API, missing capability, architectural mismatch).
# Do NOT set true for ordinary bugs, minor deviations, or fixable issues.
blocker_discovered: false
---

# T02: Tighten routing and pre-display guidance in the skill docs

**Tightened the brainstorming docs so only genuinely visual questions route to the browser, weak screens are blocked before display, and the M002 example-refresh boundary is explicit.**

## What Happened

I started with the unit’s required pre-flight fix and added `## Observability Impact` to `T02-PLAN.md` so the inspection surfaces and failure states for this doc-only task are explicit.

Then I updated `skills/brainstorming/SKILL.md` to make the routing bar stricter without changing scope: the companion now routes only when a question is materially easier to judge by seeing than by reading, and conceptual, scope, and text-first turns are explicitly told to stay in terminal.

In `skills/brainstorming/visual-companion.md`, I added the named `Pre-display quality gate` section with the four ordered checklist items expected by the new contract test, plus the hard `No placeholder screens.` rule and the explicit `revise the artifact or stay in terminal` failure behavior. I also added `### Active example refresh boundary (M002)` so only the three active example fragments are in scope for refresh and `carry-forward-summary.html` stays out unless a direct contradiction is found.

I preserved the existing runtime boundary language: four archetypes only, `/frontend-design` and `$frontend-design` as the structuring route, the first-use degraded-mode workflow, fragment-first with `full-document` compatibility support, and the bounded `data-choice` interaction contract.

## Verification

- `node tests/brainstorm-server/visual-companion-contract.test.js` → **PASS**
- Read back the updated `## Visual companion` section in `skills/brainstorming/SKILL.md` → **PASS** (genuinely visual routing threshold and explicit terminal fallback present)
- Read back the updated sections in `skills/brainstorming/visual-companion.md` → **PASS** (`Pre-display quality gate`, placeholder-screen ban, revise-or-stay-terminal rule, and `Active example refresh boundary (M002)` block present)
- `git diff --name-only -- skills/brainstorming/examples/visual-companion` → **PASS** (no output; T02 did not drift into example-file edits)

## Quality Check

**Diff reviewed:** `4d1d1c7..WORKTREE` — 3 implementation files, 32 insertions(+), 3 deletions(-)
**Checklists applied:** security, code-quality, solid

### Issues Found

#### Critical
- none

#### Important
- none

#### Minor
- none

**Verdict:** PASS

## Diagnostics

- Primary proof surface: `node tests/brainstorm-server/visual-companion-contract.test.js`
- Boundary drift check: `git diff --name-only -- skills/brainstorming/examples/visual-companion`
- Human inspection surfaces: `skills/brainstorming/SKILL.md` (`## Visual companion`) and `skills/brainstorming/visual-companion.md` (`## Per-question decision rule`, `## Pre-display quality gate`, and `### Active example refresh boundary (M002)`)
- Failure visibility: the contract test names the missing routing phrase, checklist label, or boundary block directly in stderr/stdout

## Deviations

- Added the missing `## Observability Impact` section to `.gsd/milestones/M002/slices/S01/tasks/T02-PLAN.md` before implementation because the unit’s pre-flight gate required that observability gap to be fixed first.

## Known Issues

- none

## Files Created/Modified

- `skills/brainstorming/SKILL.md` — tightened the visual-companion routing threshold and made terminal fallback explicit for conceptual, scope, and text-first turns.
- `skills/brainstorming/visual-companion.md` — added the pre-display quality gate, placeholder-screen ban, revise-or-stay-terminal rule, and explicit M002 active-example refresh boundary.
- `.gsd/milestones/M002/slices/S01/tasks/T02-PLAN.md` — added the missing `## Observability Impact` section required by the unit pre-flight gate.
- `.gsd/milestones/M002/slices/S01/S01-PLAN.md` — marked T02 complete.
- `.gsd/STATE.md` — advanced the next action to T03.
- `.gsd/milestones/M002/slices/S01/tasks/T02-SUMMARY.md` — recorded the shipped changes, verification, diagnostics, and closeout state.
