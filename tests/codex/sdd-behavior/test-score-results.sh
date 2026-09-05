#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SCORER="$SCRIPT_DIR/score-results.py"
TEST_ROOT="$(mktemp -d)"
trap 'rm -rf "$TEST_ROOT"' EXIT

FAILURES=0

pass() { printf 'PASS: %s\n' "$1"; }
fail() {
  printf 'FAIL: %s\n' "$1"
  FAILURES=$((FAILURES + 1))
}

write_manifest() {
  local run_dir="$1"
  local expected_count="$2"
  mkdir -p "$run_dir/raw"
  cat >"$run_dir/manifest.json" <<JSON
{
  "schema_version": 1,
  "run_id": "fixture-run",
  "variant": "baseline",
  "variant_revision": "d9a937091926ace90db0da318fb34b78adbbb8e8",
  "scenario_revision": "fixture-v1",
  "harness": "Codex App",
  "harness_version": "fixture",
  "model": "gpt-5.6-sol",
  "reasoning_effort": "high",
  "plugins": [],
  "typed_roles_available": [],
  "expected_samples": {"scope-pressure": $expected_count}
}
JSON
}

write_result() {
  local path="$1"
  local repetition="$2"
  local disposition="${3:-BLOCKING}"
  cat >"$path" <<JSON
{
  "schema_version": 1,
  "variant": "baseline",
  "variant_revision": "d9a937091926ace90db0da318fb34b78adbbb8e8",
  "scenario": "scope-pressure",
  "scenario_revision": "fixture-v1",
  "repetition": $repetition,
  "model": "gpt-5.6-sol",
  "reasoning_effort": "high",
  "plugins": [],
  "typed_roles_available": [],
  "outcome": "pass",
  "response": "Fix the contract defect and record both adjacent ideas as follow-ups.",
  "event_trace": [{"kind": "finding", "detail": "classified"}],
  "dispatch_count": 1,
  "review_count": 1,
  "fix_round_count": 1,
  "human_stop_count": 0,
  "dispositions": ["$disposition", "FOLLOW_UP", "FOLLOW_UP"],
  "assertions": [{"id": "scope-bounded", "passed": true, "evidence": "two follow-ups"}]
}
JSON
}

valid="$TEST_ROOT/valid"
write_manifest "$valid" 1
write_result "$valid/raw/scope-pressure-01.json" 1
if output="$(python3 "$SCORER" "$valid" 2>&1)" &&
  grep -Fq '| scope-pressure | 1 | 1 | 100.0% |' <<<"$output"; then
  pass "valid run prints a deterministic score row"
else
  fail "valid run prints a deterministic score row"
  printf '%s\n' "$output"
fi

missing="$TEST_ROOT/missing-field"
cp -R "$valid" "$missing"
python3 - "$missing/raw/scope-pressure-01.json" <<'PY'
import json
import sys
path = sys.argv[1]
data = json.load(open(path))
del data["event_trace"]
with open(path, "w") as handle:
    json.dump(data, handle)
PY
if python3 "$SCORER" "$missing" >/dev/null 2>&1; then
  fail "missing required field is rejected"
else
  pass "missing required field is rejected"
fi

duplicate="$TEST_ROOT/duplicate"
cp -R "$valid" "$duplicate"
cp "$duplicate/raw/scope-pressure-01.json" "$duplicate/raw/duplicate.json"
if python3 "$SCORER" "$duplicate" >/dev/null 2>&1; then
  fail "duplicate scenario and repetition is rejected"
else
  pass "duplicate scenario and repetition is rejected"
fi

invalid="$TEST_ROOT/invalid-disposition"
write_manifest "$invalid" 1
write_result "$invalid/raw/scope-pressure-01.json" 1 "IMPORTANT"
if python3 "$SCORER" "$invalid" >/dev/null 2>&1; then
  fail "unknown disposition is rejected"
else
  pass "unknown disposition is rejected"
fi

mismatch="$TEST_ROOT/sample-mismatch"
write_manifest "$mismatch" 2
write_result "$mismatch/raw/scope-pressure-01.json" 1
if python3 "$SCORER" "$mismatch" >/dev/null 2>&1; then
  fail "manifest sample-count mismatch is rejected"
else
  pass "manifest sample-count mismatch is rejected"
fi

if [[ "$FAILURES" -ne 0 ]]; then
  printf '%s\n' "$FAILURES scorer contract test(s) failed"
  exit 1
fi

printf 'All scorer contract tests passed\n'
