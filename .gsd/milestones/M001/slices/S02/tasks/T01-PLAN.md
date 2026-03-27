# T01: Lock the fragment-only proof surface

**Slice:** S02 — Fragment comparison defaults
**Milestone:** M001

## Description

Create the slice’s boundary proof before broad styling changes land. This task adds a stable fragment-only shell hook in the shared frame and a dedicated regression test that proves wrapped fragments receive the comparison-kit shell while full HTML documents remain passthrough-compatible.

## Steps

1. Add a stable fragment-only shell hook to `skills/brainstorming/scripts/frame-template.html` that is present on wrapped fragments but does not require any new author metadata.
2. Create `tests/brainstorm-server/fragment-comparison-defaults.test.js` to render representative fragment and full-document inputs through the existing server path and assert the hook appears only on wrapped fragments.
3. Extend `tests/brainstorm-server/server.test.js` only if needed so the fragment/full-document compatibility boundary stays covered next to the existing runtime assertions.

## Must-Haves

- [ ] Wrapped fragments expose a stable comparison-kit shell that tests can detect.
- [ ] Full-document passthrough remains unchanged by default, with a regression test that fails on contamination.

## Verification

- `node tests/brainstorm-server/fragment-comparison-defaults.test.js`
- `cd tests/brainstorm-server && node server.test.js`

## Observability Impact

- Signals added/changed: a new deterministic test surface for fragment-only comparison defaults and an explicit shell marker in wrapped fragment HTML.
- How a future agent inspects this: run `node tests/brainstorm-server/fragment-comparison-defaults.test.js`, then inspect `skills/brainstorming/scripts/frame-template.html` for the fragment-only hook and `tests/brainstorm-server/server.test.js` for the adjacent compatibility assertions.
- Failure state exposed: missing fragment shell, unexpected shell leakage into full-document responses, or broken fragment wrapping through the existing server path.

## Inputs

- `skills/brainstorming/scripts/frame-template.html` — current shared fragment wrapper that S02 must strengthen without affecting full documents
- `skills/brainstorming/scripts/server.cjs` — existing fragment/full-document routing boundary the test must exercise rather than replace
- `tests/brainstorm-server/server.test.js` — current compatibility regression coverage to keep adjacent and intact
- `skills/brainstorming/examples/visual-companion/*.html` — representative fragment surfaces created in S01 that the shared frame will wrap

## Expected Output

- `skills/brainstorming/scripts/frame-template.html` — stable fragment-only comparison shell hook
- `tests/brainstorm-server/fragment-comparison-defaults.test.js` — dedicated regression test for fragment-only defaults vs full-document passthrough
- `tests/brainstorm-server/server.test.js` — updated boundary assertions only if adjacency coverage needs tightening
