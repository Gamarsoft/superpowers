---
version: 1
always_use_skills:
  - gsd-test-driven-development
prefer_skills:
  - gsd-frontend-design
  - gsd-context7-research
  - gsd-systematic-debugging
  - gsd-verification-before-completion
avoid_skills:
  - frontend-design
skill_rules:
  - when: writing sentences or prose for a human to read
    use:
      - writing-clearly-and-concisely
  - when: completing non-trivial implementation work or completing a slice, especially for auth, storage, external I/O, or superprojects with git submodules
    use:
      - code-review
  - when: executing a feature, bug fix, refactor, or behavior change
    use:
      - gsd-test-driven-development
  - when: encountering a failing test, broken verification, regression, UAT failure, or unexpected runtime behavior
    use:
      - gsd-systematic-debugging
  - when: task involves external libraries, frameworks, SDKs, APIs, or version-sensitive tooling
    use:
      - gsd-context7-research
  - when: completing a task, slice, or milestone, writing summaries, or preparing UAT
    use:
      - gsd-verification-before-completion
  - when: researching, planning, re-planning, implementing, verifying, or refining frontend and UI/UX related work
    use:
      - gsd-frontend-design
    avoid:
      - frontend-design
  - when: working with .pen files, Pencil worksets, visual extraction, browser-to-design comparison, or reusable design patterns
    use:
      - pencil-design-core
  - when: the approved frontend packet selects ChatGPT Images 2 references as implementation visual truth
    use:
      - gsd-frontend-design
    avoid:
      - pencil-design-core
      - pencil-design-angular-nebular
      - pencil-design-react-tailwind
  - when: translating approved Pencil designs into Angular + Nebular implementation or preserving a brownfield Angular/Nebular operator UI
    use:
      - pencil-design-angular-nebular
  - when: the actual implementation target is React, Next.js, Tailwind, or shadcn/ui
    use:
      - pencil-design-react-tailwind
  - when: the repo or slice is not React/Tailwind based
    avoid:
      - pencil-design-react-tailwind
