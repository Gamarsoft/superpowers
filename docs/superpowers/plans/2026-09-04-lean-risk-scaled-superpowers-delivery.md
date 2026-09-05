# Lean Risk-Scaled Superpowers Delivery Implementation Plan

> **For this self-hosting run:** REQUIRED: Use `superpowers:executing-plans` under root control. Do not invoke `superpowers:subagent-driven-development`, even when subagents are available. Fresh Codex agents are reserved for the bounded behavioral samples and independent reviews named below. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace the overlapping Gamarsoft planning and SDD review graph with one lean, risk-scaled Superpowers delivery path whose scope, authority, correction loops, evidence, and cleanup are bounded.

**First delivery boundary:** The revised Superpowers route can take an approved specification through contract-shaped planning, risk-scaled implementation and review, exact-HEAD handoff, one finishing suite per handed-off HEAD, and report-only evidence without duplicate orchestration. It stops before any upstream pull request, push, publish, or merge.

**Architecture:** Keep one owner per stage: `brainstorming` defines approved behavior, `writing-plans` creates a spec-linked risk-classified plan, SDD performs risk-scaled delivery, and `finishing-a-development-branch` runs the sole complete suite and preserves the execution report. Thin public review and no-subagent entry points reuse those contracts without becoming parallel orchestration lanes.

**Tech Stack:** Markdown skills and prompts, Bash test fixtures, Python 3 standard library scoring, Git, Codex multi-agent V2, Codex plugin archives.

**Spec:** `docs/superpowers/specs/2026-09-04--lean-risk-scaled-superpowers-delivery.md`

**Spec revision:** `5e6931022f6134f6eba7f25c3ad0eaa7d3e83628`

**Current worktree:** `/Users/gamarsoft/.codex/worktrees/5eb5/superpowers` (detached checkout)

**Implementation base:** `d9a937091926ace90db0da318fb34b78adbbb8e8`

**Upstream comparison baseline:** `origin/main` at `b36e0829c6d0140e93cfef2ca599b1b07d4a7797`; fork baseline `d9a937091926ace90db0da318fb34b78adbbb8e8`; common ancestor `44c9b2d6e889982ac18c27d05a19fefe335194e1`.

**Risk class:** `review-required`.

**Risk triggers:** public workflow contracts, destructive file and worktree behavior, cross-system Codex/plugin contracts, and multi-owner planning/execution/finishing invariants.

**Verification lanes:** focused static and script tests per skill; fresh-context paired behavior samples per changed skill; one successful fixture-repository smoke run; final package inspection and complete focused regression matrix.

**Selected specialist profiles:** agent-orchestration/skill behavior, Codex plugin packaging, and Git worktree/destructive-action safety. Java/Spring/GKE and application-security profiles are not selected because this change has no matching files or runtime surface.

## Global Constraints

- The approved specification is authoritative for observable behavior and scope.
- Preserve TDD, specification traceability, Context7 handoff, durable plan-scoped state, and atomic commits.
- Review-required risk means money, authorization, security, privacy, schema migration, destructive behavior, concurrency, idempotency, retry semantics, public contracts, cross-system contracts, multi-owner invariants, or explicit user request.
- Every review gate permits at most two correction plus re-review rounds.
- Review findings use only `BLOCKING`, `DECISION`, `FOLLOW_UP`, or `INVALID`, with the proof and causal limits in the specification.
- Implementers and reviewers never dispatch nested agents; the root controller owns all dispatch and disposition.
- Generic dispatch must succeed when a typed role is not advertised by the runtime.
- The portable plugin must not claim that its manifest installs project `.codex/agents` roles.
- SDD must not run the complete repository suite or invoke the public requesting/receiving review skills.
- Finishing owns the sole complete-suite run, exact-HEAD evidence binding, report-only commit, integration choice, and safe cleanup.
- Make one behavior-shaping skill change at a time and run its relevant baseline/candidate scenarios before proceeding.
- No upstream pull request, push, publish, or merge is part of this implementation.

**Context7 Findings:**

- Official Codex source documents standalone role discovery below user `CODEX_HOME/agents` and project `.codex/agents`.
- The documented plugin manifest exposes skills, hooks, MCP servers, apps, and interface metadata, but no agent-role field.
- `fork_turns: "none"` creates the fresh context required by the evaluation and dispatch contracts.
- The runtime's advertised role set is authoritative. When a desired role is absent, omit `agent_type` and use the same complete prompt through a generic agent.
- Unknown-role spawn fallback is undocumented, so no workflow may depend on intentionally failing a typed dispatch.

## Plan Context

**Invariants**

- A plan names the approved specification path and revision it implements.
- Reversible HOW choices are controller rulings; observable WHAT or protected authority remains the user's decision.
- Reviewers cannot create requirements, promote non-goals, or turn unrelated pre-existing defects into blockers.
- High-risk work receives individual review; compatible ordinary work shares a checkpoint, normally at most three tasks.
- All rulings, deviations, follow-ups, review evidence, and verification lanes survive temporary workspace cleanup.

**Non-goals**

- Redesigning GSD, frontend-direction, visual-companion, or domain-specific workflows.
- Weakening money, security, migration, authorization, privacy, or data-integrity review.
- Adding a third-party runtime dependency or depending on undocumented plugin role installation.
- Re-running the supplied production feature as an evaluation fixture.

**Terminology**

- `review-required`: a task with any named risk trigger.
- `checkpoint-review`: the default class for compatible ordinary work.
- `implementation HEAD`: the exact code revision accepted by SDD final review and later tested by finishing.
- `correction round`: one correction dispatch or edit followed by one scoped re-review.
- `generic fallback`: an untyped fresh agent receiving the same role prompt and no-subagent/access contract.

**Reference data**

- Eight original paired behavior scenarios: scope pressure, authority, cadence, circuit breaker, preflight contradiction, missing-role fallback, no-subagent fallback, and finishing evidence.
- One paired final-evidence transition revision extends finishing evidence with suite-failure return, archival, refreshed new-HEAD review, preserved count, and failed-HEAD non-retry.
- Three candidate-only exact-revision edge scenarios: available-role dispatch, brainstorming review gates, and Java profile taxonomy.
- Five baseline samples per scenario; if exactly one fails, expand that scenario to ten samples.
- Candidate sample count equals its baseline count; every candidate sample must pass and improve by at least two samples for each behavior used to justify wording changes.

