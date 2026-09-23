# GPT-6 model routing validation

Verified 2026-09-24 for the approved Superpowers model update. The baseline is
source revision `c2c862d`; candidate changes are the role pins and routing policy
in this change. Installed reviewer pins already used Astra/medium; the source
pack previously used GPT-5.6 Sol/high for review and context.

## Intended assignments

| Role or route | Model | Effort |
| --- | --- | --- |
| Ordinary implementation | gpt-6-sol | medium |
| Sensitive implementation and second correction | gpt-6-sol | xhigh |
| Unified review | gpt-6-astra | medium |
| Bounded topic context | gpt-6-luna | high |
| Cross-service/conflicting/architectural context and one material-gap escalation | gpt-6-sol | medium |

Role prompts, names and sandbox fields remain unchanged. The generic context
prompt now states its existing read-only/no-subagent obligations explicitly.
No review gate or correction round was added.

## User preference update

On 2026-09-24 the user selected GPT-6 Sol/xhigh for `sp_implementer_deep` to
reduce costs. The source role, installed role, generic fallback mapping, scoped
global policy, and edge scenario now use that setting. Reviewer pins remain
Astra/medium. Role responsibilities and correction limits are unchanged.

The routing and model-task results below, including `post-install.json`, record
the initial Astra/medium deep-role configuration. They are retained as historical
evidence and do not establish Sol/xhigh rescue quality or total task savings.

## Routing samples

Run `context-scenario.md` in five separate fresh-context GPT-6 Sol/medium agents,
substituting SKILL_PATH with the variant's absolute gathering-topic-context
SKILL.md path. Each agent reads the full skill and its prompt. Preserve the
scenario's prospective Luna pin in both variants, so this measures controller
routing after the proposed pin change, not the old installed context model.
Do not tell the samples the expected answers. Do not execute their hypothetical
dispatch envelopes. Inspect all outputs manually against the cases below.

| Case | Expected action | Baseline correct / 5 | Candidate correct / 5 |
| --- | --- | --- | --- |
| Bounded topic | Typed Luna/high, deep scan | 5 | 5 |
| Cross-service conflict | Generic Sol/medium | 0 | 5 |
| Material gap after Luna | One generic Sol/medium escalation | 2 | 5 |
| Gap remains after Sol | Return gap; no further context agent | 3 | 5 |
| Missing bounded-context role | Generic Luna/high | 0 | 5 |

All five candidate samples retained fresh context, the complete prompt, and the
requested depth, with no attempt to override a fixed typed role. Summaries and
verbatim baseline failure explanations are in `baseline-routing.json` and
`candidate-routing.json`; these are observations, not complete transcripts.

Run `edge-scenario.md` with SKILLS_ROOT set to the candidate's absolute skills
path. One further Sol/medium sample verified stale pins, generic implementation
and review defaults, upfront sensitive implementation, both correction rounds,
explicit light depth, and an unresolved fact after an initial Sol context run.
All nine decisions matched the policy. Its wording ambiguity about the number
of review-owning skills was clarified in the durable scenario.

## Representative model tasks

Separate disposable Python fixtures and generic agents with explicit models
were used because this running session still advertised the old typed pins.

- Luna/high read a five-file receipt-renderer fixture. It identified the unused
  default constant, existing pass-through behavior, normalization target,
  missing tests, dependencies and preservation requirements. It returned every
  requested bundle section and made no file edits.
- Sol/medium implemented title normalization in two owned files. It observed
  the expected failing regression test, then passed that test and the assigned
  two-test unittest lane. Fixture commit: `ed15c7d3098b27425ae901a5de1a9daa2cd5ca22`.
- Astra/medium repaired a seeded second-correction tenant-cache collision.
  It demonstrated alpha's receipt leaking to beta, changed the key to tenant
  plus receipt ID, preserved prior evidence, and passed the focused regression
  and assigned two-test lane. Fixture commit: `3567256c5b6b1bddca128ae20d316c919fc7051d`.
- Astra/medium reviewed the existing review-depth scenario. It found the tenant
  isolation blocker and no defect in the behavior-preserving Unicode lookup.
  It initially requested missing test definitions. Completing that same review
  with those definitions produced NOT READY for the tenant defect and READY
  for the equivalent lookup, without another reviewer or invented requirements.
  Test results in that review scenario remained reported, not independently run.

These bounded smoke checks establish operational behavior on the supplied
fixtures. They do not benchmark model quality, task cost, or subscription usage.

## Contract checks

The following passed before and after the changes:

```sh
bash tests/claude-code/test-sdd-custom-contracts.sh
bash tests/claude-code/test-custom-policy-contracts.sh
bash tests/claude-code/test-review-depth-contracts.sh
```

TOML parsing confirmed exactly four roles and the intended model/effort pairs.
Comparison with baseline confirmed every other role field was preserved.
All new model-policy references resolve. Post-install checks confirmed every
installed file matches the staged hash, source/installed role equality, the scoped
global policy update, removal of the unused alias, and all three contract suites
passing against the actual source tree. See `post-install.json`. `git diff --check`
also passed. Start a fresh Codex task and inspect advertised pins before relying
on typed roles; older tasks can use the documented generic route.

Model-selection rationale: https://learn.chatgpt.com/docs/models?surface=cli#cli-choosing-astra-sol-and-luna
Credit-rate reference: https://learn.chatgpt.com/docs/pricing#token-rates
