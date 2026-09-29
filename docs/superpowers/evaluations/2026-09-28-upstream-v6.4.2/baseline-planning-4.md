# Local CSV Import Implementation Plan

> **For agentic workers:** Use `superpowers:subagent-driven-development` when subagents are available, or `superpowers:executing-plans` otherwise. Honor an explicit execution-route override in this plan.

**Goal:** `show_import` displays every record from a user-selected UTF-8 CSV file and returns its existing friendly message when the file cannot be read.
**First delivery boundary:** Add the local reader and its tests; no external writes or new dependencies.
**Architecture:** `app.csv_import.load_rows` parses with stdlib `csv`; the existing `show_import` owns display and error translation.
**Tech Stack:** Python standard library, `unittest`.
**Spec:** `/tmp/superpowers-workflow-fixture/spec.md`
**Spec revision:** approved r1
**Risk class:** review-required
**Risk triggers:** public contract (`load_rows` is consumed across app modules)
**Verification lanes:** Task owner runs focused reader and caller tests; finishing controller runs `python3 -m unittest discover -s tests`.

The reader returns `list[dict[str, str]]`: the first CSV record supplies keys, subsequent records supply text values. During execution, establish a failing test for each new behavior before making it pass.

## Readiness Record

**Author self-review:** complete; mapped the approved behavior, caller error boundary, and test commands to Task 1.
**Independent readiness gate:** pending; required for the public contract and not dispatched in this planning-only assignment.

| ID | Disposition | Ruling or resolution | Evidence carried forward |
| --- | --- | --- | --- |
| none | FOLLOW_UP | Obtain one holistic readiness review before execution. | This record |

### Task 1: Read local CSV records

**Outcome:** `show_import(path)` displays parsed rows or its friendly read error.

**Files and ownership:** One implementation owner creates `app/csv_import.py` and `tests/test_csv_import.py`; no other file needs modification.

**Interfaces and contracts:** Consumes a `pathlib.Path` and the existing `show_import` call in `app/import_ui.py`. Produces `load_rows(path: Path) -> list[dict[str, str]]`. Open as UTF-8, parse with stdlib `csv`, use the first row as headers, and map each later row's fields to those headers. Preserve the caller's existing display format and `"Could not read this import"` error text.

**Dependencies:** none.

**Risk class and triggers:** review-required; public contract.

**Acceptance criteria:** A header plus multiple data rows returns the corresponding dictionaries of text; `show_import` renders each returned dictionary. A header-only file yields no displayed rows. Missing or unreadable input reaches the caller's friendly error; malformed UTF-8 does likewise. Empty input or a record that cannot satisfy the string-to-string mapping fails as an invalid import instead of leaking an unexpected exception or returning non-string values.

**Error handling:** Let file-read failures raise `OSError` and invalid input raise `ValueError`; `show_import` already catches both. Do not silently drop fields.

**Verification:** Run `python3 -m unittest discover -s tests -p test_csv_import.py` for parser and caller behavior. Then run `python3 -m unittest discover -s tests` for the fixture's integration suite. Expected: all new assertions and the existing `test_import_ui.py` import check pass.

**Codebase pointers:** Read `app/import_ui.py` for caller behavior, `tests/test_import_ui.py` for the existing test convention, and `spec.md` for the approved contract.

## Whole-Feature Verification

The task owner checks parsed rows, header-only input, invalid input, and the exact caller message in the focused lane. The finishing controller owns the complete suite command above after implementation. The implementation must not add external writes or dependencies.
