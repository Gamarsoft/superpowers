# Upstream v6.4.2 integration implementation plan

Status: approved by the user on 2026-09-28 with the instruction to proceed in a dedicated branch. Based on the comparison in this directory. The user confirmed on 2026-09-28 that the written-spec path stays in this merge; an in-chat shortcut is a separate evaluation.


> For agentic workers: explicit self-hosting execution override is `superpowers:executing-plans` in the controller. Do not switch to the evolving SDD implementation during this merge.

**Goal:** Integrate upstream v6.4.2 while preserving the approved Gamarsoft workflow contracts.
**First delivery boundary:** A verified, committed dedicated branch with upstream ancestry and durable evidence; no installation or published-branch integration.
**Architecture:** Real Git merge with controller-owned resolutions, focused helper fixes, selective policy integration and independent behavioral evaluation.
**Tech stack:** Git, Bash, Python 3, Node.js, Markdown/YAML skill definitions and existing platform integrations.
**Spec:** `docs/superpowers/analysis/2026-09-28-upstream-v6.4.2/spec.md`
**Spec revision:** 2026-09-28 r1, approved through the user's proceed instruction on the preceding comparison and merge proposal.
**Risk class:** review-required
**Risk triggers:** public helper contracts, orchestration authority, workspace identity/concurrency, cross-skill contracts, packaging.
**Verification lanes:** Controller owns focused and integration tests; fresh agents supply behavioral samples and read-only reviews; controller finishing owns the complete deterministic inventory once at the final implementation HEAD.

## Intended result

Gamarsoft incorporates upstream commit `8ca22dba9a94f28898bbce59f2537ff4d87c747d` while preserving its reviewed design, frontend packet, risk-scaled delivery, role and finishing contracts. New helpers and harness support work with the fork's package and tests. The combined active skill inventory is 27.

Start from fork commit `410d0fc3516e6c67931fd9de5642f7f6363fc7a4`. Confirm both pins again before execution; if either target changes, update the comparison rather than silently widening scope.

## Execution boundaries

- Use a suitable free managed worktree or create one through the host tool. Prepare `codex/integrate-upstream-v6.4.2` from the pinned fork commit, not the tool's default upstream branch.
- Preserve the published Gamarsoft branch. Use a real merge, not rebase, squash-import, or force-push. No upstream contribution is proposed.
- One integrator owns Git state and the final resolutions. The workflow being changed must not silently change its own execution rules halfway through this integration.
- Explicit execution-route override: use controller-owned `superpowers:executing-plans`. Bounded behavioral evaluation agents and independent readiness/final reviewers are required; implementation mutation stays with the controller. Use the current fork evidence/report contracts, not conflicting upstream instructions being merged.
- Risk is review-required: public helper contracts, orchestration authority, concurrent workspace identity, packaging and cross-skill invariants.
- Read `superpowers:writing-skills` before editing skill behavior. Run matched before/after behavioral scenarios. Deterministic source-text checks are wiring evidence, not behavioral proof.
- Keep all changes local until verification and review finish. Installation, publishing and remote PRs are separate downstream actions.

## Readiness record

Author self-review: complete. Added exact specification identity, execution override, task dependencies and verification ownership. Existing approved comparison decisions remain unchanged.
Independent readiness gate: READY on initial review, fresh sp_reviewer / Astra medium, 2026-09-28.

| ID | Disposition | Ruling or resolution | Evidence carried forward |
| --- | --- | --- | --- |
| R0 | READY | No supported BLOCKING or DECISION findings | readiness-review.md |

## Shared task contracts

The controller is the sole mutation owner for all tasks, including shared skill references, test runners and Git state. Each task consumes the pinned fork, upstream delta and accepted specification; produces the files/evidence named in its body. Task 1 has no dependencies. Task 2 requires Task 1; Tasks 3–5 require the merge state from Task 2 and baseline evidence before authored behavior changes. Task 6 requires Tasks 2–5; Task 7 requires the committed candidate from Task 6; Task 8 requires verified evidence and review from Task 7.

Tasks 2–5 and 7–8 are review-required for the named plan risk triggers; Task 1 and documentation-only portions of Task 6 use checkpoint-review. Changed behavior receives focused RED/GREEN proof; imported unchanged upstream implementations use their existing tests plus fork compatibility checks. Record each retained upstream behavior separately from newly authored guidance. Baseline/candidate skill samples use fresh contexts and complete applicable guidance. An all-green baseline means preserve that guidance or import an already-tested correction without claiming a new measured improvement.

