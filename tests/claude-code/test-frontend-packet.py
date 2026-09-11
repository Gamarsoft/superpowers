#!/usr/bin/env python3
"""Exercise the packet validator against real files and damaged handoffs."""
import hashlib
import json
from pathlib import Path
import subprocess
import tempfile
import unittest

SCRIPT = Path(__file__).resolve().parents[2] / 'skills/frontend-direction/scripts/frontend_packet.py'


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


class PacketValidation(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name) / 'packet'
        self.root.mkdir()
        for name, data in {
            'packet.md': '<!-- frontend-packet: 1 -->\n# Approved design\nUse the account summary and stationary pager.',
            'screen-index.md': '# Screens\nSuccess, desktop and narrow. Error uses local scenario.',
            'brownfield-ui-extraction.md': '# Inspection\nRetain brand and read-only business behavior.',
            'prototype/index.html': '<main>Type</main>',
            'prototype/app.js': 'const revision = "v2.1";',
            'references/desktop.jpg': 'test capture bytes',
        }.items():
            p = self.root / name
            p.parent.mkdir(parents=True, exist_ok=True)
            p.write_text(data)
        self.packet = {
            'schema_version': 1, 'status': 'approved', 'revision': 'v2.1',
            'entrypoint': 'packet.md', 'context': 'brownfield',
            'approval': {'revision': 'v2.1', 'decision': 'User approved this prototype', 'date': '2026-09-11'},
            'documents': {'screen_index': 'screen-index.md', 'inspection': 'brownfield-ui-extraction.md'},
            'prototype': {'path': 'prototype', 'entrypoint': 'prototype/index.html', 'revision': 'v2.1',
                          'launch_command': 'python3 -m http.server 8766 --directory prototype',
                          'url': 'http://127.0.0.1:8766/'},
            'targets': [{'id': 'desktop', 'path': 'references/desktop.jpg', 'intent': 'visual-truth',
                         'scope': 'Approved dialog layout', 'source_version': 'v2.1', 'state': 'success',
                         'viewport': {'width': 1154, 'height': 1324}}],
            'states': [{'id': 'success', 'setup': 'Open /', 'references': ['desktop'], 'verification': 'exercised'},
                       {'id': 'error', 'setup': 'Open /?state=error', 'references': [], 'verification': 'not-exercised'}],
            'limitations': ['Synthetic fixture; no backend integration'],
            'files': self.inventory(),
        }

    def inventory(self):
        return {p.relative_to(self.root).as_posix(): digest(p) for p in sorted(self.root.rglob('*'))
                if p.is_file() and p.name != 'packet.json' and 'history' not in p.relative_to(self.root).parts}

    def run_check(self, packet=None):
        (self.root / 'packet.json').write_text(json.dumps(self.packet if packet is None else packet))
        self.assertTrue(SCRIPT.is_file(), 'Canonical packet validation helper is missing')
        result = subprocess.run(['python3', str(SCRIPT), 'check', str(self.root)], capture_output=True, text=True)
        return result, json.loads(result.stdout)

    def assert_rejected(self, code):
        result, data = self.run_check()
        self.assertNotEqual(result.returncode, 0)
        self.assertFalse(data['valid'])
        self.assertIn(code, [issue['code'] for issue in data['errors']])

    def test_complete_current_packet_passes_and_returns_identity(self):
        result, data = self.run_check()
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertTrue(data['valid'])
        self.assertEqual(data['revision'], 'v2.1')
        self.assertEqual(data['descriptor_sha256'], digest(self.root / 'packet.json'))

    def test_changed_source_is_rejected_without_refreshing_hashes(self):
        (self.root / 'prototype/app.js').write_text('unapproved source change')
        self.assert_rejected('hash-mismatch')

    def test_missing_reference_is_rejected(self):
        (self.root / 'references/desktop.jpg').unlink()
        self.assert_rejected('missing-file')

    def test_added_current_source_is_rejected(self):
        (self.root / 'prototype/extra.js').write_text('new dependency')
        self.assert_rejected('inventory-mismatch')

    def test_historical_files_are_preserved_but_not_current(self):
        h = self.root / 'history/pilot'
        h.mkdir(parents=True)
        (h / 'packet.json').write_text('old unrelated format')
        result, data = self.run_check()
        self.assertEqual(result.returncode, 0, data)

    def test_history_cannot_be_a_binding_target(self):
        self.packet['targets'][0]['path'] = 'history/old.jpg'
        self.assert_rejected('target-path')

    def test_pending_status_is_not_ready(self):
        self.packet['status'] = 'required-pending'
        self.assert_rejected('status')

    def test_approval_and_prototype_revisions_must_match(self):
        for field in ['approval', 'prototype']:
            with self.subTest(field=field):
                self.packet[field]['revision'] = 'v2.0'
                self.assert_rejected('revision-mismatch')
                self.packet[field]['revision'] = 'v2.1'

    def test_missing_approval_cannot_be_filled_by_validation(self):
        self.packet['approval']['decision'] = ''
        self.assert_rejected('approval')
        self.assertEqual(json.loads((self.root / 'packet.json').read_text())['approval']['decision'], '')

    def test_bad_state_reference_or_setup_is_rejected(self):
        self.packet['states'][0]['references'] = ['unknown']
        self.assert_rejected('state-reference')
        self.packet['states'][0]['references'] = ['desktop']
        self.packet['states'][0]['setup'] = ''
        self.assert_rejected('state-setup')

    def test_unknown_schema_is_not_accepted_as_legacy(self):
        self.packet['schema_version'] = 42
        self.assert_rejected('schema-version')

    def test_paths_and_symlinks_cannot_escape_packet(self):
        outside = self.root.parent / 'outside.txt'
        outside.write_text('outside')
        self.packet['files']['../outside.txt'] = digest(outside)
        self.assert_rejected('unsafe-path')
        del self.packet['files']['../outside.txt']
        (self.root / 'prototype/link.js').symlink_to(outside)
        self.assert_rejected('symlink')

    def test_missing_canonical_documents_are_rejected(self):
        self.packet['documents']['screen_index'] = 'elsewhere.md'
        self.assert_rejected('documents')

    def test_degraded_evidence_requires_explicit_acceptance(self):
        self.packet['prototype'] = None
        self.packet['status'] = 'approved-with-degraded-evidence'
        self.assert_rejected('degraded-approval')
        self.packet['approval']['accepted_limitations'] = self.packet['limitations']
        result, data = self.run_check()
        self.assertEqual(result.returncode, 0, data)

    def test_explicit_references_only_scope_does_not_require_a_fake_prototype(self):
        self.packet['prototype'] = None
        self.packet['prototype_omission'] = {
            'reason': 'Image-only direction explicitly requested',
            'decision': 'User requested image references without interactive exploration',
        }
        result, data = self.run_check()
        self.assertEqual(result.returncode, 0, data)

    def test_inventory_command_is_read_only_and_excludes_self_and_history(self):
        self.assertTrue(SCRIPT.is_file(), 'Canonical packet validation helper is missing')
        (self.root / 'packet.json').write_text('{"status":"required-pending"}')
        (self.root / 'history').mkdir()
        (self.root / 'history/old.txt').write_text('history')
        before = (self.root / 'packet.json').read_bytes()
        result = subprocess.run(['python3', str(SCRIPT), 'inventory', str(self.root)], capture_output=True, text=True)
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(json.loads(result.stdout), self.inventory())
        self.assertEqual((self.root / 'packet.json').read_bytes(), before)

    def test_missing_descriptor_and_wrong_expected_identity_fail_closed(self):
        self.assertTrue(SCRIPT.is_file(), 'Canonical packet validation helper is missing')
        result = subprocess.run(['python3', str(SCRIPT), 'check', str(self.root),
                                 '--expected-revision', 'v2.1'], capture_output=True, text=True)
        self.assertNotEqual(result.returncode, 0)
        self.assertIn('missing-descriptor', [e['code'] for e in json.loads(result.stdout)['errors']])
        self.run_check()
        for option, value in [('--expected-revision', 'v2.0'),
                              ('--expected-descriptor-sha256', '0' * 64)]:
            with self.subTest(option=option):
                r = subprocess.run(['python3', str(SCRIPT), 'check', str(self.root), option, value],
                                   capture_output=True, text=True)
                self.assertNotEqual(r.returncode, 0)
                self.assertIn('expected-identity', [e['code'] for e in json.loads(r.stdout)['errors']])

    def test_malformed_descriptor_has_actionable_failure(self):
        self.assertTrue(SCRIPT.is_file(), 'Canonical packet validation helper is missing')
        for value in ['{', '[]', '{"schema_version":1,"targets":false}']:
            with self.subTest(value=value):
                (self.root / 'packet.json').write_text(value)
                r = subprocess.run(['python3', str(SCRIPT), 'check', str(self.root)], capture_output=True, text=True)
                self.assertNotEqual(r.returncode, 0)
                self.assertFalse(json.loads(r.stdout)['valid'])
                self.assertNotIn('Traceback', r.stderr)


if __name__ == '__main__':
    unittest.main()
