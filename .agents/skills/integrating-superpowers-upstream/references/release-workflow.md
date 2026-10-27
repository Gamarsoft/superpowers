# Release workflow for this fork

## Locate current authority

Run from the repository root. Read `AGENTS.md`, current remote URLs and working state. Locate the latest relevant entries under `docs/superpowers/analysis/`, `docs/superpowers/plans/`, and `docs/superpowers/execution-reports/`. A comparison can be newer than the last completed integration. Resolve that distinction from recorded status and Git history, not filenames alone.

Inspect later fork commits and affected current sources. Useful anchors are:

| Contract | Current source to inspect |
| --- | --- |
| Written specs, research evidence, confirmed delivery route | `skills/brainstorming/SKILL.md` and its research/routing references |
| Frontend approval and runtime evidence | `skills/frontend-direction/` and `skills/implementing-frontend-design/` |
| Review ownership, correction limits, exact-revision verification | `skills/subagent-driven-development/`, `skills/executing-plans/`, `skills/finishing-a-development-branch/` |
| Model and effort authority | `.codex/agents/*.toml` and `skills/using-superpowers/references/codex-tools.md` |
| Fork distribution and version inventory | README fork section, plugin manifests, `.version-bump.json`, packaging scripts/tests |

For example, the v7.0.0 integration predates the Paper frontend workflow. Preserve the current approved design/runtime contract rather than restoring the older companion composition model. Do not freeze a tool, model, number of review rounds, or historical deferral forever: check whether newer authorized changes supersede it.

## Establish immutable inputs

Use the configured upstream URL to verify a named release and its tag. A release page explains intent; the tagged tree defines the comparison. Peel annotated tags with `git rev-parse 'TAG^{commit}'` and compare with `git ls-remote UPSTREAM refs/tags/TAG 'refs/tags/TAG^{}'`. If missing locally, fetch the exact tag without resetting the checkout. If identities conflict, retain the discrepancy and resolve it before claiming a verified target; do not force-move an existing tag.

Record fork HEAD and working-tree differences separately. A dirty tree is not a clean baseline. Read-only comparison can proceed; implementation must preserve unrelated work using the user's authorized branch/checkout arrangement.

Choose the last **assessed** upstream commit for the new release delta, with its evidence. Also retain the last **integrated** release and all deferred/rejected/adapted items still relevant. `merge-base` describes ancestry. A selective merge, `-s ours`, cherry-pick, or manifest version does not establish adopted behavior. When no reliable prior record exists, reconstruct it from merge parents and source comparisons, marking uncertainty instead of guessing a release label.

Generate the inventory with the bundled standard-library helper; it only reads Git and writes JSON to stdout:

```bash
python3 .agents/skills/integrating-superpowers-upstream/scripts/release_inventory.py \
  --repo . --fork HEAD --base v7.0.0 --target v7.0.1 > /tmp/superpowers-release-inventory.json
```

Those tags illustrate an invocation; choose the verified inputs for the current request. The helper resolves commit IDs and reports merge bases, rename/deletion records, and overlaps with fork changes. It does not verify remote tags, select the baseline, preview a merge, inspect uncommitted contents, or determine semantic compatibility. Record the remote evidence alongside its output.

Inspect `git diff BASE TARGET -- PATH` and the corresponding fork content. Review changed groups in dependency order. For renamed or deleted files, search both old paths and basenames in current callers, tests, scripts, templates, links, and packaging. Inspect relevant fork-only dependencies, even when Git reports no conflict. A merge preview, if useful, should run without changing the user's index or worktree, using a temporary object store or disposable clone.

## Durable comparison contract

Save evidence under `docs/superpowers/analysis/YYYY-MM-DD-upstream-VERSION/` (or the existing directory for an ongoing assessment). Keep the summary brief and the decision ledger exhaustive. Reuse the repository's existing formats where practical.

Required record:

