#!/usr/bin/env bash
# Test: ChatGPT Images upload pack detail
# Verifies image prompt-pack guidance keeps the implementation-critical structure.
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
    echo "  Matching lines:"
    grep -niE "$pattern" "$ROOT_DIR/$rel" | sed 's/^/    /'
    fail "$label"
  fi
  pass "$label"
}

SKILL="skills/creating-chatgpt-image-upload-packs/SKILL.md"
STRUCTURE="skills/creating-chatgpt-image-upload-packs/references/prompt-pack-structure.md"

echo "=== Test: ChatGPT Images prompt-pack detail ==="
echo ""

assert_file_contains "$SKILL" "Screen Family Reuse Contract" "Skill preserves screen-family reuse contract"
assert_file_contains "$SKILL" "child ID-to-state-name map|child state map" "Skill requires child state mapping"
assert_file_contains "$SKILL" "State Changes Only" "Skill requires child state-only prompts"
assert_file_contains "$SKILL" "State Semantics" "Skill requires state semantics"
assert_file_contains "$SKILL" "permission.*visible data.*hidden.*disabled.*read-only|visible data.*hidden actions.*disabled actions.*read-only" "Skill preserves permission affordance rules"
assert_file_contains "$SKILL" "rollout.*backfill.*partial failure.*completed reconciliation|setup rollout.*running.*partial failure.*completed reconciliation" "Skill preserves rollout/backfill/failure distinctions"
assert_file_contains "$SKILL" "writing-ux-copy" "Skill requires UX copy review"
assert_file_contains "$SKILL" "reference-only.*visual-truth.*semantic-guidance" "Skill preserves approval intent modes"
assert_file_contains "$SKILL" "Quality Gate" "Skill has quality gate"

assert_file_contains "$STRUCTURE" "screen-family map" "Structure requires screen-family map"
assert_file_contains "$STRUCTURE" "Parent Screen Prompt Files" "Structure details parent prompt files"
assert_file_contains "$STRUCTURE" "Child State Prompt Files" "Structure details child prompt files"
assert_file_contains "$STRUCTURE" "Parent prompt" "Structure attachment map tracks parent prompt"
assert_file_contains "$STRUCTURE" "Required screenshots" "Structure attachment map tracks screenshots"
assert_file_contains "$STRUCTURE" "Visible Text Quality" "Structure keeps visible text quality section"
assert_file_contains "$STRUCTURE" "generated images.*reference-only" "Structure keeps generated-image approval status"

assert_file_not_contains "$SKILL" "pencil|\\.pen\\b|workset|adapter" "Skill stays free of removed workflow terms"
assert_file_not_contains "$STRUCTURE" "pencil|\\.pen\\b|workset|adapter" "Structure stays free of removed workflow terms"

echo ""
echo "=== ChatGPT Images prompt-pack detail test passed ==="
