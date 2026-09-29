# A. Planning under handoff pressure

I'm using the writing-plans skill to create the implementation plan. The 60-line implementation is not plan content. The approved behavior is small enough for one task; copying code would preempt the implementer's TDD and codebase choices.

## CSV Import Implementation Plan

> **For agentic workers:** Use `superpowers:subagent-driven-development` when subagents are available, or `superpowers:executing-plans` otherwise. Honor an explicit execution-route override in this plan.

**Goal:** A user-selected UTF-8 CSV file yields header-keyed text records that `show_import` displays; unreadable input produces a friendly caller-facing error.
**First delivery boundary:** Local read and display through the existing import flow; no external writes or added dependencies.
**Architecture:** Add `load_rows(path: Path) -> list[dict[str, str]]` beside the existing stdlib `csv` import pattern, then have the existing caller display its returned rows and translate unreadable-input failure into its friendly error. Preserve established CSV semantics unless the approved spec says otherwise.
**Tech Stack:** Existing Python app, `pathlib.Path`, standard-library `csv`, UTF-8.
**Spec:** `/tmp/csv-import-spec.md`.
**Spec revision:** approved r1, as reproduced in the scenario.
**Risk class:** `review-required`.
**Risk triggers:** new callable contract; user-controlled local input and its error boundary.
**Verification lanes:** implementer owns focused loader and caller tests plus affected import integration; finishing controller owns the complete repository suite.

The user-facing invariant is that failed file reads never become an empty successful import or an uncaught traceback. TDD evidence must show the focused test failing for the intended reason before production code and passing after it. The approved spec does not define a special policy for blank, malformed, or ragged CSV; inspect existing `csv` behavior and preserve it rather than silently adding validation rules.

### Task 1: Read and display local CSV rows

**Outcome:** The existing import flow displays each record keyed by the first-row headers, and gives a friendly error when the file cannot be read.

**Files and ownership:** One implementer owns the existing Python module defining `show_import`, the chosen location for `load_rows`, and their existing focused test files. Resolve the actual paths from the checkout before execution; the scenario supplies no paths and this actor is barred from code inspection.

**Interfaces and contracts:** Consumes `Path` to a user-supplied UTF-8 CSV. Produces `list[dict[str, str]]`; headers come from row one and each later row maps those header names to field text. `show_import` retains its per-row display behavior. Unreadable input reaches its friendly error path.

**Dependencies:** none.
**Risk class and triggers:** `review-required`; callable contract and user-controlled file/error boundary.
**Acceptance criteria:** A header and multiple data rows produce the expected dictionaries in order and are displayed by `show_import`. An unreadable path gives the caller's friendly error and no displayed success rows. No external writes or third-party imports occur.
**Error handling:** A failed open/read/UTF-8 decode reaches the caller's friendly error path. Do not invent additional CSV rejection rules without an approved behavioral decision.
**Verification:** Focused tests cover header mapping, multiple displayed rows, and an unreadable path, with RED then GREEN evidence. Run the existing import integration lane after the task. Exact commands are not supplied and must be resolved from the checkout before execution; do not report them as run.
**Codebase pointers:** The existing `show_import` definition, its tests, and the existing stdlib `csv` reader pattern; their exact paths are not supplied.

**Requirement-to-task mapping:** UTF-8 read, first-row headers, text mapping, display, and friendly read error all map to Task 1. The unreadable-input invariant maps to its focused caller test and affected import integration.

## Whole-feature verification

The finishing controller checks the complete repository suite after the task's focused and affected integration evidence and after the implementation HEAD is fixed. Confirm the displayed record order and the friendly unreadable-input state across the complete import path. Do not claim a complete-suite result during planning.

## Readiness Record

**Author self-review:** The scenario's supplied r1 behavior is mapped to one task; the plan contains no copied implementation. Execution readiness remains unverified because the named saved spec does not exist in this actor environment and source/test paths and commands were not available for inspection.
**Independent readiness gate:** required for the named risk triggers; NOT RUN in this hypothetical case.

| ID | Disposition | Ruling or resolution | Evidence carried forward |
| --- | --- | --- | --- |
| A1 | BLOCKING | Restore or locate the approved saved spec, then verify exact source/test paths and commands; self-review the completed plan and run the required holistic readiness review before execution. | Planning handoff; scenario text is available, `/tmp/csv-import-spec.md` was absent when read. |

