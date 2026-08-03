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

assert_file_contains_in_order() {
  local rel="$1"
  local label="$2"
  shift 2

  local previous_line=0
  local pattern
  local line
  for pattern in "$@"; do
    line="$(grep -niE "$pattern" "$ROOT_DIR/$rel" | awk -F: -v previous="$previous_line" '$1 > previous { print $1; exit }' || true)"
    if [ -z "$line" ]; then
      fail "Expected $rel to contain ordered pattern after line $previous_line: $pattern"
    fi
    previous_line="$line"
  done

  pass "$label"
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
  "skills/brainstorming/references/spec-template.md" \
  "## Delivery Route" \
  "Spec template provides the confirmed delivery route section"
assert_file_contains \
  "skills/brainstorming/references/spec-template.md" \
  "Recommendation:.*fit" \
  "Delivery Route records best-fit recommendation evidence"
assert_file_contains \
  "skills/brainstorming/references/spec-template.md" \
  "Delivery review:.*pending.*approved" \
  "Delivery Route records selected-adapter review evidence"
assert_file_contains \
  "skills/brainstorming/references/spec-template.md" \
  "only after.*confirm" \
  "Spec template keeps routing out until confirmation"

assert_file_contains \
  "skills/brainstorming/references/delivery-routing.md" \
  "GSD.*multiple milestones|Superpowers.*bounded feature|Native Codex.*contained slice" \
  "Delivery router recommends by delivery fit"
assert_file_contains \
  "skills/brainstorming/references/delivery-routing.md" \
  "warn once" \
  "Delivery router warns once on explicit mismatch"
assert_file_contains \
  "skills/brainstorming/references/delivery-routing.md" \
  "unavailable.*remove|remove.*unavailable" \
  "Delivery router removes unavailable routes"
assert_file_contains \
  "skills/brainstorming/references/delivery-routing.md" \
  "reconciliation" \
  "Delivery router stops late rerouting for reconciliation"

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
assert_file_contains \
  "skills/brainstorming/SKILL.md" \
  "approved.*neutral spec" \
  "Brainstorming defaults to an approved neutral spec"
assert_file_contains \
  "skills/brainstorming/SKILL.md" \
  "references/delivery-routing\.md" \
  "Brainstorming loads the central delivery router"
assert_file_contains \
  "skills/brainstorming/SKILL.md" \
  "GSD handoff.*only|only.*GSD.*handoff" \
  "Brainstorming makes the GSD handoff route-specific"
assert_file_contains \
  "skills/brainstorming/SKILL.md" \
  "Native Codex.*inline proposed plan" \
  "Brainstorming defines the Native Codex terminal output"
assert_file_contains \
  "skills/brainstorming/SKILL.md" \
  "plan mode.*read-only authoring" \
  "Brainstorming keeps Codex plan mode authoring-only"
assert_file_contains \
  "skills/brainstorming/SKILL.md" \
  "not execute implementation.*plan mode|plan mode.*not execute implementation" \
  "Brainstorming prohibits implementation in plan mode"
assert_file_contains_in_order \
  "skills/brainstorming/SKILL.md" \
  "Brainstorming enforces neutral review through transition in canonical order" \
  "neutral artifact review" \
  "user approval gate" \
  "frontend packet approval" \
  "confirm the delivery route" \
  "create the selected adapter" \
  "review the selected adapter" \
  "transition through the confirmed route"
assert_file_contains \
  "skills/brainstorming/SKILL.md" \
  "selected-adapter review.*Delivery Route|Delivery Route.*selected-adapter review" \
  "Selected-adapter review validates Delivery Route metadata"
assert_file_contains \
  "skills/brainstorming/SKILL.md" \
  "selected-adapter review.*exactly one adapter|exactly one adapter.*selected-adapter review" \
  "Selected-adapter review validates adapter cardinality"
assert_file_contains \
  "skills/brainstorming/SKILL.md" \
  "selected-adapter review.*unselected|unselected.*selected-adapter review" \
  "Selected-adapter review rejects unselected adapters"
assert_file_contains \
  "skills/brainstorming/SKILL.md" \
  "selected-adapter review.*route-specific completeness|route-specific completeness.*selected-adapter review" \
  "Selected-adapter review validates route-specific completeness"
assert_file_contains \
  "skills/brainstorming/SKILL.md" \
  "Do not self-review" \
  "Selected-adapter review requires an independent reviewer dispatch"
assert_file_contains \
  "skills/brainstorming/SKILL.md" \
  "review.*reference.*Delivery Route|Delivery Route.*review.*reference" \
  "Selected-adapter approval is recorded before transition"
assert_file_not_contains \
  "skills/brainstorming/SKILL.md" \
  "packet status:[[:space:]]*required([\`.,;:]|[[:space:]]|$)" \
  "Brainstorming removes the legacy pending packet status"
assert_file_contains \
  "skills/brainstorming/SKILL.md" \
  "packet status:[[:space:]]*required-pending" \
  "Brainstorming records pending frontend work with shared status vocabulary"

assert_file_not_contains \
  "skills/brainstorming/references/spec-template.md" \
  "Pencil|\\.pen\\b|workset|adapter" \
  "Spec template stays free of removed workflow terms"
assert_file_not_contains \
  "skills/brainstorming/references/gsd-handoff-template.md" \
  "Pencil|\\.pen\\b|workset|adapter" \
  "GSD handoff template stays free of removed workflow terms"
assert_file_contains \
  "skills/brainstorming/references/gsd-handoff-template.md" \
  "not-required.*required-pending.*approved.*approved-with-degraded-evidence" \
  "GSD handoff template uses the shared packet-status vocabulary"
assert_file_not_contains \
  "skills/brainstorming/references/gsd-handoff-template.md" \
  "none[[:space:]]*\\|[[:space:]]*required[[:space:]]*\\|[[:space:]]*attached|packet status is [\`]required[\`]|packet status is required([.,;:]|[[:space:]]|$)|run .*frontend-direction.*then return to GSD" \
  "GSD handoff cannot send pending frontend work back from GSD"
assert_file_contains \
  "skills/brainstorming/references/gsd-handoff-template.md" \
  "generated only after.*approved|approved.*before.*generated" \
  "GSD handoff is generated only after frontend packet approval"
assert_file_contains \
  "skills/brainstorming/references/gsd-handoff-template.md" \
  "approved-with-degraded-evidence" \
  "GSD handoff permits explicitly approved degraded evidence"

assert_file_not_contains \
  "skills/brainstorming/references/track-selection.md" \
  "explicit GSD milestone recommendation" \
  "Architecture-led neutral artifacts do not mandate a GSD milestone"
assert_file_contains \
  "skills/brainstorming/references/track-selection.md" \
  "delivery boundar(y|ies)|delivery slice" \
  "Architecture-led work recommends workflow-neutral delivery boundaries"

assert_file_contains \
  "skills/brainstorming/references/frontend-direction-follow-on-prompt-template.md" \
  "approved neutral spec" \
  "Frontend follow-on prompt consumes the approved neutral spec"
assert_file_contains \
  "skills/brainstorming/references/frontend-direction-follow-on-prompt-template.md" \
  "do not.*route.*until.*packet.*approved|packet.*approved.*before.*routing" \
  "Frontend follow-on prompt blocks premature routing"
assert_file_contains \
  "skills/brainstorming/references/spec-review-checklist.md" \
  "selected route.*adapter|adapter.*selected route" \
  "Spec review validates only the selected route adapter"
assert_file_contains \
  "skills/brainstorming/references/spec-review-checklist.md" \
  "unselected adapter|unselected route.*artifact" \
  "Spec review rejects unselected route artifacts"
assert_file_contains \
  "skills/brainstorming/references/spec-review-checklist.md" \
  "Before route confirmation.*Delivery Route.*absent|Delivery Route.*absent.*before route confirmation" \
  "Neutral review rejects premature route metadata"
assert_file_contains \
  "skills/brainstorming/references/test-scenarios.md" \
  "Delivery Route.*before.*confirm|before.*confirm.*Delivery Route" \
  "Pressure scenarios cover premature route metadata"
assert_file_contains \
  "skills/brainstorming/references/test-scenarios.md" \
  "self-review|independent reviewer.*reference|reviewer reference" \
  "Pressure scenarios cover unverifiable delivery approval"
assert_file_contains \
  "skills/brainstorming/spec-document-reviewer-prompt.md" \
  "premature routing|route.*before.*packet.*approved" \
  "Spec reviewer rejects routing before frontend packet approval"
assert_file_contains \
  "skills/brainstorming/spec-document-reviewer-prompt.md" \
  "selected route.*adapter|adapter.*selected route" \
  "Spec reviewer conditionally validates the selected adapter"

echo ""
echo "=== Brainstorming artifact quality gates test passed ==="
