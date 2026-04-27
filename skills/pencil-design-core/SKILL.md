---
name: pencil-design-core
description: Use when creating, extracting, or maintaining durable `.pen` design evidence, especially for brownfield UI capture, shared worksets, reusable components, tokens, screenshots, or design-to-code handoff.
---

# Pencil Design Core

Design in Pencil with the same discipline you would expect from production code:
**reuse existing primitives, use tokens, verify continuously, and preserve brownfield truth before inventing anything new.**

This skill is about durable `.pen` artifacts and how to work with them safely.
Pencil MCP and Pencil CLI are both valid transports in general, but when this skill is loaded by GSD-facing workflows, use Pencil CLI interactive mode only.

## Use this skill when

- designing screens, pages, or components in a `.pen` file
- extracting an existing product UI into Pencil
- extending a design system in Pencil
- creating or maintaining shared worksets like `_shared/00-foundations.pen`
- preparing implementation-ready design evidence for downstream agents
- translating a Pencil design into stack-neutral implementation guidance

## Do not use this skill alone when

- the task requires framework-specific code translation
- the task is implementation inside Angular/Nebular or React/Tailwind code

In those cases, load this core skill **plus** the correct adapter.

## The 7 critical rules

### Rule 1 — Always reuse design-system components

**Never recreate a component from scratch when one already exists in the `.pen` file.**

Before inserting any element, you must:

1. inspect existing reusable components with `pencil_batch_get`
2. search for a matching component by name and structure
3. insert it as a `ref` instance when possible
4. customize the instance by updating descendants, replacing slots, or using descendant overrides deliberately
5. only create a new component when no suitable reusable component exists

Read `references/component-reuse.md`.
Read `references/instance-overrides-and-slots.md` when working inside component instances or copied trees.

### Rule 2 — Always use variables instead of hardcoded values

**Never hardcode colors, border radius, spacing, or typography when variables exist or should exist.**

Before styling anything, you must:

1. read variables with `pencil_get_variables`
2. map your intended value to an existing variable if possible
3. create a missing variable only when truly necessary
4. apply variable references instead of raw values
5. record normalization opportunities when the source system is inconsistent

Read `references/variables-and-tokens.md`.

### Rule 3 — Prevent text, content, and layout overflow

**Never allow text or child elements to overflow their parent or the artboard unnoticed.**

For every meaningful layout change, you must:

1. use parent-aware width constraints
2. prefer auto-layout frames over manual positioning when structure benefits from it
3. use padding and gap deliberately
4. run `pencil_snapshot_layout` with `problemsOnly: true`
5. fix reported clipping or overlap before continuing

Read `references/layout-and-overflow.md`.

### Rule 4 — Visually verify every section

**Never build a whole screen blind and only check at the end.**

After each section, you must:

1. take a screenshot with `pencil_get_screenshot`
2. inspect alignment, spacing, typography, surface hierarchy, completeness, and visual glitches
3. run layout problem detection
4. fix issues before moving on
5. take a final full-screen screenshot at the end

Read `references/visual-verification.md`.

### Rule 5 — Reuse assets instead of regenerating them

**Never generate a new logo or duplicate an asset when one already exists in the file or packet.**

Before generating an image, logo, or illustration, you must:

1. search the document for matching assets
2. copy or reference the existing asset where possible
3. generate only genuinely new imagery
4. preserve brand consistency across screens

Read `references/asset-reuse.md`.

### Rule 6 — Brownfield truth outranks novelty

**For brownfield work, recreate the real product language first.**

Before exploring variants, you must:

1. inspect the current product shell and shared primitives
2. capture must-preserve patterns
3. distinguish observed current truth from normalization targets
4. preserve the real product’s hierarchy and density unless the packet explicitly authorizes change

Read `references/brownfield-extraction.md`.

### Rule 7 — The core stays stack-agnostic

This skill governs Pencil operating discipline, not final code shape.

- use the Angular/Nebular adapter for Angular/Nebular brownfield repos
- use the React/Tailwind adapter only for actual React/Tailwind repos
- do not emit framework-specific code from the core skill

Read `references/design-to-code-principles.md`.

### Rule 8 — Board intent must be explicit before handoff

