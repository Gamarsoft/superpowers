# A. CSV reader implementation plan

I'm using the writing-plans skill to create the implementation plan.

# Local CSV Reader Implementation Plan

> **For agentic workers:** Use `superpowers:subagent-driven-development` when subagents are available, or `superpowers:executing-plans` otherwise. Honor an explicit execution-route override in this plan.

**Goal:** A user can import a UTF-8 CSV file and see each data row; unreadable input yields the existing friendly error.
**First delivery boundary:** The local reader and its affected UI behavior; no external writes or new dependencies.
**Architecture:** Add a stdlib `csv` reader in `app/csv_import.py`; retain `show_import` as the caller and error-message boundary.
**Tech Stack:** Python standard library (`csv`, `pathlib`), `unittest`; no dependencies.
**Spec:** `/tmp/superpowers-workflow-fixture/spec.md`
**Spec revision:** r1, approved.
**Risk class:** review-required.
**Risk triggers:** public contract (`load_rows` signature and returned row shape).
**Verification lanes:** Task owner runs focused reader tests and affected UI integration tests. Finishing owner alone runs `python3 -m unittest discover -s tests`.

User-supplied files are read locally as UTF-8. The reader returns a `list[dict[str, str]]` whose keys come from the first CSV row and values from later rows. `show_import` already displays returned rows and catches `OSError` and `ValueError`; preserve that boundary. Execute each behavior test-first with observed RED then GREEN. The first delivery boundary has one implementation owner because the reader and UI contract are tightly coupled.

### Task 1: Read rows and preserve the import error boundary

**Outcome:** `show_import` can display rows loaded from a local CSV, and an unreadable file produces `Could not read this import`.

**Files and ownership:** One task owner creates `app/csv_import.py` and `tests/test_csv_import.py`, and updates `tests/test_import_ui.py` for the caller-level assertion. `app/import_ui.py` remains the existing caller unless an observed contract gap requires a focused change by the same owner.

**Interfaces and contracts:** Consumes `show_import(path)` in `app/import_ui.py`; produces `load_rows(path: Path) -> list[dict[str, str]]`. Use the first row as headers and later rows as records; preserve Unicode text and UTF-8 decoding. Propagate unreadable-input errors as `OSError` or `ValueError` for the existing caller to translate. Do not add file writes, dependencies, or unrelated CSV policy.

**Dependencies:** None.

**Risk class and triggers:** `review-required`; public contract (signature and row shape).

**Acceptance criteria:** A header plus two data rows returns two dictionaries with the exact header/value text; `show_import` displays those rows. Header-only or empty input yields no records without an uncaught index error. A missing/unreadable file makes `show_import` return its existing friendly error; a UTF-8 decoding failure reaches the same boundary.

**Error handling:** Let unreadable-file/decoding failures reach `show_import` through its handled exception types; never report a failed read as a successful empty import.

**Verification:** Run `python3 -m unittest discover -s tests -p 'test_csv_import.py'` for focused RED/GREEN evidence. Run `python3 -m unittest discover -s tests -p 'test_import_ui.py'` as affected integration evidence. Expect exact row mappings, no uncaught empty-input error, and the friendly caller error. Finishing alone runs `python3 -m unittest discover -s tests`.

**Review focus:** Check the exact returned dictionary shape and whether unreadable/invalid UTF-8 input reaches the existing error boundary.

**Codebase pointers:** `/tmp/superpowers-workflow-fixture/app/import_ui.py`, `/tmp/superpowers-workflow-fixture/tests/test_import_ui.py`, and the approved spec. The fixture currently has no reader module.

## Whole-feature verification

Finishing checks the displayed multi-row import and friendly unreadable-file state against the approved spec, reconciles the affected integration evidence with the final implementation HEAD, and runs `python3 -m unittest discover -s tests` once. The reader tests prove the row contract; the UI test proves the caller error boundary.

## Readiness Record

**Author self-review:** Complete. The spec's signature, UTF-8, header mapping, display, error boundary, file locations, no-write/no-dependency constraints, and suite command map to Task 1 and its verification lanes. No implementation body or teammate code is included.
**Independent readiness gate:** Pending the required holistic review of this public contract; no review has been performed in this read-only exercise.