Error handling: preserve in-progress work and logs on failure; investigate failed commands before accepting output. Never fabricate unavailable harness evidence. Use at most two correction rounds at the final review/evidence gate, escalating any surviving architectural conflict. Ordinary local fixes are authorized. No new external mutation is implied by skill prose.

Codebase pointers: the file decision table and comparison in this directory give all 100 upstream paths, 19 conflicts and protected fork-only areas. Exact task-local paths and acceptance cases follow.

## Task 1: Freeze inputs and verification inventory

Owner: integrator. Files: integration specification and executable plan created from this proposal; recorded skill/script inventories and evaluation manifests.

Record the accepted decisions, exact revisions, source/installed role fingerprints, maintained tests and runtime prerequisites. Record the confirmed decision to retain the written-spec path in the specification. Carry the 19 conflict paths and all 100 upstream paths forward.

Prepare behavioral baseline packets from the pinned fork before editing. The baseline must cover the same scenarios, models, effort and tools as the candidate. Record unsupported harnesses instead of treating their tests as passed.

Acceptance: each comparison decision maps to a task below and a verification lane. The original branch is unchanged and the chosen worktree contains no unrelated work.

## Task 2: Integrate upstream foundations and platform support

Owner: integrator/platform owner. Files: manifests, `.version-bump.json`, `package.json`, `index.js`, `.opencode/**`, `.hermes-plugin/**`, `.devin-plugin/**`, `.muse-plugin/**`, `hooks/session-start`, `.gitignore`, `AGENTS.md`, `CLAUDE.md`, platform docs, bump/sync scripts and platform tests.

Begin a non-fast-forward merge of the pinned upstream commit. Accept non-overlapping platform improvements and resolve canonical contributor-file migration. Preserve fork configuration, custom skill directories and deterministic portal packaging. Keep version fields consistent at the integrated upstream version; identify fork provenance with the branch and commit instead of implying the tree is an unmodified official release.

Do not create a partial merge commit while unresolved entries remain. The merge can span the next work units; their file ownership prevents competing resolutions.

Acceptance: AGENTS.md is a real file, all supported bootstrap paths reference the integrated skills, V1/V2 entrypoints remain wired, manifests parse, and new platform versions are included in bump checks.

## Task 3: Reconcile workspace and execution helper contracts

Owner: helper owner. Files: `skills/subagent-driven-development/scripts/{sdd-workspace,task-brief,review-package}`, `skills/executing-plans/scripts/{task-start,task-done}`, `tests/claude-code/test-sdd-workspace.sh`, `tests/claude-code/test-executing-plans-scripts.sh`.

Adopt collision-safe workspace ownership; preserve legacy progress only when its recorded plan agrees. Preserve multi-task briefs and exact-revision/clean-tree review checks. Reject empty and non-descendant ranges with exit 3. Keep invalid input/state at exit 2. Invoke all helper-to-helper shell calls through Bash, including the new native helpers that currently fail the stripped-mode probes.

Adapt task completion recording to the fork ledger. Passing one test command cannot assert that a required review, integration gate or final report exists. No helper may delete the workspace before finishing persists its evidence.

Acceptance: same-named plans remain isolated; equivalent path spellings reuse one workspace; foreign legacy ledgers stay untouched; single and multi-task briefs retain their contracts; rejected ranges produce no misleading package; failed tests do not record completion; every entrypoint works after copied executable bits are stripped.

Focused verification: `bash tests/claude-code/test-sdd-workspace.sh` and `bash tests/claude-code/test-executing-plans-scripts.sh`, extended with the cases above. Add the missing cases first and capture actual failures before fixes.

## Task 4: Reconcile planning, review and execution policies

Owner: workflow owner. Files: brainstorming skill and route/track references; writing-plans skill and readiness prompt; SDD skill, prompts and shared review references; executing-plans; requesting-code-review; TDD; finishing; using-superpowers and Codex mapping. Preserve the four role files unless a concrete compatibility change requires an explicitly reviewed update.

Keep one workflow family and one owner per verification lane. Add concise intent reuse, Review Focus and proportion self-review. Surface Superpowers inline execution as an explicit choice separate from Native Codex plan mode. Retain risk-based SDD cadence, two-round corrections, structured dispositions and exact-HEAD finishing recovery.

Translate unnamed-input findings into the existing evidence/authority taxonomy. Preserve specialist depth and coverage records. Reconcile TDD wording so standalone work checks the relevant suite and planned work uses its declared focused/integration/full-suite owners. Every observed failure remains visible.

Acceptance examples:

