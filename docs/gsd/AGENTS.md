# Workflow preferences

- For implementation, bug fixes, refactors, and behavior changes, use `gsd-test-driven-development`.
- Do not write or change production behavior before a focused failing test or an executable repro exists.
- For failing verification, regressions, flaky behavior, or unexpected runtime behavior, use `gsd-systematic-debugging` before proposing or applying fixes.
- After the focused proof passes, run the broader project verification relevant to the change before claiming completion.
- If two fix attempts fail, stop stacking patches. Revisit root cause, task framing, or architecture before changing more code.
- Do not mark a task, slice, or milestone complete without fresh verification evidence; use `gsd-verification-before-completion`.
- If pre-commit formatting change only the code syntax, do not re-run verification before completion or code review. If the formatting change also changes behavior, run verification and code review as normal.
- When a task depends on third-party libraries, frameworks, SDKs, APIs, or version-sensitive tooling, use `gsd-context7-research` before editing code.

## Code Review Policy

- Use `code-review` for non-trivial implementation work, slice closeout, and any task touching auth, storage, external I/O, or superprojects with git submodules.
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
- For any non-trivial slice, add a final `Review and resolve slice findings` task before `complete-slice`, using a single slice-level `REVIEW.md` artifact.
- Skip paired review tasks only for trivial work such as docs-only edits, copy-only edits, renames, formatting-only changes, or other clearly mechanical non-behavioral changes.

## Frontend direction and visual-truth policy

