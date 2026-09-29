# A. Planning under handoff pressure

I'm using the writing-plans skill to create the implementation plan. The teammate's 60-line implementation is code, so it does not belong in this plan.

## CSV Import Implementation Plan

> **For agentic workers:** Use `superpowers:subagent-driven-development` when subagents are available, or `superpowers:executing-plans` otherwise. Honor an explicit execution-route override in this plan.

**Goal:** `load_rows(path: Path) -> list[dict[str, str]]` reads a user-supplied UTF-8 CSV and returns each data record as header-to-text mappings; `show_import` displays those rows and presents a friendly error when input cannot be read.
**First delivery boundary:** Local CSV import and its existing display caller; no external writes or dependency changes.
**Architecture:** Extend the existing stdlib `csv` path and caller error boundary.
**Tech Stack:** Existing Python app; standard-library `csv`, `pathlib`, and UTF-8.
**Spec:** `/tmp/csv-import-spec.md`
**Spec revision:** approved r1, as supplied in the case.
**Risk class:** review-required.
**Risk triggers:** public `load_rows` return contract and user-supplied file boundary.
**Verification lanes:** The implementation owner runs focused reader and caller tests, plus the affected import integration test. The finishing controller runs the complete repository suite.

The scenario supplies the complete behavior contract but no app checkout or real module paths. At execution preflight, resolve and record the exact existing reader, `show_import`, and test paths before editing. Do not substitute invented paths. The spec-to-task map is: UTF-8 decoding, header mapping, and field text to Task 1; friendly unreadable-input behavior and row display to Task 2. The boundary-to-verification map is: empty/header-only and unreadable input in focused tests; reader-to-display behavior in the affected integration lane. For each behavior, record a failing focused test before implementation and a passing result afterward.

### Task 1: Read CSV rows

**Outcome:** The reader returns one dictionary per data row, keyed by the first row's headers, with field text unchanged.
**Files and ownership:** One implementer owns the existing CSV module and its focused reader tests; resolve their exact paths in the app checkout before Task 1.
**Interfaces and contracts:** Consumes `Path` and a user-supplied UTF-8 CSV. Produces `load_rows(path: Path) -> list[dict[str, str]]`. Use the app's existing stdlib `csv` pattern; add no dependency or external write.
**Dependencies:** None.
**Risk class and triggers:** review-required; public return contract and user-supplied file boundary.
**Acceptance criteria:** A header plus data yields header-to-text dictionaries in row order; a header with no data yields no records. Empty input must be handled without an uncaught indexing error. Preserve the specified text values and header names.
**Error handling:** Unreadable input must reach the caller as an error that `show_import` can convert to its friendly message; do not report an empty successful import for a failed read.
**Verification:** Run the resolved focused reader-test command. Evidence must show RED then GREEN for row mapping and boundary/error behavior. Include the affected import integration lane after Task 2.
**Codebase pointers:** Locate the existing stdlib `csv` reader and reader tests in the app checkout; use those exact paths in the execution record.

### Task 2: Present rows and read errors

**Outcome:** `show_import` displays every returned row and gives a friendly error when the reader cannot read input.
**Files and ownership:** The same implementation owner owns the existing `show_import` module and focused caller tests; resolve their exact paths before Task 2.
**Interfaces and contracts:** Consumes the Task 1 `list[dict[str, str]]` result or its read failure. Produces the existing row display or a friendly caller-level error. No external writes.
**Dependencies:** Task 1, because the caller consumes its return/error contract.
**Risk class and triggers:** review-required; caller-visible import contract and user-supplied file boundary.
**Acceptance criteria:** Every returned row is displayed; unreadable input produces the friendly error rather than an exception or false success. Existing display behavior for readable input remains intact.
**Error handling:** Recover at the caller's display boundary for unreadable input.
**Verification:** Run the resolved focused `show_import` tests and affected import integration test. Record RED/GREEN for the new error path and the final integration result.
**Codebase pointers:** Locate `show_import` and its existing tests in the app checkout; use their exact paths in the execution record.

## Whole-feature verification

The implementation owner verifies UTF-8 CSV header-to-row mapping, header-only/empty behavior, unreadable-file error propagation, and display of each row through `show_import` in focused and affected integration tests. The finishing controller alone runs the complete repository suite. The exact test commands and module paths must come from the app checkout, which was not supplied to this planning case.

## Readiness Record

