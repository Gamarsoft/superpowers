---
id: M003
provides:
  - Hardened visual-companion protocol wording, a named regression-family artifact, review-loop enforcement, and selective durable wireframe appendix guidance without runtime changes
key_decisions:
  - "D026/D028: Keep M003 above the runtime by hardening the protocol, review, and spec-template surfaces first, then close on the unchanged live-runtime tie-breaker."
  - "D027/D029/D030/D031: Require a real authored RED baseline through the named pressure-scenario artifact and section-scoped contract anchors before treating the workflow wording as fixed."
  - "D032/D033: Make the checklist the detailed review gate, keep the reviewer prompt routing to it, and prove R041 with direct template readback plus a protected-file boundary diff."
patterns_established:
  - Workflow-hardening work should start with a named regression-family artifact and a deliberate RED baseline before any wording is softened or declared complete.
  - Narrow doc-layer extensions close safely when direct authored readback, unchanged proof commands, and explicit protected-file boundary checks all agree.
observability_surfaces:
  - skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md
  - node tests/brainstorm-server/visual-companion-contract.test.js
  - skills/brainstorming/references/spec-review-checklist.md
  - skills/brainstorming/spec-document-reviewer-prompt.md
  - skills/brainstorming/references/spec-template.md
  - node tests/brainstorm-server/live-companion-acceptance.test.js
  - git diff --name-only -- skills/brainstorming/references/gsd-handoff-template.md skills/brainstorming/scripts/server.cjs skills/brainstorming/scripts/helper.js skills/brainstorming/scripts/frame-template.html
requirement_outcomes:
  - id: R034
    from_status: active
    to_status: validated
    proof: S02 hardened `skills/brainstorming/SKILL.md` so the first later genuinely visual question starts the companion path after consent, and `node tests/brainstorm-server/visual-companion-contract.test.js` reran green.
  - id: R035
    from_status: active
    to_status: validated
    proof: S02 mirrored artifact-first sequencing in `skills/brainstorming/SKILL.md` and `skills/brainstorming/visual-companion.md`, with the passing authored-contract test proving the artifact is documented as viewable before the terminal prompt.
  - id: R036
    from_status: active
    to_status: validated
    proof: S02 made later-turn terminal question-tool continuity explicit in `skills/brainstorming/SKILL.md`, and the passing authored-contract test locked that wording.
  - id: R037
    from_status: active
    to_status: validated
    proof: S02 added explicit degraded fallback wording to both protocol docs, and the passing authored-contract test proved the fallback remains visible when the question tool is unavailable.
  - id: R038
    from_status: active
    to_status: validated
    proof: S01 created `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md` and reran `node tests/brainstorm-server/visual-companion-contract.test.js` to the intended RED baseline on missing protocol wording.
  - id: R039
    from_status: active
    to_status: validated
    proof: S03 hardened `skills/brainstorming/references/spec-review-checklist.md` and `skills/brainstorming/spec-document-reviewer-prompt.md`, then reran `bash tests/claude-code/test-document-review-system.sh` green under transient local shims after reproducing the raw environment failure.
  - id: R040
    from_status: active
    to_status: validated
    proof: The milestone followed the required writing-skills plus TDD loop: S01 captured the authored RED baseline, S02 reran the same contract surface to GREEN, and both proofs were recorded in the slice summaries.
  - id: R041
    from_status: active
    to_status: validated
    proof: S04 added selective low-fidelity wireframe appendix guidance to `skills/brainstorming/references/spec-template.md`, reran the authored-contract and live acceptance commands green, and confirmed no protected-file drift with the targeted diff check.
duration: ~4h 10m across S01-S04
verification_result: passed
completed_at: 2026-03-30T17:56:39+02:00
---

# M003: Visual Companion Protocol Hardening

**Delivered a hardened visual-companion contract that now starts accepted visual sessions on the first qualifying turn, keeps qualifying turns artifact-first with explicit terminal confirmation discipline, teaches review surfaces to fail the same regression family, and adds narrow optional wireframe-appendix carry-forward without changing runtime behavior.**

## What Happened

M003 closed the gap that M002 left behind: the brownfield live-use regression family was real, but the authored proof surface was too loose to catch it.

