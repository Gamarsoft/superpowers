---
estimated_steps: 5
estimated_files: 7
---

# T02: Re-run the integrated proof stack and close the milestone metadata

**Slice:** S04 — Selective wireframe appendix guidance and integrated closure
**Milestone:** M003

## Description

Prove the new appendix guidance directly, rerun the two trusted M003 closure commands, confirm the protected boundary files stayed untouched, and then update the milestone records so R041 is no longer left active.

## Steps

1. Read back `skills/brainstorming/references/spec-template.md` and confirm the four required R041 outcomes are explicit: optional/selective use, durable spatial triggers, low-fidelity form, and handoff-link allowance.
2. Run `node tests/brainstorm-server/visual-companion-contract.test.js` to confirm the authored protocol surface still passes after the template change.
3. Run `node tests/brainstorm-server/live-companion-acceptance.test.js` as the unchanged-runtime tie-breaker.
4. Run `git diff --name-only -- skills/brainstorming/references/gsd-handoff-template.md skills/brainstorming/scripts/server.cjs skills/brainstorming/scripts/helper.js skills/brainstorming/scripts/frame-template.html` and confirm it returns no protected-file edits.
5. If all checks pass, record the proof in `S04-SUMMARY.md`, mark R041 validated in `.gsd/REQUIREMENTS.md`, mark S04 complete in `.gsd/milestones/M003/M003-ROADMAP.md`, and advance `.gsd/STATE.md` to the next post-M003 action.

## Must-Haves

- [ ] The updated shared template is directly read back and proven to cover all four R041 outcomes before the slice closes.
- [ ] The authored-contract test, the live acceptance test, and the protected-file diff check all pass before milestone metadata is updated.

## Verification

- `node tests/brainstorm-server/visual-companion-contract.test.js`
- `node tests/brainstorm-server/live-companion-acceptance.test.js`
- `git diff --name-only -- skills/brainstorming/references/gsd-handoff-template.md skills/brainstorming/scripts/server.cjs skills/brainstorming/scripts/helper.js skills/brainstorming/scripts/frame-template.html`
- Read back `skills/brainstorming/references/spec-template.md`, `.gsd/REQUIREMENTS.md`, `.gsd/milestones/M003/M003-ROADMAP.md`, and `.gsd/STATE.md` to confirm the proof and closure were recorded.

## Observability Impact

- Signals changed: the final slice will record a direct authored proof for R041 plus rerun outcomes from the authored-contract and live-runtime acceptance surfaces.
- How a future agent inspects this: read `skills/brainstorming/references/spec-template.md` for the appendix rule, rerun the two `tests/brainstorm-server` commands, and inspect the targeted `git diff` output for protected-file drift.
- Failure state exposed: the template readback localizes missing R041 wording, the contract test localizes authored-surface drift, the live acceptance test localizes unchanged-runtime regressions, and the diff check exposes accidental handoff-template or runtime-surface edits.

## Inputs

- `skills/brainstorming/references/spec-template.md` — the updated shared template that must now prove R041 directly
- `tests/brainstorm-server/visual-companion-contract.test.js` — the authored-contract proof surface that must stay green
- `tests/brainstorm-server/live-companion-acceptance.test.js` — the unchanged-runtime tie-breaker for final closure
- `.gsd/REQUIREMENTS.md` — the requirement registry that still lists R041 as active before this task closes it
- `.gsd/milestones/M003/M003-ROADMAP.md` — the milestone tracker that should show S04 complete after proof passes
- `.gsd/STATE.md` — the active-state handoff file that must advance beyond planning once the slice is proven
- `.gsd/milestones/M003/slices/S04/S04-SUMMARY.md` — the slice-level proof artifact to create during closeout

## Expected Output

- `.gsd/milestones/M003/slices/S04/S04-SUMMARY.md` — recorded integrated proof and closure notes for S04
- `.gsd/REQUIREMENTS.md` — updated so R041 is validated instead of active
- `.gsd/milestones/M003/M003-ROADMAP.md` — updated so S04 is complete
- `.gsd/STATE.md` — updated to the next post-M003 execution handoff
