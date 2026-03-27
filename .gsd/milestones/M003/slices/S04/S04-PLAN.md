---
estimated_steps: 6
estimated_files: 7
---

# S04: Selective wireframe appendix guidance and integrated closure

**Goal:** Close R041 by teaching the shared spec path when a durable wireframe appendix is worth carrying forward, keeping that appendix low-fidelity and selective, and proving the milestone still closes green without handoff-template or runtime changes.
**Demo:** A future agent can open `skills/brainstorming/references/spec-template.md`, see explicit optional wireframe-appendix guidance plus a handoff-link allowance seeded from the spec path, then rerun the authored-contract and unchanged-runtime acceptance checks and get the same green result.

## Description

This slice directly owns **R041**. I’m grouping the work into two tasks because the main risk is false closure: the existing authored-contract and live-runtime tests can stay green even if the shared spec template never learns the selective wireframe-appendix rule. T01 therefore changes only `skills/brainstorming/references/spec-template.md`, reusing the already-proven appendix pattern while keeping `skills/brainstorming/references/gsd-handoff-template.md` untouched and avoiding any new default appendix regime. T02 then closes the loop with direct template readback, the two existing integrated proof commands, and an explicit scope-boundary check so the milestone finishes on authored evidence plus the unchanged runtime tie-breaker rather than on prose confidence alone.

## Must-Haves

- `skills/brainstorming/references/spec-template.md` explicitly says durable wireframe appendices are optional and selective, reserved for spatial decisions that materially affect later implementation or review.
- The shared spec path keeps durable wireframes low-fidelity and decision-tied, and it makes clear they are not a routine appendix for every visual turn.
- The spec path explicitly allows a GSD handoff to link to an existing appendix when that appendix materially shapes implementation, without changing `skills/brainstorming/references/gsd-handoff-template.md`.
- `node tests/brainstorm-server/visual-companion-contract.test.js` and `node tests/brainstorm-server/live-companion-acceptance.test.js` both pass after the template change, and no runtime/helper/frame-template or handoff-template edits are introduced.

## Proof Level

- This slice proves: final-assembly
- Real runtime required: yes
- Human/UAT required: no

## Verification

- Read back `skills/brainstorming/references/spec-template.md` and confirm it says wireframe appendices are optional, low-fidelity, reserved for durable spatial decisions, and linkable from the handoff when relevant.
- `rg -n "wireframe|low-fidelity|handoff" skills/brainstorming/references/spec-template.md` returns the localized guidance lines so missing optionality, form, or handoff-link wording is inspectable without rereading the whole file.
- `node tests/brainstorm-server/visual-companion-contract.test.js`
- `node tests/brainstorm-server/live-companion-acceptance.test.js`
- `git diff --name-only -- skills/brainstorming/references/gsd-handoff-template.md skills/brainstorming/scripts/server.cjs skills/brainstorming/scripts/helper.js skills/brainstorming/scripts/frame-template.html` returns no changed files.

## Observability / Diagnostics

- Runtime signals: pass/fail output from the authored-contract test and the live-companion acceptance test, plus direct readback of the updated shared template.
- Inspection surfaces: `skills/brainstorming/references/spec-template.md`, `tests/brainstorm-server/visual-companion-contract.test.js`, `tests/brainstorm-server/live-companion-acceptance.test.js`, and the scope-boundary `git diff` check against the handoff template and runtime files.
- Failure visibility: template readback localizes missing optionality, dedicated-folder plus linked-appendix guidance, low-fidelity guardrails, durable-decision triggers, or handoff-link wording; the two test commands distinguish authored-contract drift from unchanged-runtime drift; the diff check exposes accidental scope creep immediately.
- Redaction constraints: keep closure notes and summaries free of user-specific transcripts or secret values; only record file paths, commands, and high-signal outcomes.

## Integration Closure

