# S02: Fragment comparison defaults — UAT

**Milestone:** M001
**Written:** 2026-03-28

## UAT Type

- UAT mode: artifact-driven
- Why this mode is sufficient: S02 only changes shared fragment-frame presentation defaults and regression proof surfaces; it does not introduce new workflow logic or require live human judgment to prove the compatibility boundary.

## Preconditions

- Run from the repo root: `/Users/gamarsoft/.codex/superpowers`
- Node.js is available
- The S01 archetype example files and `skills/brainstorming/scripts/frame-template.html` exist in the working tree
- No local changes are needed beyond the shipped S02 implementation

## Smoke Test

Run:

1. `node tests/brainstorm-server/fragment-comparison-defaults.test.js`
2. **Expected:** the command exits successfully and reports that fragment comparison defaults cover ranking, recommendation, carry-forward, and the full-document boundary.

## Test Cases

### 1. Wrapped fragments expose the comparison shell, full documents do not

1. Run `cd tests/brainstorm-server && node server.test.js`
2. Inspect the `HTTP Serving` assertions in the output.
3. **Expected:** `wraps content fragments in frame template` passes.
4. **Expected:** `serves full HTML documents as-is (not wrapped)` passes.
5. **Expected:** the overall results end with `26 passed, 0 failed`.

### 2. Ranked and recommendation fragments get shared comparison emphasis by default

1. Run `node tests/brainstorm-server/fragment-comparison-defaults.test.js`
2. Confirm the test completes successfully.
3. Open `tests/brainstorm-server/fragment-comparison-defaults.test.js` and verify it asserts wrapped output for the ranked and annotated-recommendation fixtures.
4. **Expected:** the test proves the fragment-shell marker is present on wrapped fragments.
5. **Expected:** the test proves selector surfaces for ranking/current-winner emphasis are present in wrapped HTML.
6. **Expected:** the test contains the guard that lower-ranked options must remain readable instead of being dimmed via `.option:not(.selected)` opacity suppression.

### 3. Carry-forward fragments scan clearly without changing runtime behavior

1. Run `node tests/brainstorm-server/fragment-comparison-defaults.test.js`
2. Confirm the carry-forward fixture path is exercised by the regression.
3. Run `cd tests/brainstorm-server && node ws-protocol.test.js`
4. **Expected:** the fragment-default regression passes its carry-forward selector checks.
5. **Expected:** the WebSocket protocol suite still ends with `31 passed, 0 failed`, showing S02 did not alter the browser/event contract.

## Edge Cases

### Full-document compatibility boundary

1. Run:
   `node -e "const fs=require('fs');const hook='data-comparison-kit=\"fragment-shell\"';const template=fs.readFileSync('skills/brainstorming/scripts/frame-template.html','utf8');if(!template.includes(hook)){throw new Error('Missing fragment-only shell hook '+hook);}console.log(JSON.stringify({check:'fragment-shell-hook',status:'present',hook}));"`
2. Then run `node tests/brainstorm-server/fragment-comparison-defaults.test.js`
3. **Expected:** the diagnostic reports the fragment-shell hook is present in the shared frame template.
4. **Expected:** the regression still passes its negative full-document assertions, proving the hook stays fragment-only and does not contaminate passthrough documents.

## Failure Signals

- `fragment-comparison-defaults.test.js` fails with a missing fragment-shell marker, missing ranking/recommendation/carry-forward selector proof, or a lower-ranked readability regression
- `server.test.js` fails on wrapped fragments or on full-document passthrough expectations
- `ws-protocol.test.js` fails, indicating the slice accidentally altered runtime protocol behavior
- The standalone `node -e` diagnostic throws `Missing fragment-only shell hook data-comparison-kit="fragment-shell"`

## Requirements Proved By This UAT

- R002 — Proves wrapped fragment screens make recommendation and alternatives easier to parse with shared-frame defaults.
- R003 — Proves ranked fragment screens show a visible current winner without hiding lower-ranked options.

## Not Proven By This UAT

- R004 — This slice does not prove chosen-versus-still-open carry-forward behavior across later screens.
- R005 — This slice does not prove terminal-first decision flow behavior.
- Full milestone end-to-end usability through the real companion entrypoint remains for S04.

## Notes for Tester

This slice is intentionally narrow. If the fragment-default regression passes but a live browser still feels ambiguous, treat that as follow-up evidence for S04 or a design-quality discussion, not as proof that S02’s runtime contract is broken. The authoritative boundary checks for this slice are the regression and server suites.