- **Identity/status:** assessment-only, awaiting-proposal-approval, approved, integration-in-progress, or integrated; fork/base/target SHAs, tag verification, remote URLs, actual merge bases, previous assessment and integration links, dirty-state limits. Record proposal path/revision, the explicit approving user message, and exactly what it covers; leave approval pending until received.
- **Decision rows:** every upstream changed path, old/new names for moves, upstream purpose, current fork behavior, disposition, rationale/source, dependencies, proposed verification, and implemented status when applicable.
- **Behavior evidence:** for proposed skill changes, frozen baseline/candidate identity, scenarios, criteria, before/after observations and pressure checks. Distinguish independent sessions from cases within sessions, upstream studies from local evidence, observed regression from speculative risk, and unavailable harnesses from passes.
- **Continuity:** unresolved carry-forward items, what would reopen each, and which prior decision or source supersedes a changed recommendation.

Do not invent evaluation counts or test results while assessing. An explicit plan and an unmeasured status are valid. A new size guard that currently fails is evidence of work required; report actual failures instead of weakening the guard or silently truncating the fork to make it pass.

## Integration proposal and approval

Turn the recommendations into a concrete proposal, save it with the assessment, and present its substantive contents to the user before any integration changes. A generic offer to integrate or a link to a file alone does not provide a reviewable proposal. Include:

- Proposal identity/revision and the pinned fork/base/target release inputs.
- Selected change groups and affected paths, intended adopt/adapt behavior, dependency/caller updates, and fork contracts to preserve.
- Explicit exclusions and deferred/rejected changes, with reasons.
- Focused tests, before/after evaluations for changed skill guidance, applicable review/finishing checks, known risks and unmeasured limits.
- Proposed checkout/branch and ancestry strategy; intended local merge, push destination or PR scope, identifying any operation not requested.

If nothing is worth adopting, propose retaining the current fork and explain why. Otherwise ask for explicit approval of the identified proposal and stop before applying it. A clear user reply accepting that presented proposal counts; an initial “integrate,” old release approval, tool permission, teammate assertion, silence or timeout does not. Do not promise to proceed unless the user objects or start background implementation while awaiting the answer.

Before approval, inspect sources, fetch missing exact tags, write analysis/proposal artifacts and perform isolated read-only previews or frozen-source probes. Do not create an applied integration candidate by editing, staging, merging, cherry-picking or rebasing upstream changes, even on a draft branch or worktree. Approval gates upstream integration; it does not block preparing the evidence needed for the decision.

After a recorded explicit approval, continue the same proposal without asking again on resume or for routine fixes within its scope. If new evidence changes the selected behavior, adds changes or changes release inputs, present the revised proposal and wait for approval before that changed work. Keep unapproved additions deferred; independent work already covered by the unchanged approval can continue. Approval covers only the presented scope and does not expand publication permission.

## Authorized integration

Use the explicitly approved proposal and its decision rows as the implementation boundary. Confirm its inputs and approval record still match before applying changes.

Create or reuse the authorized integration branch. For a history-preserving merge, resolve upstream and fork content together, retaining deliberate rejected/deferred content while recording its disposition. Do not replace an entire file with one side merely because the merge is clean or the release is small. Reconcile new references with fork review limits, role settings and helper semantics; union meaningful tests.

For new wording, follow the invoked authoring skills' failure-first and matched-evaluation requirements. Freeze the governing workflow before editing it, so a changed instruction does not silently move this session's verification gates. Preserve raw outputs, source identities, scoring and limits. All-green baselines do not prove a local improvement; follow the authoring skill's stop/clarification rule unless the user explicitly requested the particular change.

Choose tests from the actual affected groups. Read prior integration runners as examples, then inspect the current suites: a historical suite count or hardcoded list cannot establish coverage today. Run focused regressions, link/caller checks for relocations, and applicable packaging/version checks. Record unavailable process inspection, Windows or live-harness prerequisites as limits; do not change assertions just to work around the environment. For a release-wide integration, use the repository's current review and finishing workflow to establish cumulative review and final suite ownership.

Before recording completion, reconcile implemented decisions with the final tree, inspect the complete fork-relative diff, confirm no unresolved index entries, and verify the agreed upstream ancestry. Preserve an execution report tied to the exact tested implementation commit; a later report-only commit is a different identity. Record whether the integration branch was left local, merged, pushed or deleted, without claiming operations that were not performed.

Merging to `gamarsoft`, pushing and opening a PR follow existing user authorization separately from local integration. Fork-specific synchronization is not an upstream contribution. Any upstream PR must independently meet current repository contribution rules; this maintenance skill grants no exception.
