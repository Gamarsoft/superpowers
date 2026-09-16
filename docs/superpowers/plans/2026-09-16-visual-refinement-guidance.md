# Visual refinement guidance implementation plan

> Explicit execution-route override: use superpowers:executing-plans for self-hosting skill work; controller owns mutations and scoring, fresh agents evaluate/review.

**Goal:** Improve concrete prototype refinement and preserve its approved visual rationale.
**First delivery boundary:** Tested maintained guidance and evidence; no production or canonical DashPark changes.
**Architecture:** Stage-specific reference under frontend-direction; reuse packet/checklist fields and existing implementation consumer.
**Tech Stack:** Markdown, existing Python/shell checks, isolated HTML/CSS evaluation.
**Spec:** docs/superpowers/specs/2026-09-16--visual-refinement-guidance.md
**Spec revision:** SHA256 f68d126d203c0d74ca3f00494d52c2d75941b54884d72b948f5b80e0cd1161e7; user-approved2026-09-16.
**Risk class:** review-required
**Risk triggers:** explicit user request; public contract; cross-system contract.
**Verification lanes:** controller focused/integration; fresh evaluator behavior/artifacts; one final independent reviewer; finishing full available suite.

## Context

Baseline HEAD ae40437e194e9a072026126e93618c533180cfe0; branch codex/frontend-design-knowledge, current checkout per established self-hosting choice. Earlier untracked Credipark evaluation is owned session evidence and will be committed with spec/plan. Existing immutable source audit/rights retained. No library API change, no new dependency. Write no candidate guidance before baseline failure observed. Use five fresh-context samples for each frozen no-guidance/current/candidate arm, manually inspect every output and retain exact file identities. Obvious critique questions may serve as regression checks but cannot justify guidance when controls succeed; use actual application outputs to establish RED before authoring. One skill changed/verified/committed at a time. Maximum2correction rounds per task/final evidence; unsupported additions omitted.

## Readiness Record

**Author self-review:** complete; scope/authority, baseline before guidance, actual artifact and whole-feature evidence mapped.
**Independent readiness gate:** sp_reviewer `refinement_plan_review`, one correction round. PR-1–PR-5 resolved: complete acceptance mapping, fresh frozen arms/matched artifacts, exact validators, named risk predicates, rendered consumer verification. Scoped re-review: READY — no supported BLOCKING or DECISION remains.

## Task1: Make prototype refinement concrete

**Outcome:** Relevant visual guidance changes demonstrated weak decisions without expanding workflow.
**Files and ownership:** Controller owns skills/frontend-direction/SKILL.md, references/visual-refinement.md, existing packet template/review checklist only if justified, source audit updates if needed, and docs/superpowers/evaluations/2026-09-16-visual-refinement-guidance.md. Evaluators own assigned ignored files only.
**Interfaces and contracts:** Consume existing stage/authority and reviewed sources; produce focused refinement method and consequential rationale in existing fields. No new schema/gate or mandatory helper.
**Dependencies:** none.
**Risk:** review-required; explicit user request; public contract; cross-system contract.
**Acceptance:** Demonstrated improvement in association/scan order, relative hierarchy, restrained grouping, task-based density, long-content/narrow structure and matched browser comparison. Preserve brand/shell, business meaning, copy authority, three-image default, explicit prototype-only overrides, approved identity, legacy compatibility, small-edit routing and optional helpers. Guidance generalizes beyond Credipark.
**Error handling:** If baseline succeeds, omit unsupported guidance. Candidate regression corrected within2rounds or report conflict. No fake browser proof.
**Verification:**Five fresh-context no-guidance/current/candidate applications per frozen arm, manually inspect actual outputs and exact input identities; fresh held-out marketing/form/operator requests. Render direct refinements of the same frozen unfamiliar original under identical content, state, constraints and desktop/narrow viewports; fresh reviewer blind to mapping when practical. Failed artifact returns here for same-owner correction/retest, same budget. Run python3 tests/claude-code/test-frontend-direction-contract.py and PYTHONPATH=/private/tmp/frontend-knowledge-validator-deps python3 /Users/gamarsoft/.codex/skills/.system/skill-creator/scripts/quick_validate.py skills/frontend-direction. Commit coherent result before Task2.
**Pointers:** task-to-layout.md, source audit/NOTICE, optional Impeccable bridge, Credipark transfer report.

