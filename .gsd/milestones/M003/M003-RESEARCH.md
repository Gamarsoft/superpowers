# M003 — Research

**Date:** 2026-03-30

## Summary

M003 should start by proving the **current gap**, not by rewriting docs on faith. Today the two strongest automated surfaces tell an important story: `node tests/brainstorm-server/visual-companion-contract.test.js` passes, and `node tests/brainstorm-server/live-companion-acceptance.test.js` passes, yet the named protocol-regression artifact does not exist and the authored/review surfaces still do not explicitly cover first-visual-turn startup, artifact-first sequencing, terminal question-tool continuity after browser use, or explicit degraded fallback wording. That means the thin runtime is still healthy, but the current docs-and-review layer can remain green while the exact live-use failure family slips through.

The primary recommendation is to treat **R034-R037 as table stakes**, **R038-R040 as the proof harness that makes those rules durable**, and **R041 as narrow follow-on guidance** that should land only after the protocol contract is explicit. Reuse the repo’s existing strict authored-contract pattern instead of hand-rolling a new verification approach: the current contract test already parses markdown structure precisely, `skills/brainstorming/references/test-scenarios.md` already establishes the pressure-scenario idiom, and the live acceptance test remains the runtime tie-breaker proving this milestone should stay above `server.cjs`, `helper.js`, and the frame template.

A candidate requirement emerged from research, but it should stay **advisory until approved**: extend `tests/brainstorm-server/visual-companion-contract.test.js` so the new protocol anchors and the named pressure-scenario artifact become mechanically checkable. Without that, M003 would improve prose and review prompts but still leave the strongest automated authored-surface proof blind to the new regression family.

## Recommendation

Prove the milestone in this order:

1. **RED first:** record a baseline failure against the real brownfield regression family before editing `skills/brainstorming/SKILL.md` or `skills/brainstorming/visual-companion.md`, per `writing-skills` + `test-driven-development`.
2. **Harden the two authoritative workflow docs:** make the first later genuinely visual turn start the companion path, require artifact-first sequencing, preserve terminal question-tool continuity, and make degraded fallback explicit when the tool is unavailable.
3. **Make review and authored-proof surfaces fail on drift:** add the named `visual-companion-protocol-pressure-scenarios.md`, update the spec review checklist and reviewer prompt, and preferably extend the existing authored-contract regression so the new protocol is not review-only.
4. **Add wireframe appendix guidance last and keep it narrow:** only for durable spatial decisions, low-fidelity only, and no handoff-template expansion beyond allowing a handoff to reference an already-existing appendix.

Why this order: it matches the existing decision boundary in D026, respects the `writing-skills` RED→GREEN expectation, preserves the already-green runtime contract, and keeps R041 from diluting the core operability fix.

## Don't Hand-Roll

| Problem | Existing Solution | Why Use It |
|---------|------------------|------------|
| Precise drift detection for brainstorming docs | `tests/brainstorm-server/visual-companion-contract.test.js` | It already uses section-scoped parsing and ordered assertions instead of loose phrase matching, which is the right pattern for locking M003 protocol wording too. |
| Pressure-scenario structure for skill evolution | `skills/brainstorming/references/test-scenarios.md` plus `skills/writing-skills/SKILL.md` | The repo already treats skill changes as pressure-tested documentation, so M003 should add a named scenario artifact rather than inventing a new testing style. |
| Runtime proof that stays above helper/server changes | `tests/brainstorm-server/live-companion-acceptance.test.js` | It already proves the real start/stop entrypoint, fragment shell, event persistence/clearing, and full-document passthrough; use it as the unchanged-runtime tie-breaker. |
| Review gating for spec + handoff quality | `skills/brainstorming/references/spec-review-checklist.md` and `skills/brainstorming/spec-document-reviewer-prompt.md` | These are the existing review surfaces; M003 should sharpen them around the named regression family instead of creating a parallel review flow. |

