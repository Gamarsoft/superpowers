#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
SDD_DIR="$REPO_ROOT/skills/subagent-driven-development"
SKILL="$SDD_DIR/SKILL.md"
IMPLEMENTER="$SDD_DIR/implementer-prompt.md"
TASK_REVIEWER="$SDD_DIR/task-reviewer-prompt.md"
RE_REVIEWER="$SDD_DIR/re-review-prompt.md"
TASK_BRIEF="$SDD_DIR/scripts/task-brief"
REVIEW_PACKAGE="$SDD_DIR/scripts/review-package"
ROLE_DIR="$REPO_ROOT/.codex/agents"

FAILURES=0

pass() { printf 'PASS: %s\n' "$1"; }
fail() {
  printf 'FAIL: %s\n' "$1"
  FAILURES=$((FAILURES + 1))
}

assert_contains() {
  local file="$1"
  local pattern="$2"
  local label="$3"
  if grep -Eq -- "$pattern" "$file"; then pass "$label"; else fail "$label"; fi
}

assert_not_contains() {
  local file="$1"
  local pattern="$2"
  local label="$3"
  if ! grep -Eq -- "$pattern" "$file"; then pass "$label"; else fail "$label"; fi
}

assert_contains "$SKILL" 'specification path.*revision' 'preflight validates specification identity'
assert_contains "$SKILL" 'pair.*shares a file, interface, or state' 'preflight requires pairwise evidence'
assert_contains "$SKILL" 'task/self row' 'preflight requires per-task self-consistency evidence'
assert_contains "$SKILL" 'completed unit commit.*ancestor of current HEAD' 'resume requires completed work on the current history'
assert_contains "$SKILL" 'Resume by ledger status' 'resume behavior is explicit for every controller state'
assert_contains "$SKILL" '`ready-for-finishing`.*clean worktree' 'finishing resume revalidates clean state'
assert_contains "$SKILL" 'producer-return\.md' 'SDD can resume a failed finishing handoff'
assert_contains "$SKILL" 'invalidate the old handoff' 'SDD invalidates stale finishing evidence before correction'
assert_contains "$SKILL" 'preserve the final-review correction count' 'SDD finishing return preserves the breaker budget'
assert_contains "$SKILL" 'correction-1.*reconcile the report and commits' 'round-one resume reconciles durable evidence first'
assert_contains "$SKILL" 'correction-2.*reconcile the report and commits' 'round-two resume reconciles durable evidence first'
assert_contains "$SKILL" 'Review-required tasks remain individual' 'risk-bearing tasks remain isolated'
assert_contains "$SKILL" 'normally no more than three tasks' 'ordinary checkpoint batches are bounded'
assert_contains "$SKILL" '`BLOCKING`' 'SDD uses blocking disposition'
assert_contains "$SKILL" '`DECISION`' 'SDD uses decision disposition'
assert_contains "$SKILL" '`FOLLOW_UP`' 'SDD uses follow-up disposition'
assert_contains "$SKILL" '`INVALID`' 'SDD uses invalid disposition'
assert_contains "$SKILL" 'candidate causal connection' 'blocking findings require change causality'
assert_contains "$SKILL" 'cost if wrong' 'autonomous HOW rulings record downside'
assert_contains "$SKILL" 'Round one.*original implementer' 'first correction returns to original implementer'
assert_contains "$SKILL" 'Round two.*deep rescue' 'second correction uses one deep rescue'
assert_contains "$SKILL" 'before round three' 'circuit breaker stops before a third correction'
assert_contains "$SKILL" 'fork_turns: "none"' 'Codex agents receive fresh context'
assert_contains "$SKILL" 'omit `agent_type`' 'missing typed role falls back without a fake role'
assert_contains "$SKILL" 'longest host-compatible bounded wait' 'waiting is event-driven and bounded'
assert_contains "$SKILL" 'unchanged timeout' 'unchanged waits create no work or narration'
assert_contains "$SKILL" 'execution-report\.md' 'SDD writes its finishing handoff report'
assert_contains "$SKILL" 'exact implementation HEAD' 'report binds the reviewed implementation revision'
assert_contains "$SKILL" 'revalidate current HEAD' 'report creation rechecks the reviewed revision'
assert_contains "$SKILL" 'clean worktree' 'review and report require a clean tree'
assert_contains "$SKILL" 'does not run the complete repository suite' 'SDD leaves complete verification to finishing'
assert_contains "$SKILL" 'does not delete its workspace' 'SDD leaves cleanup to finishing'
assert_contains "$SKILL" '`sp_implementer`' 'normal implementation uses the unified role'
assert_contains "$SKILL" '`sp_implementer_deep`' 'rescue implementation uses the deep role'
assert_contains "$SKILL" '`sp_reviewer`' 'all workflow reviews use the unified reviewer role'
assert_contains "$SKILL" 'selected specialist profiles' 'selected specialist depth reaches reviewers'
assert_contains "$SKILL" 'java-21-spring-gke-checklist\.md' 'existing Java/Spring/GKE depth is preserved'
assert_not_contains "$SKILL" 'sp_implementer_spark|sp_implementer_standard|sp_code_reviewer' 'legacy role fan-out is absent'
assert_not_contains "$SKILL" 'rounds 4|rounds 4-5|R = 5|of 5' 'five-round loop is absent'
assert_contains "$IMPLEMENTER" 'Do not spawn subagents' 'implementer nesting is prohibited'
assert_contains "$IMPLEMENTER" 'Finishing alone owns the complete repository suite' 'implementer avoids complete suite'
assert_contains "$IMPLEMENTER" 'cost if wrong' 'implementer reports reversible rulings'
assert_contains "$IMPLEMENTER" 'append.*never overwrite' 'correction evidence is append-only'
assert_contains "$IMPLEMENTER" 'Commit the correction' 'corrections have explicit commit semantics'
assert_contains "$TASK_REVIEWER" 'Do not spawn subagents' 'task reviewer nesting is prohibited'
assert_contains "$TASK_REVIEWER" 'candidate causal connection' 'task reviewer proves causal scope'
assert_contains "$TASK_REVIEWER" 'SPECIALIST_PROFILES' 'review prompt receives selected specialist profiles'
assert_contains "$TASK_REVIEWER" 'java-21-spring-gke-checklist\.md' 'review prompt retains Java/Spring/GKE checklist'
assert_contains "$TASK_REVIEWER" 'BLOCKING.*DECISION.*FOLLOW_UP.*INVALID|BLOCKING|DECISION|FOLLOW_UP|INVALID' 'task reviewer exposes shared dispositions'
assert_not_contains "$TASK_REVIEWER" 'Critical \(Must Fix\)|Important \(Should Fix\)|Minor \(Nice to Have\)' 'legacy severity ladder is absent'
assert_contains "$RE_REVIEWER" 'Do not spawn subagents' 're-reviewer nesting is prohibited'
assert_contains "$RE_REVIEWER" 'fix diff' 're-review stays scoped to the correction'
assert_contains "$RE_REVIEWER" 'SPECIALIST_PROFILES' 're-review receives selected specialist profiles'
assert_contains "$RE_REVIEWER" 'java-21-spring-gke-checklist\.md' 're-review preserves Java/Spring/GKE depth'
assert_not_contains "$RE_REVIEWER" 'report gives proof' 're-review can discover undisclosed fix regressions'
assert_contains "$TASK_BRIEF" 'TASK_NUMBER.*TASK_NUMBER' 'task-brief advertises multi-task units'
assert_contains "$REVIEW_PACKAGE" 'merge-base --is-ancestor' 'review package validates the recorded range'
assert_not_contains "$REVIEW_PACKAGE" 'HEAD~1' 'review package never infers a one-commit base'
assert_contains "$REVIEW_PACKAGE" 'status --porcelain' 'review package rejects dirty implementation state'
assert_contains "$REVIEW_PACKAGE" 'current HEAD does not match' 'review package rejects a stale requested head'

