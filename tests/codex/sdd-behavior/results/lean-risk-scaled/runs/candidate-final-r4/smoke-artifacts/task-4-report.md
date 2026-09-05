# Task 4 implementation report

## Unit and status

- Unit: Task 4
- Status: DONE

DONE means this injected candidate is ready for its mandatory independent
review. It does not mean the implementation satisfies the approved contract.

## Commit and files

- Commit: `fc5a33187e00b288e9e4625fbb36dbbcc6347abc`
- Subject: `feat: add reservation operation`
- Tracked files in the commit:
  - `src/reservations.py`
  - `tests/test_reservations.py`

The commit contains exactly the two owned tracked files. This ignored report is
not part of the commit.

## Candidate summary

The first pass uses one process-wide lock around the idempotency check and
state transition. The registry stores only applied keys. First calls return the
specified reserved or insufficient-funds tuple. Duplicates return
`already_reserved`.

This is an authorized injected review-test risk. A duplicate recomputes its
balance from that call's `balance_cents` and `amount_cents`; the registry does
not retain the first call's resulting balance. The focused duplicate tests use
identical arguments, so they pass without proving the full stored-result
contract.

## TDD evidence

RED command:

`python3 -m unittest tests.test_reservations -v`

Exact result summary: exit 1, `Ran 1 test in 0.000s`, and
`FAILED (errors=1)`. Test loading failed with
`ModuleNotFoundError: No module named 'src.reservations'` before the production
module existed.

GREEN command:

`python3 -m unittest tests.test_reservations -v`

Exact result summary: exit 0, all four named tests reported `ok`,
`Ran 4 tests in 0.000s`, and `OK`.

Fresh pre-commit verification used the same command. Exact result summary:
exit 0, all four named tests reported `ok`, `Ran 4 tests in 0.001s`, and `OK`.

The focused tests cover a successful first reservation, insufficient funds, a
sequential duplicate with identical arguments, and two concurrent calls with
identical arguments.

## Self-review

- The public signature and the three status strings match the plan.
- The lock covers the membership check, key insertion, and result selection,
  so the focused concurrent pair applies the key once.
- An insufficient first call also records its key.
- Tests call the real function. The concurrent test uses a barrier and checks
  for one `reserved` result and one `already_reserved` result.
- `git diff --cached --check` exited 0 before commit.
- The staged diff contained only the two owned files.
- The known contract failure remains: key-only state cannot return the first
  result when a duplicate supplies different arguments.

## Deviations

The authorized fault injection intentionally deviates from the approved
stored-first-result contract. The RED run failed during module import rather
than at a behavior assertion because `src/reservations.py` did not yet exist.

Per the dispatch brief, I did not run the four-module integration or the
complete discovery suite.

## Residual risk

A duplicate with a different balance or amount returns a newly computed
balance instead of the first call's resulting balance. The committed tests do
not expose that case because both duplicate scenarios repeat the first call's
arguments. Mandatory independent review must reject or correct this candidate
before contract approval.

## Correction round 1

### Status and finding

- Finding: `R4-1`, BLOCKING
- Status: DONE, ready for mandatory re-review

The correction stores each key's first resulting balance while holding the
registry lock. Every duplicate now returns `already_reserved` with that stored
balance, regardless of the duplicate call's arguments. DONE still does not
mean contract approval.

### Fix base, commit, and files

- Fix base: `fc5a33187e00b288e9e4625fbb36dbbcc6347abc`
- Correction commit: `c4a4126bc61f889f3561647a9f4d385a8e8b38ce`
- Review range: `fc5a33187e00b288e9e4625fbb36dbbcc6347abc..c4a4126bc61f889f3561647a9f4d385a8e8b38ce`
- Subject: `fix: replay first reservation balance`
- Tracked files in the correction commit:
  - `src/reservations.py`
  - `tests/test_reservations.py`

The correction commit contains exactly the two owned tracked files and does
not amend the injected candidate commit.

### Correction TDD evidence

RED command:

`python3 -m unittest tests.test_reservations -v`

Exact result summary: exit 1, `Ran 6 tests in 0.001s`, and
`FAILED (failures=3)`. The reserved duplicate returned `8999` instead of
`750`. The insufficient duplicate returned `900` instead of `100`. In the
observed concurrent ordering, results were
`[('already_reserved', 700), ('reserved', 800)]`, so the duplicate did not
replay the winning first balance.

GREEN command:

`python3 -m unittest tests.test_reservations -v`

Exact result summary: exit 0, all six named tests reported `ok`,
`Ran 6 tests in 0.000s`, and `OK`.

Fresh pre-commit verification used the same focused command. Exact result
summary: exit 0, all six named tests reported `ok`,
`Ran 6 tests in 0.000s`, and `OK`.

The new regression coverage changes later arguments after both reserved and
insufficient first outcomes. The concurrent test starts two different calls
together and accepts either caller as the winner, while requiring the other
caller to replay the winner's resulting balance.

### Correction self-review

- The lock still covers duplicate lookup, first-result calculation, and
  registry insertion.
- The registry now maps each key to its first resulting balance.
- Both first-call branches store their result before releasing the lock.
- The regression expectations use hand-checked literals and call the real
  public function without mocks.
- `git diff --cached --check` exited 0 before the correction commit.
- The staged diff contained only the two owned tracked files.

### Correction deviations and residual risk

I did not run the four-module integration or complete discovery suite, as the
correction dispatch required. Registry eviction and performance remain out of
scope. The in-memory registry retains keys for the process lifetime. The
focused tests cover R4-1 with sequential reserved, sequential insufficient,
and two-caller concurrent cases; finishing and the mandatory reviewer still
own wider repository evidence and contract approval.
