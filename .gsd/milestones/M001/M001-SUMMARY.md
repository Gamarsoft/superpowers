---
id: M001
provides:
  - Comparison-first visual companion upgrade across authoring guidance, fragment defaults, additive helper clarity, and integrated runtime validation
  - Milestone-level proof that the current HTML/runtime contract, fragment/full-document boundary, and terminal-first workflow remain intact
key_decisions:
  - "D001/D003: Preserve the thin non-blocking browser-plus-terminal runtime and keep comparison defaults fragment-only while leaving full-document screens compatibility-supported."
  - "D002/D004/D005: Lock M001 to four comparison-first archetypes and require `/frontend-design` or `$frontend-design` with the bounded first-use design-context workflow."
  - "D006/D015/D016: Keep helper behavior additive and `data-choice`-based, and make continuity authoritative in visible authored copy rather than runtime memory."
  - "D017/D020: Close the milestone only on the full automated matrix plus live browser/state corroboration."
patterns_established:
  - Comparison-first quality is best enforced with a strict authoring contract, copyable archetype examples, and regression checks that lock wording, order, and compatibility boundaries.
  - Shared-frame fragment upgrades should prove themselves through explicit wrapped-fragment selectors and a deterministic fragment-shell marker rather than new runtime metadata.
  - Carry-forward continuity stays reliable when later screens say `Chosen direction`, `Still open`, and `Degraded mode` explicitly, even after `state/events` is cleared.
observability_surfaces:
  - node tests/brainstorm-server/visual-companion-contract.test.js
  - node tests/brainstorm-server/fragment-comparison-defaults.test.js
  - node tests/brainstorm-server/carry-forward-behavior.test.js
  - cd tests/brainstorm-server && node server.test.js && node ws-protocol.test.js
  - cd tests/brainstorm-server && bash windows-lifecycle.test.sh
  - node tests/brainstorm-server/live-companion-acceptance.test.js
  - skills/brainstorming/scripts/start-server.sh startup JSON
  - state/server-info
  - state/server.log
  - state/events
  - explicit browser assertions for carry-forward copy and full-document non-contamination
requirement_outcomes:
  - id: R001
    from_status: active
    to_status: validated
    proof: S01 locked the four-archetype authoring contract, added one fragment example per archetype, and passed tests/brainstorm-server/visual-companion-contract.test.js.
  - id: R002
    from_status: active
    to_status: validated
    proof: S02 shipped fragment comparison defaults in skills/brainstorming/scripts/frame-template.html and proved recommendation/alternative legibility in tests/brainstorm-server/fragment-comparison-defaults.test.js.
  - id: R003
    from_status: active
    to_status: validated
    proof: S02 added ranked/current-winner emphasis plus the non-selected opacity guard, all locked by tests/brainstorm-server/fragment-comparison-defaults.test.js.
  - id: R004
    from_status: active
    to_status: validated
    proof: S03 required explicit `Chosen direction` / `Still open` carry-forward wording, added authored examples, passed tests/brainstorm-server/carry-forward-behavior.test.js, and proved the behavior live after event clearing.
  - id: R005
    from_status: active
    to_status: validated
    proof: S03 kept helper behavior container-scoped and presentation-only, guarded against workflow drift, and proved the terminal/authored screen stayed authoritative in live runtime checks.
  - id: R006
    from_status: active
    to_status: validated
    proof: S04 passed the full matrix (contract, fragment defaults, carry-forward, server, WebSocket, lifecycle, live acceptance) and corroborated runtime behavior with state/server-info, state/server.log, state/events, and full-document boundary checks.
  - id: R007
    from_status: active
    to_status: validated
    proof: S01 made `/frontend-design` or `$frontend-design` mandatory in skills/brainstorming/visual-companion.md and skills/brainstorming/SKILL.md, with regression coverage in tests/brainstorm-server/visual-companion-contract.test.js.
  - id: R008
    from_status: active
    to_status: validated
    proof: S01 documented and tested the bounded first-use workflow order: instruction context, repo design-context reuse, one-time session capture, then degraded mode.
  - id: R009
    from_status: active
    to_status: validated
    proof: S01 made repo design-context reuse explicit before any new session capture and locked that rule in tests/brainstorm-server/visual-companion-contract.test.js.
  - id: R010
    from_status: active
    to_status: validated
    proof: S03 required visible `Degraded mode` output in the guide and carry-forward example, passed tests/brainstorm-server/carry-forward-behavior.test.js, and verified the copy live.
  - id: R011
    from_status: active
    to_status: validated
    proof: S04 proved existing fragment screens, terminal-only carry-forward screens, and full-document passthrough through the refreshed lifecycle, server/WebSocket, and live-entrypoint acceptance suites.
  - id: R012
    from_status: active
    to_status: validated
    proof: S01 strengthened the guide with concrete authoring rules, direct example links, and strict contract tests that lock example presence and order.