pre_dispatch_hooks:
  - name: frontend-evidence-policy
    before:
      - plan-milestone
      - plan-slice
      - replan-slice
      - execute-task
      - complete-slice
    action: modify
    prepend: Frontend evidence policy, if this unit touches user-visible frontend, UI, UX, copy layout, interaction design, responsive behavior, or browser state, first locate and read the approved spec, approved handoff, acceptance criteria, approved frontend direction packet, the packet's declared implementation visual-truth source, `brownfield-ui-extraction.md`, `screen-index.md`, retained screenshots, and any packet paths listed in milestone or slice CONTEXT files. When ChatGPT Images 2 is the selected visual-truth source, locate the exact approved generated image files in `chatgpt-image-2/` and do not require Pencil artifacts. When Pencil is selected, locate `pencil-workset.md` and the relevant `.pen` files. When present, also read project-level `PRODUCT.md` and current `DESIGN.md` as product/register context and documented system guidance; treat `DESIGN.json` as auxiliary tooling output only. Treat these sources as first-class inputs, preserve the existing product design system unless the packet explicitly authorizes a redesign, and use `gsd-frontend-design`. When ChatGPT Images 2 is selected, do not load `pencil-design-core` or a Pencil adapter for visual consumption. When `.pen` files are in scope because Pencil is selected, use `pencil-design-core` plus the correct stack adapter. In GSD workflows, use Pencil CLI interactive mode only for `.pen` work, never Pencil MCP. Do not invent a new visual direction when an approved packet or approved visual-truth source exists. If UI work is under-specified, or the packet lacks the approved image files, `.pen` files, retained screenshots, or other evidence required by its selected visual-truth mode, stop ad-hoc UI invention and ask the human to refresh the packet. Before implementing image-backed or Pencil-backed UI, read the approved intent for each image, board, or screenshot, then build a visual implementation contract from that approved intent. If reference intent is missing or pending, propose a classification and ask for confirmation before visual changes; if confirmation is unavailable, do not treat the reference as visual truth. Completion for image-backed or Pencil-backed UI requires runtime screenshots plus the approved reference-intent checklist; screenshots alone, DOM checks, build, or lint are insufficient. Keep milestone or slice CONTEXT files updated with exact relative paths to the packet, selected visual-truth source, approved ChatGPT Images 2 files when selected, `pencil-workset.md` and relevant `.pen` files when Pencil is selected, `brownfield-ui-extraction.md`, `screen-index.md`, retained screenshots, reference intent modes and approval status, any still-relevant temporary HTML companion artifacts, and any `PRODUCT.md` or `DESIGN.md` files that materially guided the work. Prefer the selected visual-truth source and retained screenshots over packet preview images or stale temporary comparison artifacts during planning, implementation, verification, and summaries.
  - name: spec-and-handoff-projection
    before:
      - plan-milestone
      - plan-slice
      - replan-slice
      - execute-task
      - complete-slice
    action: modify
    prepend: Spec and handoff projection policy, when approved design specs, implementation specs, or GSD handoff docs exist, treat them as upstream source documents and project the relevant subset into native GSD artifacts before relying on memory alone. If a handoff says frontend packet status is `required`, do not plan or execute frontend implementation yet; run the referenced frontend-direction follow-on prompt first, then return with the approved frontend packet and support artifacts. Keep milestone or slice CONTEXT files updated with exact source paths, in-scope sections, screens, endpoints, constraints, verification notes, selected visual-truth source, approved image paths when ChatGPT Images 2 is selected, required `.pen` files when Pencil is selected, whether Pencil CLI interactive mode was used for Pencil-backed sources, and the Pencil skills that should be loaded only when Pencil is selected. Mirror binding requirements and explicit out-of-scope boundaries into `.gsd/REQUIREMENTS.md` when they are missing or stale. Append fixed choices to `.gsd/DECISIONS.md`, put reusable cross-slice patterns into `.gsd/KNOWLEDGE.md`, and record runtime dependencies in `.gsd/RUNTIME.md` when relevant.
  - name: review-task-planning-policy
    before:
      - plan-slice
      - replan-slice
    action: modify
    prepend: Review-task planning policy. When planning or re-planning this slice, decompose non-trivial work into explicit implementation and review-and-resolve units. Planning rules, 1. For each non-trivial implementation task, add a follow-up task named `Review and resolve Txx findings`. 2. The implementation task ends with one fresh-context review pass in a `worker` subagent before the task completes. 3. That first review pass writes one authoritative review artifact for the implementation task being reviewed, - `.gsd/{milestoneId}/slices/{sliceId}/tasks/{taskId}-REVIEW.md` 4. The implementation task still completes normally whether the first-pass reviewer sets `verdict, APPROVE`, `REQUEST_CHANGES`, or `ESCALATE`. 5. The follow-up review-and-resolve task is a no-op if `Txx-REVIEW.md` says `verdict, APPROVE`. 6. If `Txx-REVIEW.md` says `verdict, REQUEST_CHANGES`, the follow-up task fixes or explicitly disproves every Critical and Important finding, reruns verification, then launches another fresh-context review pass. 7. Only the fresh-context reviewer creates or overwrites `REVIEW.md`. 8. Use at most 4 fresh review cycles inside the follow-up task. If `REVIEW.md` still does not say `APPROVE` after 4 cycles, stop and escalate through `replan-slice` or `blocker_discovered, true`. 9. Skip paired review tasks only for trivial work such as docs-only edits, copy-only edits, renames, formatting-only changes, or clearly mechanical non-behavioral changes. 10. For any non-trivial slice, add a final `Review and resolve slice findings` task before `complete-slice`, using, - `.gsd/{milestoneId}/slices/{sliceId}/REVIEW.md` Task-shape guidance, - Implementation task, build and verify behavior, then run one fresh-context review pass before task completion - Review-and-resolve task, if review says APPROVE, no-op; otherwise fix or disprove findings and rerun fresh-context review until APPROVE or escalation
  - name: implementation-end-review-policy
    before:
      - execute-task
    action: modify
    prepend: Implementation-end review policy. If this is a non-trivial implementation task that has a planned follow-up `Review and resolve ... findings` task, then the final review in this task is evidence collection only, not remediation. Required process, 1. Finish implementation and verification first. 2. Load `code-review`. 3. Spawn a fresh `worker` subagent reviewer. 4. Tell the reviewer to read `~/.gsd/agent/skills/code-review/SKILL.md` first and follow it in `implementation-end-review` mode. 5. The reviewer inspects the current working tree against `HEAD`. 6. If `.gitmodules` exists, the reviewer must treat the repo as a superproject and inspect actual submodule diffs with `git diff --submodule=diff`, not only pointer bumps. 7. The reviewer writes exactly one artifact for the current task, - `.gsd/{milestoneId}/slices/{sliceId}/tasks/{taskId}-REVIEW.md` 8. The reviewer must set, - `Verdict, APPROVE | REQUEST_CHANGES | ESCALATE` - `Review Decision, no_action | remediate_and_rereview | escalate_replan` 9. Do not fix or disprove findings from this final review pass inside the implementation task. 10. Do not start a review loop inside the implementation task. 11. The implementation task completes normally after the review artifact is written. 12. Any remediation belongs to the paired `Review and resolve ... findings` task. If this task is itself a `Review and resolve ... findings` task, do not run this first-pass policy. Follow the review-resolve loop instead.
  - name: review-resolve-task-policy
    before:
      - execute-task
    action: modify
    prepend: Review-and-resolve task policy. If this task is a `Review and resolve Txx findings` task, then this task owns the review loop for the referenced implementation task. Required process, 1. Load `code-review`. 2. Identify the target task being reviewed. 3. Read `.gsd/{milestoneId}/slices/{sliceId}/tasks/{targetTaskId}-REVIEW.md`. 4. If it says `verdict, APPROVE`, treat this as a no-op task and complete it with a brief summary. 5. If it says `verdict, REQUEST_CHANGES`, fix or explicitly disprove every Critical and Important finding with fresh verification evidence. 6. Spawn a fresh `worker` subagent reviewer. 7. Tell the reviewer to read `~/.gsd/agent/skills/code-review/SKILL.md` first and follow it in `review-resolve-loop` mode. 8. The reviewer inspects the updated working tree against `HEAD`. 9. If `.gitmodules` exists, the reviewer must treat the repo as a superproject and inspect actual submodule diffs with `git diff --submodule=diff`, not only pointer bumps. 10. The reviewer overwrites the authoritative review artifact for the target task, - `.gsd/{milestoneId}/slices/{sliceId}/tasks/{targetTaskId}-REVIEW.md` 11. Use at most 4 fresh review cycles total in this task. 12. If the review artifact still does not say `APPROVE` after 4 cycles, stop and escalate through `replan-slice` or `blocker_discovered, true`. If this task is `Review and resolve slice findings`, use the same loop but target the slice-level artifact, - `.gsd/{milestoneId}/slices/{sliceId}/REVIEW.md`
