# Credipark fuller-reference transfer evaluation

Status: completed isolated comparison; no skill changes or canonical packet replacement.
Date:2026-09-16. Skill baseline: ae40437e194e9a072026126e93618c533180cfe0.

## Question and method

The previous pilot tested a compact maintained synthesis, not the source skills individually. Its unfavorable visual preference did not establish that the sources were ineffective. This follow-up tests direct use of fuller visual/interaction references during refinement of two user-selected existing Credipark prototypes.

For each case: retain the approved original, create one current-skill refinement, and create one refinement with the same skill plus fuller sources. Four fresh Sol/medium builders, same task/scope/content/viewports, no inherited discussion or access to other variants. Builders inspected supplied approved screenshots and source; controller/fresh reviewer performed browser inspection after freeze. This controls starting material but is one sample per condition per case, not a replicated causal benchmark.

Additional sources: pinned Wondel.ai Refactoring UI and Design of Everyday Things adaptations, installed Impeccable operate/critique references. Both conditions retain scope/authority; reference condition reads the reviewed correction audit. Sources are knowledge only; no helper execution/installation. Vercel/ibelick implementation material was not the visual treatment. No imagegen: this isolates prototype refinement within the existing journal/table composition family, not full concept generation.

## Results

| Case | Blinded preference | Fuller-reference variant | Concrete contribution and cost |
| --- | --- | --- | --- |
| Customer dialog journal | A > B > Original | A | Stronger event/date/amount hierarchy and tighter association; mobile long-label wrapping. Uppercase dates and a taller context block add weight. |
| Global movements | B > Original > A | B | Clearer control groups, readable effect/action columns, coherent selected-event evidence, mobile row boundaries. Added structure consumes space. |

Mapping was withheld until the reviewer returned its verdict: dialog A=references/B=current; global A=current/B=references. The reviewer preferred direct-reference output for both cases. This is positive evidence for useful visual refinement on these two screens, not proof each source helps, a universal superiority claim, or a measured productivity benefit.

Controller desktop inspection concurs that reference-dialog amounts remain more closely associated than the wider current variant and reference-global avoids the current variant's heavier boxed results/actions. Improvements are modest refinements of already strong approved designs. The user subsequently agreed with the dialog A/global B preference and authorized improving the skills. This confirms preference for these refinements; it does not replace the canonical DashPark packet approvals.

## Preservation and verification

- Copied and validated canonical packets: dialog journal-r3 descriptor6742d41fd74d4e5db767cff4ac6f05e85c7cc586a57a2baa0c7c125aee3b6f40; global A-r1 descriptorc60b3b9a7bd8636e5b19b9e81d49cbfef559df0665a08e35276e384d08c0ad3d. `python3 skills/frontend-direction/scripts/frontend_packet.py check <copied-input-root>` passed both.
- Existing `node <prototype>/check.cjs` passed for all6 original/refined copies. fixtures.js and check.cjs remain byte-identical in all4refinements.
- Source diffs: dialog/current CSS only; dialog/references CSS plus identity wrapper/close class and title; global/current CSS plus control-group wrapper/prototype title; global/references CSS only. No financial algorithm changes.
- Original DashPark packet trees compared against full before/after SHA256 inventory; unchanged.
- Independent actual screenshots/AX at1536x1024 and390x844 for paid Original/A/B in both cases; global default desktop; long-label mobile both. Detail, search/filter, raw switch/scroll, paging, error retry and Escape exercised, but not each path in every variant. No regression observed in exercised paths, not exhaustive acceptance.
- Controller additionally inspected reference-assisted desktop/narrow outputs, confirmed no document overflow and global raw region1000px within319px at390viewport. Console error/warn list empty in that final check. Viewport restored.
- No production/backend, persistence or screen-reader proof. Captures were inspected inline; no retained PNG file is claimed.

## Interpretation and next experiment

The fuller sources can contribute useful visual judgment. The compact synthesis improved specific reasoning checks but did not cover the same breadth of visual craft. However, this experiment cannot attribute the outcome to a particular source, separate source quality from stochastic generation, or establish that adding all source text to every request is worthwhile.

A justified next hypothesis is selective loading of visual-composition and operator-interface material during prototype refinement, followed by actual browser critique. Before changing maintained skills, test that narrower retrieval behavior against current and no-guidance controls with repeated samples per writing-skills. Avoid replacing evidence with more generic instructions. The user has now confirmed the preference and authorized that focused experiment.

## Artifacts and reproduction

Experiment root: `.superpowers/evals/credipark-reference-transfer-20260916/` (retained local ignored files). `protocol.md`, `builder-task.md`, `review-task.md`, `source-identities.json`, `variant-identities.json`, `reference-condition.json`, each builder's notes, and `independent-review.md` preserve the procedure, identities and results. Source revisions/licenses remain in the maintained design-knowledge-sources.md audit.

Comparison page: http://127.0.0.1:8938/ . Anonymous copies in `site/review/{dialog,global}/{original,A,B}/`; source-condition copies in `site/{dialog,global}/{original,current,references}/`.

Launch from repository root:

```sh
python3 -m http.server 8938 --bind 127.0.0.1 --directory .superpowers/evals/credipark-reference-transfer-20260916/site
```

Use `?state=paid` or the scenario selector. Alternatives retain all supplied example families and advanced states. No skill files, approved DashPark prototypes or production code changed.
