# Brainstorming research baseline

Evaluated 2026-10-01 against source commit
`b12cbd54f771c9617e4e8e9d98274c812a036a82`, before changing skill content.

## Method

Five fresh `gpt-6-sol` / `low` agents each used a snapshot of the current
brainstorming skill and handled six supplied sessions. All dispatches used
`fork_turns: none`. Each session supplied completed local context and a concrete
next request; the agents produced the actual next discovery response or short
spec, rather than explaining what a skill should do.

Sources were synthetic files simulating external retrieval. They included an
inapplicable latest-version documentation result, repeated reports of one weak
vendor study, a settled terminology preference, unavailable research, reusable
current findings, and a researched decision moving into a short spec. Agents
could inspect the indexed sources and were not given the scoring criteria.

The controller read all five complete output files. These are five fresh
sessions with six cases each, not thirty independent sessions. This is the
no-new-guidance control; no candidate has been evaluated yet.

## Results

| Dimension | Samples meeting the criterion |
| --- | --- |
| A: Distinguished pinned 2.4 behavior from the latest 4.0 documentation | 5/5 |
| B: Recognized repeated reports of one study and its population/causality limits | 5/5 |
| C: Continued the settled terminology change without a user-facing research detour | 5/5 |
| D: Kept regional capability explicitly unverified | 5/5 |
| E: Used the existing findings in the next response | 5/5 |
| A: Included a direct source locator for the technical finding | 0/5 |
| B: Included source locators for the research informing the recommendation | 0/5 |
| E: Included a direct source locator for the reused external finding | 0/5 |
| F: Retained the direct external source locator in the short spec | 1/5 |

Only sample 2 retained the direct documentation URL in case F. Every sample
retained useful version and behavior context; the missing locator is a narrower
failure than loss of the entire research rationale.

Representative excerpts:

- Sample 1, A: "The top result describes ParcelKit 4.0, while this release uses
  2.4." The response explains the difference correctly but gives no source link
  or path.
- Sample 3, B: "The three 30% claims trace to one vendor case study of first-time
  consumer visitors". The output preserves the limitation but omits the source
  references.
- Sample 4, F: "ParcelKit 2.4 documentation, opened in this session, says
  continuation uses the upload ID and next byte offset and that callers must
  retain both." The spec records that research occurred but does not give the
  next agent a locator.

## Design implications

The demonstrated gap is traceability in discovery responses and persistence of
source references in short specs. A conditional evidence output contract and a
slot in the spec template directly address those omissions.

These samples do not establish that new guidance improves source selection,
version matching or recognition of weak studies. Preserve those successes as
regression checks and avoid importing GSD's tool-based trust ordering. Research
triggering and reuse need separate tool-level or live-session evidence before
claiming a reduction in skipped or redundant research.

No candidate skill changes have been tested, so no before/after improvement or
live-search acceptance is claimed. Variations in unrelated product scope and
wording are outside these scores. The fixtures do not diagnose the user's
particular GSD sessions.

## Evidence

Full fixture inputs, skill snapshots, raw outputs, machine-readable results and
SHA-256 manifest are retained locally under
`.superpowers/sdd/brainstorming-decision-research/baseline/`.

The creation script and initial working copies are also at
`/tmp/brainstorming-research-20261001/`. The local evidence directory is ignored
by Git; this summary is the durable tracked account of the method and findings.