- A low-risk inline plan selected by the user runs in the controller, buys one final independent review when available, and produces the same durable finishing evidence.
- A risk-required unit uses SDD review by default. Missing typed roles select the complete generic prompt, not a skipped review.
- A concrete crash on an implied input is examined and tested; a reviewer cannot invent an unrelated feature because the spec is silent.
- An execution worker reports focused green accurately; finishing records the one complete-suite result at the handed-off revision.
- A failed finishing attempt retains producer identity and correction count across resume.
- The existing frontend packet is still required whenever visual direction shapes implementation.

Focused verification: fork policy suites and fresh behavioral samples listed below. Static test changes must reflect deliberate decisions, not simply make old assertions pass.

## Task 5: Add diagnosis and finish package compatibility

Owner: diagnostic/package owner. Files: `skills/diagnosing-superpowers/**`, its new `agents/openai.yaml` if source-owned, diagnostic test, package/sync tests, interpreter callsites in companion/writing-skills/debugging guidance, graph renderer.

Keep diagnosis read-only with path/line evidence, transcript-safe reads and explicit export/issue scope. Apply available-agent limits and the fork's model/effort policy without removing analysis dimensions. Keep diagnosis distinct from GSD; importing a skill is not permission to run it on private sessions during this merge.

Supply real metadata for the new skill and test with a realistic prior metadata seed. Verify native `hooks: {}`, all 27 skills, source metadata precedence, role-free fallback and deterministic archives. Audit new top-level platform directories in sync exclusions separately from the portal allowlist.

Acceptance: the diagnostic is discoverable; packaging with the documented seed succeeds; missing metadata has an actionable failure; both new native helpers survive mode-stripping; fork visual companion behavior remains intact.

## Task 6: Document the combined workflow and build an immutable candidate

Owner: integrator. Files: README, RELEASE-NOTES, docs/testing, platform docs, test runners and integration records.

Explain the fork's retained architecture and selective upstream adoption. Keep historical release notes accurate. Update upstream eval-lab instructions to Quorum without deleting the fork's independent Codex behavior harness or rewriting historical Drill records.

Union maintained tests and remove only obsolete references. Keep both histories' deletion of `plan-document-reviewer-prompt.md`; retain the fork's active readiness prompt. Verify all 12 fork-only skills and their supporting files.

Once every conflict is resolved and the relevant focused checks pass, create a local merge candidate. Its parents are the pinned fork and upstream commits. That commit is an evaluation input, not permission to publish. Any subsequent correction gets its own recorded revision and invalidates affected earlier evidence.

## Task 7: Run combined verification and review

Owner: integrator for tests and fixes; fresh read-only reviewer for cumulative integration review. Scope includes cleanly merged files and added files, not only conflict hunks.

The repository has no single root `npm test`. Record an explicit final suite inventory. Run each required lane against the final candidate, retaining command, exit status and logs. Existing focused results need repeating only when later changes invalidate them.

| Lane | Commands or procedure |
| --- | --- |
| Workspace/native helpers | `bash tests/claude-code/test-sdd-workspace.sh`; `bash tests/claude-code/test-executing-plans-scripts.sh` |
| Fork planning/review contracts | Run `test-lean-delivery-contracts.sh`, `test-sdd-custom-contracts.sh`, `test-custom-policy-contracts.sh`, `test-review-depth-contracts.sh`, `test-brainstorming-artifact-quality.sh`, `test-worktree-path-policy.sh` from `tests/claude-code/` via Bash |
| Frontend authority | `bash tests/claude-code/test-frontend-packet.sh`; `bash tests/claude-code/test-frontend-direction-resources.sh`; `bash tests/claude-code/test-frontend-visual-review-policy.sh`; `bash tests/claude-code/test-no-pencil-frontend-policy.sh` |
| Companion runtime and custom behavior | `npm --prefix tests/brainstorm-server test`; run `node tests/brainstorm-server/carry-forward-port-isolation.test.js` explicitly because the current package test command omits it |
| Codex package | `bash tests/codex/test-marketplace-manifest.sh`; `bash tests/codex/test-package-codex-plugin.sh`; `bash tests/codex-plugin-sync/test-sync-to-codex-plugin.sh`; inspect an archive built with the documented real metadata seed |
| Upstream additions | `bash tests/diagnosing-superpowers/test-skill-structure.sh`; `bash tests/devin/test-devin-plugin.sh`; `python3 -m pytest tests/hermes`; `bash tests/version-bump/test-bump-version.sh`; `bash tests/writing-skills/test-render-graphs.sh` |
| Bootstrap regressions | `bash tests/hooks/test-session-start.sh`; `node tests/pi/test-pi-extension.mjs`; maintained Kimi/Antigravity runners; OpenCode bootstrap, registration and session tests |
| Shell/debugging infrastructure | `bash tests/shell-lint/test-lint-shell.sh`; `bash tests/systematic-debugging/test-find-polluter.sh`; remaining maintained runner inventory from step 1 |
| Git integrity | Raw `git diff --check`, `git ls-files -u`, diff/inventory review; verify upstream ancestry and original Gamarsoft ref; confirm no generated runtime/authentication files entered the tree |

