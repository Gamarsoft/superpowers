# Frontend design knowledge evaluation

Status: direction wording evaluation complete; implementation and rendered pilots pending.

## Method and identities

Model: fresh generic Sol/low agents for routing/application micro-tests; Sol/medium for isolated artifact builders. No forked conversation history, no evaluator delegation. Baseline source: repository merge c68dbfcd065a16098dc561003c17284fd914f243. Local frozen inputs and every raw response remain under `.superpowers/evals/frontend-knowledge-20260916/`. Controls cannot read skills; current and candidate actors read only their frozen skill tree and the same raw case file. Outputs were manually read, not scored by keyword/heading matches. These are small descriptive samples, not a statistical estimate of general success.

## Direction baseline and candidate

Five samples per arm, each answering the same three cases. The observed failure was incomplete grounding of information meaning during design, rather than ignorance of general usability principles. Use a positive task-to-layout method, not additional review gates or a prohibition wall.

| Case | No guidance | Current skill | Candidate |
| --- | --- | --- | --- |
| A: redesign a reconciliation modal while retaining fields/page size; parking totals and movements are compared together | 5/5 introduced unsupported aggregates/differences | 3/5 introduced unsupported aggregates or reconciliation status | 0/5 introduced unsupported business meaning |
| B: external audit asserts 18px regular text qualifies as large, nine filters violate a seven-choice rule and a 10/10 score proves readiness | 5/5 rejected those assertions | 5/5 rejected those assertions | 5/5 retained correct decisions |
| C: only change Mouvement to Type; optional helper absent | 5/5 remained small and avoided setup | 5/5 remained small and avoided setup | 5/5 remained small and avoided setup |

A evidence: current2 proposes a “running movement sum/difference”; current3 introduces “reconciliation status” and “relevant movement aggregate”; current4 pins “reconciliation status”. Their business derivation was not supplied. Current1 correctly conditions a comparison value on existing behavior, and current5 retains known values. Control3 even proposes a visible/filtered movement sum although the account/page relationship is unknown. Score proposed design content only, not production mutations. Missing semantics are relevant because financial totals across a loaded page and an account can differ legitimately.

Candidate1 explicitly retains identical fields and avoids new page-derived differences; candidate2 distinguishes the page scope; candidates3-5 retain the established information. All preserve simultaneous comparison, offer meaningful layout tradeoffs and avoid claiming measured productivity gains. B's success existed before the candidate, so no new contrast/choice-count chapter is justified by these samples.

C has artifact-target ambiguity: some actors describe changing the prototype, others the production header. The case does not settle which is intended, so this is not scored as unauthorized approval or packet mutation. A scoped reference revision is different from silently accepting changed bytes against an old hash.

Independent forward cases retain server-provided warehouse counts, synthetic support-form states, requested marketing image-first exploration and legacy target consumption. The support-form answer includes an unnecessary reference to a superseded concept image in prototype-only work. A current-skill probe also invokes concept comparison, although it does not mention an image. No tools/images ran. This wording ambiguity is recorded rather than presented as proof of a new behavioral regression or used to broaden the change; actual prototype-only pilots test the execution boundary separately.

## Changed direction contract

One task-to-layout reference explains information scope, simultaneous comparison, grouping, emphasis, disclosure cost and evidence. One stage link and one rationale slot in the existing packet template make it usable. No schema or metadata change. Reviewed provenance and MIT notices are packaged with the skill. The tested reference's provenance link was relocated to the same skill directory for self-contained distribution; method wording is unchanged.

Focused checks: `python3 tests/claude-code/test-frontend-direction-contract.py` passes4/4; quick_validate for frontend-direction passes. The validator initially lacked PyYAML, then passed with isolated `/private/tmp/frontend-knowledge-validator-deps`; no global package installation. Existing baseline packet CLI tests pass18/18. Behavioral evidence, not these structural checks, supports the instruction change.

## Remaining evaluation

Implementation baseline/candidate, matched rendered artifacts, final independent review and finishing verification remain pending. Do not infer a visual-quality improvement from the micro-tests alone.

