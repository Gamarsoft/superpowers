# Gamarsoft and upstream v7.0.1 comparison

2026-10-27. **Assessment only:** this agent changed no repository files, refs, index or versions and performed no integration or publication.

## Recommendation

Integrate selectively. Adopt the diagnostic/contribution updates and adapt watcher-test waits. Apply reference extraction to the fork’s two oversized skills, preserving current behavior. Most of upstream’s brainstorming retune—inspect context, use grounded questions/options, and write a design—is already present.

Reject the four incompatible SDD reference payloads; defer its other extraction until a fork failure or growth justifies it. Upstream’s five-round correction policy, simpler status/ledger schema and workspace deletion before finishing contradict this fork. Defer the seventeen historical-plan deletions to an archive/caller decision: one still has a live fork-only test reader.

The [64-row ledger](file-decisions.md) covers every helper record, including **5 renames and 18 deletions**: 28 adopt, 10 adapt, 21 defer, 1 already-present and 4 reject. These are proposed dispositions, all **unimplemented**. Ten records overlap fork changes; no merge preview was run, so this is not a conflict count or safety metric.

## Verified inputs

| Fact | Identity |
| --- | --- |
| Fork HEAD | `6bd5a431939b0b05eb94d8749a3d9c3fc8781a1f` |
| Discovered fork remote | `gamarsoft` → `https://github.com/Gamarsoft/superpowers.git` |
| Discovered upstream remote | `origin` → `https://github.com/obra/superpowers.git` |
| Last assessed release / delta base | v7.0.0: `bb92a77741419a4ab5f06e711a283343f1ada0c3` |
| Target | v7.0.1: tag object `cfd50a286baea35041505ed068c878d389ca9f7f`, peeled commit `2ce8aa15d05bd57213e6f746f953aafb7ded7a8b` |
| Remote verification | Both local v7.0.0/v7.0.1 tag objects and peeled commits match `git ls-remote origin`; no fetch or tag movement needed |
| Actual fork/target merge base | Only `bb92a77741419a4ab5f06e711a283343f1ada0c3`; target is not an ancestor of fork |
| Last integration | `638657926d42f9a8c7fe14ffbf09af322fd2e518`, with parents `7d5c52b7…` and v7.0.0 `bb92a777…` |
| Historical tested implementation / report | `2011478a8c7fea1b2f9b6655a8396b6e39980988` / `9fe25c61535f7867cbc9555610adc070b70ec9f7` |
| Later fork authority | `6bd5a431…` adopts Paper frontend/v2 packet and runtime-evidence contracts |

[Identity evidence](identity.json), [unmodified helper inventory](inventory.json), [pinned release diff](https://github.com/obra/superpowers/compare/bb92a77741419a4ab5f06e711a283343f1ada0c3...2ce8aa15d05bd57213e6f746f953aafb7ded7a8b), [source hashes](source-records.json). The tag’s release notes date v7.0.1 October 21, 2026; the delta is 927 insertions and 14,379 deletions. Remote matching is not a signature or GitHub release-object audit.

The prior [comparison](https://github.com/Gamarsoft/superpowers/blob/6bd5a431939b0b05eb94d8749a3d9c3fc8781a1f/docs/superpowers/analysis/2026-10-13-upstream-v7.0.0/comparison.md), [decisions](https://github.com/Gamarsoft/superpowers/blob/6bd5a431939b0b05eb94d8749a3d9c3fc8781a1f/docs/superpowers/analysis/2026-10-13-upstream-v7.0.0/file-decisions.md), integration notes and [execution report](https://github.com/Gamarsoft/superpowers/blob/6bd5a431939b0b05eb94d8749a3d9c3fc8781a1f/docs/superpowers/execution-reports/2026-10-13-upstream-v7.0.0-2011478a8c7f.md) were read and reconciled against Git/current sources. The historical report’s 36-group result does not verify this assessment or a new candidate. No chat was referenced by this request; historical chat claims were checked through committed records rather than retrieving unrelated chats.

The checkout had unrelated edits at intake. The controller subsequently staged its skill/packaging work and changed the branch while keeping HEAD pinned. All assessment content and probes exclude those working/index changes. [Recorded dirty-state observations](identity.json) preserve the boundary; no sibling evaluation cases or outputs were read.

## Concrete findings

The unmodified upstream size guard ran against frozen SKILL.md snapshots:

| Source | Brainstorming | Writing-skills | SDD | Executing-plans | Result |
| --- | ---: | ---: | ---: | ---: | --- |
| Fork, 27 skills | 28,279 B | 26,636 B | 19,103 B | 9,328 B | Exit 1: first two exceed the under-20,000-byte limit |
| Target, 15 skills | 13,602 B | 16,738 B | 19,506 B | 18,103 B | Exit 0 |

[Commands, hashes and results](size-probes.json). No threshold or scope was weakened. Extracting writing-skills alone leaves brainstorming failing. Size reduction is measurable; improved real compaction behavior is not established.

The writing-skills moves require fork-only plan/milestone locator updates and preservation of the fork’s single review-gate wording in the new discovery reference. The deleted worktree-rototill plan is read by [test-worktree-path-policy.sh:13](https://github.com/Gamarsoft/superpowers/blob/6bd5a431939b0b05eb94d8749a3d9c3fc8781a1f/tests/claude-code/test-worktree-path-policy.sh#L13); its negative grep checks can pass when the input is missing. Preserve the plan or migrate that reader with an existence check. See [dependency evidence](dependency-scan.json) and [source findings](source-findings.md).

Retain current Paper composition, actual-component proof, exact v2 packet identity, independent runtime recapture, conditional attributed research, one reviewer, effective role-TOML authority and exactly one confirmed delivery route. Keep all fork-specific companion tests, all 27 Muse skills and the official-versus-fork install distinction. Diagnostic form deletion and fallback URL changes must land together.

## Carry-forward decisions

| Earlier decision | Current disposition |
| --- | --- |
| Short written spec instead of chat-only small work | Already present; upstream now converges on short written designs. The old shortcut proposal no longer describes v7.0.1. Do not remove fork review/routing. |
| Scoped automatic decision research | Preserve; reopen on a concrete cost/quality failure, not simply upstream’s permission wording. |
| Blanket opt-out | Do not import automatic downstream gate removal; explicit user scope still governs. |
| Disposable spike lane | Still deferred; reopen with learning question, isolated output, stop/retention boundary and matched evaluation. |
| Builder lens | Already adapted into the same fork reviewer; no extra reviewer or budget. |
| Frontend medium | Later Paper/v2 source supersedes the older report’s companion model; explicit medium requests keep their scoped override. |
| Historical plan retention | Defer deletion until archive provenance and caller handling are explicit. |
| Windows / live external-harness acceptance | Still unmeasured here; tag verification and old structural tests do not close it. |

## Verification and limits

[The before/after plan](evaluation-plan.md) freezes the current fork, requires an immutable future candidate, matched source wrappers/settings, fresh repeated sessions, retained traces and realistic pressure cases for each proposed behavior change. Baseline passes must be reported as preservation or clarification. Upstream’s reported 24/24→3/24 document-skip example is not a fork measurement. The ledger gives affected deterministic checks and dependency closure per path.

Only source/history/dependency inspection, remote tag checks, helper inventory generation and the two isolated size-guard executions ran. There is no integrated candidate, behavioral campaign, watcher runtime test, packaging run, complete suite, browser acceptance or external post. `evals/` is absent. Historical plans were inspected for purpose and tracked callers, not audited line by line as current executable plans. Real compaction and reference-retrieval behavior remain unmeasured. This is ready for selecting integration scope, not an integration-completion claim.