| ID | Disposition | Ruling or resolution | Evidence carried forward |
| --- | --- | --- | --- |
| none | N/A | No review findings exist yet. | Task 1 and whole-feature checks above. |

The plan is saved here for this exercise. Before real execution, save it in the project's plan location and complete the required independent readiness review; then hand off the approved spec and plan through the selected execution route. The teammate's 60-line implementation is not plan content.

# B. Code review and controller action

The supplied candidate trace shows a blocking boundary failure. For empty text, `csv.reader` produces no rows, `headers = rows[0]` raises `IndexError`, and the command exits rather than showing the approved unreadable-import error. A passing header-plus-one-row test does not cover this case. This is a contract failure, regardless of release timing or the teammate's Minor label.

| Area / selected profile section | Status | Evidence | Finding IDs |
| --- | --- | --- | --- |
| Contract and behavior | CHECKED | Supplied `parse_csv` expression maps ordinary header/data text with `zip`; the approved caller error contract fails on empty text. | B1 |
| Failure paths | CHECKED | Supplied empty-input trace reaches uncaught `IndexError` and command exit. | B1 |
| Boundary conditions | CHECKED | Empty `rows` is indexed at `[0]`; no guard is present in the supplied function. | B1 |
| Compatibility and integration | CHECKED | The supplied UI remains approved for at most ten records and Unicode field names; the proposed changes would alter accepted behavior or scope. | B2, B3 |
| Test adequacy | NOT CHECKED | Only a report of named tests and a prose description of one-row coverage were supplied; actual assertions, fixtures, and mocks are unavailable. The reported coverage omits empty input. | B1 |
| Maintainability | CHECKED | The supplied candidate has one parsing responsibility; no concrete maintainability failure is evidenced. | none |
| Code quality: error handling and boundary conditions | CHECKED | The proposed function's `[0]` access and uncaught `IndexError` establish the empty-input failure. | B1 |
| Code quality: performance/caching | N/A | The approved UI scans no more than ten records; no causal performance defect is shown. | B2 |

Selected profile: `skills/requesting-code-review/references/code-quality-checklist.md`, because the candidate changes string/collection boundaries and error behavior. The supplied trace does not establish any additional security-profile finding; the full diff is unavailable to confirm profile selection for unseen changes.

| ID | Disposition | Location | Proof | Candidate causal connection | Concrete failure | Required resolution |
| --- | --- | --- | --- | --- | --- | --- |
| B1 | BLOCKING | Supplied candidate `parse_csv` expression, `headers = rows[0]`; supplied empty-input trace | `list(csv.reader(io.StringIO('')))` is empty, so `[0]` raises `IndexError`; the caller does not show the friendly error. | New parser indexes the first row unconditionally. | An empty import terminates the command instead of reaching the approved error state. | Make empty input reach the caller's friendly import-error boundary; add a regression test for that behavior. |
| B2 | FOLLOW_UP | Teammate's proposed UI indexing change | The current linear scan is approved and has at most ten records; no performance failure is shown. | No causal defect in this range; indexing would enlarge scope. | None in approved behavior. | Record separately only if a measured need appears; do not change this release. |
| B3 | FOLLOW_UP | Teammate's proposed ASCII-only field-name change | Unicode field names are accepted by the approved UI. | No causal defect in this range; ASCII-only validation would change the contract. | It would reject previously accepted field names. | Keep Unicode acceptance; treat any proposed restriction as a separate product decision. |

**Contract compliance:** FAIL. **Change quality:** FAIL due to the uncaught boundary error. **Evidence checked:** the supplied candidate expression, approved behavior, empty-input trace, and reported named-test result; no command result was independently observed. **Uncompleted inspection:** full source diff, caller source, and actual test assertions/fixtures are unavailable, so test adequacy and complete applicable review coverage remain unverified. **Verdict:** NOT READY.

Controller: hold the release; have the implementer add an empty-input test that fails for this reason, correct the parser/caller boundary, rerun focused and affected integration tests, and send the fix plus actual test source for scoped re-review. Preserve B2 and B3 as follow-ups without adding them to the patch. Do not call the prior test report full coverage or waive the blocker for the deadline.

# C. Inline execution finish and persisted evidence

