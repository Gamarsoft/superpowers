# Bounded Paper library upkeep

The library helps relevant feature work reuse verified design. It is a navigation and freshness record, not another approval authority or synchronization service. Keep maintained entries, feature drafts and immutable approved snapshots distinct, even when they share a Paper file.

## Scope at task start

Record initial coverage and the maintenance allowance in the existing task brief. Use `docs/design/paper/library.json` unless a suitable project record already owns this information. Ordinary scoped upkeep needs no extra project-wide approval ceremony.

| Context | Useful initial coverage |
| --- | --- |
| Greenfield | Approved brief, chosen stack, minimal foundation and components needed by the first flow. Establish a real app baseline through an early working slice. |
| Small brownfield | Relevant tokens, common components and representative screens justified by expected reuse. |
| Large brownfield | Touched screens and relevant shared components; expand through real feature work. |

Never invent a full catalog, palette or unsupported API to populate the library. A proposed greenfield component is not implemented until it exists and is verified. Mechanical local fixes stay in code; update an entry only if its represented UI changed. No per-chat-turn, per-commit or backend-only sync, full-product backfill, watcher or continuous two-way synchronization.

Read the current app/source, tokens, affected entries and current v2 approval evidence. Compare their recorded source/design revisions with current versions. Inspect relevant shared dependencies; unrelated code changes do not invalidate every entry. If a shared token/component changes, check affected uses relevant to the task and mark other dependent entries `needs-review` when validity is unknown. Updating one consumer never marks all consumers checked.

Refresh the relevant baseline within the allowance. If refresh must wait, work from directly inspected app/source evidence and keep the entry pending. Missing mappings or no traceable baseline means `unknown`. Preserve manual organization, draft proposals and unaffected edits. Before mutation retain a checkpoint; if code and Paper both changed, compare each with the last recorded baseline, preserve non-conflicting changes and reopen only an unresolved affected decision. Last-writer-wins is not reconciliation.

## Record shape and identity

Use an `entries` list. Each entry has a stable `id`, `kind`, scoped Paper locators, source/dependency mappings, exact approved packet identity, design and implemented revisions, `freshness`, `last_verified` and `pending`. Include last checked source/date, verification evidence, accepted differences and coverage limits in the existing record. The approved packet link carries its exact entry/revision/descriptor hash and approval reference; the library does not create a parallel approval history.

This abbreviated before/after example shows a deferred update after verified application revision `app-42`. Existing source mappings, locators and packet identity stay in the full entry:

```json
{
  "before": {
    "id": "branding.preview",
    "design_revision": "paper-7",
    "implemented_revision": "app-40",
    "freshness": "checked",
    "last_verified": {
      "revision": "paper-7",
      "source": "app-40",
      "evidence": "evidence/preview-app-40.md"
    },
    "pending": null
  },
  "after": {
    "id": "branding.preview",
    "design_revision": "paper-7",
    "implemented_revision": "app-40",
    "freshness": "needs-review",
    "last_verified": {
      "revision": "paper-7",
      "source": "app-40",
      "evidence": "evidence/preview-app-40.md"
    },
    "pending": {
      "change": "Reflect verified app-42 preview wrapping",
      "reason": "Maintenance allowance reached",
      "intended_verified_application_revision": "app-42"
    }
  }
}
```

`last_verified` retains revision, source and evidence unchanged until reconciliation is actually verified. Do not stamp new application identities onto stale or partially edited artwork. Partial/draft canvas edits remain unverified with the checkpoint retained. New entries have explicit `last_verified: null`, `freshness: "unknown"` and a pending reason stating that no verified baseline exists. Draft, approved and implemented states are separate; importing artwork or adding an index row proves none of them.

## Reconcile and stop

After meaningful UI verification, reconcile only affected maintained entries from the verified implementation. Record actual source identity, evidence and accepted adaptations; retain the original immutable approval snapshot. Small fidelity corrections stay in the app when they satisfy the contract. Changed hierarchy, interaction, token meaning, component API or material treatment reopens only the affected design decision and needs a new approved revision where required. Never normalize unapproved drift into the library.

Stop housekeeping when the agreed allowance is reached or further work would exceed it. If overrun is discovered mid-update, stop on discovery. Record each remaining change, reason, intended verified application revision and unchanged last verified revision/source/evidence. Do this minimum pending/freshness recording even when Paper is unavailable. Broader catch-up is a separate task or later use of the entry.

Pending housekeeping does not block an otherwise verified application delivery. Report app verification and library upkeep separately. The stopping rule cannot waive application tests, design fidelity, exact approval identity, required evidence or unresolved design/behavior defects.

## Evaluation and adoption

Keep candidate workflow status until regression and fresh-session behavior checks pass and a real pilot demonstrates the full v2 path, actual scoped library reconciliation, acceptable implementation fidelity and useful maintenance within the agreed effort. Measure setup, Paper iteration, export/handoff, implementation corrections and upkeep separately. Time spent alone is not useful coverage; name the reconciled entries and evidence. Report export friction, repeated screen authoring, manual repairs and pending work honestly.

An incomplete pilot, unproved reconciliation, failed required checks or impractical upkeep retains candidate status. Correct or narrow the workflow and rerun affected checks. Additional pending housekeeping may coexist with adoption once bounded reconciliation and the other criteria are met. Verified app delivery may precede workflow adoption. One screen does not establish long-term savings or general usability improvement; record unmeasured claims. Default activation is a separate evidence-based decision, never an automatic consequence of passing scripts.
