# Smoke review results

These are the complete substantive findings and verdicts returned by the fresh
read-only reviewers named in `../controller-trace.json`. Paths refer to the
retained fixture repository.

## Plan readiness — READY

| ID | Disposition | Proof and ruling |
| --- | --- | --- |
| INV-01 | INVALID | `docs/approved-spec.md` resolves from the worktree; `sdd-smoke-base` resolves to `232c6391d64a6e59c820c402113b149c891bfb7e` and is an ancestor of HEAD. |
| INV-02 | INVALID | Every task declares sole ownership, contract, dependencies, acceptance, error boundary, risk, focused command, and pointers. |
| INV-03 | INVALID | Tasks 1-3 are same-shaped, disjoint checkpoint work; Task 4 alone carries money, concurrency, and idempotency risk. Form one three-task ordinary unit and one individual risky unit. |
| INV-04 | INVALID | Task 2 now trims and lowercases, matching the spec and Tasks 1 and 3; the earlier conflict was corrected before dispatch. |
| INV-05 | INVALID | Every task has an exact focused command; the plan separately names affected integration and the final discovery suite. |
| INV-06 | INVALID | Future task-owned files do not exist at the empty fixture base, but their explicit ownership makes creation unambiguous. |

Verdict: READY.

## Tasks 1-3 checkpoint — READY

No finding. The reviewer verified:

- exact range `ebbf4dc1e78a5437f4ff3f78ce23afec4ca57e5c..370cd9b93a7d6617e62e92b4200de970d7e96dde`;
- one commit containing only the six owned label source/test files;
- all three functions use `value.strip().lower()` and match their literal
  examples;
- the report contains separate RED/GREEN evidence and a three-test integration
  result; and
- clean worktree and diff.

Spec compliance: PASS. Task quality: PASS. Verdict: READY. The reviewer did not
rerun adequately reported tests.

## Task 4 initial review — NOT READY

| Disposition | Location | Proof | Causal failure | Required resolution |
| --- | --- | --- | --- | --- |
| BLOCKING | `src/reservations.py`, key registry and duplicate branch | The registry is `set[str]`, retaining no first balance. A focused probe returned `('already_reserved', 8999)` instead of the first `750`, and `('already_reserved', 900)` instead of the insufficient first `100`. Existing tests repeated identical arguments and hid the defect. | The changed implementation cannot replay the first result for changed later inputs, violating both the spec and Task 4. | Atomically retain each key's first resulting balance; every duplicate returns that stored value. Add reserved, insufficient, and concurrent changed-argument regressions. |

DECISION: none. FOLLOW_UP: none. INVALID: none. Verdict: NOT READY.

## Task 4 correction re-review — READY

| Prior finding | Status | Proof |
| --- | --- | --- |
| R4-1 | ADDRESSED | Exact correction range `fc5a33187e00b288e9e4625fbb36dbbcc6347abc..c4a4126bc61f889f3561647a9f4d385a8e8b38ce` changes only reservation source/tests. The locked registry now stores `key -> resulting_balance`; duplicate lookup ignores later money inputs. Three regressions first failed, then all six focused tests passed. |

No fix-introduced BLOCKING or DECISION; no FOLLOW_UP or INVALID. The complete
suite did not run. Verdict: READY.

## Final integration review — READY

| ID | Disposition | Proof and ruling |
| --- | --- | --- |
| FI-1 | FOLLOW_UP | The four-module integration passed 9 tests at `c4a4126`; finishing still owns the explicitly pending 10-test discovery suite. |
| FI-2 | INVALID | R4-1 is corrected by stored winning balance plus sequential, insufficient, and concurrent changed-argument regressions. |
| FI-3 | INVALID | The uppercase planning contradiction was corrected before implementation; plan, code, and test all produce lowercase. |
| FI-4 | INVALID | Base/tag, ancestry, clean HEAD, four-commit range, and every supplied review-package byte match were verified. |
| FI-5 | INVALID | The cumulative range contains only the planning correction and four planned source/test modules; no scope drift. |
| FI-6 | INVALID | Focused evidence and the 9-test integration cover all approved fixture behavior; no concrete in-bound failure remains. |

Spec compliance: PASS. Task quality: PASS. Unresolved decisions: none. Verdict:
READY. The reviewer inspected existing evidence without rerunning tests or the
complete suite.
