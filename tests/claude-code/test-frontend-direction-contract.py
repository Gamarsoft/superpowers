#!/usr/bin/env python3
"""Packaging/reference checks; behavioral evidence lives in the evaluation report."""
import re
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]

class FrontendResources(unittest.TestCase):
    def test_upload_authoring_is_not_discoverable(self):
        self.assertFalse((ROOT / 'skills/creating-chatgpt-image-upload-packs/SKILL.md').exists())

    def test_implementation_replacement_is_discoverable(self):
        self.assertTrue((ROOT / 'skills/implementing-frontend-design/SKILL.md').is_file())
        self.assertTrue((ROOT / 'skills/implementing-frontend-design/agents/openai.yaml').is_file())
        self.assertFalse((ROOT / 'skills/gsd-frontend-design/SKILL.md').exists())

    def test_frontend_local_markdown_links_resolve(self):
        base = ROOT / 'skills/frontend-direction'
        for path in list(base.rglob('*.md')) + list((ROOT / 'skills/implementing-frontend-design').rglob('*.md')):
            for target in re.findall(r'\]\(([^)]+)\)', path.read_text()):
                if '://' in target or target.startswith('#'):
                    continue
                target = target.split('#')[0]
                with self.subTest(source=str(path.relative_to(ROOT)), target=target):
                    self.assertTrue((path.parent / target).exists(), target)

    def test_exploration_resource_is_reachable_from_entry(self):
        skill = (ROOT / 'skills/frontend-direction/SKILL.md').read_text()
        # Ensures the supporting procedure ships and can be loaded, not how an agent behaves.
        target = 'references/visual-exploration.md'
        self.assertIn(target, skill)
        self.assertTrue((ROOT / 'skills/frontend-direction' / target).is_file())

if __name__ == '__main__':
    unittest.main()
