# Documentation reuse baseline

Five fresh `gpt-6-sol` / `low` samples used the unchanged Context7 skill and
writing-plans prerequisite. Each performed two synthetic research preparations.
The mapped retrieval tool recorded calls; all outputs were manually inspected.

| Case | Observed behavior | Samples |
| --- | --- | --- |
| G: Complete current-session findings, unchanged version and scope | No additional retrieval; findings handed to planning | 5/5 |
| H: Old findings after version upgrade | One retrieval for the new version; corrected API and expiry in handoff | 5/5 |

This control shows no failure to fix in the existing reuse behavior. Therefore
the implementation plan retains `context7-research` and `writing-plans` unchanged.
It does not claim improved reuse from new brainstorming guidance. Results apply
to the two controlled fixtures, not arbitrary live documentation sessions.

Inputs, per-run outputs and instrumented calls are preserved locally in
`.superpowers/sdd/brainstorming-decision-research/baseline/reuse/`.
