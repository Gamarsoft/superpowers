---
id: T02
parent: S03
milestone: M001
provides:
  - Made authored carry-forward screens the continuity authority with explicit chosen, still-open, and degraded-mode copy plus event-independence regression coverage.
key_files:
  - skills/brainstorming/visual-companion.md
  - skills/brainstorming/examples/visual-companion/annotated-recommendation.html
  - skills/brainstorming/examples/visual-companion/carry-forward-summary.html
  - tests/brainstorm-server/carry-forward-behavior.test.js
  - tests/brainstorm-server/visual-companion-contract.test.js
key_decisions:
  - Later-screen continuity must be expressed in visible authored copy (`Chosen direction`, `Still open`, and when applicable `Degraded mode`) rather than inferred from `state/events` or helper state.
  - The contract test now scopes workflow-order assertions to the actual first-use workflow section so additional degraded-mode guidance elsewhere in the guide does not create false failures.
patterns_established:
  - Click-assisted and terminal-only follow-up screens carry continuity through authored labels and explanatory copy, not runtime memory.
  - Degraded mode remains a visible authored status on carry-forward screens whenever richer design context was unavailable.
observability_surfaces:
  - skills/brainstorming/visual-companion.md
  - skills/brainstorming/examples/visual-companion/annotated-recommendation.html
  - skills/brainstorming/examples/visual-companion/carry-forward-summary.html
  - tests/brainstorm-server/carry-forward-behavior.test.js
  - live companion browser view plus /tmp/brainstorm-live-t02/state/events
duration: 1h 20m
verification_result: passed
completed_at: 2026-03-28T11:11:04Z
blocker_discovered: false
---

# T02: Author explicit carry-forward states for chosen, still-open, and degraded flows

**Made authored carry-forward screens explicitly communicate chosen, still-open, and degraded states, and proved they render the same with or without browser-event history.**

## What Happened

I tightened `skills/brainstorming/visual-companion.md` so carry-forward guidance now explicitly requires continuity to live in visible authored copy rather than helper state, hidden metadata, or persisted browser events. The guide now calls out the three author-facing status surfaces this slice needed: `Chosen direction`, `Still open`, and visible `Degraded mode` output.

I updated the carry-forward-oriented examples to model those states directly in the HTML fragments. `skills/brainstorming/examples/visual-companion/annotated-recommendation.html` now reads as a click-assisted follow-up with explicit `Chosen direction` and `Still open alternative` wording. `skills/brainstorming/examples/visual-companion/carry-forward-summary.html` now reads as a terminal-only follow-up with explicit `Degraded mode`, `Chosen direction`, and `Still open` copy.

I added `tests/brainstorm-server/carry-forward-behavior.test.js`, which spins up the real companion server against the authored example fragments, renders them with and without a seeded `state/events` file, and asserts the served output stays explicit and identical either way. I also extended `tests/brainstorm-server/visual-companion-contract.test.js` so the contract regression now locks the new carry-forward wording and example expectations while scoping the design-context ordering assertion to the actual workflow section.

I recorded the downstream pattern choice in `.gsd/DECISIONS.md`, marked T02 done in `.gsd/milestones/M001/slices/S03/S03-PLAN.md`, and updated `.gsd/STATE.md` to point the slice at T03.

## Verification

Task-owned checks passed:
- `node tests/brainstorm-server/carry-forward-behavior.test.js`
- `node tests/brainstorm-server/visual-companion-contract.test.js`

Slice verification run during T02:
- PASS — `node tests/brainstorm-server/helper-selection-clarity.test.js`
- PASS — `node tests/brainstorm-server/carry-forward-behavior.test.js`
- PASS — `node tests/brainstorm-server/visual-companion-contract.test.js`
- PASS — `cd tests/brainstorm-server && node server.test.js && node ws-protocol.test.js`
- PASS — `node -e "const fs=require('fs');const helper=fs.readFileSync('skills/brainstorming/scripts/helper.js','utf8');for(const banned of ['Chosen direction','Still open','state/events']){if(helper.includes(banned)){throw new Error('Helper drifted into workflow semantics: '+banned);}}console.log(JSON.stringify({check:'helper-workflow-boundary',status:'pass'}));"`

Live runtime verification passed:
- Started the real companion server at `http://localhost:34560` against `/tmp/brainstorm-live-t02`.
- Loaded a fresh click-assisted screen, clicked `[data-choice='activity-feed-card']`, and passed browser assertions for `.selected` state plus `Selected: Activity feed card — return to the terminal to continue`.
- Confirmed `/tmp/brainstorm-live-t02/state/events` existed immediately after that click.
- Pushed a fresh later screen filename with explicit `Degraded mode`, `Chosen direction`, and `Still open` copy and passed browser assertions for all three labels plus the hydrated indicator text `Selected: Chosen direction: drawer-based export flow — return to the terminal to continue` without making another click.
- Confirmed `/tmp/brainstorm-live-t02/state/events` was cleared after the new screen appeared.

## Diagnostics

Future inspection surfaces:
- `skills/brainstorming/visual-companion.md` — authoritative carry-forward authoring rule and degraded-mode wording.
- `skills/brainstorming/examples/visual-companion/annotated-recommendation.html` — click-assisted chosen-direction example.
- `skills/brainstorming/examples/visual-companion/carry-forward-summary.html` — terminal-only carry-forward example with degraded-mode honesty.
- `tests/brainstorm-server/carry-forward-behavior.test.js` — proof that rendered output is event-independent.
- Real runtime signals — helper indicator text and `/tmp/brainstorm-live-t02/state/events` presence/clearing behavior.

## Quality Check

**Diff reviewed:** `HEAD..WORKTREE` (base `6a94ece`) — 6 files, 103 insertions, 15 deletions
**Checklists applied:** security, code-quality, solid

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

- Browser diagnostics still show the existing favicon 404 noise during the live check, but the authored carry-forward assertions and state-file checks passed.

## Files Created/Modified

- `skills/brainstorming/visual-companion.md` — added explicit carry-forward authoring rules for `Chosen direction`, `Still open`, and visible `Degraded mode` output.
- `skills/brainstorming/examples/visual-companion/annotated-recommendation.html` — made the click-assisted follow-up example explicitly carry forward the chosen direction in visible copy.
- `skills/brainstorming/examples/visual-companion/carry-forward-summary.html` — made the terminal-only example explicitly communicate degraded mode, chosen direction, and still-open work.
- `tests/brainstorm-server/carry-forward-behavior.test.js` — added a real-server regression proving carry-forward copy is unchanged by seeded or absent `state/events`.
- `tests/brainstorm-server/visual-companion-contract.test.js` — locked the new guide/example wording and reduced a brittle whole-document ordering check to the workflow section.
- `.gsd/DECISIONS.md` — recorded the authored-copy carry-forward continuity decision.
- `.gsd/milestones/M001/slices/S03/S03-PLAN.md` — marked T02 complete.
- `.gsd/STATE.md` — advanced the slice state to T03.
