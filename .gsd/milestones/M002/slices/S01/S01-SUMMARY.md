---
id: S01
parent: M002
milestone: M002
provides:
  - Tightened authored routing so only genuinely visual questions use the browser while conceptual, scope, and text-first turns stay in terminal
  - A committed pre-display quality gate with an explicit placeholder-screen ban and revise-or-stay-terminal fallback
  - Refreshed side-by-side, ranked, and annotated recommendation example fragments that are concrete enough to support real visual decisions
affects:
  - S02
key_files:
  - tests/brainstorm-server/visual-companion-contract.test.js
  - skills/brainstorming/SKILL.md
  - skills/brainstorming/visual-companion.md
  - skills/brainstorming/examples/visual-companion/side-by-side-comparison.html
  - skills/brainstorming/examples/visual-companion/ranked-alternatives.html
  - skills/brainstorming/examples/visual-companion/annotated-recommendation.html
  - .gsd/REQUIREMENTS.md
  - .gsd/milestones/M002/M002-ROADMAP.md
  - .gsd/STATE.md
key_decisions:
  - Lock S01 proof to section-scoped contract assertions rather than broad phrase matching.
  - Mirror routing and terminal-fallback wording across `SKILL.md` and `visual-companion.md`.
  - Refresh only the three active example fragments while preserving stable `data-choice` IDs and carry-forward labels.
patterns_established:
  - Use named markdown sections plus ordered bold-numbered labels when extending authored-contract tests.
  - Raise example quality by increasing visible structure, specificity, and honest trade-offs without changing the runtime or metadata contract.
