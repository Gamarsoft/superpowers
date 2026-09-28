# Frontend design knowledge implementation plan

> **For agentic workers:** Explicit execution-route override: use `superpowers:executing-plans`. The controller owns skill edits, frozen eval inputs, scoring and sequential commits; fresh agents perform behavioral samples and the final independent review. Do not delegate or parallelize skill mutations.

**Goal:** Improve task-based design reasoning and control-specific implementation verification with reviewed references, retaining the approved visual workflow.
**First delivery boundary:** Evaluated, installed repository skill changes and durable source/evaluation evidence; no DashPark production or approved packet changes.
**Architecture:** Stage-specific references under existing skills. Baseline failures determine content; optional tools remain optional. No new skill family or packet schema.
**Tech Stack:** Markdown skills and references, existing Python packet/link checks, existing shell/Node infrastructure tests; isolated HTML/CSS/JS evaluation artifacts.
**Spec:** `docs/superpowers/specs/2026-09-16--frontend-design-knowledge--proposal.md`
**Spec revision:** `aad48f1bce183cb47b532b3501a14fac5d1ab6ee`
**Risk class:** review-required
**Risk triggers:** explicit user requirement for reviews; shared design authority and producer/consumer contract.
**Verification lanes:** controller owns focused and cross-skill integration evidence; fresh evaluators own their outputs; one independent final reviewer; finishing owns the complete available deterministic suite.
**Branch/base:** `codex/frontend-design-knowledge` from `refs/heads/gamarsoft`, merge commit `c68dbfc`; work in the requested current checkout. No new worktree or remote publication.

## Context and invariants

The user authorized this specification and execution on 2026-09-16. Existing branch merge is completed separately. Preserve image concepts and browser prototype default, explicit exploration limits, approved packet hashes and backward compatibility, copy ownership, brand/shell and framework, and existing review/approval gates. References provide knowledge rather than competing product requirements. Core path works with no optional helper installed.

Keep upstream discovery/read operations separate from invoking a skill or binary. Record immutable upstream revisions/licenses before retaining adaptations. Prefer original concise synthesis; no book text or wholesale source copies. Verify normative accessibility details against W3C/WAI rather than helper claims. Existing source audit replaces library/API research because no runtime API/library change is planned.

Apply writing-skills RED/GREEN/REFACTOR once per skill. Freeze no-guidance/current/candidate inputs; run at least five fresh-context samples per wording variant and inspect all output. Do not teach the desired answer in evaluator prompts. Scope application evaluations to isolated files, with no writes to production or approved artifacts. One skill must be tested, validated and committed before editing the next. Unsupported additions are omitted even if they appeared in the initial hypothesis.

## Readiness record

**Author self-review:** complete; tied knowledge changes to baseline failures, preserved per-skill sequencing and authority, separated wording evidence from artifact evidence and complete-suite ownership.
**Independent readiness gate:** READY after round 1; fresh `knowledge_plan_review` reviewer confirmed R1 resolved on 2026-09-16.

| ID | Disposition | Ruling or resolution | Evidence carried forward |
| --- | --- | --- | --- |
| R1 | BLOCKING, corrected | A failed artifact pilot returns to Task 1 or 2 under the same controller ownership and correction budget; revalidate and recommit before repeating Task 3. | Task 3 ownership and final evidence. |

## Task 1: Review sources and improve direction decisions

**Outcome:** Frontend direction uses only demonstrated useful knowledge at the relevant design stage.
**Files and ownership:** Controller sole writer of `skills/frontend-direction/SKILL.md`, justified references in `skills/frontend-direction/references/`, optional changes to its existing packet template/review checklist, and `docs/superpowers/evaluations/2026-09-16-frontend-design-knowledge.md`. Evaluators own only assigned ignored output files.
**Interfaces and contracts:** Consume approved spec and frozen current skill. Produce reviewed source provenance, baseline/candidate evidence, concise loaded references and rationale within existing packet decisions. No schema changes or helper runtime requirements.
**Dependencies:** none.
**Risk:** review-required; shared authority and explicit review requirement.
**Acceptance:** Meaningful task/visual decisions improve on observed failures; available Impeccable knowledge can supplement core reasoning without invoking orchestration unasked; no novelty, density or stack mandates. Existing entry modes and old packets retain behavior.
**Error handling:** A source without confirmed rights is not copied. A baseline without the supposed failure does not justify guidance. Record unavailable capabilities rather than claiming execution. Correct a demonstrated candidate regression with at most two rounds.
**Verification:** Five no-guidance controls, five current-skill samples, then five candidate samples when justified; manual comparison of actual responses. Fresh held-out task and permission/scope cases. Run `python3 tests/claude-code/test-frontend-direction-contract.py` and skill-creator `quick_validate.py skills/frontend-direction` with temporary validator dependencies if needed. Save focused output and exact variant identities. Commit verified direction changes before Task 2.
**Pointers:** Current entry, `impeccable-brownfield-quality-layer.md`, `visual-exploration.md`, `frontend-direction-template.md`, `frontend-review-checklist.md`, and installed Impeccable operational guidance.