**Author self-review:** Complete against the supplied r1 behavior; the two task contracts cover each specified behavior and the failure boundary without copying implementation code. Exact app paths and commands are unavailable in this case and must be resolved before execution.
**Independent readiness gate:** Pending; this plan is review-required and cannot be handed to execution as READY until one holistic readiness review receives the full approved spec and plan and returns READY.

| ID | Disposition | Ruling or resolution | Evidence carried forward |
| --- | --- | --- | --- |
| none | none | No review has run in this hypothetical case. | The readiness reviewer must inspect the complete spec and plan. |

Execution handoff, once the missing app paths/commands are filled and the readiness gate is READY: compact, then continue with `superpowers:subagent-driven-development` on this saved plan if subagents are available; otherwise use `superpowers:executing-plans`.

# B. Review of unnamed input

This is a review of the supplied trace only. No BASE/HEAD commits, complete diff, caller source, or test source were supplied; those are required for a real standalone READY review. Reported passing tests are not independently observed.

| Area / selected profile section | Status | Evidence | Finding IDs |
| --- | --- | --- | --- |
| Contract and behavior | CHECKED | The candidate indexes `rows[0]`; the supplied trace says empty input raises `IndexError` and exits rather than reaching the caller's friendly error. Full caller behavior is unavailable. | B1 |
| Failure paths | CHECKED | Empty input follows `rows[0]` to an uncaught importer exception in the supplied trace. Other I/O paths cannot be inspected. | B1 |
| Boundary conditions | CHECKED | The supplied empty-input trace is a relevant zero-row boundary. Header plus one data row is the only reported test case. | B1 |
| Compatibility and integration | NOT CHECKED | The approved ten-record linear scan and Unicode field names are stated, but no complete diff or caller/consumer source was provided. | B2, B3 |
| Test adequacy | NOT CHECKED | Only a prose test summary was supplied; the test assertions, fixtures, commands, and RED/GREEN evidence are unavailable. | B1 |
| Maintainability | NOT CHECKED | The snippet is too narrow to inspect module responsibilities or coupling in the complete changed range. | none |
| Security profile — input/output safety | CHECKED | The supplied code accepts CSV text and indexes the parsed row list before checking emptiness; no other trust-boundary path is supplied. | B1 |
| Security profile — other sections | N/A | No authentication, secrets, network, deployment, cryptography, shared state, or persistence change is in the supplied case. | none |
| Code-quality profile — error handling | CHECKED | The `IndexError` bypasses the specified friendly caller error in the concrete trace. | B1 |
| Code-quality profile — boundary conditions | CHECKED | Empty parsed rows cause `rows[0]` to fail. Unicode header names are approved. | B1, B3 |
| Code-quality profile — performance and caching | CHECKED | The UI's approved linear scan is bounded at ten records; no concrete performance failure is supplied. | B2 |

| ID | Disposition | Location | Proof | Candidate causal connection | Concrete failure | Required resolution |
| --- | --- | --- | --- | --- | --- | --- |
| B1 | BLOCKING | Candidate `parse_csv`, `headers=rows[0]`; importer error path | Empty input makes `csv.reader` return no rows; `rows[0]` raises `IndexError`, and the supplied trace says the command exits. | The new first-row assumption is on the changed import path. | The caller never presents the approved friendly unreadable-import error. | Handle empty input at the import boundary and make the caller show the approved friendly error; add a focused empty-input regression assertion. |
| B2 | FOLLOW_UP | Proposed UI change to the approved bounded scan | The UI scans at most ten records; the teammate proposed indexing without a measured failure. | The proposed optimization is outside this CSV correctness change. | No current contract failure is shown; it would add scope under deadline. | Keep the approved scan; assess indexing separately if a real scale need arises. |
| B3 | FOLLOW_UP | Proposed ASCII-only restriction on field names | Unicode field names are explicitly accepted; the teammate proposed disallowing them. | The proposed restriction would change approved input behavior, not repair the reviewed defect. | A new restriction would reject previously valid names. | Keep Unicode acceptance; treat any proposed restriction as a separate product change requiring approval. |

**Contract compliance:** FAIL on B1.
**Change quality:** FAIL on the unhandled empty boundary; the remainder cannot be judged from the snippet.
**Evidence checked:** Supplied code expression and concrete empty-input trace; reported named-test pass and one-row test scope only. No commands or test artifacts were observed.
**Uncompleted inspection:** Exact requirements artifact, BASE/HEAD validation, complete diff, caller source, actual test source/assertions, profile coverage against the actual diff, and observed verification evidence.
**Verdict:** NOT READY.

