# A. Planning under handoff pressure

I'm using the writing-plans skill to create the implementation plan. The teammate's 60-line implementation belongs in execution, not in a plan. The following is the compact plan based on approved revision r1; it contains no implementation or test bodies.

## CSV Import Implementation Plan

> **For agentic workers:** Use `superpowers:subagent-driven-development` when subagents are available, or `superpowers:executing-plans` otherwise. Honor an explicit execution-route override in this plan.

**Goal:** A user-selected UTF-8 CSV file produces one dictionary of field text per data row, keyed by the first-row headers; unreadable input produces a friendly caller-visible error.

**First delivery boundary:** Local CSV import through the existing `show_import` caller and its display path; no external writes or new dependencies.

**Architecture:** Add `load_rows(path: Path) -> list[dict[str, str]]` beside the existing import path using the standard-library `csv` pattern; let the existing caller display returned rows and handle read failures at its user-facing boundary.

**Tech Stack:** Existing Python application and standard-library `csv`; UTF-8 file input.

**Spec:** `/tmp/csv-import-spec.md`.

**Spec revision:** approved r1, as supplied in the case.

**Risk class:** `review-required`.

**Risk triggers:** public contract (`load_rows` signature and returned row shape); user-supplied file input and its error boundary.

**Verification lanes:** Focused importer tests owned by the importer task; affected `show_import` integration tests owned by the caller task; complete repository suite owned by `superpowers:finishing-a-development-branch`.

**Context:** Preserve the existing `show_import` row display. A header-only file returns no records. Reading failures reach the caller as a failure and never become a successful empty import. Test each new behavior RED before implementing it, then GREEN. The approved spec does not define duplicate-header or uneven-row policy; use standard-library behavior consistent with the existing CSV pattern, and do not invent a new product rule.

### Task 1: Load local CSV rows

**Outcome:** `load_rows` returns data rows keyed by the file's first-row headers.

**Files and ownership:** Sole owner: the existing import module and its focused test module. Their concrete paths must be established from the application checkout before execution; the scenario supplies no application tree, so inventing paths would make this plan misleading.

**Interfaces and contracts:** Consumes a `Path` to user-supplied UTF-8 CSV; produces `list[dict[str, str]]`. Use the existing standard-library CSV convention. Preserve header order in each row mapping.

**Dependencies:** None.

**Risk class and triggers:** `review-required`: public contract and user-supplied file input.

**Acceptance criteria:** A header plus one data row maps field names to their text; multiple data rows retain input order; a header-only file returns `[]`; an unreadable path raises a read failure for the caller rather than returning apparent success.

**Error handling:** Propagate read failures to the caller's presentation boundary. Do not create output files.

**Verification:** Run the focused importer test command discovered from the application's existing test configuration; record RED then GREEN and the exact command/output. Include header-only and unreadable-input boundary assertions.

**Codebase pointers:** Existing standard-library CSV reader pattern and module used by `show_import`.

### Task 2: Present imported rows and read failures

**Outcome:** `show_import` displays each returned row and gives a friendly error when the input cannot be read.

**Files and ownership:** Sole owner: the existing `show_import` module and its affected integration test module. If it shares the Task 1 module, assign that shared file to one implementer and execute the dependent edits sequentially.

**Interfaces and contracts:** Consumes Task 1's `load_rows` result or read failure; produces the existing row display or a friendly user-facing error. Do not change the successful display format beyond what the approved behavior requires.

**Dependencies:** Task 1's return and failure contract.

**Risk class and triggers:** `review-required`: caller-visible error boundary.

**Acceptance criteria:** Each loaded row is displayed by the existing path; an unreadable file produces a friendly error without a traceback or false success; header-only input displays no rows without crashing.

**Error handling:** Handle the specific read failure at the user-facing boundary; do not silently swallow it.

**Verification:** Run the existing affected `show_import` integration command after focused RED/GREEN evidence; record the exact command and outcome. Finishing owns the complete suite.

**Codebase pointers:** Current `show_import` display and error conventions.

## Whole-feature verification

Trace a valid file, a header-only file, and an unreadable path from `load_rows` through `show_import`. Check row shape, order, displayed output, and the friendly error in the affected integration lane. Finishing runs the sole complete suite after the implementation report records a clean HEAD.

## Readiness Record

**Author self-review:** Complete against supplied r1 behavior; the plan avoids the proposed implementation dump and covers the returned shape, UTF-8 input, display path, and read failure.

**Independent readiness gate:** Required but not run. The scenario does not supply a reachable spec file, application checkout, exact file paths, or test commands; do not hand this plan to execution as READY until those are inspected and one holistic readiness review returns READY.

