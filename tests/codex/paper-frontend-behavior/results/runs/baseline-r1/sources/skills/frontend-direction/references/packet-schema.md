# Frontend Packet Schema — Version 1

`packet.json` is the machine-readable companion to `packet.md`. This reference owns the field contract; [frontend_packet.py](../scripts/frontend_packet.py) implements structural and file-identity checks. All paths are relative to the packet root, contained, and free of symlinks. Current source and references must be recoverable locally; launch instructions may describe required dependencies, but are never run by the validator.

## Descriptor fields

| Field | Contract |
| --- | --- |
| `schema_version` | Integer `1`. Unknown versions fail rather than becoming legacy. |
| `status` | Final checks accept `approved` or `approved-with-degraded-evidence`. Keep unresolved work `required-pending`; it cannot pass finalization. |
| `revision` | Nonempty exact approved source revision. |
| `entrypoint` | `packet.md`, starting with `<!-- frontend-packet: 1 -->` on its own first line. |
| `context` | `brownfield` or `greenfield`. |
| `approval` | Object with matching `revision`, actual human `decision`, and ISO `date` (`YYYY-MM-DD`). Degraded status also requires `accepted_limitations`, naming every listed limitation. These are recorded evidence, not automatically granted authority. |
| `documents` | `screen_index: "screen-index.md"`; `inspection: "brownfield-ui-extraction.md"` for brownfield, `null` for greenfield. |
| `prototype` | Current source object: `path: "prototype"`, local `entrypoint` within it, matching `revision`, runnable `launch_command`, and review `url`. Commands run from the packet root; document dependencies and state setup in prose. |
| `targets` | Nonempty list of current reference objects described below. Prototype behavior is bound by `packet.md` and `prototype`; targets identify its captures or other scoped image inputs. |
| `states` | Nonempty list of important state objects described below. Do not invent a state inventory from screenshots alone. |
| `limitations` | List of specific remaining evidence/integration limits, or `[]`. |
| `files` | Map of every current payload path to its lowercase SHA-256. Generate with `inventory` after writing the payload. Excludes root `packet.json`, root `history/`, and `.git`, `node_modules`, `__pycache__`, `.DS_Store` anywhere. Other current files, including notes and launch assets, are included. |

For explicitly chosen references-only work, `prototype: null` is allowed with `prototype_omission: {"reason": "...", "decision": "<actual scope choice>"}`. Missing required browser evidence instead needs `approved-with-degraded-evidence` and explicit accepted limitations; do not describe tool failure as a user scope choice. Never invent a prototype for legacy compatibility.

Each target has unique `id`, `path` within `references/`, `intent` (`visual-truth`, `semantic-guidance`, `reference-only`), specific `scope`, exact `source_version`, a `state` ID, and `viewport` with positive integer `width`/`height`. `source_version` identifies the capture/concept's actual source, so it may differ from the packet revision where a surviving earlier reference has limited authority. Record supersession and such differences in `packet.md`.

Each state has unique `id`, concrete `setup` instructions, `references` listing target IDs (may be empty for states expressed through the prototype), and `verification`: `exercised`, `source-inspected`, or `not-exercised`. Every target's state must exist and list that target in its references; every listed reference must declare that same state. For an image that applies to several states, use a separate target ID per state with the same file path and explicit scope. The screen index adds expected behavior, viewport/platform scope and precise evidence revision. “Exercised” is not a substitute for naming when and how it was checked.

Every target path and prototype entrypoint must belong to the verified `files`
inventory. They cannot live under excluded path segments, including
`node_modules`, even when the file exists. Unreferenced generated dependencies
remain excluded; record reproducible dependency setup in the launch notes.

Additional provenance fields are allowed; they do not replace required fields. Historical artifacts are excluded from current-file validation. Preserve their original manifests for separate archival checks.

## Minimal illustrative descriptor

Replace placeholders with real evidence and the complete inventory; this is not an approved packet.

```json
{
  "schema_version": 1,
  "status": "approved",
  "revision": "v3",
  "entrypoint": "packet.md",
  "context": "brownfield",
  "approval": {"revision": "v3", "decision": "<human decision>", "date": "2026-09-11"},
  "documents": {"screen_index": "screen-index.md", "inspection": "brownfield-ui-extraction.md"},
  "prototype": {"path": "prototype", "entrypoint": "prototype/index.html", "revision": "v3", "launch_command": "python3 -m http.server 8768 --bind 127.0.0.1 --directory prototype", "url": "http://127.0.0.1:8768/"},
  "targets": [{"id": "desktop-v3", "path": "references/desktop-v3.jpg", "intent": "visual-truth", "scope": "Detail workspace layout", "source_version": "v3", "state": "success", "viewport": {"width": 1280, "height": 900}}],
  "states": [{"id": "success", "setup": "Open /; select the detail launcher", "references": ["desktop-v3"], "verification": "exercised"}],
  "limitations": ["Synthetic fixture; production integration is unverified"],
  "files": {"packet.md": "<sha256; include every current payload file>"}
}
```

## Check result and identity

`check` exits zero only when valid, returning `valid`, `errors` (objects with `code` and actionable `message`), `revision`, and `descriptor_sha256`. Invalid JSON, missing files, stale hashes, added current files, inconsistent revisions and unsupported formats exit nonzero. I/O failures also return structured errors. `inventory` returns the file map on success or structured errors on failure; neither command writes files.

Pass the returned revision and descriptor hash into planning/implementation handoffs. Use `--expected-revision` and `--expected-descriptor-sha256` on consumption to detect replacement of the descriptor itself. Hashes establish byte identity; approval truth, state behavior, accessibility and visual quality still require human/source/runtime evidence.
