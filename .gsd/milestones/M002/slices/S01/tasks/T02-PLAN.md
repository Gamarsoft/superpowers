---
estimated_steps: 5
estimated_files: 2
---

# T02: Tighten routing and pre-display guidance in the skill docs

**Slice:** S01 — Routing, quality gate, and active example refresh
**Milestone:** M002

## Description

Update the two authoritative guidance docs so they clearly route only genuinely visual questions into the browser, define the committed pre-display quality gate, forbid placeholder screens, and make the revise-or-stay-terminal fallback explicit without changing the runtime contract.

## Steps

1. Tighten the routing language in `skills/brainstorming/SKILL.md` so UI-adjacent is not treated as automatically visual.
2. Add the committed checklist items, the hard `no placeholder screens` rule, and explicit failure behavior to `skills/brainstorming/visual-companion.md`.
3. Make the active-example boundary explicit in the guide so the three active examples are in scope and `carry-forward-summary.html` remains untouched in S01.
4. Preserve the four archetypes, `/frontend-design` rule, degraded-mode workflow, fragment/full-document compatibility boundary, and `data-choice` contract.
5. Run the contract test and adjust wording until the assertions pass cleanly.

## Must-Haves

- [ ] `skills/brainstorming/SKILL.md` explicitly distinguishes genuinely visual questions from conceptual, scope, or text-first turns.
- [ ] `skills/brainstorming/visual-companion.md` contains the committed checklist, the placeholder-screen ban, and revise-or-stay-terminal failure behavior while preserving existing runtime-boundary rules.

## Verification

- `node tests/brainstorm-server/visual-companion-contract.test.js`
- Read the updated sections in `skills/brainstorming/SKILL.md` and `skills/brainstorming/visual-companion.md` to confirm the wording matches the new assertions and does not expand archetypes or runtime scope.

## Observability Impact

- Signals changed: the authored-doc contract now exposes an explicit inspection surface for genuinely-visual routing, the pre-display checklist, placeholder-screen rejection, revise-or-stay-terminal fallback, and the M002 active-example refresh boundary.
- How to inspect later: run `node tests/brainstorm-server/visual-companion-contract.test.js` and read the updated sections in `skills/brainstorming/SKILL.md` and `skills/brainstorming/visual-companion.md`; the named assertion should point directly at the missing phrase, checklist label, or boundary block.
- Failure state made visible: if routing language drifts, checklist wording weakens, placeholder screens are no longer explicitly banned, or the carry-forward example boundary expands, the contract test now fails with a section-specific message instead of a generic doc mismatch.

## Inputs

- `skills/brainstorming/SKILL.md` — current brainstorming workflow contract
- `skills/brainstorming/visual-companion.md` — current comparison-first authoring contract
- `.gsd/milestones/M002/M002-CONTEXT.md` — locked scope, constraints, and the user-approved first-slice boundary

## Expected Output

- `skills/brainstorming/SKILL.md` — tighter routing guidance for genuinely visual companion use
- `skills/brainstorming/visual-companion.md` — explicit pre-display quality gate and active-example boundary
