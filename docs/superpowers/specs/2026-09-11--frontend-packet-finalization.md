# Canonical frontend packet finalization

Status: authorized continuation of the approved frontend-direction rework. The user accepted the identified finalization gap and requested tightening for reliable implementation outcomes. Existing visual approval and historical compatibility remain in force; no new design or production DashPark work is authorized.

## Outcome

Every newly authored final packet has one predictable entry point and a self-contained current artifact set. Another agent can determine the approved revision, reproduce its important states, distinguish binding evidence from history, validate file identity, and implement with explicit acceptance criteria. File validation is separate from human approval and actual UI quality.

## Contract

New packets use `docs/superpowers/specs/<date>--<slug>--frontend/` by default, containing `packet.md`, `packet.json`, `screen-index.md`, conditional `brownfield-ui-extraction.md`, approved `prototype/`, final `references/`, and optional `history/`. Project-requested parent locations work. Existing approved packets retain their prior paths and authority; a missing new descriptor alone does not invalidate them. Canonical `packet.md` starts with `<!-- frontend-packet: 1 -->`. Canonical handoffs carry expected revision and descriptor SHA-256. The descriptor, marker, or supplied expected identity selects canonical handling; a missing, changed or unsupported descriptor then fails closed. Only inputs with none of those signals use legacy handling. A present invalid/unsupported descriptor is reported rather than silently treated as legacy.

`packet.md` is the sole human implementation entry point. It contains the brief and scope, retained constraints and approved delta, component/copy/interaction/responsive requirements, source-backed acceptance criteria, approval, runtime launch/state instructions, feasibility limits and continuation. It links evidence rather than repeating its history. `screen-index.md` maps important states and viewports to actual setup, expected behavior, references and exercised/missing verification. Brownfield inspection explicitly records source/brand constraints and freedom.

`packet.json` schema version1 supplies deterministic identity and routing: approved status/revision, matching approval record, canonical documents, prototype source and launch/state information, exact target reference IDs/intents/scopes, known evidence limits and a checksum inventory of current files. History is nonbinding and excluded from the current checksum inventory. There is no self-checksum for packet.json. An inventory command computes hashes but does not approve anything; a read-only validator checks structure, local containment, required files, file hashes, revision consistency, setup/reference coverage and current-file completeness. It does not execute commands or claim to assess design, truth of approval, or prose correctness.

The finalization recipe runs after concrete visual approval. Preserve source bytes, separate history, write the implementation contract and descriptor, recapture stale evidence from approved unchanged source where possible, check important states and mapping, validate, and hand off packet path plus exact revision/descriptor hash. Recapture or relocation alone does not require another design approval. A material design/source change does; never refresh hashes to quietly bless an unapproved revision. Missing required evidence retains pending/degraded scope according to explicit human approval.

Implementation first routes canonical versus legacy input. Canonical input requires successful validation before dependent implementation; absent runtime/tool capability is recorded, never asserted away. It then consumes and compares the actual targets. Planning/task handoffs carry the exact packet identity and acceptance references. Use the existing independent review sequence, with fixture/production limits, rather than adding an orchestration family.

## DashPark acceptance case

Normalize the already approved v2.1 Credipark bundle in its existing documentation folder. Keep original bundle files and manifest byte-for-byte in history with relocation mapping. Preserve existing README and IMPLEMENTATION entry links through short pointers or updated guidance. Keep prototype bytes unchanged. Capture current desktop/narrow reference images from the approved source where runtime is available. Do not change business behavior, visual design, production Gateway files or historical approval claims.

## Verification

Five no-guidance/current/candidate response-only samples expose shape variance and verify the finalization recipe. Preserve truthful baseline strengths. Test the real validator with valid packets and mutations: missing/stale source, unresolved status, approval/revision mismatch, missing state/reference mapping, path escape, unknown schema, and added untracked current files. Fresh forward use must read a canonical bundle and identify exact implementation inputs, reject tampered canonical evidence, and accept approved legacy image-only inputs without conversion. Use the normalized DashPark packet as a real packaging/launch case. Do not claim file validation or source assembly establishes production visual quality.