S01 fixed that first. It created `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md` with four named pressures — first-turn startup, artifact-first sequencing, terminal question-tool continuity, and explicit degraded fallback — and extended `tests/brainstorm-server/visual-companion-contract.test.js` so the current docs failed for the right reason. That mattered. The milestone stopped relying on green prose and got a concrete RED baseline before any workflow wording changed.

S02 then hardened the operative protocol itself. `skills/brainstorming/SKILL.md` and `skills/brainstorming/visual-companion.md` were brought into explicit agreement: after companion consent, the first later genuinely visual question must start the companion path, each qualifying visual turn stays artifact-first, later qualifying turns still ask the terminal confirmation question with the dedicated tool when available, and degraded fallback is named rather than silent. The same authored-contract test reran GREEN without touching server, helper, frame-template, or metadata scope.

S03 moved that same regression family into the review loop. `skills/brainstorming/references/spec-review-checklist.md` became the detailed conditional gate for visual-companion-sensitive reviews, and `skills/brainstorming/spec-document-reviewer-prompt.md` was tightened so the live review path actually invokes that gate while keeping the stable review output envelope.

S04 finished the narrow appendix work and rechecked the boundary. `skills/brainstorming/references/spec-template.md` now allows optional low-fidelity wireframe appendices only when durable spatial decisions need them, and it allows later handoffs to link back to an existing appendix without turning appendices into a routine requirement. The milestone then closed on direct template readback, green authored/runtime reruns, and a targeted protected-file diff that confirmed runtime and handoff-template scope stayed untouched.

## Cross-Slice Verification

### Success criteria

- **After companion consent, the first later genuinely visual decision is documented as starting or confirming the companion path instead of remaining terminal-only** — Met. Evidence: S02 readback of `skills/brainstorming/SKILL.md` `## Visual companion`, plus the passing rerun of `node tests/brainstorm-server/visual-companion-contract.test.js`.
- **Every qualifying visual turn is documented as artifact-first: the visual artifact is viewable before the terminal decision prompt is asked** — Met. Evidence: mirrored S02 wording in `skills/brainstorming/SKILL.md` and `skills/brainstorming/visual-companion.md`, plus the passing authored-contract test.
- **Later qualifying visual turns keep the dedicated terminal question-tool prompt when available, and when unavailable the degraded fallback wording is explicit rather than silent** — Met. Evidence: S02 readback of the continuity and degraded-fallback wording in both protocol docs, plus the passing authored-contract test.
- **The named pressure-scenario artifact, review checklist, and reviewer prompt all fail the same brownfield regression family instead of relying on general prose quality alone** — Met. Evidence: S01 pressure-scenario artifact and RED baseline, S03 conditional blocking gate in `skills/brainstorming/references/spec-review-checklist.md`, S03 checklist-routing language in `skills/brainstorming/spec-document-reviewer-prompt.md`, and the green rerun of `bash tests/claude-code/test-document-review-system.sh` under transient local shims after reproducing the environment failure.
- **A major spatial decision can carry forward through an optional low-fidelity wireframe appendix in the spec, and a handoff can link to that existing appendix without making appendices mandatory or changing runtime behavior** — Met. Evidence: S04 readback of `skills/brainstorming/references/spec-template.md`, the localized `rg -n "wireframe|low-fidelity|handoff" skills/brainstorming/references/spec-template.md` check, the passing reruns of `node tests/brainstorm-server/visual-companion-contract.test.js` and `node tests/brainstorm-server/live-companion-acceptance.test.js`, and the empty output from the protected-file `git diff --name-only` boundary check.

**Not met:** none.

### Definition of done

