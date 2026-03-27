# M003: Visual Companion Protocol Hardening

**Vision:** Harden the brainstorming visual-companion contract so accepted visual sessions start at the right moment, every qualifying visual turn stays artifact-first with explicit terminal confirmation discipline, review surfaces catch the same regression family before it reaches users, and durable low-fidelity wireframe appendices remain a narrow optional spec aid rather than a runtime change.

## Success Criteria

- After companion consent, the first later genuinely visual decision is documented as starting or confirming the companion path instead of remaining terminal-only.
- Every qualifying visual turn is documented as artifact-first: the visual artifact is viewable before the terminal decision prompt is asked.
- Later qualifying visual turns keep the dedicated terminal question-tool prompt when available, and when unavailable the degraded fallback wording is explicit rather than silent.
- The named pressure-scenario artifact, review checklist, and reviewer prompt all fail the same brownfield regression family instead of relying on general prose quality alone.
- A major spatial decision can carry forward through an optional low-fidelity wireframe appendix in the spec, and a handoff can link to that existing appendix without making appendices mandatory or changing runtime behavior.

## Key Risks / Unknowns

- The current green authored-contract surface may stay blind to the motivating regression family — if the baseline failure is not made concrete first, the milestone can go green without fixing the real gap.
- Protocol wording could remain too loose across `skills/brainstorming/SKILL.md` and `skills/brainstorming/visual-companion.md` — if first-turn startup, artifact-first sequencing, and terminal confirmation continuity are not mirrored precisely, drift survives the hardening pass.
- Review hardening could lag the workflow change — if the checklist and reviewer prompt do not reference the named scenarios directly, future specs can reintroduce the same failure family between contract-test runs.
- Wireframe appendix guidance could sprawl into a fifth archetype or handoff-template rewrite — if the guidance is not kept narrow, R041 dilutes the milestone's main operability fix.

## Proof Strategy

- Blind authored proof surface → retire in S01 by shipping the named pressure-scenario artifact and RED proof anchors that expose today's gap before workflow wording changes.
- Loose protocol wording → retire in S02 by proving `skills/brainstorming/SKILL.md`, `skills/brainstorming/visual-companion.md`, and `tests/brainstorm-server/visual-companion-contract.test.js` all encode first-turn startup, artifact-first sequencing, terminal question-tool continuity, and explicit degraded fallback.
- Review-only drift risk → retire in S03 by proving the checklist and reviewer prompt explicitly audit the named pressure scenarios and fail missing outcomes in both spec and handoff review.
- Appendix scope creep or false closure → retire in S04 by proving `skills/brainstorming/references/spec-template.md` allows only selective low-fidelity appendix use, the handoff path can reference an existing appendix without template expansion, and the full named regression family plus unchanged runtime tie-breaker reruns green.

## Verification Classes

- Contract verification: `node tests/brainstorm-server/visual-companion-contract.test.js`, readback of `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md`, and authored diff review of the protocol, review, and template files against the named scenario set.
- Integration verification: RED→GREEN `writing-skills` / `test-driven-development` loop evidence showing the named pressure-scenario family fails before the edits and passes after the workflow, review, and template surfaces are updated.
- Operational verification: `node tests/brainstorm-server/live-companion-acceptance.test.js` stays green as the unchanged-runtime tie-breaker, confirming the milestone stayed above server, helper, and frame-template scope.
- UAT / human verification: human read-through confirms the optional wireframe appendix guidance is low-fidelity, selective, and useful for durable spatial decisions without turning appendices into a routine deliverable.

## Milestone Definition of Done

This milestone is complete only when all are true:

- all slices are complete and every active M003 requirement remains mapped to a delivered slice rather than implied follow-up work
- the named pressure scenarios exist and the RED baseline was captured before workflow docs were hardened
- `skills/brainstorming/SKILL.md` and `skills/brainstorming/visual-companion.md` explicitly agree on first-turn startup, artifact-first sequencing, terminal question-tool continuity, and explicit degraded fallback wording
- review assets explicitly check the named regression family instead of relying on generic review prose
- spec guidance supports selective durable wireframe appendices without changing the handoff template or runtime/archetype boundary
- the existing authored-contract and live runtime entrypoints are re-checked after the changes, not assumed safe because the milestone is doc-first
- final integrated acceptance passes without runtime, helper, frame-template, or metadata changes

## Requirement Coverage

- Covers: R034, R035, R036, R037, R038, R039, R040, R041
- Partially covers: none
- Leaves for later: R042, R043, R044
- Orphan risks: none
- Primary slice ownership: R038 → S01; R034, R035, R036, R037, R040 → S02; R039 → S03; R041 → S04

## Slices

- [x] **S01: Named pressure scenarios and RED proof surface** `risk:high` `depends:[]`
  > After this: the repo has a concrete non-regression artifact for the live-use failure family, and the current authored-contract surface can be shown failing against that family before workflow wording changes.

- [x] **S02: Protocol wording hardening and GREEN rerun** `risk:high` `depends:[S01]`
  > After this: accepted visual sessions are explicitly documented to start on the first qualifying visual turn, make the artifact viewable before the terminal decision prompt, and preserve question-tool discipline or named degraded fallback on every later qualifying turn.

- [x] **S03: Review loop hardening around the named regression family** `risk:medium` `depends:[S01,S02]`
  > After this: spec and handoff review surfaces explicitly fail missing first-turn startup, artifact-first sequencing, confirmation continuity, or degraded fallback outcomes instead of letting those gaps hide behind generic review language.

- [x] **S04: Selective wireframe appendix guidance and integrated closure** `risk:low` `depends:[S02,S03]`
  > After this: the spec path supports optional low-fidelity spatial appendices, handoffs can link to an existing appendix when relevant, and the full M003 docs-and-review stack is re-verified alongside the unchanged runtime tie-breaker.

## Boundary Map

### S01 → S02

Produces:
- `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md` with named scenarios for the baseline first-turn startup miss, artifact-first sequencing, terminal question-tool continuity, and explicit degraded fallback
- RED proof anchors that make the current authored gap observable before doc edits, including any `visual-companion-contract.test.js` extensions needed to fail on the missing protocol family
- a stable validation target for the `writing-skills` + `test-driven-development` loop

Consumes:
- nothing (first slice)

### S02 → S03

Produces:
- explicit mirrored protocol wording in `skills/brainstorming/SKILL.md` and `skills/brainstorming/visual-companion.md`
- updated `tests/brainstorm-server/visual-companion-contract.test.js` assertions that pass only when first-turn startup, artifact-first sequencing, question-tool continuity, and degraded fallback are explicit
- recorded GREEN rerun evidence showing the named authored protocol now satisfies the S01 pressure-scenario family

Consumes from S01:
- the named pressure scenarios and baseline failure anchors

### S02 → S04

Produces:
- stable protocol terms for first qualifying visual turn startup, artifact-first sequencing, dedicated terminal confirmation, and degraded fallback that appendix guidance cannot contradict
- an authored-contract proof surface that remains above runtime scope and can be re-run during final closure

Consumes from S01:
- the named scenario family and RED evidence shape

### S03 → S04

Produces:
- `skills/brainstorming/references/spec-review-checklist.md` and `skills/brainstorming/spec-document-reviewer-prompt.md` updated to audit the named pressure scenarios directly
- review-loop failure criteria that future specs and handoffs can be checked against without relying on reviewer memory

Consumes from S02:
- finalized protocol wording and contract-test anchors
