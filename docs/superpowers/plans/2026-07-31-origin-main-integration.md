# Origin Main Integration Implementation Plan

> **For agentic workers:** REQUIRED: Use superpowers:subagent-driven-development (if subagents available) or superpowers:executing-plans to implement this plan. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Merge current `origin/main` into the Gamarsoft customization line while preserving custom workflows and adopting upstream v6 runtime, lifecycle, packaging, and safety improvements.

**Architecture:** Perform one real merge transaction so future upstream ancestry is correct. Resolve by subsystem: upstream-first for runtime infrastructure, SDD lifecycle, worktrees, and packaging; custom-first for product/planning policy; explicit hybrid reconstruction for prompts, tests, bootstrap, and reviewer contracts.

**Tech Stack:** Git, Markdown skills/prompts, Bash, Node.js CommonJS, WebSocket test harnesses, Codex plugin manifests.

**Context7 Findings:** None — no external API/library uncertainty; integration uses repository code and its pinned `ws` test dependency.

---

## Plan Context

**Invariants:** Preserve the original branch; record `origin/main` as an ancestor; keep runtime state untracked; require authentication for companion reads/events; retain workflow-family isolation, typed Codex roles, and additive custom skills.

**Non-goals:** No history rewrite, Pencil restoration, generic rewrite of custom skills, or silent deletion of specialized review guidance.

**Backward compatibility:** Existing comparison/carry-forward UI, GSD handoff, no-Pencil frontend policy, Context7 handoff, Java/Spring/GKE checks, and custom skill discovery remain available.

**Cross-Task Invariants:** Upstream security and lifecycle tests coexist with custom behavior tests; reviewer dispatch placeholders resolve completely; SDD uses one combined task review plus broad final review; no required test is omitted from its runner.

**Adversarial / Boundary Cases:** unauthenticated HTTP/WebSocket access, DNS-rebinding origin mismatch, symlink/dotfile/traversal requests, stale SDD ledgers, repeated fix rounds, detached worktrees, generated runtime files, and multiline HTML text assertions.

## Chunk 1: Merge foundation and visual runtime

### Task 1: Start the merge transaction and reconcile platform foundations

**Files:** Modify `.gitignore`, `README.md`, plugin manifests, install docs, hooks, package metadata, scripts, and non-overlapping upstream paths; remove generated `.superpowers/brainstorm` artifacts.

**Interfaces and contracts:** `origin/main` must become a merge parent; `.codex/agents/*.toml`, `.codex/config.toml` multi-agent configuration, GSD ignore rules, the submodule-oriented `using-feature-branches-with-submodules` skill, and additive skills remain present; Codex manifest declares native skills and `hooks: {}`; upstream deterministic packaging, native worktree detection, provenance cleanup, and explicit-only discard flow each retain an owned file/test surface.

**Acceptance criteria:** Conflict inventory matches the merge state; safe upstream additions are retained; obsolete Codex hook/install paths and tracked runtime artifacts are absent; `.gitignore` contains the union of project and upstream runtime exclusions; Codex archives are deterministic; worktree cleanup only removes owned project-local worktrees and discard is never offered unless explicitly requested.

**Error handling:** Abort the merge if the refreshed upstream SHA differs from the spec by more than documentation-only changes; never use destructive reset; retain unresolved files rather than guessing across policy conflicts.

**Verification:** Run `git diff --name-only --diff-filter=U`, `tests/codex/test-marketplace-manifest.sh`, `tests/codex/test-package-codex-plugin.sh`, `tests/codex-plugin-sync/test-sync-to-codex-plugin.sh`, `tests/claude-code/test-worktree-native-preference.sh`, `tests/claude-code/test-worktree-path-policy.sh`, and path/reference searches; expect only explicitly deferred domain conflicts, deterministic package assertions green, provenance/native-worktree assertions green, and no lost custom-only paths.