**Never leave implementation agents to guess whether a Pencil board is visual truth or guidance.**

For every board, frame, screenshot, or retained visual reference that may guide implementation, record:

1. intent mode: `visual-truth`, `semantic-guidance`, or `reference-only`
2. what is binding
3. what is non-binding
4. approval status
5. pending questions or blockers

If intent is not approved, mark it pending. Do not promote the board to implementation-ready visual truth.

### Rule 9 — Choose the transport layer deliberately

Pencil MCP and Pencil CLI are execution surfaces, not competing sources of truth.

- use Pencil MCP for direct local manipulation when the session is stable and the tool surface is responsive
- use Pencil CLI for headless, scripted, or session-isolated workflows
- prefer Pencil CLI in GSD-2 or any environment where MCP reliability is weak
- use CLI interactive mode when you need deterministic tool-level operations and explicit `save()`
- do not let transport choice change which `.pen` files or screenshots are authoritative

Read `references/pencil-tooling-modes.md` when you need command syntax, headless workflows, or MCP-vs-CLI guidance.

## Required preflight for every `.pen` task

1. inspect the packet / screenshots / current browser evidence
2. if brownfield truth exists only in source code and the running app, gather browser-grounded baseline evidence before touching the `.pen` file:
   - capture the current screen at desktop and narrow/mobile widths
   - capture the key local states for the changed area
   - record what is observed current truth versus what is only inferred from code
3. choose the Pencil transport:
   - MCP for stable local manipulation
   - CLI interactive mode for deterministic tool-level edits, exports, and scripted inspection
4. inventory document structure, reusable components, and variables using the chosen transport
5. determine the mode:
   - brownfield extraction
   - shared primitive build
   - faithful approved change
   - controlled exploration
   - design-to-code handoff
6. classify board intent for every implementation-facing board or screenshot:
   - `visual-truth`
   - `semantic-guidance`
   - `reference-only`
7. record approval status before treating any board as implementation-ready

## Recommended workflow

### Starting a new or empty workset

1. load the relevant packet or task context
2. run the required preflight
3. if needed, find or create workspace/canvas space with the chosen transport
4. build the screen or section one block at a time
5. after each block:
   - screenshot it
   - run layout checks
   - fix issues
6. record reusable patterns and token gaps
7. hand off to the correct adapter if code translation is required

### Section-by-section loop

For each logical section:

1. **plan** — identify existing components, variables, and assets to reuse
2. **build** — insert or update nodes
3. **verify** — screenshot + layout problem detection
4. **fix** — resolve spacing, clipping, or consistency issues
5. **proceed** — move on only when the section is stable

### Brownfield extraction loop

1. recreate the shell and major primitives first
2. capture the actual product hierarchy before improving anything
3. create shared foundations and patterns before feature-level boards
4. separate:
   - observed current truth
   - conservative normalization target
   - optional exploration
5. if a runtime baseline exists, mirror it faithfully before exploring variants

## MCP tool quick reference

Read `references/mcp-tool-quick-reference.md`.

For CLI-specific workflows, also read `references/pencil-tooling-modes.md`.

## Common mistakes to avoid

| Mistake | Correct approach |
|---|---|
| Creating a button from scratch | Search reusable components first and insert as `ref` |
| Using raw hex values or fixed radii | Use variables or create missing variables deliberately |
| Building a whole screen before checking it | Verify after each section |
| Ignoring overflow problems | Run `pencil_snapshot_layout(problemsOnly: true)` after meaningful changes |
| Generating a new logo | Search first, then copy existing assets |
| Treating an optional exploration as binding | Translate the chosen concept back into the packet or `.pen` workset |
| Jumping to framework-specific code from the core skill | Load the correct adapter |
| Treating MCP and CLI as different design sources | Treat them as transport layers over the same `.pen` truth |

## Read order

1. `references/component-reuse.md`
2. `references/instance-overrides-and-slots.md`
3. `references/variables-and-tokens.md`
4. `references/layout-and-overflow.md`
5. `references/visual-verification.md`
6. `references/asset-reuse.md`
7. `references/brownfield-extraction.md`
8. `references/design-to-code-principles.md`
9. `references/mcp-tool-quick-reference.md`
10. `references/bulk-normalization.md` when consolidating drift
