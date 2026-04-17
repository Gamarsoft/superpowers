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
- Before planning or implementing UI work, read these in order when they exist: the existing product UI and design system in the repo, the relevant milestone or slice `CONTEXT.md`, the approved frontend direction packet, `pencil-workset.md`, `brownfield-ui-extraction.md`, the screen index, the relevant `.pen` files under `design/pencil/` or packet-linked paths, retained screenshots or browser captures, and the existing component library and tokens.
- Treat this precedence order as binding for UI work: existing product UI and design system as the baseline system, the approved frontend direction packet for in-scope intentional change, `pencil-workset.md` and `brownfield-ui-extraction.md`, the relevant `.pen` files, retained screenshots or browser captures, existing component library and tokens, temporary HTML companion artifacts only when they still clarify an unresolved comparison, `gsd-frontend-design` heuristics. Freeform invention is the last resort only.
- Never invent a new visual direction during GSD planning or implementation when an approved frontend direction packet or approved Pencil workset exists. Implement the chosen direction faithfully.
- If UI work is materially under-specified and no frontend direction packet or equivalent visual source of truth exists, stop ad-hoc UI invention and ask the human to create or refresh the packet or bootstrap the Pencil workset before continuing implementation.
- If a packet or workset lacks the relevant `.pen` files, retained screenshots, or other evidence needed for high-fidelity implementation or polish, treat it as incomplete and request a refresh before continuing.
- For UI work, maintain a `## Frontend References` section inside the relevant milestone or slice `CONTEXT.md` whenever possible. Record exact relative paths to the frontend direction packet, `pencil-workset.md`, `brownfield-ui-extraction.md`, `screen-index.md`, the relevant `.pen` files, retained screenshots, any temporary HTML companion artifacts that still matter, and any other approved visual references there.
- When `.pen` files or Pencil worksets are in scope, load `pencil-design-core`.
- When the target implementation stack is Angular + Nebular or a similar brownfield operator UI, also load `pencil-design-angular-nebular`.
- For Angular + Nebular work, verify Angular guidance with `gsd-context7-research` before editing, and use the local Nebular docs/source retrieval order when available instead of guessing component APIs from memory.
- Only load `pencil-design-react-tailwind` when the actual implementation target is React / Next / Tailwind / shadcn.
- In GSD workflows, use Pencil CLI interactive mode as the only allowed Pencil transport for `.pen` work. Do not use Pencil MCP.
- In GSD-2 or other headless contexts, do not bypass Pencil CLI merely because a `.pen` change looks small or text-local. If Pencil CLI is available, use it first for `.pen` inspection or modification.
- For Pencil CLI interactive edits on an existing `.pen` file, prefer writing to a distinct output path and verifying it before replacing the original. Do not rely on in-place save-back unless that path has already been proven safe in the current environment.
- Direct text editing of a `.pen` file is degraded fallback only. Use it only when Pencil CLI is unavailable, broken, or demonstrably unable to perform the required change, and state that degraded fallback explicitly in the summary.
- Do not use Pencil CLI agent mode in this workflow. Use Pencil CLI interactive mode when CLI is the chosen transport.
- If HTML companion artifacts influenced a retained decision, translate that decision back into packet prose, `.pen` boards, and screenshots before treating it as durable direction.
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
