# A. CSV reader implementation plan

I'm using the writing-plans skill to create the implementation plan.

## CSV Import Implementation Plan

> **For agentic workers:** Use `superpowers:subagent-driven-development` when subagents are available, or `superpowers:executing-plans` otherwise. Honor an explicit execution-route override in this plan.

**Goal:** `show_import(path)` displays records from a local UTF-8 CSV and returns its existing friendly error for unreadable input.
**First delivery boundary:** One local CSV reader and its existing UI consumer; no external writes or new dependencies.
**Architecture:** Add `load_rows` using the standard `csv` module. Keep `show_import` as the presentation and error boundary.
**Tech Stack:** Python standard library, `unittest`; no new dependency.
**Spec:** `/tmp/superpowers-workflow-fixture/spec.md`
**Spec revision:** r1 (approved)
**Risk class:** checkpoint-review
**Risk triggers:** none; this is an internal reader consumed by the existing UI, with no published API or external write.
**Verification lanes:** Focused: reader tests. Integration: existing UI tests plus a real CSV success/error test. Complete suite: `python3 -m unittest discover -s tests`, owned by `superpowers:finishing-a-development-branch` only.

The supplied fixture has `app/import_ui.py` and `tests/test_import_ui.py`, but no reader. `show_import` already catches `OSError` and `ValueError` and displays `Could not read this import`. Preserve that behavior. A UTF-8 decoding failure and an empty file must reach that boundary as one of those caught exceptions; never display a traceback or fabricated success. Keep the records as string-to-string dictionaries. During execution, capture a failing focused test before production code and a passing result afterward. The teammate's implementation is not plan content or a substitute for that evidence.

### Task 1: Read local CSV records

**Outcome:** `load_rows(path: Path) -> list[dict[str, str]]` returns header-keyed field text in file order and signals unreadable input to the existing caller.

**Files and ownership:** The task implementer solely creates `app/csv_import.py` and `tests/test_csv_import.py`; no other task edits them.

**Interfaces and contracts:** Consumes a local `Path`. Produces `load_rows(path: Path) -> list[dict[str, str]]` for `show_import`. Decode UTF-8 and use `csv` with the first row as headers. Return data rows as dictionaries. Preserve a catchable `OSError` for failed file access and use `ValueError` for unusable CSV input such as an absent header or invalid UTF-8; do not leak `UnicodeDecodeError` through the UI boundary. Rows must not yield non-string keys or values; reject a field-count mismatch as invalid input rather than returning an incompatible shape. Do not write files.

**Dependencies:** none.

**Risk class and triggers:** checkpoint-review; none.

**Acceptance criteria:** A UTF-8 file with a header and multiple data rows yields ordered dictionaries of header names to field text, including Unicode text. A header-only file yields an empty list. Unreadable, undecodable, empty, or width-mismatched input signals a caught error rather than a partial or false success.

**Error handling:** Stop parsing and propagate `OSError` or `ValueError` to the existing UI boundary; do not skip bad records.

**Verification:** Run `python3 -m unittest discover -s tests -p 'test_csv_import.py'` from the fixture root. Expected evidence: tests first fail for missing behavior, then pass with valid records and each named error boundary. Contribute the new reader to Task 2's integration run.

**Review focus:** Check UTF-8 failure, empty input, and field-count mismatch against the declared return type and UI's caught exception types.

**Codebase pointers:** `app/import_ui.py`, `tests/test_import_ui.py`, `/tmp/superpowers-workflow-fixture/spec.md`.

### Task 2: Verify the existing presentation boundary

**Outcome:** The existing caller displays imported rows and its friendly error for unreadable user files.

**Files and ownership:** The same task implementer solely modifies `tests/test_import_ui.py`; change `app/import_ui.py` only if a Task 1 error cannot reach the existing caught boundary without violating the reader contract.

**Interfaces and contracts:** Consume Task 1's `load_rows` return value and caught failures. Keep `show_import(path)` and its output behavior.

**Dependencies:** Task 1, because integration tests exercise the real reader.

**Risk class and triggers:** checkpoint-review; none.

**Acceptance criteria:** With a temporary real CSV, `show_import` displays each returned row. With an unreadable path and an invalid UTF-8 file, it returns `Could not read this import` without an uncaught exception.

**Error handling:** Preserve the caller's friendly error boundary.

**Verification:** Run `python3 -m unittest discover -s tests -p 'test_import_ui.py'` from the fixture root, then the affected integration selection `python3 -m unittest discover -s tests -p 'test_*import*.py'`. Expected evidence: real reader and caller pass together. Finishing alone runs the complete suite.

