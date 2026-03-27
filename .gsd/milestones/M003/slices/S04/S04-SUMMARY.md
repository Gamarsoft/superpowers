---
id: S04
parent: M003
milestone: M003
provides:
  - Selective low-fidelity wireframe appendix guidance in the shared spec path, plus integrated proof that M003 closed without handoff-template or runtime-surface drift
requires:
  - slice: S02
    provides: Finalized protocol wording and authored-contract anchors for the four required outcomes
  - slice: S03
    provides: Hardened review-loop surfaces that already guard the named protocol regression family
key_files:
  - skills/brainstorming/references/spec-template.md
  - .gsd/REQUIREMENTS.md
  - .gsd/milestones/M003/M003-ROADMAP.md
  - .gsd/STATE.md
key_decisions:
  - Keep durable wireframes as optional, low-fidelity markdown files in a sibling `{spec-slug}-wireframes/` folder and prove the rule through template readback plus unchanged authored/runtime closure commands instead of changing the handoff template or runtime.
patterns_established:
  - Narrow doc-layer extensions should close with a direct authored readback, an unchanged runtime tie-breaker, and an explicit protected-file diff so scope creep is inspectable.
observability_surfaces:
  - skills/brainstorming/references/spec-template.md
  - rg -n "wireframe|low-fidelity|handoff" skills/brainstorming/references/spec-template.md
  - node tests/brainstorm-server/visual-companion-contract.test.js
  - node tests/brainstorm-server/live-companion-acceptance.test.js
  - git diff --name-only -- skills/brainstorming/references/gsd-handoff-template.md skills/brainstorming/scripts/server.cjs skills/brainstorming/scripts/helper.js skills/brainstorming/scripts/frame-template.html
  - .gsd/REQUIREMENTS.md
  - .gsd/milestones/M003/M003-ROADMAP.md
  - .gsd/STATE.md
drill_down_paths:
  - .gsd/milestones/M003/slices/S04/tasks/T01-SUMMARY.md
  - .gsd/milestones/M003/slices/S04/tasks/T02-SUMMARY.md
duration: ~1h across T01-T02
verification_result: passed
completed_at: 2026-03-30 17:48 CEST
---

# S04: Selective wireframe appendix guidance and integrated closure

**Added a selective low-fidelity wireframe appendix pattern to the shared spec template, then closed R041 with direct template proof, green authored/runtime reruns, and a clean scope-boundary diff.**

## What Happened

S04 stayed intentionally narrow. T01 updated `skills/brainstorming/references/spec-template.md` so durable wireframes are optional, low-fidelity, decision-tied markdown files stored in a sibling `{spec-slug}-wireframes/` folder and linked from `Appendix D. Wireframes`. The same template now makes clear that authors should not create those files for every visual turn and that a later GSD handoff may link back to the existing appendix when it materially shapes implementation.

T02 then proved the change directly instead of assuming the prose was good enough. I reread the shared template, localized the key lines with `rg`, reran the existing authored-contract and unchanged-runtime acceptance commands, and checked the protected handoff-template/runtime boundary with a targeted `git diff --name-only` command. Only after all three proof surfaces stayed green did I move R041 from active to validated, mark S04 complete, and advance the project state out of active milestone execution.

## Verification

- Read back `skills/brainstorming/references/spec-template.md` and confirmed the four required R041 outcomes are explicit:
  - optional/selective use
  - durable spatial/layout triggers
  - low-fidelity, structure-first form
  - handoff-link allowance back to the existing appendix
- Ran `rg -n "wireframe|low-fidelity|handoff" skills/brainstorming/references/spec-template.md` and confirmed the guidance localizes cleanly to lines covering optionality, sibling-folder naming, low-fidelity constraints, appendix linking, and later handoff linkage.
- Ran `node tests/brainstorm-server/visual-companion-contract.test.js` → PASS.
- Ran `node tests/brainstorm-server/live-companion-acceptance.test.js` → PASS (6/6 checks).
- Ran `git diff --name-only -- skills/brainstorming/references/gsd-handoff-template.md skills/brainstorming/scripts/server.cjs skills/brainstorming/scripts/helper.js skills/brainstorming/scripts/frame-template.html` → no output, confirming no protected-file drift.
- Read back `.gsd/REQUIREMENTS.md`, `.gsd/milestones/M003/M003-ROADMAP.md`, and `.gsd/STATE.md` after edits to confirm they all record the same closure state.