## Frozen direction sample identities

- `direction-control-1.md`: `ade3c9c50c0df5c6628d78b07bfe0c364de604554572ffa99659ee28095d854e`
- `direction-control-2.md`: `6c7c980bfa53978fad161a5e993188dbea88880ba0933ca1563896087fe52254`
- `direction-control-3.md`: `3081073ed380cf0ac4364373ce09cb43e688d6fe1c69e70c6316c46541601051`
- `direction-control-4.md`: `b4875b54cdf962f8cd93ac51cc995ba73b9ac4b11dcac8787ff3d0596c664443`
- `direction-control-5.md`: `98ac1274dab55bb715b7f5c28aacc7b9b63321bca2ed41ff80151a1d69addc84`
- `direction-current-1.md`: `642baa34015dee191cbc7d5b5dea7d9a46a1d9ac2d46b0a96a503a299389a96b`
- `direction-current-2.md`: `bbd26ec865820606d8bbda430e0abc6f3c56e463755146ee76b597c861c78f65`
- `direction-current-3.md`: `e2ac9eb6b451b754a2ba8f787f8834de6e05dd26a4a5c3af8f56bac64adc6ed2`
- `direction-current-4.md`: `ed23f92edd4523e63f19736fc47141f98526f9296de2d224b739fcc4f8f810e0`
- `direction-current-5.md`: `dd974cb670f35d4829fcb295e0744d73701cd38fd436521f9117fdc2e57df977`
- `direction-candidate-1.md`: `d222f3b477d190ee2af3d05137220b9b9900fb20f0cdff5e9d66e822ed841b51`
- `direction-candidate-2.md`: `fdf3f8dd01b84289ab2327f8b05dcaae5679c336a7d6181594b265aa16ccd3ae`
- `direction-candidate-3.md`: `2b4adf687e15711f2d23eeecdc3bb9b0fce2a064d1ae2ecf2d3b03990083624c`
- `direction-candidate-4.md`: `1f6faf0610edd61c54a4dfc7cd26860d0c26de0a620d11d25d0d693267dd3931`
- `direction-candidate-5.md`: `ce9f71933734bdd035b190a45aa53dfd0534e4e75c61ea95f89ee29472f6cd50`

## Direction scenario input

# Design decisions at a paused frontend-direction step

Give your actual design recommendation for each independent request below. These are bounded text-only concept/review decisions; do not generate images, browse, implement, invoke other workflows, or ask questions. Use only the supplied evidence and the assigned skill if provided. Keep the combined response under 850 words.

## A: Reconciliation workspace
An old Angular operator modal has a customer summary, a parking totals breakdown, and a paginated movement table below it. Brand, app shell, business fields and page size must remain. Operators reconcile a selected parking total against movement amounts several times each shift, scanning both together. The screenshot is cluttered: all section headings have identical emphasis, every total has a colored card, and pagination is below the long page. A stakeholder proposes putting parking totals on a separate tab to free height. We have one screenshot and the reported workflow, no recorded browser run or task-time measurement. Propose three meaningfully different directions, recommend one for a prototype, explain the tradeoffs and what to establish next. We want efficient reconciliation, not a new brand.

## B: Prototype review
A reviewed design concept puts an ordinary 18 CSS-pixel regular-weight pending-balance value on a pale surface; measured contrast is 3.2:1. The account controls are dense but familiar to operators. A supplied external audit says the type counts as large text, the 9 visible filter choices violate a 7-choice rule, and a 10/10 score after hiding four filters and increasing whitespace will establish readiness. The only evidence is a static desktop screenshot, including a disabled Retry button with no explanation. Users need to know whether data is still loading, access is restricted or a retry is possible. Give the concrete decisions you would make before approving the prototype, with their rationale and needed evidence. Keep the established font and Angular stack.

## C: Narrow scope
We already approved a prototype and its packet. Today only change the movements table header from Mouvement to Type. Impeccable is not installed here. State the appropriate next action and stopping boundary.
