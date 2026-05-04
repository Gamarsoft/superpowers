#!/usr/bin/env bash
# Test: GSD frontend visual review policy hardening
# Verifies that visual reviewer instructions require independent, complete browser review.
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/../.." && pwd)"

assert_contains_text() {
  local text="$1"
  local pattern="$2"
  local name="$3"

  if grep -qi "$pattern" <<< "$text"; then
    echo "  [PASS] $name"
  else
    echo "  [FAIL] $name"
    echo "  Expected policy to contain pattern: $pattern"
    exit 1
  fi
}

assert_file_contains() {
  local file="$1"
  local pattern="$2"
  local name="$3"
  local text

  text="$(cat "$ROOT_DIR/$file")"
  assert_contains_text "$text" "$pattern" "$name"
}

assert_visual_review_contract() {
  local file="$1"
  local label="$2"

  assert_file_contains "$file" "project instructions" "$label reads project instructions"
  assert_file_contains "$file" "AGENTS.md" "$label names AGENTS.md"
  assert_file_contains "$file" "PRODUCT.md" "$label names PRODUCT.md"
  assert_file_contains "$file" "DESIGN.md" "$label names DESIGN.md"
  assert_file_contains "$file" "fresh browser" "$label requires fresh browser context"
  assert_file_contains "$file" "do not reuse" "$label forbids reusing implementer browser"
  assert_file_contains "$file" "independently open" "$label requires independent route opening"
  assert_file_contains "$file" "Implementer screenshots.*not a substitute" "$label rejects implementer proof as substitute"
  assert_file_contains "$file" "ERR_CONNECTION_REFUSED\\|connection refused\\|server unavailable" "$label names runtime unreachable failures"
  assert_file_contains "$file" "must not approve" "$label blocks approval without runtime proof"
  assert_file_contains "$file" "Visual Review Completion Gates" "$label requires completion gates"
  assert_file_contains "$file" "recorded fallback\\|record the limitation" "$label records browser-isolation fallback"
  assert_file_contains "$file" "approved reference checklist completion" "$label gates approved reference checklist"
  assert_file_contains "$file" "desktop/mobile" "$label gates desktop/mobile scope"
  assert_file_contains "$file" "console/network" "$label gates console/network checks"
}

echo "=== Test: GSD frontend visual review policy ==="
echo ""

assert_visual_review_contract "skills/gsd-frontend-design/SKILL.md" "Skill policy"
assert_visual_review_contract "docs/gsd/AGENTS.md" "GSD AGENTS policy"
assert_visual_review_contract "docs/gsd/preferences.md" "GSD hook policy"

assert_file_contains \
  "skills/gsd-frontend-design/references/implementation-review-checklist.md" \
  "project instructions.*AGENTS.md.*PRODUCT.md.*DESIGN.md" \
  "Implementation checklist covers instruction sources"
assert_file_contains \
  "skills/gsd-frontend-design/references/implementation-review-checklist.md" \
  "fresh browser context.*avoid reusing" \
  "Implementation checklist covers fresh browser isolation"
assert_file_contains \
  "skills/gsd-frontend-design/references/implementation-review-checklist.md" \
  "independently open.*recapture" \
  "Implementation checklist covers independent recapture"
assert_file_contains \
  "skills/gsd-frontend-design/references/implementation-review-checklist.md" \
  "ERR_CONNECTION_REFUSED.*REQUEST_CHANGES.*ESCALATE" \
  "Implementation checklist blocks approval on runtime blockage"

echo ""
echo "=== GSD frontend visual review policy test passed ==="
