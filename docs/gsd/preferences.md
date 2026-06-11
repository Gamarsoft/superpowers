---
version: 1
mode: solo
skill_rules:
  - when: writing sentences or prose for a human to read
    use:
      - writing-clearly-and-concisely
  - when: "completing non-trivial implementation work or completing a slice, especially for auth, storage, external I/O, or superprojects with git submodules"
    use:
      - gsd-code-review
    avoid:
      - review
  - when: "task involves external libraries, frameworks, SDKs, APIs, or version-sensitive tooling"
    use:
      - gsd-context7-research
  - when: "researching, planning, re-planning, implementing, verifying, or refining frontend and UI/UX related work"
    use:
      - gsd-frontend-design
    avoid:
      - frontend-design
  - when: "turning native or mobile-first app requirements into screen inventory, mobile jobs, app flows, primary actions, state coverage, permission moments, or native-vs-web direction"
    use:
      - mobile-product-direction
  - when: "designing native or mobile-first navigation, forms, search, filtering, gestures, permissions, loading, empty, error, offline, accessibility, text scaling, tap targets, semantics, or recoverable states"
    use:
      - mobile-interaction-and-usability
  - when: "defining or improving native or mobile-first visual direction, hierarchy, typography, spacing, density, color, motion, state visuals, premium feel, native polish, or non-generic app UI quality"
    use:
      - mobile-visual-design
  - when: "reviewing native or mobile-first screens, flows, screenshots, prototypes, implementations, usability, accessibility, app store quality, or generic AI mobile UI risks"
    use:
      - mobile-design-review
  - when: "writing, changing, reviewing, or approving visible UI copy, microcopy, i18n strings, or ChatGPT Images prompt visible text"
    use:
      - writing-ux-copy
  - when: "researching, planning, re-planning, implementing, verifying, or refining Java 21+ Spring backend work"
    use:
      - /Users/gamarsoft/.agents/skills/java-21-spring-gke-implementation
models:
  discuss:
    model: gpt-5.5
    provider: openai-codex
    thinking: high
  research:
    model: gpt-5.5
    provider: openai-codex
    thinking: high
  planning:
    model: gpt-5.5
    provider: openai-codex
    thinking: high
  execution:
    model: gpt-5.5
    provider: openai-codex
    thinking: medium
  execution_simple:
    model: gpt-5.5
    provider: openai-codex
    thinking: low
  completion:
    model: gpt-5.5
    provider: openai-codex
    thinking: high
  validation:
    model: gpt-5.5
    provider: openai-codex
    thinking: high
  subagent:
    model: gpt-5.5
    provider: openai-codex
    thinking: high
skill_staleness_days: 0
auto_supervisor:
  soft_timeout_minutes: 999
  idle_timeout_minutes: 999
  stalled_tool_timeout_minutes: 999
  hard_timeout_minutes: 999
uat_dispatch: false
unique_milestone_ids: false
notifications:
  local_bell: true
cmux:
  enabled: false
  notifications: false
  sidebar: false
  splits: false
  browser: false
git:
  auto_push: false
  push_branches: false
  isolation: branch
