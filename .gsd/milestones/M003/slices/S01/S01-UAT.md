# S01: Named pressure scenarios and RED proof surface — UAT

**Milestone:** M003
**Written:** 2026-03-30

## UAT Type

- UAT mode: artifact-driven
- Why this mode is sufficient: S01 only adds authored proof surfaces and a named regression artifact. No runtime, helper, or browser behavior changes are in scope.

## Preconditions

- Worktree includes the S01 changes.
- `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md` exists.
- Node is available so `node tests/brainstorm-server/visual-companion-contract.test.js` can run.

## Smoke Test

Run `node tests/brainstorm-server/visual-companion-contract.test.js`.

**Expected:** The command exits nonzero on an M003 protocol-wording failure in `skills/brainstorming/SKILL.md`, not on a missing artifact or parser error.

## Test Cases

### 1. Pressure-scenario artifact names the full M003 regression family

1. Open `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md`.
2. Confirm the file contains these exact `##` scenario headings, in order:
   - `first qualifying visual turn starts the companion path`
   - `artifact-first sequencing before the terminal prompt`
   - `question-tool continuity after earlier browser use`
   - `explicit degraded fallback when the question tool is unavailable`
3. For each scenario, confirm the file includes these exact `###` subsections:
   - `Setup`
   - `Required outcome`
   - `Failure signature`
   - `Why current docs miss this`
4. In each `Failure signature` block, confirm the text includes an explicit `Failure if:` list.
5. **Expected:** The artifact is complete, ordered, and reusable as a named non-regression reference for later protocol and review work.

### 2. Contract harness advances past missing-file RED into missing-protocol-wording RED

1. Run `node tests/brainstorm-server/visual-companion-contract.test.js`.
2. Confirm the command exits with code `1`.
3. Confirm the failure output includes:
   - `FAIL: visual companion contract + archetype kit assertions failed`
   - `Expected SKILL.md first qualifying visual turn startup rule to include "the first later genuinely visual question must start the companion path instead of remaining terminal-only."`
4. Confirm the output does **not** say the pressure-scenario artifact is missing.
5. **Expected:** The authored-contract surface is intentionally RED for the real M003 wording gap, giving S02 a stable starting point.

## Edge Cases

### Final pressure-scenario section still parses cleanly

1. Keep the same S01 artifact in place.
2. Run `node tests/brainstorm-server/visual-companion-contract.test.js` again.
3. Confirm the failure remains the named `SKILL.md` wording gap instead of a parser error, missing final section, or malformed heading complaint.
4. **Expected:** The last H2 section (`explicit degraded fallback when the question tool is unavailable`) is parsed reliably, so the harness stays focused on authored protocol drift.

## Failure Signals

- `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md` is missing.
- Any of the four named scenario headings is absent, reordered, or missing one of the required H3 blocks.
- `Failure if:` language is missing from a scenario's failure-signature block.
- `node tests/brainstorm-server/visual-companion-contract.test.js` passes green in S01.
- The contract test fails on a missing-file message or parser error instead of the named missing-protocol-wording baseline.

## Requirements Proved By This UAT

- R038 — Proves the named pressure-scenario artifact exists and is wired into the authored-contract RED surface.

## Not Proven By This UAT

- R034, R035, R036, and R037 — This slice does not yet make the protocol wording pass.
- Any live runtime behavior — S01 stays above server, helper, and frame-template scope.
- R039 and R041 — Review-loop hardening and selective wireframe appendix guidance are deferred to later slices.

## Notes for Tester

The RED result is the expected success condition for S01. Do not treat the nonzero exit as a failure if it points at the named `SKILL.md` protocol wording gap. This slice is complete only when the missing-artifact condition is gone and the remaining failure is the intentional authored baseline for S02.
