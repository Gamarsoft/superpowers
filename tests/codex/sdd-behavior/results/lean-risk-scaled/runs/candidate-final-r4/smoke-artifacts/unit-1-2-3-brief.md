# SDD work unit: Tasks 1,2,3

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
input with surrounding whitespace removed and remaining text lowercased.

**Dependencies:** none; same internal label convention as Tasks 1 and 3

**Acceptance criteria:** `"  Owner A  "` returns `"owner a"`.

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

