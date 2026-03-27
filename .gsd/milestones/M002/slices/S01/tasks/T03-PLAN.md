---
estimated_steps: 5
estimated_files: 3
---

# T03: Refresh the three active example fragments against the new bar

**Slice:** S01 — Routing, quality gate, and active example refresh
**Milestone:** M002

## Description

Rewrite the three in-scope example fragments so they embody the stricter routing and quality-gate rules with concrete, subject-specific visual content, while leaving `carry-forward-summary.html` untouched.

## Steps

1. Rework `side-by-side-comparison.html` into a stronger two-direction comparison that shows real structural differences instead of dressed-up labels.
2. Rework `ranked-alternatives.html` so the current winner, lower-ranked trade-offs, and hierarchy judgment are visually concrete and honest.
3. Rework `annotated-recommendation.html` so the recommendation, rationale, and known constraints read like a real follow-up artifact rather than a generic shell.
4. Keep the examples fragment-first, `data-choice`-based, and inside the existing four archetypes; do not modify `carry-forward-summary.html`.
5. Run the contract test and inspect the visual-companion example diff to confirm only the three in-scope files changed.

## Must-Haves

- [ ] The three active example files become clearly more concrete and decision-capable without adding new metadata or new archetypes.
- [ ] `carry-forward-summary.html` remains untouched unless an explicit contradiction is discovered, which is not expected in S01.

## Verification

- `node tests/brainstorm-server/visual-companion-contract.test.js`
- `git diff --name-only -- skills/brainstorming/examples/visual-companion`

## Observability Impact

- Signals changed: the three active visual-companion fragments now make the comparison axis, winning direction, trade-offs, and carry-forward constraints visible in authored HTML instead of relying on generic placeholder copy.
- How to inspect later: read the three fragment files directly, render them through the existing brainstorm server if needed, run `node tests/brainstorm-server/visual-companion-contract.test.js`, and inspect `git diff --name-only -- skills/brainstorming/examples/visual-companion` to confirm the active-example boundary stayed intact.
- Failure state made visible: if the refresh drifts back toward generic shells, loses `data-choice`/fragment compatibility, or edits `carry-forward-summary.html`, the artifact diff and contract/runtime-adjacent checks make that boundary break obvious.

## Inputs

- `skills/brainstorming/examples/visual-companion/side-by-side-comparison.html` — current side-by-side example to strengthen
- `skills/brainstorming/examples/visual-companion/ranked-alternatives.html` — current ranked example to strengthen
- `skills/brainstorming/examples/visual-companion/annotated-recommendation.html` — current annotated recommendation example to strengthen
- `skills/brainstorming/examples/visual-companion/carry-forward-summary.html` — out-of-scope reference that must remain unchanged in this slice

## Expected Output

- `skills/brainstorming/examples/visual-companion/side-by-side-comparison.html` — stronger concrete side-by-side comparison fragment
- `skills/brainstorming/examples/visual-companion/ranked-alternatives.html` — stronger concrete ranked-alternatives fragment
- `skills/brainstorming/examples/visual-companion/annotated-recommendation.html` — stronger concrete annotated-recommendation fragment
