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
    prepend: Implementation-end review policy. If this is a non-trivial implementation task that has a planned follow-up `Review and resolve ... findings` task, then the final review in this task is evidence collection only, not remediation. Required process, 1. Finish implementation, verification and submodule commits first. 2. Load `code-review`. 3. Spawn a fresh `worker` subagent reviewer. 4. Tell the reviewer to read `~/.gsd/agent/skills/code-review/SKILL.md` first and follow it in `implementation-end-review` mode. 5. The reviewer inspects the current working tree against `HEAD`. 6. If `.gitmodules` exists, the reviewer must treat the repo as a superproject and inspect actual submodule diffs with `git diff --submodule=diff`, not only pointer bumps. 7. The reviewer writes exactly one artifact for the current task, - `.gsd/{milestoneId}/slices/{sliceId}/tasks/{taskId}-REVIEW.md` 8. The reviewer must set, - `Verdict, APPROVE | REQUEST_CHANGES | ESCALATE` - `Review Decision, no_action | remediate_and_rereview | escalate_replan` 9. Do not fix or disprove findings from this final review pass inside the implementation task. 10. Do not start a review loop inside the implementation task. 11. The implementation task completes normally after the review artifact is written. 12. Any remediation belongs to the paired `Review and resolve ... findings` task. If this task is itself a `Review and resolve ... findings` task, do not run this first-pass policy. Follow the review-resolve loop instead.
  - name: review-resolve-task-policy
    before:
      - execute-task
    action: modify
    prepend: Review-and-resolve task policy. If this task is a `Review and resolve Txx findings` task, then this task owns the review loop for the referenced implementation task. Required process, 1. Load `code-review`. 2. Identify the target task being reviewed. 3. Read `.gsd/{milestoneId}/slices/{sliceId}/tasks/{targetTaskId}-REVIEW.md`. 4. If it says `verdict, APPROVE`, treat this as a no-op task and complete it with a brief summary. 5. If it says `verdict, REQUEST_CHANGES`, fix or explicitly disprove every Critical and Important finding with fresh verification evidence. 6. Spawn a fresh `worker` subagent reviewer. 7. Tell the reviewer to read `~/.gsd/agent/skills/code-review/SKILL.md` first and follow it in `review-resolve-loop` mode. 8. The reviewer inspects the updated working tree against `HEAD`. 9. If `.gitmodules` exists, the reviewer must treat the repo as a superproject and inspect actual submodule diffs with `git diff --submodule=diff`, not only pointer bumps. 10. The reviewer overwrites the authoritative review artifact for the target task, - `.gsd/{milestoneId}/slices/{sliceId}/tasks/{targetTaskId}-REVIEW.md` 11. Use at most 4 fresh review cycles total in this task. 12. If the review artifact still does not say `APPROVE` after 4 cycles, stop and escalate through `replan-slice` or `blocker_discovered, true`. If this task is `Review and resolve slice findings`, use the same loop but target the slice-level artifact, - `.gsd/{milestoneId}/slices/{sliceId}/REVIEW.md`
custom_instructions:
  - .gsd/STATE.md is always untracked and should not be committed.
  - Always announce skill usage
  - Detailed frontend, spec-projection, review, and superproject/submodule behavior lives in AGENTS.md and the pre-dispatch hooks above. Do not restate those policies here unless the hook cannot cover the command.
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
