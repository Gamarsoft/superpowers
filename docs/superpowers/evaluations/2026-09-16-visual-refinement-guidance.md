# Visual refinement guidance evaluation

Status: Task1 evaluated; candidate omitted under the approved negative-result rule. Consumer check pending. Baseline ae40437e194e9a072026126e93618c533180cfe0. Approved plan: `2026-09-16-visual-refinement-guidance.md`.

## Why this change

The user preferred the fuller-reference Credipark dialog A and global B refinements and authorized a focused skill improvement. That two-case comparison motivated the hypothesis; it did not establish universal visual superiority or isolate any one source's contribution.

The tested candidate added a conditional, self-contained prototype-refinement reference. It works through a representative content group, then compares its hierarchy, association, surface and density costs in the full viewport. Optional installed knowledge supports unresolved decisions. Existing concept generation, approvals, copy authority, packet identity and consumer review remain authoritative.

## Tests before guidance

The first text quiz disclosed the layout problems explicitly. All five no-guidance responses and the two current-skill responses recognized them and respected scope. Those answers are a ceiling result, not RED evidence. No instruction was authored from that quiz.

The replacement application task asked fresh Sol/medium workers to improve the same frozen global movement prototype without naming the expected treatment. Five no-guidance, five frozen-current and five frozen-candidate refinements form the repeated application test. The original source, French copy, fixture data, supported controls/states, composition family and requested desktop/narrow viewports are identical. Builders have no browser access; controller inspection after freeze is equally applied to all arms. This tests the effect of guidance on generated refinement, not autonomous browser iteration or an entire design workflow. No source bundle is supplied to the candidate: this tests the compact maintained method with optional helpers absent.

Before candidate authoring, all five no-guidance outputs and notes were inspected at1536x1024 paid and390x844 long-state first view. Control1 makes secondary Filters the dominant filled action and wraps the detail link narrowly. Control4 gives the retained shell a large gradient header, shrinks key values to11px and hides the fixture banner on mobile. Control5 shrinks data to12px/labels10px and promotes mobile detail to a full-width outlined action. Control3 separates mobile effect labels and values across an inset band; this is a weaker association tradeoff, not a hard accessibility failure. Control2 is reasonably coherent and is not labeled a failure merely for adding borders.

These observations establish actual weaknesses in no-guidance application. They do not prove smaller text or cards are universally wrong, nor that a subjective preference measures operator productivity. The candidate uses a positive refinement recipe, not a prohibition list.

## Results and limits

All fifteen application outputs and notes were inspected. Candidate results are mixed. Three of five retain a light shell; some keep event/effect labels and values closer on narrow screens. Other candidates still introduce dominant secondary controls, dark or gradient prototype chrome, small metadata or taller stacks of labels. The current arm also contains useful refinements. This is not a consistent visual win and does not establish broad superiority.

All sixteen original/refined fixture checks pass, with fixtures and the check script unchanged. Those checks establish retained synthetic behavior, not visual quality. The first-view mobile captures do not exercise every long record below the fold. A candidate provenance follow-up confirmed that the new reference was actually read, so the mixed result cannot simply be dismissed as failed discovery.

Five held-out routing cases preserve the intended scope: editorial refinement, an operational form, unresolved dashboard exploration, a small approved legacy-packet edit, and approved direction conflicting with legacy composition. No consumer-guidance gap was demonstrated by the initial identity/rationale cases.

### DashPark-grounded comparison

The user requested anchoring tests in the main project's design guidance. The paired follow-up receives identical frozen root AGENTS/PRODUCT and Gateway AGENTS/PRODUCT/DESIGN/FRONTEND-ANCHORING/DESIGN-EVIDENCE. Gateway's light shell, Open Sans component roles, functional emphasis, French operator density and feature-delta authority materially clarify the evaluation. Both builders receive an equal browser inspection/correction pass after their initial outputs are saved. This is a separate experiment; its samples are not pooled with the five source-only repetitions.

