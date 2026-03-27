---
estimated_steps: 5
estimated_files: 1
---

# T01: Extend the authored-contract regression with M003 RED anchors

**Slice:** S01 — Named pressure scenarios and RED proof surface
**Milestone:** M003

## Description

Extend the existing authored-contract regression so it encodes the M003 protocol family and fails before any workflow doc wording is changed.

## Steps

1. Read the current structure in `tests/brainstorm-server/visual-companion-contract.test.js` and identify the smallest section-scoped extension points that fit its existing parser style.
2. Add M003 assertions for the new pressure-scenario artifact plus the four missing protocol outcomes: first qualifying visual turn starts the companion path, artifact-first sequencing, dedicated question-tool continuity after earlier browser use, and explicit degraded fallback when the question tool is unavailable.
3. Keep assertion messages grouped and specific so later reruns can distinguish missing artifact coverage from missing protocol wording.
4. Run the contract test against the current docs and confirm it fails for an M003-specific reason.
5. Leave the test in a state T02 can satisfy without guessing at wording drift or runtime behavior.

## Must-Haves

- [ ] `tests/brainstorm-server/visual-companion-contract.test.js` becomes the authoritative RED proof surface for the M003 protocol family.
- [ ] The new assertions stay section-scoped and precise instead of degrading into broad whole-document phrase matching.

## Verification

- `node tests/brainstorm-server/visual-companion-contract.test.js`
- Confirm the failure names a missing M003 artifact or protocol anchor, not an unrelated runtime or parser error.

## Observability Impact

- Signals added/changed: `visual-companion-contract.test.js` becomes the explicit RED signal for missing first-turn startup, artifact-first sequencing, question-tool continuity, and degraded fallback wording.
- How a future agent inspects this: run `node tests/brainstorm-server/visual-companion-contract.test.js` and read the named failing assertion to see whether the remaining gap is missing scenario coverage or missing protocol wording.
- Failure state exposed: authored-contract drift now surfaces as a targeted M003 assertion instead of a false green or a generic prose-review concern.

## Inputs

- `tests/brainstorm-server/visual-companion-contract.test.js` — the existing strict authored-contract parser from M001/M002
- `.gsd/milestones/M003/M003-RESEARCH.md` — documents why the current green contract surface is blind to the motivating regression family
- `skills/brainstorming/references/test-scenarios.md` — the existing pressure-scenario idiom this slice should extend rather than replace

## Expected Output

- `tests/brainstorm-server/visual-companion-contract.test.js` — extended with M003 RED anchors that fail on the missing protocol family before doc wording changes
