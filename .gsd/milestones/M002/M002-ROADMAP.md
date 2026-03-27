# M002: Visual Companion Routing and Authoring Quality

**Vision:** Make the visual companion harder to misuse and easier to trust by routing it only to genuinely visual questions, blocking placeholder screens before display, and upgrading the three active example fragments into concrete decision-capable starting points without changing the proven runtime contract.

## Success Criteria

- A conceptual, scope, or text-first brainstorming turn stays in terminal because the written routing rule now makes browser use an explicit exception for genuinely visual questions.
- A weak companion artifact with placeholder boxes, generic labels, or decision-empty prose fails the written pre-display gate and must be revised or kept out of the browser.
- The active side-by-side, ranked, and annotated-recommendation examples show concrete, subject-specific visual content that supports real layout, hierarchy, or flow judgment instead of generic shells.
- `carry-forward-summary.html` remains unchanged in this milestone and still fits the existing authored continuity contract.
- The refreshed guidance and examples render through the real companion entrypoint without reopening server, helper, frame-template, metadata, or archetype behavior.

## Key Risks / Unknowns

- Routing language could stay too soft to change behavior — if the browser is still treated as the default for UI-adjacent questions, the milestone misses its main value.
- The quality gate could describe good output without actually blocking weak output — if failure behavior is vague, placeholder screens will still reach the browser.
- Flow-style examples may still feel like dressed-up prose — if they are not visually concrete enough, the current archetypes may remain conditional for that trial family.
- Example refresh work could quietly spill into runtime or carry-forward changes — that would blur whether the real bottleneck was authoring quality or infrastructure.

## Proof Strategy

- Routing ambiguity → retire in S01 by proving `SKILL.md` and `visual-companion.md` clearly separate genuinely visual questions from conceptual or text-first turns, and by locking the revise-or-stay-terminal rule in regression checks.
- Weak or placeholder artifact leakage → retire in S01 by proving the checklist and `no placeholder screens` rule are explicit enough to reject low-information screens before display.
- Active examples may still be too generic → retire in S01 by proving the three in-scope example fragments become concrete decision artifacts for layout, hierarchy, and conditional flow-style comparisons while `carry-forward-summary.html` stays untouched.
- Runtime-boundary drift or false confidence from doc-only proof → retire in S02 by proving the refreshed examples still render through the real `start-server.sh` entrypoint and the existing lifecycle/acceptance surfaces without server or helper changes.

## Verification Classes

- Contract verification: `node tests/brainstorm-server/visual-companion-contract.test.js` plus targeted artifact assertions for the active example boundary and the new routing/checklist wording.
- Integration verification: real companion runtime exercise through `node tests/brainstorm-server/live-companion-acceptance.test.js` with the refreshed fragments and unchanged carry-forward example.
- Operational verification: `bash tests/brainstorm-server/windows-lifecycle.test.sh` and the existing server/WebSocket suite still pass while serving the updated authored files.
- UAT / human verification: quick human review that the refreshed examples feel concrete and decision-capable, not like prose copied into styled boxes.

## Milestone Definition of Done

This milestone is complete only when all are true:

- all slices are complete and each active requirement is owned by a delivered slice rather than left implicit
- the routing rule, pre-display checklist, placeholder-screen ban, and revise-or-terminal fallback are explicit in the authored guidance and covered by regression checks
- the three active examples are visibly more concrete and remain within the current four-archetype contract
- `carry-forward-summary.html` remains unchanged unless a contradiction was found and explicitly justified
- the real companion entrypoint is exercised with the refreshed example set, not just file-level assertions
- success criteria are re-checked against live runtime behavior and the existing acceptance stack, not just edited markdown
- final integrated acceptance passes without reopening runtime, metadata, or archetype scope

## Requirement Coverage

- Covers: R013, R014, R015, R016, R017, R018, R019
- Partially covers: none
- Leaves for later: R020, R021, R022, R023
- Orphan risks: none
- Primary slice ownership: R013, R014, R015, R016, R017, R018 → S01; R019 → S02

## Slices

- [x] **S01: Routing, quality gate, and active example refresh** `risk:high` `depends:[]`
  > After this: the written workflow keeps conceptual and text-first turns in terminal, blocks placeholder screens before display, and ships stronger side-by-side, ranked, and annotated-recommendation fragments together while leaving the carry-forward example untouched.

- [x] **S02: Live runtime corroboration and milestone closure** `risk:low` `depends:[S01]`
  > After this: the assembled M002 guidance and refreshed active examples are corroborated through the real companion entrypoint and existing acceptance stack, proving the milestone improved authoring quality without runtime drift.

## Closure Evidence

M002 is now closed on fresh runtime evidence, not authored-file confidence.

- Full S02 runtime corroboration matrix passed on closure: `node tests/brainstorm-server/live-companion-acceptance.test.js && bash tests/brainstorm-server/windows-lifecycle.test.sh && node tests/brainstorm-server/server.test.js && node tests/brainstorm-server/ws-protocol.test.js`
- Live browser corroboration passed through `skills/brainstorming/scripts/start-server.sh`: the refreshed annotated recommendation rendered through the real entrypoint, a real click on `.option[data-choice='technical-stack-settings']` wrote `state/events`, and a genuinely newer `carry-forward-summary` screen reloaded with visible `Chosen direction`, `Still open`, and `Degraded mode` copy while `state/events` cleared.
- Authoritative tie-breakers for ambiguous browser behavior were `state/server-info`, `state/server.log`, `state/events`, and browser resource entries from `performance.getEntriesByType('resource')`.
- The only recurring browser warning localized to `/favicon.ico`, so it was recorded as non-blocking auxiliary noise rather than runtime drift.

## Boundary Map

### S01 → S02

Produces:
- tightened routing language in `skills/brainstorming/SKILL.md` that treats the browser as opt-in for genuinely visual questions only
- explicit pre-display checklist, `no placeholder screens` rule, and revise-or-stay-terminal fallback in `skills/brainstorming/visual-companion.md`
- refreshed `skills/brainstorming/examples/visual-companion/side-by-side-comparison.html`, `ranked-alternatives.html`, and `annotated-recommendation.html` with more concrete decision-capable content
- invariant that `skills/brainstorming/examples/visual-companion/carry-forward-summary.html` remains unchanged unless a contradiction is explicitly found
- contract-level regression coverage for the tighter routing bar, the quality gate wording, and the active-example boundary

Consumes:
- nothing (first slice)
