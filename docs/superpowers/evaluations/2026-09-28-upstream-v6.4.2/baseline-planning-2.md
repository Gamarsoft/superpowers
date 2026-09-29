# Local CSV Reader Implementation Plan

> **For agentic workers:** Use `superpowers:subagent-driven-development` when
> subagents are available, or `superpowers:executing-plans` otherwise. Honor an
> explicit execution-route override in this plan.

**Goal:** `show_import(path)` displays rows from a user-supplied UTF-8 CSV file and returns its existing friendly error for unreadable input.
**First delivery boundary:** Local CSV reading and its UI behavior; no external writes or dependencies.
**Architecture:** Add `load_rows` in `app/csv_import.py`; keep `show_import` as the caller and error presenter.
**Tech Stack:** Python 3 standard library (`csv`, `pathlib`, `unittest`).
**Spec:** `/tmp/superpowers-workflow-fixture/spec.md`
**Spec revision:** r1 (approved)
**Risk class:** checkpoint-review
**Risk triggers:** none; the new function is internal to this application.
**Verification lanes:** Implementer owns focused reader and UI tests; implementer runs the app test suite as integration evidence; finishing controller owns the final complete-suite run.

User files may be empty, malformed, or invalid UTF-8. Keep every returned key and value a string; reject input that cannot satisfy the declared return type with `ValueError` so the existing caller can display its friendly error. Preserve `show_import`'s current row rendering and error text. During execution, establish a failing test for each behavior before implementing it, then record its passing result.

### Task 1: Read local CSV rows and preserve import feedback

**Outcome:** The importer returns header-keyed text records, and `show_import` renders them or reports unreadable input.

**Files and ownership:** One implementer owns new `app/csv_import.py`, new `tests/test_csv_import.py`, and any needed integration assertions in `tests/test_import_ui.py`. Change `app/import_ui.py` only if a demonstrated reader error escapes its existing `(OSError, ValueError)` handler.

**Interfaces and contracts:** Consume `Path` input; produce `load_rows(path: Path) -> list[dict[str, str]]`. Decode UTF-8, use the first CSV record as headers, and map each subsequent record's field text to those headers with stdlib `csv`. No external writes or added dependencies. `show_import` continues to display each returned row and returns `Could not read this import` for unreadable input.

**Dependencies:** none.

**Risk class and triggers:** checkpoint-review; none.

**Acceptance criteria:** A header plus multiple records yields the expected list of string dictionaries, including quoted fields; a header-only file yields an empty list. Missing or unreadable files, invalid UTF-8, absent headers, and rows that cannot map to string-valued header fields fail through the caller's friendly error. Existing row display remains intact.

**Error handling:** Propagate file access errors as `OSError`; raise `ValueError` for invalid CSV content that cannot satisfy the interface, including CSV parser errors. The caller catches those errors at the import boundary.

**Verification:** Run `python3 -m unittest discover -s tests -p 'test_csv_import.py'` for reader behavior, then `python3 -m unittest discover -s tests -p 'test_import_ui.py'` for display and friendly errors. Run `python3 -m unittest discover -s tests` for integrated app evidence. Expect all tests to pass, with the new tests observed failing before implementation.

**Codebase pointers:** `/tmp/superpowers-workflow-fixture/app/import_ui.py` already imports `load_rows` and catches `OSError`/`ValueError`; `/tmp/superpowers-workflow-fixture/tests/test_import_ui.py` has the existing UI test pattern.

## Whole-Feature Verification

The implementer verifies successful multi-row display and friendly errors for unreadable and invalid user files through the caller, alongside the reader's return-type contract. The integration evidence is `python3 -m unittest discover -s tests`; the finishing controller repeats that command as the final complete-suite gate before any completion claim.

## Readiness Record

**Author self-review:** complete; r1 requirements map to Task 1, and the UTF-8, string-value, malformed-input, and UI error boundaries map to focused plus integration tests. No implementation body or unrelated change was added.
**Independent readiness gate:** not required

| ID | Disposition | Ruling or resolution | Evidence carried forward |
| --- | --- | --- | --- |
| none | — | No readiness findings or protected risk triggers. | Task 1 and whole-feature verification |

## Execution Handoff

Continue with `superpowers:subagent-driven-development` using `/tmp/superpowers-baseline-planning-2.md` and approved spec `/tmp/superpowers-workflow-fixture/spec.md`; compact the session first if useful. The executor chooses the idiomatic implementation and records red-to-green test evidence.
