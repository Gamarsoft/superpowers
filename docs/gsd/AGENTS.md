# Workflow preferences

- For implementation, bug fixes, refactors, and behavior changes, use `gsd-test-driven-development`.
- Do not write or change production behavior before a focused failing test or an executable repro exists.
- For failing verification, regressions, flaky behavior, or unexpected runtime behavior, use `gsd-systematic-debugging` before proposing or applying fixes.
- After the focused proof passes, run the broader project verification relevant to the change before claiming completion.
- If two fix attempts fail, stop stacking patches. Revisit root cause, task framing, or architecture before changing more code.
- Do not mark a task, slice, or milestone complete without fresh verification evidence; use `gsd-verification-before-completion`.
- When a task depends on third-party libraries, frameworks, SDKs, APIs, or version-sensitive tooling, use `gsd-context7-research` before editing code.

## Code Review Policy

- Use `code-review` for non-trivial implementation work, slice closeout, and any task touching auth, storage, external I/O, or superprojects with git submodules.
- For non-trivial work, plan review as a paired follow-up task instead of treating independent review as part of the implementation task alone.
- The default pattern is:
  1. implementation task
  2. review-and-resolve follow-up task
- At the end of the implementation task, after implementation and verification but before the task completes, run one fresh-context review pass in a `worker` subagent.
- That review pass writes one authoritative artifact for the implementation task being reviewed: `Txx-REVIEW.md`.
- The implementation task still completes normally after that first review pass whether the verdict is `APPROVE`, `REQUEST_CHANGES`, or `ESCALATE`.
- The follow-up review-and-resolve task is a no-op if `Txx-REVIEW.md` says `verdict: APPROVE`.
- If `Txx-REVIEW.md` says `verdict: REQUEST_CHANGES`, the follow-up task fixes or explicitly disproves every Critical and Important finding, reruns verification, then launches another fresh-context review pass.
- Only the fresh-context reviewer creates or overwrites `REVIEW.md`.
- Use at most 4 fresh review cycles inside the follow-up task. If `REVIEW.md` still does not say `APPROVE` after 4 cycles, stop and escalate through `replan-slice` or `blocker_discovered: true`.
- If `.gitmodules` exists, every review must inspect real submodule diffs, not only superproject pointer bumps.
- For any non-trivial slice, add a final `Review and resolve slice findings` task before `complete-slice`, using a single slice-level `REVIEW.md` artifact.
- Skip paired review tasks only for trivial work such as docs-only edits, copy-only edits, renames, formatting-only changes, or other clearly mechanical non-behavioral changes.

## Frontend direction and Pencil workset policy