observability_surfaces:
  - node tests/brainstorm-server/visual-companion-contract.test.js
  - node tests/brainstorm-server/fragment-comparison-defaults.test.js
  - node tests/brainstorm-server/carry-forward-behavior.test.js
  - git diff --name-only -- skills/brainstorming/examples/visual-companion
  - skills/brainstorming/SKILL.md
  - skills/brainstorming/visual-companion.md
  - skills/brainstorming/examples/visual-companion/*.html
  - .gsd/REQUIREMENTS.md
  - .gsd/STATE.md
drill_down_paths:
  - .gsd/milestones/M002/slices/S01/tasks/T01-SUMMARY.md
  - .gsd/milestones/M002/slices/S01/tasks/T02-SUMMARY.md
  - .gsd/milestones/M002/slices/S01/tasks/T03-SUMMARY.md
duration: ~2h 5m
verification_result: passed
completed_at: 2026-03-29 23:23:40 +0200
---

# S01: Routing, quality gate, and active example refresh

**Tightened the authored browser-routing bar, committed a hard pre-display quality gate, and refreshed the three active example fragments without reopening the runtime contract.**

## What Happened

S01 closed entirely at the authored-contract layer.

First, T01 upgraded `tests/brainstorm-server/visual-companion-contract.test.js` so the new M002 bar is mechanically enforced instead of implied. The regression now checks for genuinely-visual routing language, explicit terminal fallback for conceptual/scope/text-first turns, a named pre-display quality gate with ordered checklist labels, a hard `No placeholder screens.` rule, revise-or-stay-terminal failure behavior, and an explicit `Active example refresh boundary (M002)` block that keeps `carry-forward-summary.html` out of scope.

Next, T02 updated the two guidance surfaces that authors actually follow. `skills/brainstorming/SKILL.md` now makes browser use an exception for questions that are materially easier to judge by seeing than by reading. `skills/brainstorming/visual-companion.md` now contains the committed quality gate, the placeholder-screen ban, the failure fallback, and the explicit active-example boundary, while preserving the existing four-archetype, fragment-first, `/frontend-design` / `$frontend-design`, degraded-mode, and `data-choice` runtime-boundary language.

Finally, T03 refreshed the three in-scope fragments so the example kit teaches stronger behavior by default. The side-by-side example now compares concrete onboarding layouts for a first Stripe connection, the ranked example now compares release-note entry points with honest trade-offs, and the annotated recommendation now carries forward a real settings information-architecture direction. Throughout the refresh, stable `data-choice` identifiers and carry-forward labels were preserved, and `carry-forward-summary.html` was left untouched.

During closeout, I also advanced the project bookkeeping: S01 is now marked complete in the M002 roadmap, `.gsd/REQUIREMENTS.md` now records R013-R018 as validated while leaving R019 active for S02, `.gsd/PROJECT.md` reflects the new M002 state, `.gsd/STATE.md` now points to S02, and the decisions register now includes the mirrored-wording rule for the routing/gate docs.

## Verification

- `node tests/brainstorm-server/visual-companion-contract.test.js` → **PASS**
- `node tests/brainstorm-server/fragment-comparison-defaults.test.js` → **PASS**
- `node tests/brainstorm-server/carry-forward-behavior.test.js` → **PASS**
- `git diff --name-only -- skills/brainstorming/examples/visual-companion` → **PASS** during T03 with only the three in-scope active example fragments changed
- Readback of `skills/brainstorming/SKILL.md` and `skills/brainstorming/visual-companion.md` → **PASS** for routing threshold, terminal fallback, quality gate, placeholder ban, and active-example boundary
- Readback of the three refreshed example fragments → **PASS** for concrete subject matter and decision-capable structure

## Requirements Advanced

- R019 — Kept the runtime/archetype boundary intact at the authored-file level and carried the remaining live-runtime corroboration obligation forward to S02.

## Requirements Validated

- R013 — Validated by mirrored genuinely-visual routing language in the two authored guidance surfaces plus contract regression coverage.
- R014 — Validated by the named `Pre-display quality gate` section with ordered checklist labels and passing contract proof.
- R015 — Validated by the explicit placeholder-screen ban and revise-or-stay-terminal fallback, both locked by contract regression.
- R016 — Validated by the explicit `Active example refresh boundary (M002)` block plus the in-scope example-only refresh.
- R017 — Validated by the concrete rewritten side-by-side, ranked, and annotated recommendation examples and the passing regression suite that still accepts them under the existing archetype contract.
- R018 — Validated by the guide’s conditional flow-style rule and the stronger example framing that requires visible structure/trade-offs instead of dressed-up prose.

## New Requirements Surfaced

- none

## Requirements Invalidated or Re-scoped

- R019 — Primary owning slice corrected to `M002/S02` in `.gsd/REQUIREMENTS.md` so the remaining live-runtime corroboration obligation matches the roadmap and proof strategy.

## Deviations

Added the missing `## Observability Impact` sections to the three S01 task plan files before implementation because the unit’s pre-flight gate required those observability gaps to be closed.

## Known Limitations

- R019 is still open; S02 must prove through the real companion entrypoint and lifecycle/acceptance stack that the authored refresh did not introduce runtime drift.
- Manual preview during T03 surfaced one auxiliary `404` in local browser inspection; it did not affect the rendered fragment content or any S01 proof surface, but it is worth re-checking if it appears again during S02 live verification.

## Follow-ups

- Run S02’s live acceptance stack (`start-server.sh`, `windows-lifecycle.test.sh`, server/WebSocket suites, and `live-companion-acceptance.test.js`) against the refreshed examples and unchanged carry-forward screen.
- If the preview-time `404` recurs under the real entrypoint, capture the failing asset path from the preserved runtime artifacts before deciding whether it is harmless noise or real boundary drift.

## Files Created/Modified

- `tests/brainstorm-server/visual-companion-contract.test.js` — extended the contract regression for routing, quality-gate, failure-path, and active-example-boundary proof.
- `skills/brainstorming/SKILL.md` — tightened the browser-routing threshold and made terminal fallback explicit.
- `skills/brainstorming/visual-companion.md` — added the named pre-display gate, placeholder-screen ban, revise-or-stay-terminal rule, and explicit M002 example boundary.
- `skills/brainstorming/examples/visual-companion/side-by-side-comparison.html` — replaced the generic comparison shell with a concrete Stripe-onboarding layout comparison.
- `skills/brainstorming/examples/visual-companion/ranked-alternatives.html` — replaced the generic ranking shell with a concrete release-note entry-point ranking.
- `skills/brainstorming/examples/visual-companion/annotated-recommendation.html` — replaced the generic recommendation shell with a concrete settings IA recommendation artifact.
- `.gsd/REQUIREMENTS.md` — moved R013-R018 to validated, left R019 active for S02, and updated traceability/coverage counts.
- `.gsd/DECISIONS.md` — recorded the mirrored routing/gate wording parity decision for authored proof surfaces.
- `.gsd/milestones/M002/M002-ROADMAP.md` — marked S01 complete.
- `.gsd/PROJECT.md` — refreshed current-state and next-step guidance for in-progress M002 work.
- `.gsd/STATE.md` — advanced the active slice to S02 and updated requirement counts.
- `.gsd/milestones/M002/slices/S01/S01-SUMMARY.md` — recorded the slice closeout narrative and evidence.
- `.gsd/milestones/M002/slices/S01/S01-UAT.md` — added a concrete artifact-driven UAT script for this slice.

## Forward Intelligence

### What the next slice should know
- S01 already proved the docs/examples bar; S02 should avoid reopening authored guidance unless a live-runtime failure directly contradicts the new contract.
- R019 is now the only active requirement, and it is specifically about real-entrypoint/runtime corroboration rather than more wording or example polish.

### What's fragile
- Local preview can emit an auxiliary `404` during manual inspection — treat it as a diagnostic lead, not proof of failure, and use preserved lifecycle/live-acceptance artifacts to distinguish harmless asset noise from true runtime drift.

### Authoritative diagnostics
- `tests/brainstorm-server/live-companion-acceptance.test.js` and `tests/brainstorm-server/windows-lifecycle.test.sh` — these are the most trustworthy next signals because they exercise the real entrypoint and preserve runtime artifacts on failure.
- `tests/brainstorm-server/visual-companion-contract.test.js` — use this first if an S02 failure suggests wording drift rather than runtime drift.

### What assumptions changed
- The initial requirements file still treated all M002 requirements as active under S01 — after S01 execution, R013-R018 were strong enough to validate now, while R019 clearly belongs to S02’s live-proof obligation.
