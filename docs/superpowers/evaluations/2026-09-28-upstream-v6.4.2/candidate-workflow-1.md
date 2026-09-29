## A. Planning under handoff pressure

I'm using the writing-plans skill to create the implementation plan. The teammate's implementation is not plan content; the plan records the contract and verification only.

# Local CSV Import Implementation Plan

> **For agentic workers:** Use `superpowers:subagent-driven-development` when subagents are available, or `superpowers:executing-plans` otherwise. Honor an explicit execution-route override in this plan.

**Goal:** A user-selected UTF-8 CSV file yields one field-text mapping per data row; unreadable input produces the existing friendly import error.
**First delivery boundary:** Add the local reader and prove it works through `show_import`; no external writes or dependencies.
**Architecture:** `app.csv_import.load_rows` reads with the standard-library `csv` module. The existing `app.import_ui.show_import` remains the presentation and error boundary.
**Tech Stack:** Python standard library (`csv`, `pathlib`, `unittest`); no new dependency.
**Spec:** `/tmp/superpowers-workflow-fixture/spec.md`
**Spec revision:** approved r1
**Risk class:** `review-required`
**Risk triggers:** public reader contract; user-supplied file/input boundary
**Verification lanes:** implementer owns focused `tests/test_csv_import.py` and affected `tests/test_import_ui.py` evidence; finishing owns the complete `python3 -m unittest discover -s tests` suite.

The reader returns `list[dict[str,str]]`. A first header row names each field; following rows supply field text. No header or unreadable/invalid UTF-8 input must reach the caller as `ValueError` or `OSError`, because `show_import` catches those and returns `Could not read this import`. Preserve normal display of each returned row. During execution, capture a failing focused test before reader code and passing focused evidence afterward.

### Task 1: Read local CSV and preserve the UI error boundary

**Outcome:** `show_import(path)` displays parsed records or its existing friendly error.

**Files and ownership:** Sole implementation owner creates `app/csv_import.py` and `tests/test_csv_import.py`. Inspect `app/import_ui.py` and `tests/test_import_ui.py`; change them only if the stated contract cannot be verified through the new test file.

**Interfaces and contracts:** Consumes the path passed by `show_import`. Produces `load_rows(path: Path) -> list[dict[str,str]]`; the returned list contains one dictionary per data row, mapping each header to field text. Keep `OSError`/`ValueError` as the failure types visible to the caller.

**Dependencies:** none.

**Risk class and triggers:** `review-required`: public reader contract and user-supplied file/input boundary.

**Acceptance criteria:** A UTF-8 file with a header and data returns the expected dictionaries, including Unicode field names and text. A header-only file returns an empty list. Empty input, invalid UTF-8, and an unreadable path yield `show_import`'s friendly error instead of an uncaught exception. Existing `show_import` row display remains intact.

**Error handling:** Raise `ValueError` for absent header or decode failure; allow file-access `OSError` to propagate to `show_import`. Do not turn failure into an empty successful import.

**Verification:** First observe RED for each new behavior, then GREEN. Run `python3 -m unittest discover -s tests -p test_csv_import.py` for focused evidence and `python3 -m unittest discover -s tests -p test_import_ui.py` for affected integration evidence. Finishing alone runs `python3 -m unittest discover -s tests`.

**Review focus:** Trace user-supplied file failure and empty input through `load_rows` to `show_import`; inspect actual test assertions for both friendly-error and row-mapping behavior.

**Codebase pointers:** `/tmp/superpowers-workflow-fixture/app/import_ui.py`, `/tmp/superpowers-workflow-fixture/tests/test_import_ui.py`, and approved `/tmp/superpowers-workflow-fixture/spec.md`.

## Readiness Record

**Author self-review:** Complete. Spec r1 maps to Task 1: UTF-8/header/record mapping to reader assertions; unreadable input to reader and UI assertions; no writes/dependencies to implementation inspection. Focused and affected integration lanes are assigned to the implementer, complete suite to finishing. No implementation body or teammate code is embedded.
**Independent readiness gate:** Required for named risk triggers; pending. This exercise forbids agent dispatch, so the plan is not cleared for execution handoff yet.

| ID | Disposition | Ruling or resolution | Evidence carried forward |
| --- | --- | --- | --- |
| none | — | No readiness findings have been received; no reviewer verdict is claimed. | Review this complete plan against spec r1 before execution. |

## B. Review of unnamed input

The supplied trace establishes a contract defect even though the named tests pass. Coverage below distinguishes that trace from a complete diff and inspected test source.

| Area / selected profile section | Status | Evidence | Finding IDs |
| --- | --- | --- | --- |
| Contract and behavior | CHECKED | Supplied `rows[0]` expression parses the stated header-plus-data case but cannot return normally for empty input. | B1 |
| Failure paths | CHECKED | Empty text makes `csv.reader` yield `[]`; `rows[0]` raises `IndexError`, while the stated caller handles unreadable imports by showing an error. | B1 |
| Boundary conditions | CHECKED | Empty collection is the failing boundary. Unicode header strings are accepted by the shown `zip`/`dict` expression; the linear scan is bounded at ten records. | B1, B2, B3 |
| Compatibility and integration | CHECKED | The approved UI behavior retains Unicode fields and a scan of at most ten records; proposed ASCII restriction would narrow accepted input. | B2, B3 |
| Test adequacy | NOT CHECKED | Only a report that tests cover one header/data row is supplied; actual test source and assertions are unavailable. The reported coverage omits empty input. | B1 |
| Maintainability | CHECKED | The shown function is small; there is no concrete maintainability failure in the supplied code. | none |
| Security profile — input/output safety | CHECKED | Input is externally supplied CSV text; empty input reaches an uncaught exception. No other security issue is proved by the supplied trace. | B1 |
| Security profile — remaining sections | N/A | No authentication, secrets, deployment, cryptography, shared state, or persistence behavior is in this change. | none |
| Code-quality profile — error handling and boundary conditions | CHECKED | `rows[0]` lacks an empty-input boundary; the resulting `IndexError` bypasses the stated caller error path. | B1 |
| Code-quality profile — performance and caching | CHECKED | The approved UI scans at most ten records; no measured or contractual performance failure supports indexing. | B2 |

