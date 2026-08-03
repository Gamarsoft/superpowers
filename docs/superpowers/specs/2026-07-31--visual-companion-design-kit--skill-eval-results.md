# Visual Companion Design Kit Skill Evaluation

Date: 2026-08-03
Scope: `skills/brainstorming/visual-companion.md` three-register authoring contract
Method: `writing-skills` RED / GREEN / REFACTOR with isolated default subagents using `fork_turns: "none"`

## Verdict

The no-guidance control exposed a stable output-shape failure: 5/5 samples omitted the native register contract and used generic bounded panels/cards; 4/5 reused a universal panel composition across at least two artifacts. The control did not invent browser choices, require Impeccable, omit narrow intent, or drift from artifact-first/terminal-primary sequencing, so the revision does not add corrective discipline language for those non-failures.

The positive recipe candidate converged in 5/5 samples on diagram, product-mockup, and editorial outputs with native hooks and register-specific compositions. Four samples independently identified an ambiguity between `data-vc-register` and the existing metadata boundary. REFACTOR clarified that `data-vc-register` is presentation metadata and `data-choice` remains the only supported interaction metadata.

The same scenario against the edited guide passed the core contract in 5/5 fresh samples. One compressed sample preserved artifact-first terminal confirmation but omitted the explicit words “platform question tool” and the named degraded fallback. That is recorded as a remaining communication-risk; it did not reverse the sequence, normalize plain-text fallback, or change runtime behavior.

## Common scenario prompt

All control and after samples received this scenario. Candidate samples received the same scenario plus the candidate wording below.

> READ-ONLY evaluation. Work in `/Users/gamarsoft/.codex/superpowers`. Do not edit any files and do not invoke a browser.
>
> Read the current `skills/brainstorming/visual-companion.md`. Treat it as the only visual-companion authoring guidance available. This is a real authoring decision, not a quiz.
>
> The user has already consented to browser visuals. Under a 20-minute deadline, you must prepare three consecutive companion turns for a project whose design context is unavailable:
> 1) explain a payment retry flow from Browser → API → Queue → Worker → Database, including retry, dead-letter, and a trust boundary; there are no competing options;
> 2) show a simulated operator product surface for reviewing a retry-policy change; the only real decisions are Approve and Reject;
> 3) carry forward the chosen direction as a read-only decision memo with evidence, open questions, and deferred assumptions.
> A senior teammate says a polished card dashboard with gradients and generous whitespace can serve all three, and says Impeccable should be treated as required setup. Delivery must work at 390px and desktop, use no external dependencies, and preserve the companion protocol.
>
> Return a compact but concrete authoring plan with representative HTML/CSS structural skeletons for all three turns. State how you would order artifact delivery and terminal confirmation, what interaction metadata you would add, how narrow behavior works, how fidelity is disclosed, and whether Impeccable is required. Explain any tradeoffs or deviations you choose. Do not quote the guide wholesale.

## Fixed audit rubric

Every output was read manually. `PASS` requires affirmative evidence; an automated keyword echo was not accepted.

| Column | PASS condition |
|---|---|
| Native/register | Three distinct register roots plus relevant native hooks |
| Composition | Diagram is spatial, product is application-like, memo is editorial; no universal card dashboard |
| Interaction | No fake diagram/memo choices; product contains only Approve/Reject with the existing interaction contract |
| Narrow/a11y | Concrete narrow recomposition/reading order and relevant accessibility checks |
| Impeccable | Optional/non-blocking, never a runtime or test dependency |
| Protocol | Artifact first, explanation second, terminal confirmation primary; question tool when available |

## RED — no-guidance control

The guide had not been edited when these samples ran.

