---
id: T01
parent: S02
milestone: M001
provides:
  - Stable wrapped-fragment shell marker (`data-comparison-kit="fragment-shell"`) in the shared frame
  - Dedicated regression coverage proving fragment-only marker presence and full-document passthrough non-contamination
key_files:
  - skills/brainstorming/scripts/frame-template.html
  - tests/brainstorm-server/fragment-comparison-defaults.test.js
  - tests/brainstorm-server/server.test.js
  - .gsd/milestones/M001/slices/S02/S02-PLAN.md
  - .gsd/DECISIONS.md
  - .gsd/STATE.md
key_decisions:
  - D011: Standardize the fragment shell marker as `data-comparison-kit="fragment-shell"` and assert it at the server boundary
patterns_established:
  - Boundary tests should assert both positive fragment wrapping signals and negative full-document contamination signals
observability_surfaces:
  - `node tests/brainstorm-server/fragment-comparison-defaults.test.js`
  - `cd tests/brainstorm-server && node server.test.js`
  - `node -e "const fs=require('fs');const hook='data-comparison-kit=\"fragment-shell\"';const template=fs.readFileSync('skills/brainstorming/scripts/frame-template.html','utf8');if(!template.includes(hook)){throw new Error('Missing fragment-only shell hook '+hook);}console.log(JSON.stringify({check:'fragment-shell-hook',status:'present',hook}));"`
duration: ~55m
verification_result: passed
completed_at: 2026-03-28T10:13:31Z
# Set blocker_discovered: true only if execution revealed the remaining slice plan
# is fundamentally invalid (wrong API, missing capability, architectural mismatch).
# Do NOT set true for ordinary bugs, minor deviations, or fixable issues.
blocker_discovered: false
---

# T01: Lock the fragment-only proof surface

**Added a deterministic fragment-shell marker in the shared wrapper plus regression tests that fail on fragment loss or full-document leakage.**

## What Happened

Applied the pre-flight gate first by adding an explicit diagnostic verification step to `.gsd/milestones/M001/slices/S02/S02-PLAN.md` that checks for the fragment-shell marker surface.

Then implemented T01 runtime/test changes:

1. Added the stable fragment-only hook to `skills/brainstorming/scripts/frame-template.html` as:
   - `data-comparison-kit="fragment-shell"` on `#claude-content`
2. Created `tests/brainstorm-server/fragment-comparison-defaults.test.js`:
   - boots the existing server path (`server.cjs`)
   - writes a representative S01 fragment fixture and asserts marker presence after wrapping
   - writes a full HTML document fixture and asserts marker absence + passthrough root preservation (`<!DOCTYPE html>`)
3. Tightened adjacent compatibility assertions in `tests/brainstorm-server/server.test.js`:
   - full-document response must **not** include fragment shell marker
   - fragment response **must** include fragment shell marker
   - frame-template structure check now enforces marker presence

Also appended D011 to `.gsd/DECISIONS.md`, marked T01 `[x]` in `S02-PLAN.md`, and advanced `.gsd/STATE.md` next action to T02.

## Verification

Task-level verification (required by T01 plan):

- `node tests/brainstorm-server/fragment-comparison-defaults.test.js` → **PASS**
- `cd tests/brainstorm-server && node server.test.js` → **PASS** (`26 passed, 0 failed`)

Slice-level verification chain (run during T01 execution):

- `node tests/brainstorm-server/visual-companion-contract.test.js` → **PASS**
- `node tests/brainstorm-server/fragment-comparison-defaults.test.js` → **PASS**
- `cd tests/brainstorm-server && node server.test.js && node ws-protocol.test.js` → **PASS** (`26 passed, 0 failed`; `31 passed, 0 failed`)
- `node -e "...fragment-shell-hook check..."` → **PASS** with structured output:
  - `{"check":"fragment-shell-hook","status":"present","hook":"data-comparison-kit=\"fragment-shell\""}`

Browser verification (explicit pass/fail checks):

- Started local server on `http://localhost:3366` with a representative fragment fixture, navigated via browser tools, then asserted:
  - `url_contains("localhost:3366")` → **PASS**
  - `text_visible("Rank three release-note entry points")` → **PASS**
  - `browser_evaluate` returned `{ hasFragmentShell: true, hasIndicatorBar: true }`
- Switched newest screen to a full HTML document fixture, reloaded, and asserted:
  - `text_visible("Browser Full Doc Fixture")` → **PASS**
  - `url_contains("localhost:3366")` → **PASS**
  - `browser_evaluate` returned `{ hasFragmentShell: false, hasIndicatorBar: false }`

Observability impact verification:

- `rg -n "data-comparison-kit=\"fragment-shell\"|fragment-only shell hook|leak fragment-only shell hook" skills/brainstorming/scripts/frame-template.html tests/brainstorm-server/server.test.js tests/brainstorm-server/fragment-comparison-defaults.test.js` → confirms marker + boundary assertions are present in all declared inspection surfaces.

## Quality Check

**Diff reviewed:** `HEAD..WORKTREE` — 7 files (including new regression test and state artifacts)
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

- Primary boundary regression: `tests/brainstorm-server/fragment-comparison-defaults.test.js`
- Adjacent runtime boundary coverage: `tests/brainstorm-server/server.test.js`
- Marker source of truth: `skills/brainstorming/scripts/frame-template.html`
- Fast marker health check: the `node -e` diagnostic command in `S02-PLAN.md` verification block
- Expected failure modes now surfaced explicitly:
  - missing wrapped-fragment marker
  - marker leakage into full-document passthrough
  - broken fragment wrapping path through `server.cjs`

## Deviations

- Added one explicit diagnostic verification command to `S02-PLAN.md` during pre-flight (required by the observability gap gate) before implementing runtime/test changes.

## Known Issues

- none

## Files Created/Modified

- `skills/brainstorming/scripts/frame-template.html` — added the stable fragment-only shell hook marker on the wrapped fragment container.
- `tests/brainstorm-server/fragment-comparison-defaults.test.js` — added dedicated fragment-vs-full-document boundary regression coverage through the existing server path.
- `tests/brainstorm-server/server.test.js` — tightened adjacent compatibility assertions for shell marker presence/absence and frame-template marker presence.
- `.gsd/milestones/M001/slices/S02/S02-PLAN.md` — added required diagnostic verification step and marked T01 complete.
- `.gsd/DECISIONS.md` — appended D011 documenting the marker contract decision.
- `.gsd/STATE.md` — updated next action to T02 and recorded recent decision.
