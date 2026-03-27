#!/usr/bin/env bash
# Lifecycle compatibility checks for the brainstorm server.
#
# Verifies the supported operational contract through start-server.sh / stop-server.sh:
# - startup JSON and state/server-info metadata stay aligned
# - served HTML still receives the helper and fragment shell for fragment screens
# - the newest .html screen wins
# - state/events is cleared when a genuinely newer screen arrives
#
# Usage:
#   bash tests/brainstorm-server/windows-lifecycle.test.sh

set -u -o pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="${SUPERPOWERS_ROOT:-$(cd "$SCRIPT_DIR/../.." && pwd)}"
START_SCRIPT="$REPO_ROOT/skills/brainstorming/scripts/start-server.sh"
STOP_SCRIPT="$REPO_ROOT/skills/brainstorming/scripts/stop-server.sh"
TEST_ROOT="$(mktemp -d "${TMPDIR:-/tmp}/brainstorm-lifecycle.XXXXXX")"
PROJECT_DIR="$TEST_ROOT/project"
ARTIFACT_DIR="$TEST_ROOT/artifacts"
START_STDOUT="$ARTIFACT_DIR/start-server.stdout"
START_STDERR="$ARTIFACT_DIR/start-server.stderr"
STOP_STDOUT="$ARTIFACT_DIR/stop-server.stdout"
STOP_STDERR="$ARTIFACT_DIR/stop-server.stderr"
WAITING_HTML="$ARTIFACT_DIR/waiting.html"
OLDER_HTML="$ARTIFACT_DIR/older-served.html"
NEWER_HTML="$ARTIFACT_DIR/newer-served.html"

passed=0
failed=0
session_dir=""
state_dir=""
screen_dir=""
server_url=""
server_pid=""
startup_json_file="$ARTIFACT_DIR/startup.json"
server_info_file=""
server_log_file=""

mkdir -p "$ARTIFACT_DIR"

pass() {
  echo "  PASS: $1"
  passed=$((passed + 1))
}

fail() {
  echo "  FAIL: $1"
  echo "    $2"
  failed=$((failed + 1))
}

json_field() {
  node - "$1" "$2" <<'NODE'
const fs = require('fs');
const [file, field] = process.argv.slice(2);
const raw = fs.readFileSync(file, 'utf8').trim();
const value = JSON.parse(raw)[field];
process.stdout.write(value == null ? '' : String(value));
NODE
}

fetch_to_file() {
  node - "$1" "$2" <<'NODE'
const http = require('http');
const fs = require('fs');
const [url, outFile] = process.argv.slice(2);
http.get(url, (res) => {
  let body = '';
  res.setEncoding('utf8');
  res.on('data', chunk => { body += chunk; });
  res.on('end', () => {
    fs.writeFileSync(outFile, body);
    if (res.statusCode !== 200) {
      console.error(`Unexpected status ${res.statusCode}`);
      process.exit(1);
      return;
    }
    process.exit(0);
  });
}).on('error', (error) => {
  console.error(error.message);
  process.exit(1);
});
NODE
}

send_choice_event() {
  node - "$1" "$2" "$3" <<'NODE'
const [baseUrl, choice, text] = process.argv.slice(2);
const url = new URL(baseUrl);
url.protocol = url.protocol === 'https:' ? 'wss:' : 'ws:';
url.pathname = '/';

const ws = new WebSocket(url.toString());
const timeout = setTimeout(() => {
  console.error('WebSocket event send timed out');
  process.exit(1);
}, 4000);

ws.addEventListener('open', () => {
  ws.send(JSON.stringify({ type: 'click', choice, text }));
  setTimeout(() => {
    clearTimeout(timeout);
    ws.close();
    process.exit(0);
  }, 150);
});

ws.addEventListener('error', (event) => {
  clearTimeout(timeout);
  console.error(event?.message || 'WebSocket error');
  process.exit(1);
});
NODE
}

write_html_with_mtime() {
  node - "$1" "$2" "$3" <<'NODE'
const fs = require('fs');
const [file, html, offsetMs] = process.argv.slice(2);
fs.writeFileSync(file, html);
const ts = new Date(Date.now() + Number(offsetMs));
fs.utimesSync(file, ts, ts);
NODE
}

