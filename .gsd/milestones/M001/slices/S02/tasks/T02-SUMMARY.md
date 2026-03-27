---
id: T02
parent: S02
milestone: M001
provides:
  - Shared comparison-first frame defaults that improve recommendation/current-winner scan while preserving lower-ranked readability
  - Regression coverage that names missing ranking, recommendation, and carry-forward selector proof surfaces in wrapped fragment HTML
key_files:
  - skills/brainstorming/scripts/frame-template.html
  - tests/brainstorm-server/fragment-comparison-defaults.test.js
  - .gsd/milestones/M001/slices/S02/S02-PLAN.md
  - .gsd/DECISIONS.md
  - .gsd/STATE.md
key_decisions:
  - D012: Lock comparison-default observability with selector-level wrapped-fragment assertions (plus non-selected opacity guard) in the regression test
patterns_established:
  - Shared-frame visual upgrades should be enforced with wrapped-fragment selector proof checks and explicit full-document non-contamination assertions
observability_surfaces:
  - node tests/brainstorm-server/fragment-comparison-defaults.test.js
  - node tests/brainstorm-server/visual-companion-contract.test.js
  - cd tests/brainstorm-server && node server.test.js && node ws-protocol.test.js
  - node -e "const fs=require('fs');const hook='data-comparison-kit=\"fragment-shell\"';const template=fs.readFileSync('skills/brainstorming/scripts/frame-template.html','utf8');if(!template.includes(hook)){throw new Error('Missing fragment-only shell hook '+hook);}console.log(JSON.stringify({check:'fragment-shell-hook',status:'present',hook}));"
duration: ~70m
verification_result: passed
completed_at: 2026-03-28T10:23:01Z
# Set blocker_discovered: true only if execution revealed the remaining slice plan
# is fundamentally invalid (wrong API, missing capability, architectural mismatch).
# Do NOT set true for ordinary bugs, minor deviations, or fixable issues.
blocker_discovered: false
---

# T02: Implement the shared comparison-kit defaults

**Shipped comparison-first shared-frame defaults plus regression proofs for ranking, recommendation, and carry-forward fragment surfaces.**

## What Happened

Implemented T02 in two focused changesets:

1. Upgraded shared frame tokens/CSS in `skills/brainstorming/scripts/frame-template.html` for the required surfaces:
   - `.subtitle`, `.label`, `.section`, `.mockup`
   - `.options`, `.cards`, `.option.selected`, `.card.selected`, `.letter`
   - `.options[data-multiselect]`

   The new defaults increase scanability for recommendation/current-winner states (clearer selected borders, emphasis background/shadow, stronger label/section framing), while preserving readability of non-selected options (no forced non-selected opacity dimming).

2. Extended `tests/brainstorm-server/fragment-comparison-defaults.test.js` from boundary-only coverage to slice-level proof coverage:
   - renders ranked, annotated-recommendation, and carry-forward fixtures through the real server path
   - asserts wrapped fragment shell marker persistence
   - asserts ranking/recommendation/carry-forward selector proofs are present in wrapped HTML with explicit missing-selector error names
   - adds a guard against over-dimming lower-ranked alternatives (`.option:not(.selected)` opacity rule)
   - preserves and re-validates full-document passthrough non-contamination

No helper or server behavior changes were introduced. Example files were not edited because existing S01 archetype structure already exposed all required hooks.

## Verification

Required task/slice verification chain:

- `node tests/brainstorm-server/fragment-comparison-defaults.test.js` → **PASS**
- `node tests/brainstorm-server/visual-companion-contract.test.js` → **PASS**
- `cd tests/brainstorm-server && node server.test.js && node ws-protocol.test.js` → **PASS** (`26 passed, 0 failed`; `31 passed, 0 failed`)
- `node -e "...fragment-shell-hook check..."` → **PASS** with structured output confirming marker presence

UI/browser verification (explicit assertions):

- Navigated to live local server (`http://localhost:3366`) with ranked fixture and asserted:
  - URL contains local host
  - ranked heading and current-winner copy visible
  - lower-ranked options still visible
  - no failed network requests
- Computed-style check via `browser_evaluate` confirmed:
  - selected option gets emphasized border/shadow
  - non-selected option opacity remains `1`
- Switched live fixture to carry-forward summary and asserted:
  - `Chosen direction`, `Still open`, and unresolved items are visible
  - no failed network requests
- Interaction + style check confirmed multi-select container/selection visuals:
  - dashed multiselect container styling
  - warning emphasis on selected still-open item

Observability impact verification:

- `rg -n "ranking defaults|recommendation defaults|carry-forward defaults|Lower-ranked options must remain readable" tests/brainstorm-server/fragment-comparison-defaults.test.js` confirms named proof surfaces and anti-dimming guard are present.

## Quality Check

**Diff reviewed:** `HEAD..WORKTREE` — 4 files, 223 insertions / 54 deletions
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

- Shared comparison-first style source: `skills/brainstorming/scripts/frame-template.html`
- Regression proof surface: `tests/brainstorm-server/fragment-comparison-defaults.test.js`
- Boundary/runtime guards: `tests/brainstorm-server/server.test.js`, `tests/brainstorm-server/ws-protocol.test.js`
- Fast shell-marker health check: `node -e` command in `S02-PLAN.md`

## Deviations

- none

## Known Issues

- none

## Files Created/Modified

- `skills/brainstorming/scripts/frame-template.html` — upgraded shared comparison-kit defaults (tokens + emphasis/readability styling) for fragment screens.
- `tests/brainstorm-server/fragment-comparison-defaults.test.js` — extended to ranking/recommendation/carry-forward selector proof coverage and anti-dimming guard.
- `.gsd/milestones/M001/slices/S02/S02-PLAN.md` — marked T02 complete.
- `.gsd/DECISIONS.md` — appended D012 for selector-proof observability contract.
- `.gsd/STATE.md` — updated current execution state after completing S02/T02.
- `.gsd/milestones/M001/slices/S02/tasks/T02-SUMMARY.md` — added this task completion summary.
