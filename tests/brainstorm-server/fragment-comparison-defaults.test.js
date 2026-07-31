const { spawn } = require('child_process');
const http = require('http');
const fs = require('fs');
const path = require('path');
const assert = require('assert');

const SERVER_PATH = path.join(__dirname, '../../skills/brainstorming/scripts/server.cjs');
const FIXTURE_DIR = path.join(__dirname, '../../skills/brainstorming/examples/visual-companion');
const RANKED_FIXTURE_PATH = path.join(FIXTURE_DIR, 'ranked-alternatives.html');
const RECOMMENDATION_FIXTURE_PATH = path.join(FIXTURE_DIR, 'annotated-recommendation.html');
const CARRY_FORWARD_FIXTURE_PATH = path.join(FIXTURE_DIR, 'carry-forward-summary.html');

const TEST_PORT = 35000 + Math.floor(Math.random() * 1000);
const TOKEN = 'testtoken-fragment-defaults-0123456789abcdef';
const TEST_DIR = `/tmp/brainstorm-fragment-defaults-${process.pid}-${Date.now()}`;
const CONTENT_DIR = path.join(TEST_DIR, 'content');
const ACTIVE_SCREEN = 'active-screen.html';
const SHELL_HOOK = 'data-comparison-kit="fragment-shell"';

const RANKING_SELECTOR_PROOFS = [
  ['.option.selected {', 'current-winner option emphasis selector'],
  ['.card.selected {', 'current-winner card emphasis selector'],
  ['.letter {', 'rank marker selector']
];

const RECOMMENDATION_SELECTOR_PROOFS = [
  ['.label {', 'recommendation label selector'],
  ['.section {', 'recommendation section framing selector'],
  ['.mockup {', 'annotated recommendation mockup selector'],
  ['.subtitle {', 'recommendation subtitle scan selector']
];

const CARRY_FORWARD_SELECTOR_PROOFS = [
  ['.options[data-multiselect] {', 'carry-forward multiselect container selector'],
  ['.options[data-multiselect] .option.selected {', 'carry-forward selected-item emphasis selector']
];

function cleanup() {
  if (fs.existsSync(TEST_DIR)) {
    fs.rmSync(TEST_DIR, { recursive: true, force: true });
  }
}

