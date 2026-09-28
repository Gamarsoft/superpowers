// Catch accidental inheritance of a busy developer/parallel-suite port.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const net = require('node:net');
const { spawn } = require('node:child_process');
const path = require('node:path');

test('carry-forward fixtures run when the inherited port is occupied', async () => {
  const occupied = net.createServer();
  await new Promise((resolve, reject) => {
    occupied.once('error', reject);
    occupied.listen(0, '127.0.0.1', resolve);
  });
  try {
    const result = await new Promise((resolve, reject) => {
      const child = spawn(process.execPath, [path.join(__dirname, 'carry-forward-behavior.test.js')], {
        env: { ...process.env, BRAINSTORM_PORT: String(occupied.address().port) },
        timeout: 15000
      });
      let output = '';
      child.stdout.on('data', chunk => { output += chunk; });
      child.stderr.on('data', chunk => { output += chunk; });
      child.once('error', reject);
      child.once('close', (code, signal) => resolve({ code, signal, output }));
    });
    assert.equal(result.code, 0, result.output);
    assert.equal(result.signal, null);
  } finally {
    await new Promise(resolve => occupied.close(resolve));
  }
});
