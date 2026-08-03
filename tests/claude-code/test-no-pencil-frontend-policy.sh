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

assert_file_occurrences() {
  local rel="$1"
  local pattern="$2"
  local minimum="$3"
  local label="$4"
  local count
  count="$(grep -iocE "$pattern" "$ROOT_DIR/$rel" || true)"
  if [ "$count" -lt "$minimum" ]; then
    fail "Expected $rel to contain pattern at least $minimum times (found $count): $pattern"
  fi
  pass "$label"
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

scan_gsd_centric_ui_refinery_contracts() {
  local matches
  local paragraphs
  local status
  local unconditional_matches
  if [ "$#" -eq 0 ]; then
    set -- \
      "$ROOT_DIR/.github/agents/ui-browser-verifier.agent.md" \
      "$ROOT_DIR/.github/agents/ui-packet-guardian.agent.md" \
      "$ROOT_DIR/.github/agents/ui-refinery.agent.md" \
      "$ROOT_DIR/.github/agents/ui-robustness-refiner.agent.md" \
      "$ROOT_DIR/.github/agents/ui-ux-critic.agent.md" \
      "$ROOT_DIR/.github/agents/ui-visual-refiner.agent.md" \
      "$ROOT_DIR/.github/prompts/refine-ui-pass.prompt.md" \
      "$ROOT_DIR/.github/copilot-ui-refinery-guide.md"
  fi

  if paragraphs="$(awk '
      BEGIN { RS = ""; ORS = "\n" }
      {
        paragraph = $0
        gsub(/\n/, " ", paragraph)
        print FILENAME ":" FNR ":" paragraph
      }
    ' "$@" 2>&1)"; then
    :
  else
    status=$?
    printf '%s\n' "$paragraphs" >&2
    return "$status"
  fi

  if matches="$(printf '%s\n' "$paragraphs" | rg -n -i 'approved spec (and|plus) (approved )?GSD handoff|spec and handoff|spec/handoff|spec-and-handoff|(^|[[:space:]])[0-9]+[.] approved GSD handoff($|[[:space:]])|(^|[[:space:]])-[[:space:]]+approved GSD handoff($|[[:space:]])' 2>&1)"; then
    status=0
  else
    status=$?
  fi

  case "$status" in
    0)
      unconditional_matches="$(printf '%s\n' "$matches" | awk '
        {
          line = tolower($0)
          if (line ~ /(confirmed|selected)( delivery)? route (is )?gsd/ ||
              line ~ /(confirmed|selected) gsd route/ ||
              line ~ /gsd (is )?the (confirmed|selected)( delivery)? route/ ||
              line ~ /gsd route (is )?(confirmed|selected)/) {
            next
          }
          print
        }
      ')"
      if [ -n "$unconditional_matches" ]; then
        printf '%s\n' "$unconditional_matches"
        return 0
      fi
      return 1
      ;;
    1)
      return 1
      ;;
    *)
      printf '%s\n' "$matches" >&2
      return "$status"
      ;;
  esac
}

assert_no_gsd_centric_ui_refinery_contracts() {
  local output
  set +e
  output="$(scan_gsd_centric_ui_refinery_contracts 2>&1)"
  local status=$?
  set -e

  case "$status" in
    0)
      echo "  Remaining unconditional GSD-centric UI refinery contracts:"
      echo "$output" | sed "s#${ROOT_DIR}/##" | sed 's/^/    /'
      fail "Active UI refinery guidance must accept route-neutral planning context"
      ;;
    1)
      ;;
    *)
      echo "  UI refinery contract scan failed with ripgrep status $status:"
      echo "$output" | sed "s#${ROOT_DIR}/##" | sed 's/^/    /'
      fail "Unable to scan active UI refinery guidance"
      ;;
  esac
  pass "Active UI refinery guidance accepts route-neutral planning context"
}

assert_gsd_refinery_scan_errors_fail() {
  local output
  local status
  set +e
  output="$(
    scan_gsd_centric_ui_refinery_contracts() {
      echo "synthetic ripgrep failure" >&2
      return 2
    }
    assert_no_gsd_centric_ui_refinery_contracts
  )"
  status=$?
  set -e

  if [ "$status" -eq 0 ]; then
    fail "UI refinery scan must not treat ripgrep status 2 as no matches"
  fi
  if ! printf '%s\n' "$output" | grep -q "synthetic ripgrep failure"; then
    fail "UI refinery scan failure must preserve ripgrep diagnostics"
  fi
  pass "UI refinery scan fails with diagnostics on ripgrep errors"
}

