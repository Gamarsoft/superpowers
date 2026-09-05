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
JAVA_PROFILE="$REPO_ROOT/skills/requesting-code-review/references/java-21-spring-gke-checklist.md"
SPEC_REVIEWER="$REPO_ROOT/skills/brainstorming/spec-document-reviewer-prompt.md"
SPEC_REVIEW_CHECKLIST="$REPO_ROOT/skills/brainstorming/references/spec-review-checklist.md"
RECEIVING="$REPO_ROOT/skills/receiving-code-review/SKILL.md"
FINISHING="$REPO_ROOT/skills/finishing-a-development-branch/SKILL.md"
README="$REPO_ROOT/README.md"
TESTING_DOC="$REPO_ROOT/docs/testing.md"
RELEASE_NOTES="$REPO_ROOT/RELEASE-NOTES.md"
SMOKE_SPEC="$REPO_ROOT/tests/codex/sdd-behavior/fixtures/approved-spec.md"
SMOKE_PLAN="$REPO_ROOT/tests/codex/sdd-behavior/fixtures/implementation-plan.md"
SMOKE_FACTORY="$REPO_ROOT/tests/codex/sdd-behavior/fixtures/create-smoke-repo.sh"
DELIVERY_ROUTING="$REPO_ROOT/skills/brainstorming/references/delivery-routing.md"
DELIVERY_PLAN="$REPO_ROOT/docs/superpowers/plans/2026-09-04-lean-risk-scaled-superpowers-delivery.md"
FINISHING_SCENARIO="$REPO_ROOT/tests/codex/sdd-behavior/scenarios/finishing-evidence.md"
MISSING_ROLE_SCENARIO="$REPO_ROOT/tests/codex/sdd-behavior/scenarios/missing-role-fallback.md"

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

