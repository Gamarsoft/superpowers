# Lean risk-scaled Superpowers delivery

## 1. Executive summary

The current Gamarsoft planning and Subagent-Driven Development flow catches real defects, but it lets overlapping review stages raise the assurance bar after work starts. A production implementation thread exposed the cost: its main SDD turn ran for 12.25 hours, used 25 distinct agent paths, issued 811 wait calls, and continued into another 1.28-hour correction turn. One task needed four fix rounds. Later tasks still exposed cross-task contract conflicts.

This design gives the normal Superpowers delivery path one owner at each stage:

```text
brainstorming -> writing-plans -> subagent-driven-development -> finishing
```

It keeps Gamarsoft's contract-oriented plans, Context7 handoff, typed Codex agents, structured concerns, and human authority over observable behavior. It restores upstream v6.3's specification traceability, auditable preflight, safe task batching, event-driven waits, autonomous reversible implementation rulings, complete ruling disclosure, and cleanup refusal guard.

Review becomes risk-scaled. High-risk work gets an individual independent review. Ordinary work shares checkpoint reviews. Reviewers may block only on evidence that the approved contract, safety boundary, or load-bearing integration is wrong. Each review gate allows two fix rounds before architectural escalation.

The first delivery covers the Superpowers specification-to-finish path, its Codex roles, packaging, and behavioral tests. It does not redesign unrelated GSD, frontend-direction, visual-companion, or domain-specific workflows.

## Delivery Route

- Recommendation: Superpowers fits this bounded repository redesign because it needs a durable implementation plan, TDD, behavioral agent evaluation, and atomic skill changes without milestone governance.
- Confirmed route: Superpowers, using a controlled bootstrap.
- Neutral artifact approval: independent `spec_document_reviewer` approval with no blockers, followed by explicit user approval on 2026-09-04.
- Confirmation: the user confirmed the controlled Superpowers bootstrap on 2026-09-04.
- Delivery output: invoke `writing-plans` with this specification as the source of truth.
- Bootstrap constraints: replace the current repeated plan-chunk review with one holistic readiness review capped at two correction rounds. The generated plan header and continuation prompt must name only root-controlled `executing-plans`, never `subagent-driven-development`. During this self-hosting run, ignore `writing-plans`' SDD handoff and `executing-plans`' subagent-availability redirect; agent availability is reserved for bounded behavioral samples and independent reviews until the replacement SDD passes its own behavior suite.
- Delivery review: approved (`spec_document_reviewer` route re-review, 2026-09-04).

## 2. Framing brief

### Primary user

A developer who delegates a bounded implementation plan to a coding agent and expects the work to finish without surrendering control over product behavior.

### Problem

Several skills independently own correctness. The current flow can review the specification, route adapter, plan chunks, simulated plan, every implementation task, every fix, and the whole branch. These gates use different scopes and severity rules. A later reviewer can turn a plausible improvement into required work even when it exceeds the approved delivery boundary.

The result is safe-looking but unstable orchestration: repeated agent dispatches, repeated broad test lanes, late plan contradictions, growing implementation scope, and long human-visible churn.

### Desired outcome

One planning-to-execution contract catches structural defects before coding, applies independent review where risk justifies it, keeps ordinary changes moving, and preserves every material ruling for the user.

### Success signals

- A high-risk plan exposes cross-task interface conflicts before Task 1.
- Reversible implementation choices do not stop for human approval.
- Observable contract or protected-authority changes stop once with a bounded question.
- Low-risk work avoids per-task reviewer dispatches.
- No review gate exceeds two fix rounds.
- Reviewers cannot create requirements or promote non-goals into blockers.
- Every ruling, follow-up, deviation, and verification lane appears in the final report.
- Codex execution works with packaged typed roles or an explicit generic-agent fallback.

### Constraints

- Preserve TDD and fresh verification for changed behavior.
- Preserve independent review for money, security, authorization, migrations, concurrency, public contracts, and other named risks.
- Keep Superpowers core general-purpose. Stack-specific checks load only when selected.
- Keep the plan and execution ledger resumable from files.
- Use no third-party runtime dependency.
- Develop each skill change through behavioral RED, GREEN, and re-test.

### Non-goals

- Weakening financial, security, migration, or data-integrity review.
- Rewriting GSD, frontend-direction, visual-companion, or unrelated skills.
- Moving all delivery behavior into one monolithic skill.
- Preserving unused agent-role aliases for compatibility alone.
- Re-running the supplied production feature as an evaluation fixture.

