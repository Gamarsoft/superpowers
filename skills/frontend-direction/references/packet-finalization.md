# Finalize an Approved Packet

Use after final design approval, including a direct request to preserve finished work. Approval of a concept alone still leaves the interactive direction pending when that loop is required. Existing approved legacy packets can be consumed without this conversion.

1. **Freeze authority.** Identify the exact approved source revision, human decision/date, target intents and scopes. Preserve original source, approval, manifests and drafts before relocating anything. Do not refresh hashes to bless changed source. Resolve a material design change through actual approval.
2. **Separate current work from history.** Follow the [folder contract](frontend-packet-folder-template.md). Put only current approved source in `prototype/` and current references in `references/`. Retain earlier versions, images, prompts, manifests and the original packet together under `history/`; record old-to-new locations and supersession. History has no current acceptance authority unless a specific artifact is copied into the current references with explicit surviving scope.
3. **Write the implementation contract.** Fill [packet.md](frontend-direction-template.md) and the [screen/state index](screen-index-template.md) from actual evidence. Include component mapping, approved copy, responsive behavior, keyboard/focus rules, setup and observable acceptance. Distinguish checks on the final version, inherited earlier checks, source inspection and missing proof. Name real production integration work left by a synthetic prototype.
4. **Resolve stale captures.** Recapture desktop/narrow and important state evidence from unchanged approved source where available. Relocation or a fresh capture of the same approved source needs no repeated design gate. If required evidence cannot be obtained, record the limit and use only the explicitly approved degraded scope; otherwise keep the packet pending. Do not label an earlier capture as the final revision.
5. **Write and check the descriptor.** Use [schema version 1](packet-schema.md). After current payload files are final, run the bundled helper (resolve its absolute path from this skill installation):

   ```sh
   python3 <skill-dir>/scripts/frontend_packet.py inventory <packet-root>
   python3 <skill-dir>/scripts/frontend_packet.py check <packet-root>
   ```

   Put the inventory output in `packet.json.files`, then run `check`. Both commands are read-only; neither approves a design nor executes launch instructions. Correct missing/stale files against the approved record and recheck. The descriptor is excluded from its own inventory; the checker returns its SHA-256 for the handoff. Keep that expected identity outside the packet in the invoking task or final response.
6. **Review quality, then hand off.** Apply the [completion checks](frontend-packet-completeness-checklist.md) and [quality review](frontend-review-checklist.md). A valid descriptor does not assess visual quality, prose completeness, honesty of approval or backend integration. Report those separately. Return to the original workflow/scope with:

   ```text
   Entry: <absolute packet-root>/packet.md
   Revision: <approved revision>
   Descriptor SHA-256: <check output>
   Status and approval: <actual decision and any accepted limits>
   Launch/setup and acceptance: packet.md and screen-index.md
   Continuation: <design-only delivery, or already authorized implementation workflow>
   ```

For later implementation, supply these same inputs to `superpowers:implementing-frontend-design`. Do not start production work for a design-only delivery.

## Recovery and legacy routing

The presence of `packet.json`, the `<!-- frontend-packet: 1 -->` entry marker, or an expected revision/descriptor identity selects canonical handling. Validate using supplied expectations:

```sh
python3 <skill-dir>/scripts/frontend_packet.py check <packet-root> \
  --expected-revision <revision> --expected-descriptor-sha256 <sha256>
```

Missing, changed, invalid or unsupported canonical descriptors block dependent implementation. Recover the expected artifact or resolve the discrepancy; do not erase the marker or switch to legacy to pass. Only inputs with none of those canonical signals use the legacy intent/approval checks. A previously approved image-only packet remains usable without inventing prototype evidence.
