# File decisions for the upstream delta

Pinned fork: `410d0fc3516e6c67931fd9de5642f7f6363fc7a4`. Pinned upstream: `8ca22dba9a94f28898bbce59f2537ff4d87c747d`.

Every one of the 100 upstream-changed paths is assigned a proposed plan step. Fork-only content remains subject to the preservation inventory in the comparison. Additional integration edits may be needed in fork-owned references, tests and diagnostic metadata.

| Upstream path | Change | Fork also changed | Text conflict | Plan step | Decision |
| --- | --- | --- | --- | --- | --- |
| `.claude-plugin/marketplace.json` | M | No | No | 2 | Adopt upstream platform/manifest/documentation changes and their regression checks |
| `.claude-plugin/plugin.json` | M | No | No | 2 | Adopt upstream platform/manifest/documentation changes and their regression checks |
| `.codex-plugin/plugin.json` | M | No | No | 2 | Adopt upstream platform/manifest/documentation changes and their regression checks |
| `.cursor-plugin/plugin.json` | M | No | No | 2 | Adopt upstream platform/manifest/documentation changes and their regression checks |
| `.devin-plugin/plugin.json` | A | No | No | 2 | Adopt upstream platform/manifest/documentation changes and their regression checks |
| `.github/ISSUE_TEMPLATE/diagnosis_report.md` | A | No | No | 5 | Adopt diagnostic; integrate model routing, slot limits and real Codex metadata |
| `.github/ISSUE_TEMPLATE/platform_support.md` | M | No | No | 2 | Adopt upstream platform/manifest/documentation changes and their regression checks |
| `.gitignore` | M | Yes | No | 2 | Union Python ignores with fork runtime/GSD/worktree ignores |
| `.hermes-plugin/__init__.py` | A | No | No | 2 | Adopt upstream platform/manifest/documentation changes and their regression checks |
| `.hermes-plugin/plugin.yaml` | A | No | No | 2 | Adopt upstream platform/manifest/documentation changes and their regression checks |
| `.kimi-plugin/plugin.json` | M | No | No | 2 | Adopt upstream platform/manifest/documentation changes and their regression checks |
| `.muse-plugin/marketplace.json` | A | No | No | 2 | Adopt upstream platform/manifest/documentation changes and their regression checks |
| `.muse-plugin/plugin.json` | A | No | No | 2 | Adopt upstream platform/manifest/documentation changes and their regression checks |
| `.opencode/INSTALL.md` | M | No | No | 2 | Adopt upstream platform/manifest/documentation changes and their regression checks |
| `.opencode/plugins/superpowers.js` | M | No | No | 2 | Adopt upstream platform/manifest/documentation changes and their regression checks |
| `.version-bump.json` | M | No | No | 2 | Adopt upstream platform/manifest/documentation changes and their regression checks |
| `AGENTS.md` | T | No | No | 2 | Adopt regular-file contributor guidelines; preserve applicable external Gamarsoft policy |
| `CLAUDE.md` | D | No | No | 2 | Accept deletion; AGENTS.md becomes canonical |
| `CODE_OF_CONDUCT.md` | M | No | No | 2 | Adopt upstream platform/manifest/documentation changes and their regression checks |
| `README.md` | M | Yes | Yes | 6 | Combine upstream releases/platforms with fork workflow and evaluation documentation |
| `RELEASE-NOTES.md` | M | Yes | Yes | 6 | Combine upstream releases/platforms with fork workflow and evaluation documentation |
| `docs/README.opencode.md` | M | Yes | No | 2 | Adopt upstream platform/manifest/documentation changes and their regression checks |
| `docs/porting-to-a-new-harness.md` | M | No | No | 2 | Adopt upstream platform/manifest/documentation changes and their regression checks |
| `docs/superpowers/plans/2026-07-30-codex-efficiency-fixes.md` | A | No | No | 6 | Import dated upstream design/plan history unchanged; not current execution authority |
| `docs/superpowers/plans/2026-08-06-hermes-version-bump-wiring.md` | A | No | No | 6 | Import dated upstream design/plan history unchanged; not current execution authority |
| `docs/superpowers/plans/2026-08-27-diagnosing-superpowers.md` | A | No | No | 6 | Import dated upstream design/plan history unchanged; not current execution authority |
| `docs/superpowers/specs/2026-07-30-codex-efficiency-fixes-design.md` | A | No | No | 6 | Import dated upstream design/plan history unchanged; not current execution authority |
| `docs/superpowers/specs/2026-08-05-hermes-version-bump-wiring-design.md` | A | No | No | 6 | Import dated upstream design/plan history unchanged; not current execution authority |
| `docs/superpowers/specs/2026-08-27-diagnosing-superpowers-design.md` | A | No | No | 6 | Import dated upstream design/plan history unchanged; not current execution authority |
| `docs/testing.md` | M | Yes | No | 6 | Combine upstream releases/platforms with fork workflow and evaluation documentation |
| `gemini-extension.json` | M | No | No | 2 | Adopt upstream platform/manifest/documentation changes and their regression checks |
| `hooks/session-start` | M | No | No | 2 | Adopt upstream platform/manifest/documentation changes and their regression checks |
| `index.js` | A | No | No | 2 | Adopt upstream platform/manifest/documentation changes and their regression checks |
| `package.json` | M | No | No | 2 | Adopt upstream platform/manifest/documentation changes and their regression checks |
| `scripts/bump-version.sh` | M | No | No | 2 | Adopt upstream platform/manifest/documentation changes and their regression checks |
| `scripts/sync-to-codex-plugin.sh` | M | No | No | 5 | Adopt exclusions/test changes; audit all new platform directories and avoid publishing |
| `skills/brainstorming/SKILL.md` | M | Yes | Yes | 4 | Retain fork workflow authority; integrate compatible upstream behavior per comparison matrix |
| `skills/brainstorming/visual-companion.md` | M | Yes | Yes | 5 | Keep fork visual behavior; apply upstream interpreter/backgrounding guidance |
| `skills/diagnosing-superpowers/SKILL.md` | A | No | No | 5 | Adopt diagnostic; integrate model routing, slot limits and real Codex metadata |
| `skills/diagnosing-superpowers/prompts/analyst-common.md` | A | No | No | 5 | Adopt diagnostic; integrate model routing, slot limits and real Codex metadata |
| `skills/diagnosing-superpowers/prompts/cost-and-time.md` | A | No | No | 5 | Adopt diagnostic; integrate model routing, slot limits and real Codex metadata |
| `skills/diagnosing-superpowers/prompts/plan-adherence.md` | A | No | No | 5 | Adopt diagnostic; integrate model routing, slot limits and real Codex metadata |
| `skills/diagnosing-superpowers/prompts/quality-evidence.md` | A | No | No | 5 | Adopt diagnostic; integrate model routing, slot limits and real Codex metadata |
| `skills/diagnosing-superpowers/prompts/repeated-work.md` | A | No | No | 5 | Adopt diagnostic; integrate model routing, slot limits and real Codex metadata |
| `skills/diagnosing-superpowers/prompts/request-conflicts.md` | A | No | No | 5 | Adopt diagnostic; integrate model routing, slot limits and real Codex metadata |
| `skills/diagnosing-superpowers/prompts/scrub-audit.md` | A | No | No | 5 | Adopt diagnostic; integrate model routing, slot limits and real Codex metadata |
| `skills/diagnosing-superpowers/prompts/scrub.md` | A | No | No | 5 | Adopt diagnostic; integrate model routing, slot limits and real Codex metadata |
| `skills/diagnosing-superpowers/prompts/similar-session.md` | A | No | No | 5 | Adopt diagnostic; integrate model routing, slot limits and real Codex metadata |
| `skills/diagnosing-superpowers/prompts/skill-timeline.md` | A | No | No | 5 | Adopt diagnostic; integrate model routing, slot limits and real Codex metadata |
| `skills/diagnosing-superpowers/prompts/stumbles.md` | A | No | No | 5 | Adopt diagnostic; integrate model routing, slot limits and real Codex metadata |
| `skills/diagnosing-superpowers/references/context-safety.md` | A | No | No | 5 | Adopt diagnostic; integrate model routing, slot limits and real Codex metadata |
| `skills/diagnosing-superpowers/references/github-issues.md` | A | No | No | 5 | Adopt diagnostic; integrate model routing, slot limits and real Codex metadata |
| `skills/diagnosing-superpowers/references/redaction-policy.md` | A | No | No | 5 | Adopt diagnostic; integrate model routing, slot limits and real Codex metadata |
| `skills/diagnosing-superpowers/references/session-discovery.md` | A | No | No | 5 | Adopt diagnostic; integrate model routing, slot limits and real Codex metadata |
| `skills/diagnosing-superpowers/templates/bundle-README.md` | A | No | No | 5 | Adopt diagnostic; integrate model routing, slot limits and real Codex metadata |
| `skills/diagnosing-superpowers/templates/case.md` | A | No | No | 5 | Adopt diagnostic; integrate model routing, slot limits and real Codex metadata |
| `skills/diagnosing-superpowers/templates/issue.md` | A | No | No | 5 | Adopt diagnostic; integrate model routing, slot limits and real Codex metadata |
| `skills/diagnosing-superpowers/templates/report.md` | A | No | No | 5 | Adopt diagnostic; integrate model routing, slot limits and real Codex metadata |
| `skills/executing-plans/SKILL.md` | M | Yes | Yes | 4 | Retain fork workflow authority; integrate compatible upstream behavior per comparison matrix |
| `skills/executing-plans/scripts/task-done` | A | No | No | 3 | Combine upstream identity/range/portability fixes with fork helper API and evidence checks |
| `skills/executing-plans/scripts/task-start` | A | No | No | 3 | Combine upstream identity/range/portability fixes with fork helper API and evidence checks |
| `skills/finishing-a-development-branch/SKILL.md` | M | Yes | Yes | 4 | Retain fork workflow authority; integrate compatible upstream behavior per comparison matrix |
| `skills/requesting-code-review/SKILL.md` | M | Yes | Yes | 4 | Retain fork workflow authority; integrate compatible upstream behavior per comparison matrix |
| `skills/requesting-code-review/code-reviewer.md` | M | Yes | Yes | 4 | Retain fork workflow authority; integrate compatible upstream behavior per comparison matrix |
| `skills/subagent-driven-development/SKILL.md` | M | Yes | Yes | 4 | Retain fork workflow authority; integrate compatible upstream behavior per comparison matrix |
| `skills/subagent-driven-development/implementer-prompt.md` | M | Yes | Yes | 4 | Retain fork workflow authority; integrate compatible upstream behavior per comparison matrix |
| `skills/subagent-driven-development/re-review-prompt.md` | M | Yes | Yes | 4 | Retain fork workflow authority; integrate compatible upstream behavior per comparison matrix |
| `skills/subagent-driven-development/scripts/review-package` | M | Yes | Yes | 3 | Combine upstream identity/range/portability fixes with fork helper API and evidence checks |
| `skills/subagent-driven-development/scripts/sdd-workspace` | M | No | No | 3 | Combine upstream identity/range/portability fixes with fork helper API and evidence checks |
| `skills/subagent-driven-development/scripts/task-brief` | M | Yes | Yes | 3 | Combine upstream identity/range/portability fixes with fork helper API and evidence checks |
| `skills/subagent-driven-development/task-reviewer-prompt.md` | M | Yes | Yes | 4 | Retain fork workflow authority; integrate compatible upstream behavior per comparison matrix |
| `skills/systematic-debugging/root-cause-tracing.md` | M | No | No | 5 | Adopt interpreter/Windows portability improvements; preserve fork guidance |
| `skills/test-driven-development/SKILL.md` | M | Yes | No | 4 | Reconcile full-suite wording with fork finishing ownership; disclose all observed failures |
| `skills/using-superpowers/SKILL.md` | M | Yes | Yes | 4 | Retain fork workflow authority; integrate compatible upstream behavior per comparison matrix |
| `skills/using-superpowers/references/claude-code-tools.md` | A | No | No | 4 | Adopt harness mapping; keep nested Claude controller opt-in and preserve fork orchestration |
| `skills/using-superpowers/references/codex-tools.md` | M | Yes | Yes | 4 | Retain fork workflow authority; integrate compatible upstream behavior per comparison matrix |
| `skills/using-superpowers/references/hermes-tools.md` | A | No | No | 4 | Adopt harness mapping; keep nested Claude controller opt-in and preserve fork orchestration |
| `skills/using-superpowers/references/muse-tools.md` | A | No | No | 4 | Adopt harness mapping; keep nested Claude controller opt-in and preserve fork orchestration |
| `skills/writing-plans/SKILL.md` | M | Yes | Yes | 4 | Keep fork contracts/readiness; add Review Focus and proportion self-review |
| `skills/writing-plans/plan-document-reviewer-prompt.md` | D | Yes | No | 4 | Keep deleted; preserve distinct fork readiness reviewer |
| `skills/writing-skills/SKILL.md` | M | Yes | No | 5 | Adopt interpreter/Windows portability improvements; preserve fork guidance |
| `skills/writing-skills/render-graphs.js` | M | No | No | 5 | Adopt interpreter/Windows portability improvements; preserve fork guidance |
| `tests/claude-code/run-skill-tests.sh` | M | Yes | Yes | 6 | Union maintained tests, including fork contracts and new native helper tests |
| `tests/claude-code/test-executing-plans-scripts.sh` | A | No | No | 3 | Combine upstream identity/range/portability fixes with fork helper API and evidence checks |
| `tests/claude-code/test-sdd-workspace.sh` | M | Yes | Yes | 3 | Combine upstream identity/range/portability fixes with fork helper API and evidence checks |
| `tests/codex-plugin-sync/test-sync-to-codex-plugin.sh` | M | No | No | 5 | Adopt exclusions/test changes; audit all new platform directories and avoid publishing |
| `tests/devin/test-devin-plugin.sh` | A | No | No | 2 | Adopt upstream platform/manifest/documentation changes and their regression checks |
| `tests/diagnosing-superpowers/test-skill-structure.sh` | A | No | No | 5 | Adopt diagnostic; integrate model routing, slot limits and real Codex metadata |
| `tests/hermes/__init__.py` | A | No | No | 2 | Adopt upstream platform/manifest/documentation changes and their regression checks |
| `tests/hermes/conftest.py` | A | No | No | 2 | Adopt upstream platform/manifest/documentation changes and their regression checks |
| `tests/hermes/test_bootstrap.py` | A | No | No | 2 | Adopt upstream platform/manifest/documentation changes and their regression checks |
| `tests/hermes/test_plugin.py` | A | No | No | 2 | Adopt upstream platform/manifest/documentation changes and their regression checks |
| `tests/opencode/run-tests.sh` | M | No | No | 2 | Adopt upstream platform/manifest/documentation changes and their regression checks |
| `tests/opencode/test-bootstrap-caching.mjs` | M | No | No | 2 | Adopt upstream platform/manifest/documentation changes and their regression checks |
| `tests/opencode/test-session-bootstrap.mjs` | A | No | No | 2 | Adopt upstream platform/manifest/documentation changes and their regression checks |
| `tests/opencode/test-session-bootstrap.sh` | A | No | No | 2 | Adopt upstream platform/manifest/documentation changes and their regression checks |
| `tests/opencode/test-skill-registration.mjs` | A | No | No | 2 | Adopt upstream platform/manifest/documentation changes and their regression checks |
| `tests/opencode/test-skill-registration.sh` | A | No | No | 2 | Adopt upstream platform/manifest/documentation changes and their regression checks |
| `tests/version-bump/test-bump-version.sh` | A | No | No | 2 | Adopt upstream platform/manifest/documentation changes and their regression checks |
| `tests/writing-skills/test-render-graphs.sh` | A | No | No | 5 | Adopt interpreter/Windows portability improvements; preserve fork guidance |