- For any task that researches, plans, re-plans, implements, verifies, or refines user-facing UI, use `gsd-frontend-design` and treat frontend design artifacts as first-class implementation inputs.
- Before planning or implementing UI work, read the available frontend sources in this order: existing product UI and design system, the relevant milestone or slice `CONTEXT.md`, the approved frontend direction packet, `pencil-workset.md`, `brownfield-ui-extraction.md`, `screen-index.md`, the relevant `.pen` files, retained screenshots or browser captures, and the existing component library and tokens. Treat that order as binding. Temporary HTML companion artifacts are comparison aids only. Freeform invention is the last resort.
- Never invent a new visual direction during GSD planning or implementation when an approved frontend direction packet or approved Pencil workset exists. Implement the chosen direction faithfully.
- If UI work is under-specified or the packet/workset lacks the `.pen` files, screenshots, or other evidence needed for high-fidelity work, stop ad-hoc UI invention and ask for a packet refresh or Pencil workset bootstrap before continuing.
- For UI work, maintain a `## Frontend References` section in the relevant milestone or slice `CONTEXT.md` with exact relative paths to the packet, `pencil-workset.md`, `brownfield-ui-extraction.md`, `screen-index.md`, the relevant `.pen` files, retained screenshots, any still-relevant temporary HTML companion artifacts, and other approved visual references.
- When browser interaction is needed for UI capture, verification, or comparison in GSD-2, use the built-in `browser-tools` extension and its `browser_*` toolset. Prefer semantic tools such as `browser_find`, `browser_snapshot_refs`, `browser_assert`, and `browser_diff` over screenshot-only browsing or external browser surfaces.
- When `.pen` files or Pencil worksets are in scope, load `pencil-design-core`.
- Use `pencil-design-angular-nebular` for Angular + Nebular or similar brownfield operator UIs, verify Angular guidance with `gsd-context7-research`, and prefer local Nebular docs or source over memory. Load `pencil-design-react-tailwind` only for actual React / Next / Tailwind / shadcn targets.
- In GSD workflows, use Pencil CLI interactive mode as the only allowed `.pen` transport. Do not use Pencil MCP or Pencil CLI agent mode. In GSD-2 or other headless contexts, do not bypass Pencil CLI merely because a change looks small or text-local. Prefer writing to a distinct output path before replacing an existing `.pen` file. Direct text editing is degraded fallback only and must be explained in the summary.
- If HTML companion artifacts influenced a retained decision, translate that decision back into packet prose, `.pen` boards, and screenshots before treating it as durable direction.
- In brownfield UI work, create a faithful runtime baseline before improvement when the current screen truth exists only in the running app and source code, and separate observed current truth, conservative normalization target, and approved change.
- Treat Impeccable as a bounded brownfield quality layer after the baseline exists. If a project-level `.impeccable.md` already exists and is still accurate, do not re-run `impeccable teach`.
- When writing slice plans and task plans for UI work, explicitly name the packet artifacts, screen keys, routes, exact `.pen` files, and Pencil skills that are in scope for that slice or task.
- When writing task summaries for UI work, record which frontend direction artifacts, `.pen` files, screenshots, and Pencil skills were used, note that Pencil CLI interactive mode was used when it matters for reproducibility, and document any necessary deviations from the packet.
- If a `.pen` file was edited without Pencil CLI, explain why the normal Pencil transport was not usable and record that the task ran in degraded mode.
- For UI verification, prefer browser-based verification against the packet, the relevant `.pen` files, and selected references on desktop and mobile instead of relying only on compilation, linting, or ungrounded visual claims.
- Never fall back to the bundled `frontend-design` skill when `gsd-frontend-design` and approved packet or workset artifacts are available.
- Never use the React/Tailwind adapter as a default for an Angular/Nebular repo.

## Spec and handoff projection policy

- Treat approved specs and GSD handoff docs as upstream source documents, then project their implementation-relevant context into native GSD workflow artifacts so later units inherit that context automatically.
- For each active milestone or slice, maintain a `## Source Documents` section in the relevant `CONTEXT.md` with exact relative paths to the approved spec, GSD handoff, frontend direction packet, `pencil-workset.md`, `brownfield-ui-extraction.md`, `screen-index.md`, the relevant `.pen` files, retained screenshots, any temporary HTML companion artifacts that still matter, and any other binding source documents.
- In milestone or slice `CONTEXT.md`, summarize only what the downstream unit needs: in-scope capabilities, affected screens, routes, components, APIs, data contracts, constraints, open questions, verification notes, and any required `.pen` file or evidence paths.
- Keep `.gsd/REQUIREMENTS.md` aligned with the approved spec and handoff. Record active requirements, validated requirements, deferred items, explicit non-goals, and scope boundaries that matter to implementation.
- Append fixed implementation choices, architecture constraints, library decisions, API contracts, and conventions from the approved spec or handoff to `.gsd/DECISIONS.md` instead of leaving them only in external docs or transient summaries.
- Put reusable cross-slice patterns from the approved docs or completed work into `.gsd/KNOWLEDGE.md`. Put environment, services, endpoints, feature flags, background jobs, and operational dependencies into `.gsd/RUNTIME.md` when relevant.
- When writing slice plans and task plans, translate the approved spec and handoff into concrete Goal, Must-Haves, Files, Key Links, Context, and Verify sections. Reference the exact source documents or screens that justify the plan.
- When writing UAT, task summaries, or slice summaries, record which spec, handoff, packet, workset, `.pen` file, screenshot, and temporary HTML companion sources were satisfied, what evidence was gathered, and any approved deviations or follow-up work.
- When a source spec, handoff, direction packet, or Pencil workset changes materially, refresh the affected GSD workflow docs before continuing planning or implementation.

## Superproject + Submodule Commit Policy

Before saying "Task complete" or "Slice complete":

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

**Hard rules:**

- <taskId> in commit messages must be the full task ID (e.g. M001/S01/T01)
- The agent's only git responsibility in a superproject is committing inside dirty submodules.
- Never run `git add` or `git commit` at the superproject root — that is system auto-commit's job.
- Never commit submodule changes that belong to a different task — stash them first.
- The step "Do not commit manually" in execute-task applies to the superproject root only. It does NOT exempt you from committing inside submodules — those are separate git repos.