**Codebase pointers:** `.gitignore`, `.codex/`, `.codex-plugin/`, `hooks/`, `scripts/`, `README.md`, `RELEASE-NOTES.md`, upstream release notes.

- [ ] Step 1: Read codebase pointers and understand existing patterns
- [ ] Step 2: Write failing contract checks for retained custom paths, removed runtime artifacts, and Codex no-hook metadata
- [ ] Step 3: Run checks to verify they fail against the unresolved/default merge result
- [ ] Step 4: Resolve the platform foundation and safe additive changes
- [ ] Step 5: Run checks, self-review, and stage the merge-domain result; commit remains deferred until all merge conflicts are green

### Task 2: Rebuild the visual companion on the upstream-secure runtime

**Files:** Modify `skills/brainstorming/scripts/{server.cjs,start-server.sh,stop-server.sh,helper.js,frame-template.html}`, `skills/brainstorming/{SKILL.md,visual-companion.md,spec-document-reviewer-prompt.md}`, and `tests/brainstorm-server/`.

**Interfaces and contracts:** Preserve upstream token/cookie/origin/path APIs, security headers, payload bounds, restart persistence, and startup metadata; preserve custom authored choice events, fragment shell, comparison/carry-forward templates, polling fallback, full-document pass-through, and GSD handoff material.

**Acceptance criteria:** Unauthenticated access is rejected; authenticated HTTP/WebSocket paths work; unsafe files are refused; security headers and payload bounds are enforced; port/token restart persistence works; custom selection/carry-forward and GSD handoff behavior remain stable; `npm test` runs the full upstream-plus-custom suite; `helper-selection-clarity.test.js` remains registered and checks rendered semantics rather than source formatting.

**Error handling:** Reject invalid authentication and unsafe paths; degrade from filesystem watch to polling; do not clear decisions for non-new screens; shutdown only owned processes.

**Verification:** Run `npm test` in `tests/brainstorm-server` plus `bash windows-lifecycle.test.sh`; expect all security, lifecycle, WebSocket, comparison, carry-forward, and contract cases green.

**Codebase pointers:** Current custom examples/references/tests; upstream `auth.test.js`, `lifecycle.test.js`, launcher tests, and v6 visual companion commits.

- [ ] Step 1: Read codebase pointers and understand existing patterns
- [ ] Step 2: Run/import upstream security tests and custom behavior tests against the pre-resolution runtime to establish RED evidence
- [ ] Step 3: Confirm failures correspond to missing security or lost custom behavior
- [ ] Step 4: Resolve runtime and UI files with upstream security as the foundation and custom behavior as explicit overlays
- [ ] Step 5: Run tests, self-review, and stage the merge-domain result; commit remains deferred until all merge conflicts are green

## Chunk 2: SDD and workflow policy

### Task 3: Adopt the upstream SDD lifecycle with custom execution contracts

**Files:** Modify `skills/subagent-driven-development/`, `.codex/agents/`, `skills/using-superpowers/references/codex-tools.md`, and SDD tests.

**Interfaces and contracts:** Use plan-scoped `sdd-workspace`, `task-brief`, `review-package`, durable ledger, combined `task-reviewer-prompt.md`, scoped `re-review-prompt.md`, resumable implementers, five-round circuit breaker, and broad final review; retain typed role selection, Context7 Findings, concern statuses, codebase-vs-plan escalation, and applicable Java/Spring/GKE review depth through `skills/requesting-code-review/references/java-21-spring-gke-checklist.md`.

**Acceptance criteria:** Legacy two-reviewer prompt files are retired only after their valuable checks are represented; the durable ledger identifies its plan and stale ledgers cannot contaminate a new plan; fix rounds resume implementers when supported; reviewers are read-only; typed Codex roles map to currently available APIs; Java/Spring/GKE tasks route the specialized checklist into combined task and final review.

**Error handling:** Escalate unresolved plan contradictions and circuit-breaker exhaustion; do not suppress reviewer findings through accepted-decision text; fall back to fresh fix agents only when resume is unavailable.