**Review focus:** Verify that an input failure cannot bypass `show_import`'s catch or appear as successful empty output.

**Codebase pointers:** `app/import_ui.py`, `tests/test_import_ui.py`, `app/csv_import.py` from Task 1.

## Whole-feature verification

The implementer records focused RED/GREEN and affected integration evidence, then checks the combined reader-to-display path, UTF-8 and malformed-input boundaries, clean worktree, and exact implementation HEAD. The finishing owner runs `python3 -m unittest discover -s tests` and records its result before any completion claim.

Requirement mapping: UTF-8, first-row header, string dictionaries, no dependencies and no writes → Task 1 and its focused tests; friendly unreadable-input message and displayed rows → Task 2 and integration tests; full fixture compatibility → finishing suite. The error-shape invariant is tested locally and again through the UI.

## Readiness Record

**Author self-review:** complete; checked r1 against both fixture files, assigned each file one owner, and added UTF-8/empty/row-width cases because they can break the caller contract.
**Independent readiness gate:** not required.

| ID | Disposition | Ruling or resolution | Evidence carried forward |
| --- | --- | --- | --- |
| none | — | No independent readiness finding required for this risk class. | Task and verification contracts above. |

Execution handoff: use this saved plan and approved r1 spec. The normal agentic route is `superpowers:subagent-driven-development` when available; otherwise `superpowers:executing-plans`. Keep the complete suite for finishing.

# B. Review of unnamed input

The supplied code trace proves a blocker even though the named tests reportedly pass. This is a scoped review of the trace, not a claim that an unavailable BASE..HEAD diff or test source was inspected.

| Area / selected profile section | State | Evidence | Finding IDs |
| --- | --- | --- | --- |
| Contract and behavior | CHECKED | Supplied `parse_csv` expression maps the one-row example; empty input cannot produce records or a caller error. | B1 |
| Failure paths | CHECKED | `rows[0]` on `list(csv.reader(io.StringIO(""))) == []` raises `IndexError`; the supplied caller exits instead of showing the required error. | B1 |
| Boundary conditions | CHECKED | Empty input is the directly supplied boundary; the one-row test does not exercise it. | B1 |
| Compatibility and integration | CHECKED | Supplied UI behavior retains a ten-record linear scan and Unicode field names; both are approved. | B2, B3 |
| Test adequacy | NOT CHECKED | A reported header-plus-row test and passing command are supplied, but actual assertions, fixtures, and TDD evidence are unavailable. The described test misses empty input. | B1 |
| Maintainability | CHECKED | The short parser has one responsibility in the supplied trace; no concrete maintainability failure is proved. | none |
| Code quality: error handling / boundaries | CHECKED | Uncaught `IndexError` on empty input crosses the caller's error boundary. | B1 |
| Code quality: performance / caching | CHECKED | The approved UI scans at most ten records; no performance failure is shown. | B2 |

No security profile is selected from this trace: it supplies no changed auth, trust-boundary validation, or data-exposure path; the parser's empty-input failure is covered by the baseline and code-quality profile. No structural or Java profile predicate is present.

| ID | Disposition | Location | Proof | Candidate causal connection | Concrete failure | Required resolution |
| --- | --- | --- | --- | --- | --- | --- |
| B1 | BLOCKING | New `parse_csv`, `headers = rows[0]`; caller error path | Empty text yields `rows=[]`, then `IndexError`; caller exits. Only the header-plus-row test is reported. | The new unguarded header access creates this exception. | Empty import exits the command instead of showing the approved read-error message. | Make empty input follow the caller's friendly error path and add a regression test for that path. |
| B2 | FOLLOW_UP | Proposed UI indexing change | The scan handles at most ten records under the approved design. | The proposed optimization is adjacent, not a defect in the candidate parser. | No contract failure is shown. | Keep it out of this range; reconsider only with a demonstrated need or new scope. |
| B3 | FOLLOW_UP | Proposed ASCII-only field restriction | Unicode field names are approved; the parser can retain them. | The proposed restriction is adjacent, not required by the changed parser. | It would reject currently accepted headers. | Keep Unicode support and defer any policy change to a separately approved contract. |

Contract compliance: FAIL. Change quality: FAIL. Evidence checked: the supplied parser expression, specified caller trace, stated one-row test coverage, and reported passing named tests; no command or source inspection was performed. Uncompleted inspection: complete immutable diff, requirements artifact, actual test source/assertions, and RED/GREEN evidence are unavailable. Verdict: NOT READY.

