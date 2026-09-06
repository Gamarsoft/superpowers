---
name: requesting-code-review
description: Use for an explicit ad hoc review, after a major feature, or before integration when no active workflow already owns review
---

# Requesting Code Review

## Boundary

Request one independent, read-only review for an ad hoc, major-feature, or pre-integration
change. This public skill does not own SDD task, checkpoint, correction, or
final review. When another active workflow already owns review, return control
to that workflow instead of adding a duplicate gate.

**Core principle:** one explicit contract, one recorded range, one reviewer,
one shared disposition language.

## Required Inputs

Do not dispatch until all are available:

- the requirements or approved specification source, as a reachable path or
  complete bounded text;
- a short description of what changed;
- the exact recorded BASE and HEAD commit IDs;
- named risk triggers, or `none`; and
- the changed-file list used for profile selection.

Validate both revisions as commits and require BASE to be an ancestor of HEAD.
Never infer the range from a relative parent or “latest task” guess. Missing
requirements or an invalid range blocks review dispatch.

## Select Review Depth

Read `references/review-method.md` and `references/profile-selection.md`.
Select only profiles justified by the changed files or named risk. Record each selected profile and its predicate in
the prompt. The default review is stack-neutral; an unselected profile is not a
silent mandatory checklist.

Profiles deepen inspection but remain subordinate to approved scope and the
four finding dispositions. They cannot create requirements or turn adjacent
improvements into blockers.

## Dispatch

Read `code-reviewer.md` completely and substitute every placeholder. Send the
reviewer the requirements source, description, exact BASE/HEAD, risk triggers,
selected profile paths, and absolute Superpowers directory. Do not send session
history.

For Codex:

- use `fork_turns: "none"`;
- use `agent_type: "sp_reviewer"` only when that exact role is in the
  runtime-advertised list; and
- if it is absent, omit `agent_type` and send the same complete prompt to a
  fresh generic agent. Do not probe an unknown role with a failing call.

Other harnesses use one fresh read-only reviewer with the same prompt.

## Consume the Result

Require the shared method's coverage table with evidence, followed by one findings
table using `BLOCKING`, `DECISION`, `FOLLOW_UP`, and `INVALID`, plus
a `READY` or `NOT READY` verdict.

- Any applicable `NOT CHECKED` coverage requires `NOT READY`. Complete the
  missing inspection with the same reviewer before accepting the review. This
  is review completion, not a code correction round or a new gate.
- A supported `BLOCKING` defect must be fixed before integration.
- A `DECISION` returns to the authority for observable WHAT, protected,
  destructive, or external action.
- A `FOLLOW_UP` is preserved outside the current delivery boundary.
- An `INVALID` finding keeps the reason and evidence for rejection.

The calling workflow owns fixes and may request a new review over a newly
recorded range. Do not invoke `receiving-code-review` for this internal result,
and do not start an open-ended reviewer/fixer loop.

## Use Cases

Use this skill when the human explicitly asks for review, after completing a
major feature outside another review-owning workflow, before integration, or
when a bounded independent diagnosis would unblock work.

Do not use it automatically after every task or checkpoint.
