---
name: using-feature-branches-with-submodules
description: Use when starting feature work that needs isolation in a repo that uses git submodules — isolates via a feature branch (not worktrees) with a submodule-safe workflow (no automatic pushes).
---

# Using Feature Branches (Optimized for Submodules)

## Overview

Create isolation by working on a dedicated feature branch in the **superproject** (the repo that contains `.gitmodules`) and targeted submodules rather than using git worktrees.

This workflow is optimized for submodules by:

- Keeping submodules at the commits **pinned by the superproject** by default
- Avoiding accidental work in **detached HEAD** submodules
- Making submodule changes explicit: **commit in the submodule first, then commit the gitlink update in the superproject**
- Avoiding unintended drift: **no pulling inside submodules unless you intend to bump the pinned commit**

**Core principle:** Branch isolation + explicit submodule commits + baseline verification = reliable changes without worktree pain.

**Announce at start:** “I'm using the using-feature-branches-with-submodules skill to set up isolated work on a feature branch.”

---

## Safety Rules

### Always

- Run branch creation from the **superproject root** (never from inside a submodule).
- Keep the superproject clean before branching (commit/stash first).
- Assume submodules may be in **detached HEAD** after `git submodule update` (this is normal).
- If you need to change a submodule: **create/switch to a branch inside that submodule**, commit there, then commit the updated gitlink in the superproject.
- Treat submodule commit updates as intentional changes: if the submodule commit moves, the superproject must record it.

### Never

- Edit a submodule while it’s in detached HEAD and forget to create a branch.
- Run broad `git submodule update --init --recursive` unless you truly need all submodules.
- Run `git pull` inside submodules during feature work **unless you intend to bump the pinned commit** and later commit the pointer change in the superproject.
- Assume “superproject is clean” means “everything is clean” — submodules can be dirty independently.

---

## Setup Steps

### 0) Ensure You Are in the Superproject Root

```bash
root="$(git rev-parse --show-toplevel)"
cd "$root"

# Superproject indicator
test -f .gitmodules || echo "No .gitmodules found (this repo may not use submodules)"
```

### 1) Verify a Clean Baseline (Superproject + Relevant Submodules)

Superproject status:

```bash
git status --porcelain
```

If submodules are initialized, check them for dirt too:

```bash
git submodule foreach --quiet '
  if [ -n "$(git status --porcelain)" ]; then
    echo "DIRTY: $name ($path)"
    git status --porcelain
  fi
'
```

If anything is dirty: **commit or stash** before continuing.

### 2) Sync to Base Branch and Create Feature Branch

If you are basing on `develop` (typical):

```bash
git switch develop
git pull
git switch -c feature/<short-name>
```

If you need a different base branch:

```bash
git switch <base-branch>
git pull
git switch -c feature/<short-name>
```

> Notes:
>
> - Feature branch naming is a convention; use your team's rules.
> - This skill intentionally does **not** push branches; pushing is handled manually.

### 3) Targeted Submodule Initialization (Only What You Need)

List submodules:

```bash
cat .gitmodules
```

Initialize only the submodules required by the task:

```bash
git submodule update --init --recursive -- <path-a> <path-b>
```

If submodules are already initialized and correct, do **nothing** here.

### 4) Ensure Submodules Match the Pinned Commits (Optional but Safe)

If you want to ensure submodules are exactly at the pinned commits:

```bash
git submodule update -- <submodule-path>
```

---

## Working With Submodules on a Feature Branch

### Case A: You do NOT need to modify a submodule

Do nothing special. Keep the submodule at the commit pinned by the superproject.

If you need to reset it back to the pinned commit:

```bash
git submodule update -- <submodule-path>
```

### Case B: You DO need to modify a submodule

#### 1) Enter the submodule

```bash
cd <submodule-path>
```

#### 2) Ensure you are on a branch (fix detached HEAD)