**Backward compatibility**

- Existing plans remain readable by the revised executor.
- Single-task `task-brief PLAN_FILE N` use remains supported.
- Public skill names remain except the intentionally removed `refining-plans`.
- Claude Code and other untyped harnesses retain generic task dispatch.

**Cross-Task Invariants**

- Planning risk and execution cadence use the same named trigger set.
- The same finding taxonomy and causal proof rule governs task, checkpoint, fix, and final reviews.
- SDD's execution report and finishing's committed report refer to the same implementation HEAD.
- Role names used by skills match the surviving repository-local role files, while every use has a generic fallback.
- The package test proves packaged skills contain fallback instructions and do not claim unavailable typed-role installation.

**Adversarial / Boundary Cases**

- One real contract defect appears beside two plausible but out-of-scope hardening suggestions.
- A reversible implementation choice appears beside a public behavior change.
- Three ordinary tasks appear beside one money/concurrency task.
- The same supported blocker survives two corrections.
- Producer and consumer tasks disagree before Task 1.
- No requested typed role appears in the runtime's role list.
- Finishing sees a stale report HEAD, a dirty worktree-removal refusal, or implementation changes in the proposed report-only range.

## Chunk 1: Evaluation foundation and planning

### Task 1: Add the Codex behavior contract and capture the baseline

**Files:**

- Create: `tests/codex/sdd-behavior/README.md`
- Create: `tests/codex/sdd-behavior/scenarios/{scope-pressure,authority,cadence,circuit-breaker,preflight-contradiction,missing-role-fallback,no-subagent-fallback,finishing-evidence}.md`
- Create: `tests/codex/sdd-behavior/fixtures/{approved-spec,implementation-plan}.md`
- Create: `tests/codex/sdd-behavior/fixtures/create-smoke-repo.sh`
- Create: `tests/codex/sdd-behavior/score-results.py`
- Create: `tests/codex/sdd-behavior/test-score-results.sh`
- Create: `tests/codex/sdd-behavior/results/lean-risk-scaled/index.md`
- Create: `tests/codex/sdd-behavior/results/lean-risk-scaled/runs/baseline-d9a937091926/{manifest.json,summary.md,raw/*.json}`
- Include: `docs/superpowers/specs/2026-09-04--lean-risk-scaled-superpowers-delivery.md`
- Include: `docs/superpowers/plans/2026-09-04-lean-risk-scaled-superpowers-delivery.md`

**Interfaces and contracts:**

- Each scenario defines an exact fresh-context prompt, fixture inputs, binary assertions, and event counters.
- Every raw result records variant, revision, scenario, repetition, model, reasoning effort, plugins, typed-role availability, response, event trace, dispatch/review/fix/human-stop counts, dispositions, and assertion outcomes.
- `score-results.py RUN_DIR` validates one immutable run contract and prints a deterministic Markdown score table without network access.

**Dependencies:** None; this task establishes the fixture and evidence interfaces consumed by every later task.

**Risk class and triggers:** `checkpoint-review`; no named product-risk trigger. Evaluation validity is enforced by deterministic validation and manual raw-sample inspection.

**Focused verification lane:** scorer contract tests plus the pinned baseline run.

**Acceptance criteria:**

- The scorer rejects missing required fields, duplicate scenario/repetition keys, invalid dispositions, and sample-count mismatches.
- Five `fork_turns: "none"` baseline agents run per each of the eight scenarios at `d9a937091926`; a scenario with exactly one failure receives five additional samples.
- The checked-in summary links every score to its raw result and labels the supplied production thread as hypothesis evidence, not a controlled sample.
- The smoke fixture contains a low-risk batch, a review-required money/concurrency task, a seeded blocker, an out-of-scope suggestion, a reversible ambiguity, and final cross-task acceptance.

**Error handling:**

- Fail closed on malformed or incomplete result data; never infer a pass from missing events.
- If the immutable baseline cannot be checked out or the harness/model cannot be held constant, stop before skill edits and record the environmental blocker.

**Verification:**

- Run: `bash tests/codex/sdd-behavior/test-score-results.sh`
- Expected: scorer fixture tests pass, including malformed and boundary sample sets.
- Run: `python3 tests/codex/sdd-behavior/score-results.py tests/codex/sdd-behavior/results/lean-risk-scaled/runs/baseline-d9a937091926`
- Expected: deterministic table with all required scenario/sample rows and explicit baseline failures.

**Codebase pointers:**

- Follow `docs/testing.md` for the distinction between deterministic tests and live skill behavior.
- Use `skills/writing-skills/SKILL.md` for RED evidence and manual sample inspection.
- Use `skills/using-superpowers/references/codex-tools.md` for fresh agent lifecycle calls.

- [ ] Step 1: Read the pointers and inspect the baseline skill versions at the pinned revision.
- [ ] Step 2: Write failing scorer and fixture tests from the result contract.
- [ ] Step 3: Run the scorer tests and baseline agents; verify failures precede skill edits.
- [ ] Step 4: Implement the minimal harness, fixtures, stored evidence, and summary needed to satisfy the contract.
- [ ] Step 5: Run both verification commands, self-review raw samples, and commit the evaluation baseline.

### Task 2: Make writing-plans the sole bounded planning quality gate

**Files:**

- Modify: `skills/writing-plans/SKILL.md`
- Delete: `skills/writing-plans/plan-document-reviewer-prompt.md`
- Create: `skills/writing-plans/plan-readiness-reviewer-prompt.md`
- Create: `tests/claude-code/test-lean-delivery-contracts.sh`
- Modify: `tests/claude-code/run-skill-tests.sh`
- Add candidate evidence: `tests/codex/sdd-behavior/results/lean-risk-scaled/runs/candidate-02-writing-plans/{manifest.json,summary.md,raw/preflight-contradiction-*.json}`

**Interfaces and contracts:**