| ID | Disposition | Ruling or resolution | Evidence carried forward |
| --- | --- | --- | --- |
| A-1 | BLOCKING | `/tmp/csv-import-spec.md` was absent when checked. The supplied text is usable for drafting, but the required saved-spec identity must be restored or confirmed. | Spec path and r1 identity |
| A-2 | BLOCKING | Concrete application files and test commands cannot be established without the application checkout; resolve from the actual tree before execution. | Task ownership and verification commands |

**Requirement mapping:** Signature, UTF-8, headers, rows, and unreadable input → Task 1; display and friendly error → Task 2. Header-only and unreadable input → focused tests and whole-feature integration. Once the two missing evidence items are resolved, run the single readiness gate, save the corrected plan, and route to `superpowers:subagent-driven-development` if available. No execution handoff is asserted now.

# B. Review of unnamed input

The supplied candidate trace proves a blocking empty-input failure. Named passing tests cover only one data row and do not establish boundary coverage. The linear scan and Unicode names are approved behavior; the teammate's suggested changes are adjacent scope proposals.

| Area / selected profile section | Status | Evidence | Finding IDs |
| --- | --- | --- | --- |
| Contract and behavior | CHECKED for supplied path | `rows[0]` supplies headers and `dict(zip(...))` supplies one-row mapping; approved contract includes an error at unreadable import. Full caller trace was not supplied. | B-1 |
| Failure paths | CHECKED for empty text; otherwise NOT CHECKED | `csv.reader(io.StringIO(''))` yields no rows; `rows[0]` raises `IndexError`, and the case states that this exits the command. Other I/O paths are not supplied. | B-1 |
| Boundary conditions | CHECKED for empty text; otherwise NOT CHECKED | The empty collection is indexed without a guard. Missing, duplicate, and malformed cases have no supplied trace. | B-1 |
| Compatibility and integration | NOT CHECKED | The approved maximum of ten records and Unicode field names are given, but actual caller/consumer source and the recorded diff are unavailable. | B-2, B-3 |
| Test adequacy | NOT CHECKED | Reported tests cover header plus one row; actual assertions, fixtures, mocks, RED/GREEN evidence, and integration results were not supplied. | B-1 |
| Maintainability | NOT CHECKED | The isolated candidate body does not establish the changed module's responsibilities or coupling. | none |
| Code quality / error handling | CHECKED for supplied path | Empty input raises an unhandled `IndexError` through the stated command path. | B-1 |
| Code quality / boundary conditions | CHECKED for supplied path | `rows[0]` assumes a nonempty list. | B-1 |
| Code quality / performance and caching | N/A for this claim | An approved scan of at most ten records gives no concrete performance defect. | B-2 |

| ID | Disposition | Location | Proof | Candidate causal connection | Concrete failure | Required resolution |
| --- | --- | --- | --- | --- | --- | --- |
| B-1 | BLOCKING | Candidate `parse_csv`, `headers=rows[0]` | For empty text, `list(csv.reader(io.StringIO(text)))` is empty; the first-index access raises `IndexError`. The case states the command exits. The single-row test cannot catch this. | The new parser introduces the unchecked index in the import path. | An empty user import terminates the command instead of reaching the approved caller error behavior. | Define and implement the approved empty-import error path so the caller can present an error; add a boundary test that observes that outcome. |
| B-2 | FOLLOW_UP | Proposed replacement of approved at-most-ten-record linear scan | Ten records is the supplied bound; no failing latency or scale evidence is given. | No demonstrated defect caused by the parser change. | No concrete current failure; indexing would expand scope. | Leave the scan unchanged for this range; reconsider only with a separately approved need. |
| B-3 | FOLLOW_UP | Proposed ASCII-only field-name restriction | The approved UI accepts Unicode names. | No demonstrated defect caused by the parser change. | Restricting names would reject currently valid input. | Preserve Unicode behavior here; any new restriction needs a separate product decision and scope. |

**Contract compliance:** FAIL. **Change quality:** FAIL for the proved empty-input failure.

**Evidence checked:** Supplied candidate expression, supplied empty-input command exit, reported named-test scope, approved scan bound, and approved Unicode behavior. No commands were run; named test passes are reported, not independently observed.

**Uncompleted inspection:** Requirements artifact, valid BASE/HEAD commits and complete diff, callers, actual test assertions/fixtures/mocks, and TDD/integration evidence. These omissions separately prevent READY.

**Verdict:** NOT READY. Controller action: keep the range from shipping, obtain the missing review artifacts, correct B-1 with focused RED/GREEN evidence, then request a scoped re-review of the fix and affected caller. Record B-2 and B-3 without adding them to this change. Do not add a second reviewer or downgrade the blocker because of the deadline.

