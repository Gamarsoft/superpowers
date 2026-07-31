# Workflow preferences

- For implementation, bug fixes, refactors, and behavior changes, use `tdd`.
- Do not write or change production behavior before a focused failing test or an executable repro exists.
- For failing verification, regressions, flaky behavior, or unexpected runtime behavior, use `debug-like-expert` before proposing or applying fixes.
- After the focused proof passes, always run the broader full project verification relevant to the change before claiming completion.
- If two fix attempts fail, stop stacking patches. Revisit root cause, task framing, or architecture before changing more code.
- Do not mark a task, slice, or milestone complete without fresh verification evidence; use `verify-before-complete`.
- If pre-commit formatting change only the code syntax, do not re-run verification before completion or code review. If the formatting change also changes behavior, run verification and code review as normal.
- When a task depends on third-party libraries, frameworks, SDKs, APIs, or version-sensitive tooling, use `gsd-context7-research` before editing code.

## Live Runtime State-Proof Policy

- When a project provides a live runtime, local database, state-shaping workflow, or dedicated skill for end-to-end verification, use that workflow before fixture or mock proof for frontend/backend, persistence, authorization, calculation, scheduler, service-wiring, and contract claims.
- Fixture and mock evidence is visual-state evidence only. Use it only when explicitly requested or when the live runtime workflow cannot practically create the state on demand, and state that boundary in UAT, reviews, and summaries.
- UAT, task summaries, and slice summaries must record concise proof notes: intended runtime state, source/schema files inspected, target environment, read queries or API paths used as evidence, any scoped writes, exercised browser/API/service path, observed backend/UI/DB result, and what was not proven.
- Keep raw runtime logs, screenshots, database dumps, and browser captures out of commits unless the task explicitly asks for committed evidence.

## Code Review Policy

- Use `gsd-code-review` for non-trivial implementation work, explicit review tasks, and any task touching auth, storage, external I/O, or superprojects with git submodules. Slice closeout should validate existing review artifacts and evidence instead of starting new review loops unless the slice is high risk or lacks required task-level review.
- For non-trivial work, plan review as a paired follow-up task instead of treating independent review as part of the implementation task alone.
- The default pattern is:
  1. implementation task
  2. review-and-resolve follow-up task
- At the end of the implementation task, after implementation, verification, submodule commits and before the task completes, run one fresh-context review pass in a `worker` subagent.
- That review pass writes one authoritative artifact for the implementation task being reviewed: `Txx-REVIEW.md`.
- The implementation task still completes normally after that first review pass whether the verdict is `APPROVE`, `REQUEST_CHANGES`, or `ESCALATE`.
- The follow-up review-and-resolve task is a no-op if `Txx-REVIEW.md` says `verdict: APPROVE`.
- If `Txx-REVIEW.md` says `verdict: REQUEST_CHANGES`, the follow-up task fixes or explicitly disproves every Critical and Important finding, reruns verification, then launches another fresh-context review pass.
- Only the fresh-context reviewer creates or overwrites `REVIEW.md`.
- Use at most 4 fresh review cycles inside the follow-up task. If `REVIEW.md` still does not say `APPROVE` after 4 cycles, stop and escalate through `replan-slice` or `blocker_discovered: true`.
- If `.gitmodules` exists, every review must inspect real submodule diffs, not only superproject pointer bumps.
- Fresh-context review pass should be started only after target submodule commits are done.
- Add a final `Review and resolve slice findings` task before `complete-slice` only for high-risk slices, cross-cutting behavior, auth, storage, external I/O, submodule-heavy changes, or non-trivial UI that lacks approved task-level visual review.
- Skip paired review tasks only for trivial work such as docs-only edits, copy-only edits, renames, formatting-only changes, or other clearly mechanical non-behavioral changes.

## Frontend direction and visual-truth policy