Create the feature branch in the submodule **at the current pinned commit**:

```bash
git switch -c feature/<short-name> 2>/dev/null || git switch feature/<short-name>
```

> Rule: Do **not** `git pull` in the submodule unless you intentionally want to move it forward and later commit the pointer bump in the superproject.

#### 3) Make changes and commit in the submodule

```bash
git status
# edit files

git add -A
git commit -m "<submodule change summary>"
```

#### 4) Return to the superproject and commit the updated gitlink pointer

Return to the superproject root:

```bash
cd "$(git rev-parse --show-superproject-working-tree 2>/dev/null || git rev-parse --show-toplevel)"
```

Verify the superproject sees the submodule pointer change:

```bash
git status
```

Commit the gitlink update:

```bash
git add <submodule-path>
git commit -m "Update <submodule-path> submodule pointer"
```

> Important: A submodule change is only “wired into” the overall feature when the superproject commits the pointer update.

---

## Advanced: Tracking a Submodule Branch (Use Sparingly)

If you explicitly want `git submodule update --remote` behavior for a submodule, set a tracked branch:

```bash
git submodule set-branch --branch <branch-name> <submodule-path>
git submodule update --remote --merge -- <submodule-path>
```

Notes:

- `git submodule set-branch` updates `.gitmodules`. If you want teammates/CI to follow it, commit the `.gitmodules` change:
  - `git add .gitmodules`
  - `git commit -m "Track <submodule-path> on <branch-name>"`

- Avoid this for strict pinning workflows; prefer explicit pointer bumps.

---

## Baseline Verification and Tests

### 1) Verify baseline builds before large changes (recommended)

Run the appropriate setup/build for your repo (examples):

```bash
# Node
if [ -f package.json ]; then npm install; fi

# Python
if [ -f requirements.txt ]; then pip install -r requirements.txt; fi
if [ -f pyproject.toml ]; then poetry install; fi

# Rust
if [ -f Cargo.toml ]; then cargo build; fi
```

### 2) Run relevant tests (do not ignore failures)

```bash
# Run only what applies to this repo; if something fails, report it clearly.
if [ -f package.json ]; then npm test; fi
if [ -f Cargo.toml ]; then cargo test; fi
if [ -d tests ] || [ -f pytest.ini ]; then pytest; fi
```

If the baseline fails, report it explicitly and decide whether to proceed.

---

## Reporting Format

Use this exact format after setup:

```
Feature branch ready: feature/<short-name>
Base branch: <base-branch>
Submodules initialized: <paths>
Submodules modified: <paths or none>
Pinned-commit alignment: <what you ran / verified>
Baseline verification: <commands> (pass/fail)
Ready to implement: <feature summary>
```

---

## Common Mistakes and Fixes

### Editing a submodule in detached HEAD

- **Problem:** Changes are easy to lose or hard to share.
- **Fix:** Before editing, create/switch to a branch inside the submodule:
  - `git switch -c feature/<name>`

### Committing only in the superproject

- **Problem:** Submodule changes are not actually recorded as code changes.
- **Fix:** Commit inside the submodule first, then commit the superproject pointer bump:
  - `git add <submodule-path> && git commit`

### Pulling inside submodules accidentally

- **Problem:** You move the submodule away from the pinned commit and create noisy/unintended pointer bumps.
- **Fix:** Avoid `git pull` in submodules unless intentionally bumping the pointer.

### Updating all submodules unnecessarily

- **Problem:** Slow + noisy + increases risk of unrelated changes.
- **Fix:** Use targeted updates:
  - `git submodule update --init --recursive -- <paths...>`

---

## Integration

**Called by:**

- `brainstorming` (after design approval) — setup before implementation

**Pairs with:**

- `writing-plans` — create a plan once the branch is ready
- `executing-plans` / `subagent-driven-development` — implement tasks on the branch
- `finishing-a-development-branch` — merge/PR/cleanup decisions