- For any task that researches, plans, re-plans, implements, verifies, or refines user-facing UI, use `gsd-frontend-design` and treat frontend design artifacts as first-class implementation inputs.
- For native or mobile-first UI work, compose mobile design skills only when their surface is in scope: use `mobile-product-direction` for unresolved mobile jobs, flows, screen inventories, and primary actions; `mobile-interaction-and-usability` for navigation, forms, gestures, permissions, state behavior, text scaling, tap targets, semantics, and recovery; `mobile-visual-design` for mobile hierarchy, native polish, visual quality, motion, and state visuals; and `mobile-design-review` after a concrete packet, screenshot, board, prototype, or implementation exists. Do not load all mobile skills reflexively for trivial UI edits.
- Before planning or implementing UI work, read the available frontend sources in this order: approved spec, approved handoff, acceptance criteria, existing product UI and design system, the relevant milestone or slice `CONTEXT.md`, the approved frontend direction packet, the packet's declared implementation visual-truth source, approved ChatGPT Images 2 generated image files when selected, `pencil-workset.md` and `.pen` files when Pencil is selected, `brownfield-ui-extraction.md`, `screen-index.md`, retained screenshots, browser captures, simulator/device captures, project-level `PRODUCT.md` and current `DESIGN.md`, and the existing component library and tokens. Treat that order as binding. Temporary HTML companion artifacts are comparison aids only. Freeform invention is the last resort.
- When present, also read project-level `PRODUCT.md` and current `DESIGN.md` as product/register context and documented system guidance. They support the packet and brownfield baseline; they do not silently overrule them. Treat `DESIGN.json` as auxiliary tooling output only.
- Never invent a new visual direction during GSD planning or implementation when an approved frontend direction packet or approved visual-truth source exists. Implement the chosen direction faithfully.
- If UI work is under-specified or the packet lacks the approved ChatGPT Images 2 files, `.pen` files, screenshots, or other evidence required by its selected visual-truth mode, stop ad-hoc UI invention and ask for a packet refresh before continuing.
- For UI work, maintain a `## Frontend References` section in the relevant milestone or slice `CONTEXT.md` with exact relative paths to the packet, the selected visual-truth source, approved ChatGPT Images 2 generated image files when selected, `pencil-workset.md` and relevant `.pen` files when Pencil is selected, `brownfield-ui-extraction.md`, `screen-index.md`, retained screenshots, any still-relevant temporary HTML companion artifacts, any `PRODUCT.md` or `DESIGN.md` files that materially guided the work, and other approved visual references.
- For UI work that writes or changes visible text, use `writing-ux-copy` before implementation unless an approved copy deck already exists. Carry exact copy-deck paths, terminology rules, i18n variables, date/number/plural formatting, accessibility names, and missing copy states into `CONTEXT.md`, task plans, UAT, and summaries. ChatGPT Images 2 prompt visible text must be production-quality before image generation; do not let generated reference images bake in rough, technical, unaccented, or unapproved microcopy.
- When browser interaction is needed for UI capture, verification, or comparison in GSD-2, use the built-in browser surface when available, preferably `browser-tools` and its `browser_*` toolset. Prefer semantic tools such as `browser_find`, `browser_snapshot_refs`, `browser_assert`, and `browser_diff` over screenshot-only browsing. If that surface is unavailable, use the approved local browser tool for the environment and record the fallback.
- Treat runtime screenshots, traces, console logs, network dumps, Flutter logs, simulator/device captures, and golden outputs as verification inputs, not default commit artifacts. Record the durable result in UAT, summary, checklist, or review files. Save raw runtime evidence only when needed for review or replay, and place it under `/tmp`, another temporary directory, an ignored local path, or an external redaction-safe artifact location unless the task explicitly says to commit those raw files.
- When the packet selects ChatGPT Images 2 as implementation visual truth, rely on the approved generated image files as the binding visual references and omit Pencil for that scope. Do not load `pencil-design-core`, Pencil adapters, or require `pencil-workset.md` / `.pen` files.
- When `.pen` files or Pencil worksets are in scope because Pencil is selected, load `pencil-design-core`.
- When Pencil is selected, use `pencil-design-angular-nebular` for Angular + Nebular or similar brownfield operator UIs. Before translating Pencil into Angular/Nebular work, confirm Angular and Nebular versions from the repo, verify Angular guidance with `gsd-context7-research`, then read local Nebular docs/source in this order: `/Volumes/Workspace/Development/Librairies/nebular/docs/AGENTS.md`, relevant `docs/articles/`, and matching component source under `src/framework/theme/components/`. Treat Nebular source as ground truth for selectors, inputs, outputs, module wiring, and theme variables. Load `pencil-design-react-tailwind` only for actual React / Next / Tailwind / shadcn targets when Pencil is selected. Load `pencil-design-flutter-material` for native Flutter / Material 3 / `app_ui` targets when Pencil is selected. Do not load Angular/Nebular or React/Tailwind adapters for native Flutter.
- Nebular primitives are implementation primitives, not visual authority. If a `visual-truth` image or board shows calmer controls, neutral selects, framed white panes, different section surfaces, or a different action hierarchy than Nebular defaults produce, translate that approved visual delta through theme variables, semantic wrappers, `nb-theme(...)`, `nb-install-component()`, or narrowly scoped SCSS. For `semantic-guidance` images or boards, implement the demonstrated behavior, content priority, and states without unnecessary visual redesign. Prefer theme variables and helpers before page-local literals. Avoid raw hex/rgba and `::ng-deep` unless source inspection proves no cleaner hook exists. Brownfield preservation means preserve shell, behavior, contracts, and product family; it does not mean preserve flawed local styling that the approved packet explicitly changes.
- In GSD workflows, use Pencil CLI interactive mode as the only allowed `.pen` transport when Pencil is selected. Do not use Pencil MCP or Pencil CLI agent mode. In GSD-2 or other headless contexts, do not bypass Pencil CLI merely because a change looks small or text-local when Pencil is selected. Prefer writing to a distinct output path before replacing an existing `.pen` file. Direct text editing is degraded fallback only and must be explained in the summary.
- If HTML companion artifacts influenced a retained decision, translate that decision back into packet prose, approved ChatGPT Images 2 references or `.pen` boards depending on the selected visual-truth source, and screenshots before treating it as durable direction.
- In brownfield UI work, create a faithful runtime baseline before improvement when the current screen truth exists only in the running app and source code, and separate observed current truth, conservative normalization target, and approved change.
- Treat Impeccable v3 as a bounded brownfield quality layer after the baseline exists. If `PRODUCT.md` already exists and is still accurate, do not re-run `/impeccable teach`. If `DESIGN.md` is missing or stale, prefer `/impeccable document` as the refresh path. Use `/impeccable live` only as a bounded refinement surface on supported stacks, and converge accepted changes back into packet prose, screenshots, and the selected visual-truth source.
- For non-trivial UI implementation, after implementation and runtime/reference verification but before task completion, run one fresh-context visual quality review in a `worker` subagent. Tell the reviewer to read project instructions first: nearest repo and workflow `AGENTS.md` files, relevant `.gsd/**/CONTEXT.md`, `PRODUCT.md`, `DESIGN.md`, the task file, and any slice or milestone instructions that affect the target route or screen. Tell the reviewer to load Impeccable, apply critique/audit as applicable, inspect the approved packet, visual-truth sources, reference-intent checklist, and runtime evidence, then write `.gsd/{milestoneId}/slices/{sliceId}/tasks/{taskId}-VISUAL-REVIEW.md` or slice-level `.gsd/{milestoneId}/slices/{sliceId}/VISUAL-REVIEW.md` with a verdict and review decision. For web targets, tell the reviewer to use a fresh browser context, profile, window, or tab when the environment supports it; do not reuse the implementer's browser session, route, storage, console state, or previously opened page. For Flutter targets, tell the reviewer to use fresh simulator/device, widget-test, golden, or UI-gallery evidence when supported; do not rely only on the implementer's screenshots, assertions, or summaries. The reviewer must independently open the target route/screen and recapture the required platform evidence when responsive UI scope applies. Implementer screenshots, assertions, or summaries are comparison inputs, not a substitute for reviewer runtime proof. If the target cannot be opened or recaptured because the server, app, simulator, device, route, or test harness is unavailable, the reviewer must not approve. Use `REQUEST_CHANGES` when a follow-up task can restore runnable evidence, or `ESCALATE` when the environment or task framing blocks review. The artifact must include a `Visual Review Completion Gates` section covering project instructions read, fresh runtime isolation or recorded fallback, independent runtime recapture, approved reference checklist completion, platform scope, console/network or Flutter test/log checks when relevant, and any missing gate that prevents approval. Treat findings as review evidence, not permission to redesign. If a paired review-and-resolve task exists, the implementation-end visual review is evidence collection; unresolved blocking and important findings belong to that follow-up unless they prevent basic verification from running.
- For native or mobile-first visual reviews, tell the reviewer to load `mobile-design-review` and explicitly check task clarity, native conventions, compact-screen fit, state coverage, text scaling, tap targets, semantics, gesture alternatives, safe areas, permission fallbacks, and generic AI-mobile risks.
- When writing slice plans and task plans for UI work, explicitly name the packet artifacts, screen keys, routes, selected visual-truth source, approved image files or exact `.pen` files, image/board/screenshot intent modes, and Pencil skills only when Pencil is in scope for that slice or task.
- Before implementing image-backed or Pencil-backed UI work, build a visual implementation contract from approved reference intent:
  - `visual-truth`: the image or board is binding for visual treatment and requires parity verification.
  - `semantic-guidance`: the image or board demonstrates behavior, layout intent, content priority, or workflow, but implementation may adapt visual treatment to the existing product system.
  - `reference-only`: the image or board is inspiration, an exploration, or a comparison aid and is not an acceptance target unless promoted by the packet or human.