- For UI work, use `gsd-frontend-design`. For native or mobile-first work, add only the mobile skills whose surface is in scope.
- Read the strongest available evidence before planning or coding: approved spec/handoff, acceptance criteria, current product UI and design system, workflow `CONTEXT.md`, approved frontend packet and visual-truth source, `brownfield-ui-extraction.md`, `screen-index.md`, retained screenshots/captures, approved ChatGPT Images 2 files when selected, `PRODUCT.md`, `DESIGN.md`, and existing components/tokens. Treat `DESIGN.json` as auxiliary output. Temporary HTML companion artifacts are comparison aids only.
- If evidence is missing or the packet is under-specified, stop ad-hoc UI invention and ask for a packet refresh or record degraded current-UI mode. ChatGPT Images 2 is optional reference generation; current runtime evidence and concise packet prose are the default.
- Keep `## Frontend References` current in the relevant milestone or slice `CONTEXT.md`, with exact paths to packet artifacts, source evidence, screenshots/captures, approved generated images, and any `PRODUCT.md` or `DESIGN.md` files that materially guided the work.
- For visible UI copy, use `writing-ux-copy` unless an approved copy deck exists. Carry copy-deck paths, missing copy states, terminology, i18n variables, formatting rules, and accessibility names into plans, UAT, and summaries.
- Before visual changes, classify each implementation-facing reference as `visual-truth`, `semantic-guidance`, or `reference-only`. If reference intent is missing, ask for confirmation or record degraded mode. Verify `visual-truth` with parity checks and `semantic-guidance` with intent-fit checks.
- Brownfield work starts from a faithful runtime baseline. Preserve shell, product language, data density, and existing system rules unless the packet explicitly changes them. HTML companion decisions become durable only after they are captured in packet prose, screenshots/captures, or approved generated images.
- Runtime screenshots, traces, console/network logs, Flutter logs, simulator/device captures, and golden outputs are verification inputs, not default commit artifacts. Save raw evidence only in temporary, ignored, or external redaction-safe storage unless the task explicitly requires committed evidence.
- Live runtime state proof is the default for frontend/backend work. If the project provides database or state-shaping guidance, use it before fixture planning. Fixture mode remains a fallback for explicitly requested or impractical hard visual states only, and UAT plus visual review must separate live integration proof from fixture visual-state proof.
- For reference-backed UI verification, platform runtime evidence plus the approved reference checklist is required. Screenshots, DOM checks, compilation, linting, or test output alone are not enough. Any unresolved mismatch needs a waiver naming the source, approved intent, runtime mismatch, constraint, accepted fallback, and follow-up.
- For non-trivial UI implementation tasks, run one fresh-context visual review before task completion. The reviewer must read project instructions first: nearest `AGENTS.md`, relevant `.gsd/**/CONTEXT.md`, `PRODUCT.md`, `DESIGN.md`, task file, and slice or milestone instructions. The reviewer inspects approved packet evidence, visual-truth sources, approved reference checklist completion, and runtime evidence, then writes `VISUAL-REVIEW.md`. Slice completion should validate existing visual-review artifacts instead of launching a new visual review unless required evidence is missing.
- For web targets, the visual reviewer must use a fresh browser context when supported; do not reuse the implementer's browser session, route, storage, console state, or previously opened page. The reviewer must independently open the route/screen and recapture desktop/mobile evidence. Implementer screenshots, assertions, or summaries are comparison inputs, not a substitute for reviewer runtime proof.
- If independent runtime proof is unavailable because of `ERR_CONNECTION_REFUSED`, connection refused, server unavailable, simulator/device unavailable, route failure, app launch failure, or test-harness failure, the reviewer must not approve. Use `REQUEST_CHANGES` when a follow-up can restore runnable evidence or `ESCALATE` when the environment/task framing blocks review. Every `VISUAL-REVIEW.md` must include `Visual Review Completion Gates` covering project instructions read, fresh browser/runtime isolation or a recorded fallback, independent recapture, approved reference checklist completion, desktop/mobile scope, console/network or Flutter test/log checks, and any missing gate.
- Do not fall back to the bundled `frontend-design` skill when `gsd-frontend-design` and approved packet, image, screenshot, or runtime evidence artifacts are available.

## Spec and handoff projection policy

