# Controller-only fixture probe

- Candidate revision: `67433c8`
- Fixture: `tests/codex/sdd-behavior/fixtures/implementation-plan.md`
- Result: PASS

## Preflight ruling

The approved fixture specification requires all three labels to be lowercase.
Task 2 instead produces uppercase owner labels. The task/self row and the
Task-2-to-whole-feature pairwise row therefore record one `BLOCKING`
producer/consumer contradiction. No task may dispatch until the plan is ruled
back to the approved lowercase contract through plan readiness.

Task 1's choice between a built-in trim and an equivalent private helper is a
reversible HOW ruling. The controller selects the built-in operation and records
the cost if wrong as a local implementation edit with no public-contract or
data migration impact.

After that plan correction, Tasks 1–3 form one checkpoint unit because they are
same-shaped, ordinary, and file-disjoint. Task 4 remains one individual
review-required unit for money, concurrency, and idempotency. Performance and
Unicode restrictions stay outside the first delivery boundary.

## Executed probes

| Probe | Evidence |
| --- | --- |
| Generate clean smoke repository | Fixture repository initialized and its shape test passed |
| `task-brief ... 1 2 3` | `unit-1-2-3-brief.md`; Tasks 1, 2, 3 appeared once and in order |
| `task-brief ... 4` | `task-4-brief.md`; only Task 4 appeared |
| TDD mechanics | Exactly one mechanics block appeared in each generated unit brief |
| `review-package ... HEAD HEAD` | Exact clean range accepted and recorded as zero commits |
| `python3 -m unittest discover -s tests -v` | 1 test passed |

This is a controller/script contract probe, not an implementation smoke run.
The end-to-end implementation and finishing smoke belongs to the final
candidate gate.
