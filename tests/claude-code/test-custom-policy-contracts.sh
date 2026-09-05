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
BRAINSTORMING="$REPO_ROOT/skills/brainstorming/SKILL.md"
ROUTING="$REPO_ROOT/skills/brainstorming/references/delivery-routing.md"
SCENARIOS="$REPO_ROOT/skills/brainstorming/references/test-scenarios.md"
CODEX="$REPO_ROOT/skills/using-superpowers/references/codex-tools.md"
WRITING="$REPO_ROOT/skills/writing-plans/SKILL.md"
REVIEW_SKILL="$REPO_ROOT/skills/requesting-code-review/SKILL.md"
REVIEW_PROMPT="$REPO_ROOT/skills/requesting-code-review/code-reviewer.md"
REVIEW_PROFILES="$REPO_ROOT/skills/requesting-code-review/references/profile-selection.md"
DISPATCH="$REPO_ROOT/skills/dispatching-parallel-agents/SKILL.md"
WORKTREES="$REPO_ROOT/skills/using-git-worktrees/SKILL.md"
FINISH="$REPO_ROOT/skills/finishing-a-development-branch/SKILL.md"
GATHERING="$REPO_ROOT/skills/gathering-topic-context/SKILL.md"

assert_contains "$USING" '^## Workflow Family Isolation$' 'Superpowers and GSD remain isolated by default'
assert_contains "$USING" 'asks to combine them' 'the user can explicitly combine workflow families'
assert_contains "$USING" 'confirmed delivery route' 'workflow family isolation recognizes a confirmed route'
assert_contains "$USING" 'exactly one workflow family' 'only one workflow family owns downstream orchestration'
assert_not_contains "$ROUTING" 'precedence order: \*\*GSD > Superpowers > Native Codex\*\*' 'route recommendation is not availability-only'
assert_not_contains "$BRAINSTORMING" 'first available route.*GSD > Superpowers > Native Codex' 'brainstorming workflow does not restore availability-only precedence'
assert_not_contains "$SCENARIOS" 'routes in any order other than GSD > Superpowers > Native Codex' 'behavioral scenarios do not require availability-only precedence'
assert_contains "$ROUTING" 'multiple milestones|durable roadmap|cross-workstream' 'GSD recommendation uses governance and continuity signals'
assert_contains "$ROUTING" 'bounded feature.*durable.*plan|durable.*plan.*bounded feature' 'Superpowers recommendation uses bounded planned-delivery signals'
assert_contains "$ROUTING" 'contained slice.*same task|same task.*contained slice' 'Native Codex recommendation uses immediate contained-task signals'
assert_contains "$ROUTING" 'mixed signals' 'route ties have an explicit deterministic rule'
assert_contains "$ROUTING" 'ask.*confirm' 'the recommended delivery route requires confirmation'
assert_contains "$ROUTING" 'GSD handoff.*steering note' 'GSD route owns its adapter artifacts'
assert_contains "$ROUTING" 'Superpowers.*writing-plans' 'Superpowers route invokes writing-plans'
assert_contains "$ROUTING" 'Native Codex.*inline proposed plan' 'Native Codex route returns an inline plan'
assert_contains "$ROUTING" 'persist.*only.*spec' 'Native Codex persists only the spec'
assert_contains "$ROUTING" 'plan mode.*read-only authoring' 'Native Codex plan mode remains authoring-only'
assert_contains "$ROUTING" 'not execute implementation.*plan mode|plan mode.*not execute implementation' 'Native Codex plan mode cannot execute implementation'
for tool in spawn_agent followup_task send_message wait_agent interrupt_agent list_agents; do
  assert_contains "$CODEX" "$tool" "Codex mapping documents $tool"
done
assert_not_contains "$CODEX" 'send_input|resume_agent|close_agent' 'Codex mapping removes stale lifecycle API names'
assert_contains "$WRITING" '^## Plan Shape$' 'plans use bounded outcome-oriented task shaping'
assert_contains "$WRITING" 'cross-task' 'plans preserve cross-task invariants'
assert_contains "$WRITING" 'Do not include method bodies, test bodies' 'plans remain interface/acceptance-criteria based'
assert_contains "$REVIEW_SKILL" 'sp_reviewer' 'review dispatch uses the unified typed Codex reviewer'
assert_contains "$REVIEW_PROMPT" 'read-only' 'reviewer is explicitly read-only'
assert_contains "$REVIEW_PROFILES" 'java-21-spring-gke-checklist\.md' 'reviewer preserves conditional Java/Spring/GKE depth'
assert_not_contains "$REVIEW_PROMPT" '\{PLAN_REFERENCE\}|\{WHAT_WAS_IMPLEMENTED\}' 'review template has no orphaned placeholders'
assert_contains "$DISPATCH" 'Autonomy level' 'parallel tasks state their mutation authority'
assert_contains "$DISPATCH" 'Imperative framing matters' 'parallel tasks use actionable prompts'
assert_contains "$WORKTREES" 'Native Worktree Tools \(preferred\)' 'worktrees prefer native platform support'
assert_contains "$FINISH" "Type 'discard' to confirm" 'discard remains explicit-only'
assert_contains "$BRAINSTORMING" 'agent_type: "sp_reviewer"' 'brainstorming uses the unified reviewer role'
assert_contains "$BRAINSTORMING" 'fork_turns: "none"' 'brainstorming reviewers receive fresh context'
assert_contains "$BRAINSTORMING" 'omit `agent_type`' 'brainstorming has generic reviewer fallback'
assert_contains "$GATHERING" 'agent_type: "sp_topic_context"' 'topic context uses its distinct role'
assert_contains "$GATHERING" 'fork_turns: "none"' 'topic context receives fresh context'
assert_contains "$GATHERING" 'omit `agent_type`' 'topic context has generic fallback'
assert_contains "$CODEX" 'The minimal optional role set is' 'Codex docs identify a minimal role set'
assert_contains "$CODEX" '`sp_reviewer`' 'Codex docs name the unified reviewer role'
assert_contains "$CODEX" '`sp_implementer`' 'Codex docs name the ordinary implementer role'
assert_contains "$CODEX" '`sp_implementer_deep`' 'Codex docs name the deep implementer role'
assert_contains "$CODEX" '`sp_topic_context`' 'Codex docs name the topic-context role'
assert_contains "$CODEX" 'project or user `.codex/agents`' 'Codex docs state role discovery boundary'
assert_contains "$CODEX" 'plugin archive does not install these roles' 'Codex docs state packaging boundary'
assert_contains "$CODEX" 'longest available bounded wait' 'Codex docs prefer one long idle wait'
assert_contains "$CODEX" 'Do not poll with short timeouts' 'Codex docs reject short polling loops'
test -f "$REPO_ROOT/skills/using-feature-branches-with-submodules/SKILL.md"

echo 'PASS: custom workflow policy coexists with upstream platform and review behavior'
