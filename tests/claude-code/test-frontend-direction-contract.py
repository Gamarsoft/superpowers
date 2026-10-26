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

    def test_design_knowledge_is_available_offline(self):
        # Packaging capability: follow reachable local links, not ignored eval paths.
        base = ROOT / 'skills/frontend-direction'
        pending = [base / 'SKILL.md']
        seen = set()
        while pending:
            path = pending.pop().resolve()
            if path in seen or not path.is_file():
                continue
            seen.add(path)
            for target in re.findall(r'\]\(([^)]+)\)', path.read_text()):
                if '://' not in target and not target.startswith('#'):
                    resolved = (path.parent / target.split('#')[0]).resolve()
                    if resolved.suffix == '.md' and resolved.is_relative_to(ROOT.resolve()):
                        pending.append(resolved)
        for name in ('refactoring-ui.md', 'design-everyday-things.md'):
            resource = base / 'references/design-knowledge' / name
            self.assertIn(resource.resolve(), seen, f'Offline source unreachable: {name}')
        self.assertTrue((base / 'references/design-knowledge/LICENSE.txt').is_file())

    def test_exploration_resource_is_reachable_from_entry(self):
        skill = (ROOT / 'skills/frontend-direction/SKILL.md').read_text()
        # Ensures the supporting procedure ships and can be loaded, not how an agent behaves.
        target = 'references/visual-exploration.md'
        self.assertIn(target, skill)
        self.assertTrue((ROOT / 'skills/frontend-direction' / target).is_file())

    def test_paper_operating_resources_are_reachable(self):
        # Packaging only; fresh actor campaigns establish policy behavior.
        base = ROOT / 'skills/frontend-direction'
        entry = (base / 'SKILL.md').read_text()
        for name in ('paper-workflow.md', 'paper-library.md'):
            with self.subTest(resource=name):
                self.assertIn('references/' + name, entry)
                self.assertTrue((base / 'references' / name).is_file())
        consumer = (ROOT / 'skills/implementing-frontend-design/SKILL.md').read_text()
        self.assertIn('../frontend-direction/references/paper-library.md', consumer)

if __name__ == '__main__':
    unittest.main()