- Every plan header exposes `Spec`, `Spec revision`, `Risk class`, `Risk triggers`, and `Verification lanes`.
- Author self-review checks spec coverage, task consistency, placeholders, cross-task producers/consumers, risk classification, and execution-lane ownership.
- The readiness prompt consumes the full spec and full plan and returns proof-bearing findings under the shared four-disposition taxonomy.

**Dependencies:** Task 1's scenario, result, and scorer contracts.

**Risk class and triggers:** `review-required`; public planning contract and cross-task producer/consumer invariant.

**Focused verification lane:** planning static contract plus paired preflight-contradiction behavior samples.

**Acceptance criteria:**

- No named risk means author self-review completes planning without an independent reviewer.
- Any named risk triggers exactly one holistic readiness review, never per-output-chunk review.
- The planning controller applies supported findings directly and stops after two failed correction rounds; no plan-fixer agent is dispatched.
- The plan handoff points to SDD normally, but the approved self-hosting plan and continuation prompt name only root-controlled `executing-plans`.
- The preflight-contradiction candidate samples catch the producer/consumer conflict before execution without inventing requirements.

**Error handling:**

- A missing/unreachable specification or contradictory WHAT requirement blocks handoff.
- A reversible HOW ambiguity is recorded for the executor; it does not become a user question during planning.

**Verification:**

- Run: `bash tests/claude-code/test-lean-delivery-contracts.sh`
- Expected: spec linkage, risk fields, one holistic gate, two-round breaker, controller ownership, and bootstrap handoff assertions pass.
- Score the relevant candidate samples with `score-results.py`.
- Expected: candidate meets the baseline-matched sample count and acceptance threshold.

**Codebase pointers:**

- Preserve the fork's WHAT-not-HOW task format in `skills/writing-plans/SKILL.md`.
- Restore the explicit spec pointer and author self-review intent from `origin/main:skills/writing-plans/SKILL.md`.
- Fold only the useful lenses from `skills/refining-plans/plan-simulator-prompt.md` into the new readiness prompt.

- [ ] Step 1: Read the current, upstream, and approved-spec planning contracts.
- [ ] Step 2: Extend the static and behavior assertions so the current planning loop fails them.
- [ ] Step 3: Run the relevant tests and candidate prompt against the unmodified skill to confirm RED evidence.
- [ ] Step 4: Make the minimum writing-plans and readiness-prompt changes that satisfy the approved contract.
- [ ] Step 5: Run focused tests and candidate samples, self-review spec coverage, and commit the planning gate.

## Chunk 2: Remove duplicate planning and rebuild SDD

### Task 3: Remove refining-plans and its mutation-only roles

**Files:**

- Delete: `skills/refining-plans/SKILL.md`
- Delete: `skills/refining-plans/plan-fixer-prompt.md`
- Delete: `skills/refining-plans/plan-simulator-prompt.md`
- Delete: `.codex/agents/plan-fixer.toml`
- Delete: `.codex/agents/plan-simulator.toml`
- Modify: `.codex-plugin/plugin.json`
- Modify: `tests/claude-code/test-lean-delivery-contracts.sh`

**Dependencies:** Task 2 must be green so its readiness gate replaces every live responsibility of the removed skill.

**Risk class and triggers:** `review-required`; destructive file removal and public skill inventory.

**Focused verification lane:** live-reference/manifest absence checks plus Task 2 planning regression.

**Interfaces and contracts:**

- `writing-plans` readiness is the only plan pressure-test interface.
- The plugin manifest no longer advertises `refining-plans`.

**Acceptance criteria:**

- Repository search finds no executable routing or required sub-skill reference to `refining-plans`.
- No simulator or fixer role survives this task.
- Planning behavior from Task 2 remains green after deletion.

**Error handling:**

- Fail the test if any caller, manifest entry, or prompt still routes into the deleted skill.
- Historical release-note mentions are allowed and must not be rewritten.

**Verification:**

- Run: `bash tests/claude-code/test-lean-delivery-contracts.sh`
- Expected: removed paths are absent, live references are zero, and writing-plans readiness assertions remain green.

**Codebase pointers:**

- Use `.codex-plugin/plugin.json` as the public skill inventory.
- Distinguish historical prose in `RELEASE-NOTES.md` from live routing with path-scoped search assertions.

- [ ] Step 1: Read every live reference to refining-plans and classify historical-only mentions.
- [ ] Step 2: Add failing absence and manifest tests.
- [ ] Step 3: Run them to verify the redundant skill and roles cause failure.
- [ ] Step 4: Remove the skill, prompts, roles, manifest entry, and live routing references.
- [ ] Step 5: Re-run planning tests, self-review the deletion set, and commit the removal.

### Task 4: Rebuild SDD around preflight, risk-scaled units, and bounded evidence

**Files:**

- Modify: `skills/subagent-driven-development/SKILL.md`
- Modify: `skills/subagent-driven-development/implementer-prompt.md`
- Modify: `skills/subagent-driven-development/task-reviewer-prompt.md`
- Modify: `skills/subagent-driven-development/re-review-prompt.md`
- Create: `skills/subagent-driven-development/references/execution-report.md`
- Modify: `skills/subagent-driven-development/scripts/task-brief`
- Modify: `skills/subagent-driven-development/scripts/review-package`
- Modify: `tests/claude-code/test-sdd-workspace.sh`
- Rewrite: `tests/claude-code/test-sdd-custom-contracts.sh`
- Add candidate evidence: `tests/codex/sdd-behavior/results/lean-risk-scaled/runs/candidate-04-sdd/{manifest.json,summary.md,raw/*.json}`

**Interfaces and contracts:**

- `task-brief PLAN_FILE TASK_NUMBER...` preserves the single-task output and can emit one ordered multi-task work-unit brief.
- The plan-scoped ledger stores identity, spec revision, implementation base, pairwise preflight rows, risk class, units, rulings, dispositions, correction rounds, evidence, and final implementation HEAD.
- `execution-report.md` in the ignored workspace contains completed units, verification lanes, rulings, deviations, follow-ups, risks, decisions, final-review result, exact implementation HEAD, and a separate final-evidence correction count that task/unit fixes do not consume.
- Before trusting a `ready-for-finishing` handoff, SDD checks for a matching `producer-return.md`. It archives the rejected report and marker under `attempts/<failed-head>/`, preserves the final-evidence count, refreshes affected evidence and final review at a new HEAD, and never reissues a handoff for a HEAD whose complete suite failed.
- Review packages use recorded BASE and HEAD values and never infer `HEAD~1`.