duration: ~9h 35m across S01-S04
verification_result: passed
completed_at: 2026-03-28T15:56:43Z
---

# M001: Comparison-First Visual Companion Upgrade

**Delivered a comparison-first visual companion with a locked four-archetype authoring contract, fragment-only comparison defaults, additive selection clarity, explicit carry-forward states, and integrated runtime proof without changing the thin terminal-first architecture.**

## What Happened

M001 improved the visual companion by tightening the product surface above the existing runtime instead of expanding the runtime itself.

S01 established the authoring contract: exactly four v1 archetypes, explicit `/frontend-design` or `$frontend-design` routing, the bounded first-use design-context workflow, explicit degraded mode, and a copyable four-file fragment example kit. That gave later work a clear target and prevented drift into generic UI polish.

S02 then upgraded the shared fragment frame, not the server contract. Wrapped fragments now expose `data-comparison-kit="fragment-shell"`, and the shared frame applies clearer recommendation, current-winner, ranking, and carry-forward emphasis by default while leaving full-document passthrough untouched.

S03 strengthened the thin runtime boundary. `helper.js` now gives clearer container-scoped selected-state feedback without reading workflow semantics, while the guide and examples make later-screen continuity explicit in authored copy through `Chosen direction`, `Still open`, and `Degraded mode`. That kept click-assisted and terminal-only flows equally honest.

S04 closed the milestone by improving proof quality rather than changing behavior. The refreshed lifecycle and live-entrypoint acceptance surfaces verified the assembled kit through the real companion startup path, tied browser observations back to `state/server-info`, `state/server.log`, and `state/events`, and confirmed that full-document screens still avoid fragment-shell contamination.

## Cross-Slice Verification

### Success criteria

- **Users can identify the recommendation, visible alternatives, and main trade-off at a glance** — Met. S01 locked the four comparison-first archetypes and S02 shipped the shared fragment emphasis defaults. Evidence: authored examples, `tests/brainstorm-server/visual-companion-contract.test.js`, `tests/brainstorm-server/fragment-comparison-defaults.test.js`, and the S04 live browser acceptance that showed explicit recommendation and trade-off copy.
- **Ranked alternatives show a visible current winner while keeping lower-ranked options readable** — Met. Evidence: S02 added current-winner emphasis plus a non-selected opacity guard, and `tests/brainstorm-server/fragment-comparison-defaults.test.js` passed.
- **The next screen can carry forward a chosen direction or clearly state that the comparison is still open, even without browser clicks** — Met. Evidence: S03 guide/example updates, `tests/brainstorm-server/carry-forward-behavior.test.js`, and the live sequence where `state/events` was cleared on a fresher screen while visible `Chosen direction`, `Still open`, and `Degraded mode` copy remained.
- **Companion screen creation explicitly routes through `/frontend-design` or `$frontend-design`, with the bounded one-time design-context workflow applied before first use** — Met. Evidence: S01 documentation updates in `skills/brainstorming/visual-companion.md` and `skills/brainstorming/SKILL.md`, locked by `tests/brainstorm-server/visual-companion-contract.test.js`.
- **Existing valid fragment screens and full-document screens continue to render, with fragment-only comparison defaults applied only to shared-frame fragments** — Met. Evidence: S02 fragment-shell boundary checks, S04 lifecycle and live-entrypoint acceptance, and the live DOM proof that full-document screens exposed `window.brainstorm` but not fragment-shell selectors.

