# Candidate-r1 preparation

Source commit: cd2c0f2442a0077d0da063194fcf2ce44917930d.
Control: baseline-r2. Five samples per scenario; pending controller execution.

All 18 source files were read from exact Git blobs at the source commit, not
uncommitted working-tree files. Existing per-scenario source paths and order
match the baseline; complete paper-workflow.md and paper-library.md are appended
as approved in the original campaign protocol. No spec or rubric is injected.
Source and complete-message hashes, byte counts and word counts are recorded
in source-manifest.json and actor-packets.json.

Scenario, rubric, fixture and environment bytes are identical to baseline-r2.
The actor wrapper hash matches for both packets. Known ambient instruction file
hashes match the baseline and codex --version reports0.164.0. Actual automatic
ambient loading and unknown plugin-version limits remain unchanged.

Controller uses the identical recorded ephemeral Astra/medium/read-only stdin
command from actor-environment.json, with the same B cwd and host initialization
permission. Actors may not invoke tools. Retain every JSON event and stderr;
score only completed outputs. No raw responses, outcome claims or optional
scoring helper have been created. Baseline-r1/r2 remain untouched.

After all ten valid samples are available, manually score every frozen assertion
and run the unchanged generic scorer with --baseline pointing to baseline-r2.
Any candidate failure remains evidence; do not weaken the rubric or overwrite
this run to report a pass. Subsequent policy iterations require a new run ID.