## Existing Code and Patterns

- `skills/brainstorming/SKILL.md` — authoritative per-turn workflow. It already says acceptance does not force browser use and already prefers the platform question tool, but it does **not yet** explicitly say the first later genuinely visual turn must start the companion path, nor that every qualifying visual turn is artifact-first before the terminal decision prompt.
- `skills/brainstorming/visual-companion.md` — authoritative companion-side guide. It already has the four archetypes, the pre-display quality gate, the degraded-mode design-context workflow, and the runtime boundary. What is missing is the explicit per-turn sequencing contract: artifact viewable first, then terminal question, plus question-tool continuity and named degraded fallback when the tool is unavailable.
- `skills/brainstorming/references/test-scenarios.md` — existing pressure-scenario pattern. Scenarios 7 and 8 are especially relevant because they already cover “visuals would help” and “platform question tool” pressure, which means M003’s new named scenario artifact should extend a known idiom rather than start from zero.
- `skills/writing-skills/SKILL.md` — the governing process skill for docs edits. It makes the RED baseline mandatory and explicitly maps pressure scenarios to TDD. M003 should follow this literally, not rhetorically.
- `skills/test-driven-development/SKILL.md` — the prerequisite discipline. Its value here is not code testing per se, but the insistence on watching the test fail before changing the behavior spec.
- `skills/brainstorming/references/spec-review-checklist.md` — currently generic and useful, but too broad to catch the exact M003 regression family unless updated with named checks.
- `skills/brainstorming/spec-document-reviewer-prompt.md` — currently directs good general review, but it does not yet tell the reviewer to look for first-visual-turn startup, artifact-first sequencing, terminal confirmation continuity, or explicit degraded fallback wording.
- `skills/brainstorming/references/spec-template.md` — already encourages appendices for nuanced work, which is the right insertion point for selective low-fidelity wireframe guidance. It currently says nothing about when a spatial appendix is useful or how narrow it should stay.
- `skills/brainstorming/references/gsd-handoff-template.md` — important boundary reference because M003 explicitly wants handoff-link allowance **without** reopening the template itself.
- `tests/brainstorm-server/visual-companion-contract.test.js` — a useful surprise: it is stricter than a grep test and therefore the best reusable automated proof surface for new authored-contract anchors.
- `tests/brainstorm-server/live-companion-acceptance.test.js` — still the runtime tie-breaker. Current green results support the milestone’s “docs-and-review first” boundary.

## Constraints

- The runtime boundary is real: M003 must not change `skills/brainstorming/scripts/server.cjs`, `helper.js`, or `frame-template.html`.
- Browser use remains optional and per-question; acceptance is not a mode switch.
- Terminal stays the primary reasoning and confirmation channel even when browser events exist.
- The four-archetype surface and `data-choice` metadata boundary remain unchanged.
- `writing-skills` makes the RED baseline mandatory for skill/doc edits; skipping the failing scenario would violate the project’s own process rule.
- Root `package.json` has no runtime dependencies for this milestone, and the brainstorm test area depends only on `ws`, so M003 is not blocked on framework churn.

## Common Pitfalls

- **Treating the current green contract test as proof that M003 is already covered** — it is not. The test currently passes while the named pressure-scenario file is missing and the new protocol family is not asserted.
- **Editing workflow docs before running the RED baseline scenario** — that would violate both `writing-skills` and `test-driven-development`, and it would remove the strongest evidence that the docs change fixed the right failure.
- **Letting appendix guidance define the protocol indirectly** — wireframe appendices are useful, but R041 is support work. If it lands before the core protocol rules, the slice can look “complete” while the main live-use regression is still under-specified.
- **Smuggling runtime ambitions into wording work** — the live acceptance test is green, which is a strong signal to keep this slice above runtime unless the same scenario still fails after docs hardening.
- **Making degraded fallback too implicit** — current `SKILL.md` only says to fall back to plain text when the tool is unavailable. M003 needs explicit degraded wording so freeform handling does not become silent policy drift.
- **Turning selective wireframes into a new archetype or routine deliverable** — `spec-template.md` should allow narrow appendix usage, not create appendix churn or a fifth companion mode.