**Dependencies:** Tasks 1–3 provide the behavior harness, spec-linked plan contract, and single planning gate.

**Risk class and triggers:** `review-required`; concurrency, retries/correction loops, public workflow contract, and multi-owner invariants.

**Focused verification lane:** SDD workspace/scripts/static contracts plus paired scope, authority, cadence, and circuit-breaker behavior samples and one controller-only fixture probe.

**Acceptance criteria:**

- Preflight emits auditable task/self and shared-file/interface rows and resolves every conflict before Task 1.
- Review-required tasks remain individual; compatible checkpoint work is grouped coherently, normally no more than three tasks.
- The controller autonomously rules on reversible HOW, asks only for WHAT/protected/destructive/external authority, and records the cost if wrong.
- Review findings meet the shared proof and causal rule; unrelated defects become `FOLLOW_UP`.
- The original implementer owns correction round one, one deep rescue owns round two, and a surviving supported blocker stops before round three.
- Implementer and reviewer prompts explicitly prohibit nested agents.
- Waiting is event-driven with the longest host-compatible bounded wait and no narrative or work creation on unchanged timeouts.
- SDD final review reuses focused/integration evidence, writes the report, and never runs the complete suite or deletes its workspace.
- A validated finishing return resumes the final-evidence gate with its existing count; suite failure consumes the next round, while a stale mismatch consumes a round only when code correction is required.

**Error handling:**

- Stop before dispatch on missing spec/plan identity, incomplete acceptance criteria, unresolved WHAT conflict, or unusable worktree.
- On missing typed roles, dispatch a generic fresh agent with the same prompt; do not skip the unit or review.
- A malformed report blocks finishing without fabricated resume state. A valid stale/dirty/suite-failed/mixed-range return is archived and resumed as final evidence; residual supported load-bearing findings after round two return the architectural conflict to the user.

**Verification:**

- Run: `bash tests/claude-code/test-sdd-workspace.sh && bash tests/claude-code/test-sdd-custom-contracts.sh && bash tests/claude-code/test-lean-delivery-contracts.sh`
- Expected: workspace, multi-task brief, ledger/report, producer-return archive/resume, separate final-evidence count, failed-HEAD non-retry, cadence, authority, review taxonomy, two-round breaker, wait, and no-nested-agent assertions pass.
- Score the four SDD-controller candidate scenario sets and run one controller-only fixture probe.
- Expected: all candidate samples pass, improve where baseline failed, dispatch no duplicate/nested reviewer, and preserve every ruling/follow-up in the report.

**Codebase pointers:**

- Restore auditable preflight, batching, continuous rulings, and event waiting from `origin/main:skills/subagent-driven-development/SKILL.md`.
- Preserve the fork's file-backed briefs, reports, review packages, combined reviewer, Context7 handoff, and plan-scoped workspace.
- Use `skills/writing-plans/plan-readiness-reviewer-prompt.md` for shared disposition language without invoking writing-plans at execution time.

- [ ] Step 1: Read the current and upstream SDD contracts, scripts, prompts, tests, and baseline raw samples.
- [ ] Step 2: Write failing static, script, and behavior assertions for the approved SDD interfaces.
- [ ] Step 3: Run focused tests and confirm the current five-round/per-task workflow fails the new contract.
- [ ] Step 4: Implement the minimum SDD, prompt, and script changes; then run fresh candidate agents.
- [ ] Step 5: Run focused verification, inspect every candidate sample and smoke report, and commit the SDD replacement.

## Chunk 3: Thin public boundaries and fallback execution

### Task 5: Narrow requesting and receiving review to public boundaries

**Files:**

- Modify: `skills/requesting-code-review/SKILL.md`
- Modify: `skills/requesting-code-review/code-reviewer.md`
- Create: `skills/requesting-code-review/references/profile-selection.md`
- Modify: `skills/requesting-code-review/references/java-21-spring-gke-checklist.md`
- Modify: `skills/receiving-code-review/SKILL.md`
- Modify: `tests/claude-code/test-custom-policy-contracts.sh`
- Modify: `tests/claude-code/test-lean-delivery-contracts.sh`
- Add candidate evidence: `tests/codex/sdd-behavior/results/lean-risk-scaled/runs/candidate-05-review-boundaries/{manifest.json,summary.md,raw/scope-pressure-*.json}`

**Interfaces and contracts:**

- `requesting-code-review` accepts an explicit requirements/spec source and exact BASE/HEAD range for ad hoc, major-feature, or pre-integration review.
- The reviewer selects only profiles justified by changed files or named risk; every profile remains subordinate to scope and the finding taxonomy.
- Specialist checklists may add domain probes but never add a second Critical/Important/Minor severity ladder.
- `receiving-code-review` handles human, forge, and out-of-band findings only and verifies each before action.

**Dependencies:** Task 4 owns SDD review internally before these public entry points relinquish SDD ownership.

**Risk class and triggers:** `review-required`; public review API and security/safety finding classification.

**Focused verification lane:** public-boundary static contracts plus paired scope-pressure behavior samples.

**Acceptance criteria:**

- Neither public skill claims ownership of SDD task, checkpoint, fix, or final review.
- The review template returns the four dispositions with exact proof and causal connection for blockers.
- The default reviewer is stack-neutral; Java/Spring, security, and other profiles load only when predicates match.
- Review ranges use a recorded BASE and never the unsafe `HEAD~1` shortcut.
- Fresh-context scope-pressure samples classify the real contract defect as `BLOCKING` and both unrelated hardening suggestions as `FOLLOW_UP`.

**Error handling:**

- Missing requirements or invalid Git ranges block review dispatch.
- A finding outside approved scope is recorded as `FOLLOW_UP`; a conflicting observable requirement is `DECISION`, not an automatic fix.

**Verification:**

- Run: `bash tests/claude-code/test-custom-policy-contracts.sh && bash tests/claude-code/test-lean-delivery-contracts.sh`
- Expected: standalone boundaries, conditional profile selection, one shared disposition taxonomy, safe range, generic fallback, and absence of SDD ownership all pass.
- Score `candidate-05-review-boundaries` against the baseline-matched scope-pressure sample count.
- Expected: every candidate sample passes and meets the required improvement threshold when the baseline justified the wording change.

