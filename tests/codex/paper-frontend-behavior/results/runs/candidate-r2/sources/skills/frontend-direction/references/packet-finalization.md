# Finalize an Approved Packet

Use after final design approval, including a direct request to preserve finished work. Approval of a concept leaves required runtime checks pending until they pass or the human explicitly accepts their unavailable evidence. This workflow finalizes version 2 only.

1. **Freeze authority.** Identify the exact approved source revision, human decision/date, target intents and scopes. Preserve original source, approval, manifests and drafts before relocating anything. Do not refresh hashes to bless changed source. Resolve a material design change through actual approval.
2. **Retain the selected source.** Follow the [folder contract](frontend-packet-folder-template.md). Write `design_source` and its local `design/` manifest. For Paper, retain provenance, extracted structure, computed styles, frozen resolved tokens, assets, exact copy/state mapping and component/source mappings. For runtime designs, retain the actual recoverable source. References-only work records its actual scoped omission decision. Put current captures in `references/`. Keep drafts and supersession explicit; existing historical packets stay at their original paths with unchanged bytes and reference-only authority.
3. **Write the implementation contract.** Fill [packet.md](frontend-direction-template.md) and the [screen/state index](screen-index-template.md) from actual evidence. Include component mapping, approved copy, responsive behavior, keyboard/focus rules, setup and observable acceptance. Record `runtime_evidence.required_checks`, results and local records with the seven-field runtime handoff, dependency setup and recoverable code. Distinguish final checks, inherited earlier checks, source inspection and missing proof. If no runtime checks were required, explain the scoped reason. Name production integration work left by a synthetic slice.
4. **Resolve stale or missing evidence.** Recapture desktop/narrow and important states from the unchanged approved source where available. A fresh capture of the same approved source needs no repeated design gate. Required failed checks block. Retain unavailable required check IDs and records; each needs its exact listed and explicitly accepted degraded limitation. Keep unresolved work pending. Do not label an earlier capture as the final revision or replace missing source exports with claims of source recovery.
5. **Write and check the descriptor.** Use [schema version 2](packet-schema.md). Inventory every local binding path, including all manifest extractions, assets, provenance, copy, mappings, runtime records, source, dirty changes and recovery evidence. After current payload files are final, run the bundled helper, resolving its absolute path from this skill installation:

   ```sh
   python3 <skill-dir>/scripts/frontend_packet.py inventory <packet-root>
   python3 <skill-dir>/scripts/frontend_packet.py check <packet-root>
   ```

   Put the inventory output in `packet.json.files`, then run `check`. Both commands are read-only; neither approves a design nor executes launch instructions. Correct missing/stale files against the approved record and recheck. Never refresh hashes to bless changed content. The descriptor is excluded from its own inventory; the checker returns its SHA-256 for the handoff. Keep that expected identity outside the packet in the invoking task or final response.
6. **Review quality, then hand off.** Apply the [completion checks](frontend-packet-completeness-checklist.md) and [quality review](frontend-review-checklist.md). A valid descriptor does not assess visual quality, prose completeness, honesty of approval or backend integration. Report those separately. Copy the [shared handoff record](packet-handoff.md) into the invoking workflow and every downstream review/adapter/task:

   ```text
   Frontend packet entry: <absolute packet-root>/packet.md
   Expected revision: <approved revision>
   Expected descriptor SHA-256: <check output>
   Approval reference: <actual human decision reference>
   Status and accepted limitations: <actual status and accepted limits>
   Launch/setup and acceptance: packet.md and screen-index.md
   Continuation: <design-only delivery, or already authorized implementation workflow>
   ```

For later implementation, supply these same inputs to `superpowers:implementing-frontend-design`. Do not start production work for a design-only delivery.

## Recovery and historical inputs

Every implementation handoff requires the version-2 descriptor and entry marker. Validate using the producer's supplied expectations:

```sh
python3 <skill-dir>/scripts/frontend_packet.py check <packet-root> \
  --expected-revision <revision> --expected-descriptor-sha256 <sha256>
```

Missing, changed, invalid or unsupported descriptors block dependent implementation. Recover the expected artifact or resolve the discrepancy. Version 1 fails with the exact unsupported-version message in the schema; unmarked or missing-version inputs also fail closed. Historical approvals remain part of the record and do not authorize new delivery. Leave those packets byte-identical at their original paths. New work informed by them must establish its own v2 evidence and human approval; changing a version field or copying an old approval is insufficient.