wait_for_path_state() {
  local path="$1"
  local expected="$2"
  local timeout_ms="$3"
  local start_ms
  start_ms=$(node -e 'process.stdout.write(String(Date.now()))')

  while true; do
    if [[ "$expected" == "present" && -e "$path" ]]; then
      return 0
    fi
    if [[ "$expected" == "absent" && ! -e "$path" ]]; then
      return 0
    fi

    local now_ms
    now_ms=$(node -e 'process.stdout.write(String(Date.now()))')
    if (( now_ms - start_ms >= timeout_ms )); then
      return 1
    fi
    sleep 0.1
  done
}

wait_for_html_text() {
  local url="$1"
  local text="$2"
  local out_file="$3"
  local timeout_ms="$4"
  local start_ms
  start_ms=$(node -e 'process.stdout.write(String(Date.now()))')

  while true; do
    if fetch_to_file "$url" "$out_file" && grep -Fq "$text" "$out_file"; then
      return 0
    fi

    local now_ms
    now_ms=$(node -e 'process.stdout.write(String(Date.now()))')
    if (( now_ms - start_ms >= timeout_ms )); then
      return 1
    fi
    sleep 0.1
  done
}

wait_for_file_text() {
  local file="$1"
  local text="$2"
  local timeout_ms="$3"
  local start_ms
  start_ms=$(node -e 'process.stdout.write(String(Date.now()))')

  while true; do
    if [[ -f "$file" ]] && grep -Fq "$text" "$file"; then
      return 0
    fi

    local now_ms
    now_ms=$(node -e 'process.stdout.write(String(Date.now()))')
    if (( now_ms - start_ms >= timeout_ms )); then
      return 1
    fi
    sleep 0.1
  done
}

print_diagnostics() {
  echo ""
  echo "Diagnostics preserved at: $TEST_ROOT"
  if [[ -n "$session_dir" ]]; then
    echo "  Session dir: $session_dir"
  fi
  if [[ -n "$server_info_file" ]]; then
    echo "  state/server-info: $server_info_file"
  fi
  if [[ -n "$server_log_file" ]]; then
    echo "  state/server.log: $server_log_file"
  fi
  if [[ -f "$NEWER_HTML" ]]; then
    echo "  Latest served HTML snapshot: $NEWER_HTML"
  elif [[ -f "$OLDER_HTML" ]]; then
    echo "  Latest served HTML snapshot: $OLDER_HTML"
  elif [[ -f "$WAITING_HTML" ]]; then
    echo "  Latest served HTML snapshot: $WAITING_HTML"
  fi
}

cleanup() {
  if [[ -n "$session_dir" && -f "$state_dir/server.pid" ]]; then
    server_pid="$(tr -d '[:space:]' < "$state_dir/server.pid")"
  fi

  if [[ $failed -eq 0 ]]; then
    if [[ -n "$session_dir" ]]; then
      bash "$STOP_SCRIPT" "$session_dir" > "$STOP_STDOUT" 2> "$STOP_STDERR" || true
    fi
    rm -rf "$TEST_ROOT"
  else
    if [[ -n "$server_pid" ]]; then
      kill "$server_pid" 2>/dev/null || true
      wait "$server_pid" 2>/dev/null || true
    fi
    print_diagnostics
    echo "  Stop manually after inspection with: bash \"$STOP_SCRIPT\" \"$session_dir\""
  fi
}
trap cleanup EXIT

echo ""
echo "=== Brainstorm Server Lifecycle Compatibility ==="
echo "Repo: $REPO_ROOT"
echo "Temp workspace: $TEST_ROOT"
echo ""

echo "--- Startup metadata ---"
if bash "$START_SCRIPT" --project-dir "$PROJECT_DIR" --host 127.0.0.1 --url-host localhost --background > "$START_STDOUT" 2> "$START_STDERR"; then
  cp "$START_STDOUT" "$startup_json_file"
  pass "start-server.sh returns startup metadata"
else
  fail "start-server.sh returns startup metadata" "$(tr '\n' ' ' < "$START_STDERR") $(tr '\n' ' ' < "$START_STDOUT")"
fi