**Verification:** Run upstream SDD workspace/static tests and custom prompt-contract checks; inspect every removed legacy prompt against its replacement; use a Java/Spring/GKE fixture assertion to verify the specialized checklist is loaded by the combined review contract.

**Codebase pointers:** Current SDD SKILL/prompts, `.codex/agents/*.toml`, upstream SDD scripts/prompts/tests, current Context7 and review checklist references.

- [ ] Step 1: Read codebase pointers and understand existing patterns
- [ ] Step 2: Add failing static/behavioral checks for typed roles, Context7 handoff, combined review, plan scoping, and resume lifecycle
- [ ] Step 3: Run checks to verify the hybrid contract is not yet satisfied
- [ ] Step 4: Reconstruct SDD SKILL and prompts on the upstream lifecycle
- [ ] Step 5: Run tests, self-review, and stage the merge-domain result; commit remains deferred until all merge conflicts are green

### Task 4: Reconcile planning, review, bootstrap, and branch-safety skills

**Files:** Modify `skills/{writing-plans,requesting-code-review,receiving-code-review,using-superpowers,using-git-worktrees,finishing-a-development-branch,test-driven-development,systematic-debugging,verification-before-completion,executing-plans,dispatching-parallel-agents}/` and related tests.

**Interfaces and contracts:** Preserve custom invariant/acceptance-criteria/interfaces-based planning, workflow-family isolation, and the product/frontend/mobile skill family; adopt upstream task right-sizing, concise and harness-neutral guidance, writing-good-tests guidance, native worktree detection, provenance cleanup, forge neutrality, and explicit-only discard behavior; reviewer placeholders must match exactly.

**Acceptance criteria:** No implementation bodies are required in plans; product/frontend/mobile skills remain discoverable under workflow-family isolation; custom domain checklists load when applicable; every reviewer placeholder has one documented substitution; worktree behavior detects existing isolation/submodules; the bootstrap uses harness-neutral action language and points to accurate Codex tools without losing workflow-family isolation.

**Error handling:** Stop for plan-vs-codebase WHAT conflicts, sandbox-managed detached branches, unknown reviewer placeholders, or worktree cleanup outside owned directories.

**Verification:** Run static skill tests, worktree tests, no-Pencil tests, placeholder scans, and shell lint; expect no stale deleted-file references.

**Codebase pointers:** Current custom skill files and tests; upstream v5.1-v6.2 replacements and release notes; `.codex/agents` role definitions.

- [ ] Step 1: Read codebase pointers and understand existing patterns
- [ ] Step 2: Add failing contract checks for placeholder parity, workflow isolation, planning policy, and worktree safety
- [ ] Step 3: Run checks to verify unresolved conflicts violate the intended hybrid contract
- [ ] Step 4: Resolve and compress the policy skills while preserving custom guarantees
- [ ] Step 5: Run tests, self-review, and stage the merge-domain result; commit remains deferred until all merge conflicts are green

## Chunk 3: Integration completion

### Task 5: Reconcile documentation, test runners, and custom inventory

**Files:** Modify documentation, `tests/brainstorm-server/package.json`, Claude/Codex/OpenCode test runners, and any path indexes affected by upstream removals.

**Interfaces and contracts:** `tests/brainstorm-server/package.json` is the canonical companion inventory and executes upstream `auth`, `branding`, `browser-launcher`, `helper`, `server`, `lifecycle`, and `ws-protocol` tests; custom `carry-forward-behavior`, `fragment-comparison-defaults`, `helper-selection-clarity`, `live-companion-acceptance`, and `visual-companion-contract` tests; and `start-server`, `stop-server`, and `windows-lifecycle` shell tests. Docs describe native Codex install and the hybrid SDD/planning flow; all 14 additive custom skill entrypoints and their OpenAI metadata remain discoverable.

