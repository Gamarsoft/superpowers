# Project

## What This Is

This project upgrades the Superpowers brainstorming visual companion so it stays a terminal-first design aid while the browser helps only when seeing the artifact makes the decision materially clearer.

## Core Value

Even if everything else gets cut, the companion must make visual decisions easier to judge without replacing terminal reasoning, recommendation, or confirmation.

## Current State

M001, M002, and M003 are complete.

The repo now has:

- a locked comparison-first companion contract with four v1 archetypes and copyable example artifacts
- stronger fragment defaults and carry-forward rules that preserved the existing runtime and full-document boundary
- hardened protocol wording for first qualifying visual-turn startup, artifact-first sequencing, terminal confirmation continuity, and explicit degraded fallback
- a named protocol pressure-scenario artifact at `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md`
- review-loop enforcement in `skills/brainstorming/references/spec-review-checklist.md` and `skills/brainstorming/spec-document-reviewer-prompt.md`
- selective durable wireframe appendix guidance in `skills/brainstorming/references/spec-template.md`, including the rule that later handoffs may link back to an existing appendix when relevant
- a milestone-level closure record at `.gsd/milestones/M003/M003-SUMMARY.md`

All currently active requirements are now validated. The remaining backlog is intentionally deferred.

## Architecture / Key Patterns

The architecture remains intentionally thin and runtime-stable. Authoring and workflow rules live in `skills/brainstorming/SKILL.md`, `skills/brainstorming/visual-companion.md`, and the shared reference templates. The main authored proof surface is `tests/brainstorm-server/visual-companion-contract.test.js`. The unchanged-runtime tie-breaker is `tests/brainstorm-server/live-companion-acceptance.test.js`. Review enforcement lives above runtime in the checklist and reviewer prompt, and durable-wireframe carry-forward now lives in the shared spec template rather than in runtime or handoff-template logic.

## Capability Contract

See `.gsd/REQUIREMENTS.md` for the explicit capability contract, requirement status, and coverage mapping.

## Milestone Sequence

- [x] M001: Comparison-First Visual Companion Upgrade — Make the existing visual companion materially better at side-by-side comparison, recommendation legibility, and carry-forward clarity without changing the terminal-first runtime contract.
- [x] M002: Visual Companion Routing and Authoring Quality — Tighten companion routing, commit the pre-display quality gate, and refresh the three active archetype examples without changing runtime behavior.
- [x] M003: Visual Companion Protocol Hardening — Harden first-visual-turn startup, artifact-first sequencing, terminal confirmation continuity, review pressure scenarios, and selective wireframe appendix guidance without changing runtime behavior.

## Next Planning Starting Point

There is no active milestone.

If work resumes, start from the deferred backlog and choose deliberately:

1. add runtime/helper enforcement only if the hardened docs-and-review path still misses the same live regression family (R042)
2. consider any new archetype or browser-native confirmation flow only as a separate product expansion (R043)
3. treat broader wireframe template/catalog work as separate follow-on scope rather than an implicit extension of M003 (R044)