- If reference intent is not explicit or approval is pending, propose a classification and ask for confirmation before making visual changes. If confirmation is unavailable, do not treat the image or board as visual truth; implement only behavior clearly required by the spec and record the missing reference-intent approval as a blocker or degraded-mode constraint.
- For `visual-truth` references, list the binding images, boards, or screenshots for each viewport/state, extract visible deltas for surfaces, background containers, control emphasis, primary/secondary action hierarchy, spacing rhythm, typography emphasis, section backgrounds, responsive flow, platform verification points, shared-vs-local responsibility, and any stack defaults that must be neutralized or restyled. For `semantic-guidance` references, extract the required behavior, information hierarchy, state coverage, workflow, and adaptation boundaries. Separate functional acceptance from visual acceptance.
- For native or mobile-first UI, also extract the mobile product direction and interaction contract: user jobs, primary action per screen, previous/next screen context, navigation model, permission moments, offline/degraded behavior, gesture alternatives, text scaling, tap targets, semantics, and native-vs-web risks.
- When live runtime data cannot produce every required visual state on demand, use dual runtime data modes. Live mode proves integration, auth, routing, feature flags, tenant context, and service composition for the available real state. Visual fixture mode proves hard-to-reach visual states, responsive behavior, copy, action hierarchy, and reference-intent parity with deterministic contract-shaped API responses. Use platform-appropriate fixtures: browser/e2e network fixtures or a local mock proxy for web targets; widget-test pumps, Bloc/Cubit states, fake repositories, golden fixtures, or app-supported debug fixtures for Flutter targets. In-browser XHR/fetch monkeypatches are acceptable only as ad-hoc web spikes; label them as temporary fixture evidence and convert successful lanes into a repeatable network fixture or proxy harness before relying on them across tasks or slices. Label fixture evidence as fixture evidence, never as live integration proof.
- For Angular/Nebular plans, identify root, feature, and lazy module ownership, existing shared primitives, reactive vs template-driven form choice, theme/token strategy, and any Nebular defaults that must be neutralized or restyled. Do not mix `[(ngModel)]` with `formControlName` on one control.
- When writing task summaries for UI work, record which frontend direction artifacts, approved ChatGPT Images 2 files, `.pen` files, screenshots, reference intent modes, and Pencil skills were used, note whether Pencil CLI interactive mode was used for Pencil-backed sources, and document packet-vs-image, packet-vs-pen, image/pen-vs-code mismatches, parity or intent-fit checklist results, visual waivers, and any necessary deviations from the packet.
- If a `.pen` file was edited without Pencil CLI, explain why the normal Pencil transport was not usable and record that the task ran in degraded mode.
- For image-backed or Pencil-backed UI verification, platform-appropriate runtime evidence plus the approved reference-intent checklist is required before completion. For web targets, use browser screenshots, traces, route checks, and console/network evidence. For native Flutter targets, use widget tests, golden tests, simulator/device screenshots, `flutter analyze`, `flutter test`, repo-level Melos commands, accessibility checks, and UI gallery verification where relevant. Captured screenshots, DOM checks, compilation, linting, or test output alone are not evidence. For `visual-truth` images or boards, record a parity checklist with `pass`, `mismatch`, or `waived` for surfaces and containers, control emphasis, button hierarchy, typography, spacing/alignment, section visual weight, responsive flow, and key states. For `semantic-guidance` images or boards, record an intent-fit checklist proving the behavior, information hierarchy, state coverage, and product-system adaptation were implemented. Completion with an unresolved mismatch requires a waiver naming the source image or board, approved intent, runtime mismatch, implementation constraint, accepted fallback, and follow-up.
- UAT and visual review must distinguish live runtime proof from fixture visual-state proof. Fixture mode can prove rendering of designed states; it does not prove backend state, authorization, persistence, or service wiring unless those also ran live.
- Do not commit raw runtime evidence directories unless the task or human explicitly says those files are commit artifacts.
- Never fall back to the bundled `frontend-design` skill when `gsd-frontend-design` and approved packet, image, or workset artifacts are available.
- Never use the React/Tailwind adapter as a default for an Angular/Nebular or Flutter repo.