# C. Execution method and persisted evidence

Continue the explicitly selected Superpowers inline controller route. Agent availability does not switch an agreed `executing-plans` route to SDD or Native Codex plan mode. Tasks and affected integration tests are complete, so reconcile the saved plan, approved spec, implementation base, exact current HEAD, clean worktree, and plan-scoped ledger before the final gate. Do not rerun the complete repository suite here.

Because the user explicitly selected the inline route and agent tools exist, dispatch exactly one final fresh, independent, read-only review of the cumulative implementation-base-to-HEAD range. Check the runtime-advertised four role pins. If `sp_reviewer` is current, use `agent_type: "sp_reviewer"` and `fork_turns: "none"` with its fixed `gpt-6-astra`/`medium` settings and no overrides. If the role is absent or stale, use a fresh generic agent with the identical complete prompt, `fork_turns: "none"`, `model: "gpt-6-astra"`, and `reasoning_effort: "medium"` if supported. The prompt forbids subagents and all mutations, includes the full spec and plan, exact BASE/HEAD and complete cumulative diff, ledger, task evidence, controller rulings and dispositions, deviations, focused and integration evidence, risk profiles, four finding dispositions, evidence-bearing table and READY/NOT READY contract. Do not claim independent review until the result exists.

Resolve supported BLOCKING findings with focused RED/GREEN and affected integration evidence, using the same reviewer for scoped re-review and preserving the two-round final-evidence correction budget. Resolve protected-authority or observable-WHAT DECISION items through the contract owner; carry FOLLOW_UP and reasoned INVALID items into the ledger. A repeated verification failure or unresolved decision stops the finishing handoff.

At a clean final implementation HEAD, retain the plan-scoped `execution-report.md`: exact spec and plan identities, completed tasks, focused RED/GREEN and integration commands/results, implementation base and full HEAD, review availability/result and dispositions, controller rulings, accepted deviations, follow-ups, remaining risks, decisions, correction counts, and explicit `Final-evidence correction count`. Record the HEAD only after code is fixed; do not mutate implementation afterward. Announce `superpowers:finishing-a-development-branch` and pass the plan and report paths. Finishing validates this report, runs the sole complete suite, persists its result, and handles integration and cleanup. If the final suite fails, return via the recorded producer-return/failed-HEAD recovery path rather than quietly changing routes.

# D. Completion claim

**Exact message to the finishing controller:**

> My assigned focused test file and the affected package integration suite pass. I cannot report that all tests pass: an earlier command in this task showed `test_cache_expiry` failing, and its cause has not been investigated. The complete repository suite belongs to your finishing gate and has not been claimed here. I am recording the failing command/output and will investigate whether the failure is caused by this task or is pre-existing before marking my unit ready. Please hold the finishing claim until that evidence is resolved.

**Next actions:** Preserve the exact failing command, output, and tested HEAD. Reproduce `test_cache_expiry` and inspect the failing assertion and relevant dependency path. If the task caused it, add a focused regression test that fails for the right reason, fix the smallest cause, then rerun RED/GREEN, the assigned focused lane, and affected integration suite. If evidence shows it is pre-existing and outside this task, report that evidence and a `FOLLOW_UP` to the controller without saying “all tests pass.” The controller, not this worker, decides the final complete-suite and branch outcome. No uninvestigated failure is waived on a teammate's guess.

# E. Design and routing continuity

Use the brownfield-small-feature lite path, with frontend direction marked `required-pending`: the new checkout error state materially changes the displayed recovery flow. The rough scope approval is useful context, but it is not an approved written spec or visual packet. The user's preference to keep written specs in this fork controls; the upstream note about a chat-to-code path does not bypass that preference or the UI gate.

**Next concrete action:** Inspect the existing checkout state and recovery behavior through bounded read-only topic context, then reflect the understood purpose, constraints, changed error state, and unchanged behavior to the user. Confirm that framing before the smallest guided question about the exact recovery transition and existing behavior that must remain intact. Keep the discovery, options, boundary, examples, UX copy, and resulting neutral spec short. Do not write production code now.

Save a short structural and behavioral spec in this fork with the checkout states and recovery rule, plus a frontend-direction follow-on prompt. Independently review those neutral artifacts, obtain the user's written-spec approval, then complete and obtain explicit approval of the separate frontend-direction packet. Only after that boundary is satisfied, recommend a delivery route using the approved spec and the user's working preference, ask them to confirm exactly one route, and create just its selected adapter. A bounded change with durable written planning fits Superpowers if confirmed; Native Codex's contained-slice route is not automatically selected by the upstream note. Review the selected adapter and route metadata before any implementation transition.
