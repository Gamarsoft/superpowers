# Selective integration record

Base: `7d5c52b7e42936c6f186deac892e1c781c1341b6` (`gamarsoft`).
Upstream v7.0.0: `bb92a77741419a4ab5f06e711a283343f1ada0c3`.
Branch: `codex/integrate-upstream-v7.0.0`, in the base checkout, no worktree.

The comparison and 51-path decision table remain unchanged approved inputs.
`resolved-paths.json` records the applied content identities for every upstream
path. The builder prompt is consolidated into the existing reviewer and removed;
the fork's task-done and requesting-code-review contents are retained. Six
fork-only brainstorming references were reconciled with the adapted entrypoint.
All four Codex role source files and installed role settings remain unchanged.

## Focused evidence before the final review

Commands ran against the integrated working files. Logs are in the ignored
plan workspace `.superpowers/sdd/2026-10-13-upstream-v7.0.0/`.

| Command | Result |
| --- | --- |
| `bash tests/claude-code/test-sdd-workspace.sh` | PASS, including custom ignore preservation and fork legacy-ledger/identity guards |
| `bash tests/claude-code/test-executing-plans-scripts.sh` | PASS, including silent output and stripped executable permissions |
| `bash tests/hooks/test-session-start.sh` | PASS, including broken PATH and bootstrap output shapes |
| `bash tests/version-bump/test-bump-version.sh` | PASS |
| `bash tests/antigravity/run-tests.sh` | PASS; logo freshness skipped without rsvg-convert |
| `bash tests/codex-plugin-sync/test-sync-to-codex-plugin.sh` | PASS |
| `python3 -m pytest -q tests/hermes` | 25 passed, including every fork skill description |
| `node tests/brainstorm-server/server.test.js` | 36 passed, 0 failed, 0 skipped |
| `bash tests/claude-code/test-brainstorming-artifact-quality.sh` | PASS; existing fork contract assertions unchanged |
| `python3 /Users/gamarsoft/.codex/skills/.system/skill-creator/scripts/quick_validate.py skills/brainstorming` | Skill is valid |
| `python3 docs/superpowers/analysis/2026-10-13-upstream-v7.0.0/check-evidence.py` | PASS |
| `git diff --check` | PASS |

The earlier comparison's `probes.json` records baseline failures for literal
replacement tokens, broken PATH and custom ignore preservation. Candidate
regressions cover these cases without replacing the fork's companion or helper
contracts. Brainstorming results and their narrower claims are in
`evaluation-results.md`; fifteen matched actor vectors and two extra pressure
responses are retained in `evaluation/`.

## Test tools

Missing developer tools were isolated under `/private/tmp`, with no global
installation and no runtime dependency added to the plugin:

- Graphviz 16.1.0, official source archive and SHA-256 verified; configured
  with `--prefix=/private/tmp/superpowers-v7-tools/graphviz-install --without-x`,
  built with `make -j4` and `make install`.
- yq 4.44.3 for Darwin arm64, checked against the official release checksums.
- Python venv `/private/tmp/superpowers-v7-test-env`, PyYAML 6.0.3 and pytest 9.1.1.
- Existing Node test dependencies in `tests/brainstorm-server/node_modules`.

Download identities are in `test-tool-provenance.json`. The complete-suite
command uses:

```bash
PATH="/private/tmp/superpowers-v7-test-env/bin:/private/tmp/superpowers-v7-tools:/private/tmp/superpowers-v7-tools/graphviz-install/bin:$PATH" bash docs/superpowers/analysis/2026-10-13-upstream-v7.0.0/verify.sh
```

Equivalent installed prerequisites can replace these temporary paths. The runner
disables filesystem-monitor configuration in temporary Git fixtures and reports
skip lines. Finishing alone owns this complete run on the reviewed commit.

## Rulings and limitations

- User requested the base checkout, so no worktree was created. Controller
  execution avoids changing its own instructions through parallel writers.
- Runtime fixes and brainstorming changes share one coherent two-parent merge
  commit because the merge cannot be committed with unresolved entries.
- Raw actor copies remain in the ignored workspace, with durable copies added
  to the analysis directory for reproducible review. This strengthens the
  plan's initially hash-only evidence retention without changing product scope.
- Baseline behavior passed the rubric. Discovery changes follow the approved
  upstream-backed policy; no measured quality gain is claimed. Packet wrapper
  differences and non-blinded scoring limit causal interpretation.
- Windows cmd/Git Bash execution and live Antigravity/Hermes acceptance are
  unavailable here. Their imported fixtures and structural tests are not live
  platform acceptance. Antigravity's optional logo render-freshness check needs
  rsvg-convert; PNG dimensions, format and manifest wiring were checked.
- No external publication, PR, merge into `gamarsoft`, separate role install,
  opt-out workflow or disposable implementation lane is part of this work.

The implementation revision and independent final review belong to the
plan-scoped execution report; the later tracked report records the sole complete
suite and keeps its report commit separate from the tested implementation.
