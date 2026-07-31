#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
SDD_DIR="$REPO_ROOT/skills/subagent-driven-development"
SKILL="$SDD_DIR/SKILL.md"
IMPLEMENTER="$SDD_DIR/implementer-prompt.md"
TASK_REVIEWER="$SDD_DIR/task-reviewer-prompt.md"
RE_REVIEWER="$SDD_DIR/re-review-prompt.md"

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

assert_absent() {
  local path="$1"
  local label="$2"
  if [[ -e "$path" ]]; then
    echo "FAIL: $label"
    echo "  Unexpected legacy path: $path"
    exit 1
  fi
}

assert_contains "$SKILL" 'sp_implementer_spark' 'Codex typed implementer roles are documented'
assert_contains "$SKILL" 'sp_code_reviewer' 'Codex combined reviewer role is documented'
assert_contains "$IMPLEMENTER" '^    ## Context7 Findings$' 'implementer receives Context7 findings'
assert_contains "$IMPLEMENTER" 'DO_NOT_REQUERY_CONTEXT7' 'implementer does not duplicate Context7 research'
assert_contains "$IMPLEMENTER" 'source of truth for HOW' 'codebase governs implementation approach'
assert_contains "$IMPLEMENTER" 'source of truth for WHAT' 'task brief governs required behavior'
assert_contains "$IMPLEMENTER" 'SAFETY_ADDITION' 'implementer reports categorized concerns'
assert_contains "$IMPLEMENTER" 'PLAN_DEVIATION' 'implementer reports plan deviations explicitly'
assert_contains "$TASK_REVIEWER" 'java-21-spring-gke-checklist\.md' 'combined task reviewer applies the Java/Spring/GKE checklist when relevant'
assert_contains "$TASK_REVIEWER" 'read-only' 'combined task reviewer remains read-only'
assert_contains "$RE_REVIEWER" 'read-only' 'scoped re-reviewer remains read-only'
assert_absent "$SDD_DIR/spec-reviewer-prompt.md" 'legacy independent spec reviewer stays removed'
assert_absent "$SDD_DIR/code-quality-reviewer-prompt.md" 'legacy independent quality reviewer stays removed'

echo 'PASS: custom SDD contracts coexist with the upstream workspace/review lifecycle'
