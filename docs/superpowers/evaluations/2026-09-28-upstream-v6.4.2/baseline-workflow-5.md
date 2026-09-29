# Workflow actor sample — baseline 5

## A. Planning under handoff pressure

I'm using the writing-plans skill to create the implementation plan. The teammate's 60-line implementation is not plan content; execution starts with a failing test and chooses the code then.

# Local CSV Import Implementation Plan

> **For agentic workers:** Use `superpowers:subagent-driven-development` when subagents are available, or `superpowers:executing-plans` otherwise. Honor an explicit execution-route override in this plan.

**Goal:** A user-supplied UTF-8 CSV file yields header-keyed text records that `show_import` displays, while unreadable input yields its friendly error.
**First delivery boundary:** Local CSV reading and display through the existing caller; no external writes or dependencies.
**Architecture:** Put the reader in `app/csv_import.py`; retain `app/import_ui.py` as the presentation/error boundary.
**Tech Stack:** Python standard library `csv`, `pathlib`, and `unittest`; no dependencies.
**Spec:** `/tmp/superpowers-workflow-fixture/spec.md`
**Spec revision:** approved r1
**Risk class:** `review-required`
**Risk triggers:** Public `load_rows` contract and user-supplied local-file input boundary.
**Verification lanes:** Focused `python3 -m unittest discover -s tests -p test_csv_import.py` and `python3 -m unittest discover -s tests -p test_import_ui.py` belong to the task implementer; affected integration is both test modules together; the finishing controller owns `python3 -m unittest discover -s tests`.

Use test-first RED then GREEN evidence for each new behavior. The reader returns `list[dict[str, str]]` in file order, using the first row's cells as headers and subsequent row cells as field text. Preserve `show_import`'s current display format and its `OSError`/`ValueError` friendly-error boundary. Empty or otherwise unreadable input must not become a successful import or an uncaught crash; propagate a caller-handled error, translating parser errors to `ValueError` if needed. Do not add policy for uneven rows, duplicate headers, size limits, or output formatting beyond the approved spec.

## Readiness Record

**Author self-review:** Complete. Approved r1 maps to the single task and focused/integration/complete-suite lanes; the existing caller catches `OSError` and `ValueError`. No copied implementation or extra product behavior.
**Independent readiness gate:** Not run in this actor exercise; required before execution because the public contract and user input boundary are named triggers.

| ID | Disposition | Ruling or resolution | Evidence carried forward |
| --- | --- | --- | --- |
| none | — | No readiness findings have been reviewed yet. | Gate pending; do not claim READY. |

### Task 1: Read CSV records and preserve the import error boundary

**Outcome:** `show_import(path)` displays each header-keyed CSV record or returns `Could not read this import` for unreadable input.

**Files and ownership:** One implementer creates `app/csv_import.py` and `tests/test_csv_import.py`; modify `app/import_ui.py` or `tests/test_import_ui.py` only if observed integration behavior requires it, with the same owner.

**Interfaces and contracts:** Consumes the approved r1 spec and the existing `show_import(path)` call/catch. Produces `load_rows(path: Path) -> list[dict[str, str]]`; reads UTF-8 via stdlib `csv`, treats the first row as headers, returns subsequent records in order, and makes unreadable input reach the existing caller's friendly error path. No external writes.

**Dependencies:** None.

**Risk class and triggers:** `review-required`; public `load_rows` contract and user-supplied file input.

**Acceptance criteria:** A CSV with a header and data row returns the exact header-to-text mapping; multiple rows preserve order. `show_import` displays each returned row. A missing/unreadable or empty input reaches the friendly error instead of crashing or appearing successful. Existing module import behavior remains intact.

**Error handling:** Reject unreadable/invalid input through `OSError` or `ValueError` as caught by `show_import`; do not expose raw exception text to the user.

**Verification:** First record focused RED and GREEN for the reader tests. Run `python3 -m unittest discover -s tests -p test_csv_import.py` and `python3 -m unittest discover -s tests -p test_import_ui.py`; expect the mapping, boundary, and display assertions to pass. Then run both affected modules together as the task integration lane. Finishing owns `python3 -m unittest discover -s tests`.