- Upstream surfaces consumed: `skills/brainstorming/references/spec-template.md`, `skills/brainstorming/references/gsd-handoff-template.md`, `docs/superpowers/specs/2026-03-30--brainstorming-visual-companion-protocol-hardening.md`, `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md`, `tests/brainstorm-server/visual-companion-contract.test.js`, `tests/brainstorm-server/live-companion-acceptance.test.js`, `.gsd/REQUIREMENTS.md`, and `.gsd/milestones/M003/M003-ROADMAP.md`.
- New wiring introduced in this slice: the shared spec template gains a narrow appendix-carry-forward rule; no runtime or handoff-template wiring is added.
- What remains before the milestone is truly usable end-to-end: nothing.

## Tasks

- [x] **T01: Add selective low-fidelity wireframe appendix guidance to the shared spec template** `est:40m`
  - Why: R041 remains unproven until the live spec template itself tells authors when a durable wireframe appendix is useful, what form it should take, and how the later handoff may point back to it without turning appendices into routine paperwork.
  - Files: `skills/brainstorming/references/spec-template.md`
  - Do: Distill the existing one-off wireframe appendix pattern into the shared template; add explicit authoring guidance that a durable wireframe appendix is optional, only for spatial decisions that materially affect later implementation or review, and must stay low-fidelity and structure-first; keep the appendix tied to a specific decision and key rationale; state clearly that ordinary visual turns do not need one; and seed the allowance that the GSD handoff may link back to an existing appendix when relevant, all without editing `skills/brainstorming/references/gsd-handoff-template.md` or creating a new required appendix block.
  - Verify: Read back `skills/brainstorming/references/spec-template.md` and confirm it now covers optionality, durable spatial triggers, low-fidelity guardrails, and handoff-link allowance from the spec path.
  - Done when: the shared spec template can guide a future author to add a durable wireframe appendix only when it materially helps spatial carry-forward, while leaving the handoff template and runtime surfaces untouched.
- [x] **T02: Re-run the integrated proof stack and close the milestone metadata** `est:40m`
  - Why: S04 can look finished on prose alone, so the final slice needs direct template proof, the established authored-contract and unchanged-runtime reruns, an explicit no-scope-creep check, and the usual milestone bookkeeping to make R041 genuinely validated.
  - Files: `skills/brainstorming/references/spec-template.md`, `tests/brainstorm-server/visual-companion-contract.test.js`, `tests/brainstorm-server/live-companion-acceptance.test.js`, `.gsd/REQUIREMENTS.md`, `.gsd/milestones/M003/M003-ROADMAP.md`, `.gsd/STATE.md`, `.gsd/milestones/M003/slices/S04/S04-SUMMARY.md`
  - Do: Re-read the updated template for the four required R041 outcomes; run the authored-contract and live-acceptance commands; confirm the handoff template and runtime/helper/frame-template files remain unchanged with the targeted `git diff` check; if the verification stays green, record the slice summary, mark R041 validated in `.gsd/REQUIREMENTS.md`, mark S04 complete in the roadmap, and advance `.gsd/STATE.md` to the post-M003 handoff.
  - Verify: `node tests/brainstorm-server/visual-companion-contract.test.js`; `node tests/brainstorm-server/live-companion-acceptance.test.js`; `git diff --name-only -- skills/brainstorming/references/gsd-handoff-template.md skills/brainstorming/scripts/server.cjs skills/brainstorming/scripts/helper.js skills/brainstorming/scripts/frame-template.html`; and read back `skills/brainstorming/references/spec-template.md` plus the updated milestone state files.
  - Done when: the two established proof commands stay green, the template readback proves R041 directly, the protected boundary files remain untouched, and the project metadata records S04 and M003 as closed.

## Files Likely Touched

- `skills/brainstorming/references/spec-template.md`
- `.gsd/REQUIREMENTS.md`
- `.gsd/milestones/M003/M003-ROADMAP.md`
- `.gsd/STATE.md`
- `.gsd/milestones/M003/slices/S04/S04-SUMMARY.md`
stones/M003/slices/S04/S04-SUMMARY.md`
-SUMMARY.md`