## Requirements Advanced

- R041 — S04 added the missing shared-template rule for selective durable wireframe appendices and tied it to the existing handoff path without widening scope into template or runtime changes.

## Requirements Validated

- R041 — Validated by direct readback of `skills/brainstorming/references/spec-template.md`, the passing reruns of `node tests/brainstorm-server/visual-companion-contract.test.js` and `node tests/brainstorm-server/live-companion-acceptance.test.js`, and the clean protected-file diff against `skills/brainstorming/references/gsd-handoff-template.md`, `skills/brainstorming/scripts/server.cjs`, `skills/brainstorming/scripts/helper.js`, and `skills/brainstorming/scripts/frame-template.html`.

## New Requirements Surfaced

- none

## Requirements Invalidated or Re-scoped

- none

## Deviations

- none

## Known Limitations

- M003 intentionally stops at docs, review, and spec-template hardening. Deferred follow-up work remains deferred: runtime/helper enforcement hooks if the same live scenario still escapes the hardened workflow (R042), any new archetype or browser-native confirmation flow (R043), and broader wireframe template/catalog work beyond appendix linkage (R044).

## Follow-ups

- none

## Files Created/Modified

- `skills/brainstorming/references/spec-template.md` — added the selective low-fidelity wireframe appendix pattern and the later handoff link-back allowance.
- `.gsd/REQUIREMENTS.md` — moved R041 from active to validated and updated the coverage summary.
- `.gsd/milestones/M003/M003-ROADMAP.md` — marked S04 complete.
- `.gsd/PROJECT.md` — refreshed the living project description to post-M003 state.
- `.gsd/STATE.md` — moved the project out of active M003 execution and into post-milestone planning state.
- `.gsd/milestones/M003/slices/S04/S04-SUMMARY.md` — recorded the integrated proof and closure evidence for S04.

## Forward Intelligence

### What the next slice should know
- There is no next M003 slice. If future work reopens this area, start from the deferred backlog rather than re-editing the just-validated protocol docs.
- `skills/brainstorming/references/spec-template.md` is now the canonical place to inspect or refine the durable-wireframe rule. Do not spread that logic into the handoff template unless a later milestone explicitly chooses to do so.

### What's fragile
- The closure claim depends on the boundary staying narrow. Any later edit to `skills/brainstorming/references/gsd-handoff-template.md`, `skills/brainstorming/scripts/server.cjs`, `skills/brainstorming/scripts/helper.js`, or `skills/brainstorming/scripts/frame-template.html` should rerun the same protected-file diff and proof commands so doc-only and runtime work do not blur together.

### Authoritative diagnostics
- `skills/brainstorming/references/spec-template.md` plus `rg -n "wireframe|low-fidelity|handoff" skills/brainstorming/references/spec-template.md` — fastest way to inspect whether R041 wording is still present and localized.
- `node tests/brainstorm-server/visual-companion-contract.test.js` and `node tests/brainstorm-server/live-companion-acceptance.test.js` — fastest trustworthy authored/runtime tie-breakers for M003 closure drift.
- `git diff --name-only -- skills/brainstorming/references/gsd-handoff-template.md skills/brainstorming/scripts/server.cjs skills/brainstorming/scripts/helper.js skills/brainstorming/scripts/frame-template.html` — fastest scope-creep check when someone claims the slice stayed above runtime.

### What assumptions changed
- The working assumption was that a narrow spec-template edit might still leave R041 too implicit to close safely. In practice, the updated template wording plus the existing authored/runtime proof stack were sufficient, and no handoff-template or runtime changes were needed.
