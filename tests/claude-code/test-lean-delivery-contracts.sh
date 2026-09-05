#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
WRITING="$REPO_ROOT/skills/writing-plans/SKILL.md"
READINESS="$REPO_ROOT/skills/writing-plans/plan-readiness-reviewer-prompt.md"
OLD_REVIEWER="$REPO_ROOT/skills/writing-plans/plan-document-reviewer-prompt.md"
TASK_BRIEF="$REPO_ROOT/skills/subagent-driven-development/scripts/task-brief"
IMPLEMENTER="$REPO_ROOT/skills/subagent-driven-development/implementer-prompt.md"
EXECUTING="$REPO_ROOT/skills/executing-plans/SKILL.md"
PLUGIN="$REPO_ROOT/.codex-plugin/plugin.json"
REFINING="$REPO_ROOT/skills/refining-plans/SKILL.md"
PLAN_FIXER_ROLE="$REPO_ROOT/.codex/agents/plan-fixer.toml"
PLAN_SIMULATOR_ROLE="$REPO_ROOT/.codex/agents/plan-simulator.toml"

FAILURES=0

pass() { printf 'PASS: %s\n' "$1"; }
fail() {
  printf 'FAIL: %s\n' "$1"
  FAILURES=$((FAILURES + 1))
}

assert_contains() {
  local file="$1"
  local text="$2"
  local label="$3"
  if [[ -f "$file" ]] && grep -Fq -- "$text" "$file"; then
    pass "$label"
  else
    fail "$label"
  fi
}

assert_not_contains() {
  local file="$1"
  local text="$2"
  local label="$3"
  if [[ -f "$file" ]] && ! grep -Fq -- "$text" "$file"; then
    pass "$label"
  else
    fail "$label"
  fi
}

assert_present() {
  local path="$1"
  local label="$2"
  if [[ -f "$path" ]]; then pass "$label"; else fail "$label"; fi
}

assert_absent() {
  local path="$1"
  local label="$2"
  if [[ ! -e "$path" ]]; then pass "$label"; else fail "$label"; fi
}

assert_contains "$WRITING" '**Spec:**' 'plan header carries the spec path'
assert_contains "$WRITING" '**Spec revision:**' 'plan header carries the spec revision'
assert_contains "$WRITING" '**Risk class:**' 'plan header carries risk class'
assert_contains "$WRITING" '**Risk triggers:**' 'plan header carries named risk triggers'
assert_contains "$WRITING" '**Verification lanes:**' 'plan header carries verification lanes'
assert_contains "$WRITING" '## Author Self-Review' 'plan author owns a whole-plan self-review'
assert_contains "$WRITING" 'exactly one holistic readiness review' 'named risk gets one holistic readiness gate'
assert_contains "$WRITING" 'two correction rounds' 'planning correction circuit breaker is bounded'
assert_contains "$WRITING" 'The plan author applies supported findings directly.' 'controller retains plan mutation ownership'
assert_contains "$WRITING" 'A plan may explicitly override the execution route' 'approved self-hosting route is preserved'
assert_not_contains "$WRITING" 'After completing each chunk of the plan' 'per-chunk review loop is removed'
assert_contains "$WRITING" 'independent subsystems can ship and verify separately' 'separable subsystems become separate plans'
assert_not_contains "$WRITING" 'If independent subsystems cannot ship and verify separately' 'scope split condition is not reversed'
assert_contains "$WRITING" 'Do not hand off until the reviewer returns `READY`.' 'all not-ready outcomes block handoff'
assert_contains "$WRITING" 'resolution updates the specification and plan' 'human decisions return through the readiness gate'
assert_contains "$WRITING" 'destructive or external authority' 'all protected decision classes route to the human'
assert_contains "$WRITING" '## Readiness Record' 'readiness dispositions persist in the plan'
assert_contains "$WRITING" 'Record every readiness finding' 'the complete readiness ruling survives compaction'
assert_present "$READINESS" 'holistic readiness reviewer prompt exists'
assert_absent "$OLD_REVIEWER" 'per-chunk plan reviewer prompt is removed'
assert_contains "$READINESS" 'full approved specification' 'readiness reviewer consumes the full spec'
assert_contains "$READINESS" 'full implementation plan' 'readiness reviewer consumes the full plan'
assert_contains "$READINESS" 'BLOCKING' 'readiness prompt defines blocking findings'
assert_contains "$READINESS" 'DECISION' 'readiness prompt defines decision findings'
assert_contains "$READINESS" 'FOLLOW_UP' 'readiness prompt defines follow-up findings'
assert_contains "$READINESS" 'INVALID' 'readiness prompt defines invalid findings'
assert_contains "$READINESS" 'candidate causal connection' 'findings require a causal connection to changed work'
assert_contains "$READINESS" 'proof' 'findings require evidence'
assert_contains "$READINESS" 'A `BLOCKING` or `DECISION` finding is supported only when' 'load-bearing findings require causality'
assert_contains "$READINESS" 'A real defect with proof but no candidate causal connection is `FOLLOW_UP`.' 'adjacent real defects remain follow-ups'
assert_contains "$TASK_BRIEF" 'TDD execution mechanics' 'SDD task briefs carry global TDD mechanics'
assert_contains "$TASK_BRIEF" 'Finishing alone owns the complete repository suite.' 'task brief reserves complete suite for finishing'
assert_contains "$IMPLEMENTER" 'Finishing alone owns the complete repository suite.' 'implementer prompt reserves complete suite for finishing'
assert_not_contains "$IMPLEMENTER" 'run the full suite once before committing' 'implementer no longer repeats the complete suite'
assert_contains "$EXECUTING" 'Execute the task contract' 'inline execution consumes contract-shaped tasks'
assert_not_contains "$EXECUTING" 'plan has bite-sized steps' 'inline execution does not require legacy step boilerplate'
assert_contains "$EXECUTING" 'If the plan explicitly selects this skill, honor that override' 'inline execution preserves an explicit route override'
assert_absent "$REFINING" 'duplicate refining-plans skill is removed'
assert_absent "$PLAN_FIXER_ROLE" 'plan-fixer role is removed'
assert_absent "$PLAN_SIMULATOR_ROLE" 'plan-simulator role is removed'
assert_not_contains "$PLUGIN" 'refining-plans' 'plugin manifest has no refining-plans route'

if rg -n 'refining-plans|plan-fixer|plan-simulator|sp_plan_fixer|sp_plan_simulator' \
  "$REPO_ROOT/skills" "$REPO_ROOT/.codex/agents" "$REPO_ROOT/.codex-plugin" \
  --glob '!writing-plans/SKILL.md' >/dev/null; then
  fail 'live skill and role references to removed planning lane are absent'
else
  pass 'live skill and role references to removed planning lane are absent'
fi

if [[ "$FAILURES" -ne 0 ]]; then
  printf '%s\n' "$FAILURES lean-delivery contract test(s) failed"
  exit 1
fi

printf 'All lean-delivery contract tests passed\n'
