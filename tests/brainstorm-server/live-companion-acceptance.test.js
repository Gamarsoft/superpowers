#!/usr/bin/env node

const { spawnSync } = require('child_process');
const http = require('http');
const fs = require('fs');
const path = require('path');
const assert = require('assert');
const WebSocket = require('ws');

const START_SCRIPT = path.join(__dirname, '../../skills/brainstorming/scripts/start-server.sh');
const STOP_SCRIPT = path.join(__dirname, '../../skills/brainstorming/scripts/stop-server.sh');
const EXAMPLES_DIR = path.join(__dirname, '../../skills/brainstorming/examples/visual-companion');

const TEST_ROOT = path.join('/tmp', `brainstorm-live-companion-${process.pid}-${Date.now()}`);
const PROJECT_DIR = path.join(TEST_ROOT, 'project');
const ARTIFACT_DIR = path.join(TEST_ROOT, 'artifacts');
const START_STDOUT_PATH = path.join(ARTIFACT_DIR, 'start-server.stdout');
const START_STDERR_PATH = path.join(ARTIFACT_DIR, 'start-server.stderr');
const STOP_STDOUT_PATH = path.join(ARTIFACT_DIR, 'stop-server.stdout');
const STOP_STDERR_PATH = path.join(ARTIFACT_DIR, 'stop-server.stderr');

let startup = null;
let sessionDir = '';
let stateDir = '';
let screenDir = '';
let serverUrl = '';
let sessionKey = '';
let sessionCookie = '';
let serverInfoPath = '';
let serverLogPath = '';
let stopAttempted = false;
let succeeded = false;

function cleanupDir(targetPath) {
  if (fs.existsSync(targetPath)) {
    fs.rmSync(targetPath, { recursive: true, force: true });
  }
}

function ensureDir(targetPath) {
  fs.mkdirSync(targetPath, { recursive: true });
}

function writeArtifact(filePath, content) {
  ensureDir(path.dirname(filePath));
  fs.writeFileSync(filePath, content);
}

function readJson(filePath) {
  return JSON.parse(fs.readFileSync(filePath, 'utf-8').trim());
}

function parseJsonFromOutput(rawOutput, label) {
  const lines = String(rawOutput)
    .split('\n')
    .map((line) => line.trim())
    .filter(Boolean);

  for (const line of lines) {
    try {
      return JSON.parse(line);
    } catch (_error) {
      // Keep scanning for the first valid JSON line.
    }
  }

  throw new Error(`${label} did not contain a parseable JSON line. Output: ${String(rawOutput).trim()}`);
}

function runScript(scriptPath, args, label) {
  const result = spawnSync('bash', [scriptPath, ...args], {
    encoding: 'utf8',
    env: process.env
  });

  return {
    ...result,
    label,
    stdout: result.stdout || '',
    stderr: result.stderr || ''
  };
}

function fetch(url) {
  return new Promise((resolve, reject) => {
    http
      .get(url, { headers: sessionCookie ? { Cookie: sessionCookie } : {} }, (res) => {
        let body = '';
        res.setEncoding('utf8');
        res.on('data', (chunk) => {
          body += chunk;
        });
        res.on('end', () => {
          resolve({ status: res.statusCode, headers: res.headers, body });
        });
      })
      .on('error', reject);
  });
}