pre_dispatch_hooks:
  - name: subagent-wait-discipline
    before:
      - execute-task
      - complete-slice
      - validate-milestone
    action: modify
    prepend: 'Subagent discipline, foreground subagent calls are blocking, so wait for the tool result; do not poll action "status" unless background = true was used, wait at least 3 minutes between background status checks, never launch a duplicate subagent for the same target, and do not pass followUp to status. Also ignore the Stalled tool detected system notification for foreground subagents, since waiting is expected, don''t attempt idle recovery during expected waits, and don''t escalate or replan for expected waits.'
  - name: avoid-context-mode-tools-when-scoped-out
    before:
      - research-milestone
      - plan-milestone
      - research-slice
      - plan-slice
      - refine-slice
      - replan-slice
      - execute-task
      - complete-slice
      - run-uat
      - validate-milestone
      - reassess-roadmap
      - complete-milestone
    action: modify
    prepend: "Tool-scope guard,\nContext Mode tools may be available, but do not call `gsd_resume`,\n`gsd_exec`, or `gsd_exec_search` unless this unit's scoped workflow\ninstructions explicitly allow them.\n\nFor `plan-slice`, do not call `gsd_resume`. Use the prompt context\nalready provided and call `gsd_plan_slice` directly.\n\nFor `reassess-roadmap`, do not call `gsd_resume`, `gsd_exec`, or `gsd_exec_search`. The only GSD lifecycle tools allowed are `gsd_milestone_status` and `gsd_reassess_roadmap`; use `gsd_reassess_roadmap` to write the assessment."
  - name: frontend-evidence-policy
    before:
      - plan-milestone
      - plan-slice
      - replan-slice
      - execute-task
      - complete-slice
    action: modify
    prepend: "Frontend evidence policy. If this unit touches user-visible frontend, UI, UX, copy layout, interaction design, responsive behavior, browser state, or native mobile UI state, first locate the approved spec, handoff, acceptance criteria, frontend direction packet, selected visual-truth source, brownfield-ui-extraction.md, screen-index.md, retained screenshots, browser captures, simulator/device captures, and any packet paths listed in milestone or slice CONTEXT files. Use gsd-frontend-design, preserve the existing product design system unless the packet explicitly authorizes change, and do not invent visual direction when an approved packet or visual-truth source exists. ChatGPT Images 2 files are optional approved references; when selected, read exact generated image paths and approved reference intent. When source evidence is missing, stop ad-hoc UI invention and request a packet refresh. Before visual changes, classify every reference as visual-truth, semantic-guidance, or reference-only; if intent is missing, ask for confirmation or record degraded mode. UI copy changes require writing-ux-copy or an approved copy deck. Completion for reference-backed UI requires platform runtime evidence plus the reference-intent checklist; screenshots alone, DOM checks, build, lint, or test output are insufficient. Keep CONTEXT Frontend References current with exact packet, selected visual source, image, screenshot, capture, brownfield, screen-index, PRODUCT.md, and DESIGN.md paths. Raw runtime evidence is local by default unless explicitly requested as a commit artifact."
  - name: spec-and-handoff-projection
    before:
      - plan-milestone
      - plan-slice
      - replan-slice
      - execute-task
      - complete-slice
    action: modify
    prepend: "Spec and handoff projection policy. Treat approved specs and GSD handoffs as upstream source documents, then project only the implementation-relevant subset into native GSD artifacts. If a handoff says frontend packet status is required, do not plan or execute frontend implementation yet; run the referenced frontend-direction follow-on prompt first. Keep milestone or slice CONTEXT files updated with exact source paths, in-scope sections, screens, endpoints, constraints, verification notes, selected visual-truth source, approved image paths, screenshots, browser captures, and source evidence paths. Mirror binding requirements and explicit non-goals into .gsd/REQUIREMENTS.md, append fixed choices to .gsd/DECISIONS.md, put reusable cross-slice patterns into .gsd/KNOWLEDGE.md, and record runtime dependencies in .gsd/RUNTIME.md when relevant."
  - name: review-task-planning-policy
    before:
      - plan-slice
      - replan-slice
    action: modify
    prepend: "Review-task planning policy. When planning or re-planning this slice, decompose non-trivial work into explicit implementation and review-and-resolve units. Planning rules, 1. For each non-trivial implementation task, add a follow-up task named `Review and resolve Txx findings`. 2. The implementation task ends with one fresh-context review pass in a `worker` subagent before the task completes. 3. That first review pass writes one authoritative review artifact for the implementation task being reviewed, `.gsd/{milestoneId}/slices/{sliceId}/tasks/{taskId}-REVIEW.md`. 4. For non-trivial UI work, the implementation task also ends with one fresh-context visual review artifact, `.gsd/{milestoneId}/slices/{sliceId}/tasks/{taskId}-VISUAL-REVIEW.md`. 5. The implementation task still completes normally whether the first-pass reviewer sets `Verdict, APPROVE`, `REQUEST_CHANGES`, or `ESCALATE`. 6. The follow-up review-and-resolve task is a no-op if `Txx-REVIEW.md` and any `Txx-VISUAL-REVIEW.md` both say `Verdict, APPROVE`. 7. If either review artifact says `Verdict, REQUEST_CHANGES`, the follow-up task fixes or explicitly disproves every Critical and Important finding, reruns verification, then launches another fresh-context review pass for the affected review type. 8. Only the fresh-context reviewer creates or overwrites `REVIEW.md` or `VISUAL-REVIEW.md`. 9. Use at most 4 fresh review cycles inside the follow-up task. If the relevant review artifact still does not say `APPROVE` after 4 cycles, stop and escalate through `replan-slice` or `blocker_discovered, true`. 10. Skip paired review tasks only for trivial docs-only edits, copy-only edits, renames, formatting-only changes, or clearly mechanical non-behavioral changes. 11. For any non-trivial slice, add a final `Review and resolve slice findings` task before `complete-slice`, using `.gsd/{milestoneId}/slices/{sliceId}/REVIEW.md` and, for non-trivial UI slices, `.gsd/{milestoneId}/slices/{sliceId}/VISUAL-REVIEW.md`. Task-shape guidance, Implementation task, build and verify behavior, then run fresh-context review before task completion. Review-and-resolve task, if reviews say APPROVE, no-op; otherwise fix or disprove findings and rerun fresh-context review until APPROVE or escalation."
  - name: implementation-end-review-policy
    before:
      - execute-task
    action: modify
    prepend: "Implementation-end review policy. If this is a non-trivial implementation task that has a planned follow-up `Review and resolve ... findings` task, then the final review in this task is evidence collection only, not remediation. Required process, 1. Finish implementation, verification, and submodule commits first. 2. Load `gsd-code-review`. 3. Spawn a fresh `worker` subagent reviewer. 4. Tell the reviewer to read the loaded `gsd-code-review` skill first and follow it in `implementation-end-review` mode. 5. The reviewer inspects the current working tree against `HEAD`. 6. If `.gitmodules` exists, the reviewer must treat the repo as a superproject and inspect actual submodule diffs with `git diff --submodule=diff`, not only pointer bumps. 7. The reviewer writes exactly one artifact for the current task, `.gsd/{milestoneId}/slices/{sliceId}/tasks/{taskId}-REVIEW.md`. 8. The reviewer must set `Verdict, APPROVE | REQUEST_CHANGES | ESCALATE` and `Review Decision, no_action | remediate_and_rereview | escalate_replan`. 9. Do not fix or disprove findings from this final review pass inside the implementation task. 10. Do not start a review loop inside the implementation task. 11. The implementation task completes normally after the review artifact is written. 12. Any remediation belongs to the paired `Review and resolve ... findings` task. If this task is itself a `Review and resolve ... findings` task, do not run this first-pass policy. Follow the review-resolve loop instead."
  - name: frontend-visual-review-policy
    before:
      - execute-task
      - complete-slice
    action: modify
    prepend: "Frontend visual review policy. If this unit includes non-trivial UI work, after implementation and runtime/reference verification but before completion, run one fresh-context visual quality review in a `worker` subagent. Tell the reviewer to read project instructions first, nearest repo and workflow `AGENTS.md` files, relevant `.gsd/**/CONTEXT.md`, `PRODUCT.md`, `DESIGN.md`, the task file, and any slice or milestone instructions that affect the target route or screen. Tell the reviewer to load Impeccable, apply critique/audit as applicable, inspect the approved packet, visual-truth sources, reference-intent checklist, and runtime evidence, then write `.gsd/{milestoneId}/slices/{sliceId}/tasks/{taskId}-VISUAL-REVIEW.md` or slice-level `.gsd/{milestoneId}/slices/{sliceId}/VISUAL-REVIEW.md` with `Verdict, APPROVE | REQUEST_CHANGES | ESCALATE` and `Review Decision, no_action | remediate_and_rereview | escalate_replan`. For native or mobile-first work, tell the reviewer to load `mobile-design-review` and explicitly check task clarity, native conventions, compact-screen fit, state coverage, text scaling, tap targets, semantics, gesture alternatives, safe areas, permission fallbacks, and generic AI-mobile risks. For web targets, tell the reviewer to use a fresh browser context, profile, window, or tab when the environment supports it, and do not reuse the implementer's browser session, route, storage, console state, or previously opened page. For Flutter targets, tell the reviewer to use fresh simulator/device, widget-test, golden, or UI-gallery evidence when supported; do not rely only on the implementer's screenshots, assertions, or summaries. If isolation is unavailable, record the limitation before navigating or launching the target. The reviewer must independently open the target route/screen and recapture required platform evidence when responsive UI scope applies. Implementer screenshots, assertions, or summaries are comparison inputs, not a substitute for reviewer runtime proof. If the target cannot be opened or recaptured because of `ERR_CONNECTION_REFUSED`, connection refused, server unavailable, simulator/device unavailable, route failure, app launch failure, or test harness failure, the reviewer must not approve. Use `REQUEST_CHANGES` when a follow-up task can restore runnable evidence, or `ESCALATE` when the environment or task framing blocks review. The artifact must include a `Visual Review Completion Gates` section covering project instructions read, fresh runtime isolation or recorded fallback, independent runtime recapture, approved reference checklist completion, desktop/mobile platform scope, console/network or Flutter test/log checks when relevant, and any missing gate that prevents approval. Treat findings as review evidence, not permission to redesign. If this is an implementation-end pass and a paired review-and-resolve task exists, unresolved blocking and important findings belong to that follow-up unless they prevent basic verification from running. Do not rely on implementer self-review as the final visual gate for non-trivial UI work."
  - name: frontend-visual-fixture-policy
    before:
      - plan-slice
      - replan-slice
      - execute-task
      - complete-slice
    action: modify
    prepend: "Frontend visual fixture policy. Live runtime is the default proof path for frontend/backend work. Use fixture mode only when live runtime data cannot produce a required hard visual state on demand. Live mode proves integration, auth, routing, feature flags, tenant context, and service composition for the available real state. Visual fixture mode proves hard-to-reach visual states, responsive behavior, copy, action hierarchy, and reference-intent parity with deterministic contract-shaped API responses. Use platform-appropriate fixtures, browser/e2e network fixtures or a local mock proxy for web targets, and widget-test pumps, Bloc/Cubit states, fake repositories, golden fixtures, or app-supported debug fixtures for Flutter targets. In-browser XHR/fetch monkeypatches are acceptable only as ad-hoc web spikes; label them as temporary fixture evidence and convert successful lanes into a repeatable network fixture or proxy harness before relying on them across tasks or slices. Label fixture evidence as fixture evidence, never as live integration proof. UAT must separate live runtime proof from fixture visual-state proof and state the claim boundary for each."
  - name: review-resolve-task-policy
    before:
      - execute-task
    action: modify
    prepend: "Review-and-resolve task policy. If this task is a `Review and resolve Txx findings` task, then this task owns the review loop for the referenced implementation task. Required process, 1. Load `gsd-code-review`. 2. Identify the target task being reviewed. 3. Read `.gsd/{milestoneId}/slices/{sliceId}/tasks/{targetTaskId}-REVIEW.md` and, if present, `.gsd/{milestoneId}/slices/{sliceId}/tasks/{targetTaskId}-VISUAL-REVIEW.md`. 4. If every present review artifact says `Verdict, APPROVE`, treat this as a no-op task and complete it with a brief summary. 5. If any artifact says `Verdict, REQUEST_CHANGES`, fix or explicitly disprove every Critical and Important finding with fresh verification evidence. 6. Spawn a fresh `worker` subagent reviewer for each affected review type. 7. For code review, tell the reviewer to read the loaded `gsd-code-review` skill first and follow it in `review-resolve-loop` mode. For visual review, tell the reviewer to read project instructions first, load Impeccable, apply critique/audit as applicable, inspect approved frontend evidence plus runtime proof, use fresh browser evidence for web targets or fresh simulator/device, widget-test, golden, or UI-gallery evidence for Flutter targets, independently open the target route/screen, recapture required platform evidence, and overwrite the visual review artifact with `Visual Review Completion Gates`. 8. The reviewer inspects the updated working tree against `HEAD`. 9. If `.gitmodules` exists, the code reviewer must treat the repo as a superproject and inspect actual submodule diffs with `git diff --submodule=diff`, not only pointer bumps. 10. The reviewer must overwrite the authoritative review artifact for the target task, `.gsd/{milestoneId}/slices/{sliceId}/tasks/{targetTaskId}-REVIEW.md` and/or `.gsd/{milestoneId}/slices/{sliceId}/tasks/{targetTaskId}-VISUAL-REVIEW.md`. 11. Use at most 4 fresh review cycles total in this task. 12. If the relevant review artifact still does not say `APPROVE` after 4 cycles, stop and escalate through `replan-slice` or `blocker_discovered, true`. If this task is `Review and resolve slice findings`, use the same loop but target the slice-level artifacts, `.gsd/{milestoneId}/slices/{sliceId}/REVIEW.md` and optional `.gsd/{milestoneId}/slices/{sliceId}/VISUAL-REVIEW.md`."
dynamic_routing:
  enabled: false
  escalate_on_failure: true
  budget_pressure: true
  cross_provider: true
  hooks: true
  capability_routing: false
  allow_flat_rate_providers: false
  tier_models:
    light: openai-codex/gpt-5.5
    standard: openai-codex/gpt-5.5
    heavy: openai-codex/gpt-5.5
uok:
  enabled: true
  legacy_fallback:
    enabled: false
  gates:
    enabled: true
  model_policy:
    enabled: true
  execution_graph:
    enabled: true
  audit_unified:
    enabled: true
  plan_v2:
    enabled: true
  gitops:
    enabled: true
    turn_action: commit
    turn_push: false
token_profile: burn-max
experimental:
  rtk: true
---

# GSD Skill Preferences

See `~/.gsd/agent/extensions/gsd/docs/preferences-reference.md` for full field documentation and examples.
