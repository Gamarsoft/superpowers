Case A

Selected instructions:

- `/private/tmp/sdd-review-depth-baseline/subagent-driven-development/SKILL.md`: controller selection and dispositions.
- `/private/tmp/sdd-review-depth-baseline/subagent-driven-development/task-reviewer-prompt.md`: combined specification and quality review.
- `/private/tmp/sdd-review-depth-baseline/requesting-code-review/references/java-21-spring-gke-checklist.md`: the process-local cache changes runtime behavior; cache and tenant-isolation checks apply. Java/Spring/GKE-specific checks do not apply. No specialist profiles were selected.

| ID | Disposition | Location | Proof | Candidate causal connection | Concrete failure | Required resolution |
|---|---|---|---|---|---|---|
| A1 | BLOCKING | `receipts.py:4–6` | After alpha reads `r1`, beta reading `r1` receives alpha’s cached result without calling `store.get('beta', 'r1')`. IDs are unique only within a tenant. | The new shared cache keys solely on receipt ID and bypasses the tenant-enforcing store on hits. | Cross-tenant receipt disclosure; a cached miss for one tenant can also hide another tenant’s existing receipt. | Preserve tenant isolation on cache hits and add behavioral coverage for two tenants sharing an ID, including differing existence. |
| A2 | FOLLOW_UP | `receipts.py:1–5` | Every distinct requested ID remains in the process-global dictionary without eviction. | This patch introduces the retained cache. | Memory grows with distinct requests; the supplied contract establishes no capacity or lifetime limit. | Consider an explicit cache lifecycle and capacity policy separately; no change required for this gate. |
| A3 | INVALID | Implementer RED evidence | RED evidence is absent, but TDD is expressly not required. | None establishing a defect. | No demonstrated failure from absent RED evidence. | None. |

- Spec compliance: `FAIL`
- Task quality: `FAIL`
- Evidence checked: complete supplied BASE/HEAD and added test; reported `python -m pytest test_receipts.py` → `1 passed`. The test exercises only one tenant and cannot detect A1. No tests rerun.
- Verdict: `NOT READY`

Case B

Selected instructions:

- `/private/tmp/sdd-review-depth-baseline/subagent-driven-development/SKILL.md`
- `/private/tmp/sdd-review-depth-baseline/subagent-driven-development/task-reviewer-prompt.md`

These cover this bounded Python refactor. No specialist profiles were selected; the patch introduces no persistence, deployment, or runtime configuration surface requiring the additional checklist.

| ID | Disposition | Location | Proof | Candidate causal connection | Concrete failure | Required resolution |
|---|---|---|---|---|---|---|
| B1 | INVALID | `lookup.py:1–5` | Both implementations compare IDs with `==`, return the first matching row, and return `None` otherwise. | The patch replaces the generator with an equivalent loop. | None demonstrated. | None. |
| B2 | INVALID | `lookup.py:2–3` | The contract permits at most ten rows and explicitly preserves Unicode and empty identifiers. | No new scale or identifier restriction is introduced. | Neither a performance blocker nor an ASCII restriction is justified. | None; retain the approved identifier behavior. |
| B3 | INVALID | Unchanged tests and RED evidence | Existing behavioral tests cover missing, empty-list, empty-identifier, Unicode, and first-duplicate behavior; TDD is not required. | No uncovered changed behavior is demonstrated. | None demonstrated. | None. |

- Spec compliance: `PASS`
- Task quality: `PASS`
- Evidence checked: complete supplied BASE/HEAD, stated test coverage, reported `python -m pytest test_lookup.py` → `5 passed`. No tests rerun.
- FOLLOW_UP: none supported.
- Verdict: `READY`
