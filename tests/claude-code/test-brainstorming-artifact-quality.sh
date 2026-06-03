#!/usr/bin/env bash
# Test: brainstorming artifact quality gates
# Verifies compact brainstorming templates still preserve handoff-ready detail.
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/../.." && pwd)"

fail() {
  echo "  [FAIL] $1"
  exit 1
}

pass() {
  echo "  [PASS] $1"
}

assert_file_contains() {
  local rel="$1"
  local pattern="$2"
  local label="$3"

  if grep -qiE "$pattern" "$ROOT_DIR/$rel"; then
    pass "$label"
  else
    fail "Expected $rel to contain pattern: $pattern"
  fi
}

assert_file_not_contains() {
  local rel="$1"
  local pattern="$2"
  local label="$3"

  if grep -qiE "$pattern" "$ROOT_DIR/$rel"; then
    fail "Expected $rel to avoid pattern: $pattern"
  else
    pass "$label"
  fi
}

echo "=== Test: brainstorming artifact quality gates ==="
echo ""

assert_file_contains \
  "skills/brainstorming/references/spec-template.md" \
  "## Quality bar" \
  "Spec template has a quality bar"
assert_file_contains \
  "skills/brainstorming/references/spec-template.md" \
  "who it is for" \
  "Spec quality bar names audience"
assert_file_contains \
  "skills/brainstorming/references/spec-template.md" \
  "what problem it solves" \
  "Spec quality bar names problem"
assert_file_contains \
  "skills/brainstorming/references/spec-template.md" \
  "chosen direction" \
  "Spec quality bar names chosen direction"
assert_file_contains \
  "skills/brainstorming/references/spec-template.md" \
  "not in scope" \
  "Spec quality bar names scope boundary"
assert_file_contains \
  "skills/brainstorming/references/spec-template.md" \
  "risks" \
  "Spec quality bar names risks"
assert_file_contains \
  "skills/brainstorming/references/spec-template.md" \
  "behavior detail" \
  "Spec quality bar names behavior detail"
assert_file_contains \
  "skills/brainstorming/references/spec-template.md" \
  "consistent with the handoff" \
  "Spec quality bar requires handoff consistency"
assert_file_contains \
  "skills/brainstorming/references/spec-template.md" \
  "Optional Track-Specific Sections" \
  "Spec template preserves track-specific guidance"
assert_file_contains \
  "skills/brainstorming/references/spec-template.md" \
  "Wireframes" \
  "Spec template preserves durable wireframe appendix guidance"
assert_file_contains \
  "skills/brainstorming/references/spec-template.md" \
  "copy acceptance criteria" \
  "Spec template preserves UX copy acceptance detail"
assert_file_contains \
  "skills/brainstorming/references/spec-template.md" \
  "Runtime screenshots and browser captures" \
  "Spec template preserves runtime visual evidence links"
assert_file_contains \
  "skills/brainstorming/references/spec-template.md" \
  "visual-truth, semantic-guidance, reference-only" \
  "Spec template preserves visual reference intent modes"

assert_file_contains \
  "skills/brainstorming/references/gsd-handoff-template.md" \
  "## Quality bar" \
  "GSD handoff template has a quality bar"
assert_file_contains \
  "skills/brainstorming/references/gsd-handoff-template.md" \
  "Active.*Deferred.*Out of Scope" \
  "GSD handoff quality bar names requirement buckets"
assert_file_contains \
  "skills/brainstorming/references/gsd-handoff-template.md" \
  "Requirements Reconciliation" \
  "GSD handoff quality bar requires reconciliation"
assert_file_contains \
  "skills/brainstorming/references/gsd-handoff-template.md" \
  "Reused unchanged" \
  "GSD handoff preserves reused requirement detail"
assert_file_contains \
  "skills/brainstorming/references/gsd-handoff-template.md" \
  "Reactivated from deferred" \
  "GSD handoff preserves reactivated requirement detail"
assert_file_contains \
  "skills/brainstorming/references/gsd-handoff-template.md" \
  "Narrowed / split / clarified" \
  "GSD handoff preserves narrowed requirement detail"
assert_file_contains \
  "skills/brainstorming/references/gsd-handoff-template.md" \
  "Superseded for this scope" \
  "GSD handoff preserves superseded requirement detail"
assert_file_contains \
  "skills/brainstorming/references/gsd-handoff-template.md" \
  "Still deferred" \
  "GSD handoff preserves deferred requirement detail"
assert_file_contains \
  "skills/brainstorming/references/gsd-handoff-template.md" \
  "first milestone" \
  "GSD handoff quality bar names first milestone"
assert_file_contains \
  "skills/brainstorming/references/gsd-handoff-template.md" \
  "constraints and integration points" \
  "GSD handoff quality bar names implementation constraints"
assert_file_contains \
  "skills/brainstorming/references/gsd-handoff-template.md" \
  "frontend inputs" \
  "GSD handoff quality bar names frontend inputs"
assert_file_contains \
  "skills/brainstorming/references/gsd-handoff-template.md" \
  "slice thinking" \
  "GSD handoff quality bar names slice thinking"
assert_file_contains \
  "skills/brainstorming/references/gsd-handoff-template.md" \
  "Downstream frontend guidance" \
  "GSD handoff preserves downstream frontend guidance"
assert_file_contains \
  "skills/brainstorming/references/gsd-handoff-template.md" \
  "visual reference intent approvals" \
  "GSD handoff preserves reference-intent approvals"
assert_file_contains \
  "skills/brainstorming/references/gsd-handoff-template.md" \
  "Do not treat unapproved screenshots" \
  "GSD handoff blocks unapproved visual truth"
assert_file_contains \
  "skills/brainstorming/references/gsd-handoff-template.md" \
  "Using This With GSD" \
  "GSD handoff preserves steering instructions"
assert_file_contains \
  "skills/brainstorming/references/gsd-handoff-template.md" \
  "Only ask follow-up questions about unresolved items" \
  "GSD handoff preserves follow-up question boundary"

assert_file_contains \
  "skills/brainstorming/SKILL.md" \
  "Compact does not mean lossy" \
  "Brainstorming skill states compact is not lossy"
assert_file_contains \
  "skills/brainstorming/SKILL.md" \
  "implementation-shaping details" \
  "Brainstorming skill preserves implementation-shaping details"
assert_file_contains \
  "skills/brainstorming/SKILL.md" \
  "state coverage" \
  "Brainstorming skill preserves state coverage"
assert_file_contains \
  "skills/brainstorming/SKILL.md" \
  "failure behavior" \
  "Brainstorming skill preserves failure behavior"
assert_file_contains \
  "skills/brainstorming/SKILL.md" \
  "rollout" \
  "Brainstorming skill preserves rollout detail"
assert_file_contains \
  "skills/brainstorming/SKILL.md" \
  "open questions" \
  "Brainstorming skill preserves open questions"

assert_file_not_contains \
  "skills/brainstorming/references/spec-template.md" \
  "Pencil|\\.pen\\b|workset|adapter" \
  "Spec template stays free of removed workflow terms"
assert_file_not_contains \
  "skills/brainstorming/references/gsd-handoff-template.md" \
  "Pencil|\\.pen\\b|workset|adapter" \
  "GSD handoff template stays free of removed workflow terms"

echo ""
echo "=== Brainstorming artifact quality gates test passed ==="