**Acceptance criteria:** No stale `.codex/INSTALL.md`, old reviewer prompt, legacy command, Pencil, or orphan hook references remain in active guidance; release/history documents may retain dated references when clearly historical; generated runtime files are untracked; `helper-selection-clarity.test.js` stays in the canonical runner and passes without relying on contiguous HTML source whitespace.

**Error handling:** Distinguish active references from dated artifacts; do not delete historical design records merely because paths evolved; fail test runners on missing maintained tests.

**Verification:** Run repository path searches; compare pre-merge `dacda7b` and final `skills/*/SKILL.md` entrypoint sets and verify the 14 additive paths plus their `agents/openai.yaml` metadata explicitly; run manifest/package tests and the canonical companion runner, then verify every named maintained test appears once in its output or runner definition.

**Codebase pointers:** `README.md`, `docs/README.*`, `docs/testing.md`, test package files, run scripts, current custom skill inventory, upstream manifests.

- [ ] Step 1: Read codebase pointers and understand existing patterns
- [ ] Step 2: Add failing inventory/runner checks for required custom skills and all maintained tests
- [ ] Step 3: Run checks to verify stale paths or omitted tests are detected
- [ ] Step 4: Reconcile docs, runners, and indexes
- [ ] Step 5: Run tests, self-review, and stage the merge-domain result; commit remains deferred until all merge conflicts are green

### Task 6: Complete and verify the merge transaction

**Files:** All staged merge paths; no new production surface beyond Tasks 1-5.

**Interfaces and contracts:** The merge commit has both custom HEAD and `origin/main` as parents; working tree is clean afterward; original branch/ref remains unchanged.

**Acceptance criteria:** Zero unmerged paths/conflict markers; combined deterministic suites pass; security runtime checks pass; custom skill inventory and invariants are verified; final diff contains no accidental runtime artifacts or secrets.

**Error handling:** Do not commit with failing required tests or unresolved Critical/Important findings; abort only if reconciliation cannot preserve a named invariant; never force-push the original branch.

**Verification:** Run complete companion, shell, worktree, SDD, manifest, packaging, no-Pencil, custom policy, and reference scans; run `git merge-base --is-ancestor origin/main HEAD`; inspect `git diff --check`, status, and merge parents.

**Codebase pointers:** Specification, Tasks 1-5 outputs, all test runners, final staged diff.

- [ ] Step 1: Read the specification and staged diff, then map every invariant to evidence
- [ ] Step 2: Add any missing regression/contract test exposed by whole-merge review
- [ ] Step 3: Run new tests to verify they fail for the identified gap
- [ ] Step 4: Apply only the minimal correction required by whole-merge review
- [ ] Step 5: Run the full verification matrix, self-review, create the merge commit, and verify both parents

## Invariant-to-Task Mapping

- Runtime authentication/containment: Task 2; re-verified Task 6; omission exposes screens and event injection.
- Custom visual behavior: Tasks 2 and 5; re-verified Task 6; omission breaks comparison/carry-forward workflows.
- Plan-scoped resumable SDD: Task 3; re-verified Task 6; omission causes stale progress or costly fresh fix agents.
- Workflow-family isolation and custom planning/review depth: Task 4; re-verified Task 6; omission changes the user's established workflow.
- Custom skill inventory and untracked runtime state: Tasks 1 and 5; re-verified Task 6; omission loses capabilities or commits ephemeral state.
- Correct upstream ancestry and original-branch safety: Tasks 1 and 6; re-verified after commit; omission makes future updates unreliable.

## Whole-Feature Verification

Task 6 must prove unauthenticated and authenticated runtime states, custom visual states, repeated SDD fix state, stale-plan isolation, worktree/detached-HEAD safety, reviewer placeholder completeness, custom skill discovery, native Codex packaging, and clean Git ancestry together. Per-domain green tests are insufficient if the final merged runner omits them or the final tree reintroduces stale paths.