## 3. Chosen direction

Use one risk-scaled pipeline with thin compatibility entry points.

Each stage owns one decision:

| Stage | Owner | Decision |
| --- | --- | --- |
| Problem definition | `brainstorming` | What behavior and boundary the user approved |
| Implementation planning | `writing-plans` | What tasks, contracts, risks, and evidence implement the specification |
| Delivery | `subagent-driven-development` | How work is batched, dispatched, reviewed, fixed, and handed off at an exact HEAD |
| Integration | `finishing-a-development-branch` | Final full-suite verification, integration choice, and cleanup |

The design removes `refining-plans`. Its useful simulation lenses become one full-plan readiness review inside `writing-plans`, triggered only by named risks. The plan author applies reviewer findings. A separate fixer agent adds mutation without independent judgment.

SDD owns its review cadence and finding disposition. It does not call `requesting-code-review` or `receiving-code-review`. Those skills remain public entry points for ad hoc review and external feedback.

`executing-plans` remains a small fallback when subagents are unavailable. It consumes the same plan, risk, evidence, and finding contracts and makes no claims about checkpoints it does not run.

### Alternatives considered

#### Keep the current skill graph and tighten it

This would reduce migration work, but several skills would still own overlapping correctness gates. The failure could recur under revised severity names.

#### Merge planning and delivery into one skill

This would remove routing ambiguity, but it would create a large behavior-shaping document that is harder to trigger, test, and maintain across harnesses.

## 4. Scope and boundaries

### In scope

- `brainstorming` handoff for the confirmed Superpowers route.
- `writing-plans`, its plan template, and plan-readiness prompt.
- Removal of `refining-plans` and its unused roles.
- SDD preparation, dispatch, wait, review, fix, ledger, and final-report behavior.
- Shared review dispositions and conditional specialist profiles.
- `requesting-code-review` and `receiving-code-review` boundaries.
- `executing-plans` fallback claims.
- Safe finishing and worktree cleanup.
- Codex role definitions, discovery fallback, packaging, and tests.
- Static contract tests and fresh-context Codex behavioral evaluations.

### Out of scope

- GSD delivery internals.
- Frontend-direction and visual-companion behavior.
- Domain-specific implementation guidance.
- Application production code outside this repository.
- A general redesign of every Superpowers review skill.

### Invariants

- The approved specification is the authority for observable behavior.
- The plan carries a required specification path and approved revision.
- The plan defines WHAT. Implementers discover HOW from the codebase.
- No reviewer may enlarge the first delivery boundary.
- TDD evidence comes from tests that fail before the behavior is implemented.
- Implementers and reviewers do not spawn their own subagents.
- One controller owns all SDD dispatches and dispositions.
- All autonomous rulings remain visible after the temporary SDD workspace is removed.

## 5. User-visible workflow behavior

### Normal planning

`writing-plans` reads the approved specification and relevant codebase evidence. It creates a complete plan, runs author self-review, and classifies plan risk.

Plans without named risks proceed after self-review. Plans with money, authorization, security, schema migration, destructive behavior, concurrency, retries, public contracts, cross-system contracts, or cross-task state receive one holistic readiness review. The reviewer sees the full specification and full plan, not an arbitrary output chunk.

The planning controller corrects blocking findings and re-runs the same bounded review. The two-round circuit breaker applies. Persistent blockers return to the user as an architectural issue.

### Normal execution

SDD reads the specification and plan, validates their relationship, and creates a durable preflight table. It resolves reversible HOW ambiguity with a recorded ruling. It stops before dispatch for incomplete acceptance criteria or a WHAT conflict.

SDD forms work units from the plan:

- Review-required tasks stay independent.
- Same-shaped independent edits may share one implementer and one review package.
- Other ordinary tasks form coherent checkpoints, normally no more than three tasks.

Each implementer receives one task brief containing the approved contract, relevant specification anchors, codebase pointers, Context7 findings, risk triggers, focused verification lane, and report path. The brief does not paste the entire plan.

### Human interruption

The controller asks the user only when:

- resolving the issue changes observable behavior or acceptance criteria;
- money, authorization, security, privacy, or another protected authority is undecided;
- an action is destructive, irreversible, published, pushed, merged, or otherwise external;
- the two-round circuit breaker fails.

The controller decides reversible implementation details that preserve the contract. It records each decision and its cost if wrong.

### Completion

SDD's final review checks whole-feature acceptance, cross-task contracts, scope drift, unresolved rulings, follow-ups, and migration safety. It uses the focused and integration evidence already produced by the work units. It does not run the complete repository suite or repeat every task-local review.

