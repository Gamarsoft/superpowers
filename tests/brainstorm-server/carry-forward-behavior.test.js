const { spawn } = require('child_process');
const http = require('http');
const fs = require('fs');
const path = require('path');
const assert = require('assert');

const SERVER_PATH = path.join(__dirname, '../../skills/brainstorming/scripts/server.cjs');
const EXAMPLES_DIR = path.join(__dirname, '../../skills/brainstorming/examples/visual-companion');
const TEST_ROOT = path.join('/tmp', `brainstorm-carry-forward-${process.pid}`);

function cleanupDir(dirPath) {
  if (fs.existsSync(dirPath)) {
    fs.rmSync(dirPath, { recursive: true, force: true });
  }
}

function fetch(url) {
  return new Promise((resolve, reject) => {
    http.get(url, (res) => {
      let data = '';
      res.on('data', (chunk) => {
        data += chunk;
      });
      res.on('end', () => {
        resolve({ status: res.statusCode, headers: res.headers, body: data });
      });
    }).on('error', reject);
  });
}

function waitForServer(server) {
  let stdout = '';
  let stderr = '';

  return new Promise((resolve, reject) => {
    const timeoutId = setTimeout(() => {
      reject(new Error(`Server did not start. stderr: ${stderr}`));
    }, 5000);

    server.stdout.on('data', (data) => {
      stdout += data.toString();
      const lines = stdout.trim().split('\n').filter(Boolean);
      const startedLine = lines.find((line) => line.includes('"type":"server-started"'));
      if (startedLine) {
        clearTimeout(timeoutId);
        resolve(JSON.parse(startedLine));
      }
    });

    server.stderr.on('data', (data) => {
      stderr += data.toString();
    });

    server.on('error', (error) => {
      clearTimeout(timeoutId);
      reject(error);
    });

    server.on('exit', (code) => {
      clearTimeout(timeoutId);
      reject(new Error(`Server exited before startup with code ${code}. stderr: ${stderr}`));
    });
  });
}

async function renderExample({ exampleFile, eventsPresent }) {
  const sessionDir = path.join(TEST_ROOT, `${path.basename(exampleFile, '.html')}-${eventsPresent ? 'with-events' : 'without-events'}`);
  const contentDir = path.join(sessionDir, 'content');
  const stateDir = path.join(sessionDir, 'state');
  cleanupDir(sessionDir);
  fs.mkdirSync(contentDir, { recursive: true });
  fs.mkdirSync(stateDir, { recursive: true });

  fs.writeFileSync(
    path.join(contentDir, 'screen.html'),
    fs.readFileSync(path.join(EXAMPLES_DIR, exampleFile), 'utf-8')
  );

  if (eventsPresent) {
    fs.writeFileSync(
      path.join(stateDir, 'events'),
      JSON.stringify({ type: 'click', choice: 'surprise-from-events', text: 'Wrong answer from stale events' }) + '\n'
    );
  }

  const server = spawn('node', [SERVER_PATH], {
    env: {
      ...process.env,
      BRAINSTORM_DIR: sessionDir
    }
  });

  try {
    const info = await waitForServer(server);
    const response = await fetch(info.url);
    const eventsPath = path.join(stateDir, 'events');

    return {
      body: response.body,
      status: response.status,
      eventsExistsAfterRender: fs.existsSync(eventsPath)
    };
  } finally {
    server.kill();
    await new Promise((resolve) => setTimeout(resolve, 100));
    cleanupDir(sessionDir);
  }
}

async function run() {
  cleanupDir(TEST_ROOT);

  let passed = 0;
  let failed = 0;

  async function test(name, fn) {
    try {
      await fn();
      console.log(`  PASS: ${name}`);
      passed += 1;
    } catch (error) {
      console.log(`  FAIL: ${name}`);
      console.log(`    ${error.message}`);
      failed += 1;
    }
  }

  console.log('\n--- Carry-forward behavior ---');

  await test('annotated recommendation keeps the chosen direction explicit without events', async () => {
    const rendered = await renderExample({ exampleFile: 'annotated-recommendation.html', eventsPresent: false });

    assert.strictEqual(rendered.status, 200);
    assert(rendered.body.includes('click-assisted follow-up'), 'Expected click-assisted context copy');
    assert(rendered.body.includes('Chosen direction'), 'Expected explicit chosen-direction wording');
    assert(rendered.body.includes('Still open alternative: technical-stack sections'), 'Expected explicit still-open alternative wording');
    assert(!rendered.body.includes('surprise-from-events'), 'Should not echo stale event content into authored carry-forward copy');
    assert.strictEqual(rendered.eventsExistsAfterRender, false, 'events file should stay absent in the no-events case');
  });

  await test('annotated recommendation renders the same chosen direction even when stale events exist', async () => {
    const withoutEvents = await renderExample({ exampleFile: 'annotated-recommendation.html', eventsPresent: false });
    const withEvents = await renderExample({ exampleFile: 'annotated-recommendation.html', eventsPresent: true });

    assert.strictEqual(withEvents.status, 200);
    assert(withEvents.body.includes('Chosen direction: task-grouped settings'), 'Expected authored chosen direction to stay explicit');
    assert.strictEqual(withEvents.body, withoutEvents.body, 'Rendered carry-forward output should not depend on state/events presence');
    assert.strictEqual(withEvents.eventsExistsAfterRender, true, 'Presence test should keep the seeded events file in place during rendering');
  });

  await test('carry-forward summary stays explicit about chosen, still-open, and degraded mode without events', async () => {
    const rendered = await renderExample({ exampleFile: 'carry-forward-summary.html', eventsPresent: false });

    assert.strictEqual(rendered.status, 200);
    assert(rendered.body.includes('terminal-only follow-up'), 'Expected terminal-only context copy');
    assert(rendered.body.includes('Degraded mode'), 'Expected explicit degraded-mode wording');
    assert(rendered.body.includes('Chosen direction: drawer-based export flow'), 'Expected explicit chosen direction');
    assert(rendered.body.includes('Still open: permission fallback copy'), 'Expected explicit still-open wording');
    assert.strictEqual(rendered.eventsExistsAfterRender, false, 'events file should stay absent in the no-events case');
  });

  await test('carry-forward summary stays identical when conflicting events are present', async () => {
    const withoutEvents = await renderExample({ exampleFile: 'carry-forward-summary.html', eventsPresent: false });
    const withEvents = await renderExample({ exampleFile: 'carry-forward-summary.html', eventsPresent: true });

    assert.strictEqual(withEvents.status, 200);
    assert(withEvents.body.includes('Still open'), 'Expected still-open wording to remain visible');
    assert(withEvents.body.includes('Degraded mode'), 'Expected degraded-mode wording to remain visible');
    assert.strictEqual(withEvents.body, withoutEvents.body, 'Rendered carry-forward summary should not depend on state/events presence');
    assert.strictEqual(withEvents.eventsExistsAfterRender, true, 'Presence test should keep the seeded events file in place during rendering');
  });

  console.log(`\n--- Results: ${passed} passed, ${failed} failed ---`);
  cleanupDir(TEST_ROOT);
  if (failed > 0) process.exit(1);
}

run().catch((error) => {
  cleanupDir(TEST_ROOT);
  console.error('Test failed:', error);
  process.exit(1);
});
