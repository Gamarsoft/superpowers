# Experience-design correction evidence

This targeted campaign follows the human rejection of DashPark Branding
`branding-paper-r1-20261026`. It tests how agents frame, explore and critique an
experience. It does not establish that a newly rendered design is better or
that a person can use it successfully.

The fixed scenario has three independent checkpoints: an approved product spec
with an unsettled experience, release pressure on the actual rejected captures,
and a settled typo correction. `acceptance.md` was frozen before the candidate
changes. Exact source snapshots, prompts, image hashes, commands, responses and
unfiltered traces are retained per run. Actors use fresh ephemeral GPT-6 Astra
sessions at medium effort, the same baseline working directory and read-only,
no-tool instructions. These small samples are diagnostic, not statistical proof.

| Run | Instruction source | Result |
| --- | --- | --- |
| baseline-r1 | `7e6b25dfa6d464d10b7548a037393f1f32400af3` | Both skip experience framing and structural comparison; one adequately critiques the preview when explicitly asked. |
| candidate-r1 | `0da9cdd2c5564e51078a2ed3a43718d0af7fa6f3` | Both frame and compare structures; one omits the separate product decision for repeated-logo work. |
| candidate-r2 | `3ad8a833e842d5a9c5e6dee971eb6498b25ebfed` | Both expose rule friction; one passes all six criteria, one leaves the redesign's exact approval linkage implicit and fails criterion 5. |
| design-regression-r1 | `0da9cdd2c5564e51078a2ed3a43718d0af7fa6f3` | All five fresh samples pass the existing D01–D15 rubric. |

`judgments.md` contains the independent semantic judgments, exact supporting
text, hash/trace inspection and the retained criterion-5 interpretation history.
No failed sample was discarded. The final targeted run remains mixed; it must
not be described as an all-pass campaign. A typo-only approval statement cannot
satisfy a separate redesign checkpoint.

Between the two candidate runs, only the existing rule-friction paragraph
changed: it now identifies repeat work, workaround or task interruption and
requires the rule, user cost and separate product decision. The five-sample
design regression was not repeated after that paragraph change; its source
scope remains explicit. The matched targeted rerun covers that correction.
Schema and maintenance behavior did not change; their historical evidence is
preserved. The previous 140/140 campaign is a different campaign and is untouched.

The actual pilot must still demonstrate a useful revised desktop/narrow
experience, sensitive component feasibility, coherent version-2 exports and
explicit human approval of the exact final revision. Installed defaults and
application implementation remain gated. The existing SDD review assesses the
workflow change and these evidence limits before dependent pilot work resumes.