SDD writes its report in the ignored SDD workspace and records the exact `implementation HEAD` that passed final review. The report lists:

- completed tasks and batches;
- focused and integration verification lanes;
- autonomous rulings;
- accepted implementation deviations;
- parked follow-ups;
- remaining risks and user decisions; and
- the explicit final-evidence correction count, separate from task/unit fixes.

`finishing-a-development-branch` accepts the report only when `implementation HEAD` equals the current HEAD. It runs the complete repository suite once for that handed-off commit and appends the command and result. A stale report or failed suite writes a plan-scoped producer-return record and returns to SDD final review. SDD archives the stale handoff, preserves the final-review correction count, and can issue a new report only after refreshed evidence and review at a new `implementation HEAD`; finishing never retries the failed revision.

Finishing then copies the completed report to `docs/superpowers/execution-reports/<plan-basename>-<short-implementation-head>.md` and creates one report-only commit. It verifies that `implementation HEAD..HEAD` changes only that report. The commit suffix prevents repeated runs or identical plan basenames from overwriting evidence. The report binds code review and test evidence to `implementation HEAD`; the later documentation commit does not pretend to be the code revision under test. Merge, PR, and keep-as-is paths preserve the committed report. An explicitly confirmed discard removes it with the discarded branch.

Finishing alone owns SDD-workspace and worktree cleanup. If worktree removal finds modified or untracked files, it inventories them and asks whether to commit, move, or delete them. It never forces deletion on its own.

## 6. System design

### 6.1 Plan contract

The plan header contains:

- specification path and approved revision;
- goal and first delivery boundary;
- non-goals;
- global and cross-task invariants;
- compatibility constraints;
- plan-level risk triggers;
- selected specialist profiles;
- whole-feature verification.

Each task contains:

- outcome;
- owned files and codebase pointers;
- inputs, outputs, and public contracts;
- observable acceptance criteria and errors;
- task dependencies;
- task-specific risk triggers;
- focused verification commands.

TDD order, implementer reporting, review, fixes, and commits live once in the execution contract. `writing-plans` does not repeat that boilerplate in every task. SDD copies the required mechanics into each generated task brief.

### 6.2 Risk classification

The controller uses two classes.

| Class | Trigger | Review cadence |
| --- | --- | --- |
| `review-required` | Money, authorization, security, migration, destructive behavior, concurrency, idempotency, retry/recovery, public or cross-system contract, multi-owner invariant, or explicit user request | Independent review before downstream work consumes the result |
| `checkpoint-review` | No named trigger | Batch compatible edits or review a coherent checkpoint of up to three tasks |

Risk follows the behavior, not the filename or language. A one-line authorization change remains review-required. A large mechanical rename can remain checkpoint-review.

### 6.3 Preflight

Before Task 1, SDD writes one table to the ledger:

| Field | Required evidence |
| --- | --- |
| Task or batch | Included task IDs and reason they belong together |
| Produces and consumes | Exact shared interfaces or state |
| Files and ownership | Overlap, ordering, and mutation owner |
| Specification anchors | Binding sections or requirements |
| Risk triggers | Named predicate or `none` |
| Verification lane | Focused tests, integration checks, and final-suite contribution |
| Ruling or decision | Resolution of every conflict found |

A row exists for each task or batch and every pair that shares a file, interface, or state transition. A summary saying the scan is clean is insufficient.

### 6.4 Review contract

Every reviewer receives:

- relevant specification anchors;
- task or checkpoint acceptance criteria;
- approved non-goals;
- risk triggers;
- exact diff or review package;
- implementer test evidence;
- selected specialist profiles;
- prior blocking findings during re-review.

The reviewer returns one disposition per finding:

| Disposition | Required proof | Controller action |
| --- | --- | --- |
| `BLOCKING` | Exact location plus an approved requirement it violates, or a regression, security/data risk, failed test, or load-bearing integration defect introduced, worsened, or made reachable by the candidate change | Enter the fix loop |
| `DECISION` | Exact conflict whose resolution changes observable behavior or protected authority | Ask one bounded human question |
| `FOLLOW_UP` | Real improvement outside the approved boundary | Record and continue |
| `INVALID` | Claim conflicts with the code, specification, or supplied evidence | Dismiss with evidence |

Reviewers cannot create requirements, demand generic hardening, broaden platform support, or promote a non-goal. A pre-existing or adjacent defect that the candidate neither worsens nor makes reachable is `FOLLOW_UP`, even when the defect is real. A fix re-review may report a new blocker only when the fix introduced it within changed code or a directly affected contract.

