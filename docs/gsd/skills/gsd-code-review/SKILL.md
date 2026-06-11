---
name: gsd-code-review
description: Use when reviewing GSD implementation work before a task or slice is marked done, especially Java 21/Spring Boot services, auth, persistence, performance, external I/O, GKE runtime changes, or superprojects with git submodules.
---

# GSD Code Review Checklists

Use this skill to apply structured quality checks to the real diff that is about to ship. The diff you review must match the current phase. Reviewing the wrong diff is review theater.

Preferred workflow for step mode:

1. the implementation task ends with one fresh-context review pass
2. the follow-up task reviews and resolves findings until approve or escalation

Hook review after auto-commit is a fallback path for full auto mode.

## When to Load This Skill

**Mandatory — load before:**

- Marking a task done (`[x]`) that involved non-trivial implementation
- Running slice-level verification in `complete-slice`
- Any task touching authentication, authorization, data persistence, external I/O, Java/Spring runtime behavior, Kubernetes manifests, or JVM/container configuration

**Valuable — load when:**

- Stuck on a bug (fresh perspective from the checklists)
- After fixing a complex bug (confirm you fixed the root cause, not a symptom)
- Before squash-merge (final sweep)

## Review Modes

Choose the review mode that matches the workflow:

- **Implementation-end review pass**
  - Preferred first pass for step mode and normal slice execution
  - Reviewer runs in a fresh `worker` subagent at the end of the implementation task
  - Reviewer inspects the current working tree against `HEAD`
- **Review-and-resolve task**
  - Follow-up task after a non-trivial implementation task
  - If the review artifact says `APPROVE`, it is a no-op task
  - If the review artifact says `REQUEST_CHANGES`, it fixes or disproves findings, then reruns fresh-context review until approve or escalation
- **Full auto mode with post-unit hooks**
  - Hook reviewer inspects the just-created commit `HEAD~1..HEAD`

Do not rely on implementer self-review as the final gate for non-trivial work. The final gate should be a fresh-context reviewer.

If you review `HEAD~1..HEAD` before the unit auto-commits, you are usually reviewing the previous unit, not the work you just did.

## How to Get the Diff

### Normal repo

- **Fresh-context review before auto-commit**

```bash
git diff --stat HEAD
git diff HEAD
```

- **Hook review after auto-commit**

```bash
git diff --stat HEAD~1..HEAD
git diff HEAD~1..HEAD
```

### Superproject with git submodules

If `.gitmodules` exists, the review is not complete until you have reviewed both:

1. the superproject diff
2. the actual submodule code behind every changed gitlink pointer

Use `--submodule=diff`, not plain `git diff`.

- **Fresh-context review before auto-commit**

```bash
git diff --stat --submodule=diff HEAD
git diff --submodule=diff HEAD
```

- **Hook review after auto-commit**

```bash
git diff --stat --submodule=diff HEAD~1..HEAD
git diff --submodule=diff HEAD~1..HEAD
```

Do not approve a superproject change after reviewing only a pointer bump.

## Task Pattern

For non-trivial work, use this pattern inside the slice plan:

1. implementation task
2. review-and-resolve follow-up task

Example:

1. `T01: Implement API changes`
2. `T02: Review and resolve T01 findings`

Use the same pattern at slice level before `complete-slice`:

1. final integration task
2. `Review and resolve slice findings`

### Implementation task rule

At the end of the implementation task, after implementation and verification but before the task completes, run one fresh-context review pass in a `worker` subagent.

That reviewer writes exactly one authoritative review artifact for the implementation task:

- `T01-REVIEW.md`

The implementation task then completes normally either way.

### Review-and-resolve task rule

The follow-up task owns the review loop for the preceding implementation task.

- If `T01-REVIEW.md` says `verdict: APPROVE`, the task is a no-op and completes quickly.
- If `T01-REVIEW.md` says `verdict: REQUEST_CHANGES`, the task fixes or explicitly disproves each Critical and Important finding, runs verification, then launches another fresh-context review pass against the updated working tree.
- The follow-up task repeats this loop until `T01-REVIEW.md` says `APPROVE` or the cycle limit is reached.

