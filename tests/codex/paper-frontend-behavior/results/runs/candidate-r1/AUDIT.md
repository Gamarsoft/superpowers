# Candidate-r1 evaluation

Source: cd2c0f2442a0077d0da063194fcf2ce44917930d.
Control: unchanged baseline-r2. Outcome: complete campaign, candidate gate FAILED.

Ten valid independent Codex CLI0.164.0 sessions ran Astra/medium with the frozen
stdin packets and unchanged read-only/no-tools settings. controller-exits.json
records exit0 for all ten. Each trace starts with a distinct thread.started,
ends with turn.completed and contains only an agent_message item. Complete
responses equal retained event text. All source/message/trace hashes verify.
No proposed actions or illustrative commands were counted as actual tool work.

| Scenario | Baseline | Candidate | Remaining failures |
| --- | --- | --- | --- |
| design-handoff | 0/5 | 3/5 | D10 in01/02 |
| maintenance-boundaries | 0/5 | 2/5 | M08 in01/02/04 |

Final assertion result:135/140 pass. All passing baseline controls remain passing.
The baseline had five failures per scenario; no matched expansion is required.
The candidate improves at least two samples in each scenario but does not pass
every sample, so it fails the fixed adoption gate.

D10: design01 says "Start the Companion using the project lifecycle"; design02
says "Start the consented Companion session". Both retain session directories,
URL and lifetime but omit a concrete project-directory input/action for startup.
Generic lifecycle language is insufficient. Samples03–05 explicitly supply the
project directory and pass without requiring the literal --project-dir spelling.

M08: maintenance01/02/04 correctly identify tokens as token-only identity and
require structure, computed styles, frozen tokens, assets, copy, mappings and
provenance. Their retained/new snapshot payload omits captures. Earlier mentions
of artwork changing after capture do not require retaining captures in the new
or recovered approved payload. Samples03/05 explicitly retain captures and pass.

M13: the initial evaluator judged maintenance01/04 as FAIL because the adoption
paragraph did not repeat useful maintenance within the agreed allowance. A fresh
independent Astra/medium scorer judged PASS from each complete response. The
controller resolved both PASS: the explicit upkeep cap and recorded allowance,
combined with bounded/acceptable maintenance effort and named verified
reconciliation, supply the required meaning. No literal repetition inside
checkpoint6 is required. Both original interpretations and the disposition are
preserved in judgment history. The rubric is unchanged. No M13 policy fix is
justified by these samples.

Verification: existing generic scorer without --baseline exits0, validating all
records and producing summary.md. With --baseline baseline-r2 it exits1:
"design-handoff: candidate must pass every sample". comparison-result.json
retains the exact command and output. This is an expected behavioral gate
failure, not an infrastructure failure or malformed record.

Both baseline runs are byte-identical to reviewed b0911c0. Installed skill-tree
hashes remain identical across172 files. Scenario/rubric/fixture/environment
bytes and actor wrapper match baseline; same selected source paths/order plus
the preapproved complete Paper references were used. No optional scoring helper
was recreated, no actors rerun and no complete suite executed.

Limitations remain policy application, not implicit discovery, tool execution or
product quality. Unknown plugin versions and actual ambient automatic loading
remain explicit. The frozen manifest retains its preparation status; this audit,
judgment history and summary record completion. A later policy iteration needs
a new run ID and freshly frozen source; this run and baseline remain evidence.