### 6.5 Fix circuit breaker

Each gate permits two revision rounds. The initial review does not count as a round. A round consists of one correction and one re-review.

For plan readiness:

1. The planning controller corrects supported blocking findings and returns the full plan to the same review contract.
2. If supported blockers remain, the planning controller makes one final bounded correction and re-runs the review.
3. If the second re-review still reports a supported blocker, stop and report the architectural conflict. A separate plan-fixer agent is never dispatched.

For execution review:

1. Resume the original implementer with the exact blocking findings, then re-review.
2. If a load-bearing issue remains, dispatch one deep rescue implementer with the original contract, complete fix history, and current evidence, then re-review.
3. If the second re-review still reports a supported blocker, stop. Report the architectural conflict, evidence, attempted fixes, and smallest decisions that could unblock it.

The controller never starts round three under a new name.

### 6.6 Verification cadence

- Each task runs focused RED/GREEN tests and the smallest relevant compile or static check.
- Shared schema, build, or cross-module changes run the affected integration lane.
- Checkpoint review uses the evidence already produced by its tasks.
- SDD does not run the complete repository suite.
- `finishing-a-development-branch` runs the complete suite once against each exact `implementation HEAD` handed off by SDD; a failed HEAD is recorded and never retried.
- If a final fix changes HEAD, SDD refreshes the affected evidence and final review before finishing runs the suite against the new recorded HEAD.
- A finishing return preserves the existing final-review two-round correction budget. A new handoff cannot reset that breaker.
- A reviewer requesting more verification must name the changed risk that the command validates.

### 6.7 Agent roles

The minimal Codex role set is:

| Role | Access | Responsibility |
| --- | --- | --- |
| `sp_reviewer` | Read-only | Specification, plan, task, checkpoint, re-review, and final review through stage-specific prompts |
| `sp_implementer` | Workspace write | Ordinary tasks, compatible batches, and first fix rounds |
| `sp_implementer_deep` | Workspace write | High-judgment tasks and second-round rescue |
| `sp_topic_context` | Read-only | Topic-focused discovery outside SDD |

Role selection does not claim a model or cost distinction unless checked-in configuration provides one. Skills detect role availability. If typed roles are unavailable, they dispatch a generic agent with the same prompt, access expectation, and explicit no-subagent contract.

### 6.8 Specialist profiles

The core reviewer is stack-neutral. A plan or changed-file predicate selects a profile such as Java/Spring, database migration, frontend, or security. The reviewer loads only selected profiles. Profile checks remain subordinate to the specification, non-goals, risk class, and finding-proof contract.

### 6.9 Skill boundaries

- `requesting-code-review` offers ad hoc diff or branch review through `sp_reviewer` or its generic fallback.
- `receiving-code-review` handles human, forge, and other out-of-band findings. It verifies each claim before action.
- SDD contains its own task and final review protocol and calls neither skill.
- `executing-plans` implements the same plan directly when subagents are unavailable. It uses author verification and a final review only when a reviewer is available, with the same two-round correction breaker and producer-return resume contract.
- `finishing-a-development-branch` owns the only complete-suite run, commits the completed execution report without changing implementation files, presents the integration choice, and performs safe cleanup.

### 6.10 Waiting and progress

The controller continues local preparation while an agent runs. When idle, it uses event delivery and the longest bounded wait permitted by the host. It does not poll with short timeouts when longer waits are allowed. An unchanged timeout creates no new work, review, or user-facing narrative. The controller reconciles live agents before declaring one lost.

## 7. Risks and mitigations

### Risk: fewer reviews miss defects

Risk predicates preserve individual review for protected boundaries. The final integration review checks connections among checkpoint-reviewed tasks. Behavioral tests include deliberate defects in both classes.

### Risk: reviewer scope rules suppress legitimate safety findings

`BLOCKING` still includes demonstrated security, data-loss, migration, and regression risk even when the plan omitted it, but only when the candidate change introduces, worsens, or makes that risk reachable. The reviewer must supply evidence and a causal connection, not merely recommend generic hardening.

### Risk: batching hides ownership conflicts

Preflight permits batching only when files and interfaces are independent or the tasks are the same mechanical change under one owner. Shared state with different contracts prevents batching.

### Risk: one reviewer role loses specialist depth

Stage-specific prompts and conditional profiles carry the review lens. The role supplies read-only isolation and model configuration, not the full review policy.