Controller action: hold the range, send B1 for a focused correction with a failing then passing empty-input test, and obtain the missing review package before requesting a scoped re-review. Preserve B2 and B3 as follow-ups; do not change the approved UI behavior in this correction.

# C. Execution method and persisted evidence

I'm using executing-plans in the controller context because the approved plan explicitly selects Superpowers inline execution, even though agent tools are available. Keep that route; the teammate's Native Codex plan mode and SDD suggestions do not supersede the agreed execution mode.

Next, verify the saved plan/spec identities, readiness status, implementation base, recorded clean implementation HEAD, and the plan-scoped workspace. Confirm each task's focused RED/GREEN result, affected integration results, commits, cumulative self-review, rulings, accepted deviations, dispositions, and final-evidence correction count are in its ledger. A new failed check or mismatch returns to the producer's bounded correction loop; the finishing controller has sole ownership of the complete repository suite.

Because this is an explicit inline override with agent tools available, dispatch exactly one final independent read-only review of the complete cumulative implementation BASE..HEAD range. Use the runtime-advertised `sp_reviewer` role with its current fixed `gpt-6-astra`/`medium` pins and `fork_turns: "none"`, with no model/effort override. If that role is absent or stale, use a fresh generic reviewer with the identical complete prompt, `gpt-6-astra`/`medium` where supported, and `fork_turns: "none"`; never probe an unknown role. The prompt must forbid subagents and all file, index, commit, branch, and plan-workspace writes. Give the reviewer the full approved spec and plan, exact BASE/HEAD and complete diff, ledger, task evidence, controller rulings and dispositions, deviations, selected profiles, and focused/integration results. Require the shared findings table, PASS/FAIL compliance and quality, checked evidence, and READY only with no BLOCKING or DECISION. Record FOLLOW_UP and INVALID rows even for READY.

After READY, confirm the worktree remains clean at the same full implementation HEAD. Write `<plan-scoped workspace>/execution-report.md` with `Status: ready-for-finishing`, `Producer: executing-plans`, plan/spec and revision, full base and HEAD IDs, completed task commits, exact focused and integration commands/results, rulings, deviations, follow-ups, risks, resolved decisions, correction rounds, reviewer availability/result/evidence, and explicit final-evidence correction count. Do not change code after that HEAD. Announce `superpowers:finishing-a-development-branch` and hand off both plan and report paths. Finishing validates the report/HEAD and runs the single complete repository suite; its result supplies the final branch handoff evidence. This case calls for a next-action decision only, so no review dispatch, report write, or repository action was performed.

# D. Completion claim

Exact completion message to the finishing controller:

> My assigned focused test file and affected package integration suite pass. I cannot report that all tests pass: an earlier command in this task failed at `test_cache_expiry`, and its cause is still uninvestigated. The final repository suite is yours. I am investigating the failure now and will send the exact command, failure output, cause, and any correction evidence before claiming this work ready for finishing.

Next actions: preserve the exact failing command/output and the two passing lane commands/results; reproduce and diagnose `test_cache_expiry` without assuming it is old. If changed work caused it, add a focused failing regression test, watch RED, make the minimal correction, then watch GREEN and rerun affected integration. If it is demonstrably pre-existing and outside the assigned change, document the evidence and notify the controller as a follow-up, leaving the complete-suite decision to the finishing gate. Do not claim all tests pass or ready-for-finishing while the failure is unresolved.

# E. Design and routing continuity

The next action is a compact brownfield-small-feature brainstorming pass. Inspect the existing checkout screen and recovery path, then reflect the requested new error state, the existing flow that must remain intact, and the smallest extension point for confirmation. The rough scope approval is not a written spec or an approved visual packet. Because the new error state materially changes the displayed recovery flow, mark frontend direction `required-pending`. On the lite path, settle the state, recovery transition, unchanged behavior, acceptance examples, and copy gaps; write the short neutral spec in this fork and a frontend-direction follow-on prompt. Review the neutral artifacts and obtain the user's written-spec approval, then run the separate frontend-direction session and obtain approval of its packet.

Only after the neutral spec and packet are approved should delivery routing begin. The user's preference for keeping written specs is strong evidence for a durable Superpowers route for this bounded change, but it is not yet a confirmed execution route. Recommend the available route by fit, ask for one explicit route confirmation, create only that route's adapter, independently review the adapter, record its approval, and then transition. The upstream note about a bounded chat-design path does not override the user's preference or the changed recovery-flow packet gate. No code or routing adapter is created now.