**Codebase pointers:**

- Preserve the verification-before-action discipline in `skills/receiving-code-review/SKILL.md`.
- Reuse specialist checklists already under `skills/requesting-code-review/references/`; do not add stack-specific mandatory policy.

- [ ] Step 1: Read both public skills, their reviewer prompt, profiles, and SDD's internal review contract.
- [ ] Step 2: Add failing boundary, taxonomy, profile-selection, and safe-range assertions.
- [ ] Step 3: Run focused tests and verify the current overlapping ownership fails.
- [ ] Step 4: Narrow requesting first and test it, then narrow receiving and test it.
- [ ] Step 5: Run both suites, self-review that ad hoc review remains usable, and commit the public-boundary changes.

### Task 6: Make executing-plans an honest no-subagent fallback

**Files:**

- Modify: `skills/executing-plans/SKILL.md`
- Modify: `tests/claude-code/test-lean-delivery-contracts.sh`
- Add candidate evidence: `tests/codex/sdd-behavior/results/lean-risk-scaled/runs/candidate-06-executing-plans/{manifest.json,summary.md,raw/no-subagent-fallback-*.json}`

**Interfaces and contracts:**

- `executing-plans` consumes the same spec-linked plan, risk fields, focused verification lanes, and finding taxonomy but performs work in the controller context.
- It runs author verification per task and one final independent review only when a reviewer is actually available.
- It resolves the ignored plan workspace through `skills/subagent-driven-development/scripts/sdd-workspace PLAN_FILE` and writes `execution-report.md`.
- The fallback report contains the plan/spec identity, completed tasks, focused/integration verification lanes, controller rulings, deviations, follow-ups, remaining risks/decisions, reviewer availability/result, and exact implementation HEAD.
- The fallback report carries the separate final-evidence correction count. On a matching finishing return, executing-plans archives the rejected handoff, preserves that count, refreshes evidence and optional review at a new HEAD, and never retries a failed HEAD.

**Dependencies:** Tasks 2, 4, and 5 define the plan, workspace/report schema, and independent-review boundary consumed by the fallback.

**Risk class and triggers:** `review-required`; public fallback contract and multi-owner report/finishing invariant.

**Focused verification lane:** executing-plans static contract plus paired no-subagent-fallback behavior samples.

**Acceptance criteria:**

- Normal guidance selects this skill only when subagents are unavailable.
- The skill does not claim fresh implementers, checkpoint reviews, typed roles, or other guarantees it does not provide.
- The explicit self-hosting override remains valid for this one implementation plan.
- A completed inline run produces the full report at current implementation HEAD even when no independent reviewer exists.
- A valid producer return resumes the bounded final-evidence gate; the same supported failure stops before correction round three.

**Error handling:**

- Missing spec, critical plan gap, repeated verification failure, or unresolved WHAT decision stops execution.
- Lack of a reviewer is disclosed in the final report; it does not generate a fabricated review result.

**Verification:**

- Run: `bash tests/claude-code/test-lean-delivery-contracts.sh`
- Expected: fallback routing, honest claims, producer-return archive/resume, separate final-evidence count, failed-HEAD non-retry, stop conditions, and self-hosting exception assertions pass.
- Score `candidate-06-executing-plans` against the baseline-matched no-subagent-fallback sample count.
- Expected: every candidate produces the complete report without fabricating reviewer evidence.

**Codebase pointers:**

- Keep the current direct task loop in `skills/executing-plans/SKILL.md`.
- Align plan fields and finishing handoff with Tasks 2, 4, and 7.

- [ ] Step 1: Read executing-plans beside the revised plan and SDD contracts.
- [ ] Step 2: Add failing tests for false claims and missing fallback evidence.
- [ ] Step 3: Run them and verify the current redirect-only prose fails.
- [ ] Step 4: Rewrite only the no-subagent contract and required evidence handoff.
- [ ] Step 5: Run focused tests, self-review both normal and bootstrap paths, and commit the fallback.

## Chunk 4: Finishing, roles, and complete evidence

### Task 7: Give finishing sole ownership of full verification, reporting, and cleanup

**Files:**

- Modify: `skills/finishing-a-development-branch/SKILL.md`
- Modify: `tests/claude-code/test-worktree-path-policy.sh`
- Modify: `tests/claude-code/test-custom-policy-contracts.sh`
- Modify: `tests/claude-code/test-lean-delivery-contracts.sh`
- Modify: `tests/codex/sdd-behavior/scenarios/finishing-evidence.md`
- Add candidate evidence: `tests/codex/sdd-behavior/results/lean-risk-scaled/runs/candidate-07-finishing/{manifest.json,summary.md,raw/finishing-evidence-*.json}`
- Add final-evidence transition baseline/candidate evidence: `tests/codex/sdd-behavior/results/lean-risk-scaled/runs/{baseline-finishing-return-v2,candidate-final-r4-paired}/{manifest.json,summary.md,raw/finishing-evidence-*.json}`

**Interfaces and contracts:**

- Finishing accepts a plan-scoped `execution-report.md` whose recorded implementation HEAD must equal current HEAD.
- A valid stale/dirty/suite-failed/mixed-range handoff writes a plan-scoped `producer-return.md` containing producer identity, failed and observed HEADs, reason, command/result, and the copied final-evidence correction count. Malformed or unidentifiable handoffs stop without inventing a marker.
- After the sole complete-suite run, finishing appends exact command/result evidence, copies the report to `docs/superpowers/execution-reports/<plan-basename>-<short-implementation-head>.md`, commits only that report, and verifies the implementation-HEAD-to-HEAD range.

**Dependencies:** Tasks 4 and 6 are the two valid producers of the report finishing consumes.

**Risk class and triggers:** `review-required`; destructive cleanup, public integration behavior, and exact-HEAD multi-owner invariant.

**Focused verification lane:** worktree/report static contracts plus paired finishing-evidence behavior samples.

**Acceptance criteria:**

