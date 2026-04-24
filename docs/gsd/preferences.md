---
version: 1
always_use_skills:
  - gsd-test-driven-development
  - gsd-frontend-design
prefer_skills:
  - gsd-context7-research
  - gsd-systematic-debugging
  - gsd-verification-before-completion
  - pencil-design-core
  - pencil-design-angular-nebular
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
    prepend: Frontend evidence policy, if this unit touches user-visible frontend, UI, UX, copy layout, interaction design, responsive behavior, or browser state, first locate and read the approved frontend direction packet, `pencil-workset.md`, `brownfield-ui-extraction.md`, `screen-index.md`, the relevant `.pen` files, retained screenshots, and any packet paths listed in milestone or slice CONTEXT files. When present, also read project-level `PRODUCT.md` and current `DESIGN.md` as product/register context and documented system guidance; treat `DESIGN.json` as auxiliary tooling output only. Treat these sources as first-class inputs, preserve the existing product design system unless the packet explicitly authorizes a redesign, and use `gsd-frontend-design`. When `.pen` files are in scope, also use `pencil-design-core` plus the correct stack adapter. In GSD workflows, use Pencil CLI interactive mode only for `.pen` work, never Pencil MCP. Do not invent a new visual direction when an approved packet exists. If UI work is under-specified, or the workset lacks the relevant `.pen` files or screenshots, stop ad-hoc UI invention and ask the human to create or refresh the packet or bootstrap the Pencil workset before continuing. Keep milestone or slice CONTEXT files updated with exact relative paths to the packet, `pencil-workset.md`, `brownfield-ui-extraction.md`, `screen-index.md`, the relevant `.pen` files, retained screenshots, any still-relevant temporary HTML companion artifacts, and any `PRODUCT.md` or `DESIGN.md` files that materially guided the work. Prefer the durable `.pen` files and retained screenshots over packet preview images or stale temporary comparison artifacts during planning, implementation, verification, and summaries.
  - name: spec-and-handoff-projection
    before:
      - plan-milestone
      - plan-slice
      - replan-slice
      - execute-task
      - complete-slice
    action: modify
    prepend: Spec and handoff projection policy, when approved design specs, implementation specs, or GSD handoff docs exist, treat them as upstream source documents and project the relevant subset into native GSD artifacts before relying on memory alone. Keep milestone or slice CONTEXT files updated with exact source paths, in-scope sections, screens, endpoints, constraints, verification notes, required `.pen` files, whether Pencil CLI interactive mode was used when it matters for reproducibility, and the Pencil skills that should be loaded. Mirror binding requirements and explicit out-of-scope boundaries into `.gsd/REQUIREMENTS.md` when they are missing or stale. Append fixed choices to `.gsd/DECISIONS.md`, put reusable cross-slice patterns into `.gsd/KNOWLEDGE.md`, and record runtime dependencies in `.gsd/RUNTIME.md` when relevant.
  - name: review-task-planning-policy
    before:
      - plan-slice
      - replan-slice
    action: modify
    prepend: |
      Review-task planning policy. When planning or re-planning this slice, decompose non-trivial work into explicit implementation and review-and-resolve units.

      Planning rules:
      1. For each non-trivial implementation task, add a follow-up task named `Review and resolve Txx findings`.
      2. The implementation task ends with one fresh-context review pass in a `worker` subagent before the task completes.
      3. That first review pass writes one authoritative review artifact for the implementation task being reviewed:
         - `.gsd/{milestoneId}/slices/{sliceId}/tasks/{taskId}-REVIEW.md`
      4. The implementation task still completes normally whether the first-pass reviewer sets `verdict: APPROVE`, `REQUEST_CHANGES`, or `ESCALATE`.
      5. The follow-up review-and-resolve task is a no-op if `Txx-REVIEW.md` says `verdict: APPROVE`.
      6. If `Txx-REVIEW.md` says `verdict: REQUEST_CHANGES`, the follow-up task fixes or explicitly disproves every Critical and Important finding, reruns verification, then launches another fresh-context review pass.
      7. Only the fresh-context reviewer creates or overwrites `REVIEW.md`.
      8. Use at most 4 fresh review cycles inside the follow-up task. If `REVIEW.md` still does not say `APPROVE` after 4 cycles, stop and escalate through `replan-slice` or `blocker_discovered: true`.
      9. Skip paired review tasks only for trivial work such as docs-only edits, copy-only edits, renames, formatting-only changes, or clearly mechanical non-behavioral changes.
      10. For any non-trivial slice, add a final `Review and resolve slice findings` task before `complete-slice`, using:
          - `.gsd/{milestoneId}/slices/{sliceId}/REVIEW.md`

      Task-shape guidance:
      - Implementation task: build and verify behavior, then run one fresh-context review pass before task completion
      - Review-and-resolve task: if review says APPROVE, no-op; otherwise fix or disprove findings and rerun fresh-context review until APPROVE or escalation
  - name: implementation-end-review-policy
    before:
      - execute-task
    action: modify
    prepend: |
      Implementation-end review policy.

      If this is a non-trivial implementation task that has a planned follow-up `Review and resolve ... findings` task, then the final review in this task is evidence collection only, not remediation.

      Required process:
      1. Finish implementation and verification first.
      2. Load `code-review`.
      3. Spawn a fresh `worker` subagent reviewer.
      4. Tell the reviewer to read `~/.gsd/agent/skills/code-review/SKILL.md` first and follow it in `implementation-end-review` mode.
      5. The reviewer inspects the current working tree against `HEAD`.
      6. If `.gitmodules` exists, the reviewer must treat the repo as a superproject and inspect actual submodule diffs with `git diff --submodule=diff`, not only pointer bumps.
      7. The reviewer writes exactly one artifact for the current task:
         - `.gsd/{milestoneId}/slices/{sliceId}/tasks/{taskId}-REVIEW.md`
      8. The reviewer must set:
         - `Verdict: APPROVE | REQUEST_CHANGES | ESCALATE`
         - `Review Decision: no_action | remediate_and_rereview | escalate_replan`
      9. Do not fix or disprove findings from this final review pass inside the implementation task.
      10. Do not start a review loop inside the implementation task.
      11. The implementation task completes normally after the review artifact is written.
      12. Any remediation belongs to the paired `Review and resolve ... findings` task.

      If this task is itself a `Review and resolve ... findings` task, do not run this first-pass policy. Follow the review-resolve loop instead.
  - name: review-resolve-task-policy
    before:
      - execute-task
    action: modify
    prepend: |
      Review-and-resolve task policy.

      If this task is a `Review and resolve Txx findings` task, then this task owns the review loop for the referenced implementation task.

      Required process:
      1. Load `code-review`.
      2. Identify the target task being reviewed.
      3. Read `.gsd/{milestoneId}/slices/{sliceId}/tasks/{targetTaskId}-REVIEW.md`.
      4. If it says `verdict: APPROVE`, treat this as a no-op task and complete it with a brief summary.
      5. If it says `verdict: REQUEST_CHANGES`, fix or explicitly disprove every Critical and Important finding with fresh verification evidence.
      6. Spawn a fresh `worker` subagent reviewer.
      7. Tell the reviewer to read `~/.gsd/agent/skills/code-review/SKILL.md` first and follow it in `review-resolve-loop` mode.
      8. The reviewer inspects the updated working tree against `HEAD`.
      9. If `.gitmodules` exists, the reviewer must treat the repo as a superproject and inspect actual submodule diffs with `git diff --submodule=diff`, not only pointer bumps.
      10. The reviewer overwrites the authoritative review artifact for the target task:
          - `.gsd/{milestoneId}/slices/{sliceId}/tasks/{targetTaskId}-REVIEW.md`
      11. Use at most 4 fresh review cycles total in this task.
      12. If the review artifact still does not say `APPROVE` after 4 cycles, stop and escalate through `replan-slice` or `blocker_discovered: true`.

      If this task is `Review and resolve slice findings`, use the same loop but target the slice-level artifact:
      - `.gsd/{milestoneId}/slices/{sliceId}/REVIEW.md`