assert_gsd_refinery_scan_is_route_aware() {
  local output
  local status
  set +e
  output="$(printf '%s\n' 'When the confirmed delivery route is GSD, use the approved spec plus GSD handoff.' | scan_gsd_centric_ui_refinery_contracts /dev/stdin 2>&1)"
  status=$?
  set -e
  if [ "$status" -ne 1 ]; then
    fail "UI refinery scan must allow an explicitly confirmed GSD route: $output"
  fi

  set +e
  output="$(printf '%s\n' 'Use the approved spec plus GSD handoff.' | scan_gsd_centric_ui_refinery_contracts /dev/stdin 2>&1)"
  status=$?
  set -e
  if [ "$status" -ne 0 ]; then
    fail "UI refinery scan must catch the same phrase when it is unconditional: $output"
  fi

  set +e
  output="$(printf '%s\n' 'When the confirmed delivery route is GSD,' 'use the approved spec plus GSD handoff.' | scan_gsd_centric_ui_refinery_contracts /dev/stdin 2>&1)"
  status=$?
  set -e
  if [ "$status" -ne 1 ]; then
    fail "UI refinery scan must allow confirmed GSD context across adjacent lines: $output"
  fi
  pass "UI refinery scan classifies the same GSD input by explicit route context"
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
assert_gsd_refinery_scan_errors_fail
assert_gsd_refinery_scan_is_route_aware
assert_no_gsd_centric_ui_refinery_contracts

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

assert_file_contains \
  "skills/frontend-direction/SKILL.md" \
  "approved neutral spec" \
  "Frontend direction consumes the approved neutral spec"
assert_file_contains \
  "skills/frontend-direction/SKILL.md" \
  "follow-on context" \
  "Frontend direction consumes neutral follow-on context"
assert_file_contains \
  "skills/frontend-direction/SKILL.md" \
  "packet.*approved.*delivery-routing\\.md|delivery-routing\\.md.*packet.*approved" \
  "Frontend direction finishes packet approval before delivery routing"
assert_file_contains \
  "skills/frontend-direction/references/frontend-packet-completeness-checklist.md" \
  "GSD handoff.*only.*GSD route|only.*GSD route.*GSD handoff" \
  "Frontend packet makes the GSD handoff route-conditional"
assert_file_contains \
  "skills/frontend-direction/references/design-source-priority.md" \
  "Approved neutral spec" \
  "Frontend source priority starts from neutral product direction"
assert_file_contains \
  "docs/superpowers/references/frontend-skill-stack-reference.md" \
  "approved neutral spec" \
  "Frontend stack reference documents the neutral source contract"
assert_file_contains \
  "docs/superpowers/references/brownfield-frontend-contract-workflow.md" \
  "packet.*approved.*route|route.*packet.*approved" \
  "Brownfield workflow routes only after packet approval"
assert_file_contains \
  "skills/brainstorming/references/track-selection.md" \
  "frontend-direction.*packet.*approved.*delivery routing|delivery routing.*frontend-direction.*packet.*approved" \
  "Track selection finishes frontend direction before delivery routing"
assert_file_not_contains \
  "skills/brainstorming/references/track-selection.md" \
  "spec and GSD handoff are approved|^[[:space:]]*- GSD handoff[[:space:]]*$" \
  "Track selection does not require an unconditional GSD handoff"
assert_file_contains \
  "skills/brainstorming/agents/openai.yaml" \
  "approved neutral spec.*delivery route confirmation|delivery route confirmation.*approved neutral spec" \
  "Brainstorming metadata advertises neutral output and confirmed routing"
assert_file_not_contains \
  "skills/brainstorming/agents/openai.yaml" \
  "GSD handoff|GSD/Codex-ready handoff" \
  "Brainstorming metadata does not promise a GSD handoff"
assert_file_contains \
  "skills/frontend-direction/agents/openai.yaml" \
  "approved neutral spec.*route-neutral.*follow-on" \
  "Frontend metadata advertises neutral shaping inputs"
assert_file_contains \
  "skills/frontend-direction/agents/openai.yaml" \
  "packet.*approv.*delivery routing|delivery routing.*packet.*approv" \
  "Frontend metadata preserves the packet-before-routing gate"
assert_file_not_contains \
  "skills/frontend-direction/agents/openai.yaml" \
  "GSD handoff|approved specs and handoffs" \
  "Frontend metadata does not require a GSD handoff"
assert_file_contains \
  ".github/agents/ui-refinery.agent.md" \
  "approved spec.*selected-route planning context|selected-route planning context.*approved spec" \
  "UI refinery agent keeps the route-neutral spec-backed contract"
assert_file_contains \
  ".github/agents/ui-packet-guardian.agent.md" \
  "planning context from the confirmed delivery route" \
  "UI packet guardian accepts confirmed-route planning context"
assert_file_contains \
  ".github/prompts/refine-ui-pass.prompt.md" \
  "approved spec.*selected-route planning context" \
  "UI refinement prompt advertises route-neutral planning context"
assert_file_occurrences \
  "skills/frontend-direction/references/use-cases-prompts-and-flows.md" \
  "approved neutral spec.*approved route-neutral follow-on context" \
  5 \
  "Every frontend use case requires both approved neutral shaping inputs"
assert_file_occurrences \
  "skills/frontend-direction/references/use-cases-prompts-and-flows.md" \
  "approve the packet, confirm one delivery route, then implement through the selected lane" \
  5 \
  "Every frontend use case routes between packet approval and implementation"
assert_file_contains \
  "skills/frontend-direction/references/frontend-direction-template.md" \
  "Packet status: not-required.*required-pending.*approved.*approved-with-degraded-evidence" \
  "Frontend packet uses the shared packet-status vocabulary"
assert_file_contains \
  "skills/frontend-direction/references/frontend-direction-phase.md" \
  "required-pending.*approved-with-degraded-evidence" \
  "Frontend phase defines pending and approved degraded status semantics"
assert_file_contains \
  "skills/frontend-direction/references/frontend-direction-template.md" \
  "explicit approval.*every.*degraded constraint|every.*degraded constraint.*explicit.*approv" \
  "Every degraded constraint requires explicit approval"
assert_file_contains \
  "skills/frontend-direction/references/frontend-direction-template.md" \
  "degraded evidence alone.*never authorizes routing|degraded evidence.*by itself.*not.*authorize routing" \
  "Degraded evidence alone cannot authorize routing"
assert_file_not_contains \
  "skills/frontend-direction/references/frontend-direction-template.md" \
  "Packet status: approved.*pending.*degraded" \
  "Frontend packet removes the legacy status vocabulary"

echo ""
echo "=== No Pencil frontend policy test passed ==="