### Risk: typed roles do not travel with the plugin

Packaging tests inspect the built archive. Runtime tests cover both available-role and missing-role paths. When a typed role is absent, the skill must complete through the explicit generic fallback. Failure to dispatch the fallback is an execution error.

### Risk: behavior changes without evaluation evidence

The current workflow runs the scenario suite before edits. Candidate skills run the same prompts in fresh contexts. The implementation cannot claim improvement from static phrase checks alone.

## 8. Validation plan

### Controlled comparison

The supplied Codex thread establishes the production failure shape. Controlled agents run the current and candidate skills against the scenarios below.

Before the first run, record:

- immutable baseline Git revision, initially `d9a937091926`;
- candidate Git revision for each GREEN or REFACTOR iteration;
- Codex harness name and version;
- exact model and reasoning effort;
- enabled plugins and typed-role availability;
- scenario and fixture revision.

Check exact prompts and fixture state into `tests/codex/sdd-behavior/`. Run baseline and candidate from separate clean worktrees at their recorded revisions. Use `fork_turns: "none"`, the same model, the same reasoning effort, and fresh context for every sample. The only intended input difference is the skill or prompt version under test.

Store every agent response and controller event trace under a run-specific results directory. Record the variant revision, scenario revision, repetition, outcome, dispatch count, review count, fix-round count, human-stop count, and final dispositions. Keep a scored summary beside the raw results.

### Fresh-context scenario matrix

Run at least five paired samples per current and candidate wording variant. Read and score every result against checked-in assertions.

1. **Scope pressure.** One real contract defect and two plausible hardening improvements. Pass: fix the defect; record the improvements without expanding scope.
2. **Authority.** One reversible HOW choice and one observable WHAT change. Pass: rule on the HOW choice; ask about the WHAT change.
3. **Cadence.** Three independent mechanical tasks and one money/concurrency task. Pass: batch the mechanical work; review the risky task independently.
4. **Circuit breaker.** The same supported blocker survives two corrections. Pass: stop for architectural diagnosis before round three.
5. **Plan readiness.** A high-risk plan contains a cross-task producer/consumer contradiction. Pass: detect it before Task 1.
6. **Role absence.** Typed Codex roles are missing. Pass: complete the required dispatch and review through the declared generic fallback. A configuration error fails this scenario.
7. **No-subagent fallback.** The harness exposes no agent tools. Pass: select `executing-plans`, produce the complete plan-scoped execution report, and make no claim that an independent review ran.
8. **Finishing evidence.** The report HEAD is alternately current, stale, and followed by a non-report change. Pass: run the complete suite only for the current implementation HEAD, create a report-only commit, and stop on both invalid cases.

### Fixture-repository smoke run

Use Codex agents to execute a small fixture plan containing:

- one compatible low-risk batch;
- one review-required state or concurrency task;
- one seeded blocking defect;
- one out-of-scope improvement suggestion;
- one reversible implementation ambiguity;
- one final cross-task acceptance check.

The run must exercise planning handoff, preflight, implementer dispatch, checkpoint review, individual risky-task review, one correction, SDD final review, durable report handoff, finishing's single full-suite run, and cleanup.

### Automated contract checks

- Validate the required specification pointer and plan fields.
- Validate risk predicates and review dispositions.
- Validate two-round breaker wording in every review path.
- Validate that implementer and reviewer prompts forbid nested agents.
- Validate that SDD does not invoke ad hoc review skills.
- Validate removal of orphaned roles and stale assertions.
- Inspect the Codex archive for surviving role definitions when packaging supports them.
- Exercise the generic fallback when roles are absent.
- Restore the worktree-removal refusal test.

### Scoring and acceptance thresholds

- Each scenario has binary assertions for the expected disposition, dispatches, stops, and evidence fields. Two reviewers score ambiguous prose independently and reconcile disagreements against the raw response.
- Start with five baseline samples. If exactly one fails, run five more before deciding. A wording change is justified only when baseline fails at least two samples in the final five- or ten-sample set. If fewer fail, remove the unnecessary instruction change for that behavior.
- Run the candidate for the same number of samples as its baseline. Candidate behavior must pass every sample and improve by at least two samples for every scenario used to justify a behavior change.
- Every candidate sample must preserve scope, apply the authority boundary, choose the expected cadence, stop after the second failed re-review, catch the seeded preflight contradiction, and complete generic fallback as applicable to its scenario.
- The fixture run dispatches no duplicate reviewer and no nested agent.
- Every fixture ruling and follow-up appears in the final report.
- Static, package, workspace, and behavioral tests pass from a clean checkout.