Use the repository's RTK policy when running supported high-output commands. Inspect runner prerequisites before execution. Some harness tests run real agents or require installed tooling; distinguish deterministic checks, live runs, failures and unavailable prerequisites in the report. A structure test alone does not validate diagnosis quality or a live platform integration.

For skill behavior, use the existing `tests/codex/sdd-behavior/README.md` procedure: immutable manifests, fresh contexts, matched models/effort/tools, five initial samples, scenario-matched baselines, and preserved outputs. Cover at least:

- missing/available/stale role routing;
- preflight contradictions and product versus implementation authority;
- safe batching, risk-required cadence and two-round circuit breaker;
- scope pressure and unnamed-input review without requirement invention;
- no-subagent fallback and explicit inline selection with agents available;
- frontend packet gate preservation;
- complete-suite ownership, failed-finishing recovery and durable ruling disclosure;
- compact plans retaining interfaces, risk and evidence coverage.

Add a bounded-path scenario only if that policy changes. Add diagnosis scenarios for transcript injection, cited evidence, redaction and no unrequested export before accepting changes to its dispatch behavior. Reuse existing coverage where the behavior is unchanged; do not launch an unrelated broad campaign.

Acceptance: required lanes pass or a concrete limitation is accepted before integration; candidate behavioral regressions are resolved; no supported blocking or unresolved authority findings remain. Independent review follows the existing correction budget rather than adding another repeated review system.

The exact complete-suite command is:

```bash
PATH="/tmp/superpowers-v642-tools:/tmp/superpowers-v642-test-env/bin:/tmp/superpowers-graphviz/install/bin:$PATH" bash docs/superpowers/analysis/2026-09-28-upstream-v6.4.2/verify.sh
```

The runner requires Bash, Git, Node/npm, jq, Mike Farah yq v4, Graphviz dot,
and Python with PyYAML/pytest. The temporary tools directory supplies an official,
checksum-verified yq 4.44.3 binary. The temporary Python environment provides
PyYAML and pytest. The temporary
Graphviz 16.1.0 installation was compiled from its official, checksum-verified
source package; no global installation was changed. Reproductions may supply
those dependencies on PATH instead. The companion tests use the checked-in
lockfile (`npm ci --prefix tests/brainstorm-server --ignore-scripts`). The
runner records each test group's complete log in the helper's plan workspace.
It excludes tests that launch paid live Claude/OpenCode/Drill sessions; current
Codex actor samples are recorded separately and are not equivalent to those
external platform acceptance sessions.

## Task 8: Preserve evidence and present integration

Owner: integrator. Persist the final report using the fork's finishing contract, separate the tested implementation revision from the report-only commit, and show the complete fork-to-candidate diff.

The result should prove:

- pinned upstream is an ancestor and the merge has the intended parents;
- all 27 skills are present, with no loss of the 12 fork-only skills;
- model defaults and installed-role synchronization remain correct;
- helper APIs, visual packet authority and recovery behavior match the decisions;
- testing limitations, controller rulings and follow-ups are recorded;
- the original published branch remains unchanged until integration is requested.

Install or update active skills only after the candidate is accepted. Start a fresh session to verify discovery and advertised roles. Use recoverable host-managed worktree archival when cleanup is appropriate, preserving needed ignored evidence first.

## Decision-to-verification mapping

| Decision | Delivery step | Required evidence |
| --- | --- | --- |
| Upstream ancestry and platform support | 2, 6, 8 | Merge parents, bootstrap/platform tests, version checks |
| Workspace/range/mode fixes | 3 | Behavioral shell fixtures including stripped bits and legacy collisions |
| Fork planning/SDD/review ownership | 4 | Matched behavior samples and current policy checks |
| Explicit inline choice | 3, 4 | Native helper tests, execution-route samples, independent-review reporting |
| Frontend/mobile preservation | 4, 5, 6 | Skill inventory, packet tests, runtime companion tests |
| Diagnosis/package integration | 5 | Diagnostic scenarios, actual metadata seed, archive inspection |
| Finishing and safe cleanup | 4, 7, 8 | Exact-revision report, failure/resume samples, durable rulings |

The user approved this work on 2026-09-28. Keep execution on the dedicated branch and stop before integration into the published Gamarsoft branch or installed-skill deployment.