assert_count() {
  local file="$1"
  local text="$2"
  local expected="$3"
  local label="$4"
  local actual
  actual="$(grep -Foc -- "$text" "$file" || true)"
  if [[ "$actual" = "$expected" ]]; then
    pass "$label"
  else
    fail "$label"
  fi
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
assert_contains "$DELIVERY_PLAN" '**First delivery boundary:**' 'self-hosting plan declares its first delivery boundary'
assert_contains "$DELIVERY_PLAN" '**Spec revision:**' 'self-hosting plan records a separate spec revision'
assert_contains "$DELIVERY_PLAN" '**Current worktree:**' 'self-hosting plan records its execution worktree'
assert_contains "$DELIVERY_PLAN" '**Implementation base:**' 'self-hosting plan records its implementation base'
assert_contains "$DELIVERY_PLAN" '## Author Self-Review' 'self-hosting plan uses the shared author-review heading'
assert_contains "$DELIVERY_PLAN" '## Readiness Record' 'self-hosting plan persists holistic readiness evidence'
assert_contains "$DELIVERY_PLAN" '**Result:** READY' 'self-hosting plan is ready before implementation handoff'
assert_contains "$FINISHING_SCENARIO" 'the sole full-suite run fails' 'behavior probe covers complete-suite failure'
assert_contains "$FINISHING_SCENARIO" 'refuses a second run for that failed HEAD' 'behavior probe covers failed-head non-retry'
assert_contains "$FINISHING_SCENARIO" 'archives the rejected report and marker' 'behavior probe covers producer-return archival'
assert_contains "$FINISHING_SCENARIO" 'advances the existing final-evidence budget to round 2' 'behavior probe preserves the final-evidence breaker'
assert_contains "$FINISHING_SCENARIO" 'hands off only the new HEAD' 'behavior probe requires refreshed evidence at a new head'
assert_contains "$MISSING_ROLE_SCENARIO" 'Operationally prove the fallback with exactly two harmless dispatches' 'missing-role probe requires executed fallback dispatches'
assert_contains "$MISSING_ROLE_SCENARIO" 'with `agent_type` omitted' 'missing-role probe omits unavailable typed roles'
assert_contains "$MISSING_ROLE_SCENARIO" '`fork_turns: "none"`' 'missing-role probe gives fallback agents fresh context'
assert_contains "$MISSING_ROLE_SCENARIO" 'actually performed in this actor session.' 'missing-role probe records only observed actions'
assert_contains "$MISSING_ROLE_SCENARIO" 'Retained operational parent/child traces prove both generic dispatches' 'missing-role probe requires durable operational proof'
assert_contains "$MISSING_ROLE_SCENARIO" '`scope=bounded-probe`' 'implementation marker proves prompt scope'
assert_contains "$MISSING_ROLE_SCENARIO" '`dispositions=BLOCKING,DECISION,FOLLOW_UP,INVALID`' 'review marker proves shared dispositions'
assert_contains "$MISSING_ROLE_SCENARIO" '`range=BASE..HEAD`' 'review marker proves exact-range evidence'
assert_contains "$MISSING_ROLE_SCENARIO" '`read-only=true`' 'review marker proves read-only isolation'
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
assert_contains "$EXECUTING" 'Inspect the runtime-advertised role list' 'inline optional review checks available reviewer roles'
assert_contains "$EXECUTING" 'agent_type: "sp_reviewer"' 'inline optional review uses the unified typed reviewer when available'
assert_contains "$EXECUTING" 'fork_turns: "none"' 'inline optional review gives reviewers fresh context'
assert_contains "$EXECUTING" 'omit `agent_type`' 'inline optional review has a generic reviewer fallback'
assert_contains "$EXECUTING" 'fresh generic reviewer' 'inline optional review uses a fresh generic fallback'
assert_contains "$EXECUTING" 'identical complete review prompt' 'inline generic fallback preserves review coverage'
assert_contains "$EXECUTING" 'Do not skip this review because `sp_reviewer` is absent.' 'inline review does not depend on the typed role'
assert_contains "$EXECUTING" 'Do not spawn subagents' 'inline reviewer cannot delegate its evidence check'
assert_contains "$EXECUTING" 'full approved specification and plan' 'inline reviewer receives the approved contract'
assert_contains "$EXECUTING" 'exact implementation BASE and HEAD' 'inline reviewer receives the recorded range'
assert_contains "$EXECUTING" '`BASE..HEAD` review package' 'inline reviewer receives cumulative diff evidence'
assert_contains "$EXECUTING" 'selected risk profiles' 'inline reviewer receives selected review depth'
assert_contains "$EXECUTING" 'focused and integration evidence' 'inline reviewer receives existing verification evidence'
assert_contains "$EXECUTING" 'candidate causal connection' 'inline reviewer requires causal findings'
assert_contains "$EXECUTING" 'exact verdict/report contract' 'inline reviewer receives an explicit output contract'
assert_contains "$EXECUTING" 'ID | Disposition | Location | Proof | Candidate causal connection | Concrete failure | Required resolution' 'inline reviewer returns the shared finding table'
assert_contains "$EXECUTING" 'Spec compliance: `PASS` or `FAIL`' 'inline reviewer reports specification compliance'
assert_contains "$EXECUTING" 'Change quality: `PASS` or `FAIL`' 'inline reviewer reports implementation quality'
assert_contains "$EXECUTING" 'Evidence checked:' 'inline reviewer reports inspected evidence'
assert_contains "$EXECUTING" 'Verdict: `READY` only when no `BLOCKING` or `DECISION` remains' 'inline reviewer uses the shared readiness rule'
assert_contains "$EXECUTING" 'Finishing alone runs the complete repository suite' 'inline execution leaves complete verification to finishing'
assert_contains "$EXECUTING" 'at most two correction plus re-review rounds' 'inline execution has the shared correction budget'
assert_contains "$EXECUTING" 'stop before a third correction' 'inline execution trips the shared correction breaker'
assert_contains "$EXECUTING" 'producer-return.md' 'inline execution can resume a failed finishing handoff'
assert_contains "$EXECUTING" 'preserve the existing final-evidence correction count' 'inline finishing return cannot reset the correction budget'
assert_contains "$EXECUTING" 'missing specification' 'inline execution stops for a missing specification'
assert_contains "$EXECUTING" 'repeated verification failure' 'inline execution stops for repeated verification failure'
assert_contains "$EXECUTING" 'unresolved observable WHAT' 'inline execution stops for unresolved product authority'
assert_contains "$EXECUTING" 'exact implementation HEAD' 'inline report binds the implementation revision'
assert_contains "$EXECUTING" 'clean worktree' 'inline report requires a clean implementation state'
assert_present "$REPORT_CONTRACT" 'shared execution-report contract exists'
for field in 'Plan:' 'Spec:' 'Spec revision:' 'Final-evidence correction count:' 'Completed work' 'Focused verification' 'Integration verification' 'Controller rulings' 'Deviations' 'Follow-ups' 'Remaining risks' 'Decisions' 'Reviewer availability' 'Implementation HEAD:'; do
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
for disposition in BLOCKING DECISION FOLLOW_UP INVALID; do
  assert_contains "$SPEC_REVIEWER" "$disposition" "brainstorming reviewer defines $disposition"
done
assert_contains "$SPEC_REVIEWER" 'candidate causal connection' 'brainstorming reviewer requires causality'
assert_contains "$SPEC_REVIEWER" 'Proof' 'brainstorming reviewer requires evidence'
assert_contains "$SPEC_REVIEWER" 'READY' 'brainstorming reviewer returns the shared readiness verdict'
assert_not_contains "$SPEC_REVIEWER" 'Blocking Issues' 'brainstorming reviewer drops the legacy output taxonomy'
assert_contains "$SPEC_REVIEW_CHECKLIST" 'BLOCKING' 'brainstorming checklist uses shared blocking disposition'
assert_contains "$SPEC_REVIEW_CHECKLIST" 'DECISION' 'brainstorming checklist uses shared decision disposition'
assert_contains "$SPEC_REVIEW_CHECKLIST" 'FOLLOW_UP' 'brainstorming checklist uses shared follow-up disposition'
assert_contains "$SPEC_REVIEW_CHECKLIST" 'INVALID' 'brainstorming checklist uses shared invalid disposition'
assert_not_contains "$JAVA_PROFILE" 'Treat as Critical' 'Java profile does not restore a critical severity tier'
assert_not_contains "$JAVA_PROFILE" 'Treat as Important' 'Java profile does not restore an important severity tier'
assert_contains "$JAVA_PROFILE" 'shared dispositions' 'Java profile remains subordinate to shared dispositions'
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
assert_contains "$FINISHING" 'once for each handed-off Implementation HEAD' 'failed finishing attempts cannot rerun against one implementation head'
assert_contains "$FINISHING" 'producer-return.md' 'finishing persists its return transition'
assert_contains "$FINISHING" 'failed Implementation HEAD' 'finishing return evidence identifies the failed revision'
assert_contains "$FINISHING" 'Malformed or unreachable handoffs stop without a producer-return marker.' 'unidentifiable handoffs do not fabricate return identity'
assert_contains "$FINISHING" 'Final-evidence correction count' 'finishing validates the explicit correction count'
assert_contains "$REPORT_CONTRACT" 'Only a validated, identity-bearing handoff can produce this marker.' 'shared return schema excludes unidentifiable handoffs'
assert_contains "$FINISHING" 'docs/superpowers/execution-reports/<plan-basename>-<short-implementation-head>.md' 'durable report path is implementation-head suffixed'
assert_contains "$FINISHING" 'git add -- "$REPORT_DEST"' 'only the completed report is staged'
assert_contains "$FINISHING" 'git diff --name-only "$IMPLEMENTATION_HEAD..HEAD"' 'report range is checked against implementation head'
assert_contains "$FINISHING" 'contains only `$REPORT_DEST`' 'report commit rejects implementation changes'
assert_contains "$FINISHING" 'Do not run the complete suite again' 'invalid report ranges never trigger a second suite'
assert_contains "$FINISHING" 'Merge, PR, and keep-as-is preserve the committed report' 'all non-discard paths preserve evidence'
assert_contains "$FINISHING" 'report-copy collision' 'finishing stops rather than overwriting evidence'
assert_contains "$FINISHING" 'report-only finishing resume' 'finishing can resume after its report commit'
assert_contains "$FINISHING" 'does not rerun the suite or create another report commit' 'finishing resume is idempotent'

assert_contains "$README" 'ordinary work in compatible batches of at most three tasks' 'README describes bounded ordinary batches'
assert_contains "$README" 'review-required work individually' 'README describes risk-scaled review cadence'
assert_contains "$README" 'two correction rounds' 'README describes the bounded correction breaker'
assert_contains "$README" 'ad hoc, major-feature, and pre-integration reviews' 'README keeps public review outside SDD orchestration'
assert_contains "$README" 'runs the complete repository suite exactly once' 'README assigns the sole complete suite to finishing'
assert_contains "$README" 'generic fresh agents without losing implementation or review coverage' 'README documents missing-role fallback'
assert_not_contains "$README" 'fresh implementer per task' 'README removes unconditional per-task dispatch'
assert_not_contains "$README" 'Activates between tasks' 'README removes public-review task-loop ownership'
assert_not_contains "$README" 'reports issues by severity' 'README removes the obsolete severity ladder'
assert_not_contains "$README" 'broad final review' 'README removes the obsolete broad-review wording'
assert_contains "$DELIVERY_ROUTING" 'risk-scaled review' 'delivery routing advertises the new review model'
assert_not_contains "$DELIVERY_ROUTING" 'per-task review' 'delivery routing removes unconditional per-task review'
assert_not_contains "$REPO_ROOT/skills/brainstorming/SKILL.md" 'Maximum 5 iterations' 'brainstorming review loops use the shared breaker'
assert_contains "$REPO_ROOT/skills/brainstorming/SKILL.md" 'at most two correction plus re-review rounds' 'brainstorming names the shared two-round breaker'
assert_count "$REPO_ROOT/skills/brainstorming/SKILL.md" 'When a supported `DECISION` remains, ask one bounded human question' 2 'both brainstorming review gates route decisions to the human'

assert_contains "$TESTING_DOC" 'tests/codex/sdd-behavior/' 'testing guide names the local Codex behavior suite'
assert_contains "$TESTING_DOC" 'immutable run directories' 'testing guide documents immutable behavior evidence'
assert_contains "$TESTING_DOC" 'does not replace the external Drill suite' 'testing guide distinguishes local probes from Drill'

assert_contains "$RELEASE_NOTES" '## Gamarsoft fork (unreleased)' 'release notes identify the fork-only unreleased changes'
assert_contains "$RELEASE_NOTES" '`refining-plans` is removed' 'release notes disclose the removed planning lane'
assert_contains "$RELEASE_NOTES" 'four optional local Codex roles' 'release notes disclose role consolidation'

assert_contains "$SMOKE_SPEC" 'returns `already_reserved` with the first call' 'smoke spec defines duplicate status and retained result'
assert_contains "$SMOKE_PLAN" 'Complete-suite command: `python3 -m unittest discover -s tests -v`' 'smoke plan names finishing command exactly'
assert_contains "$SMOKE_PLAN" '**Goal:**' 'smoke plan declares its goal'
assert_contains "$SMOKE_PLAN" '**First delivery boundary:**' 'smoke plan declares its first boundary'
assert_contains "$SMOKE_PLAN" '**Implementation base:** `sdd-smoke-base`' 'smoke plan declares an explicit base ref'
assert_contains "$SMOKE_PLAN" '**Spec:** `docs/approved-spec.md`' 'smoke plan declares a root-reachable specification'
assert_not_contains "$SMOKE_PLAN" '**Risk triggers:** money, concurrency, idempotency, cross-task contract' 'smoke plan omits an unused cross-task trigger'
assert_contains "$SMOKE_PLAN" '## Readiness Record' 'smoke plan carries readiness evidence'
assert_contains "$SMOKE_PLAN" '**Result:** NOT READY' 'smoke begins with a readiness blocker'
assert_count "$SMOKE_PLAN" '**Files / ownership:**' 4 'every smoke task declares ownership'
assert_count "$SMOKE_PLAN" '**Contracts:**' 4 'every smoke task declares contracts'
assert_count "$SMOKE_PLAN" '**Dependencies:**' 4 'every smoke task declares dependencies'
assert_count "$SMOKE_PLAN" '**Acceptance criteria:**' 4 'every smoke task declares acceptance'
assert_count "$SMOKE_PLAN" '**Error boundaries:**' 4 'every smoke task declares errors'
assert_count "$SMOKE_PLAN" '**Risk:**' 4 'every smoke task declares risk'
assert_count "$SMOKE_PLAN" '**Focused verification:**' 4 'every smoke task declares focused verification'
assert_count "$SMOKE_PLAN" '**Codebase pointers:**' 4 'every smoke task declares codebase pointers'
assert_count "$SMOKE_PLAN" '**Risk:** checkpoint-review; no named risk trigger' 3 'three label tasks form an ordinary checkpoint batch'
assert_not_contains "$SMOKE_PLAN" 'public label convention' 'ordinary label batch does not claim a public-contract trigger'
assert_not_contains "$SMOKE_PLAN" 'All four public functions' 'ordinary label batch does not claim every helper is public'
assert_not_contains "$SMOKE_FACTORY" 'unimplemented' 'smoke shape test remains valid after implementation'
assert_not_contains "$SMOKE_FACTORY" 'queue_label.py").exists' 'smoke shape test does not reject completed work'
assert_contains "$SMOKE_FACTORY" 'tag sdd-smoke-base' 'smoke factory creates its declared implementation base'

SMOKE_CHECK_ROOT="$(mktemp -d /tmp/superpowers-smoke-contract.XXXXXX)"
trap 'rm -rf "$SMOKE_CHECK_ROOT"' EXIT
bash "$SMOKE_FACTORY" "$SMOKE_CHECK_ROOT/repo" >/dev/null
if git -C "$SMOKE_CHECK_ROOT/repo" rev-parse --verify 'sdd-smoke-base^{commit}' >/dev/null 2>&1; then
  pass 'generated smoke checkout resolves its implementation base'
else
  fail 'generated smoke checkout resolves its implementation base'
fi
if [[ -f "$SMOKE_CHECK_ROOT/repo/docs/approved-spec.md" ]]; then
  pass 'generated smoke checkout resolves its declared specification'
else
  fail 'generated smoke checkout resolves its declared specification'
fi

if [[ "$FAILURES" -ne 0 ]]; then
  printf '%s\n' "$FAILURES lean-delivery contract test(s) failed"
  exit 1
fi

printf 'All lean-delivery contract tests passed\n'