custom_instructions:
  - .gsd/STATE.md is always untracked and should not be committed.
  - Always announce skill usage
  - For frontend or UI work, read the approved spec, approved handoff, acceptance criteria, existing product UI and design system, the approved frontend direction packet, the packet's declared implementation visual-truth source, `brownfield-ui-extraction.md`, `screen-index.md`, retained screenshots or browser captures, project-level `PRODUCT.md` and current `DESIGN.md`, the existing component library and tokens, and any paths listed in milestone or slice CONTEXT files before planning or implementation. If ChatGPT Images 2 is selected, read the approved generated image files in `chatgpt-image-2/` and do not require Pencil artifacts. If Pencil is selected, read `pencil-workset.md` and the relevant `.pen` files. Treat `DESIGN.json` as auxiliary tooling output, not the primary contract. Typical locations are `docs/superpowers/specs/*--frontend-direction.md`, `docs/superpowers/specs/*--frontend/chatgpt-image-2/`, `docs/superpowers/specs/*--frontend/pencil-workset.md`, `docs/superpowers/specs/*--frontend/brownfield-ui-extraction.md`, `docs/superpowers/specs/*--frontend/screen-index.md`, `design/pencil/**/*.pen`, `docs/superpowers/specs/*--frontend/screenshots/`, and `docs/superpowers/specs/*--frontend/selected-direction/`.
  - For frontend or UI work, use this precedence, approved spec, approved handoff, acceptance criteria, existing product UI and design system, approved frontend direction packet, packet-declared visual-truth source, approved ChatGPT Images 2 files when selected, `pencil-workset.md` and relevant `.pen` files when Pencil is selected, `brownfield-ui-extraction.md`, `screen-index.md`, retained screenshots or browser captures, `PRODUCT.md` and current `DESIGN.md` as supporting context, existing component library and tokens, temporary HTML companion artifacts only when they still clarify an unresolved comparison, then `gsd-frontend-design` heuristics. Freeform invention is the last resort.
  - In GSD-2, use the built-in browser surface for UI capture, comparison, and verification when available, preferably `browser-tools` and semantic `browser_*` tools such as `browser_find`, `browser_snapshot_refs`, `browser_assert`, and `browser_diff`. If that surface is unavailable, use the approved local browser tool for the environment and record the fallback. For image-backed or Pencil-backed UI, screenshot capture alone is not evidence; record each approved image or board's intent and whether runtime behavior passed, mismatched, or was waived against that intent.
  - When ChatGPT Images 2 is the selected visual-truth source, use the approved generated image files as binding visual references and do not load `pencil-design-core` or a Pencil adapter for visual consumption. When `.pen` files or Pencil worksets are in scope because Pencil is selected, use `pencil-design-core` and the correct adapter, `pencil-design-angular-nebular` for Angular + Nebular or similar brownfield operator UIs, `pencil-design-react-tailwind` only for actual React / Next / Tailwind / shadcn targets. For Angular + Nebular work with Pencil selected, confirm Angular and Nebular versions from the repo, verify Angular guidance with `gsd-context7-research`, then read local Nebular docs/source in this order, `/Volumes/Workspace/Development/Librairies/nebular/docs/AGENTS.md`, relevant `docs/articles/`, and matching component source under `src/framework/theme/components/`. Treat Nebular source as ground truth for selectors, inputs, outputs, module wiring, and theme variables.
  - In GSD workflows, use Pencil CLI interactive mode as the only allowed Pencil transport for `.pen` work when Pencil is selected. Do not use Pencil MCP or Pencil CLI agent mode. In headless contexts, do not bypass Pencil CLI just because a change looks small when Pencil is selected. Prefer writing to a distinct output path before replacing an existing `.pen` file. Direct text editing is degraded fallback only and must be explained in the summary.
  - Never invent a new visual direction when an approved frontend packet or approved visual-truth source exists. If UI work is under-specified, or the packet lacks the approved image files, `.pen` files, retained screenshots, or other evidence required by its selected visual-truth mode, stop ad-hoc UI invention and ask the human to refresh the packet. In brownfield UI work, create a faithful runtime baseline before improvement when the current screen truth exists only in the running app and source code, and separate observed current truth, conservative normalization target, and approved change. Brownfield preservation means preserve shell, behavior, contracts, and product family; it does not mean preserve flawed local styling that the approved packet explicitly changes. Treat Impeccable v3 as a bounded quality layer after that baseline exists; if `PRODUCT.md` is already valid, do not re-run `/impeccable teach`. If `DESIGN.md` is missing or stale, prefer `/impeccable document` as the refresh path. Use `/impeccable live` only as a bounded refinement surface on supported stacks. If a temporary HTML companion artifact or live refinement influenced a retained direction, translate it back into packet prose, screenshots, and the selected visual-truth source before treating it as durable guidance.
  - Approved images and Pencil boards must declare approved intent before implementation. Use `visual-truth` when the image or board is binding for visual treatment, `semantic-guidance` when it demonstrates behavior, layout intent, content priority, or workflow while allowing product-system adaptation, and `reference-only` when it is inspiration or comparison material. Only approved `visual-truth` references bind visual hierarchy, surface treatment, control emphasis, spacing rhythm, section visual weight, and primary/secondary action priority. If intent is missing or pending, ask for confirmation before visual changes. For Angular + Nebular work, Nebular primitives are implementation primitives, not visual authority; if Nebular defaults make a control or surface read differently than an approved `visual-truth` image or board, restyle through theme variables, semantic wrappers, `nb-theme(...)`, `nb-install-component()`, or narrowly scoped SCSS and record the local visual delta. Prefer theme variables and helpers before page-local literals. Avoid raw hex/rgba and Angular deep selectors unless source inspection proves no cleaner hook exists.
  - When approved specs or handoff docs exist, do not leave them as disconnected external references. Project the implementation-relevant subset into native GSD artifacts so later units inherit the context automatically.
  - If a GSD handoff marks frontend packet status as `required`, stop before frontend implementation and run the referenced frontend-direction follow-on prompt in a fresh or compacted session.
  - For each active milestone or slice, maintain a `## Source Documents` section in the relevant CONTEXT.md with exact relative paths to the approved spec, frontend direction packet, selected visual-truth source, approved ChatGPT Images 2 generated image files when selected, `pencil-workset.md` and relevant `.pen` files when Pencil is selected, `brownfield-ui-extraction.md`, `screen-index.md`, retained screenshots, any still-relevant temporary HTML companion artifacts, any `PRODUCT.md` or `DESIGN.md` files that materially guided the work, GSD handoff, and other binding source documents.
  - In milestone or slice CONTEXT files, summarize only what the current work needs, in-scope capabilities, affected screens, routes, components, APIs, data contracts, constraints, open questions, verification notes, selected visual-truth source, and any required approved image, `.pen`, or evidence paths. List Pencil skills only when Pencil is selected.
  - Keep `.gsd/REQUIREMENTS.md` aligned with the approved spec and handoff by recording active requirements, validated requirements, deferred items, explicit non-goals, and scope boundaries that matter to implementation.
  - Append fixed implementation choices, architecture constraints, library decisions, API contracts, and conventions from the approved spec or handoff to `.gsd/DECISIONS.md` instead of burying them only in summaries or external docs.
  - Put reusable cross-slice implementation patterns from the spec, handoff, packet, workset, or completed work into `.gsd/KNOWLEDGE.md`. Put environment, services, endpoints, feature flags, background jobs, and operational dependencies into `.gsd/RUNTIME.md` when relevant.
  - When writing slice plans and task plans, translate the spec and handoff into concrete Goal, Must-Haves, Files, Key Links, Context, and Verify sections. Reference the exact source documents or screens that justify the plan.
  - When writing UAT, task summaries, or slice summaries, record which spec, handoff, packet, approved ChatGPT Images 2 file, workset, `.pen` file, screenshot, reference intent mode, temporary HTML companion artifact, whether Pencil CLI interactive mode was used for Pencil-backed sources, which Pencil skills were used, what evidence was gathered, parity or intent-fit pass/mismatch/waiver results, and any approved deviations or follow-up work.
  - If a `.pen` file was edited without Pencil CLI, explain why the normal Pencil transport was not usable and record that the task ran in degraded mode.
  - In a superproject with `.gitmodules`, code review must inspect actual submodule diffs, not only pointer bumps.
  - For non-trivial work, the preferred review workflow is implementation task plus paired `Review and resolve ... findings` follow-up task.
  - The implementation task ends with one fresh-context review pass and still completes normally.
  - The paired follow-up task owns the fix or disprove plus re-review loop until `REVIEW.md` says `APPROVE` or escalation occurs.
  - Only the fresh-context reviewer creates or overwrites `REVIEW.md`.
  - Always announce when you are applying a code-review checklist and state the verdict in the task summary.
  - SUPERPROJECT SUBMODULE RULE — applies before every "Task complete" and "Slice complete"; Run [ -f .gitmodules ] && git submodule foreach --quiet 'echo "=== $name ===" && git status --short' If any submodule shows dirty output, load the submodule-commit skill and commit those submodule working trees NOW, before proceeding. Do NOT run git add or git commit at the superproject root — the system auto-commits the pointer update. The "Do not commit manually" instruction does not apply to submodules.

models:
  research: openai-codex/gpt-5.5
  planning: openai-codex/gpt-5.5
  execution: openai-codex/gpt-5.5
  completion: openai-codex/gpt-5.5
skill_discovery: suggest
auto_supervisor:
  soft_timeout_minutes: 120
  idle_timeout_minutes: 60
  hard_timeout_minutes: 999
git:
  auto_push: false
  push_branches: false
  isolation: branch
---
