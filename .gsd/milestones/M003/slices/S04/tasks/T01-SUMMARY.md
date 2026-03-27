---
id: T01
parent: S04
milestone: M003
provides:
  - Shared spec-template guidance for selective low-fidelity wireframe files stored in a dedicated folder, linked from the spec, and reusable from later handoffs
key_files:
  - skills/brainstorming/references/spec-template.md
  - .gsd/milestones/M003/slices/S04/S04-PLAN.md
  - .gsd/milestones/M003/slices/S04/tasks/T01-PLAN.md
key_decisions:
  - Durable wireframes should live as separate markdown files in a sibling `{spec-slug}-wireframes/` folder and be linked from the spec instead of being implied as inline appendix content.
patterns_established:
  - Durable wireframes are optional, low-fidelity, decision-tied markdown files linked from `Appendix D. Wireframes`, with later handoffs linking back to that appendix when relevant.
observability_surfaces:
  - `skills/brainstorming/references/spec-template.md` readback and `rg -n "wireframe|wireframes/|low-fidelity|handoff" skills/brainstorming/references/spec-template.md`
duration: 30m
verification_result: passed
completed_at: 2026-03-30T15:36:35Z
# Set blocker_discovered: true only if execution revealed the remaining slice plan
# is fundamentally invalid (wrong API, missing capability, architectural mismatch).
# Do NOT set true for ordinary bugs, minor deviations, or fixable issues.
blocker_discovered: false
---

# T01: Add selective low-fidelity wireframe appendix guidance to the shared spec template

**Updated the shared spec template so durable wireframes are optional low-fidelity markdown files in a dedicated sibling folder, linked from the spec and reusable from later handoffs when relevant.**

## What Happened

Per the unit pre-flight checks, I first patched the slice/task planning artifacts so observability was explicit before implementation: `S04-PLAN.md` now includes a localized `rg` verification step, and `T01-PLAN.md` now has an `## Observability Impact` section.

I then updated `skills/brainstorming/references/spec-template.md` to teach a more concrete durable-wireframe pattern:
- durable wireframes stay optional and selective, only for spatial decisions that materially affect later implementation or review
- each durable wireframe should be a separate low-fidelity markdown file in a sibling `{spec-slug}-wireframes/` folder
- file names should use stable review order such as `01-screen-name.md`
- the spec should expose those files through `Appendix D. Wireframes` with one-line descriptions
- a later GSD handoff may link back to that appendix instead of duplicating the wireframes

To make the pattern copyable, I added an example `Appendix D. Wireframes` block to the shared template and shifted the later appendix headings to `Appendix E. Decisions / ADR Notes` and `Appendix F. GSD Handoff Seed`.

I kept `skills/brainstorming/references/gsd-handoff-template.md` unchanged, as required by the slice boundary.

## Verification

Verified by direct readback of `skills/brainstorming/references/spec-template.md` that the shared template now states:
- optional/selective use
- dedicated sibling wireframe-folder plus linked-appendix pattern
- low-fidelity, structure-first form
- stable numbered file naming
- handoff-link allowance

Commands run:
- `rg -n "wireframe|wireframes/|low-fidelity|Appendix D|Appendix F|handoff" skills/brainstorming/references/spec-template.md`
- `node tests/brainstorm-server/visual-companion-contract.test.js` → PASS
- `node tests/brainstorm-server/live-companion-acceptance.test.js` → PASS (6/6 checks)
- `git diff --name-only -- skills/brainstorming/references/gsd-handoff-template.md skills/brainstorming/scripts/server.cjs skills/brainstorming/scripts/helper.js skills/brainstorming/scripts/frame-template.html` → no output, confirming no protected-file scope creep

## Diagnostics

Future inspection surfaces:
- `skills/brainstorming/references/spec-template.md` — canonical source of the durable-wireframe file pattern
- `rg -n "wireframe|wireframes/|low-fidelity|handoff" skills/brainstorming/references/spec-template.md` — fast localization of the folder, link, form, and handoff wording
- the two brainstorm-server tests above — unchanged authored/runtime proof stack

Failure state is now more inspectable because missing guidance can be localized to optionality, folder naming, link-list structure, low-fidelity form, or handoff linkage rather than inferred from broad prose.

## Quality Check

**Diff reviewed:** `HEAD(63b4231)..WORKTREE` — 3 implementation files reviewed before summary rewrite
**Checklists applied:** security, code-quality

### Issues Found

#### Critical
- none

#### Important
- none

#### Minor
- none

**Verdict:** PASS

## Deviations

User clarified the durable pattern after the first pass: wireframes should live as separate files in a dedicated folder and be linked from the spec. I updated the shared template and the local plan artifacts to match that stronger rule, including an explicit `Appendix D. Wireframes` example and shifted appendix numbering.

## Known Issues

None.

## Files Created/Modified

- `skills/brainstorming/references/spec-template.md` — added selective low-fidelity wireframe-file guidance, linked appendix examples, and handoff link-back wording
- `.gsd/milestones/M003/slices/S04/S04-PLAN.md` — updated slice wording so the recorded proof contract matches the dedicated-folder plus linked-appendix pattern
- `.gsd/milestones/M003/slices/S04/tasks/T01-PLAN.md` — updated task wording and observability notes to match the dedicated-folder plus linked-appendix pattern
- `.gsd/milestones/M003/slices/S04/tasks/T01-SUMMARY.md` — refreshed the task record to reflect the final shipped guidance
