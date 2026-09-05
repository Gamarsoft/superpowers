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
REPORT_CONTRACT="$REPO_ROOT/skills/subagent-driven-development/references/execution-report.md"
PLUGIN="$REPO_ROOT/.codex-plugin/plugin.json"
REFINING="$REPO_ROOT/skills/refining-plans/SKILL.md"
PLAN_FIXER_ROLE="$REPO_ROOT/.codex/agents/plan-fixer.toml"
PLAN_SIMULATOR_ROLE="$REPO_ROOT/.codex/agents/plan-simulator.toml"
REQUESTING="$REPO_ROOT/skills/requesting-code-review/SKILL.md"
PUBLIC_REVIEWER="$REPO_ROOT/skills/requesting-code-review/code-reviewer.md"
PROFILE_SELECTION="$REPO_ROOT/skills/requesting-code-review/references/profile-selection.md"
RECEIVING="$REPO_ROOT/skills/receiving-code-review/SKILL.md"
FINISHING="$REPO_ROOT/skills/finishing-a-development-branch/SKILL.md"

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
assert_contains "$EXECUTING" 'use this skill only when the harness exposes no subagent tools' 'inline execution is the honest no-subagent route'
assert_contains "$EXECUTING" 'Goal, First delivery boundary, Risk class, Risk triggers, and Verification lanes' 'inline execution validates the shared plan contract'
assert_contains "$EXECUTING" 'scripts/sdd-workspace PLAN_FILE' 'inline execution uses the plan-scoped workspace'
assert_contains "$EXECUTING" 'execution-report.md' 'inline execution writes a finishing handoff'
assert_contains "$EXECUTING" 'Reviewer availability: unavailable' 'inline execution records absent independent review'
assert_contains "$EXECUTING" 'Do not claim fresh implementers, checkpoint reviewers' 'inline execution does not fabricate SDD guarantees'
assert_contains "$EXECUTING" 'one final independent review only when' 'inline execution uses a reviewer only when one exists'
assert_contains "$EXECUTING" 'Finishing alone runs the complete repository suite' 'inline execution leaves complete verification to finishing'
assert_contains "$EXECUTING" 'missing specification' 'inline execution stops for a missing specification'
assert_contains "$EXECUTING" 'repeated verification failure' 'inline execution stops for repeated verification failure'
assert_contains "$EXECUTING" 'unresolved observable WHAT' 'inline execution stops for unresolved product authority'
assert_contains "$EXECUTING" 'exact implementation HEAD' 'inline report binds the implementation revision'
assert_contains "$EXECUTING" 'clean worktree' 'inline report requires a clean implementation state'
assert_present "$REPORT_CONTRACT" 'shared execution-report contract exists'
for field in 'Plan:' 'Spec:' 'Spec revision:' 'Completed work' 'Focused verification' 'Integration verification' 'Controller rulings' 'Deviations' 'Follow-ups' 'Remaining risks' 'Decisions' 'Reviewer availability' 'Implementation HEAD:'; do
  assert_contains "$REPORT_CONTRACT" "$field" "execution report carries $field"
done
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

assert_contains "$REQUESTING" 'ad hoc, major-feature, or pre-integration' 'public requesting review has a narrow boundary'
assert_contains "$REQUESTING" 'requirements or approved specification source' 'standalone review requires an explicit contract source'
assert_contains "$REQUESTING" 'recorded BASE and HEAD' 'standalone review requires an exact recorded range'
assert_not_contains "$REQUESTING" 'HEAD~1' 'standalone review never guesses a one-commit base'
assert_contains "$REQUESTING" 'does not own SDD' 'standalone review relinquishes SDD ownership'
assert_contains "$REQUESTING" 'fork_turns: "none"' 'standalone Codex reviewer gets fresh context'
assert_contains "$REQUESTING" 'omit `agent_type`' 'standalone review has generic role fallback'
assert_contains "$PUBLIC_REVIEWER" 'candidate causal' 'public reviewer requires causality for blockers'
assert_contains "$PUBLIC_REVIEWER" 'Name the implied proposed change' 'review pressure is classified without relabeling approved behavior'
for disposition in BLOCKING DECISION FOLLOW_UP INVALID; do
  assert_contains "$PUBLIC_REVIEWER" "$disposition" "public reviewer defines $disposition"
done
assert_not_contains "$PUBLIC_REVIEWER" 'Critical \(Must Fix\)|Important \(Should Fix\)|Minor \(Nice to Have\)' 'public reviewer has no second severity ladder'
assert_contains "$PROFILE_SELECTION" 'changed files or named risk' 'profile selection is evidence-triggered'
assert_contains "$PROFILE_SELECTION" 'stack-neutral' 'default review remains stack-neutral'
assert_contains "$PROFILE_SELECTION" 'security-checklist.md' 'security depth has a conditional profile'
assert_contains "$PROFILE_SELECTION" 'java-21-spring-gke-checklist.md' 'Java depth has a conditional profile'
assert_contains "$RECEIVING" 'human, forge, or out-of-band' 'receiving review handles only external feedback'
assert_contains "$RECEIVING" 'Verify each finding before action' 'external feedback is verified before mutation'
for disposition in BLOCKING DECISION FOLLOW_UP INVALID; do
  assert_contains "$RECEIVING" "\`$disposition\`" "receiving review defines $disposition"
done
assert_contains "$RECEIVING" 'does not own SDD' 'receiving review relinquishes SDD ownership'
assert_not_contains "$RECEIVING" 'From Subagent Reviews|subagent-driven-development' 'receiving review excludes internal SDD findings'

assert_contains "$FINISHING" 'Require both the plan path and its plan-scoped `execution-report.md` path' 'finishing requires the producer handoff'
assert_contains "$FINISHING" 'before running the complete repository suite' 'stale reports stop before complete verification'
assert_contains "$FINISHING" 'return ownership to the producing workflow' 'stale reports return to final review'
assert_contains "$FINISHING" 'Run the complete repository suite exactly once' 'finishing has sole one-shot complete verification'
assert_contains "$FINISHING" 'docs/superpowers/execution-reports/<plan-basename>-<short-implementation-head>.md' 'durable report path is implementation-head suffixed'
assert_contains "$FINISHING" 'git add -- "$REPORT_DEST"' 'only the completed report is staged'
assert_contains "$FINISHING" 'git diff --name-only "$IMPLEMENTATION_HEAD..HEAD"' 'report range is checked against implementation head'
assert_contains "$FINISHING" 'contains only `$REPORT_DEST`' 'report commit rejects implementation changes'
assert_contains "$FINISHING" 'Do not run the complete suite again' 'invalid report ranges never trigger a second suite'
assert_contains "$FINISHING" 'Merge, PR, and keep-as-is preserve the committed report' 'all non-discard paths preserve evidence'
assert_contains "$FINISHING" 'report-copy collision' 'finishing stops rather than overwriting evidence'
assert_contains "$FINISHING" 'report-only finishing resume' 'finishing can resume after its report commit'
assert_contains "$FINISHING" 'does not rerun the suite or create another report commit' 'finishing resume is idempotent'

if [[ "$FAILURES" -ne 0 ]]; then
  printf '%s\n' "$FAILURES lean-delivery contract test(s) failed"
  exit 1
fi

printf 'All lean-delivery contract tests passed\n'
