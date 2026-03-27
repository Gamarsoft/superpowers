---
id: T01
parent: S03
milestone: M001
provides:
  - Locked helper indicator rendering to container-scoped, DOM-derived selection semantics with focused regression coverage.
key_files:
  - skills/brainstorming/scripts/helper.js
  - skills/brainstorming/scripts/frame-template.html
  - tests/brainstorm-server/helper-selection-clarity.test.js
key_decisions:
  - Hydrate the helper indicator from authored `.selected` DOM only when exactly one selection container is active; otherwise keep neutral guidance.
patterns_established:
  - Helper-selected feedback remains additive and presentation-only: read current `.selected` DOM inside the active `.options`/`.cards` container, never workflow copy or `state/events`.
observability_surfaces:
  - helper indicator text in the shared frame, authored `.selected` markup, tests/brainstorm-server/helper-selection-clarity.test.js, and the live companion browser view
duration: 1h
verification_result: passed
completed_at: 2026-03-28T11:00:32Z
blocker_discovered: false
---

# T01: Lock additive helper selection semantics

**Shipped container-scoped helper indicator updates that clarify selected state without turning `helper.js` into workflow memory.**

## What Happened

I kept the change inside the existing helper/frame boundary. In `skills/brainstorming/scripts/helper.js` I replaced the inline indicator update block with small helper functions that:
- reuse the existing `.options` / `.cards` container boundary,
- render clearer indicator copy for default, single-select, and multiselect states,
- escape selected labels before writing indicator HTML, and
- hydrate the indicator from authored `.selected` DOM only when exactly one selection container is active.

In `skills/brainstorming/scripts/frame-template.html` I updated the default indicator copy and marked it as a live status region (`role="status"`, `aria-live="polite"`) so the shared frame remains an inspectable observability surface.

I added `tests/brainstorm-server/helper-selection-clarity.test.js`, a zero-dependency harness that executes the real helper in a fake DOM and proves:
- default guidance stays intact,
- a uniquely authored selected container hydrates correctly,
- single-select label rendering stays container-local,
- multiselect count rendering stays container-local, and
- the helper never drifts into `Chosen direction`, `Still open`, or `state/events` workflow semantics.

## Verification

Task-owned checks passed:
- `node tests/brainstorm-server/helper-selection-clarity.test.js`
- `node -e "const fs=require('fs');const helper=fs.readFileSync('skills/brainstorming/scripts/helper.js','utf8');for(const banned of ['Chosen direction','Still open','state/events']){if(helper.includes(banned)){throw new Error('Helper drifted into workflow semantics: '+banned);}}console.log(JSON.stringify({check:'helper-workflow-boundary',status:'pass'}));"`

Slice-level checks run during T01:
- PASS — `node tests/brainstorm-server/helper-selection-clarity.test.js`
- PASS — `node tests/brainstorm-server/visual-companion-contract.test.js`
- PASS — `cd tests/brainstorm-server && node server.test.js`
- PASS — `cd tests/brainstorm-server && node ws-protocol.test.js`
- PASS — helper workflow-boundary guard command above
- EXPECTED T02 GAP — `node tests/brainstorm-server/carry-forward-behavior.test.js` currently fails because the file does not exist yet

Live runtime verification:
- Started the real companion server against a fresh temp session.
- In the browser, clicked `activity-feed-card` and passed explicit assertions for:
  - `Selected: Activity feed card — return to the terminal to continue`
  - `.option.selected[data-choice='activity-feed-card']`
- Loaded a fresh later screen filename with explicit `Chosen direction` / `Still open` copy and passed explicit assertions for:
  - visible `Chosen direction`
  - visible `Still open`
  - visible `Selected: Drawer-based export flow — return to the terminal to continue`
  - `.option.selected[data-choice='drawer-based-export']`
- Confirmed `/tmp/brainstorm-live-t01/state/events` was removed after the new screen file appeared.

## Diagnostics

Later inspection surfaces:
- `skills/brainstorming/scripts/helper.js` — `DEFAULT_INDICATOR_TEXT`, `syncIndicator()`, and `syncIndicatorFromDocument()` define the locked semantics.
- `skills/brainstorming/scripts/frame-template.html` — `#indicator-text` is now the shared live-status surface.
- `tests/brainstorm-server/helper-selection-clarity.test.js` — focused regression coverage for default, single-select, multiselect, and workflow-boundary drift.
- Real runtime signal — the indicator text updates in the browser, while new-screen creation still clears `state/events`.

## Quality Check

**Diff reviewed:** `HEAD..WORKTREE` (base `733b11a`) — 4 files, 59 insertions, 15 deletions
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

- `tests/brainstorm-server/carry-forward-behavior.test.js` is still missing; that expected slice verification gap remains for T02.
- Browser diagnostics surfaced the usual favicon noise during the live check, but the helper interaction assertions and page state passed.

## Files Created/Modified

- `skills/brainstorming/scripts/helper.js` — centralized indicator rendering, added safer label escaping, and hydrated uniquely authored selected state without adding workflow memory.
- `skills/brainstorming/scripts/frame-template.html` — updated default indicator guidance and exposed it as a live status region.
- `tests/brainstorm-server/helper-selection-clarity.test.js` — added focused helper semantics and workflow-boundary regression coverage.
- `.gsd/DECISIONS.md` — recorded the helper indicator hydration scope decision.
- `.gsd/milestones/M001/slices/S03/S03-PLAN.md` — marked T01 complete.