| ID | Disposition | Location | Proof | Candidate causal connection | Concrete failure | Required resolution |
| --- | --- | --- | --- | --- | --- | --- |
| B1 | BLOCKING | `parse_csv`, `headers=rows[0]` (supplied candidate expression) | For `text=""`, `rows=[]`, so indexing raises `IndexError`; named tests cover only a nonempty row. | New parser directly introduces an exception that the import caller does not convert. | Empty user input exits the command instead of showing the required import error. | Make empty input follow the caller's friendly-error contract, and add a test asserting that boundary through the affected caller. |
| B2 | FOLLOW_UP | Approved UI scan, at most ten records | The proposed index changes an approved bounded scan without evidence of a user-visible failure. | No blocking causal connection to this parser change. | None within the approved scale; optimization can be considered separately if a real need appears. | Do not add indexing to this change. |
| B3 | FOLLOW_UP | Approved Unicode field-name behavior | ASCII-only validation would reject currently accepted Unicode names. | No blocking causal connection to the parser defect; it would change approved behavior. | A Unicode-header import would newly fail. | Preserve Unicode behavior here; consider a separate product decision only if requirements change. |

Contract compliance: **FAIL**. Change quality: **FAIL**. Evidence checked: supplied parser expression and concrete empty-input trace; named test pass is reported, not independently observed. Uncompleted inspection: full BASE..HEAD diff, requirements artifact, caller source, test assertions, and test command output were not supplied. Verdict: **NOT READY**. Controller action: hold shipping, correct B1 with a failing boundary test and passing affected test evidence, then request a scoped re-review with the actual diff and tests; retain B2/B3 as nonblocking follow-ups, not part of the fix.

## C. Execution method and persisted evidence

I'm using executing-plans in the controller context because the approved plan explicitly selected Superpowers inline execution. Keep that route; the presence of agent tools does not change the selected route.

Next, check the plan-scoped workspace and its ledger, the approved plan/spec identities and readiness record, the isolated clean worktree, and the exact implementation base and HEAD. Confirm every task has focused RED/GREEN, task and integration verification, self-review, disposition, and commit evidence. Do not rerun the complete repository suite in this execution lane.

Because this is an explicit inline override with agent tools, dispatch one fresh final independent read-only reviewer. The advertised current `sp_reviewer` uses `gpt-6-astra`/`medium`; dispatch with `agent_type: "sp_reviewer"`, `fork_turns: "none"`, and no model or effort override. The full prompt must say “Do not spawn subagents,” require no file/index/commit/branch/workspace changes, and supply the approved spec and plan, exact BASE and HEAD and cumulative diff, ledger, task evidence and rulings, risk profiles, and focused/integration results. Require the shared findings table and PASS/FAIL checks, with READY only if no BLOCKING or DECISION remains. If a typed role is unavailable or stale, use a fresh generic reviewer with the same complete prompt, `fork_turns: "none"`, and `gpt-6-astra`/`medium` when supported. Do not add task or checkpoint reviewers.

Apply any supported final findings within the existing correction budget, refresh affected evidence and review, and keep all dispositions in the plan-scoped ledger. With a READY review, clean worktree, and unchanged implementation HEAD, save the plan-scoped `execution-report.md` with spec/plan identity, completed tasks, focused and integration commands/results, decisions, deviations, follow-ups, risks, reviewer result, implementation BASE/HEAD, and explicit final-evidence correction count. Announce `superpowers:finishing-a-development-branch` and pass the plan and report paths. Finishing validates that handoff, runs the sole complete suite, persists its result, and owns integration/cleanup.

## D. Completion claim

Exact message to the controller:

> My assigned focused test file and affected package integration suite pass. I cannot report “all tests pass”: an earlier command in this task showed `test_cache_expiry` failing, and that failure has not been investigated. The final repository suite belongs to finishing and has not run in my lane. I will reproduce and trace `test_cache_expiry`, record the exact command and failure, and determine whether my change caused it before calling this task complete. If it is caused by my change, I will add a failing regression test, make the smallest fix, and rerun both assigned lanes. If it is unrelated, I will give you the evidence and leave its disposition explicit for the controller.

Next actions: inspect the failing test and changed dependencies, reproduce the failure, compare against the implementation base if needed, then report the causal finding and exact evidence. Do not infer “old” from the teammate's guess or silently relabel the failure as a passing suite.

## E. Design and routing continuity

The next action is the brownfield-small-feature brainstorming lite path: inspect the existing checkout screen and its current error and recovery behavior, reflect the supplied purpose and constraints, then resolve only the new state's trigger, displayed recovery action, and unchanged behavior needed for an implementable contract. The changed recovery flow makes frontend direction required. Keep the user's chosen written-spec practice despite the upstream shortcut note.

Write a concise neutral design spec with the first delivery boundary, flow and state examples, compatibility constraints, and `packet status: required-pending`; prepare the separate frontend-direction follow-on prompt. Review the neutral artifacts and get the user's approval. Then obtain the approved frontend-direction packet in its separate phase before delivery routing. Only after both approvals, recommend a route by the approved spec and working preference, ask the user to confirm one route, create exactly that route's adapter, and independently review it before transition. A small bounded change may fit Native Codex or Superpowers, but it is premature to choose or start either now; no implementation starts from the rough scope alone.