### Cycle limit

Use at most 4 fresh review cycles inside the follow-up task.

If approval still does not exist after 4 cycles, stop looping and escalate through `replan-slice` or `blocker_discovered: true`.

### Scope rule

Skip the follow-up review-and-resolve task only for trivial work such as docs-only edits, copy-only edits, formatting-only changes, renames, or other clearly mechanical non-behavioral changes.

## Checklist Order

Apply the checklists in this order:

1. **Security first** — blockers go here
2. **Java 21/Spring/GKE** — apply when the diff touches JVM/Spring/persistence/runtime/deployment behavior
3. **Code quality** — correctness and robustness
4. **SOLID** — structural health; skip for trivial changes

## Reference Checklists

All paths are relative to this skill's directory. Load with `read`.

- Security: `references/security-checklist.md`
- Java 21/Spring/GKE: `references/java-21-spring-gke-checklist.md`
- Code quality: `references/code-quality-checklist.md`
- SOLID smells: `references/solid-checklist.md`

## Severity Model

Apply this when reporting issues in task summaries or slice summaries:

| Level         | Description                                                                                                         | Action                                                                        |
| ------------- | ------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------- |
| **Critical**  | Security vulnerability, data loss, cross-tenant leak, correctness bug, broken auth                                  | Fix before marking done. Set `blocker_discovered: true` if plan-invalidating. |
| **Important** | Logic error, missing error handling, N+1, race condition, test gap, unsafe transaction, unreviewed submodule change | Fix before marking slice complete. Note in task summary.                      |
| **Minor**     | Style, naming, magic numbers, missing progress indicators                                                           | Note in task summary. Fix if quick, defer if not.                             |

Treat these as **Important** at minimum:

- superproject pointer bump reviewed only as a pointer change
- changed submodule commit range not inspected
- dirty submodule working tree still present at review time
- `.gitmodules` URL, path, or branch change without explicit justification
- unrelated submodule changes swept into the task
- Java endpoint/resolver/repository change without tenant/ownership reasoning
- JPA query/list endpoint likely to create N+1 or unbounded reads
- retryable write path without idempotency or transaction reasoning
- unbounded cache, thread pool, queue, scheduler, or in-memory batch
- JVM/container/Kubernetes change without resource and rollout reasoning

## Evidence Rules

- Review the actual diff, not your memory of the code.
- Name the exact diff you reviewed.
- Read touched files and nearby tests/configs before judging.
- For Java/Spring changes, say whether auth/tenant, transaction, persistence, and performance checks were applicable.
- If every severity bucket says `(none)`, add one short note explaining why the reviewed diff is safe enough to pass.
- For superprojects, say whether submodules were present and whether their actual diffs were reviewed.

## Review Artifact Format

When you complete a review pass, write one authoritative artifact:

- task review: `.gsd/{milestoneId}/slices/{sliceId}/tasks/{taskId}-REVIEW.md`
- slice review: `.gsd/{milestoneId}/slices/{sliceId}/REVIEW.md`

Include this content:

```markdown
## Quality Check

**Review mode:** implementation-end-review | review-resolve-loop | hook-review
**Target:** <taskId or sliceId>
**Cycle:** <1 | 2>
**Diff reviewed:** <HEAD or HEAD~1..HEAD> — X files, Y lines
**Submodules:** absent | present, reviewed with --submodule=diff
**Checklists applied:** security, java-21-spring-gke(if applicable), code-quality[, solid]

### Issues Found

#### Critical

- (none) / [file:line — what — why — fix]

#### Important

- (none) / [file:line — what — why — fix]

#### Minor

- (none) / [file:line — what — why — fix]

**Java/Spring/GKE notes:** auth/tenant: n/a|ok|issue; persistence: n/a|ok|issue; performance: n/a|ok|issue; runtime: n/a|ok|issue

**Verdict:** APPROVE | REQUEST_CHANGES | ESCALATE
**Review Decision:** no_action | remediate_and_rereview | escalate_replan
```