## Spec and handoff projection policy

- Treat approved specs and GSD handoff docs as upstream source documents, then project their implementation-relevant context into native GSD workflow artifacts so later units inherit that context automatically.
- If a GSD handoff says frontend packet status is `required`, do not plan or execute frontend implementation yet. Run the referenced frontend-direction follow-on prompt first, then return with the approved frontend packet and support artifacts.
- For each active milestone or slice, maintain a `## Source Documents` section in the relevant `CONTEXT.md` with exact relative paths to the approved spec, GSD handoff, frontend direction packet, selected visual-truth source, approved ChatGPT Images 2 generated image files when selected, `pencil-workset.md` and relevant `.pen` files when Pencil is selected, `brownfield-ui-extraction.md`, `screen-index.md`, retained screenshots, any temporary HTML companion artifacts that still matter, any `PRODUCT.md` or `DESIGN.md` files that materially guided the work, and any other binding source documents.
- In milestone or slice `CONTEXT.md`, summarize only what the downstream unit needs: in-scope capabilities, affected screens, routes, components, APIs, data contracts, constraints, open questions, verification notes, selected visual-truth source, and any required image, `.pen`, or evidence paths.
- Keep `.gsd/REQUIREMENTS.md` aligned with the approved spec and handoff. Record active requirements, validated requirements, deferred items, explicit non-goals, and scope boundaries that matter to implementation.
- Append fixed implementation choices, architecture constraints, library decisions, API contracts, and conventions from the approved spec or handoff to `.gsd/DECISIONS.md` instead of leaving them only in external docs or transient summaries.
- Put reusable cross-slice patterns from the approved docs or completed work into `.gsd/KNOWLEDGE.md`. Put environment, services, endpoints, feature flags, background jobs, and operational dependencies into `.gsd/RUNTIME.md` when relevant.
- When writing slice plans and task plans, translate the approved spec and handoff into concrete Goal, Must-Haves, Files, Key Links, Context, and Verify sections. Reference the exact source documents or screens that justify the plan.
- When writing UAT, task summaries, or slice summaries, record which spec, handoff, packet, approved ChatGPT Images 2 file, workset, `.pen` file, screenshot, reference intent mode, and temporary HTML companion sources were satisfied, what evidence was gathered, any parity or intent-fit mismatches or waivers, and any approved deviations or follow-up work.
- When a source spec, handoff, direction packet, approved image set, or Pencil workset changes materially, refresh the affected GSD workflow docs before continuing planning or implementation.

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