custom_instructions:
  - .gsd/STATE.md is always untracked and should not be committed.
  - Always announce skill usage
  - For frontend or UI work, read the existing product UI and design system, the approved frontend direction packet, `pencil-workset.md`, `brownfield-ui-extraction.md`, `screen-index.md`, the relevant `.pen` files, retained screenshots or browser captures, the existing component library and tokens, and any paths listed in milestone or slice CONTEXT files before planning or implementation. When present, also read project-level `PRODUCT.md` and current `DESIGN.md`; treat `DESIGN.json` as auxiliary tooling output, not the primary contract. Typical locations are `docs/superpowers/specs/*--frontend-direction.md`, `docs/superpowers/specs/*--frontend/pencil-workset.md`, `docs/superpowers/specs/*--frontend/brownfield-ui-extraction.md`, `docs/superpowers/specs/*--frontend/screen-index.md`, `design/pencil/**/*.pen`, `docs/superpowers/specs/*--frontend/screenshots/`, and `docs/superpowers/specs/*--frontend/selected-direction/`.
  - For frontend or UI work, use this precedence, existing product UI and design system, approved frontend direction packet, `pencil-workset.md` and `brownfield-ui-extraction.md`, the relevant `.pen` files, retained screenshots or browser captures, `PRODUCT.md` and current `DESIGN.md` as supporting context, existing component library and tokens, temporary HTML companion artifacts only when they still clarify an unresolved comparison, then `gsd-frontend-design` heuristics. Freeform invention is the last resort.
  - In GSD-2, use the built-in `browser-tools` extension for UI capture, comparison, and verification. Prefer semantic `browser_*` tools such as `browser_find`, `browser_snapshot_refs`, `browser_assert`, and `browser_diff` over screenshot-only browsing or external browser surfaces.
  - When `.pen` files or Pencil worksets are in scope, use `pencil-design-core` and the correct adapter, `pencil-design-angular-nebular` for Angular + Nebular or similar brownfield operator UIs, `pencil-design-react-tailwind` only for actual React / Next / Tailwind / shadcn targets. For Angular + Nebular work, verify framework guidance with `gsd-context7-research` and prefer local Nebular docs or source over memory.
  - In GSD workflows, use Pencil CLI interactive mode as the only allowed Pencil transport for `.pen` work. Do not use Pencil MCP or Pencil CLI agent mode. In headless contexts, do not bypass Pencil CLI just because a change looks small. Prefer writing to a distinct output path before replacing an existing `.pen` file. Direct text editing is degraded fallback only and must be explained in the summary.
  - Never invent a new visual direction when an approved frontend packet or Pencil workset exists. If UI work is under-specified, or the packet/workset lacks the `.pen` files, retained screenshots, or other evidence needed for high-fidelity work, stop ad-hoc UI invention and ask the human to refresh the packet or bootstrap the workset. In brownfield UI work, create a faithful runtime baseline before improvement when the current screen truth exists only in the running app and source code, and separate observed current truth, conservative normalization target, and approved change. Treat Impeccable v3 as a bounded quality layer after that baseline exists; if `PRODUCT.md` is already valid, do not re-run `/impeccable teach`. If `DESIGN.md` is missing or stale, prefer `/impeccable document` as the refresh path. Use `/impeccable live` only as a bounded refinement surface on supported stacks. If a temporary HTML companion artifact or live refinement influenced a retained direction, translate it back into `.pen` boards, screenshots, and packet prose before treating it as durable guidance.
  - When approved specs or handoff docs exist, do not leave them as disconnected external references. Project the implementation-relevant subset into native GSD artifacts so later units inherit the context automatically.
  - For each active milestone or slice, maintain a `## Source Documents` section in the relevant CONTEXT.md with exact relative paths to the approved spec, frontend direction packet, `pencil-workset.md`, `brownfield-ui-extraction.md`, `screen-index.md`, the relevant `.pen` files, retained screenshots, any still-relevant temporary HTML companion artifacts, any `PRODUCT.md` or `DESIGN.md` files that materially guided the work, GSD handoff, and other binding source documents.
  - In milestone or slice CONTEXT files, summarize only what the current work needs, in-scope capabilities, affected screens, routes, components, APIs, data contracts, constraints, open questions, verification notes, required `.pen` paths, and the Pencil skills to load.
  - Keep `.gsd/REQUIREMENTS.md` aligned with the approved spec and handoff by recording active requirements, validated requirements, deferred items, explicit non-goals, and scope boundaries that matter to implementation.
  - Append fixed implementation choices, architecture constraints, library decisions, API contracts, and conventions from the approved spec or handoff to `.gsd/DECISIONS.md` instead of burying them only in summaries or external docs.
  - Put reusable cross-slice implementation patterns from the spec, handoff, packet, workset, or completed work into `.gsd/KNOWLEDGE.md`. Put environment, services, endpoints, feature flags, background jobs, and operational dependencies into `.gsd/RUNTIME.md` when relevant.
  - When writing slice plans and task plans, translate the spec and handoff into concrete Goal, Must-Haves, Files, Key Links, Context, and Verify sections. Reference the exact source documents or screens that justify the plan.
  - When writing UAT, task summaries, or slice summaries, record which spec, handoff, packet, workset, `.pen` file, screenshot, temporary HTML companion artifact, whether Pencil CLI interactive mode was used, which Pencil skills were used, what evidence was gathered, and any approved deviations or follow-up work.
  - If a `.pen` file was edited without Pencil CLI, explain why the normal Pencil transport was not usable and record that the task ran in degraded mode.
  - In a superproject with `.gitmodules`, code review must inspect actual submodule diffs, not only pointer bumps.
  - For non-trivial work, the preferred review workflow is implementation task plus paired `Review and resolve ... findings` follow-up task.
  - The implementation task ends with one fresh-context review pass and still completes normally.
  - The paired follow-up task owns the fix or disprove plus re-review loop until `REVIEW.md` says `APPROVE` or escalation occurs.
  - Only the fresh-context reviewer creates or overwrites `REVIEW.md`.
  - Always announce when you are applying a code-review checklist and state the verdict in the task summary.
  - SUPERPROJECT SUBMODULE RULE — applies before every "Task complete" and "Slice complete"; Run [ -f .gitmodules ] && git submodule foreach --quiet 'echo "=== $name ===" && git status --short' If any submodule shows dirty output, load the submodule-commit skill and commit those submodule working trees NOW, before proceeding. Do NOT run git add or git commit at the superproject root — the system auto-commits the pointer update. The "Do not commit manually" instruction does not apply to submodules.

models:
  research: openai-codex/gpt-5.4
  planning: openai-codex/gpt-5.4
  execution: openai-codex/gpt-5.4
  completion: openai-codex/gpt-5.4
skill_discovery: suggest
auto_supervisor:
  soft_timeout_minutes: 120
  idle_timeout_minutes: 60
  hard_timeout_minutes: 999
git:
  auto_push: false
  push_branches: false
  remote:
  snapshots:
  pre_merge_check:
  commit_type:
  main_branch:
  isolation: branch
---