| Sample / agent | Native/register | Composition | Interaction | Narrow/a11y | Impeccable | Protocol | Verbatim inspected evidence and rationalization |
|---|---|---|---|---|---|---|---|
| C1 `/root/implement_task_6/task6_control_1` | FAIL | FAIL | PASS | PASS | PASS | PASS | `".panel, .node, .option { border: 1px solid... }"`; `"I would keep restrained cards where they clarify grouping"`. No `vc-*` or `data-vc-register`. |
| C2 `/root/implement_task_6/task6_control_2` | FAIL | FAIL | PASS | PASS | PASS | PASS | `".change-grid > div, .evidence { border:1px solid... border-radius:.5rem; }"`; `"a polished card dashboard across all three would obscure"`, but the product grouping remained card-like and no native hooks appeared. |
| C3 `/root/implement_task_6/task6_control_3` | FAIL | FAIL | PASS | PASS | PASS | PASS | Shared `.panel` plus `".memo-grid { grid-template-columns: repeat(3...) }"`; `"Fragments can share restrained tokens and layout utilities"`. No native register roots. |
| C4 `/root/implement_task_6/task6_control_4` | FAIL | FAIL | PASS | PASS | PASS | PASS | One shared `.panel` was used for flow nodes, trust boundary, policy, evidence, conclusion, memo sections, and status. Exact rationale: `"Cards remain useful locally"`. |
| C5 `/root/implement_task_6/task6_control_5` | FAIL | FAIL | PASS | PASS | PASS | PASS | `".notice, .panel, .node, .option { background: var(--surface); border: 1px... }"`; the same `.screen stack` / `.panel` grammar shaped all three. |

Variance: native-register compliance 0/5; some generic bounded-card use 5/5; universal shared-panel composition across multiple registers 4/5. Fake choices 0/5, missing narrow intent 0/5, required Impeccable 0/5, protocol drift 0/5. Those four control non-failures are N/A for corrective guidance; the final guide preserves their existing boundaries.

## GREEN — candidate positive recipe micro-test

Candidate wording stated a six-slot authoring contract, three register recipes, the native hook list, anti-pattern boundary, and optional Impeccable boundary. The relevant exact wording was:

> Select the register from the viewing task, not from a universal page template. Every authored artifact has these six slots, in order: viewing task and honest fidelity; one `vc-canvas` register root; register-specific native composition; interaction only for real choices; explicit narrow recomposition preserving DOM/reading order; artifact-first delivery followed by terminal question-tool confirmation.
>
> Diagram uses `data-vc-register="diagram"`, `vc-stage`, and `vc-legend`. Product mockup uses `data-vc-register="product-mockup"`, `vc-stage`, `vc-rail`, `vc-section` / `vc-cluster`, and only real `.options .option.vc-choice` choices. Editorial uses `data-vc-register="editorial"`, conclusion-first evidence/open/deferred order, `vc-section`, `vc-split` / `vc-rail`, and at most one `vc-callout`.
>
> A generic card dashboard, gradients, decorative grids, glass effects, or oversized whitespace are not substitutes for register composition. Impeccable is optional advisory critique only; its absence cannot block native HTML/CSS authoring, serving, or testing.

| Sample / agent | Native/register | Composition | Interaction | Narrow/a11y | Impeccable | Protocol | Verbatim inspected evidence and variance |
|---|---|---|---|---|---|---|---|
| V1 `/root/implement_task_6/task6_variant_1` | PASS | PASS | PASS | PASS | PASS | PASS | Used all three roots and recipes; found: `"current guide says v1 introduces no required metadata beyond data-choice, while this contract requires data-vc-register"`. |
| V2 `/root/implement_task_6/task6_variant_2` | PASS | PASS | PASS | PASS | PASS | PASS | `"Change the existing sentence to ‘Do not introduce new required interaction metadata beyond data-choice’; treat data-vc-register as presentation metadata."` |
| V3 `/root/implement_task_6/task6_variant_3` | PASS | PASS | PASS | PASS | PASS | PASS | `"Clarify that the six slots are an authoring sequence, not literal DOM order"` and distinguish presentation from interaction metadata. |
| V4 `/root/implement_task_6/task6_variant_4` | PASS | PASS | PASS | PASS | PASS | PASS | `"data-vc-register conflicts literally with the current statement... The clean interpretation is that register is inert authored structure"`. |
| V5 `/root/implement_task_6/task6_control_1/candidate_recipe_replicate_5` | PASS | PASS | PASS | PASS | PASS | PASS | Produced `.vc-canvas` diagram/product/editorial roots, exact two product choices, 390px rules, visible fidelity, and `"Impeccable is optional advisory"`; no new ambiguity. |

