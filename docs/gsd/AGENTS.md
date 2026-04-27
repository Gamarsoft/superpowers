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
- Before planning or implementing UI work, read the available frontend sources in this order: approved spec, approved handoff, acceptance criteria, existing product UI and design system, the relevant milestone or slice `CONTEXT.md`, the approved frontend direction packet, `pencil-workset.md`, `brownfield-ui-extraction.md`, `screen-index.md`, the relevant `.pen` files, retained screenshots or browser captures, project-level `PRODUCT.md` and current `DESIGN.md`, and the existing component library and tokens. Treat that order as binding. Temporary HTML companion artifacts are comparison aids only. Freeform invention is the last resort.
- When present, also read project-level `PRODUCT.md` and current `DESIGN.md` as product/register context and documented system guidance. They support the packet and brownfield baseline; they do not silently overrule them. Treat `DESIGN.json` as auxiliary tooling output only.
- Never invent a new visual direction during GSD planning or implementation when an approved frontend direction packet or approved Pencil workset exists. Implement the chosen direction faithfully.
- If UI work is under-specified or the packet/workset lacks the `.pen` files, screenshots, or other evidence needed for high-fidelity work, stop ad-hoc UI invention and ask for a packet refresh or Pencil workset bootstrap before continuing.
- For UI work, maintain a `## Frontend References` section in the relevant milestone or slice `CONTEXT.md` with exact relative paths to the packet, `pencil-workset.md`, `brownfield-ui-extraction.md`, `screen-index.md`, the relevant `.pen` files, retained screenshots, any still-relevant temporary HTML companion artifacts, any `PRODUCT.md` or `DESIGN.md` files that materially guided the work, and other approved visual references.
- When browser interaction is needed for UI capture, verification, or comparison in GSD-2, use the built-in browser surface when available, preferably `browser-tools` and its `browser_*` toolset. Prefer semantic tools such as `browser_find`, `browser_snapshot_refs`, `browser_assert`, and `browser_diff` over screenshot-only browsing. If that surface is unavailable, use the approved local browser tool for the environment and record the fallback.
- When `.pen` files or Pencil worksets are in scope, load `pencil-design-core`.
- Use `pencil-design-angular-nebular` for Angular + Nebular or similar brownfield operator UIs. Before translating Pencil into Angular/Nebular work, confirm Angular and Nebular versions from the repo, verify Angular guidance with `gsd-context7-research`, then read local Nebular docs/source in this order: `/Volumes/Workspace/Development/Librairies/nebular/docs/AGENTS.md`, relevant `docs/articles/`, and matching component source under `src/framework/theme/components/`. Treat Nebular source as ground truth for selectors, inputs, outputs, module wiring, and theme variables. Load `pencil-design-react-tailwind` only for actual React / Next / Tailwind / shadcn targets.
- Nebular primitives are implementation primitives, not visual authority. If a `visual-truth` board shows calmer controls, neutral selects, framed white panes, different section surfaces, or a different action hierarchy than Nebular defaults produce, translate that approved visual delta through theme variables, semantic wrappers, `nb-theme(...)`, `nb-install-component()`, or narrowly scoped SCSS. For `semantic-guidance` boards, implement the demonstrated behavior, content priority, and states without unnecessary visual redesign. Prefer theme variables and helpers before page-local literals. Avoid raw hex/rgba and `::ng-deep` unless source inspection proves no cleaner hook exists. Brownfield preservation means preserve shell, behavior, contracts, and product family; it does not mean preserve flawed local styling that the approved packet explicitly changes.
- In GSD workflows, use Pencil CLI interactive mode as the only allowed `.pen` transport. Do not use Pencil MCP or Pencil CLI agent mode. In GSD-2 or other headless contexts, do not bypass Pencil CLI merely because a change looks small or text-local. Prefer writing to a distinct output path before replacing an existing `.pen` file. Direct text editing is degraded fallback only and must be explained in the summary.
- If HTML companion artifacts influenced a retained decision, translate that decision back into packet prose, `.pen` boards, and screenshots before treating it as durable direction.
- In brownfield UI work, create a faithful runtime baseline before improvement when the current screen truth exists only in the running app and source code, and separate observed current truth, conservative normalization target, and approved change.
- Treat Impeccable v3 as a bounded brownfield quality layer after the baseline exists. If `PRODUCT.md` already exists and is still accurate, do not re-run `/impeccable teach`. If `DESIGN.md` is missing or stale, prefer `/impeccable document` as the refresh path. Use `/impeccable live` only as a bounded refinement surface on supported stacks, and converge accepted changes back into packet prose, screenshots, and `.pen` files.
- When writing slice plans and task plans for UI work, explicitly name the packet artifacts, screen keys, routes, exact `.pen` files, board or screenshot intent modes, and Pencil skills that are in scope for that slice or task.
- Before implementing Pencil-backed UI work, build a visual implementation contract from approved board intent:
  - `visual-truth`: the board is binding for visual treatment and requires board-parity verification.
  - `semantic-guidance`: the board demonstrates behavior, layout intent, content priority, or workflow, but implementation may adapt visual treatment to the existing product system.
  - `reference-only`: the board is inspiration, an exploration, or a comparison aid and is not an acceptance target unless promoted by the packet or human.
