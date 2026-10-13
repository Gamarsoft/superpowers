# Brainstorming before/after evaluation

The selective candidate preserved the tested fork contracts. All five baseline
and all five candidate actors passed cases A–G under the prewritten rubric.
The observed change is narrower: baseline A responses all recommended problem
categories; candidate A responses all asked about a concrete incident without
a menu. The baseline categories were about intent, not proposed dashboards or
checklists, so they are **not retrospectively scored as failures**. This campaign
does not establish a quality improvement over the fork. The discovery change is
an upstream-backed policy adaptation; the other additions clarify contracts
that already worked in these samples.

## Method

- Five fresh Codex app actors per arm: no-skill control, frozen current fork,
  selective candidate. Each actor answered seven fictional bounded turns.
  These are **five independent sample vectors per arm**, not 35 independent
  sessions. Two further fresh candidate actors handled realistic combined
  pressure scenarios.
- All actors used the advertised `sp_implementer` role, GPT-6.1 Sol/medium,
  with no inherited history and no role/model override. They could read their
  assigned inputs and write only their own response. No browsing, further
  agents or implementation was allowed. Controls saw only the cases.
- Baseline and candidate received all eleven applicable skill/reference files,
  not an excerpt of the edited skill. Actors did not receive the rubric,
  alternative arms or other outputs. The baseline finished before authoring.
  Cases and rubric were frozen before baseline dispatch.
- Packet wrappers differed: baseline used source-file separators; candidate
  used Markdown source headings and one reading instruction. Source contents
  and order are recoverable and checked. This is a limitation for causal
  attribution; the comparison is descriptive, not a controlled effect estimate.
- Codex CLI 0.154.0 rejected `gpt-6.1-sol` for this account. That failed launch
  is not a sample and was not pooled with a different model. App sessions
  supplied the matched model cohort. Per-agent token use, complete tool traces
  and comparable latency were unavailable; response words are not token cost.
- The controller read every response and scored the prewritten observations.
  This was not blinded grading. Source-text tests are reported separately.

## Results

| Observation | Control | Current fork | Candidate |
| --- | --- | --- | --- |
| A: investigates unclear intent without a premature solution menu | 5/5 | 5/5 | 5/5 |
| B: explicit agent-owned platform default and compatibility assumption | 2/5 | 5/5 | 5/5 |
| C: preserves supplied native platform, behavior and written review | 5/5 | 5/5 | 5/5 |
| D: cites installed-version evidence and keeps recovery unverified | 5/5 | 5/5 | 5/5 |
| E: material builder gaps, delegated HOW, existing review format | 0/5 | 5/5 | 5/5 |
| F: separate frontend approval before routing under pressure | 5/5 | 5/5 | 5/5 |
| G: reuses known answers, asks material question within review budget | 3/5 | 5/5 | 5/5 |

Control B1/B2/B5 assumed browser delivery without clearly owning the choice.
B3/B4 attributed it. All controls found E's substantive product gaps, but lacked
the fork's review format; that difference is expected without its instructions,
not evidence of better product reasoning. Control G3/G5 explicitly skipped
another review cycle after a material answer, unlike the fork's bounded
correction requirement. G1/G2/G4 did not explicitly bypass review of the material
answer and receive the benefit of that ambiguity.

The A response style changed from five recommended-category questions to five
incident questions. The no-skill controls also asked incident questions. This
supports removing the forced menu rule, without claiming that an incident
question was proved more useful in a real conversation.

Candidate E4 added an example-mapping blocker beyond the seeded product gaps.
The scenario's category-only validation wording does lack concrete examples,
which the existing checklist requires. This is not a new HOW approval gate,
but shows that the builder lens does not guarantee fewer review comments.
Candidate B5 kept song-specific versus aggregate history explicitly unresolved;
the scenario did not settle that observable behavior. Other samples used draft
assumptions. Neither is evidence of user approval.

Both additional pressure actors passed: native Android/Kotlin and installed
transport limits survived deadline, sunk-cost and teammate pressure; known
export facts and atomic-publication behavior were reused, and tombstones stayed
a single user decision in the existing review budget. No extra builder agent,
approval evidence or premature adapter was invented.

## Evidence and limits

`evaluation-manifest.json` records every actor, raw output hash, word count and
case score. `evaluation/` contains the complete raw responses, including the
less desirable observations above. Source hashes reconstruct the actual packets
from the pinned base and candidate files. `check-evidence.py` verifies identities
without requiring the ignored working copies.

This tests supplied-evidence turns on one model. It does not measure actual
research retrieval, long-conversation behavior, user satisfaction, runtime tool
discipline, token savings, or live acceptance in another harness. No outcome
improvement claim meets the preregistered two-baseline-failure threshold, so no
such claim is made. No isolated baseline failure needs extra matched samples.