- A stale report returns to SDD final review before any suite or integration menu.
- A suite-failed HEAD is recorded and never retried; the producer must refresh evidence and review at a new HEAD while preserving the two-round final-evidence budget.
- The full suite runs once against implementation HEAD; implementation changes after that invalidate the evidence.
- The report-only commit contains no implementation file.
- Merge, PR, and keep paths preserve the report; confirmed discard removes it with the branch.
- Worktree removal refusal shows uncommitted files and asks whether to commit, move, or delete; no autonomous force removal occurs.
- Start with five paired fresh-context finishing samples covering the suite/report-only path, valid stale return, suite-failure return, marker/archive/count preservation, refreshed new-HEAD review, failed-HEAD non-retry, and mixed report ranges. If exactly one baseline sample fails, expand both baseline and candidate to ten.

**Error handling:**

- Stop on stale/malformed report, failing suite, report-copy collision, non-report changes in the report commit range, or refused cleanup.
- Preserve externally managed detached worktrees and require exact `discard` confirmation before destructive cleanup.

**Verification:**

- Run: `bash tests/claude-code/test-worktree-path-policy.sh && bash tests/claude-code/test-custom-policy-contracts.sh && bash tests/claude-code/test-lean-delivery-contracts.sh`
- Expected: exact-HEAD, single-suite, producer-return identity/count, failed-HEAD non-retry, report-only range, preservation, refusal guard, detached-worktree, and discard assertions pass.
- Score `candidate-07-finishing` against its original baseline, then score `candidate-final-r4-paired` against `baseline-finishing-return-v2`, starting with five revised-prompt samples and expanding both runs to ten only when the baseline is 4/5.
- Expected: every candidate selects the correct proceed/stop behavior without a second full-suite run.

**Codebase pointers:**

- Restore the refusal recovery choice from `origin/main:skills/finishing-a-development-branch/SKILL.md`.
- Preserve the current environment detection and reduced detached-HEAD menu.

- [ ] Step 1: Read current/upstream finishing and the revised SDD report contract.
- [ ] Step 2: Add failing exact-HEAD, report-only, and removal-refusal assertions.
- [ ] Step 3: Run focused tests and verify the current finishing flow lacks the report contract.
- [ ] Step 4: Implement the minimum verification, report, integration, and cleanup instructions.
- [ ] Step 5: Run focused tests, self-review destructive boundaries, and commit finishing behavior.

### Task 8: Consolidate Codex roles and make packaged fallback truthful

**Files:**

- Create: `.codex/agents/reviewer.toml`
- Create: `.codex/agents/implementer.toml`
- Modify: `.codex/agents/implementer-deep.toml`
- Keep: `.codex/agents/topic-context.toml`
- Delete: `.codex/agents/{code-reviewer,implementer-spark,implementer-standard,plan-reviewer,spec-document-reviewer,spec-reviewer}.toml`
- Modify: `skills/brainstorming/SKILL.md`
- Modify: `skills/brainstorming/spec-document-reviewer-prompt.md`
- Modify: `skills/brainstorming/references/spec-review-checklist.md`
- Modify: `skills/brainstorming/references/delivery-routing.md`
- Modify: `skills/gathering-topic-context/SKILL.md`
- Modify: `skills/using-superpowers/references/codex-tools.md`
- Modify: `scripts/package-codex-plugin.sh`
- Modify: `tests/codex/test-package-codex-plugin.sh`
- Modify: `tests/claude-code/test-sdd-custom-contracts.sh`
- Modify: `tests/claude-code/test-custom-policy-contracts.sh`
- Add candidate evidence: `tests/codex/sdd-behavior/results/lean-risk-scaled/runs/candidate-08-role-fallback/{manifest.json,summary.md,raw/missing-role-fallback-*.json}`

**Interfaces and contracts:**

- Surviving role names are `sp_reviewer`, `sp_implementer`, `sp_implementer_deep`, and `sp_topic_context`.
- Each role has distinct access/responsibility metadata; reviewer and topic roles are read-only.
- Every skill checks the runtime-advertised role list and uses an untyped `fork_turns: "none"` dispatch when its role is absent.
- Package output states that `.codex/agents` is repository-local and proves the archive's skills remain operable through generic fallback.

**Dependencies:** Tasks 2, 4, 5, and 7 must have migrated all role callers before alias deletion.

**Risk class and triggers:** `review-required`; cross-system Codex/plugin contract and public dispatch availability.

**Focused verification lane:** role inventory, caller search, package inspection, and paired missing-role-fallback behavior samples.

**Acceptance criteria:**

- No live skill or prompt references a deleted role name.
- Missing-role behavior completes implementation and review without silently reducing coverage.
- Wait guidance uses one long event wait only when idle and never short-timeout polling.
- Archive tests assert no project role registry is claimed or shipped through unsupported manifest fields.
- Brainstorming's topic and spec reviews use the surviving roles or their generic fallbacks.
- Brainstorming's checklist uses the shared four dispositions and its delivery route advertises risk-scaled work units rather than unconditional per-task review.
- Gathering topic context checks advertised roles and uses the unchanged prompt through an untyped fresh agent when `sp_topic_context` is unavailable.

**Error handling:**

- Never intentionally request an unknown role to discover availability.
- If neither typed nor generic agents are available, route to `executing-plans` or disclose unavailable independent review instead of fabricating it.

**Verification:**

- Run: `bash tests/codex/test-package-codex-plugin.sh && bash tests/claude-code/test-sdd-custom-contracts.sh && bash tests/claude-code/test-custom-policy-contracts.sh`
- Expected: role inventory, every caller's untyped fresh fallback, shared brainstorming taxonomy, risk-scaled route wording, read-only reviewers, event waits, archive truthfulness, and manifest checks pass.
- Score missing-role candidate samples.
- Expected: every sample completes through untyped dispatch with review coverage preserved.

**Codebase pointers:**

- Use `.codex/config.toml` and current role TOMLs for project discovery.
- Use the official Context7 findings above for supported discovery and manifest boundaries.
- Preserve the source-correct lifecycle names already in `skills/using-superpowers/references/codex-tools.md`.

