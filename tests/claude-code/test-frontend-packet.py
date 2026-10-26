#!/usr/bin/env python3
"""Exercise the packet validator against real files and damaged handoffs."""
import copy
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
            'packet.md': '<!-- frontend-packet: 2 -->\n# Approved design\nUse the account summary and stationary pager.',
            'screen-index.md': '# Screens\nSuccess, desktop and narrow. Error uses local scenario.',
            'brownfield-ui-extraction.md': '# Inspection\nRetain brand and read-only business behavior.',
            'design/structure.json': '{"tag":"main","text":"Type"}',
            'design/styles.json': '{"main":{"color":"#123456"}}',
            'design/tokens.json': '{"brand":"#123456"}',
            'design/copy.json': '{"success":"Type"}',
            'design/components.json': '{"main":"AccountSummary"}',
            'design/provenance.json': '{"file":"paper-file","page":"page-1","nodes":["node-1"],"revision":"v2.1"}',
            'runtime/source/index.html': '<main>Type</main>',
            'runtime/source/app.js': 'const revision = "app-commit";',
            'runtime/dependencies.txt': 'Python 3 stdlib; no external runtime dependencies',
            'references/desktop.jpg': 'test capture bytes',
        }.items():
            p = self.root / name
            p.parent.mkdir(parents=True, exist_ok=True)
            p.write_text(data)
        self.packet = {
            'schema_version': 2, 'status': 'approved', 'revision': 'v2.1',
            'entrypoint': 'packet.md', 'context': 'brownfield',
            'approval': {'revision': 'v2.1', 'decision': 'User approved this design snapshot', 'date': '2026-09-11'},
            'documents': {'screen_index': 'screen-index.md', 'inspection': 'brownfield-ui-extraction.md'},
            'design_source': {'medium': 'paper', 'revision': 'v2.1', 'manifest': 'design/manifest.json'},
            'runtime_evidence': {'required_checks': ['interaction'], 'checks': [
                {'id': 'interaction', 'state_ids': ['success'], 'result': 'passed',
                 'record': 'runtime/interaction.json'}], 'not_required_reason': None},
            'targets': [{'id': 'desktop', 'path': 'references/desktop.jpg', 'intent': 'visual-truth',
                         'scope': 'Approved dialog layout', 'source_version': 'v2.1', 'state': 'success',
                         'viewport': {'width': 1154, 'height': 1324}}],
            'states': [{'id': 'success', 'setup': 'Open /', 'references': ['desktop'], 'verification': 'exercised'},
                       {'id': 'error', 'setup': 'Open /?state=error', 'references': [], 'verification': 'not-exercised'}],
            'limitations': ['Synthetic fixture; no backend integration'],
        }
        self.manifest = {
            'revision': 'v2.1', 'provenance': 'design/provenance.json',
            'structure': 'design/structure.json', 'computed_styles': 'design/styles.json',
            'resolved_tokens': 'design/tokens.json', 'assets': [],
            'copy': 'design/copy.json', 'component_mappings': 'design/components.json',
        }
        self.runtime_record = {
            'check_id': 'interaction', 'state_ids': ['success'], 'result': 'passed',
            'source_revision': 'app-commit',
            'handoff': {
                'checkout_build': '/tmp/review-checkout at app-commit, clean snapshot',
                'start_command_and_working_directory': 'python3 -m http.server 8766; /tmp/review-checkout',
                'base_url_and_target_route': 'http://127.0.0.1:8766/',
                'readiness_check': 'Confirm app-commit marker and main element',
                'authentication_and_fixture_state_setup': 'No authentication; open / for success fixture',
                'required_viewports_platforms': 'Desktop browser 1154x1324; success',
                'server_owner_lifetime': 'Review session owns server until recapture completes',
            },
            'source': self.local_source(),
        }
        self.write_evidence()

    def local_source(self):
        return {'kind': 'local', 'revision': 'app-commit',
                'paths': ['runtime/source/index.html', 'runtime/source/app.js'],
                'dependencies': 'runtime/dependencies.txt', 'dirty_changes': []}

    def write_evidence(self):
        (self.root / 'design/manifest.json').write_text(json.dumps(self.manifest))
        (self.root / 'runtime/interaction.json').write_text(json.dumps(self.runtime_record))
        self.packet['files'] = self.inventory()

    def inventory(self):
        excluded = {'history', '.git', 'node_modules', '__pycache__', '.DS_Store'}
        return {p.relative_to(self.root).as_posix(): digest(p) for p in sorted(self.root.rglob('*'))
                if p.is_file() and p.name != 'packet.json'
                and not excluded.intersection(p.relative_to(self.root).parts)}

    def run_check(self, packet=None, expected_revision=None, expected_hash=None):
        (self.root / 'packet.json').write_text(json.dumps(self.packet if packet is None else packet))
        self.assertTrue(SCRIPT.is_file(), 'Canonical packet validation helper is missing')
        command = ['python3', str(SCRIPT), 'check', str(self.root)]
        if expected_revision is not None:
            command += ['--expected-revision', expected_revision]
        if expected_hash is not None:
            command += ['--expected-descriptor-sha256', expected_hash]
        result = subprocess.run(command, capture_output=True, text=True)
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
        result, data = self.run_check(expected_revision='v2.1', expected_hash=data['descriptor_sha256'])
        self.assertEqual(result.returncode, 0, data)

    def test_version_one_is_reference_only_with_exact_error(self):
        self.packet['schema_version'] = 1
        before = {p: p.read_bytes() for p in self.root.rglob('*') if p.is_file()}
        result, data = self.run_check()
        self.assertNotEqual(result.returncode, 0)
        self.assertEqual(data['errors'], [{'code': 'schema-version', 'message':
            'Unsupported packet schema version 1. This workflow requires version 2; historical packets are reference material only.'}])
        for path, contents in before.items():
            self.assertEqual(path.read_bytes(), contents)

    def test_missing_and_noninteger_versions_fail_closed(self):
        for version in (None, '2', True, 2.0):
            with self.subTest(version=version):
                self.packet['schema_version'] = version
                self.assert_rejected('schema-version')
        del self.packet['schema_version']
        self.assert_rejected('schema-version')

    def test_version_two_requires_its_entry_marker(self):
        (self.root / 'packet.md').write_text('<!-- frontend-packet: 1 -->\nOld marker')
        self.packet['files'] = self.inventory()
        self.assert_rejected('documents')

    def test_legacy_source_fields_cannot_select_an_omission_branch(self):
        for field in ('prototype', 'prototype_omission'):
            with self.subTest(field=field):
                self.packet[field] = None
                self.assert_rejected('obsolete-field')
                del self.packet[field]

    def test_design_source_and_contained_manifest_are_required(self):
        source = copy.deepcopy(self.packet['design_source'])
        for value in (None, {}, dict(source, medium='unknown'), dict(source, manifest='runtime/interaction.json')):
            with self.subTest(value=value):
                self.packet['design_source'] = value
                self.assert_rejected('design-source')
        self.packet['design_source'] = source
        del self.packet['design_source']
        self.assert_rejected('design-source')

    def test_paper_requires_all_extractions_and_provenance(self):
        for field in ('provenance', 'structure', 'computed_styles', 'resolved_tokens', 'copy', 'component_mappings', 'assets'):
            with self.subTest(field=field):
                value = self.manifest.pop(field)
                self.write_evidence()
                self.assert_rejected('design-manifest')
                self.manifest[field] = value

    def test_manifest_revision_must_match_approved_revision(self):
        self.manifest['revision'] = 'v2.0'
        self.write_evidence()
        self.assert_rejected('revision-mismatch')

    def test_paper_assets_and_supporting_files_are_bound(self):
        for field in ('assets', 'supporting_files'):
            with self.subTest(field=field):
                self.manifest[field] = ['design/missing.svg']
                self.write_evidence()
                self.assert_rejected('missing-file')
                self.assert_rejected('binding-inventory')

    def test_manifest_paths_cannot_escape_or_bind_history(self):
        outside = self.root.parent / 'outside.json'
        outside.write_text('{}')
        self.manifest['structure'] = '../outside.json'
        self.write_evidence()
        self.assert_rejected('unsafe-path')
        old = self.root / 'history/structure.json'
        old.parent.mkdir()
        old.write_text('{}')
        self.manifest['structure'] = 'history/structure.json'
        self.write_evidence()
        self.assert_rejected('binding-inventory')

    def test_frozen_tokens_do_not_follow_live_paper_values(self):
        live_tokens = self.root.parent / 'live-tokens.json'
        live_tokens.write_text('{"brand":"#123456"}')
        self.run_check()
        identity = digest(self.root / 'packet.json')
        live_tokens.write_text('{"brand":"#ffffff"}')
        result, data = self.run_check(expected_revision='v2.1', expected_hash=identity)
        self.assertEqual(result.returncode, 0, data)
        self.assertEqual((self.root / 'design/tokens.json').read_text(), '{"brand":"#123456"}')
        (self.root / 'design/tokens.json').write_text(live_tokens.read_text())
        self.assert_rejected('hash-mismatch')

    def test_runtime_design_retains_actual_local_source(self):
        self.packet['design_source']['medium'] = 'runtime'
        self.manifest = {'revision': 'v2.1', 'provenance': 'design/provenance.json',
                         'source': self.local_source()}
        self.write_evidence()
        result, data = self.run_check()
        self.assertEqual(result.returncode, 0, data)

    def test_runtime_design_cannot_use_only_an_ephemeral_checkout(self):
        self.packet['design_source']['medium'] = 'runtime'
        self.manifest = {'revision': 'v2.1', 'provenance': 'design/provenance.json',
                         'source': {'kind': 'local', 'revision': 'app-commit', 'checkout': '/tmp/vanished'}}
        self.write_evidence()
        self.assert_rejected('runtime-source')

    def test_immutable_source_requires_local_verified_recovery_and_dirty_changes(self):
        source = {'kind': 'immutable-reference', 'revision': 'app-commit',
                  'locator': 'https://example.invalid/repo/commit/app-commit',
                  'recovery_evidence': 'runtime/recovery.json',
                  'dependencies': 'runtime/dependencies.txt', 'dirty_changes': ['runtime/dirty.patch']}
        recovery = {'locator': source['locator'], 'revision': 'app-commit', 'result': 'passed',
                    'method': 'Retrieved immutable archive and compared checkout source'}
        (self.root / 'runtime/recovery.json').write_text(json.dumps(recovery))
        (self.root / 'runtime/dirty.patch').write_text('retained uncommitted source diff')
        self.runtime_record['source'] = source
        self.write_evidence()
        result, data = self.run_check()
        self.assertEqual(result.returncode, 0, data)
        (self.root / 'runtime/dirty.patch').unlink()
        self.packet['files'] = self.inventory()
        self.assert_rejected('binding-inventory')

    def test_unverified_or_mismatched_immutable_recovery_is_rejected(self):
        source = {'kind': 'immutable-reference', 'revision': 'app-commit',
                  'locator': 'https://example.invalid/repo/commit/app-commit',
                  'recovery_evidence': 'runtime/recovery.json',
                  'dependencies': 'runtime/dependencies.txt', 'dirty_changes': []}
        self.runtime_record['source'] = source
        for changed in ({'result': 'unavailable'}, {'revision': 'other'}, {'locator': 'https://example.invalid/mutable'}):
            with self.subTest(changed=changed):
                recovery = {'locator': source['locator'], 'revision': 'app-commit',
                            'result': 'passed', 'method': 'Verified retrieval'}
                recovery.update(changed)
                (self.root / 'runtime/recovery.json').write_text(json.dumps(recovery))
                self.write_evidence()
                self.assert_rejected('source-recovery')

    def test_references_only_requires_the_actual_scope_choice(self):
        self.packet['design_source']['medium'] = 'references-only'
        self.manifest = {'revision': 'v2.1', 'provenance': 'design/provenance.json'}
        self.write_evidence()
        self.assert_rejected('design-manifest')

    def test_no_required_checks_needs_a_substantive_reason(self):
        self.packet['runtime_evidence']['required_checks'] = []
        for reason in (None, '', '   '):
            with self.subTest(reason=reason):
                self.packet['runtime_evidence']['not_required_reason'] = reason
                self.assert_rejected('runtime-evidence')

    def test_runtime_evidence_cannot_be_absent(self):
        del self.packet['runtime_evidence']
        self.assert_rejected('runtime-evidence')

    def test_runtime_evidence_requires_all_three_fields(self):
        del self.packet['runtime_evidence']['not_required_reason']
        self.assert_rejected('runtime-evidence')

    def test_immutable_locator_does_not_exempt_declared_local_source(self):
        source = {'kind': 'immutable-reference', 'revision': 'app-commit',
                  'locator': 'https://example.invalid/repo/commit/app-commit',
                  'recovery_evidence': 'runtime/recovery.json',
                  'paths': ['runtime/node_modules/retained-source.js'],
                  'dependencies': 'runtime/dependencies.txt', 'dirty_changes': []}
        recovery = {'locator': source['locator'], 'revision': 'app-commit',
                    'result': 'passed', 'method': 'Verified retrieval'}
        (self.root / 'runtime/recovery.json').write_text(json.dumps(recovery))
        excluded = self.root / source['paths'][0]
        excluded.parent.mkdir()
        excluded.write_text('excluded binding source')
        self.runtime_record['source'] = source
        self.write_evidence()
        self.assert_rejected('binding-inventory')

    def test_every_required_check_must_resolve_once(self):
        self.packet['runtime_evidence']['checks'] = []
        self.assert_rejected('required-check')
        self.packet['runtime_evidence']['checks'] = [
            {'id': 'interaction', 'state_ids': ['success'], 'result': 'passed', 'record': 'runtime/interaction.json'}] * 2
        self.assert_rejected('runtime-check')

    def test_required_ids_must_be_nonempty_unique_strings(self):
        for ids in (['interaction', 'interaction'], [''], [{}], None):
            with self.subTest(ids=ids):
                self.packet['runtime_evidence']['required_checks'] = ids
                self.assert_rejected('runtime-evidence')

    def test_failed_required_check_never_becomes_an_omission(self):
        self.packet['runtime_evidence']['checks'][0]['result'] = 'failed'
        self.runtime_record['result'] = 'failed'
        self.packet['status'] = 'approved-with-degraded-evidence'
        self.packet['approval']['accepted_limitations'] = self.packet['limitations']
        self.packet['runtime_evidence']['not_required_reason'] = 'Try to omit failed proof'
        self.write_evidence()
        self.assert_rejected('required-check')

    def test_required_unavailable_check_needs_its_own_accepted_limit(self):
        check = self.packet['runtime_evidence']['checks'][0]
        check['result'] = self.runtime_record['result'] = 'unavailable'
        self.runtime_record['unavailable_reason'] = 'Backend unavailable'
        self.write_evidence()
        self.assert_rejected('required-check')
        self.packet['status'] = 'approved-with-degraded-evidence'
        self.packet['approval']['accepted_limitations'] = self.packet['limitations']
        check['limitation'] = 'Different unaccepted limitation'
        self.assert_rejected('required-check')

    def test_unavailable_source_is_only_allowed_in_accepted_degraded_scope(self):
        check = self.packet['runtime_evidence']['checks'][0]
        check['result'] = self.runtime_record['result'] = 'unavailable'
        check['limitation'] = self.packet['limitations'][0]
        self.runtime_record['unavailable_reason'] = 'Source unavailable; check was not executed'
        self.runtime_record['source'] = None
        self.write_evidence()
        self.assert_rejected('runtime-source')
        self.packet['status'] = 'approved-with-degraded-evidence'
        self.packet['approval']['accepted_limitations'] = self.packet['limitations']
        result, data = self.run_check()
        self.assertEqual(result.returncode, 0, data)

    def test_degraded_source_omission_must_be_explicit_null(self):
        check = self.packet['runtime_evidence']['checks'][0]
        check['result'] = self.runtime_record['result'] = 'unavailable'
        check['limitation'] = self.packet['limitations'][0]
        self.runtime_record['unavailable_reason'] = 'Source unavailable; check was not executed'
        del self.runtime_record['source']
        self.packet['status'] = 'approved-with-degraded-evidence'
        self.packet['approval']['accepted_limitations'] = self.packet['limitations']
        self.write_evidence()
        self.assert_rejected('runtime-source')

    def test_checks_require_known_states_and_valid_results(self):
        check = self.packet['runtime_evidence']['checks'][0]
        for states in ([], ['unknown'], ['success', 'success'], [False]):
            with self.subTest(states=states):
                check['state_ids'] = states
                self.assert_rejected('runtime-check')
        check['state_ids'] = ['success']
        check['result'] = 'omitted'
        self.assert_rejected('runtime-check')

    def test_runtime_record_identity_must_agree_with_check(self):
        for field, value in (('check_id', 'other'), ('state_ids', ['error']),
                             ('result', 'failed'), ('source_revision', 'other')):
            with self.subTest(field=field):
                old = self.runtime_record[field]
                self.runtime_record[field] = value
                self.write_evidence()
                self.assert_rejected('runtime-record')
                self.runtime_record[field] = old

    def test_runtime_records_need_all_seven_handoff_fields(self):
        for field in tuple(self.runtime_record['handoff']):
            with self.subTest(field=field):
                old = self.runtime_record['handoff'].pop(field)
                self.write_evidence()
                self.assert_rejected('runtime-record')
                self.runtime_record['handoff'][field] = old

    def test_runtime_check_records_are_binding_files(self):
        self.packet['runtime_evidence']['checks'][0]['record'] = 'runtime/missing.json'
        self.assert_rejected('binding-inventory')

    def test_malformed_manifest_and_runtime_records_fail_structurally(self):
        for path in ('design/manifest.json', 'runtime/interaction.json'):
            original = (self.root / path).read_text()
            for value in ('{', '[]'):
                with self.subTest(path=path, value=value):
                    (self.root / path).write_text(value)
                    self.packet['files'] = self.inventory()
                    self.assert_rejected('evidence-json')
            (self.root / path).write_text(original)
            self.packet['files'] = self.inventory()

    def test_changed_source_is_rejected_without_refreshing_hashes(self):
        (self.root / 'runtime/source/app.js').write_text('unapproved source change')
        self.assert_rejected('hash-mismatch')

    def test_binding_files_cannot_escape_inventory_via_excluded_paths(self):
        for area in ('references', 'design', 'runtime'):
            for excluded in ('node_modules', '.git', '__pycache__', '.DS_Store'):
                with self.subTest(area=area, excluded=excluded):
                    record, field = {
                        'references': (self.packet['targets'][0], 'path'),
                        'design': (self.manifest, 'computed_styles'),
                        'runtime': (self.runtime_record['source'], 'dependencies'),
                    }[area]
                    original = record[field]
                    relative = f'{area}/{excluded}/binding.html'
                    path = self.root / relative
                    path.parent.mkdir(parents=True, exist_ok=True)
                    path.write_text('approved bytes')
                    record[field] = relative
                    self.write_evidence()
                    self.run_check()
                    identity = digest(self.root / 'packet.json')
                    path.write_text('changed after approval')
                    result, data = self.run_check(expected_revision='v2.1', expected_hash=identity)
                    record[field] = original
                    self.write_evidence()
                    self.assertNotEqual(result.returncode, 0, 'Uninventoried binding file was accepted')
                    self.assertIn('binding-inventory', [issue['code'] for issue in data['errors']])
                    self.assertNotIn('expected-identity', [issue['code'] for issue in data['errors']])

    def test_unused_dependency_files_remain_excluded(self):
        dependency = self.root / 'runtime/node_modules/library/index.js'
        dependency.parent.mkdir(parents=True)
        dependency.write_text('generated dependency')
        result, data = self.run_check()
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertTrue(data['valid'])

    def test_cross_wired_state_references_are_rejected(self):
        self.packet['targets'].append(dict(self.packet['targets'][0], id='error-target', state='error'))
        self.packet['states'][0]['references'] = ['error-target']
        self.packet['states'][1]['references'] = ['desktop']
        self.assert_rejected('state-reference')

    def test_target_must_be_referenced_by_its_declared_state(self):
        self.packet['states'][0]['references'] = []
        self.assert_rejected('state-reference')

    def test_shared_capture_can_have_explicit_targets_per_state(self):
        self.packet['targets'].append(dict(self.packet['targets'][0], id='error-target', state='error'))
        self.packet['states'][1]['references'] = ['error-target']
        result, data = self.run_check()
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertTrue(data['valid'])

    def test_missing_reference_is_rejected(self):
        (self.root / 'references/desktop.jpg').unlink()
        self.assert_rejected('missing-file')

    def test_added_current_source_is_rejected(self):
        (self.root / 'runtime/source/extra.js').write_text('new dependency')
        self.assert_rejected('inventory-mismatch')

    def test_historical_files_are_preserved_but_not_current(self):
        h = self.root / 'history/pilot'
        h.mkdir(parents=True)
        (h / 'packet.json').write_text('old unrelated format')
        historical = (h / 'packet.json').read_bytes()
        result, data = self.run_check()
        self.assertEqual(result.returncode, 0, data)
        self.assertEqual((h / 'packet.json').read_bytes(), historical)

    def test_history_cannot_be_a_binding_target(self):
        self.packet['targets'][0]['path'] = 'history/old.jpg'
        self.assert_rejected('target-path')

    def test_pending_status_is_not_ready(self):
        self.packet['status'] = 'required-pending'
        self.assert_rejected('status')

    def test_approval_and_design_source_revisions_must_match(self):
        for field in ['approval', 'design_source']:
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
        (self.root / 'runtime/source/link.js').symlink_to(outside)
        self.assert_rejected('symlink')

    def test_missing_canonical_documents_are_rejected(self):
        self.packet['documents']['screen_index'] = 'elsewhere.md'
        self.assert_rejected('documents')

    def test_degraded_evidence_requires_explicit_acceptance(self):
        self.packet['runtime_evidence']['checks'][0]['result'] = 'unavailable'
        self.packet['runtime_evidence']['checks'][0]['limitation'] = self.packet['limitations'][0]
        self.runtime_record['result'] = 'unavailable'
        self.runtime_record['unavailable_reason'] = 'Backend unavailable; interaction check cannot run'
        self.write_evidence()
        self.packet['status'] = 'approved-with-degraded-evidence'
        self.assert_rejected('degraded-approval')
        self.packet['approval']['accepted_limitations'] = self.packet['limitations']
        result, data = self.run_check()
        self.assertEqual(result.returncode, 0, data)

    def test_scoped_references_only_needs_no_runtime_source(self):
        self.packet['design_source']['medium'] = 'references-only'
        self.manifest = {'revision': 'v2.1', 'provenance': 'design/provenance.json', 'omission': {
            'reason': 'Image-only direction explicitly requested',
            'decision': 'User requested image references without interactive exploration',
        }}
        self.packet['runtime_evidence'] = {'required_checks': [], 'checks': [],
                                          'not_required_reason': 'Image references only; no behavior decision in scope'}
        self.write_evidence()
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
        for value in ['{', '[]', '{"schema_version":2,"targets":false}']:
            with self.subTest(value=value):
                (self.root / 'packet.json').write_text(value)
                r = subprocess.run(['python3', str(SCRIPT), 'check', str(self.root)], capture_output=True, text=True)
                self.assertNotEqual(r.returncode, 0)
                self.assertFalse(json.loads(r.stdout)['valid'])
                self.assertNotIn('Traceback', r.stderr)


if __name__ == '__main__':
    unittest.main()
