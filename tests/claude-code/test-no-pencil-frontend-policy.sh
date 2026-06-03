#!/usr/bin/env bash
# Test: Pencil removal and compact frontend policy
# Verifies active Superpowers guidance no longer depends on Pencil artifacts.
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/../.." && pwd)"

fail() {
  echo "  [FAIL] $1"
  exit 1
}

pass() {
  echo "  [PASS] $1"
}

assert_absent_path() {
  local rel="$1"
  if [ -e "$ROOT_DIR/$rel" ]; then
    fail "Expected removed path to be absent: $rel"
  fi
  pass "Removed path absent: $rel"
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

assert_no_active_pencil_terms() {
  local output
  set +e
  output="$(rg -n -i 'pencil|pencil-workset|workset|design/pencil|\.pen\b|Pencil MCP|Pencil CLI|board-intent|boards? / frames' \
    "$ROOT_DIR/skills" \
    "$ROOT_DIR/docs/gsd" \
    "$ROOT_DIR/docs/superpowers/references" \
    "$ROOT_DIR/.github/agents" \
    "$ROOT_DIR/.github/prompts" \
    "$ROOT_DIR/.github/copilot-ui-refinery-guide.md" 2>/dev/null)"
  local status=$?
  set -e

  if [ "$status" -eq 0 ]; then
    echo "  Remaining active Pencil references:"
    echo "$output" | sed "s#${ROOT_DIR}/##" | sed 's/^/    /'
    fail "Active frontend guidance must not mention Pencil or .pen artifacts"
  fi
  pass "Active frontend guidance has no Pencil/.pen references"
}

echo "=== Test: no Pencil frontend policy ==="
echo ""

assert_absent_path "skills/pencil-design-core"
assert_absent_path "skills/pencil-design-angular-nebular"
assert_absent_path "skills/pencil-design-react-tailwind"
assert_absent_path "skills/pencil-design-flutter-material"
assert_absent_path "docs/pencil"
assert_absent_path "skills/frontend-direction/references/pencil-workset-template.md"
assert_absent_path "skills/frontend-direction/references/pencil-skill-selection.md"
assert_absent_path "skills/gsd-frontend-design/references/pencil-source-consumption.md"
assert_absent_path "skills/gsd-frontend-design/references/pencil-skills-integration.md"
assert_absent_path "skills/brainstorming/references/pencil-skill-selection.md"
assert_absent_path "skills/brainstorming/README.md"
assert_absent_path "skills/frontend-direction/README.md"
assert_absent_path "skills/gsd-frontend-design/README.md"

assert_no_active_pencil_terms

assert_file_contains \
  "skills/frontend-direction/references/frontend-direction-template.md" \
  "## 1\\. Summary|## Summary" \
  "Frontend packet keeps a compact summary section"
assert_file_contains \
  "skills/frontend-direction/references/frontend-direction-template.md" \
  "Source Evidence" \
  "Frontend packet keeps source evidence section"
assert_file_contains \
  "skills/frontend-direction/references/frontend-direction-template.md" \
  "Screens And States" \
  "Frontend packet keeps screens and states section"
assert_file_contains \
  "skills/frontend-direction/references/frontend-direction-template.md" \
  "Visual References" \
  "Frontend packet keeps visual references section"
assert_file_contains \
  "skills/frontend-direction/references/frontend-direction-template.md" \
  "Implementation Contract" \
  "Frontend packet keeps implementation contract section"
assert_file_contains \
  "skills/frontend-direction/references/frontend-direction-template.md" \
  "Verification" \
  "Frontend packet keeps verification section"
assert_file_contains \
  "skills/frontend-direction/references/frontend-direction-template.md" \
  "Open Questions" \
  "Frontend packet keeps open questions section"
assert_file_contains \
  "skills/frontend-direction/references/frontend-direction-template.md" \
  "Must preserve" \
  "Frontend packet keeps must-preserve gate"
assert_file_contains \
  "skills/frontend-direction/references/frontend-direction-template.md" \
  "May adapt" \
  "Frontend packet keeps may-adapt gate"
assert_file_contains \
  "skills/frontend-direction/references/frontend-direction-template.md" \
  "Explicit no-gos" \
  "Frontend packet keeps no-go gate"
assert_file_contains \
  "skills/frontend-direction/references/frontend-direction-template.md" \
  "UX copy source" \
  "Frontend packet keeps UX copy source gate"
assert_file_contains \
  "skills/frontend-direction/references/frontend-direction-template.md" \
  "Reference intent" \
  "Frontend packet keeps reference-intent gate"
assert_file_contains \
  "skills/frontend-direction/references/frontend-direction-template.md" \
  "visual-truth" \
  "Frontend packet keeps visual-truth mode"
assert_file_contains \
  "skills/frontend-direction/references/frontend-direction-template.md" \
  "semantic-guidance" \
  "Frontend packet keeps semantic-guidance mode"
assert_file_contains \
  "skills/frontend-direction/references/frontend-direction-template.md" \
  "reference-only" \
  "Frontend packet keeps reference-only mode"
assert_file_not_contains \
  "skills/frontend-direction/references/frontend-direction-template.md" \
  "Appendix [A-Z]|Downstream Skill Plan|Flutter / Mobile Implementation Notes|workset|\.pen|adapter" \
  "Frontend packet template avoids verbose appendix and stack boilerplate"
assert_file_not_contains \
  "skills/frontend-direction/references/screen-index-template.md" \
  "Pencil file|Board / frame|Downstream adapter|workset|\.pen" \
  "Screen index avoids Pencil-era columns"

echo ""
echo "=== No Pencil frontend policy test passed ==="