role_inventory="$(find "$ROLE_DIR" -mindepth 1 -maxdepth 1 -type f -name '*.toml' -print | sed 's#.*/##' | sort)"
expected_roles="$(printf '%s\n' implementer-deep.toml implementer.toml reviewer.toml topic-context.toml | sort)"
if [[ "$role_inventory" == "$expected_roles" ]]; then
  pass 'Codex role inventory contains only four responsibilities'
else
  fail 'Codex role inventory contains only four responsibilities'
fi
assert_contains "$ROLE_DIR/reviewer.toml" 'name = "sp_reviewer"' 'unified reviewer role has the public name'
assert_contains "$ROLE_DIR/reviewer.toml" 'sandbox_mode = "read-only"' 'unified reviewer is read-only'
assert_contains "$ROLE_DIR/implementer.toml" 'name = "sp_implementer"' 'normal implementer role has the public name'
assert_not_contains "$ROLE_DIR/implementer.toml" 'sandbox_mode = "read-only"' 'normal implementer retains workspace mutation'
assert_contains "$ROLE_DIR/implementer-deep.toml" 'name = "sp_implementer_deep"' 'deep implementer role survives'
assert_contains "$ROLE_DIR/topic-context.toml" 'sandbox_mode = "read-only"' 'topic context remains read-only'

if rg -n 'sp_code_reviewer|sp_implementer_spark|sp_implementer_standard|sp_plan_reviewer|sp_spec_reviewer|spec_document_reviewer' \
  "$REPO_ROOT/skills" "$ROLE_DIR" >/dev/null; then
  fail 'live skills and roles do not reference deleted aliases'
else
  pass 'live skills and roles do not reference deleted aliases'
fi

if [[ "$FAILURES" -ne 0 ]]; then
  printf '%s\n' "$FAILURES custom SDD contract test(s) failed"
  exit 1
fi

printf 'All custom SDD contracts passed\n'
