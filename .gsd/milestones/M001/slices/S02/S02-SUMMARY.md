---
id: S02
parent: M001
milestone: M001
provides:
  - Shared fragment-frame comparison defaults that make recommendation, current winner, alternatives, and carry-forward summaries easier to scan by default
  - Stable wrapped-fragment shell marker (`data-comparison-kit="fragment-shell"`) with boundary regression coverage proving no leakage into full-document passthrough
requires:
  - slice: S01
    provides: The four comparison-first archetypes, authored fragment examples, and the fragment/full-document compatibility contract
affects:
  - S03
  - S04
key_files:
  - skills/brainstorming/scripts/frame-template.html
  - tests/brainstorm-server/fragment-comparison-defaults.test.js
  - tests/brainstorm-server/server.test.js
  - .gsd/REQUIREMENTS.md
  - .gsd/STATE.md
key_decisions:
  - D011: Standardize the fragment shell marker as `data-comparison-kit="fragment-shell"` and assert it at the server boundary
  - D012: Lock comparison-default observability with selector-level wrapped-fragment assertions plus a non-selected opacity guard
patterns_established:
  - Fragment-vs-full-document compatibility should be enforced with both positive wrapped-fragment signals and negative full-document contamination checks
  - Shared-frame visual upgrades should prove their selectors in wrapped HTML instead of relying on helper logic or new metadata
observability_surfaces:
  - node tests/brainstorm-server/fragment-comparison-defaults.test.js
  - node tests/brainstorm-server/visual-companion-contract.test.js
  - cd tests/brainstorm-server && node server.test.js && node ws-protocol.test.js
  - node -e "const fs=require('fs');const hook='data-comparison-kit=\"fragment-shell\"';const template=fs.readFileSync('skills/brainstorming/scripts/frame-template.html','utf8');if(!template.includes(hook)){throw new Error('Missing fragment-only shell hook '+hook);}console.log(JSON.stringify({check:'fragment-shell-hook',status:'present',hook}));"
drill_down_paths:
  - .gsd/milestones/M001/slices/S02/tasks/T01-SUMMARY.md
  - .gsd/milestones/M001/slices/S02/tasks/T02-SUMMARY.md
duration: ~2h 5m
verification_result: passed
completed_at: 2026-03-28T10:28:00Z
---

# S02: Fragment comparison defaults

**Shipped fragment-only comparison defaults in the shared frame, with explicit boundary proofs that preserve full-document passthrough unchanged.**

## What Happened

S02 started by locking the fragment-only proof surface before touching styling. The shared fragment wrapper in `skills/brainstorming/scripts/frame-template.html` now exposes a deterministic marker, `data-comparison-kit="fragment-shell"`, on `#claude-content`. That gave the slice a simple, testable boundary signal without adding author metadata or workflow behavior.

With that hook in place, the slice added `tests/brainstorm-server/fragment-comparison-defaults.test.js` and tightened adjacent checks in `tests/brainstorm-server/server.test.js` so the real server path now proves two things together: wrapped fragments must expose the fragment-shell marker, and full HTML documents must not inherit it.

After the boundary was locked, the shared frame received the comparison-first defaults promised by the slice. `frame-template.html` now gives clearer emphasis to existing fragment structures such as `.subtitle`, `.label`, `.section`, `.mockup`, `.options`, `.cards`, `.option.selected`, `.card.selected`, `.letter`, and `.options[data-multiselect]`. The result is stronger recommendation/current-winner visibility, clearer ranked-order scan, and cleaner carry-forward presentation, while lower-ranked alternatives remain readable instead of being visually suppressed.

The slice deliberately stayed inside the existing runtime contract. There were no server workflow changes, no helper behavior changes, and no new required metadata beyond existing `data-choice`. The shipped S01 archetype examples already had enough structure, so the shared frame could improve them without changing the authored examples themselves.

## Verification

Ran the full slice verification chain and all checks passed:

- `node tests/brainstorm-server/visual-companion-contract.test.js` → PASS
- `node tests/brainstorm-server/fragment-comparison-defaults.test.js` → PASS
- `cd tests/brainstorm-server && node server.test.js && node ws-protocol.test.js` → PASS (`26 passed, 0 failed`; `31 passed, 0 failed`)
- `node -e "...fragment-shell-hook check..."` → PASS with `{"check":"fragment-shell-hook","status":"present","hook":"data-comparison-kit=\"fragment-shell\""}`

The regression suite now names the slice’s proof surfaces directly: missing fragment-shell wrapping, missing ranking/recommendation/carry-forward selectors, over-dimmed non-selected options, and full-document contamination all fail with explicit diagnostics.

## Requirements Advanced

- R006 — Advanced the fragment/full-document compatibility proof by asserting fragment-only hooks at the server boundary while preserving passthrough full documents unchanged.

## Requirements Validated

- R002 — Validated by the shared fragment comparison defaults in `skills/brainstorming/scripts/frame-template.html` and the wrapped-fragment proof checks in `tests/brainstorm-server/fragment-comparison-defaults.test.js`.
- R003 — Validated by the ranked/current-winner emphasis checks plus the non-selected opacity guard that keeps lower-ranked options readable.

## New Requirements Surfaced

- none

## Requirements Invalidated or Re-scoped

- none

## Deviations

- Added one fast diagnostic verification command to `S02-PLAN.md` during T01 pre-flight so the fragment-shell marker can be checked independently of the larger regression suite.

## Known Limitations

- S03 still needs to make chosen-versus-still-open state explicit for both click-assisted and terminal-only flows.
- S04 still needs to validate the assembled comparison-first behavior end-to-end against the real companion entrypoint and remaining compatibility scenarios.

## Follow-ups

- Use the fragment-shell marker and selector-level proof pattern again in S04 if compatibility drift needs fast diagnosis.
- In S03, attach selected-state clarity to the existing fragment surfaces instead of inventing new workflow metadata.

## Files Created/Modified

- `skills/brainstorming/scripts/frame-template.html` — added the fragment-shell marker and shipped the shared comparison-first fragment defaults.
- `tests/brainstorm-server/fragment-comparison-defaults.test.js` — added boundary coverage, ranking/recommendation/carry-forward selector proofs, and the anti-dimming guard.
- `tests/brainstorm-server/server.test.js` — tightened adjacent fragment/full-document compatibility assertions.
- `.gsd/REQUIREMENTS.md` — moved R002 and R003 from Active to Validated based on passing slice evidence.
- `.gsd/milestones/M001/M001-ROADMAP.md` — marked S02 complete.
- `.gsd/PROJECT.md` — refreshed project state to reflect shipped fragment comparison defaults and the remaining S03 gap.
- `.gsd/STATE.md` — advanced the active slice and requirement counts after S02 completion.

## Forward Intelligence

### What the next slice should know
- The S01 archetype examples already expose enough structure for the runtime to style recommendation/current-winner/carry-forward states without changing authoring metadata. S03 should build on those same hooks.

### What's fragile
- `skills/brainstorming/scripts/frame-template.html` — The slice’s guarantees live in shared-frame selectors, so even small token or selector refactors can silently weaken comparison emphasis unless `fragment-comparison-defaults.test.js` is kept in lockstep.

### Authoritative diagnostics
- `tests/brainstorm-server/fragment-comparison-defaults.test.js` — This is the fastest trustworthy signal for fragment-shell presence, selector proof surfaces, lower-ranked readability, and full-document non-contamination.

### What assumptions changed
- The plan allowed for possible minimal archetype example edits — in practice they were unnecessary because the existing S01 authored structures already exposed the needed comparison hooks.