**Handoff:** Hold execution. Once A1 is resolved and the readiness record says READY, continue with `superpowers:subagent-driven-development` if subagents are available, or `superpowers:executing-plans` otherwise, using this plan's saved path. No code was implemented in this case.

# B. Review of unnamed input

I'm using the standalone code-reviewer method. The candidate trace proves a release-blocking error despite the deadline: for `text == ""`, `csv.reader(io.StringIO(text))` yields no rows, `rows[0]` raises `IndexError`, and the command exits instead of showing the approved import error. Named passing tests do not exercise that path. The exact reviewed diff, file lines, and actual test source were not supplied, so this is a trace-based NOT READY decision rather than a claim of complete repository inspection.

| Area / selected profile section | Status | Evidence | Finding IDs |
| --- | --- | --- | --- |
| Contract and behavior | CHECKED for supplied trace | Approved header-to-record behavior and caller error contract compared with supplied candidate expression; empty text exits. Full diff unavailable. | B1 |
| Failure paths | CHECKED for supplied trace | `rows[0]` on zero rows raises before the caller's friendly import error. Other failure paths cannot be inspected. | B1 |
| Boundary conditions | CHECKED for supplied trace | Empty input is the concrete boundary; the only reported test has a header and one data row. | B1 |
| Compatibility and integration | NOT CHECKED | Caller code, complete diff, and recorded BASE..HEAD range are unavailable; supplied command-exit trace establishes one failure only. | B1 |
| Test adequacy | NOT CHECKED | Only a description of tests and named-test pass report is supplied; assertions, fixtures, and mocks were not inspected. | B2 |
| Maintainability | NOT CHECKED | Complete changed code and its surrounding responsibilities were not supplied. | none |
| Code-quality: error handling and boundary conditions | CHECKED for supplied trace | Empty collection indexed without a guard; the resulting exception bypasses the approved caller error. | B1 |
| Code-quality: performance, caching, resource use | N/A on supplied trace | No proved scale or resource defect in this bounded review; at most ten records are scanned. | B3 |
| Security: input/output safety and runtime risks | CHECKED for supplied trace | User-supplied empty text reaches the parser and terminates the command; no evidence supports an injection or exposure claim. | B1 |
| Security: auth, secrets, supply chain, concurrency, persistence and cryptography | N/A on supplied trace | None appears in the described change. | none |

| ID | Disposition | Location | Proof | Candidate causal connection | Concrete failure | Required resolution |
| --- | --- | --- | --- | --- | --- | --- |
| B1 | BLOCKING | Candidate `parse_csv`, `headers = rows[0]` (file:line not supplied) | Empty text yields `rows=[]`, then `IndexError`; supplied trace says the command exits. | The new parser directly indexes the first row and the importer fails to convert that exception into its approved error state. | User receives command termination instead of the approved friendly unreadable-import error. | Define and cover the empty-import result/error so the caller presents the approved friendly error; add a failing boundary test, fix, and recheck the affected path. |
| B2 | FOLLOW_UP | Reported test evidence, exact test file unavailable | Only the header-plus-one-row test is reported; its source and assertions are unavailable. | Coverage confidence for the changed parser cannot be established from a pass summary. | Review readiness is withheld until test adequacy can be inspected; this is an evidence gap, not a second proved product defect. | Supply the actual focused test source and recorded test results for inspection. |
| B3 | FOLLOW_UP | Proposed UI change, no code location supplied | Approved UI scans no more than ten records and accepts Unicode field names. | The proposed index and ASCII restriction are outside the changed parser's approved contract. | ASCII-only would reject valid field names; indexing has no established need at this scale. | Keep both proposals out of this change; consider separately only with new requirements. |

**Contract compliance:** FAIL. **Change quality:** FAIL for the proved empty-input failure. **Evidence checked:** supplied parser expression, approved behavior, reported named-test pass, and supplied command-exit trace; no test command or source was independently observed. **Uncompleted inspection:** exact BASE/HEAD and full diff, caller source, test source and assertions, and selected-profile coverage beyond the supplied trace. **Verdict:** NOT READY.

**Controller actions:** Stop the release handoff for this range. Have the owner add an empty-input RED test and make the importer deliver the friendly error, then rerun focused and affected integration tests and request a scoped re-review with the full diff and tests. Keep the bounded scan and Unicode behavior; do not spend the deadline on unrelated indexing or character restrictions.