- [ ] Step 1: Read every typed-role caller, role file, package inventory rule, and missing-role baseline result.
- [ ] Step 2: Add failing role-inventory, deleted-caller, package-truth, and fallback behavior assertions.
- [ ] Step 3: Run focused tests and missing-role probes to establish RED.
- [ ] Step 4: Add the minimal roles, migrate callers one skill at a time, delete aliases, and document generic fallback.
- [ ] Step 5: Run package/static tests and candidate samples, inspect the archive, and commit role consolidation.

### Task 9: Run whole-flow regression and publish the evaluation record

**Files:**

- Create: `tests/codex/sdd-behavior/scenarios/{available-role-dispatch,brainstorming-review-gates,java-profile-taxonomy}.md`
- Complete: `tests/codex/sdd-behavior/results/lean-risk-scaled/runs/candidate-final-r3/{manifest.json,summary.md,AUDIT.md,raw/*.json}`
- Complete: `tests/codex/sdd-behavior/results/lean-risk-scaled/runs/{baseline-finishing-return-v2,candidate-final-r4-paired}/{manifest.json,summary.md,raw/*.json}`
- Create: `tests/codex/sdd-behavior/results/lean-risk-scaled/runs/candidate-final-r4/` with the exact-revision edge samples, retained smoke bundle/artifacts/trace, checked summary, and independent audit.
- Modify: `docs/testing.md`
- Modify: `README.md`
- Modify: `RELEASE-NOTES.md`
- Modify: `tests/claude-code/run-skill-tests.sh`
- Modify: `tests/claude-code/test-lean-delivery-contracts.sh`

**Interfaces and contracts:**

- `candidate-final-r3` is the authoritative result for the eight original paired scenarios. `candidate-final-r4-paired` is the authoritative five- or conditionally ten-sample RED/GREEN result for the revised finishing-return scenario. `candidate-final-r4` holds five passing samples for each of the three candidate-only edge scenarios plus the retained successful smoke; its summary does not claim a synthetic baseline.
- Documentation describes the normal pipeline, removed `refining-plans`, risk-scaled cadence, two-round breaker, generic role fallback, and sole full-suite owner.

**Dependencies:** Tasks 1–8 must be committed and their run manifests must record their exact revisions.

**Risk class and triggers:** `review-required`; public documentation, cross-task integration, and destructive finishing behavior.

**Focused verification lane:** all eight original paired scenario sets, the five- or conditionally ten-sample paired finishing-return revision, five candidate-only samples for each of the three final exact-revision edge scenarios, one successful end-to-end smoke run, static/workspace/package tests, and stale-reference search.

**Acceptance criteria:**

- For the eight original scenarios and revised finishing-return scenario only, candidate count matches each five- or ten-sample baseline set and every candidate sample passes.
- Each behavior used to justify wording changes improves by at least two samples; baseline 5/5 behaviors do not retain unnecessary extra wording. The three candidate-only edge probes each run exactly five times and must pass 5/5; they are invariant checks, not improvement claims.
- One clean smoke execution catches and rules on the seeded preflight issue, batches ordinary work, isolates the risky task, fixes its seeded implementation defect after one correction, completes final review and durable report handoff, runs finishing's sole complete suite, creates the report-only commit, and cleans only owned temporary state.
- The separate circuit-breaker samples, not the successful smoke run, stop after two failed corrections.
- Producer-return scenarios cover stale and suite-failed handoffs, archival of rejected evidence, refreshed final review at a new HEAD, preservation of the separate final-evidence count, and refusal to retry the failed HEAD.
- Static, workspace, packaging, explicit-trigger, and relevant runtime tests pass from a clean checkout.
- Repository search finds no stale live role, five-round, per-task-unconditional-review, duplicate-review-owner, or refining-plans route.

**Error handling:**

- Any unexplained candidate failure, scorer disagreement, stale result revision, or regression blocks completion.
- If two scorers disagree on prose, reconcile against raw events and preserve both original judgments in the result record.

**Verification:**

- Run: `bash tests/codex/sdd-behavior/test-score-results.sh`
- Run: `python3 tests/codex/sdd-behavior/score-results.py tests/codex/sdd-behavior/results/lean-risk-scaled/runs/candidate-final-r3 --baseline tests/codex/sdd-behavior/results/lean-risk-scaled/runs/baseline-d9a937091926 --baseline tests/codex/sdd-behavior/results/lean-risk-scaled/runs/baseline-fallback-v2`
- Run: `python3 tests/codex/sdd-behavior/score-results.py tests/codex/sdd-behavior/results/lean-risk-scaled/runs/candidate-final-r4-paired --baseline tests/codex/sdd-behavior/results/lean-risk-scaled/runs/baseline-finishing-return-v2`
- Run: `python3 tests/codex/sdd-behavior/score-results.py tests/codex/sdd-behavior/results/lean-risk-scaled/runs/candidate-final-r4`
- Run: `bash tests/claude-code/test-sdd-workspace.sh && bash tests/claude-code/test-sdd-custom-contracts.sh && bash tests/claude-code/test-custom-policy-contracts.sh && bash tests/claude-code/test-worktree-path-policy.sh && bash tests/claude-code/test-lean-delivery-contracts.sh`
- Run: `bash tests/codex/test-package-codex-plugin.sh`
- Expected: every command exits zero and the scored candidate meets all thresholds.

**Codebase pointers:**

- Use `docs/testing.md` as the canonical test/eval distinction.
- Keep historical release notes intact and add a new current entry rather than rewriting history.
- Update README workflow claims only where the implemented behavior changed.

- [ ] Step 1: Read all changed contracts, stored baseline/candidate results, and public workflow descriptions.
- [ ] Step 2: Add final stale-reference and documentation-alignment assertions before editing docs.
- [ ] Step 3: Run the complete focused matrix and verify any remaining mismatch fails explicitly.
- [ ] Step 4: Make only evidence-backed cleanup/documentation edits and complete missing candidate samples.
- [ ] Step 5: Run all verification commands from a clean checkout, self-review the full diff, and commit the final evidence.

## Invariant-to-Task Mapping

- Invariant: planning and execution share one risk trigger set.
  - Implemented in: Tasks 2 and 4.
  - Re-verified in: Task 9 contract and cadence scenarios.
  - Failure mode if omitted: a task is low-risk in planning but unexpectedly gains or loses review during execution.