- If board intent is not explicit or approval is pending, propose a classification and ask for confirmation before making visual changes. If confirmation is unavailable, do not treat the board as visual truth; implement only behavior clearly required by the spec and record the missing board-intent approval as a blocker or degraded-mode constraint.
- For `visual-truth` boards, list the binding boards or screenshots for each viewport/state, extract visible deltas for surfaces, background containers, control emphasis, primary/secondary action hierarchy, spacing rhythm, typography emphasis, section backgrounds, responsive flow, browser verification points, shared-vs-local responsibility, and any stack defaults that must be neutralized or restyled. For `semantic-guidance` boards, extract the required behavior, information hierarchy, state coverage, workflow, and adaptation boundaries. Separate functional acceptance from visual acceptance.
- For Angular/Nebular plans, identify root, feature, and lazy module ownership, existing shared primitives, reactive vs template-driven form choice, theme/token strategy, and any Nebular defaults that must be neutralized or restyled. Do not mix `[(ngModel)]` with `formControlName` on one control.
- When writing task summaries for UI work, record which frontend direction artifacts, `.pen` files, screenshots, board intent modes, and Pencil skills were used, note whether Pencil CLI interactive mode was used for Pencil-backed sources, and document packet-vs-pen mismatches, pen-vs-code mismatches, board-parity or intent-fit checklist results, visual waivers, and any necessary deviations from the packet.
- If a `.pen` file was edited without Pencil CLI, explain why the normal Pencil transport was not usable and record that the task ran in degraded mode.
- For Pencil-backed UI verification, runtime browser evidence plus the approved board-intent checklist is required before completion. Captured screenshots, DOM checks, compilation, linting, or test output alone are not evidence. For `visual-truth` boards, record a board-parity checklist with `pass`, `mismatch`, or `waived` for surfaces and containers, control emphasis, button hierarchy, typography, spacing/alignment, section visual weight, responsive flow, and key states. For `semantic-guidance` boards, record an intent-fit checklist proving the behavior, information hierarchy, state coverage, and product-system adaptation were implemented. Completion with an unresolved mismatch requires a waiver naming the source board, approved intent, runtime mismatch, implementation constraint, accepted fallback, and follow-up.
- Never fall back to the bundled `frontend-design` skill when `gsd-frontend-design` and approved packet or workset artifacts are available.
- Never use the React/Tailwind adapter as a default for an Angular/Nebular repo.

## Spec and handoff projection policy

- Treat approved specs and GSD handoff docs as upstream source documents, then project their implementation-relevant context into native GSD workflow artifacts so later units inherit that context automatically.
- For each active milestone or slice, maintain a `## Source Documents` section in the relevant `CONTEXT.md` with exact relative paths to the approved spec, GSD handoff, frontend direction packet, `pencil-workset.md`, `brownfield-ui-extraction.md`, `screen-index.md`, the relevant `.pen` files, retained screenshots, any temporary HTML companion artifacts that still matter, any `PRODUCT.md` or `DESIGN.md` files that materially guided the work, and any other binding source documents.
- In milestone or slice `CONTEXT.md`, summarize only what the downstream unit needs: in-scope capabilities, affected screens, routes, components, APIs, data contracts, constraints, open questions, verification notes, and any required `.pen` file or evidence paths.
- Keep `.gsd/REQUIREMENTS.md` aligned with the approved spec and handoff. Record active requirements, validated requirements, deferred items, explicit non-goals, and scope boundaries that matter to implementation.
- Append fixed implementation choices, architecture constraints, library decisions, API contracts, and conventions from the approved spec or handoff to `.gsd/DECISIONS.md` instead of leaving them only in external docs or transient summaries.
- Put reusable cross-slice patterns from the approved docs or completed work into `.gsd/KNOWLEDGE.md`. Put environment, services, endpoints, feature flags, background jobs, and operational dependencies into `.gsd/RUNTIME.md` when relevant.
- When writing slice plans and task plans, translate the approved spec and handoff into concrete Goal, Must-Haves, Files, Key Links, Context, and Verify sections. Reference the exact source documents or screens that justify the plan.
- When writing UAT, task summaries, or slice summaries, record which spec, handoff, packet, workset, `.pen` file, screenshot, board intent mode, and temporary HTML companion sources were satisfied, what evidence was gathered, any board-parity or intent-fit mismatches or waivers, and any approved deviations or follow-up work.
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
