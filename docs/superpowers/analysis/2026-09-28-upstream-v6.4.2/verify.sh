#!/usr/bin/env bash
# Complete deterministic inventory for the approved integration. Live model
# evaluations and real external harness sessions are recorded separately.
set -euo pipefail
root="$(git rev-parse --show-toplevel)"
cd "$root"
for tool in bash git node npm jq yq dot python3; do
  command -v "$tool" >/dev/null || { printf 'Missing prerequisite: %s\n' "$tool" >&2; exit 2; }
done
python3 -c 'import yaml, pytest' || { echo 'Python requires PyYAML and pytest' >&2; exit 2; }
plan=docs/superpowers/analysis/2026-09-28-upstream-v6.4.2/merge-plan.md
workspace="$(bash skills/subagent-driven-development/scripts/sdd-workspace "$plan")"
logs="$workspace/finishing-$(git rev-parse --short=12 HEAD)"
mkdir -p "$logs"
export GIT_CONFIG_COUNT=1 GIT_CONFIG_KEY_0=core.fsmonitor GIT_CONFIG_VALUE_0=false
failed=0
count=0
run() {
  local name=$1
  shift
  count=$((count + 1))
  if "$@" > "$logs/$name.log" 2>&1; then
    printf 'PASS %s\n' "$name"
  else
    local code=$?
    printf 'FAIL %s (exit %s)\n' "$name" "$code"
    tail -n 18 "$logs/$name.log"
    failed=$((failed + 1))
  fi
}
for name in worktree-path-policy timeout-portability lean-delivery-contracts review-depth-contracts sdd-workspace executing-plans-scripts sdd-custom-contracts custom-policy-contracts frontend-visual-review-policy gsd-review-policy-detail no-pencil-frontend-policy brainstorming-artifact-quality frontend-direction-resources frontend-packet; do
  run "$name" bash "tests/claude-code/test-$name.sh"
done
run behavior-score bash tests/codex/sdd-behavior/test-score-results.sh
run marketplace bash tests/codex/test-marketplace-manifest.sh
run package bash tests/codex/test-package-codex-plugin.sh
run sync bash tests/codex-plugin-sync/test-sync-to-codex-plugin.sh
run diagnosis bash tests/diagnosing-superpowers/test-skill-structure.sh
run devin bash tests/devin/test-devin-plugin.sh
run muse bash tests/muse/test-plugin-manifest.sh
run hermes python3 -m pytest -q tests/hermes
run version bash tests/version-bump/test-bump-version.sh
run graphs bash tests/writing-skills/test-render-graphs.sh
run hooks bash tests/hooks/test-session-start.sh
run pi node tests/pi/test-pi-extension.mjs
run kimi bash tests/kimi/run-tests.sh
run antigravity bash tests/antigravity/run-tests.sh
run opencode bash tests/opencode/run-tests.sh
run shell-lint bash tests/shell-lint/test-lint-shell.sh
run polluter bash tests/systematic-debugging/test-find-polluter.sh
run companion npm test --prefix tests/brainstorm-server
run port-isolation node tests/brainstorm-server/carry-forward-port-isolation.test.js
run whitespace git diff --check 410d0fc3516e6c67931fd9de5642f7f6363fc7a4 HEAD
printf '%s groups; %s failed; logs: %s\n' "$count" "$failed" "$logs"
[ "$failed" -eq 0 ]
