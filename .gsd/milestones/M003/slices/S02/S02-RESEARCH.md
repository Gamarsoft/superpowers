# S02: Protocol wording hardening and GREEN rerun — Research

**Date:** 2026-03-30

## Summary

S02 owns the protocol-hardening core of M003: **R034, R035, R036, R037, and R040**. It also supports **R039** indirectly by producing the stable wording that S03 must later audit. The repo is already set up for this slice more tightly than the roadmap alone suggests: S01 did not just add the named pressure scenarios, it also extended `tests/brainstorm-server/visual-companion-contract.test.js` with the exact authored anchors that S02 now needs to satisfy. That means the slice's main job is likely **not** new harness work — it is a precise doc update in `skills/brainstorming/SKILL.md` and `skills/brainstorming/visual-companion.md`, followed by a RED→GREEN rerun.

The most important current fact is that the authored contract is intentionally RED for the right reason. `node tests/brainstorm-server/visual-companion-contract.test.js` now fails on missing protocol wording in `skills/brainstorming/SKILL.md`, starting with the absent first-turn startup rule. The guide files already contain parts of the needed policy — genuinely-visual routing, browser-is-not-a-mode language, degraded mode for missing design context, and general platform question-tool preference — but they do **not** yet encode the full M003 per-turn protocol explicitly enough for the new section-scoped assertions.

The biggest implementation constraint is structural, not conceptual. The contract test slices exact markdown sections by heading boundaries and checks for ordered phrases inside those slices. S02 should therefore prefer **small, additive wording changes inside the existing `## Visual companion` and `## Per-question decision rule` sections** instead of reorganizing headings. The fastest safe path is to mirror the named pressure-scenario outcomes almost verbatim, preserve existing M002 and M001 language, and rerun the authored contract after each change until all M003 anchors pass.

## Recommendation

Take S02 in this order:

1. **Treat the existing RED contract test as the authoritative starting point.**
   - R040 is already half-proved by S01: the baseline failure exists and localizes to missing authored protocol wording rather than missing-file drift.
   - Do not weaken or replace this surface with prose review.

2. **Edit `skills/brainstorming/SKILL.md` minimally, inside `## Visual companion`.**
   - Add the explicit first-turn startup rule for **R034**.
   - Add explicit terminal decision-prompt continuity after earlier browser use for **R036**.
   - Add explicit named degraded fallback wording for question-tool unavailability for **R037**.
   - Keep the existing per-question/browser-optional boundary intact.

3. **Edit `skills/brainstorming/visual-companion.md` minimally, inside `## Per-question decision rule`.**
   - Add the exact artifact-first sequence for **R035**:
     1. author or refresh the visual artifact first
     2. tell the user what they are viewing and what decision it supports
     3. ask the decision or confirmation in terminal with the platform question tool
   - Keep `## Pre-display quality gate` and downstream sections in place.

4. **Rerun `node tests/brainstorm-server/visual-companion-contract.test.js` until GREEN and record the evidence.**
   - Expect the test to fail one missing anchor at a time; fixing the first failure will likely reveal the next.
   - This is the required GREEN side of **R040** for S02.

5. **Do not broaden scope into S03 or S04.**
   - The review checklist and reviewer prompt are still generic by design; that is S03's work.
   - Wireframe appendix guidance remains S04.
   - Runtime/helper/frame-template files stay out of scope.

## Don't Hand-Roll

| Problem | Existing Solution | Why Use It |
|---------|------------------|------------|
| Proving the new protocol wording is real rather than implied | `tests/brainstorm-server/visual-companion-contract.test.js` | S01 already added section-scoped M003 anchors, so S02 can close on a mechanical GREEN rerun instead of subjective prose review. |
| Naming the regression family consistently | `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md` | The four scenario names already define the vocabulary S02 should mirror across the two workflow docs. |
| Keeping wording aligned with existing brainstorming evolution style | `skills/brainstorming/references/test-scenarios.md` | Scenarios 7 and 8 already show the repo's pressure-scenario idiom for visual routing and question-tool discipline. |
| Enforcing RED→GREEN discipline for doc edits | `skills/writing-skills/SKILL.md` plus `skills/test-driven-development/SKILL.md` | They explicitly require watching the failure first, then rerunning to prove the change, which is exactly what S02 needs to finish R040 honestly. |

## Existing Code and Patterns

- `skills/brainstorming/SKILL.md` — already says acceptance makes the browser available without forcing every later turn into browser use, and already says visual questions must be materially easier to judge by seeing than by reading. Missing: the explicit first later qualifying visual turn startup rule, explicit terminal prompt continuity after earlier browser use, and explicit degraded fallback naming for tool unavailability.
- `skills/brainstorming/visual-companion.md` — already has the archetype contract, first-use design-context workflow, pre-display quality gate, and runtime boundary. Missing: the per-turn sequence that makes the artifact viewable before the terminal decision prompt.
- `tests/brainstorm-server/visual-companion-contract.test.js` — now contains the exact M003 success anchors. Notably, it expects them in specific sections: `SKILL.md`'s `## Visual companion` block and `visual-companion.md`'s `## Per-question decision rule` block.
- `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md` — already names the four protocol pressures in the same order S02 should satisfy them: first-turn startup, artifact-first sequencing, question-tool continuity, and explicit degraded fallback.
- `skills/brainstorming/references/test-scenarios.md` — scenarios 7 and 8 establish the older baseline: offer the companion as its own message only when visuals would help, and use the platform question tool when available. S02 should extend that logic, not contradict it.
- `skills/brainstorming/references/spec-review-checklist.md` and `skills/brainstorming/spec-document-reviewer-prompt.md` — still generic. That is useful context because it confirms S02 should not try to solve review-loop enforcement yet.

