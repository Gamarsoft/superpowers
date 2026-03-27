---
id: S01
parent: M001
milestone: M001
provides:
  - Explicit comparison-first visual-companion authoring contract with four locked v1 archetypes and explicit `/frontend-design` / `$frontend-design` routing
  - Copyable fragment example kit plus regression coverage for workflow order, degraded-mode wording, and compatibility boundaries
affects:
  - M001/S02
  - M001/S03
  - M001/S04
key_files:
  - skills/brainstorming/visual-companion.md
  - skills/brainstorming/SKILL.md
  - skills/brainstorming/examples/visual-companion/side-by-side-comparison.html
  - skills/brainstorming/examples/visual-companion/ranked-alternatives.html
  - skills/brainstorming/examples/visual-companion/annotated-recommendation.html
  - skills/brainstorming/examples/visual-companion/carry-forward-summary.html
  - tests/brainstorm-server/visual-companion-contract.test.js
  - .gsd/REQUIREMENTS.md
  - .gsd/milestones/M001/M001-ROADMAP.md
key_decisions:
  - Keep the comparison-first kit to exactly four v1 archetypes and route screen structuring through `/frontend-design` or `$frontend-design`.
  - Keep fragment examples inside the existing frame contract and `data-choice` metadata boundary; full-document screens stay compatibility-supported only.
  - Make contract regression checks section-scoped and order-exact instead of relying on loose whole-document phrase matches.
patterns_established:
  - Ordered first-use context workflow: instruction context -> repo design-context source if present -> one-time minimal session capture -> explicit degraded mode
  - One fragment example per archetype, linked directly from the guide as the default copy/adapt starter kit
  - Contract regression checks that lock example presence, link order, workflow wording, and compatibility terms
observability_surfaces:
  - `node tests/brainstorm-server/visual-companion-contract.test.js`
  - `cd tests/brainstorm-server && node ws-protocol.test.js`
  - `cd tests/brainstorm-server && node server.test.js` (or the success-banner timeout wrapper if the old open-handle hang returns)
  - `rg -n "server-stopped|watch-fallback|owner-pid-invalid|state/events" skills/brainstorming/scripts/server.cjs tests/brainstorm-server/server.test.js`
drill_down_paths:
  - .gsd/milestones/M001/slices/S01/tasks/T01-SUMMARY.md
  - .gsd/milestones/M001/slices/S01/tasks/T02-SUMMARY.md
  - .gsd/milestones/M001/slices/S01/tasks/T03-SUMMARY.md
duration: resumed execution (~2h)
verification_result: passed
completed_at: 2026-03-27T17:03:49Z
---

# S01: Authoring contract and archetype kit

**Shipped the locked comparison-first authoring contract, the four-file archetype example kit, and regression coverage that keeps later slices inside the existing runtime boundary.**

## What Happened

S01 turned the visual companion from loose guidance into an explicit contract future agents can follow without improvising.

First, the slice rewrote `skills/brainstorming/visual-companion.md` and `skills/brainstorming/SKILL.md` around exactly four v1 archetypes: side-by-side comparison, ranked alternatives, annotated recommendation, and carry-forward summary. Those docs now require `/frontend-design` or `$frontend-design` as the screen-structuring step, define the bounded first-use workflow in order, call out explicit degraded mode, and keep the fragment-first versus full-document compatibility rule clear.

Second, the slice added one copyable fragment example per archetype under `skills/brainstorming/examples/visual-companion/`. The ranked and carry-forward examples use explicit status language such as `Current winner`, `Chosen direction`, and `Still open` so authors can copy clear decision states instead of inventing new wording or metadata.

Third, the slice hardened `tests/brainstorm-server/visual-companion-contract.test.js` so contract drift fails loudly. The test now locks the archetype list, the `/frontend-design` / `$frontend-design` routing rule, the ordered first-use workflow, degraded-mode wording, the `data-choice` and full-document boundary, example-file presence, and guide link order.

At closeout, the slice also updated `.gsd/REQUIREMENTS.md`, `.gsd/DECISIONS.md`, `.gsd/PROJECT.md`, `.gsd/STATE.md`, and the milestone roadmap so downstream work starts from the current, validated state instead of the pre-slice plan.

## Verification

Re-ran the slice verification chain and it passed:

- `node tests/brainstorm-server/visual-companion-contract.test.js` → PASS
- `cd tests/brainstorm-server && node ws-protocol.test.js` → PASS (`31 passed, 0 failed`)
- `cd tests/brainstorm-server && node server.test.js` → PASS by success banner (`26 passed, 0 failed`) using a hard timeout wrapper to guard against the previously observed open-handle hang
- `rg -n "server-stopped|watch-fallback|owner-pid-invalid|state/events" skills/brainstorming/scripts/server.cjs tests/brainstorm-server/server.test.js` → PASS

Earlier in T02, the slice also exercised the real companion runtime: each new fragment example was copied into the live `screen_dir`, rendered in the shared frame, and checked in the browser for its expected comparison markers.