function sleep(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

async function waitFor(label, predicate, { timeoutMs = 5000, intervalMs = 100 } = {}) {
  const deadline = Date.now() + timeoutMs;
  let lastError = null;

  while (Date.now() < deadline) {
    try {
      const value = await predicate();
      if (value) return value;
    } catch (error) {
      lastError = error;
    }
    await sleep(intervalMs);
  }

  if (lastError) {
    throw new Error(`Timed out waiting for ${label}: ${lastError.message}`);
  }
  throw new Error(`Timed out waiting for ${label}`);
}

function snapshotPath(name) {
  return path.join(ARTIFACT_DIR, `${name}.html`);
}

async function waitForHtmlText(text, artifactName, timeoutMs = 5000) {
  const targetPath = snapshotPath(artifactName);

  return waitFor(
    `served HTML containing "${text}"`,
    async () => {
      const response = await fetch(`${serverUrl}/`);
      writeArtifact(targetPath, response.body);
      if (response.status === 200 && response.body.includes(text)) {
        return { response, snapshot: targetPath };
      }
      return false;
    },
    { timeoutMs }
  );
}

async function waitForFileText(filePath, text, timeoutMs = 5000) {
  return waitFor(
    `${path.basename(filePath)} containing "${text}"`,
    async () => {
      if (!fs.existsSync(filePath)) return false;
      return fs.readFileSync(filePath, 'utf-8').includes(text);
    },
    { timeoutMs }
  );
}

async function waitForPathState(filePath, shouldExist, timeoutMs = 5000) {
  return waitFor(
    `${filePath} to become ${shouldExist ? 'present' : 'absent'}`,
    async () => (shouldExist ? fs.existsSync(filePath) : !fs.existsSync(filePath)),
    { timeoutMs }
  );
}

function writeScreen(fileName, html, mtimeOffsetMs = 0) {
  const destination = path.join(screenDir, fileName);
  fs.writeFileSync(destination, html);
  const timestamp = new Date(Date.now() + mtimeOffsetMs);
  fs.utimesSync(destination, timestamp, timestamp);
  return destination;
}

function copyExampleScreen(exampleFile, destinationFile, mtimeOffsetMs = 0) {
  const html = fs.readFileSync(path.join(EXAMPLES_DIR, exampleFile), 'utf-8');
  return writeScreen(destinationFile, html, mtimeOffsetMs);
}

async function sendChoiceEvent(event) {
  const wsUrl = new URL(serverUrl);
  wsUrl.protocol = wsUrl.protocol === 'https:' ? 'wss:' : 'ws:';
  wsUrl.pathname = '/';
  wsUrl.searchParams.set('key', sessionKey);

  return new Promise((resolve, reject) => {
    const ws = new WebSocket(wsUrl.toString());
    const timeoutId = setTimeout(() => {
      ws.terminate();
      reject(new Error(`Timed out sending choice event to ${wsUrl}`));
    }, 4000);

    ws.on('open', () => {
      ws.send(JSON.stringify(event), (error) => {
        if (error) {
          clearTimeout(timeoutId);
          ws.terminate();
          reject(error);
          return;
        }

        setTimeout(() => {
          clearTimeout(timeoutId);
          ws.close();
          resolve();
        }, 150);
      });
    });

    ws.on('error', (error) => {
      clearTimeout(timeoutId);
      reject(error);
    });
  });
}

function assertIncludes(haystack, needle, message) {
  assert(haystack.includes(needle), message);
}

function printDiagnostics(error) {
  console.error('\nFAIL: live companion acceptance regression failed');
  console.error(error.message);
  console.error('Diagnostics preserved at:', TEST_ROOT);

  if (sessionDir) {
    console.error('  Session dir:', sessionDir);
  }
  if (serverInfoPath) {
    console.error('  state/server-info:', serverInfoPath);
  }
  if (serverLogPath) {
    console.error('  state/server.log:', serverLogPath);
  }

  const htmlSnapshots = fs.existsSync(ARTIFACT_DIR)
    ? fs.readdirSync(ARTIFACT_DIR).filter((entry) => entry.endsWith('.html')).sort()
    : [];

  if (htmlSnapshots.length > 0) {
    console.error('  HTML snapshots:');
    htmlSnapshots.forEach((file) => {
      console.error(`    - ${path.join(ARTIFACT_DIR, file)}`);
    });
  }

  if (sessionDir && !stopAttempted) {
    console.error(`  Stop manually after inspection with: bash "${STOP_SCRIPT}" "${sessionDir}"`);
  }
}

async function run() {
  cleanupDir(TEST_ROOT);
  ensureDir(PROJECT_DIR);
  ensureDir(ARTIFACT_DIR);

  let passed = 0;

  function pass(message) {
    console.log(`  PASS: ${message}`);
    passed += 1;
  }

  console.log('\n--- Live companion acceptance ---');

  const startResult = runScript(
    START_SCRIPT,
    ['--project-dir', PROJECT_DIR, '--host', '127.0.0.1', '--url-host', 'localhost', '--background'],
    'start-server.sh'
  );
  writeArtifact(START_STDOUT_PATH, startResult.stdout);
  writeArtifact(START_STDERR_PATH, startResult.stderr);

  assert.strictEqual(
    startResult.status,
    0,
    `start-server.sh exited ${startResult.status}. stderr: ${startResult.stderr || '(empty)'}`
  );

  startup = parseJsonFromOutput(startResult.stdout, 'start-server.sh stdout');
  assert.strictEqual(startup.type, 'server-started', 'start-server.sh should emit a server-started payload');
  assert.strictEqual(startup.host, '127.0.0.1', 'startup host should match the requested bind host');
  assert.strictEqual(startup.url_host, 'localhost', 'startup url_host should match the requested display host');
  assert(String(startup.url).startsWith('http://localhost:'), `unexpected startup url: ${startup.url}`);

  stateDir = startup.state_dir;
  screenDir = startup.screen_dir;
  const startupUrl = new URL(startup.url);
  sessionKey = startupUrl.searchParams.get('key');
  assert(sessionKey, 'startup URL should carry the session key');
  serverUrl = startupUrl.origin;
  sessionCookie = `brainstorm-key-${startup.port}=${sessionKey}`;
  sessionDir = path.dirname(stateDir);
  serverInfoPath = path.join(stateDir, 'server-info');
  serverLogPath = path.join(stateDir, 'server.log');

  assert(fs.existsSync(serverInfoPath), 'state/server-info should be written by the live entrypoint');
  assert.deepStrictEqual(
    readJson(serverInfoPath),
    startup,
    'state/server-info should match the startup JSON from start-server.sh'
  );
  pass('start-server.sh launches the real runtime and persists matching startup metadata');

  const fragmentFile = copyExampleScreen(
    'annotated-recommendation.html',
    'annotated-recommendation-live.html',
    -10000
  );
  await waitForFileText(serverLogPath, path.basename(fragmentFile));
  const fragmentRender = await waitForHtmlText(
    'Annotated recommendation: settings information architecture',
    '01-fragment-annotated-recommendation'
  );

  assert.strictEqual(fragmentRender.response.status, 200, 'fragment request should return 200');
  assertIncludes(
    fragmentRender.response.body,
    'click-assisted follow-up',
    'fragment render should keep the authored click-assisted continuity copy visible'
  );
  assertIncludes(
    fragmentRender.response.body,
    'Chosen direction: task-grouped settings',
    'fragment render should show the authored chosen direction'
  );
  assertIncludes(
    fragmentRender.response.body,
    'Still open alternative: technical-stack sections',
    'fragment render should show the authored still-open alternative'
  );
  assertIncludes(
    fragmentRender.response.body,
    'data-comparison-kit="fragment-shell"',
    'fragment render should still receive the fragment shell marker through the real entrypoint'
  );
  pass('the real entrypoint serves the authored fragment example with visible comparison content and the fragment shell');

  const eventsPath = path.join(stateDir, 'events');
  await sendChoiceEvent({
    type: 'click',
    choice: 'task-grouped-settings',
    text: 'Chosen direction: task-grouped settings'
  });
  await waitForPathState(eventsPath, true);

  const eventLines = fs.readFileSync(eventsPath, 'utf-8').trim().split('\n').filter(Boolean);
  const latestEvent = JSON.parse(eventLines[eventLines.length - 1]);
  assert.strictEqual(latestEvent.choice, 'task-grouped-settings', 'latest persisted event should match the simulated choice');
  assert.strictEqual(
    latestEvent.text,
    'Chosen direction: task-grouped settings',
    'latest persisted event should preserve the submitted choice text'
  );
  pass('the live runtime writes state/events after a simulated authored choice submission');

  const carryForwardFile = copyExampleScreen(
    'carry-forward-summary.html',
    'carry-forward-summary-live.html',
    0
  );
  await waitForFileText(serverLogPath, path.basename(carryForwardFile));
  const carryForwardRender = await waitForHtmlText(
    'Decision checkpoint: export flow',
    '02-carry-forward-summary'
  );

  assert.strictEqual(carryForwardRender.response.status, 200, 'carry-forward request should return 200');
  assertIncludes(
    carryForwardRender.response.body,
    'terminal-only follow-up',
    'carry-forward render should stay explicit about the terminal-only follow-up context'
  );
  assertIncludes(
    carryForwardRender.response.body,
    'Chosen direction: drawer-based export flow',
    'carry-forward render should keep the authored chosen direction visible'
  );
  assertIncludes(
    carryForwardRender.response.body,
    'Still open: permission fallback copy',
    'carry-forward render should keep the authored still-open copy visible'
  );
  assertIncludes(
    carryForwardRender.response.body,
    'Degraded mode',
    'carry-forward render should keep the authored degraded-mode copy visible'
  );
  assert(
    !carryForwardRender.response.body.includes('Annotated recommendation: settings information architecture'),
    'the newer carry-forward screen should replace the older fragment render'
  );
  await waitForPathState(eventsPath, false);
  pass('a genuinely newer carry-forward screen clears state/events while preserving explicit continuity copy');

  const fullDocumentHtml = [
    '<!DOCTYPE html>',
    '<html>',
    '<head>',
    '  <meta charset="utf-8">',
    '  <title>Live Acceptance Full Document</title>',
    '</head>',
    '<body>',
    '  <main>',
    '    <h1 id="full-document-marker">Live Acceptance Full Document</h1>',
    '    <p id="boundary-copy">This compatibility fixture should pass through as a full document.</p>',
    '  </main>',
    '</body>',
    '</html>'
  ].join('\n');
  const fullDocumentFile = writeScreen('full-document-live.html', fullDocumentHtml, 10000);
  await waitForFileText(serverLogPath, path.basename(fullDocumentFile));
  const fullDocumentRender = await waitForHtmlText(
    'Live Acceptance Full Document',
    '03-full-document-passthrough'
  );

  assert.strictEqual(fullDocumentRender.response.status, 200, 'full-document request should return 200');
  assert(
    fullDocumentRender.response.body.trimStart().startsWith('<!DOCTYPE html>'),
    'full-document passthrough should preserve the authored document root'
  );
  assertIncludes(
    fullDocumentRender.response.body,
    'id="full-document-marker"',
    'full-document passthrough should keep the authored marker'
  );
  assertIncludes(
    fullDocumentRender.response.body,
    'window.brainstorm',
    'full-document passthrough should still receive helper injection'
  );
  assert(
    !fullDocumentRender.response.body.includes('data-comparison-kit="fragment-shell"'),
    'full-document passthrough must not leak the fragment shell marker'
  );
  assert(
    !fullDocumentRender.response.body.includes('indicator-bar'),
    'full-document passthrough must not inherit the shared fragment indicator bar'
  );
  assert(
    !fullDocumentRender.response.body.includes('id="claude-content"'),
    'full-document passthrough must not inherit the shared fragment content frame'
  );
  pass('a genuinely newer full-document screen passes through without fragment-shell contamination');

  const stopResult = runScript(STOP_SCRIPT, [sessionDir], 'stop-server.sh');
  stopAttempted = true;
  writeArtifact(STOP_STDOUT_PATH, stopResult.stdout);
  writeArtifact(STOP_STDERR_PATH, stopResult.stderr);

  assert.strictEqual(
    stopResult.status,
    0,
    `stop-server.sh exited ${stopResult.status}. stderr: ${stopResult.stderr || '(empty)'}`
  );
  const stopPayload = parseJsonFromOutput(stopResult.stdout, 'stop-server.sh stdout');
  assert.strictEqual(stopPayload.status, 'stopped', 'stop-server.sh should report stopped for the live session');
  assert(
    !fs.existsSync(path.join(stateDir, 'server.pid')),
    'server.pid should be removed after stop-server.sh tears down the live session'
  );
  pass('stop-server.sh tears down the session created by the real start entrypoint');

  succeeded = true;
  console.log(`\n--- Results: ${passed} passed, 0 failed ---`);
}

run()
  .then(() => {
    if (succeeded) cleanupDir(TEST_ROOT);
  })
  .catch((error) => {
    printDiagnostics(error);
    process.exit(1);
  });
