# Codex SDD behavior evaluation

This directory holds small, fresh-context probes for planning, SDD, review,
fallback execution, and finishing behavior. They supplement deterministic
shell tests; they do not replace them.

## Run contract

Each immutable run lives under `results/lean-risk-scaled/runs/<run-id>/`:

- `manifest.json` records the exact skill revision, scenario revision,
  harness/version, model/effort, plugins, advertised typed roles, and expected
  sample count. `scenario_revision` may be one string for a uniform run or an
  object keyed by scenario when only one prompt evolves; every candidate is
  compared only with a baseline carrying the same revision for that scenario.
- `raw/<scenario>-<two-digit-repetition>.json` preserves the complete actor
  response, controller event trace, counts, dispositions, assertions, and
  evidence.
- `summary.md` is the checked output of `score-results.py`.

Never overwrite a run after its revision is recorded. A new GREEN or REFACTOR
iteration gets a new run ID.

## Actor procedure

1. Prepare a clean checkout at the manifest's `variant_revision`.
2. Build a read-only instruction packet from the complete skill files named by
   `Skills under test`, then append the scenario's `Actor prompt`. Send that
   self-contained packet to a new Codex agent with `fork_turns: "none"` and
   substitute the clean checkout and fixture paths. The actor's no-tools rule
   applies after the controller has supplied this packet; do not ask the actor
   to discover its own instructions.
3. Hold harness, model, reasoning effort, plugins, and advertised-role
   conditions constant across paired baseline and candidate runs.
4. Preserve the actor's complete response. Count controller dispatch, review,
   correction, and human-stop events from the tool trace.
5. Score the listed assertions from observable response/events. Use two
   independent scorers only when prose makes an assertion ambiguous, and keep
   both original judgments in `event_trace`.
6. Run `python3 score-results.py RUN_DIR`. For candidates, also pass
   `--baseline BASELINE_RUN_DIR`. Repeat `--baseline` when the aggregate
   candidate contains scenario revisions stored in separate baseline runs;
   the scorer selects only exact scenario/revision matches.

Start with five samples. If exactly one baseline sample fails, run five more
for that scenario. A candidate uses the final matched count, passes every
sample, and improves at least two samples when baseline had at least two
failures.

The production thread that motivated this suite is hypothesis evidence only.
It is not one of the controlled samples.
