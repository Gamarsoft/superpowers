# Decisions for all 51 upstream paths

Date: 2026-10-13. Proposed resolutions, not an applied merge. See [comparison](comparison.md) for policy rationale and verification limits.

`Both` means changed between the common ancestor and each pinned tip. `Conflict` comes from the isolated Git merge preview. A clean textual merge does not prove behavioral compatibility.

| Upstream path | Both | Conflict | Proposed treatment | Reason |
| --- | --- | --- | --- | --- |
| `.antigravity-plugin/plugin.json` | no | no | Adopt platform group | Native Antigravity support and its complete packaging/test dependencies. Validate fork discovery separately from upstream results. |
| `.claude-plugin/marketplace.json` | no | no | Adopt metadata | Align release versions when the hybrid is integrated; record fork-specific behavior in its release notes. |
| `.claude-plugin/plugin.json` | no | no | Adopt metadata | Align release versions when the hybrid is integrated; record fork-specific behavior in its release notes. |
| `.codex-plugin/plugin.json` | no | no | Adopt metadata | Align release versions when the hybrid is integrated; record fork-specific behavior in its release notes. |
| `.cursor-plugin/plugin.json` | no | no | Adopt metadata | Align release versions when the hybrid is integrated; record fork-specific behavior in its release notes. |
| `.devin-plugin/plugin.json` | no | no | Adopt metadata | Align release versions when the hybrid is integrated; record fork-specific behavior in its release notes. |
| `.hermes-plugin/__init__.py` | no | no | Adopt | Pass frontmatter descriptions at registration and test every fork skill, preserving existing layout handling. |
| `.hermes-plugin/plugin.yaml` | no | no | Adopt metadata | Align release versions when the hybrid is integrated; record fork-specific behavior in its release notes. |
| `.kimi-plugin/plugin.json` | no | no | Adopt metadata | Align release versions when the hybrid is integrated; record fork-specific behavior in its release notes. |
| `.muse-plugin/marketplace.json` | no | no | Adopt metadata | Align release versions when the hybrid is integrated; record fork-specific behavior in its release notes. |
| `.muse-plugin/plugin.json` | yes | no | Reconcile | Update version without replacing the fork-expanded skill inventory. |
| `.opencode/INSTALL.md` | no | no | Reconcile docs | Update upstream release examples; retain fork workflow instructions and verify URLs describe the intended distribution. |
| `.version-bump.json` | no | no | Adopt platform group | Native Antigravity support and its complete packaging/test dependencies. Validate fork discovery separately from upstream results. |
| `README.md` | yes | yes | Reconcile docs | Take corrected Antigravity bootstrap explanation; describe the chosen hybrid, retain written specs and custom workflow inventory. |
| `RELEASE-NOTES.md` | yes | yes | Reconcile docs | Preserve upstream history and fork history; explain which v7 brainstorming policies differ in this fork. |
| `assets/antigravity-logo.png` | no | no | Adopt platform group | Native Antigravity support and its complete packaging/test dependencies. Validate fork discovery separately from upstream results. |
| `docs/README.opencode.md` | yes | no | Reconcile docs | Update upstream release examples; retain fork workflow instructions and verify URLs describe the intended distribution. |
| `docs/porting-to-a-new-harness.md` | no | no | Adopt | Correct platform/bootstrap documentation to match the imported manifest and hooks. |
| `docs/superpowers/plans/2026-10-06-antigravity-marketplace.md` | no | no | Retain historical docs | Preserve upstream design provenance in an ancestry-preserving integration; these documents do not authorize fork policy changes. |
| `docs/superpowers/specs/2026-10-05-brainstorming-rebuild-design.md` | no | no | Retain historical docs | Preserve upstream design provenance in an ancestry-preserving integration; these documents do not authorize fork policy changes. |
| `docs/superpowers/specs/2026-10-06-antigravity-marketplace-design.md` | no | no | Retain historical docs | Preserve upstream design provenance in an ancestry-preserving integration; these documents do not authorize fork policy changes. |
| `docs/windows/polyglot-hooks.md` | no | no | Adopt | Correct platform/bootstrap documentation to match the imported manifest and hooks. |
| `gemini-extension.json` | no | no | Adopt metadata | Align release versions when the hybrid is integrated; record fork-specific behavior in its release notes. |
| `hooks/run-hook.cmd` | no | no | Adopt | Broken-PATH bootstrap and Windows discovery/exit handling, with regressions. Unix PATH case reproduced; Windows runtime untested here. |
| `hooks/session-start` | no | no | Adopt | Broken-PATH bootstrap and Windows discovery/exit handling, with regressions. Unix PATH case reproduced; Windows runtime untested here. |
| `package.json` | no | no | Adopt metadata | Align release versions when the hybrid is integrated; record fork-specific behavior in its release notes. |
| `scripts/bump-version.sh` | no | no | Adopt | Avoid version-audit matches inside longer numbers; import matching coverage. |
| `scripts/render-antigravity-logo.sh` | no | no | Adopt platform group | Native Antigravity support and its complete packaging/test dependencies. Validate fork discovery separately from upstream results. |
| `scripts/sync-to-codex-plugin.sh` | yes | no | Reconcile | Add Antigravity manifest/logo exclusions while retaining existing fork exclusion and packaging logic. |
| `skills/brainstorming/SKILL.md` | yes | yes | Adapt behavior | Use intent discovery, attributed defaults and useful playback inside existing research/spec/frontend/routing contracts. Evaluate the hybrid. |
| `skills/brainstorming/builder-check-prompt.md` | no | no | Adapt and consolidate | Fold the consequential-unanswered-question lens into the existing spec reviewer. Do not activate an additional review pass or leave competing dispatch instructions. |
| `skills/brainstorming/scripts/server.cjs` | yes | no | Reconcile | Apply literal replacement callback to the fork server without replacing custom visual-companion behavior. |
| `skills/brainstorming/spec-document-reviewer-prompt.md` | yes | yes | Keep fork and extend | Reject upstream deletion. Preserve stage-specific readiness, research, frontend and adapter checks; add builder lens in the same review. |
| `skills/executing-plans/scripts/task-done` | yes | yes | Keep fork | Silent output already handled. Preserve interpreter-safe invocation and verification-passed wording; do not restore automatic completion claims. |
| `skills/requesting-code-review/SKILL.md` | yes | yes | Keep fork | Upstream changes an example absent from the fork. Preserve exact supplied review ranges, workflow ownership and configured roles. |
| `skills/subagent-driven-development/scripts/sdd-workspace` | yes | no | Reconcile | Import create-only gitignore and physical-root spelling. Keep fork refusal to adopt foreign/unidentifiable markerless ledgers. |
| `skills/systematic-debugging/SKILL.md` | yes | no | Reconcile | Import presence-only environment diagnostics and preserve unrelated fork guidance. |
| `tests/antigravity/test-antigravity-tools.sh` | no | no | Adopt platform group | Native Antigravity support and its complete packaging/test dependencies. Validate fork discovery separately from upstream results. |
| `tests/antigravity/test-logo.sh` | no | no | Adopt platform group | Native Antigravity support and its complete packaging/test dependencies. Validate fork discovery separately from upstream results. |
| `tests/antigravity/test-plugin-manifest.sh` | no | no | Adopt platform group | Native Antigravity support and its complete packaging/test dependencies. Validate fork discovery separately from upstream results. |
| `tests/brainstorm-server/lifecycle.test.js` | no | no | Adopt | Avoid login-shell rewriting of the test environment. |
| `tests/brainstorm-server/server.test.js` | yes | no | Reconcile | Add literal-token regression and exitCode cleanup fix; retain fork-specific companion tests and port handling. |
| `tests/claude-code/test-executing-plans-scripts.sh` | yes | yes | Reconcile | Take path portability correction; retain existing silent-output and stripped-permission tests and verification-passed assertions. |
| `tests/claude-code/test-sdd-workspace.sh` | yes | yes | Reconcile | Combine upstream gitignore/path tests with fork multi-task, review-range, dirty-worktree and foreign-ledger tests. |
| `tests/codex-plugin-sync/test-sync-to-codex-plugin.sh` | no | no | Reconcile | Add Antigravity manifest/logo exclusions while retaining existing fork exclusion and packaging logic. |
| `tests/hermes/conftest.py` | no | no | Adopt | Pass frontmatter descriptions at registration and test every fork skill, preserving existing layout handling. |
| `tests/hermes/test_plugin.py` | no | no | Adopt | Pass frontmatter descriptions at registration and test every fork skill, preserving existing layout handling. |
| `tests/hooks/test-run-hook-cmd-windows.sh` | no | no | Adopt | Broken-PATH bootstrap and Windows discovery/exit handling, with regressions. Unix PATH case reproduced; Windows runtime untested here. |
| `tests/hooks/test-session-start.sh` | no | no | Adopt | Broken-PATH bootstrap and Windows discovery/exit handling, with regressions. Unix PATH case reproduced; Windows runtime untested here. |
| `tests/version-bump/test-bump-version.sh` | no | no | Adopt | Avoid version-audit matches inside longer numbers; import matching coverage. |
| `tests/writing-skills/test-render-graphs.sh` | no | no | Adopt | Use actual Node executable so the empty-PATH test also works with version-manager shims. |

Any brainstorming adaptation must also reconcile the fork-only guided-choice protocol, question bank, framing/spec templates and spec-review checklist. These are not in the upstream delta but contain behavior that would otherwise contradict a changed entrypoint.

The installed `choose-workflow` skill is outside this repository delta. If the recommended written-spec and route contracts remain, no routing-policy update is needed there merely because the upstream version changes. Recheck it if a separate shortcut or spike policy is later approved.
