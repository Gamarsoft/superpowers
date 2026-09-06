# Shared review method

SDD and standalone review use this method inside their existing review gate.
Review depth comes from inspecting behavior and evidence, not adding reviewers.

## Inspect the change

Read the requirements and complete recorded diff. Trace changed behavior through
its callers, consumers, state, and error paths. Inspect relevant unchanged code
when it establishes those contracts; do not audit unrelated code. Treat reports
and test summaries as claims. When a report claims automated test coverage, inspect the actual test source,
assertions, fixtures, and relevant mocks. If that source is unavailable, mark
Test adequacy NOT CHECKED and request the missing artifact. Implementation
equivalence and a prose test summary cannot establish assertion quality.
Distinguish reported results from independently observed results. Revisit files when tracing a dependency requires it.

Apply `profile-selection.md` to the actual changed files and named risks. Plan
selections are inputs, not an exhaustive list. Record each selected path, its
predicate, and the files or behavior it covers. Read the selected checklists.
A reviewer who discovers an omitted applicable profile reads and applies it in
this same review, recording the addition. This does not create another gate.

## Baseline coverage

Apply every row to the review's scope, including ordinary work units. For a
non-code change, check the affected instructions or artifact contracts and mark
code-only checks N/A with a concrete reason.

| Area | Inspection required |
| --- | --- |
| Contract and behavior | Map acceptance criteria to implementation paths. Check missing and extra behavior, return values, state transitions, and preserved invariants. |
| Failure paths | Trace failed I/O, rejected inputs, exceptions, partial writes, cleanup, and recovery where present. Verify errors reach the correct caller and cannot become false success. |
| Boundary conditions | Inspect empty, missing, zero, limit, duplicate, and malformed inputs relevant to the contract. Check identity, isolation, and shared state when present. |
| Compatibility and integration | Trace affected callers and consumers, data shapes, defaults, configuration, and deployment assumptions. Check ordering, retries, concurrency, or migrations when changed behavior depends on them. |
| Test adequacy | Read assertions, fixtures, and mocks for changed behavior. Identify a plausible regression the tests would catch and a relevant failure or boundary they exercise. Check required TDD and integration evidence; a passing command alone does not prove coverage. |
| Maintainability | Inspect responsibility boundaries, duplication of rules, hidden coupling, and misleading abstractions in changed code. Explain a concrete consequence for a finding; size, style, or personal design preference alone is insufficient. |

Use specialist checklists to deepen applicable areas. Their smell lists are
questions to investigate, not automatic defects or new requirements. Missing
memoization, alerts, retries, or an abstraction is not itself proof of failure.

## Coverage output

Before the findings table, return:

Area / selected profile section | CHECKED / N/A / NOT CHECKED | Evidence | Finding IDs

Include one row for each baseline area and each relevant section of a selected
profile. Group inapplicable profile sections with a shared concrete reason.
CHECKED cites file:line, an inspected assertion, a traced path, or an evidence
artifact and explains what was established. A checklist path alone is not
coverage. N/A explains why the area does not apply. NOT CHECKED names missing
access or evidence and its impact; never disguise it as PASS or N/A.

A READY review requires complete applicable coverage and no supported BLOCKING
or unresolved DECISION. If required inspection is incomplete, return NOT READY
with the missing evidence, even if no code defect has been proved. Missing
review evidence is not automatically a product defect or a human decision.

Use the calling prompt's four finding dispositions. Empty findings are valid;
write `none` rather than inventing INVALID or FOLLOW_UP rows to fill a table.

## Correction and final review scope

For correction review, apply this method only to open findings, the fix diff,
and affected dependencies. Scope the coverage table accordingly; reference prior
coverage for unaffected areas. Re-evaluate profiles for fix-introduced behavior
and retain applicable prior selections. Do not restart the whole unit review.

For final integration, use the cumulative diff to trace whole-feature paths and
cross-unit contracts. Prior unit evidence can support unchanged local checks;
cite it with its reviewed range and verify later changes have not invalidated
it. Inspect the combined behavior directly. Unit READY verdicts alone do not
establish integration coverage.