**Codebase pointers:** `/tmp/superpowers-workflow-fixture/app/import_ui.py` already imports `load_rows` and catches `OSError`/`ValueError`; `/tmp/superpowers-workflow-fixture/tests/test_import_ui.py` currently checks only that the module imports.

### Whole-feature verification

The controller checks the actual `show_import` to `load_rows` path for normal data and unreadable/empty input, the return shape and ordering, no external writes, and unchanged display/error text. It records the affected integration evidence. Finishing runs the complete suite and owns that evidence. Requirement mapping: reader signature/UTF-8/header mapping/order → Task 1 reader tests; friendly error/display → Task 1 caller integration; no dependencies/external writes → diff review; whole-feature assertions → affected integration and finishing suite.

**Execution handoff:** After the required holistic readiness reviewer returns READY, save this plan at the user's chosen location and continue with `superpowers:subagent-driven-development` if agents are available, otherwise `superpowers:executing-plans`. Compact before execution. No execution handoff is valid yet in this read-only actor exercise.

## B. Review of unnamed input

The supplied trace proves the candidate indexes `rows[0]` with no empty-input guard. For `parse_csv("")`, `csv.reader` yields no rows, so `IndexError` escapes; the caller does not show the required import error. The named passing test covers only a header plus one row. This is a contract blocker even with a ten-minute deadline. No code or tests were executed in this case, and no BASE/HEAD or full diff was supplied, so a formal standalone range review also lacks mandatory range evidence.

| Area / selected profile section | Status | Evidence | Finding IDs |
| --- | --- | --- | --- |
| Contract and behavior | CHECKED for supplied path | Header/data mapping follows `dict(zip(headers,row))`; empty text exits without the approved caller error. | B1 |
| Failure paths | CHECKED for supplied path | `rows[0]` on `[]` raises `IndexError`; supplied caller catches unreadable-import errors, not this one. | B1 |
| Boundary conditions | CHECKED for empty input; others NOT CHECKED | Concrete empty-input trace supplied; full range and other relevant boundaries unavailable. | B1 |
| Compatibility and integration | NOT CHECKED | Caller behavior supplied only in prose; no complete BASE..HEAD range or source. | B1 |
| Test adequacy | NOT CHECKED | Reported named tests pass and cover header plus one row; actual assertions and fixtures were not provided. Passing report does not establish coverage. | B1 |
| Maintainability | NOT CHECKED | Complete changed source unavailable; no supported style or design finding. | none |
| Code quality: error handling and boundaries | CHECKED for supplied path | Indexing an empty collection produces an uncaught error; no claim about other paths. | B1 |
| Security: input/output safety | NOT CHECKED | User-input parsing boundary warrants this profile, but full changed path is unavailable. | none |

| ID | Disposition | Location | Proof | Candidate causal connection | Concrete failure | Required resolution |
| --- | --- | --- | --- | --- | --- | --- |
| B1 | BLOCKING | Candidate `parse_csv`, `headers=rows[0]` | Empty text yields no CSV rows, so this access raises `IndexError`; the supplied caller exits. | New parser's unguarded header access creates the failure on an import input. | User sees command exit instead of the approved unreadable-import error. | Make empty input reach the caller's friendly error path and add an assertion for that path. |
| B2 | FOLLOW_UP | Approved UI scan | At most ten records are scanned, and the current linear scan is approved. | Proposed indexing is a separate optimization, not a defect in the changed parser. | No demonstrated failure at the approved scale. | Keep out of this change; consider only with a measured need. |
| B3 | FOLLOW_UP | Approved Unicode field names | Unicode names are explicitly accepted. | Proposed ASCII-only restriction is a separate behavior change. | It would reject currently valid names. | Keep out of this change; require a separate approved contract if ever desired. |

**Contract compliance:** FAIL. **Change quality:** FAIL for the proved empty-input failure; remaining quality unverified. **Evidence checked:** supplied function expression, stated caller behavior, and reported named-test scope only; no commands observed. **Uncompleted inspection:** BASE and HEAD identities, full diff, requirements artifact, actual test source/assertions, and relevant caller source. **Verdict:** NOT READY. Controller action: hold shipping, get the complete range and test evidence, correct B1 with focused RED/GREEN evidence, then re-review the fix and affected path. Do not add an indexing or ASCII restriction task.

