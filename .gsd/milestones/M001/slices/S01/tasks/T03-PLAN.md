# T03: Lock the contract with regression checks

**Slice:** S01 — Authoring contract and archetype kit
**Milestone:** M001

## Description

Give the slice a durable proof surface. This task adds a contract test for the guidance and example kit, then re-runs the existing brainstorm runtime regressions so later slices can build on S01 without quietly breaking the authoring boundary it establishes.

## Steps

1. Add `tests/brainstorm-server/visual-companion-contract.test.js` as a Node-based assertion script that reads the guide and example artifacts from disk.
2. Assert the exact four archetype labels, the `/frontend-design` or `$frontend-design` rule, the ordered first-use workflow, the degraded-mode language, the full-document compatibility rule, and the presence of the four example files.
3. Run the existing `server.test.js` and `ws-protocol.test.js` scripts after the new contract test to confirm the slice stayed additive to the runtime.

## Must-Haves

- [x] The slice has a repeatable contract test that fails if the guide, workflow, or example kit drifts.
- [x] Existing brainstorm runtime regression tests still pass after the documentation/example changes.

## Verification

- `node tests/brainstorm-server/visual-companion-contract.test.js`
- `cd tests/brainstorm-server && node server.test.js && node ws-protocol.test.js`

## Inputs

- `skills/brainstorming/visual-companion.md` — finalized contract language from T01
- `skills/brainstorming/examples/visual-companion/*.html` — example artifacts from T02 that the test must lock in place
- `tests/brainstorm-server/server.test.js` — existing runtime regression suite that guards the fragment/full-document boundary
- `tests/brainstorm-server/ws-protocol.test.js` — existing runtime regression suite for event persistence behavior

## Expected Output

- `tests/brainstorm-server/visual-companion-contract.test.js` — repeatable contract assertions for the comparison-first guide and archetype kit

## Observability Impact

- **Signals changed by this task:** adds a deterministic contract-failure surface at `tests/brainstorm-server/visual-companion-contract.test.js` with explicit missing-phrase and missing-artifact assertions for archetypes, workflow order, degraded mode, command-routing wording, compatibility language, and example presence.
- **How future agents inspect this task:** run `node tests/brainstorm-server/visual-companion-contract.test.js` for contract drift, then `cd tests/brainstorm-server && node server.test.js && node ws-protocol.test.js` to confirm runtime diagnostics remained additive.
- **Failure state now visible:** contract drift becomes an immediate test failure naming the missing phrase or artifact instead of silently shipping stale guidance.
