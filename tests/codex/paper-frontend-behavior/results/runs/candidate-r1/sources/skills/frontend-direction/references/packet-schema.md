# Frontend packet schema, version 2

`packet.json` is the machine-readable companion to `packet.md`. This reference
owns the field contract; [frontend_packet.py](../scripts/frontend_packet.py)
checks record consistency, containment and file identity. The helper never
writes a packet, runs launch commands, grants approval or certifies that a
recorded check actually ran, passed visually or worked for a person.

## Descriptor fields

| Field | Contract |
| --- | --- |
| `schema_version` | Integer `2`, with no missing-version fallback. |
| `status` | Final checks accept `approved` or `approved-with-degraded-evidence`. Unresolved work stays `required-pending` and fails finalization. |
| `revision` | Nonempty exact approved design revision. |
| `entrypoint` | `packet.md`, starting with `<!-- frontend-packet: 2 -->` on its own first line. |
| `context` | `brownfield` or `greenfield`. |
| `approval` | Matching `revision`, actual human `decision`, ISO `date` in `YYYY-MM-DD` form. Degraded status also requires `accepted_limitations`, naming every listed limitation. Recorded approval is not automatically verified authority. |
| `documents` | `screen_index: "screen-index.md"`; `inspection: "brownfield-ui-extraction.md"` for brownfield, `null` for greenfield. |
| `design_source` | `medium`: `paper`, `runtime` or `references-only`; matching `revision`; `manifest`: local JSON file under `design/`. See below. |
| `runtime_evidence` | Required `required_checks`, `checks` and `not_required_reason`. See below. |
| `targets` | Nonempty list of current scoped capture/reference objects. |
| `states` | Nonempty list of important states, setup and verification. |
| `limitations` | Specific remaining evidence/integration limits, or `[]`. |
| `files` | Every current payload path mapped to its lowercase SHA-256. Excludes root `packet.json`, root `history/`, and `.git`, `node_modules`, `__pycache__`, `.DS_Store` anywhere. All other current files, including notes and source dependencies retained as payload, are included. |

Version 1 fails with exactly:

```text
Unsupported packet schema version 1. This workflow requires version 2; historical packets are reference material only.
```

Missing and other unsupported versions also fail closed with `schema-version`.
The former source/omission fields are rejected, with no compatibility branch,
automatic conversion or migration. Leave historical packets and their original
paths byte-identical as reference material. New delivery requires independently
established v2 evidence and approval.

## Design manifest

Every manifest is a JSON object with matching `revision` and a `provenance`
file path. The provenance file records source locators, captured revision,
extraction method and relevant application source. For Paper, identify the
file, page and selected nodes. A live locator and a Paper token hash do not
identify the whole approved design. Hash the actual local payload.

For `medium: "paper"`, all these fields are required:

```json
{
  "revision": "v3",
  "provenance": "design/provenance.json",
  "structure": "design/structure.json",
  "computed_styles": "design/computed-styles.json",
  "resolved_tokens": "design/resolved-tokens.json",
  "assets": ["design/assets/logo.svg"],
  "copy": "design/copy.json",
  "component_mappings": "design/component-mappings.json"
}
```

The extraction files can use the format actually exported by the tool. Their
content must preserve extracted structure, relevant computed styles, frozen
resolved token values, required assets, exact approved visible copy with state
mapping, and application component/source mappings. `assets: []` explicitly
records that no assets are needed. Missing extraction files block finalization;
do not substitute a screenshot while claiming source recovery. Native editable
Paper file restoration is not promised by this contract.

For `medium: "runtime"`, the manifest requires `source`, using the recoverable
code shape below. Captures and runtime checks remain separate descriptor
records. A launch path alone is insufficient source recovery.

For `medium: "references-only"`, the manifest requires
`omission: {"reason": "<specific scope>", "decision": "<actual human scope choice>"}`.
This is an affirmative scope choice. It does not waive required runtime checks.
A tool failure belongs in the unavailable-evidence record and accepted degraded
scope, not an invented references-only choice.

Optional `supporting_files` lists additional local binding files, or `[]`.
Any declared extraction, asset, source or supporting path remains binding even
when included with a different medium. Additional provenance metadata belongs
in the provenance file; register every additional binding file in the defined
path fields or `supporting_files`.

## Runtime checks and records

```json
{
  "required_checks": ["actual-component-focus"],
  "checks": [{
    "id": "actual-component-focus",
    "state_ids": ["success"],
    "result": "passed",
    "record": "runtime/actual-component-focus.json"
  }],
  "not_required_reason": null
}
```

Each check has a unique nonempty `id`, nonempty unique `state_ids` naming
existing states, `result` of `passed`, `failed` or `unavailable`, and an
inventoried local JSON `record`. Every required ID resolves exactly once.
An empty required list needs a substantive `not_required_reason`, explaining
why no pre-approval runtime checks were needed for the actual scope. Keep the
field present and use `null` when checks were required.

A failed required check always blocks. An unavailable required check needs
`status: "approved-with-degraded-evidence"` and `limitation` on the check naming
the exact limitation present in both `limitations` and
`approval.accepted_limitations`. Retain its check ID, record and missing gate.
Do not remove or relabel a required failure to pass finalization. Changed
requirements or approval need actual resolution and a new handoff identity.

