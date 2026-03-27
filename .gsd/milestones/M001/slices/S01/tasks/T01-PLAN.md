# T01: Codify the comparison-first authoring contract

**Slice:** S01 — Authoring contract and archetype kit
**Milestone:** M001

## Description

Lock the authoring contract before any examples or downstream styling work. This task rewrites the brainstorming guidance so the visual companion is explicitly comparison-first, defines exactly four archetypes, requires `/frontend-design` or `$frontend-design` for screen structuring, and documents the bounded first-use design-context workflow plus the fragment/full-document compatibility boundary.

## Steps

1. Rewrite `skills/brainstorming/visual-companion.md` around the four v1 archetypes instead of the current generic visual-pattern framing.
2. Add the explicit screen-creation rule that companion screens route through `/frontend-design` or `$frontend-design` and explain that this is a structuring pass for brainstorming, not a near-final mockup requirement.
3. Document the first-use workflow in the required order: existing instruction context, repo design-context source if present, one-time minimal session capture, else explicit degraded mode.
4. Update `skills/brainstorming/SKILL.md` so the brainstorming entrypoint points future agents at the same contract and compatibility boundary.

## Must-Haves

- [x] Exactly four archetypes are named and described consistently in the guide.
- [x] The `/frontend-design` / `$frontend-design` rule, bounded first-use workflow, degraded mode, and fragment/full-document boundary are explicit in both documentation entrypoints.

## Verification

- `rg -n "side-by-side comparison|ranked alternatives|annotated recommendation|carry-forward summary|/frontend-design|\$frontend-design|degraded mode|full-document|data-choice" skills/brainstorming/visual-companion.md skills/brainstorming/SKILL.md`
- Manual read-through confirms the workflow order is instruction context → repo context if present → one-time session capture → degraded mode.

## Inputs

- `skills/brainstorming/visual-companion.md` — current guidance that needs to be tightened into the comparison-first contract
- `skills/brainstorming/SKILL.md` — brainstorming skill entrypoint that must surface the same authoring rule
- `skills/brainstorming/scripts/server.cjs` — existing fragment/full-document runtime boundary the docs must preserve
- `skills/brainstorming/scripts/helper.js` — existing `data-choice` metadata boundary the docs must not exceed
- `S01-RESEARCH.md` summary — identifies the missing contract language and bounded workflow this task must codify

## Observability Impact

- **Signals changed:** none at runtime; this task changes documentation contracts only.
- **Signals clarified for future inspection:** docs now explicitly point future agents to `state/server-info`, `state/events`, and `state/server-stopped` as the runtime evidence surfaces behind the authoring contract.
- **Failure state visibility:** contract drift becomes visible through grep/manual-read checks and the companion contract regression test (once present), rather than implicit interpretation.
- **Redaction/logging constraints:** keep examples synthetic; do not add required metadata beyond `data-choice` or describe logging patterns that include secrets.

## Expected Output

- `skills/brainstorming/visual-companion.md` — rewritten comparison-first contract with four archetypes, explicit `frontend-design` workflow, degraded mode, and compatibility language
- `skills/brainstorming/SKILL.md` — entrypoint guidance aligned to the same contract
