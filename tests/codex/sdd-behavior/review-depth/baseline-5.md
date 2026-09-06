Selected instructions for both cases:

- `/private/tmp/sdd-review-depth-baseline/subagent-driven-development/SKILL.md`: controller selection and dispositions.
- `/private/tmp/sdd-review-depth-baseline/subagent-driven-development/task-reviewer-prompt.md`: required specification and quality review.
- `/private/tmp/sdd-review-depth-baseline/requesting-code-review/references/java-21-spring-gke-checklist.md`: read under the runtime-behavior trigger; tenant isolation and cache guidance apply to A. Java, Spring, and deployment sections do not apply. No specialist profiles were selected.

Case A

| ID | Disposition | Location | Proof | Candidate causal connection | Concrete failure | Required resolution |
|---|---|---|---|---|---|---|
| A1 | BLOCKING | `receipts.py:4–6` | Read alpha/r1, then beta/r1: the second read returns alpha’s cached receipt without calling the tenant-enforcing store. | New cache keys omit tenant. | Cross-tenant disclosure; a missing beta receipt can return alpha’s receipt. Caching alpha’s missing receipt can also hide beta’s existing receipt. | Preserve tenant isolation on every cached read and add regression coverage for tenants sharing an ID, including missing results. |
| A2 | FOLLOW_UP | `receipts.py:1–5` | The process-local dictionary retains every distinct requested ID indefinitely. | New cache introduces retained state. | Memory grows with distinct IDs; no workload or contract establishes a blocking resource failure. | No change required for this unit; consider capacity and lifetime policy separately. |
| A3 | INVALID | Implementer evidence | RED evidence is absent, but this fixture explicitly does not require TDD. | None. | No demonstrated violation from missing RED evidence. | None. |

- Spec compliance: `FAIL`
- Task quality: `FAIL` — the added test exercises repeated reads for one tenant and misses the changed isolation boundary.
- Evidence checked: complete supplied BASE/HEAD and test; reported `python -m pytest test_receipts.py` → `1 passed`. Tests not rerun; the counterexample follows directly from inspection.
- Verdict: `NOT READY`

Case B

| ID | Disposition | Location | Proof | Candidate causal connection | Concrete failure | Required resolution |
|---|---|---|---|---|---|---|
| B1 | INVALID | `lookup.py:2–5` | Both implementations return the first exact match or None; at most ten rows are scanned. | Loop replaces equivalent generator traversal. | No performance or correctness failure demonstrated. | None. |
| B2 | INVALID | `lookup.py:3` | Exact equality preserves Unicode, case, and empty identifiers as required. | Comparison semantics are unchanged. | ASCII restriction or normalization would contradict the contract. | None. |
| B3 | INVALID | Implementer evidence | TDD is explicitly unnecessary for this behavior-preserving fixture. | None. | Missing RED evidence is not a defect. | None. |

- Spec compliance: `PASS`
- Task quality: `PASS`
- Evidence checked: complete supplied BASE/HEAD; unchanged behavioral-test coverage description; reported `python -m pytest test_lookup.py` → `5 passed`. Tests not rerun.
- FOLLOW_UP: none supported.
- Verdict: `READY`