Each record carries these fields:

```json
{
  "check_id": "actual-component-focus",
  "state_ids": ["success"],
  "result": "passed",
  "source_revision": "<exact application source revision>",
  "handoff": {
    "checkout_build": "<absolute checkout/build; commit and dirty snapshot identity or immutable build ID>",
    "start_command_and_working_directory": "<actual command; absolute cwd>",
    "base_url_and_target_route": "<reachable implementation route or device target>",
    "readiness_check": "<confirm the intended source/build is serving and ready>",
    "authentication_and_fixture_state_setup": "<fresh-context steps; credential reference, no secrets>",
    "required_viewports_platforms": "<sizes/platforms and relevant states>",
    "server_owner_lifetime": "<owner/session/process and availability through review>"
  },
  "source": {
    "kind": "local",
    "revision": "<same application source revision>",
    "paths": ["runtime/source/relevant-component.ts"],
    "dependencies": "runtime/dependencies.txt",
    "dirty_changes": ["runtime/dirty-source.patch"]
  },
  "supporting_files": ["runtime/focus-observations.md"]
}
```

`check_id`, `state_ids` in the same order and `result` must agree with the
descriptor check. `source_revision` must agree with `source.revision`; it need
not equal the design revision when a focused actual-app slice supplies proof.
Use all seven fields from the [runtime handoff](../../implementing-frontend-design/references/runtime-handoff.md).
The source/build, dependency setup and state preparation must let an independent
reviewer establish the intended runtime. A matching URL or screenshot alone
does not prove served-source identity.

For `unavailable`, add specific `unavailable_reason` and retain all seven
handoff fields, marking unknown values pending with reasons. `source: null`
is accepted only when that unavailable check names its explicitly accepted
degraded limitation. Otherwise retain recoverable source. Optional checks
remain recorded honestly; an omission reason never suppresses required checks.

## Recoverable code

Both runtime-authored manifests and runtime records use the same `source`
object. Local source requires `kind: "local"`, nonempty `revision`, nonempty
`paths` of retained source files or archives, a `dependencies` file naming
versions and reproducible setup, and `dirty_changes` listing retained patches
or snapshots. Use `dirty_changes: []` only when there are no uncommitted edits
outside the retained source snapshot. Include enough relevant code and assets
to recover the checked slice; a pathname to a temporary checkout is not code.

Alternatively:

```json
{
  "kind": "immutable-reference",
  "revision": "<immutable commit/archive/build identity>",
  "locator": "<immutable source reference>",
  "recovery_evidence": "runtime/source-recovery.json",
  "dependencies": "runtime/dependencies.txt",
  "dirty_changes": ["runtime/dirty-source.patch"]
}
```

The local recovery JSON records the same `locator` and `revision`,
`result: "passed"` and a nonempty `method` describing the retrieval and
verification actually performed. Retain uncommitted changes locally. Optional
local `paths` remain binding with this kind too. The helper checks the recovery
record's consistency; it does not contact a remote service or verify the truth
of its claim. The producer and independent reviewer establish recoverability.

## Targets, states and file containment

Each target has unique `id`, `path` within `references/`, `intent` of
`visual-truth`, `semantic-guidance` or `reference-only`, specific `scope`, exact
`source_version`, a `state` ID, and `viewport` with positive integer `width`
and `height`. A surviving earlier reference may have a different source
version with explicit limited authority and supersession in `packet.md`.

Each state has unique `id`, concrete `setup`, `references` listing current
target IDs, and `verification` of `exercised`, `source-inspected` or
`not-exercised`. References can be `[]` for a state described by recoverable
source and setup. Every target's declared state must exist and list that
target; cross-wired state references fail. A shared capture uses a separate
target ID for each state, with explicit scope. The screen index records actual
checks and exact evidence revision; a label alone is not execution evidence.

Every local binding path, including manifests, provenance, extraction, assets,
copy, mappings, code, dependency and dirty-change files, recovery records,
check records, supporting files and targets, must exist inside the verified
inventory. Use contained relative paths without symlinks, `..`, empty path
segments or absolute paths. Excluded directories and `history/` cannot hold
binding files. External locators never exempt associated local files from
these checks. Unreferenced generated dependencies remain excluded.

## Check result and exact handoff identity

`check` exits zero only when valid and returns `valid`, `errors` with actionable
`code`/`message`, `revision` and `descriptor_sha256`. Invalid JSON, missing files,
stale hashes, added or removed current files, stale approval, inconsistent
records and unsupported versions exit nonzero. I/O failures are structured
errors. `inventory` returns the current file map, or structured errors.

The descriptor is excluded from its own inventory. Carry the producer's exact
entry, revision, descriptor hash, human approval reference, status and accepted
limits outside the packet. On consumption use `--expected-revision` and
`--expected-descriptor-sha256`, unchanged from the existing CLI. Recover the
expected bytes or resolve the mismatch; rehashing a changed descriptor does
not recover approval. Structural validity establishes consistency only.