## Open Risks

- The largest operational risk is false confidence: because the current contract and live runtime tests already pass, M003 can appear “small” while still missing the exact regression family that motivated it.
- If the new pressure scenarios are too abstract, future edits may satisfy the words without preserving the actual sequence: consent → genuinely visual turn → artifact viewable → terminal decision prompt.
- If review assets are tightened but the authored-contract regression is not, the strongest automated surface may remain blind and future drift could re-enter between human review passes.
- Wireframe appendix guidance can sprawl unless it is explicitly tied to durable spatial decisions, low fidelity, and existing appendix linkage only.

## Skills Discovered

| Technology | Skill | Status |
|------------|-------|--------|
| Skill-document validation | `writing-skills` | installed / available |
| TDD process discipline | `test-driven-development` | installed / available |
| Node.js / JS repo surfaces | `wshobson/agents@nodejs-backend-patterns` | none installed; promising via `npx skills add wshobson/agents@nodejs-backend-patterns` |
| Browser acceptance / Playwright-style verification | `currents-dev/playwright-best-practices-skill@playwright-best-practices` | none installed; promising via `npx skills add currents-dev/playwright-best-practices-skill@playwright-best-practices` |

## Sources

- The current brainstorming workflow already prefers the platform question tool and already keeps visual companion use per-question, but it only has a generic plain-text fallback and does not yet spell out M003’s artifact-first / first-later-visual-turn protocol (source: `skills/brainstorming/SKILL.md`).
- The current companion guide already has the four archetypes, pre-display gate, degraded design-context workflow, and runtime boundary, but it does not yet encode the full M003 sequencing and terminal-confirmation continuity rules (source: `skills/brainstorming/visual-companion.md`).
- The existing skill-evolution pressure-scenario pattern is already documented, including visual-companion and platform-question-tool scenarios, so M003 should build a named scenario artifact on top of that pattern (source: `skills/brainstorming/references/test-scenarios.md`).
- `writing-skills` explicitly requires a RED baseline scenario before skill edits, and `test-driven-development` explicitly requires watching the failure first; M003’s validation loop should inherit that standard directly (source: `skills/writing-skills/SKILL.md`, `skills/writing-skills/testing-skills-with-subagents.md`, `skills/test-driven-development/SKILL.md`).
- The current spec review checklist and reviewer prompt are broad but generic; they do not yet name the M003 regression family directly (source: `skills/brainstorming/references/spec-review-checklist.md`, `skills/brainstorming/spec-document-reviewer-prompt.md`).
- The current spec template already allows appendices for nuanced work, making it the right place for selective low-fidelity wireframe appendix guidance; the handoff template should remain unchanged in this slice (source: `skills/brainstorming/references/spec-template.md`, `skills/brainstorming/references/gsd-handoff-template.md`).
- The named pressure-scenario artifact is currently missing, which is direct evidence that R038 is not yet represented in the repo (source: `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md` absent during local inspection).
- Today’s local verification still shows the thin runtime is green: `node tests/brainstorm-server/visual-companion-contract.test.js` and `node tests/brainstorm-server/live-companion-acceptance.test.js` both passed, which supports keeping M003 above runtime changes (source: local verification run on 2026-03-30).
- The design spec and GSD handoff already agree on slice ordering: protocol hardening first, review pressure second, appendix guidance last, runtime follow-up only if the same live scenario still fails afterward (source: `docs/superpowers/specs/2026-03-30--brainstorming-visual-companion-protocol-hardening.md`, `docs/superpowers/specs/2026-03-30--brainstorming-visual-companion-protocol-hardening--gsd-handoff.md`).