- Invariant: one proof-bearing finding taxonomy governs every review stage.
  - Implemented in: Tasks 2, 4, and 5.
  - Re-verified in: Task 9 scope-pressure and circuit-breaker scenarios.
  - Failure mode if omitted: later reviewers enlarge scope or restart correction loops under new labels.
- Invariant: execution and finishing evidence bind to one implementation HEAD.
  - Implemented in: Tasks 4 and 7.
  - Re-verified in: Task 9 smoke run and static contract suite.
  - Failure mode if omitted: the committed report claims tests/review for code that changed afterward.
- Invariant: typed roles and generic fallback preserve the same coverage.
  - Implemented in: Tasks 4, 5, and 8.
  - Re-verified in: Task 9 missing-role samples and package inspection.
  - Failure mode if omitted: packaged installs silently skip implementation or review work.
- Invariant: only finishing runs the complete suite and cleans SDD state.
  - Implemented in: Tasks 4, 6, and 7.
  - Re-verified in: Task 9 static suite and smoke event trace.
  - Failure mode if omitted: repeated suites and premature workspace deletion recreate the observed long-running churn.

## Whole-Feature Verification

Task 9 is the whole-feature verification gate. It must establish that the revised route remains faithful from an approved specification through plan readiness, preflight, work-unit dispatch, risk-scaled review, bounded fixes, exact-HEAD report handoff, final suite, report-only commit, and safe integration choice.

The gate must answer:

- Ordinary and review-required work receive their intended cadence without losing protected-boundary review.
- Reversible HOW and observable WHAT choices route to different authorities.
- Scope pressure produces one blocker and two follow-ups, not three blockers.
- The third attempted correction never starts.
- Missing project roles preserve behavior through generic fresh agents.
- A stale report, modified implementation after verification, or refused cleanup stops safely.
- A valid stale or suite-failed handoff returns durably to its producer, refreshes final evidence at a new HEAD within the preserved two-round budget, and never reruns finishing against the failed HEAD.
- No surviving skill claims ownership of another stage's gate.

## Author Self-Review

- Spec coverage: all scope items in sections 4 through 9 map to Tasks 1 through 9.
- Scope: no GSD, frontend-direction, visual-companion, application-production, or upstream-PR work is included.
- Concrete anchors: role names, report path, implementation HEAD, scenario names, risk triggers, dispositions, two-round cap, exact baseline revisions, and plugin boundary are preserved verbatim.
- Cross-task consistency: Tasks 2 and 4 share the risk set; Tasks 4 and 7 share the report/HEAD contract; Tasks 4, 5, and 8 share role fallback; Task 9 verifies all of them.
- TDD order: every task reads pointers, writes failing assertions, verifies RED, makes the minimum change, then verifies/self-reviews/commits.
- Placeholders: dynamic raw-result filenames are bounded by fixed scenario/repetition naming; no requirement or implementation decision is deferred.
- Bootstrap: this plan names only root-controlled `executing-plans`; current SDD is a test subject, never the controller.

## Readiness Record

**Author self-review:** Complete after correcting the plan header and review record; assigning the final-evidence return protocol and all live role, taxonomy, specialist-profile, and routing references to explicit task owners; adding the missing paired producer-return behavior probe; and making the r3 paired, r4 paired, and r4 candidate-only scoring commands unambiguous.

**Independent readiness gate:** READY after correction round 2 and one user-authorized, FX-1-only breaker exception; the same reviewer found no fix-introduced inconsistency.

**Result:** READY

| ID | Disposition | Ruling or resolution | Evidence carried forward |
| --- | --- | --- | --- |
| DC-1 | BLOCKING | Corrected the self-hosting plan so it satisfies the same handoff schema imposed on generated plans. | Header, Author Self-Review, and this Readiness Record; regression assertions in `tests/claude-code/test-lean-delivery-contracts.sh`. |
| PR-1 | BLOCKING | Extended Tasks 4, 6, 7, and 9 with the separate final-evidence count, producer-return identity, rejected-attempt archival, refreshed new-HEAD evidence/review, preserved two-round budget, and failed-HEAD non-retry. | Report contract and producer/consumer acceptance and verification clauses. |
| PR-2 | BLOCKING | Added `skills/gathering-topic-context/SKILL.md` to Task 8 ownership and required advertised-role checking plus the same-prompt untyped fresh fallback. | Task 8 files, acceptance criteria, and focused verification. |
| PR-3 | BLOCKING | Added the Java checklist to Task 5 and the brainstorming checklist/routing references to Task 8; required the shared taxonomy and risk-scaled route. | Task 5 and Task 8 files, contracts, acceptance criteria, and verification. |
| PR-1-R1 | BLOCKING | Expanded and assigned `finishing-evidence.md` plus baseline-matched paired RED/GREEN result paths to cover suite failure, identity/count marker, archival, refreshed new-HEAD review, preserved breaker state, and failed-HEAD non-retry. | Task 7 files, acceptance criteria, verification, and `baseline-finishing-return-v2` / `candidate-final-r4-paired`. |
| PR-4 | BLOCKING | Split the authoritative final evidence into r3 original paired, r4 paired final-evidence transition, and r4 candidate-only edge probes; fixed exact commands, counts, and pass/improvement rules. | Task 9 files, interface, focused lane, acceptance criteria, and commands. |
| FX-1 | BLOCKING | The human partner explicitly authorized one narrow breaker exception. Reconciled every revised finishing-return count: start at five, and only a 4/5 baseline expands both baseline and candidate to ten. | Task 7 acceptance/verification and Task 9 evidence identity/focused lane; no skill behavior or scenario content changed. |
| FX-1-R1 | INVALID | The same reviewer confirmed the plan now applies one count rule throughout and the wording-only correction introduced no inconsistency. | Final scoped readiness verdict at `be9db7a`: READY. |

## Continuation Prompt

After compacting, say: **Execute the plan at `docs/superpowers/plans/2026-09-04-lean-risk-scaled-superpowers-delivery.md` using `superpowers:executing-plans` under root control. Do not invoke legacy `superpowers:subagent-driven-development`, even though agents are available; use fresh Codex agents only for the plan's bounded behavioral samples and independent reviews.**
