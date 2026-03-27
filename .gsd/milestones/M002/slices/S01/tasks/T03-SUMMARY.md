---
id: T03
parent: S01
milestone: M002
provides:
  - Stronger, subject-specific versions of the three active visual companion example fragments that satisfy the stricter S01 quality bar without changing the runtime contract
key_files:
  - skills/brainstorming/examples/visual-companion/side-by-side-comparison.html
  - skills/brainstorming/examples/visual-companion/ranked-alternatives.html
  - skills/brainstorming/examples/visual-companion/annotated-recommendation.html
key_decisions:
  - Preserve the existing `data-choice` identifiers and carry-forward labels while making the example content materially more concrete
patterns_established:
  - Refresh example fragments by increasing visible structure, recommendation legibility, and honest trade-offs without adding metadata or new archetypes
observability_surfaces:
  - node tests/brainstorm-server/visual-companion-contract.test.js
  - node tests/brainstorm-server/fragment-comparison-defaults.test.js
  - node tests/brainstorm-server/carry-forward-behavior.test.js
  - git diff --name-only -- skills/brainstorming/examples/visual-companion
  - local browser render via skills/brainstorming/scripts/server.cjs
duration: 1h
verification_result: passed
completed_at: 2026-03-29 23:19:05 +0200
# Set blocker_discovered: true only if execution revealed the remaining slice plan
# is fundamentally invalid (wrong API, missing capability, architectural mismatch).
# Do NOT set true for ordinary bugs, minor deviations, or fixable issues.
blocker_discovered: false
---

# T03: Refresh the three active example fragments against the new bar

**Shipped concrete, decision-capable replacements for the three active visual-companion example fragments while keeping the fragment-first `data-choice` contract and carry-forward boundary intact.**

## What Happened

I started with the unit’s required pre-flight fix and added `## Observability Impact` to `.gsd/milestones/M002/slices/S01/tasks/T03-PLAN.md` so this doc/example-only task has explicit inspection and failure surfaces.

I then rewrote the three in-scope example fragments in place:

- `side-by-side-comparison.html` now compares two materially different onboarding screen structures for a first Stripe connection, with concrete layout zones, visible strengths, and visible trade-offs instead of generic pros/cons shells.
- `ranked-alternatives.html` now ranks three release-note entry points against a specific judgment axis, keeps the current winner explicit, and makes the lower-ranked trade-offs visible and honest.
- `annotated-recommendation.html` now reads like a real follow-up artifact with an explicit chosen direction, concrete rationale, and known constraints while preserving the carry-forward wording that downstream tests already prove.

Throughout the refresh, I kept the fragments fragment-first and `data-choice`-based, preserved the existing choice IDs and helper interaction boundary, and left `carry-forward-summary.html` untouched as required.

I also recorded the downstream-useful pattern in `.gsd/DECISIONS.md`: strengthen example specificity without reopening the runtime contract or changing the stable example IDs / carry-forward labels that the current proof surfaces depend on.

## Verification

- `node tests/brainstorm-server/visual-companion-contract.test.js` → **PASS**
- `node tests/brainstorm-server/fragment-comparison-defaults.test.js` → **PASS**
- `node tests/brainstorm-server/carry-forward-behavior.test.js` → **PASS**
- `git diff --name-only -- skills/brainstorming/examples/visual-companion` → **PASS**; only these three files changed:
  - `skills/brainstorming/examples/visual-companion/side-by-side-comparison.html`
  - `skills/brainstorming/examples/visual-companion/ranked-alternatives.html`
  - `skills/brainstorming/examples/visual-companion/annotated-recommendation.html`
- Real browser render via `skills/brainstorming/scripts/server.cjs` on `http://localhost:4013` → **PASS**
  - Side-by-side screen showed `Compare two onboarding layouts for the first Stripe connection`, `Option A · Guided checklist rail`, and `Option B · Single-column steps`
  - Ranked screen showed `Rank three release-note entry points`, `Option A · Inline release banner`, and `Why it ranks first:`
  - Recommendation screen showed `Annotated recommendation: settings information architecture`, `Chosen direction: task-grouped settings`, and `Known constraints`

## Diagnostics

- Contract drift / boundary check: `node tests/brainstorm-server/visual-companion-contract.test.js`
- Wrapped-fragment rendering check: `node tests/brainstorm-server/fragment-comparison-defaults.test.js`
- Carry-forward continuity independence check: `node tests/brainstorm-server/carry-forward-behavior.test.js`
- In-scope file boundary check: `git diff --name-only -- skills/brainstorming/examples/visual-companion`
- Manual preview path used during this task: run `BRAINSTORM_DIR=<session-dir> node skills/brainstorming/scripts/server.cjs` with one of the refreshed fragments copied into `<session-dir>/content/active-screen.html`

## Quality Check

**Diff reviewed:** `f2b790d..WORKTREE` — 7 task-owned files reviewed (pre-flight plan fix, 3 example fragments, decisions register, slice plan toggle, state update)
**Checklists applied:** security, code-quality

### Issues Found

#### Critical
- none

#### Important
- none

#### Minor
- Local browser preview emitted one missing-resource console error (`404`) during manual verification, likely from an unfurnished auxiliary asset request rather than the refreshed fragment HTML itself.

**Verdict:** PASS WITH NOTES

## Deviations

None.

## Known Issues

- Local preview through the existing brainstorm server still emits one missing-resource console error (`404`) during browser inspection. This did not affect the rendered fragment content or the slice proof checks.

## Files Created/Modified

- `.gsd/milestones/M002/slices/S01/tasks/T03-PLAN.md` — added the missing `## Observability Impact` section required by the unit pre-flight gate.
- `skills/brainstorming/examples/visual-companion/side-by-side-comparison.html` — replaced the generic comparison shell with a concrete two-direction onboarding layout comparison.
- `skills/brainstorming/examples/visual-companion/ranked-alternatives.html` — replaced the generic ranking shell with a concrete, honest release-note entry-point ranking.
- `skills/brainstorming/examples/visual-companion/annotated-recommendation.html` — replaced the generic recommendation shell with a concrete carry-forward recommendation artifact.
- `.gsd/DECISIONS.md` — recorded the example-refresh pattern that preserves stable fragment IDs and carry-forward labels.
- `.gsd/milestones/M002/slices/S01/S01-PLAN.md` — marked T03 complete.
- `.gsd/STATE.md` — updated the active slice status and next action after completing S01.
- `.gsd/milestones/M002/slices/S01/tasks/T03-SUMMARY.md` — captured the task outcome, verification, diagnostics, and review notes.
