# Upstream release skill evaluation

Date: 2026-10-27. Package: `.agents/skills/integrating-superpowers-upstream/`.
Authoring used `skill-creator` and `superpowers:writing-skills`.

## Outcome

The skill makes a before/after behavior evaluation plan part of the release
decision record. All five no-skill runs omitted that plan when recommending skill
changes; all five candidate runs included frozen sources, matched independent
sessions, criteria and evidence limits. The other specified fork-preservation and
scope boundaries remained satisfied in both arms. This demonstrates a narrower
planning improvement on supplied scenarios, not reliable real-world integration
or a general quality gain.

The strict output rubric also flags missing explicit remote identities in all
controls; all candidates name the configured upstream and fork remotes. Controls
did distinguish fork content from upstream content and proposed no unsafe push.

Two additional candidate-only pressure checks passed: repairing an incomplete
local integration without declaring success, and completing an explicitly
authorized fork push without seeking permission again. No new failure or
rationalization required a candidate revision.

## Method and evidence

The [cases](cases.md) and [rubric](rubric.md) were frozen before controls ran;
the skill was authored after the missing-evaluation-plan failure was observed.
Each arm used five fresh `collaboration.spawn_agent` contexts. Each actor answered
two cases, so these are five independent runs per arm, not ten. Candidates received
the complete skill and its workflow reference. Controls received neither. Actors
could read only the assigned inputs, then use no tools, other skills or agents.
No actor saw scores, rubric, sibling outputs, or controller conclusions.

The controller manually inspected all ten response pairs and the two pressure
responses. [Scores](scores.json), [pressure scores](pressure-scores.json),
[dispatch details and source identities](manifest.json), and raw responses under
`outputs/` are retained. Responses were saved verbatim in separate preservation
turns after the evaluated final answers. Complete tool traces are not exported.
Runtime model/effort defaults were inherited without overrides; exact identifiers
and the desktop build were not exposed by the spawning tool.

The main failure was an **omitted output element**, addressed with a required
verification field and a positive before/after recipe. Controls did not rationalize
unsafe merges; no additional discipline prohibitions or invented rationalization
claims were needed. For example, control 2 recommends brainstorming changes and
an inventory but its next action is only “maintain a durable ledger containing
immutable revisions, the complete changed-path inventory, upstream intent, current
fork behavior, disposition, rationale, dependencies, and remaining actions.” No
before/after behavior plan accompanies that recommendation. Candidate 2 adds
frozen sources, fresh independent sessions, specific cases, scoring and limits.

The fixtures are synthetic and include illustrative byte counts and dependency
conditions. They must not be cited as measurements of v7.0.1. The real release
assessment is a separate forward trial under
`docs/superpowers/analysis/2026-10-27-upstream-v7.0.1/`.

The [real trial](../../../docs/superpowers/analysis/2026-10-27-upstream-v7.0.1/comparison.md)
completed independently using the skill and raw repository, without seeing the
synthetic cases or controller conclusions. It produced all 64 decision records,
preserved five rename pairs and eighteen deletions, identified the current fork
contracts and dependent test reader, and supplied a future before/after plan.
The controller verified 152 recorded source hashes against Git and exact 64/64
decision coverage. The unmodified upstream size guard failed on two frozen fork
entrypoints and passed on upstream snapshots. No upstream integration or behavior
campaign was performed; this trial validates the assessment lane only.

Limitations: small sample, non-blinded controller scoring, correlated cases within
each actor, no long conversations, latency or cost measurement, and no actual
release integration by the behavioral actors. The pressure checks are additional
coverage, not comparative improvement evidence.

## Executable checks

Four real-Git fixture tests pass for the installed inventory helper:

- Annotated tags resolve to commits; renames, deletion records and fork overlaps
  are complete, including paths containing spaces.
- Staged, unstaged and untracked work plus HEAD stay unchanged by observation.
- Missing refs and a reversed release baseline fail clearly without JSON output.
- An ancestry-only merge does not erase an explicitly supplied reviewed delta.

The tests failed before the helper existed; see [RED output](logs/script-red.txt)
and [installed verification](logs/installed-verification.txt). The helper uses only
Python's standard library and Git, with no network or repository mutations.

The existing plugin sync suite gained one actual-content regression: a tracked
repository-local skill must not appear in exported plugin content. The corrected
fixture exposed that leak and its no-op consequences before the new exclusion;
see [RED excerpt](logs/scope-red-excerpt.txt). The first setup attempt omitted the
fixture from Git, causing unrelated failures; it is not counted as RED evidence.
The [complete sync run](logs/scope-green.txt) passes after excluding
`/.agents/skills/`. The separate archive packager already uses an explicit path
allowlist and rejects `.agents/` content; it was not changed.

Skill validation, shell syntax, relative reference resolution, source-hash
agreement and whitespace checks passed. The system Python lacked PyYAML; the
existing skill-creator validator used an isolated temporary environment with
PyYAML 6.0.3. No product dependency or global Python configuration was added.

## Scope and deployment

The skill is repository-scoped, outside the globally linked `skills/` tree, and
retains normal implicit discovery. This matches the user's explicit fork-only
request rather than writing-skills' general preference for cross-project skills.
Codex documents `.agents/skills` as a repository discovery location in its
[skill guide](https://developers.openai.com/codex/skills/#where-to-save-skills).
The old integration reports remain evidence, not permanent policy. The helper
does not select a baseline or determine semantic adoption automatically.

The installed package is byte-identical to the candidate identities in the
manifest. The unrelated `docs/gsd/preferences.md` edit is preserved. Development
uses `codex/upstream-release-skill`; v7.0.1 production files and release metadata
are not integrated by this task. No upstream PR is appropriate for this
fork-specific maintenance skill.