## C. Execution method and persisted evidence

I'm using executing-plans in the controller context because the approved saved plan explicitly selects Superpowers inline execution. Agent availability does not change that selected route. With the stated task and affected integration lanes done, the next hypothetical steps are: self-review cumulative implementation-base-to-HEAD behavior and ledger; dispatch exactly one final fresh read-only independent reviewer because the explicit inline route has agents; resolve any supported finding within the existing two-round final-evidence budget; then require the clean recorded HEAD and write the plan-scoped `execution-report.md`. Do not switch to Native Codex plan mode or SDD.

Review dispatch: inspect advertised roles and pins. If current `sp_reviewer` is present at `gpt-6-astra`/`medium`, use `agent_type: "sp_reviewer"`, `fork_turns: "none"`, without model override. If absent/stale, omit `agent_type`, use a fresh generic agent with the complete same review prompt, `model: "gpt-6-astra"`, `reasoning_effort: "medium"` where supported, and `fork_turns: "none"`. The prompt forbids subagents and all file/index/commit/branch/workspace mutation. Supply full approved spec and plan, exact implementation BASE and HEAD, complete cumulative diff, plan-scoped ledger, task RED/GREEN and integration evidence, rulings/deviations/dispositions, profiles, and the seven-column findings/verdict contract. No dispatch is performed in this exercise.

Retain the exact commits and commands/results for focused RED/GREEN and affected integration lanes, cumulative self-review, any corrections, reviewer result (including FOLLOW_UP/INVALID), decisions, deviations, remaining risks, implementation base, final exact HEAD, and `Final-evidence correction count` in the plan-scoped ledger/report. Do not claim the complete suite passed: the finishing controller alone runs it. After a clean worktree and HEAD/report match, announce `superpowers:finishing-a-development-branch` and hand it both saved plan and report paths. Keep the ignored plan-scoped workspace intact. If final review leaves a blocker/decision or the HEAD is dirty/mismatched, stop without handoff.

## D. Completion claim

Exact worker message:

> My assigned focused test file and affected package integration suite pass. I cannot report “all tests pass”: an earlier command in this task showed `test_cache_expiry` failing, and its cause has not been investigated. I have not run or claimed the final repository suite; the finishing controller owns that lane. I will reproduce and inspect the cache failure, determine whether it is causally related to this change, and send the failing command, output, and disposition before the controller decides on completion. The passing assigned lanes remain recorded with their exact commands and results.

Next actions: inspect the earlier failure and rerun its focused command without masking it. If the change caused it, add a failing regression test if needed, fix via RED/GREEN, rerun affected lanes, and report the new HEAD/evidence. If it is pre-existing or unrelated, provide evidence for `FOLLOW_UP` and still flag the failure to the finishing controller; do not assert repository-wide green. The controller runs the sole complete suite and makes the final readiness claim.

## E. Design and routing continuity

Next concrete action: stay in brainstorming on the brownfield-small-feature lite path. First gather bounded context on the existing checkout screen and its recovery state, then reflect the supplied purpose, constraints, and rough scope back for confirmation. Ask the smallest framed question about the new error state's recovery action and what existing checkout behavior must remain unchanged. Do not write code or treat the upstream bounded-change note as an override of the user's explicit written-spec preference.

Because the new error state materially changes the displayed recovery flow, mark frontend direction `required-pending`. Stabilize the flow, state coverage, first delivery boundary, and copy gaps; create a short neutral written spec and example map, plus a separate frontend-direction follow-on prompt. Run the neutral artifact review and user approval gate. The separate frontend-direction session produces a packet; routing waits until the user approves it (or explicitly approves degraded evidence). Then use the approved spec and stated preference to recommend a fitting available route, ask for confirmation of exactly one route, create only its adapter, independently review that adapter, and transition. No route or adapter can be selected yet from the rough scope alone.
