# Local CSV Import Implementation Plan

> **For agentic workers:** Use `superpowers:subagent-driven-development` when subagents are available, or `superpowers:executing-plans` otherwise. Honor an explicit execution-route override in this plan.

**Goal:** `show_import` displays rows from a user-selected UTF-8 CSV file and returns its existing friendly message when the input cannot be read.
**First delivery boundary:** Add the local reader and its tests; no new UI, dependencies, or external writes.
**Architecture:** A small stdlib `csv` reader in `app/csv_import.py` supplies the existing `show_import` call in `app/import_ui.py`.
**Tech Stack:** Python 3 standard library (`csv`, `pathlib`, `unittest`); no third-party dependencies.
**Spec:** `/tmp/superpowers-workflow-fixture/spec.md`
**Spec revision:** Approved r1.
**Risk class:** checkpoint-review
**Risk triggers:** none; this is an internal local reader consumed by the existing UI.
**Verification lanes:** Task 1 owns focused reader tests, the `show_import` integration check, and the complete fixture suite.

## Context

Use UTF-8 and the first CSV record as field names. Return one `dict[str, str]` per later record, preserving text. A header-only file returns `[]`. Empty input, malformed CSV, or a row that cannot map every header to exactly one text value raises `ValueError`; file access errors remain `OSError`. This keeps the existing `show_import` error boundary effective. No product behavior beyond approved r1 is added. During execution, show a failing test before each behavior is implemented, then its passing result.

## Task 1: Read and display local CSV rows

**Outcome:** Valid files produce row dictionaries, while unreadable input produces `Could not read this import` through `show_import`.

**Files and ownership:** Create `app/csv_import.py` and `tests/test_csv_import.py` (sole mutation owner: Task 1). Read `app/import_ui.py` and `tests/test_import_ui.py`; no changes to them are expected.

**Interfaces and contracts:** Consume `Path` input and the existing `show_import(path)` call. Produce `load_rows(path: Path) -> list[dict[str, str]]` in `app.csv_import`. Open with UTF-8 and CSV-compatible newline handling; use stdlib `csv`. Preserve the UI's existing `OSError`/`ValueError` catch and row display.

**Dependencies:** none.

**Risk class and triggers:** checkpoint-review; none.

**Acceptance criteria:** A file with a header and multiple records returns ordered row dictionaries containing the exact field text, including Unicode and quoted delimiters. Header-only input returns an empty list. Empty, malformed, and mismatched-width records raise `ValueError`; a missing or unreadable file raises `OSError`. `show_import` displays valid returned rows and its existing friendly message for unreadable input.

**Error handling:** Reject invalid CSV structure with `ValueError`, including `csv.Error` converted at the reader boundary. Let `OSError` and UTF-8 decoding failure reach the UI's existing catch (decoding failure is a `ValueError`). Do not return partial rows after an error.

**Verification:** From `/tmp/superpowers-workflow-fixture`, run `python3 -m unittest discover -s tests -p 'test_csv_import.py'`; expect focused reader and UI boundary tests to pass. Then run `python3 -m unittest discover -s tests`; expect the full fixture suite to pass. Use temporary files in tests, including a nonexistent path and invalid UTF-8 bytes.

**Codebase pointers:** `app/import_ui.py` contains the current call and error message; `tests/test_import_ui.py` shows the existing unittest style; `spec.md` is the complete approved behavior.

## Whole-feature verification

Task 1 owns the valid-row display and friendly-error integration assertions, including invalid UTF-8 and malformed CSV. Its focused command proves the reader/UI boundary; `python3 -m unittest discover -s tests` is the complete-suite command for finishing. Confirm no file is written by the import path.

## Readiness Record

**Author self-review:** Complete. Approved r1 maps to Task 1: reader signature, UTF-8/header mapping, UI display, friendly error, stdlib-only implementation, and no external writes. Dangerous input and the UI boundary map to focused integration tests and the full suite.
**Independent readiness gate:** not required.

| ID | Disposition | Ruling or resolution | Evidence carried forward |
| --- | --- | --- | --- |
| none | — | No independent findings; no named risk trigger. | Task 1 focused and whole-feature verification. |

## Execution Handoff

Compact before execution. Continue with: “Execute `/tmp/superpowers-baseline-planning-3.md` using `superpowers:subagent-driven-development` if agents are available, or `superpowers:executing-plans` otherwise. Preserve the approved r1 scope and run both verification commands.”
