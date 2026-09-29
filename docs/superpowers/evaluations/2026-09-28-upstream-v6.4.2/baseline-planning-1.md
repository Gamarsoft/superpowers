# Local CSV Reader Implementation Plan

> **For agentic workers:** Use `superpowers:subagent-driven-development` when subagents are available, or `superpowers:executing-plans` otherwise. Honor an explicit execution-route override in this plan.

**Goal:** Import a user-selected UTF-8 CSV file as header-keyed text records and show a friendly error when it cannot be read.
**First delivery boundary:** Local CSV reading and its existing `show_import` display path; no external writes.
**Architecture:** Add `app.csv_import.load_rows` using Python's standard `csv` module. Keep `show_import` as the caller and error display boundary.
**Tech Stack:** Python standard library (`csv`, `pathlib`, `unittest`); no dependencies.
**Spec:** `/tmp/superpowers-workflow-fixture/spec.md`
**Spec revision:** r1 (approved)
**Risk class:** checkpoint-review
**Risk triggers:** none
**Verification lanes:** Reader-focused tests owned by Task 1; UI integration assertions owned by Task 1; complete suite owned by the finishing controller.

The reader must open the supplied path as UTF-8, use the first CSV row as headers, and return one `dict[str, str]` per subsequent row. User-file read or decode failures must reach the existing friendly error boundary as `OSError` or `ValueError`. Do not add dependencies or write outside the local import flow. During execution, establish a failing test for each new behavior before making it pass.

### Task 1: Read and display local CSV records

**Outcome:** Valid CSV rows appear through `show_import`; unreadable files produce `Could not read this import`.

**Files and ownership:** Sole task owner creates `app/csv_import.py` and `tests/test_csv_import.py`; modify `app/import_ui.py` only if needed to preserve the approved friendly error for decode failures. Add caller-level checks to `tests/test_import_ui.py`.

**Interfaces and contracts:**
- Consumes: a user-supplied `path: pathlib.Path`; existing `show_import(path)` calls `load_rows(path)`.
- Produces: `load_rows(path: Path) -> list[dict[str, str]]` in `app/csv_import.py`.
- Preserve UTF-8 field text and header names. Header-only input yields no records. The caller continues to display each returned row.

**Dependencies:** none.

**Risk class and triggers:** checkpoint-review; none.

**Acceptance criteria:**
- A header and multiple records produce the expected list of header-to-field-text dictionaries; `show_import` displays every returned record.
- A missing or unreadable path, and a file that cannot decode as UTF-8, produce the caller's friendly error instead of an uncaught exception.
- Header-only input returns an empty list; an empty file fails with the friendly error because it has no header. Unicode text survives unchanged.

**Error handling:** File access, decoding, or missing-header failures stop the import and reach `show_import` as `OSError` or `ValueError`; do not display partial records.

**Verification:** Run `python3 -m unittest discover -s tests -p 'test_csv_import.py'` for reader evidence, then `python3 -m unittest discover -s tests -p 'test_import_ui.py'` for caller evidence. The finishing controller runs `python3 -m unittest discover -s tests` at branch completion and records its result.

**Codebase pointers:** `app/import_ui.py` holds the caller and error boundary; `tests/test_import_ui.py` has the current caller test.

## Whole-feature verification

Task 1 owns a caller-level check proving records from a real temporary CSV file reach `show_import` and that unreadable or undecodable input shows the approved error. The finishing controller runs `python3 -m unittest discover -s tests` before claiming completion. No external write is part of this feature.

## Readiness Record

**Author self-review:** complete; spec r1 requirements map to Task 1, including UTF-8, header mapping, display, and friendly read errors. The caller checks and fixture suite cover the cross-file flow.
**Independent readiness gate:** not required.

| ID | Disposition | Ruling or resolution | Evidence carried forward |
| --- | --- | --- | --- |
| none | INVALID | No readiness findings or protected risk triggers. | Task 1 focused and caller-level tests; fixture suite. |

**Handoff:** Execute this plan with `superpowers:subagent-driven-development` when available; otherwise use `superpowers:executing-plans`. Continue from `/tmp/superpowers-baseline-planning-1.md`.