## Constraints

- **Keep scope above runtime.** Do not change `skills/brainstorming/scripts/server.cjs`, `helper.js`, or `frame-template.html`.
- **Preserve the browser-optional model.** Acceptance still makes the browser available; it does not turn the session into browser mode.
- **Preserve terminal primacy.** Even on qualifying visual turns, reasoning and confirmation remain terminal-led.
- **Preserve the four-archetype and `data-choice` boundary.** No new archetypes, no new required metadata.
- **Respect the parser boundaries in the contract test.** The test slices exact markdown sections by headings, so renaming or moving `## Visual companion`, `## Per-question decision rule`, or `## Pre-display quality gate` carelessly can create parser failures unrelated to protocol quality.
- **Expect short-circuit failures.** The contract test stops at the first missing anchor, so S02 should rerun after each wording pass or deliberately add all expected anchors in one edit.
- **Keep S03 and S04 work out of band.** Review-loop hardening and wireframe appendix guidance are downstream slices.

## Common Pitfalls

- **Treating the current RED failure as only an `SKILL.md` issue** — the test will likely reveal more missing anchors after the first fix, especially in `visual-companion.md`'s per-question protocol section.
- **Reorganizing headings while adding wording** — the parser is section-scoped, so structural cleanup can accidentally create new failures.
- **Writing a general artifact-first principle without the explicit sequence** — the contract test expects ordered language, not just a high-level statement.
- **Assuming the question-tool continuity rule is already covered by general brainstorming guidance** — the repo already prefers the platform question tool broadly, but S02 needs it restated inside the visual-companion protocol for qualifying visual turns after earlier browser use.
- **Forgetting to name fallback as degraded behavior** — the current docs already allow plain-text fallback in some places, which makes it easy to add a soft restatement instead of the explicit degraded wording R037 requires.
- **Drifting into review-asset edits too early** — the checklist and reviewer prompt are supposed to stay generic until S03 hardens them against the named scenario family.

## Open Risks

- The strongest risk is false closure after the first GREEN-looking doc edit. Because the contract test fails fast, S02 can appear nearly done while still hiding later missing anchors.
- Some needed language already exists elsewhere in `visual-companion.md`'s `Start and loop` steps, but the test expects it under `## Per-question decision rule`; moving text instead of mirroring it carefully may weaken other validated guidance.
- Over-literal copy from the pressure-scenario artifact could satisfy the test but read awkwardly in the workflow docs. S02 should mirror the outcomes tightly while still keeping the docs readable.
- If wording changes accidentally dilute the earlier M001/M002 guarantees, S02 could regress validated routing, degraded-mode, or compatibility language while chasing the new anchors.

## Skills Discovered

| Technology | Skill | Status |
|------------|-------|--------|
| Skill-document validation | `writing-skills` | installed / available |
| TDD process discipline | `test-driven-development` | installed / available |
| Node.js contract-test work | `wshobson/agents@nodejs-backend-patterns` | none installed; promising via `npx skills add wshobson/agents@nodejs-backend-patterns` |

## Sources

- `skills/brainstorming/SKILL.md` — current brainstorming entrypoint already preserves browser-optional, genuinely-visual routing, and general question-tool preference, but lacks the explicit M003 startup/continuity/fallback anchors inside `## Visual companion`.
- `skills/brainstorming/visual-companion.md` — current guide already preserves archetypes, degraded design-context handling, and the pre-display gate, but lacks the exact artifact-first sequence inside `## Per-question decision rule`.
- `tests/brainstorm-server/visual-companion-contract.test.js` — authoritative authored proof surface for S02; now expects exact M003 phrases and ordering inside specific markdown sections.
- `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md` — named regression family and required outcome vocabulary for the S02 doc edits.
- `skills/brainstorming/references/test-scenarios.md` — existing pressure-scenario style, especially Scenario 7 (`visuals would help`) and Scenario 8 (`platform question tool`).
- `skills/writing-skills/SKILL.md` — explicit instruction that skill/doc changes must follow a failing-test-first RED→GREEN loop.
- `skills/test-driven-development/SKILL.md` — foundational requirement to watch the test fail first; useful here because S02 is closing an already-established authored RED baseline.
- `skills/brainstorming/references/spec-review-checklist.md` and `skills/brainstorming/spec-document-reviewer-prompt.md` — confirmed still generic, reinforcing that S03 remains the review-hardening slice.
- Local verification: `node tests/brainstorm-server/visual-companion-contract.test.js` currently fails with `Expected SKILL.md first qualifying visual turn startup rule to include "the first later genuinely visual question must start the companion path instead of remaining terminal-only."`
- Local skill discovery: `npx skills find "Node.js"` surfaced `wshobson/agents@nodejs-backend-patterns` as the highest-install-count directly relevant external skill candidate.
