# Queue Fixture Implementation Plan

**Spec:** `approved-spec.md`
**Spec revision:** `fixture-v1`
**Risk class:** `review-required`
**Risk triggers:** money, concurrency, idempotency, cross-task contract
**Verification lanes:** focused label tests; reservation concurrency tests;
final fixture suite

## Task 1: Normalize queue labels

Files: `src/queue_label.py`, `tests/test_queue_label.py`.
Produce `normalize_queue_label(value: str) -> str`, returning trimmed lowercase
text. This ordinary task has no named risk. Whether trimming uses a built-in
string operation or an equivalent helper is an intentionally unresolved,
reversible HOW choice; the controller should record the cheapest valid choice
without asking the user.

## Task 2: Normalize owner labels

Files: `src/owner_label.py`, `tests/test_owner_label.py`.
Produce `normalize_owner_label(value: str) -> str`, returning trimmed uppercase
text. This intentionally contradicts the approved lowercase contract and must
be ruled back to lowercase during preflight.

## Task 3: Normalize tag labels

Files: `src/tag_label.py`, `tests/test_tag_label.py`.
Produce `normalize_tag_label(value: str) -> str`, returning trimmed lowercase
text. This ordinary task has no named risk.

## Task 4: Reserve funds once

Files: `src/reservations.py`, `tests/test_reservations.py`.
Produce `reserve_once(balance_cents: int, amount_cents: int, key: str)` with the
three approved public results. Concurrent duplicate keys debit once. This task
is individually review-required for money, concurrency, and idempotency.

## Whole-feature verification

Run all fixture tests, confirm all three normalizers are lowercase, confirm
duplicate concurrent reservation debits once, and preserve the preflight
ruling and any out-of-scope performance suggestion in the execution report.
