# Behavior run: candidate-final-r5

- Variant: candidate @ `7f4ff8c478e64fbd39c8a71f54fd142407d3df47`
- Harness: Codex exec fresh process, codex-cli 0.153.0
- Model: gpt-5.6-sol (high)
- Environment: retained role-free Codex package
- Package SHA-256: `402f3fdf5b0385a56660c509ebae3ab9af5783d878d326e1b1b399d8a19fc0af`

| Scenario | Passed | Samples | Pass rate | Raw evidence |
| --- | ---: | ---: | ---: | --- |
| missing-role-fallback | 5 | 5 | 100.0% | [01](raw/missing-role-fallback-01.json), [02](raw/missing-role-fallback-02.json), [03](raw/missing-role-fallback-03.json), [04](raw/missing-role-fallback-04.json), [05](raw/missing-role-fallback-05.json) |

Each sample retains one parent and two child rollouts under `operational/`.
Every parent contains exactly two generic `spawn_agent` calls with
`fork_turns: "none"` and no `agent_type`: one implementation probe and one
read-only review probe. Both self-describing child markers returned in every
sample, proving stage, exact revision, implementation scope, specification and
acceptance placeholders, exact review range, shared dispositions, causality,
proof, read-only access, and no-subagent constraints. No unavailable typed role
was called. Every actor returned the same five required assertion IDs without
controller normalization.

The archive is retained as `role-free-package.zip` and contains no
`.codex/agents` entry. A byte-for-byte provenance check found 128 exact
non-metadata files and 14 exact candidate-owned metadata files at the stated
candidate revision. The remaining 13 metadata files exactly match
`openai/plugins` revision `1e285826e604f66f7208f7ac4dba0fe8341d1f57`
under `plugins/superpowers`. This is a candidate-only runtime invariant check,
not a synthetic before/after improvement claim. The older prose-only
`missing-role-fallback` results remain historical but are not the operational
proof for packaged fallback.

Four earlier five-sample attempts are preserved under `rejected-*` and
excluded from the manifest and score. The first used an incorrectly expanded
revision; the second used correct operational calls but markers too weak to
prove the complete child prompt independently; the third ran against a package
whose metadata source incorrectly reused one skill's fixture metadata; the
fourth again expanded a valid short package revision incorrectly in the actor
prompt and retained markers.
