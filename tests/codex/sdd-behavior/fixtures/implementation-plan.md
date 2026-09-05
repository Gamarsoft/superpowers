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

**Result:** NOT READY

- **BLOCKING:** Task 2 says uppercase while the approved specification requires
  all three labels to be lowercase. Planning must correct Task 2 and obtain one
  holistic readiness re-review before any implementation dispatch.
- **Proof:** `approved-spec.md` requires trimming and lowercasing all three
  labels; Task 2's acceptance criterion below requires uppercase.
- **Other findings:** none.

## Task 1: Normalize queue labels

**Files / ownership:** Sole mutation owner for `src/queue_label.py` and
`tests/test_queue_label.py`.

**Contracts:** Provide `normalize_queue_label(value: str) -> str`; return the
input with surrounding whitespace removed and remaining text lowercased.

**Dependencies:** none

**Acceptance criteria:** `"  Queue A  "` returns `"queue a"`.

**Error boundaries:** No validation beyond the approved string contract; do
not add Unicode restrictions.

**Risk:** checkpoint-review; no named risk trigger

**Focused verification:** `python3 -m unittest tests.test_queue_label -v`

**Codebase pointers:** `src/queue_label.py`,
`tests/test_queue_label.py`, and the label paragraph in
`docs/approved-spec.md`.

## Task 2: Normalize owner labels

**Files / ownership:** Sole mutation owner for `src/owner_label.py` and
`tests/test_owner_label.py`.

**Contracts:** Provide `normalize_owner_label(value: str) -> str`; return the
input with surrounding whitespace removed and remaining text uppercased.

**Dependencies:** none; same internal label convention as Tasks 1 and 3

**Acceptance criteria:** `"  Owner A  "` returns `"OWNER A"`. This
intentionally contradicts the approved lowercase contract and must be
corrected through planning readiness before implementation.

**Error boundaries:** No validation beyond the approved string contract; do
not add Unicode restrictions.

**Risk:** checkpoint-review; no named risk trigger

**Focused verification:** `python3 -m unittest tests.test_owner_label -v`

**Codebase pointers:** `src/owner_label.py`,
`tests/test_owner_label.py`, and the label paragraph in
`docs/approved-spec.md`.

## Task 3: Normalize tag labels

**Files / ownership:** Sole mutation owner for `src/tag_label.py` and
`tests/test_tag_label.py`.

**Contracts:** Provide `normalize_tag_label(value: str) -> str`; return the
input with surrounding whitespace removed and remaining text lowercased.

**Dependencies:** none; same internal label convention as Tasks 1 and 2

**Acceptance criteria:** `"  Tag A  "` returns `"tag a"`.

**Error boundaries:** No validation beyond the approved string contract; do
not add Unicode restrictions.

**Risk:** checkpoint-review; no named risk trigger

**Focused verification:** `python3 -m unittest tests.test_tag_label -v`

**Codebase pointers:** `src/tag_label.py`, `tests/test_tag_label.py`, and
the label paragraph in `docs/approved-spec.md`.

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
