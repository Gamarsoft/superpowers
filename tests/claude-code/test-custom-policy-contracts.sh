#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

assert_contains() {
  local file="$1"
  local pattern="$2"
  local label="$3"
  if ! grep -Eq "$pattern" "$file"; then
    echo "FAIL: $label"
    echo "  Missing pattern '$pattern' in $file"
    exit 1
  fi
}

assert_not_contains() {
  local file="$1"
  local pattern="$2"
  local label="$3"
  if grep -Eq "$pattern" "$file"; then
    echo "FAIL: $label"
    echo "  Unexpected pattern '$pattern' in $file"
    exit 1
  fi
}

USING="$REPO_ROOT/skills/using-superpowers/SKILL.md"
CODEX="$REPO_ROOT/skills/using-superpowers/references/codex-tools.md"
WRITING="$REPO_ROOT/skills/writing-plans/SKILL.md"
REVIEW_SKILL="$REPO_ROOT/skills/requesting-code-review/SKILL.md"
REVIEW_PROMPT="$REPO_ROOT/skills/requesting-code-review/code-reviewer.md"
DISPATCH="$REPO_ROOT/skills/dispatching-parallel-agents/SKILL.md"
WORKTREES="$REPO_ROOT/skills/using-git-worktrees/SKILL.md"
FINISH="$REPO_ROOT/skills/finishing-a-development-branch/SKILL.md"

assert_contains "$USING" '^## Workflow Family Isolation$' 'Superpowers and GSD remain isolated by default'
assert_contains "$USING" 'asks to combine them' 'the user can explicitly combine workflow families'
for tool in spawn_agent followup_task send_message wait_agent interrupt_agent list_agents; do
  assert_contains "$CODEX" "$tool" "Codex mapping documents $tool"
done
assert_not_contains "$CODEX" 'send_input|resume_agent|close_agent' 'Codex mapping removes stale lifecycle API names'
assert_contains "$WRITING" '^## Task Right-Sizing$' 'plans use upstream task right-sizing'
assert_contains "$WRITING" 'Cross-Task Invariants' 'plans preserve cross-task invariants'
assert_contains "$WRITING" 'Do NOT include implementation or test code' 'plans remain interface/acceptance-criteria based'
assert_contains "$REVIEW_SKILL" 'sp_code_reviewer' 'review dispatch uses the typed Codex reviewer'
assert_contains "$REVIEW_PROMPT" 'read-only' 'reviewer is explicitly read-only'
assert_contains "$REVIEW_PROMPT" 'java-21-spring-gke-checklist\.md' 'reviewer preserves Java/Spring/GKE depth'
assert_not_contains "$REVIEW_PROMPT" '\{PLAN_REFERENCE\}|\{WHAT_WAS_IMPLEMENTED\}' 'review template has no orphaned placeholders'
assert_contains "$DISPATCH" 'Autonomy level' 'parallel tasks state their mutation authority'
assert_contains "$DISPATCH" 'Imperative framing matters' 'parallel tasks use actionable prompts'
assert_contains "$WORKTREES" 'Native Worktree Tools \(preferred\)' 'worktrees prefer native platform support'
assert_contains "$FINISH" "Type 'discard' to confirm" 'discard remains explicit-only'
test -f "$REPO_ROOT/skills/using-feature-branches-with-submodules/SKILL.md"

echo 'PASS: custom workflow policy coexists with upstream platform and review behavior'
