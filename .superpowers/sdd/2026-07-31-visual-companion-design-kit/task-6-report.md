# Task 6 Report: Three-Register Authoring Contract

Date: 2026-08-03

## Outcome

Implemented the three-register authoring contract in the Visual Companion guide and verified it with deterministic documentation tests plus 15 manually scored fresh-context eval samples. The guide now selects diagram, product-mockup, or editorial composition from the viewing task, uses the native kit hooks, limits interaction to real choices, specifies responsive/accessibility checks, rejects generic decorative composition, and keeps Impeccable optional.

The product mockup remains an `experience` useful-artifact exemplar rather than a new workflow archetype. Existing artifact-first, terminal-primary, question-tool, degraded-fallback, and optional-Companion semantics remain in place. The brainstorming skill entrypoint did not require an edit.

## TDD and skill-eval evidence

### RED

The deterministic contract was added before editing the guide/reference. Its first run failed as intended:

```text
FAIL: visual companion useful-artifact contract assertions failed
Expected visual-companion.md native kit quick reference to include start marker "## Native kit quick reference"
```

Five no-guidance controls then exposed the actual behavior failure:

- native/register compliance: 0/5
- generic bounded panels/cards: 5/5
- universal shared-panel composition across multiple artifact types: 4/5
- fake choices: 0/5 (N/A for new corrective guidance)
- missing narrow behavior: 0/5 (N/A)
- required Impeccable: 0/5 (N/A)
- protocol drift: 0/5 (N/A)

### GREEN and REFACTOR

Five candidate micro-tests converged on distinct native diagram, product-mockup, and editorial outputs. Four independently found the same wording collision: requiring `data-vc-register` appeared to conflict with the existing ban on new required metadata. The refactor therefore makes the separation explicit:

- `data-vc-register` is optional presentation metadata for native-kit CSS.
- `data-choice` remains the only supported interaction metadata.
- The six authoring slots are checks, not literal DOM order.
- Legacy fragments do not require register metadata.

The focused deterministic test then passed. Five after-guidance pressure samples passed the core register, composition, real-choice, narrow/accessibility, optional-Impeccable, and artifact-first/terminal-primary criteria. Four of five explicitly named the question tool and degraded fallback; one compressed response abbreviated this to `terminal-confirm` without reversing or weakening the behavior. This variance is retained as a remaining communication risk rather than scored away.

The complete prompt, agent paths, verbatim inspected evidence, fixed audit table, variance, rationalizations, revisions, and verdict are in `docs/superpowers/specs/2026-07-31--visual-companion-design-kit--skill-eval-results.md`.

## Fresh-context agents

All samples used the default role with `fork_turns: "none"` and were read-only.

- Controls: `task6_control_1` through `task6_control_5`
- Candidate samples: `task6_variant_1` through `task6_variant_4`, plus `candidate_recipe_replicate_5`
- After samples: `after_replicate_1` through `after_replicate_4`, plus `after_replicate5_fresh`

No browser or Impeccable command was invoked. Impeccable availability was therefore immaterial, as required by the optional boundary.

## Files changed

- `skills/brainstorming/visual-companion.md`
- `skills/frontend-direction/references/impeccable-brownfield-quality-layer.md`
- `tests/brainstorm-server/visual-companion-contract.test.js`
- `docs/superpowers/specs/2026-07-31--visual-companion-design-kit--skill-eval-results.md`
- `.superpowers/sdd/2026-07-31-visual-companion-design-kit/task-6-report.md`

## Verification

- Focused RED/GREEN command: `cd tests/brainstorm-server && node visual-companion-contract.test.js`
- Final focused result: PASS, `visual companion useful-artifact contract assertions passed`
- Full command: `npm test`
- Full result: FAIL in the pre-existing live companion acceptance checkpoint after all earlier deterministic custom assertions passed. The acceptance test waits for `Decision checkpoint: export flow`, but the served `carry-forward-summary.html` contains `Chosen direction: drawer-based export flow` and no matching checkpoint text. Two escalated runs reproduced the same mismatch; the preserved second-run HTML confirmed the server had already switched to the new screen. Task 6 does not own the fixture or live-acceptance test, so no unrelated edit was made.

## Self-review

- Re-read the task brief and checked every acceptance item against the guide, deterministic assertions, and eval report.
- Confirmed the three recipes use distinct spatial/application/editorial compositions rather than a shared card dashboard.
- Confirmed the only interaction recipe is the existing `.options .option.vc-choice` / `data-choice` / `toggleSelect(this)` contract for real product decisions.
- Confirmed the product exemplar is registered under `experience`, not as a sixth intent.
- Confirmed `/impeccable init` replaces `/impeccable teach` only in the initialization reference.
- Confirmed all existing protocol pressure-scenario headings remain asserted exactly.
- Confirmed the skill entrypoint was not edited and `server.cjs` was not touched.
- Reviewed only the owned diff and staged only Task 6 files; unrelated untracked approved-spec artifacts remain untouched.

## Concerns

1. One of five compressed after samples omitted the explicit question-tool/degraded-fallback terminology while retaining terminal confirmation and the correct sequence. The deterministic contract still guards the complete wording.
2. The repository-wide suite is not green because of the unrelated live-acceptance/fixture text mismatch described above. The focused Task 6 contract is green.
