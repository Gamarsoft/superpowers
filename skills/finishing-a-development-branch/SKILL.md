---
name: finishing-a-development-branch
description: Use when an implementation report is ready for complete verification, durable evidence, and an integration choice
---

# Finishing a Development Branch

## Overview

Validate the producer's exact implementation revision, run the complete suite
once, preserve the completed report in one report-only commit, then present the
integration choice and clean only owned state.

**Core principle:** exact report → one complete suite → report-only commit →
integration choice → safe cleanup.

**Announce at start:** “I'm using finishing-a-development-branch to verify and
preserve this implementation before integration.”

## Step 1: Validate the Handoff

Require both the plan path and its plan-scoped `execution-report.md` path from
SDD or `executing-plans`. Resolve the expected workspace with:

```bash
../subagent-driven-development/scripts/sdd-workspace PLAN_FILE
```

The supplied report must be `<returned-workspace>/execution-report.md`. Read
`../subagent-driven-development/references/execution-report.md` completely and
validate every required section. Require:

- `Status: ready-for-finishing`;
- canonical plan and reachable specification paths plus spec revision;
- a valid full Implementation base and Implementation HEAD;
- no supported `BLOCKING` or unresolved `DECISION`;
- truthful independent-review availability/result; and
- a clean worktree; and
- current HEAD equal to Implementation HEAD, except for the report-only
  finishing resume described below.

Resolve commits rather than trusting text:

```bash
git rev-parse --verify "${IMPLEMENTATION_HEAD}^{commit}"
git merge-base --is-ancestor "$IMPLEMENTATION_BASE" "$IMPLEMENTATION_HEAD"
git rev-parse HEAD
git status --porcelain -uall
```

If current HEAD differs, derive the expected head-suffixed report destination
without changing files and inspect `Implementation HEAD..HEAD`. Treat it as a
report-only finishing resume only when the range contains exactly that one
tracked report, the committed report records the same Implementation HEAD and a
passing `Finishing verification` section, and the worktree is clean. Record
current HEAD as `REPORT_COMMIT` and continue at Step 3. This resume does not rerun the suite or create another report commit.

For every other mismatch—or if the report is malformed, a commit is
unreachable, or the worktree is dirty—stop before running the complete repository suite.
Do not update the report to bless a different tree. Show the
mismatch and return ownership to the producing workflow: SDD resumes final
review; `executing-plans` resumes its final evidence step.

## Step 2: Run the Sole Complete Suite and Preserve Its Evidence

Read the exact complete-suite command from the plan. A missing command blocks
finishing rather than inviting a guess.

Run the complete repository suite exactly once at Implementation HEAD. Capture
the exact command, exit status, concise result, and implementation commit.

If it fails, append nothing, create no report commit, show the failures, and
return to the producer for a correction and refreshed final review. If it
passes, recheck current HEAD and worktree cleanliness. Generated tracked or
untracked files are a changed test subject, so stop and inventory them.

Append a `## Finishing verification` section to the ignored report containing
the exact suite evidence. Derive:

```text
REPORT_DEST=docs/superpowers/execution-reports/<plan-basename>-<short-implementation-head>.md
```

This means the literal destination contract is
`docs/superpowers/execution-reports/<plan-basename>-<short-implementation-head>.md`.
Use a stable short hash of at least 12 characters. A report-copy collision
stops finishing; never overwrite or silently reuse an existing path.

Copy the completed report to `$REPORT_DEST`. Before committing, require the
worktree change list and staged list to contain only that destination. Then:

```bash
git add -- "$REPORT_DEST"
git diff --cached --name-only
git commit -m "docs: preserve execution report for <plan-basename>"
git diff --name-only "$IMPLEMENTATION_HEAD..HEAD"
git status --porcelain -uall
```

The staged list must contain only `$REPORT_DEST`; the
implementation-HEAD-to-HEAD range contains only `$REPORT_DEST` as well. The
worktree must be clean after the commit. Record the
new report commit separately; it is not the implementation revision under test.

If the range contains an implementation file or any path besides the report,
stop and return ownership to the producing workflow. Do not run the complete suite again
to bless the mixed range. The report-only boundary must be restored
first.

Merge, PR, and keep-as-is preserve the committed report. Only an explicitly
confirmed discard removes it with the branch.

## Step 3: Detect the Git Environment

Capture these values while still inside the workspace:

```bash
GIT_DIR=$(cd "$(git rev-parse --git-dir)" 2>/dev/null && pwd -P)
GIT_COMMON=$(cd "$(git rev-parse --git-common-dir)" 2>/dev/null && pwd -P)
WORKTREE_PATH=$(git rev-parse --show-toplevel)
REPORT_COMMIT=$(git rev-parse HEAD)
```