function sleep(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

function fetch(url) {
  return new Promise((resolve, reject) => {
    http
      .get(url, { headers: { Cookie: `brainstorm-key-${TEST_PORT}=${TOKEN}` } }, (res) => {
        let data = '';
        res.on('data', (chunk) => {
          data += chunk;
        });
        res.on('end', () => {
          resolve({ status: res.statusCode, headers: res.headers, body: data });
        });
      })
      .on('error', reject);
  });
}

function startServer() {
  return spawn('node', [SERVER_PATH], {
    env: {
      ...process.env,
      BRAINSTORM_PORT: String(TEST_PORT),
      BRAINSTORM_DIR: TEST_DIR,
      BRAINSTORM_TOKEN: TOKEN
    }
  });
}

function waitForServer(server) {
  let stdout = '';
  let stderr = '';

  return new Promise((resolve, reject) => {
    const timeoutId = setTimeout(() => {
      reject(new Error(`Server didn't start. stderr: ${stderr}`));
    }, 5000);

    server.stdout.on('data', (data) => {
      stdout += data.toString();
      if (stdout.includes('server-started')) {
        clearTimeout(timeoutId);
        resolve();
      }
    });

    server.stderr.on('data', (data) => {
      stderr += data.toString();
    });

    server.on('error', (error) => {
      clearTimeout(timeoutId);
      reject(error);
    });
  });
}

function writeActiveScreen(html) {
  fs.writeFileSync(path.join(CONTENT_DIR, ACTIVE_SCREEN), html);
}

function assertSelectorProofs(html, proofs, surfaceName) {
  for (const [selector, label] of proofs) {
    assert(
      html.includes(selector),
      `Missing ${surfaceName} proof in wrapped fragment HTML: ${label} (${selector})`
    );
  }
}

async function renderFixtureAndFetch(fixturePath) {
  const fragment = fs.readFileSync(fixturePath, 'utf-8');
  writeActiveScreen(fragment);
  await sleep(300);
  return fetch(`http://localhost:${TEST_PORT}/`);
}

function assertNoOverDimmingRule(html) {
  const overDimmingRule = /\.option:not\(\.selected\)\s*\{[^}]*opacity\s*:/m;
  assert(
    !overDimmingRule.test(html),
    'Lower-ranked options must remain readable; found opacity dimming rule targeting non-selected options'
  );
}

async function run() {
  cleanup();

  const server = startServer();

  try {
    await waitForServer(server);

    const rankedRes = await renderFixtureAndFetch(RANKED_FIXTURE_PATH);
    assert.strictEqual(rankedRes.status, 200, 'Ranked fixture request should return 200');
    assert(
      rankedRes.body.includes(SHELL_HOOK),
      'Wrapped fragments must expose the fragment comparison shell hook'
    );
    assert(
      rankedRes.body.includes('Rank three release-note entry points'),
      'Wrapped ranked response should include representative ranked fragment content'
    );
    assertSelectorProofs(rankedRes.body, RANKING_SELECTOR_PROOFS, 'ranking defaults');
    assertNoOverDimmingRule(rankedRes.body);

    const recommendationRes = await renderFixtureAndFetch(RECOMMENDATION_FIXTURE_PATH);
    assert.strictEqual(
      recommendationRes.status,
      200,
      'Annotated recommendation fixture request should return 200'
    );
    assert(
      recommendationRes.body.includes(SHELL_HOOK),
      'Annotated recommendation fragment must keep the fragment comparison shell hook'
    );
    assert(
      recommendationRes.body.includes('Annotated recommendation: settings information architecture'),
      'Wrapped recommendation response should include representative recommendation fragment content'
    );
    assertSelectorProofs(
      recommendationRes.body,
      RECOMMENDATION_SELECTOR_PROOFS,
      'recommendation defaults'
    );

    const carryForwardRes = await renderFixtureAndFetch(CARRY_FORWARD_FIXTURE_PATH);
    assert.strictEqual(carryForwardRes.status, 200, 'Carry-forward fixture request should return 200');
    assert(
      carryForwardRes.body.includes(SHELL_HOOK),
      'Carry-forward fragment must keep the fragment comparison shell hook'
    );
    assert(
      carryForwardRes.body.includes('Decision checkpoint: export flow'),
      'Wrapped carry-forward response should include representative carry-forward fragment content'
    );
    assertSelectorProofs(carryForwardRes.body, CARRY_FORWARD_SELECTOR_PROOFS, 'carry-forward defaults');

    const fullDocument = [
      '<!DOCTYPE html>',
      '<html>',
      '<head><meta charset="utf-8"><title>Full Document Fixture</title></head>',
      '<body><main><h1 id="full-document-marker">Full Document Fixture</h1></main></body>',
      '</html>'
    ].join('');

    writeActiveScreen(fullDocument);
    await sleep(300);

    const fullDocRes = await fetch(`http://localhost:${TEST_PORT}/`);
    assert.strictEqual(fullDocRes.status, 200, 'Full-document request should return 200');
    assert(
      fullDocRes.body.includes('id="full-document-marker"'),
      'Full-document passthrough should keep authored HTML content'
    );
    assert(
      fullDocRes.body.trimStart().startsWith('<!DOCTYPE html>'),
      'Full-document passthrough should preserve full-document root output'
    );
    assert(
      !fullDocRes.body.includes(SHELL_HOOK),
      'Full-document passthrough must not leak fragment-only shell hook'
    );

    console.log('PASS: fragment comparison defaults cover ranking, recommendation, carry-forward, and full-document boundary checks');
  } finally {
    server.kill();
    await sleep(120);
    cleanup();
  }
}

run().catch((error) => {
  console.error('FAIL: fragment comparison defaults regression failed');
  console.error(error.message);
  process.exit(1);
});
