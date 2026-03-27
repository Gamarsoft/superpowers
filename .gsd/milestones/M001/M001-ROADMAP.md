# M001: Comparison-First Visual Companion Upgrade

**Vision:** Upgrade the existing visual companion into a comparison-first design aid that makes options, recommendations, and carry-forward state materially clearer while preserving the current non-blocking browser-plus-terminal model and the current HTML/runtime contract.

## Success Criteria

- Users can review a comparison-first companion screen and identify the recommended direction, visible alternatives, and main trade-off at a glance.
- Ranked alternatives show a visible current winner and still keep lower-ranked options readable enough for honest comparison.
- The next screen can explicitly carry forward a chosen direction, or explicitly state that the comparison is still open, even when the user never clicked in the browser.
- Companion screen creation explicitly routes through `/frontend-design` or `$frontend-design`, with the bounded one-time design-context workflow applied before the first use.
- Existing valid fragment screens and full-document screens continue to render, with fragment-only comparison defaults applied only to shared-frame fragment screens.

## Key Risks / Unknowns

- The work could drift into generic visual-polish improvements instead of comparison-first decision support — that would miss the actual product claim.
- `frontend-design` could add too much runtime friction if the design-context requirement is not kept one-time, bounded, and reusable when repo context exists — that would make the new authoring rule costly to follow.
- Fragment-first defaults could accidentally become an implied parity promise for full-document screens — that would break the intended compatibility boundary.
- Helper or frame changes could grow hidden workflow behavior instead of staying additive and explicit — that would violate the existing runtime contract.

## Proof Strategy

- Comparison-first value could get diluted by generic screen polish → retire in S01 by proving the authoring contract names exactly four archetypes, ties them to concrete authored examples, and binds screen creation to the explicit `/frontend-design` or `$frontend-design` workflow.
- `frontend-design` could become too heavy to use in live brainstorming → retire in S01 by proving the one-time session design-context workflow is bounded, reusable, and has an explicit degraded mode when context is unavailable.
- Fragment defaults could be confused with universal behavior → retire in S02 by proving fragment screens receive the comparison-kit defaults while full-document compatibility remains explicit and unchanged.
- Additive runtime behavior could drift into implicit workflow logic → retire in S03 by proving selected-state clarity and carry-forward presentation work for click-assisted and terminal-only flows without new required metadata or server/session rewrites.

## Verification Classes

- Contract verification: documentation review, authored-screen examples, artifact checks, and targeted tests around frame/helper behavior
- Integration verification: real companion runtime exercises fragment screens, full-document compatibility screens, `state_dir/events`, and terminal-only carry-forward scenarios
- Operational verification: existing start, reload, newest-screen selection, helper injection, and event persistence behavior still pass under the normal runtime lifecycle
- UAT / human verification: checking whether a real brainstorm reaches a decision with less ambiguity and fewer clarification loops than before

## Milestone Definition of Done

This milestone is complete only when all are true:

- all slice deliverables are complete and mapped requirements are covered
- the four archetypes, runtime `frontend-design` rule, design-context workflow, degraded mode, and compatibility rule are all documented and reflected in the assembled companion behavior
- fragment screens get comparison-first defaults without changing the current HTML/runtime contract
- selected, current-winner, and still-open states are visibly legible for both click-assisted and terminal-only flows
- the real companion entrypoint is exercised with authored screens, not just file-level artifacts
- success criteria are re-checked against live behavior, compatibility checks, and scenario-based validation
- final integrated acceptance scenarios pass without a server/workflow rewrite

## Requirement Coverage

- Covers: R001, R002, R003, R004, R005, R006, R007, R008, R009, R010, R011, R012
- Partially covers: none
- Leaves for later: R020, R021, R022, R023
- Orphan risks: none

## Slices

- [x] **S01: Authoring contract and archetype kit** `risk:high` `depends:[]`
  > After this: the companion has an explicit comparison-first authoring contract with four archetypes, explicit `/frontend-design` or `$frontend-design` runtime use, repo-context reuse, a one-time session design-context workflow, degraded-mode behavior, and authored examples the agent can follow.