Applied the code-review checklists at slice closeout in this order: security, code quality, SOLID. Verdict: PASS.

## Requirements Advanced

- R001 — Locked the v1 authoring contract to exactly four named archetypes and tied each one to a concrete fragment example.
- R007 — Made `/frontend-design` or `$frontend-design` the explicit screen-structuring step in the guidance and skill entrypoint.
- R008 — Documented and tested the bounded first-use workflow order for the first `frontend-design` call in a session.
- R009 — Made repo design-context reuse explicit before any one-time session capture.
- R012 — Added copyable examples and guide-level routing notes so authors can reuse proven archetypes instead of improvising.

## Requirements Validated

- R001 — Validated by the guide rewrite, the four authored fragment examples, and `tests/brainstorm-server/visual-companion-contract.test.js`.
- R007 — Validated by mirrored guidance in `skills/brainstorming/visual-companion.md` and `skills/brainstorming/SKILL.md`, with regression coverage on the explicit routing rule.
- R008 — Validated by ordered workflow assertions covering instruction context, repo reuse, one-time session capture, and degraded mode.
- R009 — Validated by explicit repo-context reuse wording and its regression checks.
- R012 — Validated by the guide cross-links, one-file-per-archetype example kit, and contract checks that lock example presence and order.

## New Requirements Surfaced

- none

## Requirements Invalidated or Re-scoped

- none

## Deviations

- Added the first contract regression test during T01 instead of waiting until T03, then expanded and tightened it in T03.
- T03 hardened an existing contract-test file instead of creating a brand-new one from scratch.
- Pre-flight gap checks required explicit observability sections in the task plans and an explicit failure-path verification step in the slice plan before closeout.

## Known Limitations

- S01 proves the authoring contract, not the shared-frame visual defaults. Recommendation legibility and ranked treatment still belong to S02.
- Chosen versus still-open carry-forward behavior in live click-assisted and terminal-only flows still belongs to S03.
- Full-document screens remain compatibility-supported only. They do not inherit fragment comparison defaults in v1.

## Follow-ups

- S02 should add fragment comparison defaults against the locked archetype surfaces and keep lower-ranked alternatives readable while showing a visible current winner.
- S03 should attach chosen-direction and still-open carry-forward semantics to those surfaces without adding new required metadata or hidden workflow logic.

## Files Created/Modified

- `skills/brainstorming/visual-companion.md` — rewritten around the four-archetype contract, ordered first-use workflow, degraded mode, and compatibility boundary.
- `skills/brainstorming/SKILL.md` — mirrors the same contract at the brainstorming entrypoint.
- `skills/brainstorming/examples/visual-companion/side-by-side-comparison.html` — copyable side-by-side comparison fragment.
- `skills/brainstorming/examples/visual-companion/ranked-alternatives.html` — ranked fragment with a visible current winner and readable lower-ranked options.
- `skills/brainstorming/examples/visual-companion/annotated-recommendation.html` — recommendation fragment with rationale and constraints.
- `skills/brainstorming/examples/visual-companion/carry-forward-summary.html` — carry-forward fragment showing both chosen and still-open states.
- `tests/brainstorm-server/visual-companion-contract.test.js` — locks the contract wording, ordering, example-kit presence, and compatibility terms.
- `.gsd/DECISIONS.md` — recorded D008 and D009 for the example-kit anchors and strict contract-test strategy.
- `.gsd/REQUIREMENTS.md` — moved the S01 contract requirements into `Validated`.
- `.gsd/milestones/M001/M001-ROADMAP.md` — marked S01 complete.
- `.gsd/PROJECT.md` — refreshed current-state language for the now-shipped authoring contract.
- `.gsd/STATE.md` — advanced the active slice and next action to S02.

## Forward Intelligence

### What the next slice should know
- `tests/brainstorm-server/visual-companion-contract.test.js` now locks archetype names, example order, workflow order, degraded-mode wording, and compatibility terms. If S02 changes the guide or example references, update the docs and test together.
- The archetype examples already use the shared-frame classes and `toggleSelect(this)` pattern, so S02 can work by strengthening fragment defaults instead of inventing new metadata.

### What's fragile
- The contract test is intentionally strict about ordered phrases and example-link targets. Casual wording changes will fail even if the high-level intent stays the same.
- `tests/brainstorm-server/server.test.js` has previously lingered after printing a success banner. If that returns, trust the banner and diagnose open handles separately.

### Authoritative diagnostics
- `tests/brainstorm-server/visual-companion-contract.test.js` — this is the precise drift alarm for the S01 contract.
- `skills/brainstorming/scripts/server.cjs` and `tests/brainstorm-server/server.test.js` — these remain the source of truth for `state/events`, `server-stopped`, `watch-fallback`, and `owner-pid-invalid` behavior.

### What assumptions changed
- Docs alone were not enough. The slice needed a copyable four-file example kit and exact-phrase regression checks to keep later slices honest.
