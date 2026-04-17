# Pencil Tooling Modes

Use this when you need to choose between Pencil MCP and Pencil CLI or when you need a concise CLI reminder inside the live skill set.

## Core rule

The `.pen` files are the durable design truth.
MCP and CLI are only transport layers for reading, editing, exporting, or validating those artifacts.

## Transport preflight

Before relying on Pencil CLI, confirm the environment is usable:

```bash
pencil version
pencil status
```

Runtime notes:

- Pencil CLI expects a working Node.js 18+ runtime
- `pencil version` should succeed before you assume the transport is available
- `pencil status` should confirm authentication before you start a headless design loop

Authentication notes:

- `pencil login` creates a stored CLI session for interactive local use
- `PENCIL_CLI_KEY` is the preferred CI or headless credential and overrides a stored session when both exist
- the local CLI session is stored at `~/.pencil/session-cli.json`
- if CLI auth is broken, do not fake progress with screenshots alone; fall back to MCP only if the session is actually stable

Useful environment variables:

- `PENCIL_CLI_KEY` for CI or headless auth
- `PENCIL_API_BASE` when a custom backend endpoint is required
- `DEBUG` for extra CLI debug logging

## Choose the transport

### Prefer Pencil MCP when

- you are in a stable local session
- direct document manipulation is available and responsive
- you need fine-grained interactive edits in the current editor session

### Prefer Pencil CLI when

- you are in GSD-2
- the environment is headless or session-isolated
- Pencil MCP is flaky or unavailable
- you need deterministic export or scripted reads

## CLI mode for this workflow

In the active GSD and Pencil skills, use Pencil CLI interactive mode only.
Do not use Pencil CLI agent mode in this workflow.

### Use CLI interactive mode when

- you need the same tool-level operations as MCP in a headless session
- you want deterministic read/edit/export steps
- you need to inspect nodes, variables, screenshots, or layout problems before choosing the next edit

Examples:

```bash
pencil interactive -o output.pen
pencil interactive -i input.pen -o output.pen
```

Persistence rule:

- do not rely on in-place headless writes to the same path for both input and output
- prefer reading from `input.pen` and saving to a distinct `output.pen`
- after verification, replace the original file deliberately outside the interactive session if needed
- if headless `save()` still produces an empty or corrupt output file, treat that session as degraded and do not continue mutating the original `.pen` blindly

Attach to a stable running app only when that specific session is the intended source:

```bash
pencil interactive -a desktop -i current.pen
pencil interactive -a vscode -i current.pen
```

Interactive reminders:

- call the same tool names you would use through MCP, without the `pencil_` prefix
- in headless mode, call `save()` before exit or your changes are not written
- use app mode only when you intentionally want to connect to a stable running Pencil app or extension
- shell syntax is `tool_name({ key: value })`
- use `exit()` to close the session cleanly

Useful shell commands:

```text
get_editor_state({ include_schema: true })
batch_get({ patterns: [{ reusable: true }], readDepth: 2, searchDepth: 3 })
get_variables({})
save()
exit()
```

## Pencil CLI quick reference

### Authentication and status

```bash
pencil login
pencil status
pencil version
```

### Export

Export the current `.pen` file for review:

```bash
pencil --in design.pen --export review.png --export-scale 2
```

Use `--export-type pdf` when you need a multi-page review artifact.

### Interactive mode

Use headless interactive mode when you need tool-level operations:

```bash
pencil interactive -o output.pen
pencil interactive -i input.pen -o output.pen
```

Safer pattern for existing files:

```bash
pencil interactive -i current.pen -o current.updated.pen
```

Then verify `current.updated.pen` before replacing the original.

## Pencil MCP quick reference

Use MCP when direct local manipulation is stable and you need structured operations on the open document.

### Typical read flow

1. `pencil_get_editor_state`
2. `pencil_batch_get` for reusable components or target boards
3. `pencil_get_variables`
4. `pencil_get_screenshot` or `pencil_snapshot_layout`

### Typical edit flow

1. `pencil_get_editor_state`
2. `pencil_batch_get` for target nodes and reusable components
3. `pencil_batch_design` for bounded edits
4. `pencil_get_screenshot`
5. `pencil_snapshot_layout`

## Export and review guidance

- prefer CLI export when implementation workflows need deterministic image artifacts from packet-linked `.pen` files
- prefer MCP screenshots during live local iteration when the session is stable
- use the same packet-linked board names and paths regardless of transport

## Tool naming mental model

- MCP tool names are `pencil_get_editor_state`, `pencil_batch_get`, `pencil_batch_design`, and so on
- CLI interactive uses the same logical tools without the `pencil_` prefix: `get_editor_state`, `batch_get`, `batch_design`
- the document semantics are identical across both

## Task-to-transport matrix

| Task | Prefer | Why |
|---|---|---|
| Inspect packet-linked `.pen` boards in GSD-2 | CLI | headless and reliable |
| Export `.pen` screens for review | CLI | deterministic image export |
| Broad redesign of a board in this workflow | MCP or CLI interactive | keep the `.pen` work explicit and inspectable |
| Deterministic tool-by-tool board surgery without MCP | CLI interactive | same logical tools, explicit save/export flow |
| Small but exact `.pen` property update in GSD-2 | CLI interactive | still prefer Pencil-native persistence over direct text editing |
| Scripted reads or batch work | CLI | easier to automate |
| Fine-grained local edits in a stable session | MCP | direct structured operations |
| Section-by-section design iteration in a live editor | MCP | faster edit/verify loop when stable |
| Mixed workflow: inspect/export first, then local touch-up | CLI then MCP | separates reliable retrieval from optional live edits |

## Working assumptions

- Prefer CLI for reading, exporting, and scripted validation in implementation workflows.
- Prefer MCP for direct, local, section-by-section design work when it is genuinely stable.
- Never let the transport choice change which packet, `.pen`, or screenshot artifacts are binding.
- Do not treat direct text editing of `.pen` JSON as equivalent to successful Pencil CLI usage.