- **All slices are complete and every active M003 requirement remains mapped to delivered work rather than implied follow-up work** — Verified. The roadmap shows S01-S04 as `[x]`, and `.gsd/REQUIREMENTS.md` shows R034-R041 validated with no active requirements left.
- **The named pressure scenarios exist and the RED baseline was captured before workflow docs were hardened** — Verified. S01 created `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md` and captured the intended RED failure in `node tests/brainstorm-server/visual-companion-contract.test.js` before S02 wording changes.
- **`skills/brainstorming/SKILL.md` and `skills/brainstorming/visual-companion.md` explicitly agree on first-turn startup, artifact-first sequencing, terminal question-tool continuity, and explicit degraded fallback wording** — Verified. S02 readback confirmed the mirrored wording, and the authored-contract test passed.
- **Review assets explicitly check the named regression family instead of relying on generic review prose** — Verified. S03 updated the checklist and reviewer prompt to route relevant reviews through the named pressure-scenario gate.
- **Spec guidance supports selective durable wireframe appendices without changing the handoff template or runtime/archetype boundary** — Verified. S04 updated only `skills/brainstorming/references/spec-template.md`, and the protected-file diff against `skills/brainstorming/references/gsd-handoff-template.md`, `skills/brainstorming/scripts/server.cjs`, `skills/brainstorming/scripts/helper.js`, and `skills/brainstorming/scripts/frame-template.html` returned no changes.
- **The existing authored-contract and live runtime entrypoints are re-checked after the changes, not assumed safe because the milestone is doc-first** — Verified. `node tests/brainstorm-server/visual-companion-contract.test.js` and `node tests/brainstorm-server/live-companion-acceptance.test.js` both passed during S04 and again during milestone closeout.
- **Final integrated acceptance passes without runtime, helper, frame-template, or metadata changes** — Verified. The authored-contract test passed, the live acceptance suite passed 6/6 checks, and the protected-file diff stayed empty.
- **All slice summaries exist** — Verified in the workspace: `.gsd/milestones/M003/slices/S01/S01-SUMMARY.md`, `.gsd/milestones/M003/slices/S02/S02-SUMMARY.md`, `.gsd/milestones/M003/slices/S03/S03-SUMMARY.md`, and `.gsd/milestones/M003/slices/S04/S04-SUMMARY.md` are present.

## Requirement Changes

- R034: active → validated — S02 hardened first-turn startup wording in `skills/brainstorming/SKILL.md` and proved it with the passing authored-contract rerun.
- R035: active → validated — S02 mirrored artifact-first sequencing in both protocol docs and locked it with the passing authored-contract rerun.
- R036: active → validated — S02 made later-turn terminal question-tool continuity explicit and proved it on the same contract surface.
- R037: active → validated — S02 added explicit degraded fallback wording and proved it on the same contract surface.
- R038: active → validated — S01 created the named pressure-scenario artifact and advanced the contract harness to the intended RED baseline.
- R039: active → validated — S03 hardened the checklist and reviewer prompt around the named regression family and reran the shared review smoke green under transient local shims after reproducing the raw environment failure.
- R040: active → validated — The milestone followed the required RED→GREEN writing-skills plus TDD loop through the S01 baseline failure and S02 passing rerun.
- R041: active → validated — S04 added selective wireframe appendix guidance, reran the authored/runtime closure commands green, and confirmed the protected boundary stayed untouched.

## Forward Intelligence

### What the next milestone should know
- M003 proved the docs-and-review path can close the observed regression family without runtime work. If the same live failure reappears, start from the deferred runtime/helper enforcement backlog rather than reopening the wording pass.

### What's fragile
- `tests/brainstorm-server/visual-companion-contract.test.js` and the parser-sensitive protocol sections it inspects — small heading or wording drift can quietly weaken the authored proof surface even when the docs still read plausibly.

### Authoritative diagnostics
- `node tests/brainstorm-server/visual-companion-contract.test.js`, `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md`, and `skills/brainstorming/references/spec-review-checklist.md` — together they show the named regression family, the exact authored contract under test, and the live review gate that should fail it.

### What assumptions changed
- The original concern was that M003 might need runtime enforcement to close safely. What actually happened is that a stricter authored RED baseline, mirrored protocol wording, relevance-gated review checks, and narrow appendix guidance were enough to close the milestone while leaving runtime scope untouched.

## Files Created/Modified

- `.gsd/milestones/M003/M003-SUMMARY.md` — milestone closure summary with cross-slice verification, requirement transitions, and forward intelligence.
- `.gsd/PROJECT.md` — refreshed the living project summary to record M003 closure and the current post-milestone state.
- `.gsd/STATE.md` — recreated the local handoff surface so the repo once again has an explicit quick-glance state file.