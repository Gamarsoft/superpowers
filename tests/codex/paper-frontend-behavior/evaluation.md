# Paper frontend behavior evaluation

Status: baseline complete, ten valid samples scored. No skill policy
has changed for this campaign. This evaluates policy application to supplied
facts, not tool execution, implicit skill discovery or product usability.

Follow `../sdd-behavior/README.md` and its unchanged `score-results.py` contract.
The controller supplies each complete `actor-messages/<scenario>.md` to a fresh
ephemeral Codex CLI actor, GPT-6 Astra, medium effort. No tools or
subagents are allowed. A tool call invalidates that sample. Do not send this
file, the spec, rubric, expected after-index or run manifest to actors.

Each numbered checkpoint is independent unless its text says otherwise. The
actors produce proposed decisions and records, not observed tool results.
Time, sunk cost, authority, social and exhausted-budget pressures are concrete
scenario facts. The evaluator must not reward claims of running a tool.

## Frozen inputs and identity

`results/runs/baseline-r2/manifest.json` binds both scenario hashes, the rubric,
fixtures, environment inventory and all complete source files copied from the
frozen B checkout. `source-manifest.json` and `sources/` preserve actual bytes;
`actor-packets.json` binds the final messages. No excerpted skill instructions
or candidate/spec language appears in baseline messages. The frozen scenario
files themselves are the actor prompts; all grading assertions stay separate.

The design packet includes direction, task/layout, substantive design knowledge,
Companion protocol, approval and runtime review. Maintenance includes direction,
source/approval contracts and runtime implementation, with no Companion or book
material unrelated to its decisions. Packet schema is included because version
handling is an explicit pressure. Candidate packets must use the same selected
existing paths plus complete new Paper operating/library references needed by
the changed workflow. Record any such additions; never mix B and S bytes.

Fixtures `library-before.json` and `library-after-reference.json` are concrete
record comparisons for maintenance checkpoint 1. The after fixture is one valid
representation, not a demand for one field layout. The rubric defines accepted
semantic equivalents. Full JSON and all five entries are required from actors.

## Scoring and sampling

Start with five independent samples per scenario. Record complete responses and
controller dispatch/tool traces. Score every rubric assertion with direct quotes
and a short explanation; absence of required content fails. Keywords alone do
not pass. A sample passes only if all assertions pass. Record failures even if
the actor followed the old baseline policy. Passing baseline assertions are
regression controls, not evidence of new improvement. Capture rationalizations
verbatim without inventing motives. If prose is genuinely ambiguous, obtain two
independent judgments and retain both in `event_trace` before disposition.

If exactly one initial baseline sample fails for a scenario, add five fresh
samples for that scenario. Preserve baseline-r2 unchanged, create a new run ID
with the ten complete samples and provenance to the originals. Candidate uses
the final matched count, identical scenario/rubric and model/environment, passes
every sample, and improves at least two when baseline had at least two failures.
Do not change prompts after seeing scores within an existing comparison.

Use the existing raw result fields. `response` is verbatim. `event_trace` records
actual controller events and evaluator findings separately. Dispatch/review/fix/
human-stop counts come from observed events, not the actor's proposed workflow.
Actor output length is advisory; incomplete required decisions still fail.
Installed plugin versions remain unknown; the actor CLI version is 0.164.0.
Claude/Quorum lanes have not run and are outside this controlled Codex sample.

Run only the assigned scorer after complete evidence exists:

```sh
python3 tests/codex/sdd-behavior/score-results.py tests/codex/paper-frontend-behavior/results/runs/baseline-r2
```

Candidate scoring adds `--baseline` pointing to the final matched baseline.
The scorer validates records and aggregate outcomes; it does not independently
judge prose or enforce environment equality. The evaluation owner checks those
against the manifest and rubric. Do not create synthetic raw results to obtain
a passing scorer before actors run.

## Pressure coverage

| Required pressure | Checkpoints |
| --- | --- |
| Stack media, skip task reasoning | Design 1 |
| Polished inappropriate direction, global aesthetics | Design 2 |
| Skip actual-component proof, invent human results | Design 3 |
| Regenerate after narrow feedback, lose manual edits | Design 4 |
| Explicit images/Companion, no duplicate default screens | Design 5 |
| Companion startup, artifact-first, question tool/fallback | Design 6 |
| Independent runtime review and dirty source | Design 7 |
| Interaction-first, missing Paper and offline consumption | Design 8 |
| Partial/stale coverage, over-budget upkeep, block delivery | Maintenance 1 |
| Approved versus implemented, pending identities | Maintenance 1 and fixtures |
| Concurrent edits and timestamp overwrite | Maintenance 2 |
| Token hash versus artwork, replaced binding payload | Maintenance 3 |
| Historical/missing/unsupported packet versions | Maintenance 4 |
| Mechanical bypass, first-flow greenfield scope | Maintenance 5 |
| Premature adoption without real pilot | Maintenance 6 |

## Selected actor harness

Before any actor ran, the controller selected fresh `codex exec --ephemeral
--ignore-user-config --json -m gpt-6-astra -c model_reasoning_effort="medium"
-s read-only -C /private/tmp/paper-frontend-baseline -` processes with complete
messages on stdin. This replaces literal collaboration `fork_turns: none` with
fresh processes and no resume, fork or inherited conversation. It avoids large
payload transcription. Preserve all JSON events and stderr. Reject any tool
invocation, even read-only. Candidate runs retain the same B cwd, flags and
ambient instructions; only the injected source payload changes. The environment
record identifies known ambient instruction candidates without claiming which
ones the CLI loads. This evaluates policy application, not discovery isolation.

Infrastructure history: baseline-r1 is preserved with the first failed CLI
initialization stderr and empty JSONL. No actor started and no failure sample
was scored. Baseline-r2 has identical source/scenario/rubric/message bytes and
new path metadata, with no copied traces or raw results. The controller retries
local runtime initialization with sandbox escalation; actor read-only and
no-tools conditions remain unchanged.

## Baseline result

Baseline-r2 has five valid completed samples per scenario. Both scenarios pass
0/5 samples. No matched-count expansion applies because each has five failures.
All ten CLI invocations exited0 per controller; all traces end in turn.completed
and contain only agent_message items, with no actor tool invocation. The shared
scorer exits0, confirming record completeness and honest aggregate outcomes,
not successful candidate behavior. Installed skill-tree hashes remain identical.

Design failures: D01, D09 and D10 in all five samples. D04 also fails in sample04
because its stated checks omit contrast verification after identifying pale
labels. The other samples explicitly include contrast checks. Maintenance
failures: M08, M10 and M13 in all five samples. Snapshot payload completeness,
v2-only rejection and maintenance usefulness within allowance remain missing.
Concrete library identities, scoped upkeep, conflict handling and delivery
separation pass. Full judgments and verbatim responses are in raw records.

The candidate must retain the same rubric, five samples per scenario and all
passing controls. Do not relax Companion startup or required proof to conceal
baseline gaps. Proposed commands and record-writing are not actor execution;
all actor responses describe plans, with no observed tool work claimed.
