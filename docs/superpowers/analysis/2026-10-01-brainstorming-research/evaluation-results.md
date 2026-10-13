# Brainstorming research evaluation

The corrected skill preserved source references in all five fresh samples for
each tested discovery output and short spec. The matched baseline omitted them
in every sample. This supports the source-preservation change; it does not show
better live search, general reasoning, or product decisions.

## Revisions and method

- Control: `b12cbd54f771c9617e4e8e9d98274c812a036a82`.
- First candidate: `43c47faf10bf7047b37a44fa6fc04758c3066b98`.
- Corrected candidate: `649297559996ccc9da14d4092a7935e1b9416ea2`.
- Final comparison: five fresh Codex CLI sessions per variant, requested model
  `gpt-5.6-sol`, low effort, ephemeral sessions with workspace-write sandboxes.
  Each session received the same six requests, source fixtures and output task;
  only the skill snapshot and output paths differed. All ten sessions completed.
- Each session handled cases A-F. Cases within a session are correlated; these
  are five samples per variant, not thirty independent sessions.
- The controller manually read every complete output. The scoring contract
  preceded candidate inspection. Sources simulate retrieval for fictional
  products. No live browsing or Context7 call forms part of this comparison.

The app's lifetime agent limit prevented a fifth first-candidate session and
fresh corrected evaluations. CLI requests for `gpt-6-sol` failed as unsupported
and are not samples. The final comparison therefore reran both arms on the
supported older Sol model. Do not pool these results with the earlier app cohort.

## Matched results

| Required observation | Baseline | Corrected candidate |
| --- | --- | --- |
| A: applicable ParcelKit 2.4 source beside the recommendation | 0/5 | 5/5 |
| B: original vendor study and actual opened local observations cited | 0/5 | 5/5 |
| E: existing QueuePath finding remains traceable when reused | 0/5 | 5/5 |
| F: short spec retains claim, locator, version, limit and decision impact | 0/5 | 5/5 |
| A: distinguish installed 2.4 behavior from 4.0 | 5/5 | 5/5 |
| B: retain shared origin and population/causality limits | 5/5 | 5/5 |
| C: no research detour for settled terminology | 5/5 | 5/5 |
| D: keep regional capability unverified and continue discussion | 5/5 | 5/5 |
| E: distinguish callback semantics from alert policy | 5/5 | 5/5 |
| F: do not claim process-crash recovery has been verified locally | 5/5 | 5/5 |

Every corrected sample passed the four source-preservation observations. Every
baseline sample failed them. For example, baseline 2 A explains caller-owned
persistence without a locator. Corrected 2 A links the opened
`fixtures/A/official-v24.md`. Corrected 3 B links both `vendor-study.md` and
`internal-study.md`, retaining the small sample and absence of a wizard test.
Corrected 5 E cites `prior-findings.md` while leaving alert timing to the user.
Every corrected F cites the opened `findings.md` and retains the local
crash-recovery verification gap.

These scores cover the named observations. They are not complete quality scores
for the proposed fictional products. Outputs still vary in wording, length and
optional implementation suggestions. For example, corrected 3 F overstates
client-only infeasibility in its rationale, despite correctly recording that
2.4 delegates persistence to the caller. That incidental inference is not
evidence of improved source interpretation and remains visible in the raw output.

## Correction and preserved controls

The original app baseline used five fresh `gpt-6-sol`/low sessions: A/B/E source
locators were 0/5 and F was 1/5. Interpretation already passed. The first app
candidate had four completed sessions. Sample 4 still omitted A/B/E citations;
samples 1-3 also turned local source-origin metadata into unverified paths.
This partial cohort justified correction, not a passing result.

Correction 1 adds a research-informed output shape directly in guided discovery,
including reuse, and requires local citations to identify the reachable file
actually opened. Five fresh matched CLI samples then passed those observations.
No baseline success is attributed to the added instructions.

The separate five-session instrumented reuse control passed before editing:
matching detailed findings triggered no redundant retrieval; a changed version
triggered retrieval for the new version. `context7-research`, `writing-plans`
and `gathering-topic-context` remain byte-identical. See `reuse-baseline.md`.

## Evidence and limits

Local raw artifacts, immutable skill snapshots, requests, fixtures, CLI command
traces, manual scores and SHA-256 manifest are preserved under:

```text
.superpowers/sdd/2026-10-01-brainstorming-decision-research/evaluation/
```

The runner is `run-cli-eval.sh`; it uses the original temporary fixture root
`/tmp/brainstorming-research-20261001`. Recreate that directory from the archived
snapshots and fixtures before replaying it. Source links in raw outputs retain
their original locations; the archive also contains all source files.

The focused artifact-quality check, skill metadata validator, new-reference
existence check and whitespace checks passed on the corrected candidate, as
recorded in `task-1-report.md` in the same plan workspace. Existing workflow gates
are checked separately from these behavior observations. The complete suite
belongs to finishing and is not claimed here.

This small controlled exercise does not establish live query quality, discovery
of authoritative sources in an unfamiliar domain, statistical reliability, or
complete end-to-end delivery. A real discussion trial remains the useful next
way to assess those limits.