## Completion Rule By Mode

- In `implementation-end-review` mode:
  - the reviewer writes the review artifact
  - the implementation task still completes normally after that first-pass review
  - do not fix or disprove review findings inside the implementation task's final review step
  - do not start a review loop inside the implementation task
  - those findings belong to the paired `Review and resolve ... findings` task

- In `review-resolve-loop` mode:
  - the follow-up task owns the fix/disprove plus re-review loop
  - do not complete the follow-up task until the review artifact says `APPROVE` or the cycle limit is hit and escalation occurs

- In `hook-review` mode:
  - treat review as a gate only when the runtime actually supports that hook workflow

## Implementation-End Review Prompt

Use this at the end of the implementation task. This is the preferred first pass.

```text
Use the subagent tool with mode "worker" and this prompt:

  You are a code reviewer. Your only job is to apply quality checklists to the real diff that is about to ship.

  Read these files from the loaded gsd-code-review skill directory in full before reviewing:
  - references/security-checklist.md
  - references/java-21-spring-gke-checklist.md
  - references/code-quality-checklist.md
  - references/solid-checklist.md

  Review mode: implementation-end-review
  Repo shape: <normal repo | superproject with submodules>
  What was implemented: <WHAT_WAS_IMPLEMENTED>
  Plan/requirements: <PLAN_OR_REQUIREMENTS>

  Review the target implementation task before auto-commit:
  - normal repo: git diff --stat HEAD && git diff HEAD
  - superproject: git diff --stat --submodule=diff HEAD && git diff --submodule=diff HEAD

  Apply every applicable checklist. Report issues by severity (Critical / Important / Minor) with file:line references. For Java/Spring/GKE changes, explicitly cover auth/tenant, persistence, performance, and runtime readiness. For superprojects, call out submodule findings explicitly.

  Write exactly one artifact for the implementation task being reviewed:
  - task review: .gsd/{milestoneId}/slices/{sliceId}/tasks/{taskId}-REVIEW.md

  Set:
  - Verdict: APPROVE | REQUEST_CHANGES | ESCALATE
  - Review Decision: no_action | remediate_and_rereview | escalate_replan

  Give a clear APPROVE / REQUEST_CHANGES verdict. Fix nothing — report only.
```

In this mode, the implementation task must not remediate those findings after the review artifact is written. Any remediation belongs to the paired follow-up task.

## Review-and-Resolve Task Prompt

Use this in the follow-up task. This task is a no-op if pass already exists.

```text
Use gsd-code-review.

Target implementation task: <T01>
This is the follow-up review-and-resolve task for that implementation.

1. Read `.gsd/{milestoneId}/slices/{sliceId}/tasks/{targetTaskId}-REVIEW.md`.
2. If it says `verdict: APPROVE`, summarize that the prior implementation already passed review and complete the task with no code changes.
3. If it says `verdict: REQUEST_CHANGES`, fix or explicitly disprove every Critical and Important finding with fresh verification evidence.
4. Launch a fresh `worker` subagent review pass against the updated working tree.
5. The reviewer must read this skill first and review in `review-resolve-loop` mode.
6. The reviewer overwrites `.gsd/{milestoneId}/slices/{sliceId}/tasks/{targetTaskId}-REVIEW.md`.
7. Repeat at most 4 review cycles total in this follow-up task.
8. If the review artifact still does not say `APPROVE` after 4 cycles, stop and escalate through `replan-slice` or `blocker_discovered: true`.
```

In this pattern, `REVIEW.md` is always created or overwritten by the fresh-context
reviewer, not by the remediation logic itself.
For the final slice-level review-and-resolve task, use the same loop but target the slice-level artifact:

- `.gsd/{milestoneId}/slices/{sliceId}/REVIEW.md`

## Hook Review

If you are running full auto mode and post-unit hooks are available, the hook reviewer should review `HEAD~1..HEAD` and write the same single review artifact.

Use hook review only when the engine actually supports it in that mode.