Initial grounded outputs retain the light shell more faithfully. The current-skill browser pass reported no required source correction, exercised desktop/narrow content and controls, and passed the fixture check. The candidate browser pass also found no supported reason to change its source. Both passes exercised desktop/narrow states, inline details, raw-table containment, search, filtering, paging and focus; both fixture checks pass. Frozen before/after source hashes confirm neither pass changed implementation bytes.

The unfamiliar Relay pilot uses its own teal/Arial identity, not DashPark's visual vocabulary. Both variants retain byte-identical records, filtering and input/paging handlers; syntax checks pass. The fresh reviewer rendered both prototypes and the original at both viewports, exercising search, status filtering, paging, Inspect/focus and synthetic copy feedback.

### Independent comparison and disposition

The reviewer received the project records and a task brief, but no skill text, variant source, builder notes, mapping or prior evaluation results. Mapping was frozen before review: Credipark A=current/B=candidate; Relay A=candidate/B=current. It used a fresh tab in the existing in-app browser, recording that full context isolation was unavailable.

| Case | Blinded preference | Interpretation and costs |
| --- | --- | --- |
| DashPark-grounded Credipark | B > original > A | Candidate was preferred. Light shell, functional blue, restrained rows and clearer mobile field roles improved the record/evidence relationship. It costs vertical space and still has small muted metadata. Current's bordered cards, boxed effects and full-width detail actions were weaker at narrow width. |
| Unfamiliar Relay | B > A > original | Current was preferred. It preserves more room for long recipient names and clearer selected-detail context. Candidate also improves the original, but puts the action beside the name, forcing earlier wrapping and taller mobile cards. Current's three-column mobile summary has small labels. |

No behavioral regression was observed in the exercised representative paths. Credipark grant +3 000 cp and restitution +1 200 cp remain distinct. These are qualitative reviewer preferences, not measured usability gains.

**Disposition: omit the candidate reference and its entrypoint link.** The repeated outputs remain variable, the grounded case favors the candidate, and the unfamiliar case favors the current workflow. This supports neither a reliable overall improvement nor a general prescription for one mobile treatment. The approved spec explicitly permits trimming/removing additions that do not earn their maintenance cost. The frozen candidate and all comparisons remain local evidence; no candidate instruction is deployed. Existing task-to-layout, scoped project authority, browser iteration and implementation guidance remain unchanged.

The practical test improvement is to supply the real app-level design records equally to both variants and distinguish retained anchors from the feature delta. That is already required by the existing workflow. The new paired evidence illustrates its value; two grounded samples do not quantify its causal effect. No new mandatory document names or DashPark-specific design rules are added to reusable skills.

## Reproduction

Retained local ignored root: `.superpowers/evals/visual-refinement-20260916/`. `application-task.md`, `rubric.md`, `application-identities.json`, frozen `baseline/skills` and `candidate/skills`, per-arm prototypes/notes and `application-verification.json` retain exact inputs and outputs. `baseline-observations.md` records observations before candidate authoring. The initial `cases.md` and responses remain as negative/ceiling evidence.

```sh
python3 -m http.server 8939 --bind 127.0.0.1 --directory .superpowers/evals/visual-refinement-20260916
python3 .superpowers/evals/visual-refinement-20260916/verify-artifacts.py
```

Application routes: `/application/{original,control-1..5,current-1..5,candidate-1..5}/?state=paid` and `?state=long`. The unfamiliar Relay pilot lives under `/pilot/`.

All work is synthetic. No canonical DashPark packet or production UI is changed. Browser captures inspected inline are transient unless a retained file is explicitly named. No backend, auth, persistence, screen-reader or measured usability claim is made.

## Focused checks

Task1: `python3 tests/claude-code/test-frontend-direction-contract.py` passes four tests; skill-creator `quick_validate.py skills/frontend-direction` passes with the prepared PyYAML dependency path. Baseline consumer checks pass: `python3 tests/claude-code/test-frontend-packet.py` passes18tests, and `bash tests/claude-code/test-frontend-visual-review-policy.sh` passes. A fresh exact-target consumption check remains before completion.