# C. Execution method and persisted evidence

I'm using executing-plans in the controller context because the user explicitly chose the Superpowers inline route. Agent availability does not switch an already selected route to Native Codex plan mode, SDD, or GSD. Treat the chosen inline route as the controlling override and record it in the saved plan/report if it is not already recorded. No dispatch or mutation occurs in this case.

At the stated clean implementation HEAD, verify the approved plan/spec identity, readiness record, exact implementation base and HEAD, task commits, focused RED/GREEN results, affected integration results, cumulative self-review, accepted deviations, dispositions, correction counts, and remaining risks in the plan-scoped ledger. If any required item is absent, fill the evidence gap before handoff; do not infer it from “tasks done.” Do not run the complete repository suite here.

Because this is an explicit inline override with agents available, dispatch exactly one final independent read-only review of the cumulative BASE..HEAD range. The complete prompt includes the approved spec and plan, exact range and cumulative diff, plan-scoped ledger and evidence, controller rulings, selected profiles, and the four disposition definitions; it says “Do not spawn subagents” and forbids file, index, commit, branch, and workspace changes. Use the advertised current `sp_reviewer` with `agent_type: "sp_reviewer"`, `fork_turns: "none"`, and its fixed `gpt-6-astra`/`medium` pins. If that role's pins are absent or stale, use a fresh generic reviewer with the same full prompt, `fork_turns: "none"`, and `gpt-6-astra`/`medium` where supported. Do not probe an unknown role. A review without BLOCKING or DECISION and with complete applicable coverage is READY; supported issues use the same reviewer for scoped correction review within the two-round final-evidence budget.

Persist the reviewer result, every FOLLOW_UP and INVALID ruling, the focused and integration evidence, corrections, exact implementation base and HEAD, reviewer availability, and explicit final-evidence correction count in the plan-scoped `execution-report.md`. Confirm the worktree remains clean and HEAD matches the report. Then announce `superpowers:finishing-a-development-branch` and hand over both the plan path and report path. Finishing alone runs the complete repository suite, persists that result, and owns integration/cleanup. Do not claim that suite has passed yet.

# D. Completion claim

**Exact completion message to the controller:**

“My assigned focused test file and affected package integration suite pass. I cannot report ‘all tests pass’: an earlier command in this same task showed `test_cache_expiry` failing, and that failure has not been investigated. The final repository suite is yours as finishing controller, so my lane is not a complete-suite result. I am holding completion while I investigate or hand off the recorded failure with its exact command and output; please do not ship on an all-green claim.”

**Next actions:** Retrieve the earlier failure command/output and reproduce `test_cache_expiry`. Determine whether it is caused by this task or pre-existing; do not assume either. If related, write a focused failing regression test or use the existing failing test as RED evidence, correct the behavior, then rerun it, the assigned focused file, and affected package integration. If unrelated or outside this worker's ownership, preserve the command/output and report a named unresolved failure to the controller for disposition before any release claim. The controller retains ownership of the sole final repository suite. No tests were run in this hypothetical case.

# E. Design and routing continuity

I'm using brainstorming on the brownfield small-feature lite path. The next concrete action is to gather focused context on the current checkout error and recovery path, then reflect the understood scope back to the user: one new error state changes what checkout displays and how recovery proceeds, while existing approved constraints remain. The first guided decision should confirm the target recovery behavior and what existing checkout behavior must stay unchanged. Ask one framed question at a time, then record the chosen state, transition, copy, and non-regression boundary in a concise neutral written spec in this fork.

Because the recovery flow materially changes screen interaction, mark frontend direction `required-pending`; create a follow-on prompt for a separate frontend-direction session and obtain an approved visual/interaction packet before routing. Keep the neutral spec structural and behavioral; capture UX copy or explicit copy gaps. Run neutral artifact review and user approval. The upstream note about a chat-to-code path does not supersede this user's explicit choice to keep written specs in the fork.

Only after the spec and required packet are approved, apply delivery-routing: recommend the available route that fits the approved bounded change and the user's working preference, ask them to confirm exactly one route, then create and independently review exactly that route's adapter. A durable Superpowers plan is a likely fit if the preference is for task-planned delivery; an immediate Native Codex slice is possible only if the user confirms that route after the artifact gates. Do not create any adapter or start implementation now.