## Task 2: Improve approved-target implementation checks

**Outcome:** Changed controls receive relevant, evidence-based source and runtime verification without reopening approved design.
**Files and ownership:** Controller sole writer of `skills/implementing-frontend-design/SKILL.md`, references beneath that skill, and cumulative evaluation document. Reuse Task 1 provenance by link; avoid modifying the completed direction skill unless a proved integration defect requires correction and revalidation.
**Interfaces and contracts:** Consume approved reference identity and Task 1 knowledge authority; produce focused findings mapped to actual changed controls, evidence kind and necessary runtime checks within the existing review.
**Dependencies:** Task 1 completed and committed.
**Risk:** review-required; approved-target and review evidence boundaries.
**Acceptance:** No silent redesign/stack changes, no assertion of runtime behavior from source alone; handle tabs/dialog/paging, long translated content and transient states when relevant. Component-specific interpretation avoids universal Tab-stop and contrast mistakes. Mechanical edits remain narrow.
**Error handling:** Proved conflict changing approved WHAT is surfaced for a scoped decision. Missing runtime evidence remains unverified. Omit unsupported guidance; no extra review or approval family.
**Verification:** Same fresh 5-control/5-current/5-candidate process with approved-target scenarios and seeded raw UI source where helpful, manually reviewed. Fresh forward cases for legacy packet and scope preservation. Run `python3 tests/claude-code/test-frontend-direction-contract.py`, `python3 tests/claude-code/test-frontend-packet.py`, `bash tests/claude-code/test-frontend-visual-review-policy.sh`, and quick_validate for this skill. Commit verified changes.
**Pointers:** Existing entry, implementation checklist, shared scoped authority, reviewed Vercel actual guidelines, ibelick source and W3C/WAI pattern guidance.

## Task 3: Verify artifact quality and cross-skill behavior

**Outcome:** Actual isolated interfaces and implementation findings support the claimed improvement and its limits.
**Files and ownership:** Controller owns cumulative evaluation report and plan-scoped evidence. Fresh agents own assigned isolated HTML outputs/review results; no edits to live DashPark. A failed pilot returns to the affected owning Task 1 or 2: the same controller corrects its skill files, revalidates affected behavioral/contract evidence and commits the correction before repeating Task 3. Preserve that task's correction budget and per-skill sequencing.
**Interfaces and contracts:** Consume frozen current/candidate skill versions, same task/content/viewport constraints and approved targets. Produce actual rendered desktop/narrow comparison and exercised interaction evidence, with provenance, limitations and preference reasons.
**Dependencies:** Tasks 1 and 2. Evaluations may begin alongside the relevant task only when input versions are frozen; no cross-skill mutation overlap.
**Risk:** review-required; truthful acceptance and reviewer independence.
**Acceptance:** Inspect an operator-screen example and an unfamiliar form/operational example. Conceal variant identity during independent comparison where practical. Assess task clarity, hierarchy, information access and interactions; do not infer real-user speed gains. Preserve exact packet behavior; report any unsupported hypothesis as such. If artifact results fail to support adoption, correct/remove the causally related guidance and rerun affected evaluations within the correction budget.
**Error handling:** No browser means no browser proof; report the blocker rather than passing from source. Fixture proof never establishes backend integration. No actual user approval is simulated.
**Verification:** Open isolated artifacts in in-app browser where available, capture and inspect desktop/narrow views, exercise relevant actions/focus/recovery. Record exact observed outcomes. Run cross-skill resource checks and one independent cumulative review with exact BASE/HEAD, plan/spec, ledger and evidence. Review must be READY before finishing.
**Pointers:** Spec evaluation matrix, existing browser selection guidance, executing-plans final-review contract.

## Whole-feature verification and handoff

Mapping: knowledge/provenance and design reasoning → Task 1; applied source/runtime findings and protected approval → Task 2; rendered outcomes and transfer → Task 3. All tasks preserve original workflow scope. Controller records every finding disposition, candidate identity, actual outputs and any correction; independent final reviewer checks the combined contract.

The available deterministic repository suite below is owned only by finishing. Model-driven CLI integration suites and optional harness packaging are outside this environment's complete available lane; the fresh Codex behavioral evaluations above cover the edited skills directly. Report that limit.

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

Finishing validates exact HEAD, runs this suite once, preserves the execution report and leaves the new feature branch available for user review. The prior merge instruction applies to the previous feature branch, not an automatic merge or push of this new work.
