---
estimated_steps: 5
estimated_files: 1
---

# T01: Extend the contract regression for the stricter S01 bar

**Slice:** S01 — Routing, quality gate, and active example refresh
**Milestone:** M002

## Description

Extend the existing contract test so S01 closes on explicit proof for the tighter routing rule, the pre-display checklist, the placeholder-screen ban, the revise-or-stay-terminal fallback, and the active-example boundary.

## Steps

1. Read the current assertions in `tests/brainstorm-server/visual-companion-contract.test.js` and isolate the smallest extension points that fit the existing parser style.
2. Add assertions for genuinely-visual routing, terminal fallback for conceptual or text-first turns, the committed checklist items, the `no placeholder screens` rule, and revise-or-stay-terminal failure behavior.
3. Add assertions that make the active-example scope explicit for M002 and keep `carry-forward-summary.html` outside the refresh boundary.
4. Run the contract test and confirm it fails or would fail until the doc changes land.
5. Leave the test file in a state that T02 and T03 can satisfy without guessing at wording drift.

## Must-Haves

- [ ] `tests/brainstorm-server/visual-companion-contract.test.js` asserts the new S01 rules instead of relying on manual review.
- [ ] The new assertions still follow the existing precise parsing style rather than broad, fragile whole-document phrase matching.

## Verification

- `node tests/brainstorm-server/visual-companion-contract.test.js`
- Confirm failing assertions point to the missing S01 contract language or boundary rule, not unrelated runtime behavior.

## Observability Impact

- Signal added/changed: `tests/brainstorm-server/visual-companion-contract.test.js` becomes the authoritative failure surface for missing S01 routing, quality-gate, fallback, and active-example-boundary language.
- How to inspect later: run `node tests/brainstorm-server/visual-companion-contract.test.js` and read the named assertion in stderr/stdout; the failure should identify the missing section or boundary drift directly.
- Visible failure state: missing wording now surfaces as a targeted contract-test assertion instead of a prose review gap.

## Inputs

- `tests/brainstorm-server/visual-companion-contract.test.js` — existing contract-proof surface from M001
- `.gsd/milestones/M001/M001-SUMMARY.md` — confirms that M001 closed on strict authored-contract checks above the runtime boundary

## Expected Output

- `tests/brainstorm-server/visual-companion-contract.test.js` — extended contract assertions for S01 routing, checklist, fallback, and active-example boundary