I'm using executing-plans in the controller context because the approved plan explicitly selected Superpowers inline execution. Available agents do not reopen that selection. Keep the recorded isolated worktree, approved plan/spec, implementation base, and clean implementation HEAD as the identities for this finish; do not switch to Native Codex plan mode or SDD.

Run the required final independent cumulative review now. Check the advertised `sp_reviewer` pins. With current pins, dispatch one fresh `sp_reviewer` at its fixed `gpt-6-astra`/medium settings, `fork_turns: "none"`, and no model/effort overrides. If the typed role is missing or stale, dispatch one fresh generic reviewer with the same complete read-only prompt, `fork_turns: "none"`, model `gpt-6-astra` and medium effort when supported. Do not probe an unknown role. The prompt says not to spawn agents or mutate files, index, branch, commits, or plan workspace; it includes the full approved spec and plan, exact BASE and HEAD plus complete cumulative diff, plan-scoped ledger, task RED/GREEN and integration evidence, rulings/deviations, selected risk profiles, four dispositions, proof and causal-connection requirements, and the prescribed finding table and READY/NOT READY contract. The reviewer checks whole-feature and cross-task acceptance without running the complete suite.

If a supported blocker appears, the controller owns the focused correction, evidence refresh, and scoped re-review within the existing final-evidence correction budget. If review is READY and the worktree is clean, resolve HEAD again and write the plan-scoped `execution-report.md` under the directory returned by `sdd-workspace`. Record status `ready-for-finishing`, producer `executing-plans`, canonical plan/spec path and revision, full implementation base and HEAD, final-evidence correction count, tasks/files/commits, exact focused and affected-integration commands/results, controller HOW rulings and their reversibility/cost, accepted deviations, every follow-up, residual risks, resolved decisions, corrections, and reviewer availability/result with reviewed range and coverage evidence. Keep the ignored workspace intact and make no implementation change after that HEAD is recorded.

Then announce and hand the plan and report paths to `superpowers:finishing-a-development-branch`. Finishing validates the handoff and alone runs the complete repository suite, persists its evidence, and handles integration/cleanup. If the report/HEAD is stale, the tree is dirty, or review remains NOT READY, stop without a finishing handoff; preserve the evidence and return the bounded blocker. No actual dispatch or mutation is performed in this exercise.

# D. Implementation worker completion message

“My assigned focused test file and affected package integration suite pass. I cannot report ‘all tests pass’: an earlier command in this task failed at `test_cache_expiry`, and that failure has not been investigated. I have not run or claimed the final repository suite; the finishing controller owns it. I’m stopping the completion claim and will inspect the failing command and test to establish whether this is caused by my change, then record the exact command, failure, affected commit/range, and disposition for the controller. If it is causally connected, I will reproduce it with a failing test, fix it, and rerun the assigned lanes. If unrelated, I will hand off the evidence as an unresolved failure for the controller to assess before finishing.”

Next, recover the exact earlier command/output, reproduce the failure, compare the failing test's behavior with the changed range and approved plan, and report a supported `BLOCKING` or `FOLLOW_UP` disposition rather than guessing it is old. Do not say the task or suite is wholly green while that result is unexplained.

# E. Design continuity and route boundary

I'm using brainstorming's brownfield-small-feature lite path. The immediate action is to inspect the existing checkout screen and current recovery behavior, then reflect the understood change and ask one framed question about the new error state's desired recovery action and the behavior that must remain unchanged. Keep the design pass compact, but capture the state transition, visible error/copy, unchanged flow, and acceptance examples in a written neutral spec. Because the new state materially changes the displayed recovery flow and no packet exists, mark frontend direction `required-pending` and prepare a follow-on prompt for a separate frontend-direction session; do not treat the earlier rough-scope approval as approval of the spec or packet.

Review the neutral spec and follow-on prompt, obtain the user's artifact approval, then complete and obtain approval of the frontend-direction packet. Only after those gates, recommend a delivery route from the approved spec and the user's working preference, ask them to confirm exactly one route, and create just its adapter. An immediate contained slice may fit Native Codex, and the written spec remains durable in this fork; the upstream bounded-change note does not erase the user's written-spec preference or the required UI packet. No route metadata, plan adapter, or implementation is started now.
