# Testing Superpowers

Superpowers has two distinct kinds of tests, each in its own directory:

- **`tests/`** — does the plugin's non-LLM code work? Bash + node + python integration tests for brainstorm-server JS, OpenCode plugin loading, codex-plugin sync, and analysis utilities.
- **`evals/`** — do agents behave correctly on real LLM sessions? Python harness driving real tmux sessions of Claude Code / Codex / Gemini CLI, with an LLM actor and verifier judging skill compliance.

## Plugin tests

Live in `tests/`. Currently:

- `tests/brainstorm-server/` — node/shell test suite for the brainstorm server.
  Its canonical `npm test` runs both the upstream runtime/security/lifecycle
  coverage and the custom comparison, selection-clarity, carry-forward, live
  acceptance, contract, and Windows/WSL lifecycle regressions.
- `tests/opencode/` — bash tests for OpenCode plugin loading, bootstrap caching, and tool registration.
- `tests/codex-plugin-sync/` — bash sync verification.
- `tests/kimi/` — bash/Python checks for Kimi plugin manifest wiring.
- `tests/claude-code/test-helpers.sh`, `analyze-token-usage.py` — utilities used by remaining bash tests.
- `tests/claude-code/test-subagent-driven-development.sh` — agent-can-describe-SDD test (no drill counterpart; tests description-recall, not behavior).
- `tests/claude-code/test-subagent-driven-development-integration.sh` — extended SDD integration with token analysis (drill covers the YAGNI subset; bash adds commit-count, Claude Code task-tracking, and token telemetry assertions).
- `tests/claude-code/test-worktree-native-preference.sh` — RED-GREEN-REFACTOR validation for worktree skill (drill covers the PRESSURE phase; bash also covers RED/GREEN baselines).
- `tests/explicit-skill-requests/` — Haiku-specific, multi-turn, and skill-name-prompted tests not covered by drill.

Run plugin tests via the relevant directory's `run-*.sh` or `npm test`.

The repository also keeps focused Codex behavior probes under
`tests/codex/sdd-behavior/`. These use fresh Codex agents to exercise the lean
planning and delivery controller under scope, authority, cadence, correction,
fallback, and finishing pressure. Every campaign uses immutable run directories
containing a manifest, complete raw responses, controller-visible event counts,
assertion evidence, and a checked summary. Run the deterministic scorer contract
with:

```bash
bash tests/codex/sdd-behavior/test-score-results.sh
```

Review-depth micro-tests and manually inspected responses live in
`tests/codex/sdd-behavior/review-depth/`. These are bounded prompt probes, not
scorer-certified controller campaigns. Run their dispatch wiring checks with
`bash tests/claude-code/test-review-depth-contracts.sh`. See that directory's
`RESULTS.md` for before/after results and limitations.

These local probes test a narrow fork-specific workflow contract. The suite supplements
the shell tests and does not replace the external Drill suite.

## Skill behavior evals

Live in `evals/`. Drill is the harness; scenarios live at `evals/scenarios/*.yaml`. See `evals/README.md` for setup. Quick start:

```bash
cd evals
uv sync --extra dev
export ANTHROPIC_API_KEY=sk-...
uv run drill run triggering-test-driven-development -b claude
```

Drill scenarios are slow (3-30+ minutes each) and run real LLM sessions. They are not part of CI today; the natural follow-up is a tiered model (fast subset on PR, full sweep nightly + on-demand).
