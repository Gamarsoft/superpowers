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

- **Identity/status:** assessment-only, integration-in-progress, or integrated; fork/base/target SHAs, tag verification, remote URLs, actual merge bases, previous assessment and integration links, dirty-state limits.
- **Decision rows:** every upstream changed path, old/new names for moves, upstream purpose, current fork behavior, disposition, rationale/source, dependencies, proposed verification, and implemented status when applicable.
- **Behavior evidence:** for proposed skill changes, frozen baseline/candidate identity, scenarios, criteria, before/after observations and pressure checks. Distinguish independent sessions from cases within sessions, upstream studies from local evidence, observed regression from speculative risk, and unavailable harnesses from passes.
- **Continuity:** unresolved carry-forward items, what would reopen each, and which prior decision or source supersedes a changed recommendation.

Do not invent evaluation counts or test results while assessing. An explicit plan and an unmeasured status are valid. A new size guard that currently fails is evidence of work required; report actual failures instead of weakening the guard or silently truncating the fork to make it pass.

## Authorized integration

Use the accepted decision rows as the implementation boundary. An explicit request to integrate already grants that work; avoid asking for approval of routine choices again. If selection remains materially ambiguous, complete the reviewable comparison first and ask only about that ambiguity.

Create or reuse the authorized integration branch. For a history-preserving merge, resolve upstream and fork content together, retaining deliberate rejected/deferred content while recording its disposition. Do not replace an entire file with one side merely because the merge is clean or the release is small. Reconcile new references with fork review limits, role settings and helper semantics; union meaningful tests.

For new wording, follow the invoked authoring skills' failure-first and matched-evaluation requirements. Freeze the governing workflow before editing it, so a changed instruction does not silently move this session's verification gates. Preserve raw outputs, source identities, scoring and limits. All-green baselines do not prove a local improvement; follow the authoring skill's stop/clarification rule unless the user explicitly requested the particular change.

Choose tests from the actual affected groups. Read prior integration runners as examples, then inspect the current suites: a historical suite count or hardcoded list cannot establish coverage today. Run focused regressions, link/caller checks for relocations, and applicable packaging/version checks. Record unavailable process inspection, Windows or live-harness prerequisites as limits; do not change assertions just to work around the environment. For a release-wide integration, use the repository's current review and finishing workflow to establish cumulative review and final suite ownership.

Before recording completion, reconcile implemented decisions with the final tree, inspect the complete fork-relative diff, confirm no unresolved index entries, and verify the agreed upstream ancestry. Preserve an execution report tied to the exact tested implementation commit; a later report-only commit is a different identity. Record whether the integration branch was left local, merged, pushed or deleted, without claiming operations that were not performed.

Merging to `gamarsoft`, pushing and opening a PR follow existing user authorization separately from local integration. Fork-specific synchronization is not an upstream contribution. Any upstream PR must independently meet current repository contribution rules; this maintenance skill grants no exception.