if [[ -f "$startup_json_file" ]]; then
  if node - "$startup_json_file" <<'NODE'
const fs = require('fs');
const file = process.argv[2];
const raw = fs.readFileSync(file, 'utf8').trim();
const data = JSON.parse(raw);
const required = ['type', 'port', 'host', 'url', 'screen_dir', 'state_dir'];
for (const field of required) {
  if (!(field in data) || data[field] === '') {
    throw new Error(`missing ${field}`);
  }
}
if (data.type !== 'server-started') throw new Error(`unexpected type ${data.type}`);
if (!String(data.url).startsWith('http://localhost:')) throw new Error(`unexpected url ${data.url}`);
NODE
  then
    pass "startup JSON exposes the current server-started contract"
  else
    fail "startup JSON exposes the current server-started contract" "$(tr '\n' ' ' < "$startup_json_file")"
  fi

  state_dir="$(json_field "$startup_json_file" state_dir)"
  screen_dir="$(json_field "$startup_json_file" screen_dir)"
  server_url="$(json_field "$startup_json_file" url)"
  session_dir="$(dirname "$state_dir")"
  server_info_file="$state_dir/server-info"
  server_log_file="$state_dir/server.log"
fi

if [[ -n "$server_info_file" && -f "$server_info_file" ]]; then
  if node - "$startup_json_file" "$server_info_file" <<'NODE'
const fs = require('fs');
const [startupFile, infoFile] = process.argv.slice(2);
const startup = JSON.parse(fs.readFileSync(startupFile, 'utf8').trim());
const info = JSON.parse(fs.readFileSync(infoFile, 'utf8').trim());
for (const field of ['type', 'port', 'host', 'url', 'screen_dir', 'state_dir']) {
  if (startup[field] !== info[field]) {
    throw new Error(`${field} drifted: ${startup[field]} !== ${info[field]}`);
  }
}
NODE
  then
    pass "state/server-info matches the startup JSON and current state path"
  else
    fail "state/server-info matches the startup JSON and current state path" "$(tr '\n' ' ' < "$server_info_file")"
  fi
else
  fail "state/server-info matches the startup JSON and current state path" "Missing $server_info_file"
fi

echo ""
echo "--- Helper-served HTML ---"
if [[ -n "$server_url" ]] && fetch_to_file "$server_url/" "$WAITING_HTML"; then
  if grep -Fq 'Waiting for the agent to push a screen' "$WAITING_HTML" \
    && grep -Fq 'toggleSelect' "$WAITING_HTML" \
    && grep -Fq 'window.brainstorm' "$WAITING_HTML"; then
    pass "waiting page serves helper-injected HTML"
  else
    fail "waiting page serves helper-injected HTML" "Expected waiting copy and helper API in $WAITING_HTML"
  fi
else
  fail "waiting page serves helper-injected HTML" "Could not fetch $server_url/"
fi

older_fragment=$(cat <<'HTML'
<h2>Lifecycle older screen</h2>
<p class="subtitle">Older screen used to prove helper injection, choice persistence, and newest-screen replacement.</p>
<div class="options">
  <div class="option" data-choice="older-choice" onclick="toggleSelect(this)">
    <div class="letter">A</div>
    <div class="content">
      <h3>Older lifecycle choice</h3>
      <p>This choice should write state/events before a newer screen clears it.</p>
    </div>
  </div>
</div>
HTML
)

newer_fragment=$(cat <<'HTML'
<h2>Lifecycle newer screen</h2>
<div class="section">
  <div class="label">Chosen direction</div>
  <p class="subtitle">A genuinely newer screen should become the served screen and clear prior transient events.</p>
</div>
<div class="section">
  <div class="label">Still open</div>
  <p class="subtitle">Lifecycle drift should not hide authored carry-forward copy.</p>
</div>
<div class="section">
  <div class="label">Degraded mode</div>
  <p class="subtitle">Diagnostics stay explicit even when a later screen replaces the earlier interactive fragment.</p>
</div>
HTML
)