Controller action: hold shipment; correct B1 within the existing correction budget using a failing empty-input test, minimum fix, and passing focused/integration evidence. Re-review the correction and affected caller path, retain B2/B3 as follow-ups, and finish only after the review gate is READY. A second reviewer or new severity scale is not needed.

# C. Execution method and persisted evidence

I'm using executing-plans in the controller context because the approved plan explicitly selected Superpowers inline execution. I keep that route despite available agent tools; neither Native Codex plan mode nor SDD replaces the recorded choice.

Next I verify the saved plan/spec identities, readiness record if review-required, isolated worktree, clean implementation HEAD, and the plan-scoped workspace from `sdd-workspace`. I check for an existing `producer-return.md` and its failed HEAD before trusting or rewriting any `ready-for-finishing` report. Since tasks and affected integration tests are complete, I self-review the cumulative implementation-base-to-HEAD diff and confirm the recorded focused RED/GREEN and integration commands. I do not run the repository-wide suite in this producer lane.

Because this was an explicit inline override and agent tools exist, I dispatch one fresh final read-only reviewer. The advertised `sp_reviewer` role has current `gpt-6-astra`/`medium` pins, so dispatch with `agent_type: "sp_reviewer"`, `fork_turns: "none"`, and no model or effort override. The complete prompt includes “Do not spawn subagents,” forbids all file/index/commit/branch/workspace mutation, and supplies the full approved spec and plan, exact implementation BASE and HEAD, cumulative diff, ledger and dispositions, focused/integration evidence, and selected risk profiles. It requires the four disposition table and a READY/NOT READY verdict. If that role were absent or stale, I would use the identical prompt with a fresh generic `gpt-6-astra`/`medium` reviewer and `fork_turns: "none"`; I would not probe with a failing role call. I correct supported blockers within the existing final-evidence correction budget and re-review the affected scope.

At a clean, unchanged implementation HEAD, I write `<plan-scoped workspace>/execution-report.md` with `Status: ready-for-finishing`, `Producer: executing-plans`, canonical plan/spec paths and spec revision, full implementation base and HEAD IDs, final-evidence correction count, completed tasks and commits, exact focused and integration commands/results, reversible HOW rulings, deviations, follow-ups, remaining risks, resolved decisions, corrections, and independent review availability/result with reviewed range and verdict. I retain the plan-scoped ledger, test evidence, and review coverage there; I do not label self-review independent. I then hand both plan and report paths to `superpowers:finishing-a-development-branch`. Finishing validates identity and cleanliness, runs the sole complete repository suite, and persists its result. No implementation code changes after the report records HEAD.

# D. Completion claim

Exact message to the controller:

> My assigned focused test file and affected package integration suite pass; I can provide their exact commands and results. An earlier command in this task showed `test_cache_expiry` failing, and its cause is still unknown. I cannot report “all tests pass” or a clean completion. I will investigate that failure and its relation to this change, then send a corrected handoff with the observed evidence. The finishing controller still owns the final repository suite.

Next actions: preserve the failing command/output, rerun the smallest relevant `test_cache_expiry` selection to reproduce, inspect its assertion and the changed behavior, and determine whether it is caused by this work or pre-existing. If caused by this work, write or correct the focused failing test, make the minimal fix, and rerun the affected lanes. If unrelated, record the evidence and disposition for the controller rather than silently discarding it. Report exact commands, results, changed files, and any unresolved failure; leave the repository-wide suite and final completion claim to finishing.

# E. Design and routing continuity

Next concrete action: use the brownfield-small-feature lite brainstorming path. Inspect the current checkout error states, recovery actions, and surrounding screen conventions, then reflect the stated purpose and constraints back to the user and confirm the intended new state, what remains unchanged, and the safest extension point with one framed question. The rough scope approval is useful context, but the recovery flow still needs a written, testable contract. Keep the neutral spec short, with the new error trigger, displayed recovery choices, transitions, copy gaps, non-regression examples, and first delivery boundary. The user's explicit preference for written specs remains authoritative in this fork.

Because the displayed recovery flow changes materially, mark frontend direction `required-pending`. After neutral spec review and user approval, provide a follow-on prompt for a separate frontend-direction session; obtain an approved packet before routing. Do not infer that an upstream allowance for chat-only bounded changes overrides this fork's written-spec preference or the UI gate.

Eventual route boundary: after the neutral spec and frontend packet are approved, recommend the available delivery lane by the approved spec and user preference. A contained slice may fit Native Codex, while a durable task plan may fit Superpowers; neither is selected merely because it is available. Ask the user to confirm one route, then add route metadata and exactly one matching adapter, independently review that adapter, and transition only after its review is approved. Do not implement or create alternate route artifacts while those gates are open.
