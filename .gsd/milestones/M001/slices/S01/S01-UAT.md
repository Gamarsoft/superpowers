# S01: Authoring contract and archetype kit — UAT

**Milestone:** M001
**Written:** 2026-03-27

## UAT Type

- UAT mode: mixed
- Why this mode is sufficient: S01 shipped contract docs and example artifacts, but one live fragment-render check is still needed to prove the examples fit the current fragment runtime instead of only looking correct on disk.

## Preconditions

- The repo contains the S01 files under `skills/brainstorming/` and `tests/brainstorm-server/`.
- Node is available for the contract and server regression tests.
- For the live runtime check, the tester can start the local companion server and open the emitted localhost URL.

## Smoke Test

Run `node tests/brainstorm-server/visual-companion-contract.test.js`.

**Expected:** The command passes and confirms the guide, skill entrypoint, workflow wording, compatibility terms, and example-kit files still match the S01 contract.

## Test Cases

### 1. Contract and workflow stay explicit in the guidance

1. Open `skills/brainstorming/visual-companion.md` and `skills/brainstorming/SKILL.md`.
2. Confirm both files name exactly these four archetypes: `side-by-side comparison`, `ranked alternatives`, `annotated recommendation`, and `carry-forward summary`.
3. Confirm both files require `/frontend-design` or `$frontend-design` as the screen-structuring step.
4. Confirm the first-use workflow appears in bounded order: instruction context → repo design-context source if present → one-time minimal session capture → explicit degraded mode.
5. **Expected:** The two docs use the same contract language, include degraded mode, and keep the full-document compatibility plus `data-choice` boundary explicit.

### 2. The example kit stays copyable and archetype-specific

1. Check that these four files exist under `skills/brainstorming/examples/visual-companion/`:
   - `side-by-side-comparison.html`
   - `ranked-alternatives.html`
   - `annotated-recommendation.html`
   - `carry-forward-summary.html`
2. Search those files for `Recommended`, `Current winner`, `Still open`, `Chosen direction`, and `data-choice`.
3. Open `skills/brainstorming/visual-companion.md` and confirm it links to all four example files in archetype order with short “when to copy/adapt” notes.
4. **Expected:** Each archetype has one fragment file, the ranked and carry-forward examples use explicit decision-state language, and the examples stay within the existing metadata boundary.

### 3. A fragment example still renders inside the current runtime contract

1. Start the companion server with `skills/brainstorming/scripts/start-server.sh --project-dir /Users/gamarsoft/.codex/superpowers`.
2. Copy `skills/brainstorming/examples/visual-companion/ranked-alternatives.html` into the emitted `screen_dir` as the newest HTML file.
3. Open the local companion URL in a browser.
4. Confirm the shared frame renders the fragment and the page shows `Current winner`, `Recommended`, and a readable lower-ranked option.
5. **Expected:** The fragment renders inside the existing shared frame, helper behavior still works, and no new required metadata beyond `data-choice` is needed.

## Edge Cases

### Missing repo design context falls back honestly

1. Read the first-use workflow in `skills/brainstorming/visual-companion.md` as if no repo design-context source exists.
2. Confirm the guidance moves to explicit degraded mode instead of pretending `frontend-design` had context.
3. **Expected:** The workflow stays bounded and honest when repo context is unavailable.

### Full-document compatibility stays explicit, not implied

1. Review the compatibility language in `skills/brainstorming/visual-companion.md`.
2. Run `rg -n "server-stopped|watch-fallback|owner-pid-invalid|state/events" skills/brainstorming/scripts/server.cjs tests/brainstorm-server/server.test.js`.
3. **Expected:** The docs do not promise automatic comparison defaults for full-document screens, and the runtime diagnostics still point to the existing additive contract surfaces.

## Failure Signals

- `visual-companion-contract.test.js` fails on archetype names, workflow ordering, degraded-mode wording, compatibility terms, or example-kit presence.
- A guide file mentions new required metadata beyond `data-choice`.
- Any example file is missing, unlinked from the guide, or no longer contains the explicit status language for decision state.
- `server.test.js` or the diagnostic `rg` check no longer shows `state/events`, `server-stopped`, `watch-fallback`, or `owner-pid-invalid`.
- The live fragment check renders as a broken full document, skips the shared frame, or requires hidden workflow data to look correct.

## Requirements Proved By This UAT

- R001 — Proves the four-archetype authoring kit exists and is tied to concrete artifacts.
- R007 — Proves the explicit `/frontend-design` or `$frontend-design` routing rule is present in the authoring contract.
- R008 — Proves the first-use workflow order is documented and testable.
- R009 — Proves repo design-context reuse is part of the contract before one-time session capture.
- R012 — Proves the guide and examples are strong enough to copy consistently.

## Not Proven By This UAT

- R002, R003 — This slice does not yet add the shared-frame visual defaults for recommendation legibility or ranked treatment.
- R004, R005, R010, R011 — This slice does not yet prove live carry-forward behavior for click-assisted or terminal-only flows.
- R006 — This UAT checks compatibility boundaries and diagnostics, but full integrated compatibility proof remains for S04.

## Notes for Tester

S01 is contract-first. Expect explicit guidance, example artifacts, and regression checks, not final comparison styling. If `server.test.js` ever prints `--- Results: 26 passed, 0 failed ---` and then lingers, treat the success banner as the trustworthy signal and use a timeout wrapper rather than assuming the slice regressed.