| State | Menu | Cleanup |
| --- | --- | --- |
| `GIT_DIR == GIT_COMMON` | Standard 3 options | No worktree removal |
| Linked worktree, named branch | Standard 3 options | Provenance-based |
| Linked worktree, detached HEAD | Reduced 2 options | Host-owned; leave it |

## Step 4: Determine the Base Branch

Use the base branch recorded by the plan, conversation, or upstream. If it is
not known, ask: “This branch split from <best evidence>—is that correct?”
Confirm before a local merge.

## Step 5: Present Options

For a normal repo or named-branch worktree:

```text
Implementation complete. What would you like to do?

1. Merge back to <base-branch> locally
2. Push and create a Pull Request
3. Keep the branch as-is (I'll handle it later)

Which option?
```

For detached HEAD:

```text
Implementation complete. You're on a detached HEAD (externally managed workspace).

1. Push as new branch and create a Pull Request
2. Keep as-is (I'll handle it later)

Which option?
```

Do not offer discard. Wait for the human choice.

## Step 6: Execute the Choice

### Option 1: Merge locally

Resolve the main repository root, switch to the confirmed base, and pull. If
the base no longer equals the report's Implementation base, stop before merge
and return the branch to the producing workflow for integration refresh.

Merge the feature branch. The resulting tree must be identical to
`REPORT_COMMIT`; otherwise stop with both refs intact. Because an identical tree
is already covered by the suite evidence, do not run a second complete suite.
After a successful identical-tree merge, perform owned cleanup below and delete
the feature branch with the non-forcing `git branch -d` form.

### Option 2: Push and create a pull request

Push the named branch with upstream tracking. From detached HEAD, push HEAD to
an explicitly chosen new remote branch. Follow the repository's PR template,
target-branch rules, contributor requirements, and forge conventions. Report
the URL. Preserve the worktree and plan workspace for review iteration.

### Option 3: Keep as-is

Report the branch/ref, report commit, worktree, and plan-workspace paths.
Preserve them.

### Explicit discard request

Discard exists only after the human asks to throw the work away. Show the exact
branch/ref, commits, committed report, worktree, and ignored plan workspace:

```text
This will permanently delete:
- Branch <name>
- All commits: <commit-list>
- Committed report: <report-path>
- Worktree at <path>
- Plan workspace at <path>

Type 'discard' to confirm.
```

Wait for that exact word. Then use owned cleanup and force-delete only the named
feature branch.

## Step 7: Clean Owned State

Run only after a successful local merge or exact discard confirmation. PR and
keep-as-is preserve both worktree and plan workspace.

Before removing an owned linked worktree after merge, remove only the exact
plan workspace returned in Step 1; its completed report is already committed.
Never clean another plan's directory.

- If `GIT_DIR == GIT_COMMON`, there is no worktree to remove. Remove only the
  exact plan workspace after a successful local merge or confirmed discard.
- If `WORKTREE_PATH` is under `.worktrees/` or `worktrees/`, Superpowers owns
  cleanup. Change to the main repo root, remove that exact worktree, then prune.
- Otherwise the host owns the workspace. Leave it in place and use a platform
  workspace-exit action when available.

If `git worktree remove` is refused because it contains modified or untracked files,
do not retry destructively. Never use `--force` autonomously. Inventory first:

```bash
git -C "$WORKTREE_PATH" status --porcelain -uall
```

Then ask:

```text
Worktree removal refused — these files were never committed:

<file list>

1. Commit them to <branch> before cleanup
2. Move them into <main repo root>
3. Delete them (unrecoverable)

Which?
```

Carry out only the selected action, then retry cleanup. Deletion remains
destructive authority; an earlier merge or discard choice does not silently
authorize deleting newly discovered files.

## Quick Reference

| Option | Evidence kept | Push | Worktree | Branch |
| --- | --- | --- | --- | --- |
| Merge locally | yes | no | clean if owned | delete safely |
| Create PR | yes | yes | preserve | preserve |
| Keep as-is | yes | no | preserve | preserve |
| Confirmed discard | no | no | clean if owned | force-delete named branch |

## Common Rationalizations

| Excuse | Reality |
| --- | --- |
| “Tests passed earlier.” | Only finishing's recorded run at exact Implementation HEAD is the complete-suite evidence. |
| “The report is one commit stale, so I can test current HEAD.” | Return to final review; do not transfer evidence between revisions. |
| “I can include a tiny code fix with the report.” | Any implementation change invalidates the report-only range. |
| “The suite can run again after a suspicious change.” | No. Restore the producer/review boundary before another finishing attempt. |
| “They obviously want it merged.” | Integration remains the human's decision. |
| “The PR is open, so cleanup is safe.” | PR feedback still needs its worktree and plan workspace. |
| “Removal refused; force is harmless.” | Refusal proves unique files may exist. Inventory and ask. |
| “A rejected push needs force.” | Investigate remote movement; force-push needs explicit authority. |
