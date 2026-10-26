# Frontend packet handoff record

Copy this record unchanged from the producing handoff into the upstream spec,
selected-adapter review, selected delivery adapter and implementation task.
Use the resolved entry path; do not reconstruct a filename from a slug.

```text
Frontend packet entry: <absolute resolved entry path>
Expected revision: <approved revision>
Expected descriptor SHA-256: <validated descriptor hash from the producing handoff>
Approval reference: <actual human decision reference>
Status and accepted limitations: <status; exact scope and accepted limits>
```

Version-2 packets use `...--frontend/packet.md` with sibling `packet.json`. Keep this
record outside the packet payload so its descriptor hash has no circular
dependency. The producer follows [finalization](packet-finalization.md).

For approved version-2 inputs, all fields are required at selected-adapter and
implementation handoffs. Recover missing expectations from the producing
handoff; calculating a new hash from a candidate packet does not recover the
expected identity. The receiver checks both expectations before dependent work.
Carry the approval reference and limitations as well as the hash. Identity
does not establish approval, actual execution or visual quality. Keep the
same design_source manifest and runtime_evidence records bound to that identity;
do not reconstruct them from a mutable Paper locator or an ephemeral checkout.

```sh
python3 <skill-dir>/scripts/frontend_packet.py check <packet-root> \
  --expected-revision <revision> --expected-descriptor-sha256 <sha256>
```

Missing expectations or invalid/unsupported packets block dependent work.
Version 1 returns the exact unsupported-version message in the
[schema](packet-schema.md); missing versions never select a fallback.

Before direction is complete, record `required-pending` and the follow-on
prompt; do not invent paths, revisions, hashes or approval. `not-required` uses
an explicit not-applicable record. Historical packets keep their original
paths, bytes and historical approvals as reference material only. They cannot
authorize a new delivery. Establish current v2 evidence and approval without
migration, automatic conversion or a legacy handoff branch.
