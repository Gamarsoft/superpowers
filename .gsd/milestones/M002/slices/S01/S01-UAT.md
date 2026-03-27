# S01: Routing, quality gate, and active example refresh — UAT

**Milestone:** M002
**Written:** 2026-03-29

## UAT Type

- UAT mode: artifact-driven
- Why this mode is sufficient: S01 closes on authored guidance, example fragments, and contract/regression proof; live companion runtime corroboration is intentionally deferred to S02.

## Preconditions

- Repository is at the completed S01 worktree.
- Node.js is available in the shell.
- The tester can read the authored files under `skills/brainstorming/` and run the regression scripts from the repo root.

## Smoke Test

Run `node tests/brainstorm-server/visual-companion-contract.test.js`.

**Expected:** The script passes and confirms the visual-companion contract plus archetype-kit assertions without naming any missing routing, checklist, or boundary wording.

## Test Cases

### 1. Routing rule and quality gate are explicit

1. Run `node tests/brainstorm-server/visual-companion-contract.test.js`.
2. Open `skills/brainstorming/SKILL.md` and inspect the `## Visual companion` section.
3. Open `skills/brainstorming/visual-companion.md` and inspect `## Per-question decision rule` and `## Pre-display quality gate`.
4. **Expected:**
   - The contract test passes.
   - `SKILL.md` says the browser is for questions materially easier to judge by seeing than by reading.
   - Conceptual, scope, and text-first turns are explicitly told to stay in terminal.
   - `visual-companion.md` contains the named `Pre-display quality gate` section with ordered checklist items, the exact `No placeholder screens.` rule, and the instruction to revise the artifact or stay in terminal when the gate fails.

### 2. Active example refresh boundary is narrow and explicit

1. Open `skills/brainstorming/visual-companion.md`.
2. Navigate to `### Active example refresh boundary (M002)`.
3. Verify the block names only:
   - `side-by-side-comparison.html`
   - `ranked-alternatives.html`
   - `annotated-recommendation.html`
4. Verify `carry-forward-summary.html` is described as out of scope unless a direct contradiction is found.
5. **Expected:** The guide makes the refresh boundary explicit and keeps the carry-forward example outside the S01 refresh set.

### 3. Refreshed examples are concrete and decision-capable

1. Open `skills/brainstorming/examples/visual-companion/side-by-side-comparison.html`.
2. Confirm it presents a real comparison about the first Stripe connection flow, with materially different layout directions and visible trade-offs.
3. Open `skills/brainstorming/examples/visual-companion/ranked-alternatives.html`.
4. Confirm it ranks release-note entry points against a concrete judgment axis and keeps lower-ranked trade-offs readable.
5. Open `skills/brainstorming/examples/visual-companion/annotated-recommendation.html`.
6. Confirm it carries forward a concrete settings information-architecture recommendation with rationale and known constraints.
7. **Expected:** None of the three files reads like generic labeled boxes or placeholder prose; each gives enough visual structure and subject matter to support a real decision.

## Edge Cases

### Existing carry-forward artifact stays untouched and still valid

1. Run `node tests/brainstorm-server/carry-forward-behavior.test.js`.
2. Optionally inspect `skills/brainstorming/examples/visual-companion/carry-forward-summary.html` to confirm it was not part of the active refresh.
3. **Expected:** The carry-forward behavior test passes, proving the untouched carry-forward example still preserves chosen, still-open, and degraded-mode continuity states.

### Shared fragment defaults still accept the refreshed examples

1. Run `node tests/brainstorm-server/fragment-comparison-defaults.test.js`.
2. **Expected:** The test passes, showing the refreshed fragments still render within the existing fragment-shell comparison defaults and did not require runtime or metadata changes.

## Failure Signals

- `visual-companion-contract.test.js` fails with a named assertion about missing routing language, checklist labels, placeholder-screen ban, or active-example boundary wording.
- The guide lists `carry-forward-summary.html` as part of the refresh set or omits the boundary block entirely.
- Any refreshed example falls back to generic labels, placeholder boxes, or prose that does not expose a visually judgeable trade-off.
- `carry-forward-behavior.test.js` or `fragment-comparison-defaults.test.js` fails after the example refresh.

## Requirements Proved By This UAT

- R013 — Proves the authored routing rule keeps non-genuinely-visual turns in terminal.
- R014 — Proves the pre-display checklist is explicit and committed.
- R015 — Proves placeholder screens are forbidden and failed checks force fallback.
- R016 — Proves the active example refresh boundary stayed explicit and narrow.
- R017 — Proves the three active examples are concrete decision-capable starting points.
- R018 — Proves flow-style comparison use remains conditional on genuinely visual, concrete structure.

## Not Proven By This UAT

- R019 — This UAT does not prove the unchanged runtime/archetype contract through the real entrypoint; S02 must do that with live acceptance and lifecycle checks.
- Any new runtime behavior, metadata schema, or helper/server changes, because S01 intentionally did not introduce them.

## Notes for Tester

Treat this as an artifact-quality and contract-proof review, not a live browser session. If you see a failure, start with the named assertion in the failing test output; S01’s regression surfaces were designed to tell you exactly which authored section or boundary drifted.