- Treat approved specs and GSD handoff docs as upstream source documents, then project their implementation-relevant context into native GSD workflow artifacts so later units inherit that context automatically.
- If a GSD handoff says frontend packet status is `required`, do not plan or execute frontend implementation yet. Run the referenced frontend-direction follow-on prompt first, then return with the approved frontend packet and support artifacts.
- For each active milestone or slice, maintain a `## Source Documents` section in the relevant `CONTEXT.md` with exact relative paths to the approved spec, GSD handoff, frontend direction packet, selected visual-truth source, approved ChatGPT Images 2 generated image files when selected, `brownfield-ui-extraction.md`, `screen-index.md`, retained screenshots/captures, any temporary HTML companion artifacts that still matter, any `PRODUCT.md` or `DESIGN.md` files that materially guided the work, and any other binding source documents.
- In milestone or slice `CONTEXT.md`, summarize only what the downstream unit needs: in-scope capabilities, affected screens, routes, components, APIs, data contracts, constraints, open questions, verification notes, selected visual-truth source, and any required image, screenshot, capture, or evidence paths.
- Keep `.gsd/REQUIREMENTS.md` aligned with the approved spec and handoff. Record active requirements, validated requirements, deferred items, explicit non-goals, and scope boundaries that matter to implementation.
- Treat `.gsd/REQUIREMENTS.md` as a compact capability and coverage contract, not as a proof log. Keep requirement descriptions, notes, and validation concise and durable.
- When requirements need verification updates, store only short status or proof references there, such as the owning slice, UAT, summary, or review artifact path. Do not paste narrative test histories, browser transcripts, or long closeout summaries into requirement entries or traceability tables.
- Keep traceability sections reference-only. Table cells should stay short and structured.
- Append fixed implementation choices, architecture constraints, library decisions, API contracts, and conventions from the approved spec or handoff to `.gsd/DECISIONS.md` instead of leaving them only in external docs or transient summaries.
- Treat `.gsd/DECISIONS.md` as a durable decision register. Record the decision, rationale, and revisability boundary, not the surrounding execution log, red-green transcript, or per-run evidence.
- Put reusable cross-slice patterns from the approved docs or completed work into `.gsd/KNOWLEDGE.md`. Put environment, services, endpoints, feature flags, background jobs, and operational dependencies into `.gsd/RUNTIME.md` when relevant.
- When writing slice plans and task plans, translate the approved spec and handoff into concrete Goal, Must-Haves, Files, Key Links, Context, and Verify sections. Reference the exact source documents or screens that justify the plan.
- When writing UAT, task summaries, or slice summaries, record which spec, handoff, packet, approved ChatGPT Images 2 file, screenshot, capture, reference intent mode, and temporary HTML companion sources were satisfied, what evidence was gathered, any parity or intent-fit mismatches or waivers, and any approved deviations or follow-up work.
- When a source spec, handoff, direction packet, approved image set, or source evidence changes materially, refresh the affected GSD workflow docs before continuing planning or implementation.

## Superproject + Submodule Commit Policy

Before saying "Task complete" during an implementation or review-and-resolve task:

**1. Detect submodules:**

```bash
[ -f .gitmodules ] && echo "superproject" || echo "no submodules — skip this section"
```

If `.gitmodules` is absent, skip this entire section.

**2. Check for dirty working trees INSIDE submodules:**

```bash
# git submodule status is NOT sufficient — it does not see unstaged/uncommitted changes
git submodule foreach --quiet 'echo "=== $name ===" && git status --short'
```

A submodule needs action if this produces any output for it.

**3. For each submodule with uncommitted changes:**

```bash
cd <submodule-path>
git status --short              # see what is dirty
git add <task-related-files>    # stage only files touched by this task
git commit -m "chore(<taskId>): <description>"  # commit with proper message format
git status --short              # must be empty before returning
cd -
```

Repeat for every dirty submodule. Do NOT use `git add -A` blindly if the submodule has changes unrelated to this task — stage only what this task touched.

**4. Verify all submodule working trees are clean:**

```bash
git submodule foreach --quiet 'git status --short'
# Expected: no output
```

**5. Do NOT touch the superproject git index.**
Do not run `git add` or `git commit` in the superproject root.
Once submodules are committed, the auto-commit system handles the superproject pointer update automatically — it stages the updated SHA pointers via `git add -A` and commits them as part of the normal `chore(<unitId>): auto-commit after <unitType>`.

During `complete-slice`, do not create submodule commits. Only verify and report whether submodule working trees are clean and whether required task-level commits already exist.

**Hard rules:**

- <taskId> in commit messages must be the full task ID (e.g. M001/S01/T01)
- The agent's only git responsibility in a superproject is committing inside dirty submodules.
- Never run `git add` or `git commit` at the superproject root — that is system auto-commit's job.
- Never commit submodule changes that belong to a different task — stash them first.
- The step "Do not commit manually" in execute-task applies to the superproject root only. It does NOT exempt you from committing inside submodules — those are separate git repos.