**Not met:** none.

### Definition of done

- **All slices complete** — Verified from the inlined roadmap state: S01, S02, S03, and S04 are all `[x]`.
- **All slice summaries exist** — Verified in the workspace: `.gsd/milestones/M001/slices/S01/S01-SUMMARY.md`, `.gsd/milestones/M001/slices/S02/S02-SUMMARY.md`, `.gsd/milestones/M001/slices/S03/S03-SUMMARY.md`, and `.gsd/milestones/M001/slices/S04/S04-SUMMARY.md` are present.
- **Cross-slice integration points work correctly** — Verified by the green automated stack and S04 live runtime acceptance: S01 contract → S02 fragment defaults → S03 helper/carry-forward behavior → S04 end-to-end runtime proof.
- **Requirement coverage is closed** — Verified by `.gsd/REQUIREMENTS.md`: R001-R012 are validated, there are no active requirements, and deferred/out-of-scope items remain explicitly bounded.
- **Real companion entrypoint exercised with authored screens** — Verified by `tests/brainstorm-server/live-companion-acceptance.test.js` and the live browser acceptance described in S04.

## Requirement Changes

- R001: active → validated — S01 locked the four archetypes, added the example kit, and passed `tests/brainstorm-server/visual-companion-contract.test.js`.
- R002: active → validated — S02 shipped fragment comparison defaults and proved recommendation/alternative legibility in `tests/brainstorm-server/fragment-comparison-defaults.test.js`.
- R003: active → validated — S02 proved visible current-winner emphasis plus readable lower-ranked options with the non-selected opacity guard.
- R004: active → validated — S03 made carry-forward explicit in authored copy and proved it with `tests/brainstorm-server/carry-forward-behavior.test.js` and live acceptance.
- R005: active → validated — S03 preserved the terminal-first model by keeping helper behavior additive and presentation-only.
- R006: active → validated — S04 closed the runtime-contract proof on the full automated matrix plus live state-backed acceptance.
- R007: active → validated — S01 made `/frontend-design` or `$frontend-design` an explicit rule and locked it in the contract test.
- R008: active → validated — S01 documented and tested the bounded first-use design-context workflow.
- R009: active → validated — S01 documented and tested repo design-context reuse before one-time session capture.
- R010: active → validated — S03 required and proved explicit degraded-mode output.
- R011: active → validated — S04 proved existing screens and terminal-only flows still work through lifecycle, protocol, and live-entrypoint checks.
- R012: active → validated — S01 delivered guidance and examples strong enough for consistent reuse.

## Forward Intelligence

### What the next milestone should know
- M001 is intentionally thin-runtime and authoring-heavy. Future milestones should keep building on explicit authored screens, the fragment/full-document boundary, and the existing observability surfaces instead of adding hidden workflow state.

### What's fragile
- `skills/brainstorming/scripts/frame-template.html` and its selector-level regression tests — small selector or token changes can silently weaken comparison emphasis or blur the fragment/full-document boundary unless the tests move with the implementation.

### Authoritative diagnostics
- The S04 proof stack is the fastest trustworthy truth source: the automated matrix plus `state/server-info`, `state/server.log`, `state/events`, and explicit browser assertions. These signals separate real runtime drift from browser reload ambiguity.

### What assumptions changed
- The work did not need a deeper runtime rewrite or new metadata. The existing fragment structures, `data-choice`, authored carry-forward copy, and strict regression tests were sufficient to deliver the comparison-first upgrade and prove it end to end.

## Files Created/Modified

- `.gsd/milestones/M001/M001-SUMMARY.md` — milestone closure summary with cross-slice verification, requirement transitions, and forward intelligence.
- `.gsd/PROJECT.md` — refreshed current project status to reflect M001 closure and post-milestone state.
- `.gsd/STATE.md` — recorded that the project is now at milestone-complete state with no active requirement work.
