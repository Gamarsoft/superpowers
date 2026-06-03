#!/usr/bin/env bash
# Test: GSD review policy detail
# Verifies preferences preserve detailed code-review and visual-review workflow hooks.
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/../.." && pwd)"
PREFS="$ROOT_DIR/docs/gsd/preferences.md"

fail() {
  echo "  [FAIL] $1"
  exit 1
}

pass() {
  echo "  [PASS] $1"
}

assert_contains() {
  local pattern="$1"
  local label="$2"

  if grep -qiE "$pattern" "$PREFS"; then
    pass "$label"
  else
    fail "Expected preferences.md to contain pattern: $pattern"
  fi
}

assert_not_contains() {
  local pattern="$1"
  local label="$2"

  if grep -qiE "$pattern" "$PREFS"; then
    echo "  Matching lines:"
    grep -niE "$pattern" "$PREFS" | sed 's/^/    /'
    fail "$label"
  fi
  pass "$label"
}

echo "=== Test: GSD review policy detail ==="
echo ""

assert_contains "For each non-trivial implementation task, add a follow-up task named" "Planning hook requires follow-up review tasks"
assert_contains "Txx-REVIEW.md" "Planning hook names task code-review artifact"
assert_contains "Txx-VISUAL-REVIEW.md" "Planning hook names task visual-review artifact"
assert_contains "Review and resolve slice findings" "Planning hook preserves slice-level review task"
assert_contains "Use at most 4 fresh review cycles" "Review loop keeps cycle cap"

assert_contains "implementation-end-review" "Implementation-end hook names review mode"
assert_contains "git diff --submodule=diff" "Code review inspects submodule diffs"
assert_contains "Verdict, APPROVE \\| REQUEST_CHANGES \\| ESCALATE" "Code review artifact requires verdict"
assert_contains "Review Decision, no_action \\| remediate_and_rereview \\| escalate_replan" "Code review artifact requires review decision"
assert_contains "Do not fix or disprove findings from this final review pass" "Implementation-end hook forbids remediation"

assert_contains "load Impeccable" "Visual review hook restores Impeccable instruction"
assert_contains "mobile-design-review" "Visual review hook restores mobile review instruction"
assert_contains "fresh browser context" "Visual review hook requires fresh browser context"
assert_contains "do not reuse the implementer's browser session" "Visual review hook forbids reused browser state"
assert_contains "independently open the target route/screen" "Visual review hook requires independent recapture"
assert_contains "Visual Review Completion Gates" "Visual review hook requires gates"

assert_contains "review-resolve-loop" "Review-resolve hook names code-review loop mode"
assert_contains "overwrite the authoritative review artifact" "Review-resolve hook overwrites authoritative artifacts"
assert_contains "target the slice-level artifacts" "Review-resolve hook covers slice-level artifacts"

assert_not_contains "pencil|\\.pen\\b|workset|adapter" "Review policies stay free of removed workflow terms"

echo ""
echo "=== GSD review policy detail test passed ==="
