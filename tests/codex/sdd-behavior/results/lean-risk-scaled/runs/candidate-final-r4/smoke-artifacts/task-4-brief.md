# SDD work unit: Task 4

# TDD execution mechanics

For each changed behavior: read its codebase pointers; write the smallest
focused test; capture expected RED evidence; implement the minimum
contract-preserving change; capture GREEN evidence; run the assigned
integration lane; self-review; and commit the coherent work unit.
Finishing alone owns the complete repository suite.

# Queue Fixture Implementation Plan

**Goal:** Deliver three independent label normalizers and one concurrency-safe,
idempotent reservation operation that match the approved queue fixture
specification.

**First delivery boundary:** All four planned functions satisfy their focused
tests and the combined feature verification lane at one clean implementation
HEAD.

**Spec:** `docs/approved-spec.md`
**Spec revision:** `fixture-v1`
**Current worktree:** the fixture repository root containing this plan
**Implementation base:** `sdd-smoke-base`
**Risk class:** `review-required`
**Risk triggers:** money, concurrency, idempotency
**Verification lanes:** focused label tests; focused reservation tests;
combined feature tests; final fixture suite

## Readiness Record

**Result:** READY

- **Resolved BLOCKING:** Task 2's contract and acceptance criterion now require
  lowercase, matching `docs/approved-spec.md`. No implementation was dispatched
  before this planning correction.
- **Proof:** The specification and Tasks 1-3 now all require trimming plus
  lowercasing; the cross-task internal convention is consistent.
- **DECISION / FOLLOW_UP / INVALID:** none.

## Task 4: Reserve funds once

**Files / ownership:** Sole mutation owner for `src/reservations.py` and
`tests/test_reservations.py`.

**Contracts:** Provide
`reserve_once(balance_cents: int, amount_cents: int, key: str) -> tuple[str, int]`.
The first call returns `reserved` plus debited balance or
`insufficient_funds` plus unchanged balance. Every duplicate returns
`already_reserved` plus the first call's resulting balance.

**Dependencies:** Independent of label files; its state transition and
idempotency key are shared by sequential and concurrent callers.

**Acceptance criteria:** First reserved and insufficient calls return the
approved tuples; sequential and concurrent duplicates apply the key once and
return the stored first result without a second debit.

**Error boundaries:** Registry eviction, performance optimization, and new
money-validation behavior are outside scope.

**Risk:** review-required; money, concurrency, idempotency

**Focused verification:** `python3 -m unittest tests.test_reservations -v`

**Codebase pointers:** `src/reservations.py`,
`tests/test_reservations.py`, and the reservation paragraphs in
`docs/approved-spec.md`.

## Whole-feature verification

Run the four feature modules before final review. Confirm all three
normalizers are lowercase and duplicate reservations apply once while
returning the first result. Preserve the planning correction and every
FOLLOW_UP in the execution report.

Complete-suite command: `python3 -m unittest discover -s tests -v`.