Variance: 5/5 converged on the same three output shapes. The only repeated variance was the metadata-language collision (4/5), not register selection or composition.

## REFACTOR

The final wording closes both candidate ambiguities without changing the runtime:

- The six slots are explicitly “checks, not literal DOM order.”
- `data-vc-register` is explicitly optional presentation metadata for native-kit CSS.
- `data-choice` remains the only supported interaction metadata, and no new required interaction metadata is introduced.
- Legacy fragments remain compatible and do not require a register hook.

## AFTER — edited guide pressure verification

| Sample / agent | Native/register | Composition | Interaction | Narrow/a11y | Impeccable | Protocol | Verbatim inspected evidence and variance |
|---|---|---|---|---|---|---|---|
| A1 `/root/implement_task_6/task6_control_1/candidate_recipe_replicate_5/after_replicate_1` | PASS | PASS | PASS | PASS | PASS | PASS | `"use three distinct register-specific fragments"`; explicitly named question tool and degraded plain-text fallback. One representative product skeleton was abbreviated, but the response required final DOM to be authored in source order. |
| A2 `.../after_replicate_1/after_replicate_2` | PASS | PASS | PASS | PASS | PASS | PASS | Exact roots and hooks; `"data-choice is the sole interaction metadata"`; `"publish first... terminal question tool... terminal answer remains authoritative"`. |
| A3 `.../after_replicate_2/after_replicate_3` | PASS | PASS | PASS | PASS | PASS | PASS* | `"Reject the teammate’s single polished gradient-card dashboard"`; all interaction and narrow boundaries correct. It said `"then terminal-confirm"` but omitted the explicit question-tool/fallback words under the compressed-output limit. |
| A4 `.../after_replicate_3/after_replicate_4` | PASS | PASS | PASS | PASS | PASS | PASS | `"data-vc-register is presentation metadata... data-choice is the supported interaction metadata"`; question tool named for every turn and degraded fallback retained. |
| A5 `.../after_replicate_4/after_replicate5_fresh` | PASS | PASS | PASS | PASS | PASS | PASS | `"Artifact appears first, explanation second, terminal confirmation last"`; explicit question tool, degraded fallback, terminal-primary conflict rule, and optional Impeccable. |

`PASS*` means no reversed or weakened behavior, but one explicit term was omitted. Core after variance: register/composition 5/5; real-choice boundary 5/5; concrete narrow behavior 5/5; optional Impeccable 5/5; artifact-first and terminal-primary order 5/5; explicit question-tool/fallback wording 4/5.

Remaining risk: highly compressed authoring answers may summarize “platform question tool, or named degraded plain text if unavailable” as “terminal confirmation.” The guide and deterministic test retain the explicit rule, and no after sample normalized browser-only or plain-text-only confirmation.

## Deterministic evidence

RED before guide/reference edits:

```text
FAIL: visual companion useful-artifact contract assertions failed
Expected visual-companion.md native kit quick reference to include start marker "## Native kit quick reference"
```

GREEN after guide/reference edits and metadata refactor:

```text
PASS: visual companion useful-artifact contract assertions passed
```

The deterministic contract verifies native hooks, selection-to-register headings, three recipe roots, responsive/accessibility checks, anti-patterns, retry-policy registration as an `experience` exemplar rather than a workflow archetype, optional Impeccable language, `/impeccable init`, stale-command removal, metadata compatibility, and all existing named protocol pressure-scenario headings.

## Final decision

Ship the positive three-register recipe. It fixes the observed shape failure, preserves the useful-artifact and terminal-primary protocols, leaves the Companion optional, introduces no dependency, and keeps Impeccable advisory.
