---
name: gsd-test-driven-development
description: Use when executing GSD feature work, bug fixes, refactors, or behavior changes before production code is changed.
---

# GSD Test-Driven Development

## Mission

In GSD, execution should produce both working code and durable proof.

For behavior changes, write the failing test first, watch it fail for the right reason, then implement the smallest code change that makes it pass.

## Use When

- implementing a new feature
- fixing a bug
- changing behavior
- refactoring code with regression risk

## Best Place In GSD

This is primarily an **execution-phase** skill.

Use it while working from:

- `T##-PLAN.md`
- `S##-PLAN.md`
- roadmap or requirement-driven behavior changes

If planning reveals a behavior change with no obvious proof path, shape the task so it includes the failing test first.

## Rule

No production-code behavior change without a failing test first.

## Workflow

### 1. Read project testing guidance first

Before designing the test, read the project's testing guidance and execution rules.

Start with:

- `AGENTS.md`
- `TESTING.md`
- any clearly relevant testing or contribution docs in the repo

Do not invent a test workflow that conflicts with project guidance that already exists.

If the task depends on a testing framework, runner, matcher library, browser harness, or build-integrated test tool and you are not fully sure about the current API, use `gsd-context7-research` before writing the test.

This is especially important for frameworks and tools with shifting APIs or deprecated patterns such as JUnit, Karma, Jest, Playwright, Vitest, Cypress, or similar tools in the repo.

Do not write tests against stale memory when the current framework docs may have changed.

### 2. Read the task and identify the proof boundary

Before editing code, answer:

- what behavior is changing?
- what observable proof would show it works?
- what is the smallest test that captures that behavior?

Prefer the narrowest test that proves the current task, not a broad end-to-end harness unless that is the real boundary.

### 3. Write one failing test

Write the minimum test that captures the intended behavior.

Good tests are:

- specific
- behavior-focused
- small
- easy to understand later

### 4. Run the test and watch it fail

Do not skip this.

Confirm the test fails for the expected reason:

- missing behavior
- wrong behavior
- current bug still present

If the test passes immediately, it is not proving the change you think it is.

### 5. Implement the smallest change

Change only what is needed to make the failing test pass.

Do not bundle unrelated cleanup or speculative abstractions into the same step.

### 6. Run focused verification

Run:

- the new test
- any adjacent tests that are the obvious regression surface

If the task changes build or runtime behavior materially, run the relevant project verification too.

### 7. Record the proof in GSD artifacts

Capture the red-green evidence in the task summary:

- what test was added or updated
- how it failed before the fix
- how it passed after the fix
- any regression coverage or limits

If the task changed architectural assumptions, append the durable decision to `.gsd/DECISIONS.md`.

Keep artifact boundaries explicit:

- Put red-green narrative in the task summary, slice summary, or UAT artifact that owns execution proof
- If `REQUIREMENTS.md` needs updating, keep it to compact status or validation references only, not the full failing-then-passing story
- If `DECISIONS.md` needs updating, record only the durable decision and rationale, not the test transcript

## GSD-Specific Guidance

- Project testing guidance wins over generic TDD habits when they conflict
- Current framework docs win over remembered but possibly deprecated testing patterns
- Task plans should mention the intended proof path when the task is behavior-heavy
- If a task is too large to produce a clear failing test first, split the task
- If browser behavior is the real proof surface, combine this skill with browser-based verification rather than pretending a unit test is enough
- If you cannot create a meaningful failing test, state why plainly in the summary instead of faking TDD
- Requirement traceability should stay compact; reference the proof artifact instead of expanding requirement rows into mini summaries
- Do not let `DECISIONS.md` become a running log of red-green cycles; only stable decisions belong there

## Anti-Patterns

- writing code and adding tests afterward
- claiming “covered by existing tests” without showing which one failed first
- adding multiple tests and multiple fixes at once
- using mocks so heavily that the test no longer proves real behavior
- using deprecated test APIs, runners, matchers, or setup logic because they were remembered from older versions
- skipping artifact updates after the test passes
- copying detailed red-green evidence into `REQUIREMENTS.md` instead of the owning summary or UAT artifact
- appending temporary debugging or test-run history to `.gsd/DECISIONS.md`

## Completion Standard

A GSD task that used this skill should leave behind:

- a clear failing-then-passing proof path
- implementation sized to the test
- a summary the next agent can trust