- [x] **S02: Fragment comparison defaults** `risk:medium` `depends:[S01]`
  > After this: shared-frame fragment screens make recommendation, current winner, alternatives, and carry-forward summaries visibly clearer by default, while full-document compatibility remains explicit and unchanged.

- [x] **S03: Selection clarity and carry-forward behavior** `risk:medium` `depends:[S01,S02]`
  > After this: click-assisted and terminal-only flows both produce screens with explicit selected or still-open state, and helper behavior remains additive and `data-choice`-based rather than workflow-driven.

- [x] **S04: Compatibility and integrated validation** `risk:low` `depends:[S02,S03]`
  > After this: the assembled comparison-first kit is proven against existing fragment/full-document behavior, authored-screen scenarios, and end-to-end runtime checks in the real companion flow.

## Closure Evidence

M001 is now closed on measured proof, not planned intent.

- Full automated validation matrix passed: `node tests/brainstorm-server/visual-companion-contract.test.js && node tests/brainstorm-server/fragment-comparison-defaults.test.js && node tests/brainstorm-server/carry-forward-behavior.test.js && cd tests/brainstorm-server && node server.test.js && node ws-protocol.test.js && bash windows-lifecycle.test.sh && cd ../.. && node tests/brainstorm-server/live-companion-acceptance.test.js`
- Live browser acceptance passed through `skills/brainstorming/scripts/start-server.sh`: authored fragment click wrote `state/events`, a genuinely newer carry-forward screen cleared `state/events` while preserving visible `Chosen direction`, `Still open`, and `Degraded mode` copy, and a genuinely newer full-document screen rendered without `data-comparison-kit="fragment-shell"` contamination.
- Authoritative tie-breakers for ambiguous reload behavior were the live session’s `state/server-info`, `state/server.log`, and `state/events` surfaces plus explicit browser assertions.
- The only observed browser noise was a benign favicon 404; it did not affect the contract, lifecycle, server/WebSocket, or live acceptance results.

## Boundary Map

### S01 → S02

Produces:
- `skills/brainstorming/visual-companion.md` archetype contract for side-by-side comparison, ranked alternatives, annotated recommendation / current winner, and carry-forward summary
- explicit runtime rule that companion screen creation invokes `/frontend-design` or `$frontend-design`
- bounded one-time session design-context workflow: instruction context → repo design-context source if present → minimal one-time session capture → explicit degraded mode if unavailable
- authored fragment examples and authoring rules that downstream visual defaults can target without introducing new required metadata beyond `data-choice`

Consumes:
- nothing (first slice)

### S01 → S03

Produces:
- explicit carry-forward semantics for chosen versus still-open direction in authored screens
- explicit non-goals that helper behavior must stay additive and `data-choice`-based
- compatibility rule that full-document screens remain valid but do not receive fragment comparison defaults automatically

Consumes:
- nothing (first slice)

### S02 → S03

Produces:
- shared-frame visual treatments for recommendation emphasis, current winner, alternative visibility, ranked order cues, and carry-forward summary presentation on fragment screens
- fragment-first styling contract that helper-selected state can strengthen without inventing hidden decision logic

Consumes from S01:
- archetype names, authored examples, and runtime authoring rules from `skills/brainstorming/visual-companion.md`

### S02 → S04

Produces:
- fragment rendering behavior that can be checked against compatibility expectations for both comparison screens and existing authored screens
- explicit proof surface for the fragment-only defaults versus full-document compatibility boundary

Consumes from S01:
- full-document compatibility rule and comparison-first archetype contract

### S03 → S04

Produces:
- additive `helper.js` selected-state clarity for `data-choice` interactions
- explicit terminal-only carry-forward behavior that does not depend on `state_dir/events`
- authored-screen scenarios for chosen and still-open direction across browser-click and terminal-only paths

Consumes from S01:
- carry-forward rules, degraded-mode rule, and `frontend-design` workflow contract

Consumes from S02:
- fragment-first comparison styling surfaces that selected-state and carry-forward behavior attach to
