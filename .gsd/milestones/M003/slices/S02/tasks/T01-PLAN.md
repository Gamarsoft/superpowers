---
estimated_steps: 5
estimated_files: 3
---

# T01: Mirror the M003 protocol rules into the authored workflow docs

**Slice:** S02 — Protocol wording hardening and GREEN rerun
**Milestone:** M003

## Description

Add the smallest doc changes that make the visual-companion protocol explicit in the two parser-sensitive workflow sections without changing scope or structure.

## Steps

1. Read `skills/brainstorming/SKILL.md` (`## Visual companion`) and `skills/brainstorming/visual-companion.md` (`## Per-question decision rule`) alongside `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md`.
2. Update `SKILL.md` so it explicitly says the first later genuinely visual question starts the companion path after consent, and later qualifying visual turns still end with a dedicated terminal question-tool prompt.
3. Update `visual-companion.md` so the per-question protocol is explicitly artifact-first: author or refresh the artifact first, make it viewable, tell the user what they are seeing and what decision it supports, then ask the terminal confirmation question.
4. Name the degraded fallback explicitly for question-tool unavailability while preserving the browser-optional and terminal-primary model.
5. Read back the edited sections and confirm the wording stays mirrored and the section headings remain unchanged.

## Must-Haves

- [ ] `skills/brainstorming/SKILL.md` explicitly covers first-turn startup, question-tool continuity, and degraded fallback inside `## Visual companion`.
- [ ] `skills/brainstorming/visual-companion.md` explicitly covers the artifact-first sequence inside `## Per-question decision rule`.

## Verification

- Read back `skills/brainstorming/SKILL.md` (`## Visual companion`) and confirm it names first-turn startup, later-turn question-tool continuity, and degraded fallback.
- Read back `skills/brainstorming/visual-companion.md` (`## Per-question decision rule`) and confirm the artifact is created or refreshed before the terminal decision prompt is asked.

## Inputs

- `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md` — the named M003 protocol outcomes this wording must mirror
- `skills/brainstorming/SKILL.md` — existing visual-companion routing and workflow wording that must stay parser-compatible
- `skills/brainstorming/visual-companion.md` — existing per-question protocol section that must become explicitly artifact-first

## Expected Output

- `skills/brainstorming/SKILL.md` — updated `## Visual companion` section with explicit startup, continuity, and degraded-fallback wording
- `skills/brainstorming/visual-companion.md` — updated `## Per-question decision rule` section with the explicit artifact-first sequence

## Observability Impact

- Signals changed: the authored protocol now makes startup, artifact-first sequencing, question-tool continuity, and degraded fallback explicit in the parser-sensitive sections instead of leaving those outcomes implicit.
- How to inspect later: read `skills/brainstorming/SKILL.md` (`## Visual companion`) and `skills/brainstorming/visual-companion.md` (`## Per-question decision rule`), then run `node tests/brainstorm-server/visual-companion-contract.test.js` to confirm the contract still finds the expected anchors.
- Failure visibility: if wording drifts, the contract test fail-fast output should identify the first missing authored anchor so a future agent can see whether the gap is startup, artifact-first sequencing, question-tool continuity, or degraded fallback.