write_html_with_mtime "$screen_dir/older-screen.html" "$older_fragment" -10000
if wait_for_file_text "$server_log_file" 'older-screen.html' 5000 && wait_for_html_text "$server_url/" 'Lifecycle older screen' "$OLDER_HTML" 5000; then
  if grep -Fq 'data-comparison-kit="fragment-shell"' "$OLDER_HTML" \
    && grep -Fq 'toggleSelect' "$OLDER_HTML" \
    && grep -Fq 'Older lifecycle choice' "$OLDER_HTML"; then
    pass "fragment screens are wrapped and helper-served through the current runtime"
  else
    fail "fragment screens are wrapped and helper-served through the current runtime" "Expected fragment shell marker, helper script, and older content in $OLDER_HTML"
  fi
else
  fail "fragment screens are wrapped and helper-served through the current runtime" "Did not observe Lifecycle older screen plus its screen-added log at $server_url/"
fi

echo ""
echo "--- Newest-screen selection and transient events ---"
events_file="$state_dir/events"
if send_choice_event "$server_url" 'older-choice' 'Older lifecycle choice'; then
  if wait_for_path_state "$events_file" present 5000 && grep -Fq 'older-choice' "$events_file"; then
    pass "choice interactions write state/events for the current screen"
  else
    fail "choice interactions write state/events for the current screen" "Expected $events_file to contain the older-choice event"
  fi
else
  fail "choice interactions write state/events for the current screen" "WebSocket choice submission failed for $server_url"
fi

write_html_with_mtime "$screen_dir/newer-screen.html" "$newer_fragment" 0
if wait_for_file_text "$server_log_file" 'newer-screen.html' 5000 && wait_for_html_text "$server_url/" 'Lifecycle newer screen' "$NEWER_HTML" 5000; then
  if grep -Fq 'Chosen direction' "$NEWER_HTML" \
    && grep -Fq 'Still open' "$NEWER_HTML" \
    && grep -Fq 'Degraded mode' "$NEWER_HTML" \
    && ! grep -Fq 'Lifecycle older screen' "$NEWER_HTML"; then
    pass "the newest .html screen wins and serves the newer authored content"
  else
    fail "the newest .html screen wins and serves the newer authored content" "Expected newer carry-forward copy without the older screen in $NEWER_HTML"
  fi
else
  fail "the newest .html screen wins and serves the newer authored content" "Did not observe Lifecycle newer screen plus its screen-added log at $server_url/"
fi

if wait_for_path_state "$events_file" absent 5000; then
  pass "state/events is cleared when a genuinely newer screen is added"
else
  fail "state/events is cleared when a genuinely newer screen is added" "Expected $events_file to be removed after newer-screen.html was added"
fi

if [[ -f "$server_log_file" ]] && grep -Fq 'screen-added' "$server_log_file" \
  && grep -Fq 'older-screen.html' "$server_log_file" \
  && grep -Fq 'newer-screen.html' "$server_log_file"; then
  pass "state/server.log records screen-added diagnostics for the compatibility flow"
else
  fail "state/server.log records screen-added diagnostics for the compatibility flow" "Expected screen-added entries for older-screen.html and newer-screen.html in $server_log_file"
fi

echo ""
echo "--- Supported shutdown flow ---"
if [[ $failed -eq 0 && -n "$session_dir" ]]; then
  if [[ -f "$server_log_file" ]]; then
    cp "$server_log_file" "$ARTIFACT_DIR/server.log.snapshot"
  fi
  if bash "$STOP_SCRIPT" "$session_dir" > "$STOP_STDOUT" 2> "$STOP_STDERR"; then
    if grep -Fq '"status": "stopped"' "$STOP_STDOUT" && [[ ! -f "$state_dir/server.pid" ]]; then
      pass "stop-server.sh stops the session created by start-server.sh"
    else
      fail "stop-server.sh stops the session created by start-server.sh" "Unexpected stop output: $(tr '\n' ' ' < "$STOP_STDOUT")"
    fi
  else
    fail "stop-server.sh stops the session created by start-server.sh" "$(tr '\n' ' ' < "$STOP_STDERR") $(tr '\n' ' ' < "$STOP_STDOUT")"
  fi
fi

echo ""
echo "=== Results: $passed passed, $failed failed ==="
if [[ $failed -gt 0 ]]; then
  exit 1
fi
exit 0
