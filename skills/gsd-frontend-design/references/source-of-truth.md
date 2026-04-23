# Source of Truth

Read this before planning, designing, or changing UI code.

## Precedence order

Use the strongest available source in this order.

### Functional contract

1. **Approved spec, approved handoff, and acceptance criteria**
2. **Current product behavior** when the spec is silent

### Visual contract

For brownfield work, think in layers instead of only a flat ranking:

1. **Existing product UI and design system** as the baseline system truth
2. **Approved frontend direction packet** for the intentional in-scope change
3. **`pencil-workset.md`, `brownfield-ui-extraction.md`, and `screen-index.md`** as the packet’s implementation evidence
4. **Relevant `.pen` files** in `design/pencil/` or packet-linked paths
5. **Retained screenshots, browser captures, or Pencil exports** that the packet treats as binding evidence
6. **Existing component library, tokens, and app-shell conventions**
7. **Pencil skills and this skill’s implementation-quality references**
8. **Freeform invention** only for genuinely unspecified gaps

Later items do not overrule earlier items without an explicit reason.

## Brownfield baseline rule

If no durable frontend packet or `.pen` baseline exists yet for the changed screen, treat retained browser evidence from the running app as mandatory input.

Do not rely on code-only visual inference for:

- spacing rhythm
- shell hierarchy
- responsive breakpoints
- empty/loading/error state treatment
- action placement
- density and scan path

## Pencil skill rule

`pencil-design-core` and any stack adapter are **interpretation tools**.
They help you consume and translate the approved evidence.
They do not outrank the packet, the `.pen` files, or the current product system.

## What to extract before coding

Capture these before you edit code:

- linked spec, route, flow, or slice scope
- the affected screens or components
- chosen direction for each key screen
- responsive contract
- state coverage
- accessibility constraints
- **Must preserve**
- **May adapt**
- **Explicit no-gos**
- the exact `.pen` files and screenshots that are in scope
- which Pencil skills should be loaded
- verification plan

## Brownfield rule

Brownfield default is preservation.

Preserve unless the packet explicitly changes them:

- navigation patterns
- shell structure
- tokens and spacing rhythm
- component APIs and affordances
- copy conventions and interaction expectations
- operator density when the screen is operationally dense

## When sources disagree

### Packet vs current code
1. Check whether the packet intentionally calls for a change.
2. Check whether the current code pattern is a system rule or just a local inconsistency.
3. Prefer the packet for intentional new direction inside the approved scope.
4. Prefer the existing system when the packet is silent.
5. Use the `.pen` file or retained screenshot to resolve ambiguity before guessing.
6. If the conflict remains material, surface it instead of silently choosing.

### `.pen` file vs current code
1. Confirm that you opened the correct `.pen` file for the current task.
2. Check whether the `.pen` file expresses a local screen change or a shared system pattern.
3. If it is a local screen change, implement the in-scope change while preserving shared system rules.
4. If it looks like a system-wide pattern change but the packet does not authorize it, do not expand the change silently.
5. Record any mismatch that should trigger a packet or workset refresh.

### Stack adapter vs repo reality
1. The adapter may suggest a translation pattern.
2. If that pattern conflicts with the repo’s proven shared primitives, prefer the repo.
3. If the adapter exposes a repeated repo weakness, improve conservatively instead of redesigning broadly.

### HTML companion artifact vs `.pen` file
1. The HTML companion is a temporary decision surface.
2. Once the chosen direction is translated into `.pen` files or packet prose, the durable Pencil artifacts win.
3. Do not implement directly from stale HTML companion screens when the packet and `.pen` workset already converged.

## Degraded mode

If no packet or no relevant `.pen` file exists, say so explicitly.

Then use, in order:

- existing product UI
- existing component library and tokens
- current browser captures or screenshots
- this skill’s reference files

Keep invention conservative and avoid accidental redesign.

## Deviation rule

If you must deviate from the packet, the workset, or the current system, record:

- what changed
- why the original direction could not be implemented as written
- whether the deviation is visual only or behavior-affecting
- whether `.pen` files or retained screenshots were consulted
- which Pencil skills were loaded
- whether the packet or workset should be updated after implementation
