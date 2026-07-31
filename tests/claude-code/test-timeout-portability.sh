#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/test-helpers.sh"

output="$(run_with_timeout 2 bash -c 'printf portable')"
[[ "$output" == "portable" ]] || {
  echo "FAIL: portable timeout changed successful command output"
  exit 1
}

status=0
run_with_timeout 1 bash -c 'sleep 5' >/dev/null 2>&1 || status=$?
[[ "$status" -eq 124 ]] || {
  echo "FAIL: expected timeout exit 124, got $status"
  exit 1
}

echo 'PASS: Claude skill tests have a portable timeout wrapper'
