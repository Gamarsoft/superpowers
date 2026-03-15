# Code Quality Reviewer Prompt Template

Use this template when dispatching a code quality reviewer subagent in subagent-driven development.

**Purpose:** Verify implementation is well-built (clean, tested, maintainable)

**Only dispatch after spec compliance review passes.**

## Template Integrity Rule

Build this prompt from `skills/requesting-code-review/code-reviewer.md` in full. Do not abbreviate or paraphrase. Replace placeholders only.

If you think a slimmed-down prompt is enough, ask the user first.

## How to Dispatch

1. Read `skills/requesting-code-review/code-reviewer.md` in full.
2. Paste it verbatim into the subagent prompt body.
3. Replace all placeholders:
   - WHAT_WAS_IMPLEMENTED: [from implementer's report]
   - PLAN_OR_REQUIREMENTS: Task N from [plan-file]
   - BASE_SHA: [commit before task]
   - HEAD_SHA: [current commit]
   - DESCRIPTION: [task summary]
   - SUPERPOWERS_DIR: Absolute path to the superpowers directory
4. Append the full addendum below unchanged.

## Required Addendum (append after code-reviewer.md content)

```md
## Additional Checklist (subagent-driven development only)

In addition to the standard code quality concerns from the reviewer template, also check:

- Does each file have one clear responsibility with a well-defined interface?
- Are units decomposed so they can be understood and tested independently?
- Is the implementation following the file structure from the plan?
- Did this implementation create new files that are already large, or significantly grow existing files? (Don't flag pre-existing file sizes — focus on what this change contributed.)

## Plan-Aware Constraint

**Respect documented boundary decisions.** If the task's "Error handling" section or
acceptance criteria explicitly resolve a boundary decision (e.g., "skip invalid origins,
do not reject"), do NOT flag the corresponding implementation as a security or quality issue.
The decision was made at plan time and is not open for re-litigation at review time.

**Litmus test:** "Is this a quality issue with HOW the code is written, or a disagreement
with WHAT the plan decided?" If the latter, it's a plan decision — not a review finding.

**What you CAN still flag:**

- Bugs in how a boundary decision was carried out (e.g., null pointer in skip logic)
- Missing boundary handling for surfaces the plan's error handling section didn't cover
- Security issues unrelated to documented boundary decisions
- All standard code quality concerns (naming, DRY, SOLID, test coverage, architecture)

## Accepted Decisions

[ACCEPTED_DECISIONS — orchestrator fills this with any DONE_WITH_CONCERNS items accepted
before review and relevant decision log entries. Treat these as settled — do not re-litigate.]
```

**Code reviewer returns:** Strengths, Issues (Critical/Important/Minor), Assessment
