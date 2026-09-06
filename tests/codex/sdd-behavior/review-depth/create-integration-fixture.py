#!/usr/bin/env python3
"""Create a disposable two-unit review fixture; print immutable review inputs."""
import json
import pathlib
import subprocess
import tempfile

repo = pathlib.Path(tempfile.mkdtemp(prefix='sdd-review-integration-'))

def write(name, content):
    (repo / name).write_text(content)

def git(*args):
    return subprocess.check_output(['git', '-C', str(repo), *args], text=True).strip()

git('init', '-q')
git('config', 'core.hooksPath', '/dev/null')
git('config', 'commit.gpgsign', 'false')
git('config', 'user.name', 'Review fixture')
git('config', 'user.email', 'fixture@example.invalid')
write('spec.md', '''# Approved contract
Expose invoice totals as dollar strings with two decimal places, e.g. $12.00.
The producer moves its internal amount representation from dollars to cents.
The external display must preserve dollar units. No negative amounts are valid.
No TDD requirement applies to this fixture.
''')
write('plan.md', '''# Plan
Unit 1: Change producer amount to integer cents and update its behavioral test.
Unit 2: Preserve display behavior for callers using the producer.
Named risk: cross-unit contract.
Selected profiles: none.
''')
write('producer.py', 'def invoice():\n    return {"amount": 12}\n')
write('consumer.py', 'def display(invoice):\n    return f"${invoice[\'amount\']:.2f}"\n')
write('test_invoice.py', '''import unittest
from producer import invoice
from consumer import display

class InvoiceTests(unittest.TestCase):
    def test_producer(self):
        self.assertEqual(invoice(), {"amount": 12})
    def test_display(self):
        self.assertEqual(display({"amount": 12}), "$12.00")
''')
git('add', '.')
git('commit', '-qm', 'test: Create base fixture')
base = git('rev-parse', 'HEAD')
write('producer.py', 'def invoice():\n    return {"amount": 1200}\n')
write('test_invoice.py', (repo / 'test_invoice.py').read_text().replace('invoice(), {"amount": 12}', 'invoice(), {"amount": 1200}'))
git('add', '.')
git('commit', '-qm', 'feat: Use cents in producer')
head = git('rev-parse', 'HEAD')
result = subprocess.run(['python3', '-m', 'unittest', '-v'], cwd=repo, text=True, capture_output=True)
write('evidence.md', f'''# Supplied unit evidence
Unit 1 READY: producer returns integer cents. Reviewed {base}..{head}.
Unit 2 READY: local display test still passes. No consumer changes deemed needed.
Command: python3 -m unittest -v
Exit: {result.returncode}
{result.stdout}{result.stderr}
These are unit verdicts; inspect their claims against source.
''')
write('review.diff', git('diff', base, head)+'\n')
print(json.dumps({'repo':str(repo), 'base':base, 'head':head, 'test_exit':result.returncode}))