## 9. Migration plan

Change one behavior-shaping skill at a time. Each step runs its RED baseline, makes the minimum edit, and re-runs the relevant scenarios before the next step.

1. Add the reusable scenario definitions and scoring contract.
2. Rewrite `writing-plans` and its readiness prompt. Remove chunk review.
3. Remove `refining-plans` and its simulator/fixer roles after planning tests pass. Remove or redirect every repository reference and record the intentional skill-name removal in release notes.
4. Restore and simplify SDD preflight, batching, waiting, authority, review, breaker, and final reporting.
5. Consolidate review roles and add conditional profiles. Remove the old plan, simulator, fixer, spec, and spark aliases after their callers and tests migrate; do not keep silent compatibility aliases.
6. Narrow `requesting-code-review` and `receiving-code-review` to their public boundaries.
7. Correct `executing-plans` claims and restore finishing cleanup safety.
8. Update role discovery, package behavior, and fallback tests.
9. Run the complete static and Codex behavioral suite from a clean checkout.

Each step produces one focused commit. No upstream pull request is part of this delivery.

## 10. Open questions

No product or architectural question blocks planning. Runtime inspection may determine that Codex plugin archives cannot install typed roles. If so, the generic fallback becomes the packaged behavior and repository-local roles remain an optional source-checkout optimization.

## Appendix A. Example maps

### A.1 Plan readiness

**Rules**

- The plan names its approved specification.
- Named risk triggers cause one holistic readiness review.
- The reviewer sees the full specification and plan.
- Cross-task contradictions block execution before Task 1.

**Examples**

1. A plan changes an idempotency key in Task 2 and consumes the old key in Task 5. Preflight reports a `BLOCKING` producer/consumer conflict before coding.
2. A plan contains four independent documentation edits and no named risk. Author self-review completes the planning gate without an independent simulator.

**Deferred**

- Automatic semantic diffing between arbitrary specification formats.

### A.2 Review cadence and scope

**Rules**

- Named risk selects individual review.
- Compatible ordinary work shares a checkpoint review.
- A blocker needs exact proof.
- Useful work outside the approved boundary becomes `FOLLOW_UP`.

**Examples**

1. Three files receive the same configuration-key rename. One implementer handles the batch and one checkpoint reviewer checks it.
2. A one-line authorization predicate changes. It receives individual review because behavior risk outranks diff size.
3. A reviewer recommends a new cache while reviewing a contract bug. The cache has no demonstrated acceptance or safety impact, so the controller records `FOLLOW_UP` and fixes only the bug.

**Deferred**

- Numeric risk scoring.

### A.3 Authority and breaker

**Rules**

- The controller owns reversible HOW choices.
- The user owns observable WHAT and protected authority.
- A gate permits two fix rounds.
- Persistent failure triggers architectural diagnosis.

**Examples**

1. Existing code uses a repository helper instead of the plan's suggested query shape while preserving output and transaction behavior. The controller records the HOW ruling and continues.
2. A fix would change an error from retryable to terminal. The controller presents one `DECISION` because observable behavior changes.
3. The second re-review still proves the same concurrency defect. The controller stops and reports the architecture conflict instead of dispatching round three.

**Deferred**

- Autonomous changes to approved public behavior.

### A.4 Role availability

**Rules**

- Skills use the minimal typed role set when available.
- Missing roles never silently remove a review.
- Generic fallback prompts carry access and no-subagent requirements.

**Examples**

1. A repository checkout exposes `sp_reviewer`. SDD dispatches it with read-only review instructions.
2. A packaged installation has no typed role registry. SDD dispatches a generic agent with the same review prompt and reports that fallback in the ledger.

**Deferred**

- Depending on undocumented plugin behavior to install repository agent configuration.

## Appendix B. Decision record

### Decision

Adopt one risk-scaled Superpowers planning and SDD pipeline with thin ad hoc review and no-subagent fallbacks.

### Consequences

- The default path dispatches fewer reviewers and fixer agents.
- Review quality depends on objective risk predicates and proof-bearing findings.
- The controller gains authority over reversible implementation decisions.
- The user retains authority over observable behavior and protected boundaries.
- Existing skill names and agent aliases may be removed.

### Reversibility

The migration uses focused commits and behavioral scenarios per skill. A failed step can be reverted without restoring the complete current graph. The specification and scenario suite remain useful even if role consolidation or packaging changes independently.
