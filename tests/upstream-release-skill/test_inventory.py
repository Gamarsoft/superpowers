"""Exercise release inventory against real disposable Git histories."""

import json
import os
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest


SKILL = Path(os.environ.get('UPSTREAM_SKILL_DIR',
    Path(__file__).resolve().parents[2] / '.agents/skills/integrating-superpowers-upstream'))
SCRIPT = SKILL / 'scripts/release_inventory.py'


class InventoryTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory()
        self.addCleanup(self.tmp.cleanup)
        self.repo = Path(self.tmp.name)
        self.git('init', '-q')
        self.git('config', 'user.name', 'Fixture')
        self.git('config', 'user.email', 'fixture@example.invalid')
        self.git('config', 'commit.gpgsign', 'false')
        self.git('config', 'tag.gpgsign', 'false')
        self.write('keep.txt', 'base\n')
        self.write('old name.md', 'a stable paragraph\n' * 10)
        self.write('obsolete.md', 'history\n')
        self.commit('base')
        self.base = self.git('rev-parse', 'HEAD')
        self.git('tag', '-a', 'v1', '-m', 'base')
        self.git('checkout', '-qb', 'upstream')
        self.git('mv', 'old name.md', 'new name.md')
        self.git('rm', '-q', 'obsolete.md')
        self.write('keep.txt', 'upstream\n')
        self.write('added.txt', 'new\n')
        self.commit('release')
        self.target = self.git('rev-parse', 'HEAD')
        self.git('tag', '-a', 'v2', '-m', 'release')
        self.git('checkout', '-qb', 'fork', self.base)
        self.write('old name.md', 'fork paragraph\n' * 10)
        self.write('fork-only.md', 'local decision\n')
        self.commit('fork changes')

    def git(self, *args):
        return subprocess.check_output(
            ['git', '-c', 'core.fsmonitor=false', '-C', str(self.repo), *args],
            text=True).strip()

    def write(self, name, contents):
        (self.repo / name).write_text(contents)

    def commit(self, message):
        self.git('add', '--all')
        self.git('commit', '-qm', message)

    def inventory(self, base='v1', target='v2'):
        return subprocess.run(
            [sys.executable, str(SCRIPT), '--repo', str(self.repo),
             '--base', base, '--fork', 'HEAD', '--target', target],
            text=True, capture_output=True)

    def test_pins_annotated_tags_and_covers_renames_deletions_and_overlap(self):
        result = self.inventory()
        self.assertEqual(result.returncode, 0, result.stderr)
        inventory = json.loads(result.stdout)
        self.assertEqual(inventory['reviewed_base'], self.base)
        self.assertEqual(inventory['target'], self.target)
        files = {f['path']: f for f in inventory['files']}
        self.assertEqual(set(files), {'added.txt', 'keep.txt', 'new name.md', 'obsolete.md'})
        self.assertEqual(files['obsolete.md']['status'], 'D')
        self.assertEqual(files['new name.md']['old_path'], 'old name.md')
        self.assertEqual(files['new name.md']['fork_changed_paths'], ['old name.md'])
        self.assertEqual(files['keep.txt']['fork_changed_paths'], [])
        self.assertEqual(inventory['merge_bases'], [self.base])

    def test_observation_preserves_dirty_index_and_worktree(self):
        self.write('keep.txt', 'personal staged edit\n')
        self.git('add', 'keep.txt')
        self.write('keep.txt', 'personal unstaged edit\n')
        self.write('untracked.txt', 'keep this\n')
        before = [self.git('status', '--porcelain=v1'), self.git('diff'),
                  self.git('diff', '--cached'), self.git('rev-parse', 'HEAD')]
        result = self.inventory()
        self.assertEqual(result.returncode, 0, result.stderr)
        after = [self.git('status', '--porcelain=v1'), self.git('diff'),
                 self.git('diff', '--cached'), self.git('rev-parse', 'HEAD')]
        self.assertEqual(before, after)

    def test_rejects_unknown_or_reversed_release_baseline(self):
        for base, target in [('unknown', 'v2'), ('v2', 'v1')]:
            with self.subTest(base=base, target=target):
                result = self.inventory(base, target)
                self.assertNotEqual(result.returncode, 0)
                self.assertEqual(result.stdout, '')
                self.assertIn('inventory:', result.stderr)

    def test_ours_ancestry_does_not_erase_explicit_reviewed_delta(self):
        self.git('merge', '-q', '--no-ff', '-s', 'ours', '-m', 'record ancestry', 'v2')
        result = self.inventory()
        self.assertEqual(result.returncode, 0, result.stderr)
        inventory = json.loads(result.stdout)
        self.assertTrue(inventory['target_is_ancestor_of_fork'])
        self.assertEqual(inventory['merge_bases'], [self.target])
        self.assertEqual(len(inventory['files']), 4)
        self.assertEqual(inventory['reviewed_base'], self.base)


if __name__ == '__main__':
    unittest.main()