## Task2: Preserve approved refinement during implementation

**Outcome:** Existing handoff/consumer preserves visual rationale with runtime fidelity evidence.
**Files and ownership:** Controller owns implementing-frontend-design SKILL.md/checklist only if baseline demonstrates a gap, cumulative evaluation and plan ledger. No speculative change required.
**Interfaces and contracts:** Existing packet rationale/must-preserve/state fields consumed under exact identity; no silent legacy normalization, target change or retroactive packet requirement.
**Dependencies:** Task1 committed.
**Risk:** review-required; explicit user request; public contract; cross-system contract.
**Acceptance:** Approved visual choices remain binding; relevant source/runtime checks; old packets and small edits retain scope.
**Error handling:** Baseline without failure means no consumer edit. If edited, separate5control/current/candidate cycle before commit. Real direction conflict returns for scoped decision.
**Verification:** CaseD current/controls evidence plus a fresh consumer application of the exact Task1 produced rationale to the isolated unfamiliar prototype. Compare approved source and implementation at1536x1024 and390x844 with identical default/long-content states, search/detail/pagination and keyboard checks. Retain actual screenshot observations and source identities; synthetic static implementation does not prove Angular or backend integration. python3 tests/claude-code/test-frontend-packet.py and bash tests/claude-code/test-frontend-visual-review-policy.sh; if changed: PYTHONPATH=/private/tmp/frontend-knowledge-validator-deps python3 /Users/gamarsoft/.codex/skills/.system/skill-creator/scripts/quick_validate.py skills/implementing-frontend-design. Commit results.
**Pointers:** implementing-frontend-design entry/checklist and existing packet template.

## Whole-feature verification

Spec association/scan order, hierarchy/grouping, density and long/narrow content→Task1 application outputs and matched rendered pilot. Brand/shell and business meaning→fixture/source comparison and browser observations. Copy authority, three-image default and prototype-only override→held-out routing cases and direction contracts. Approved identity and legacy compatibility→packet tests plus Task2 exact-target application. Small edits and optional helpers→C and fresh held-out cases. Source rights→audit/NOTICE. Implementation fidelity→Task2 actual desktop/narrow rendering and interactions, with evidence limits. Existing rationale fields→Task1 handoff and Task2 consumption; no new schema gate. One final independent cumulative review per executing-plans contract with exactBASE/HEAD, full spec/plan, ledger, evidence, dispositions. Reviewer READY before handoff. Finishing writes durable report-only commit and leaves feature branch as-is.

Complete available deterministic suite, finishing only:

```bash
bash <<'SH'
failed=0
for test in test-worktree-path-policy.sh test-timeout-portability.sh test-lean-delivery-contracts.sh test-review-depth-contracts.sh test-sdd-workspace.sh test-sdd-custom-contracts.sh test-custom-policy-contracts.sh test-frontend-visual-review-policy.sh test-gsd-review-policy-detail.sh test-no-pencil-frontend-policy.sh test-brainstorming-artifact-quality.sh test-frontend-direction-resources.sh test-frontend-packet.sh; do
  bash "tests/claude-code/$test" || failed=1
done
bash tests/codex/sdd-behavior/test-score-results.sh || failed=1
node --test tests/brainstorm-server/*.test.js || failed=1
exit "$failed"
SH
```

External model-driven CLI suites/optional packaging not available; fresh Codex evals cover edited behavior. Report limit.
