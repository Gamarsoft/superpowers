# Unit 1 implementation report

## Unit and status

- Unit: Unit 1
- Task IDs: Task 1, Task 2, Task 3
- Status: DONE

## Commit and files

- Commit: `370cd9b93a7d6617e62e92b4200de970d7e96dde`
- Subject: `feat: add label normalizers`
- Tracked files in the commit:
  - `src/queue_label.py`
  - `src/owner_label.py`
  - `src/tag_label.py`
  - `tests/test_queue_label.py`
  - `tests/test_owner_label.py`
  - `tests/test_tag_label.py`

The commit contains exactly the six owned tracked files. This ignored report is
not part of the commit.

## Summary

Implemented the three public label normalizers. Each accepts the specified
string input, removes surrounding whitespace, and lowercases the remaining
text. Added one focused acceptance test per normalizer.

## TDD evidence

Task 1 RED:

`python3 -m unittest tests.test_queue_label -v`

Result: expected failure, 1 test run and 1 failure. The failure was
`No module named 'src.queue_label'`, before `src/queue_label.py` existed.

Task 1 GREEN:

`python3 -m unittest tests.test_queue_label -v`

Result: 1 test run, OK.

Task 2 RED:

`python3 -m unittest tests.test_owner_label -v`

Result: expected failure, 1 test run and 1 failure. The failure was
`No module named 'src.owner_label'`, before `src/owner_label.py` existed.

Task 2 GREEN:

`python3 -m unittest tests.test_owner_label -v`

Result: 1 test run, OK.

Task 3 RED:

`python3 -m unittest tests.test_tag_label -v`

Result: expected failure, 1 test run and 1 failure. The failure was
`No module named 'src.tag_label'`, before `src/tag_label.py` existed.

Task 3 GREEN:

`python3 -m unittest tests.test_tag_label -v`

Result: 1 test run, OK.

After the focused GREEN runs, I moved each import to normal module scope and
reran all three exact focused commands. Each ran 1 test and returned OK.

## Label-only integration

Command:

`python3 -m unittest tests.test_queue_label tests.test_owner_label tests.test_tag_label -v`

Result: 3 tests run, OK.

I did not run the complete discovery suite, as required by the unit brief.

## Self-review

- Each function name, string type hint, and return type matches the plan.
- Each implementation uses the controller's exact `value.strip().lower()`
  ruling.
- No validation, Unicode restriction, shared abstraction, or unrelated change
  was added.
- Each test calls the real public function and checks the plan's literal
  acceptance example.
- Removing either `strip()` or `lower()` makes the matching test fail, so the
  required behavior is protected.
- The staged diff passed `git diff --cached --check` and contained only the six
  owned files.

No self-review finding remains open.

## Controller ruling and reversible cost

Applied `value.strip().lower()` to all three internal helpers. If that ruling
changes, the reversible cost is one private-helper refactor plus three focused
test reruns.

## Deviations

No implementation or verification deviation from the unit brief. The assigned
fixture repository is a normal checkout on `main`, not a linked worktree. I
worked in that explicitly assigned repository and did not create another
workspace.

## Follow-ups

SDD, not finishing, will run the affected four-module integration after Task 4.
Finishing alone runs the complete discovery suite.

## Residual risk

Task 4 is outside this unit, so this report does not establish the combined
label and reservation behavior. Python's standard `lower()` semantics are used
without extra Unicode policy, matching the approved scope.
