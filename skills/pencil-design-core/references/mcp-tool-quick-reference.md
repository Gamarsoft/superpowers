# MCP Tool Quick Reference

Pencil CLI interactive mode exposes the same logical tool set as Pencil MCP.
The practical difference is naming:
`pencil_batch_get` becomes `batch_get`, `pencil_get_screenshot` becomes `get_screenshot`, and so on.

| Tool | When to use it |
|---|---|
| `pencil_get_editor_state` | first call to understand file state and schema |
| `pencil_open_document` | open or create a `.pen` document |
| `pencil_batch_get` | inspect nodes, search for reusable components, search for assets |
| `pencil_batch_design` | insert, copy, update, move, replace, delete, or generate nodes |
| `pencil_get_variables` | inspect design tokens |
| `pencil_set_variables` | create or update tokens |
| `pencil_get_screenshot` | visual verification |
| `pencil_snapshot_layout` | detect clipping, overflow, and overlap |
| `pencil_find_empty_space_on_canvas` | place new screens or boards safely |
| `pencil_get_guidelines` | fetch Pencil-native guidance if useful |
| `pencil_get_style_guide_tags` / `pencil_get_style_guide` | optional inspiration or style support |
| `pencil_export_nodes` | export nodes as PNG/JPEG/WEBP/PDF when you need deterministic review artifacts |
| `pencil_search_all_unique_properties` | audit repeated property values and drift |
| `pencil_replace_all_matching_properties` | bulk normalization when safe |

## Common operations inside `pencil_batch_design`

- `I()` — insert a node
- `U()` — update a node
- `C()` — copy a node
- `R()` — replace a node or slot
- `M()` — move a node
- `D()` — delete a node
- `G()` — generate an image or new visual asset when truly necessary

Important operation notes:

- use `U(instanceId + "/childId", { ... })` for small descendant overrides inside component instances
- use `R(instanceId + "/slotId", { ... })` when the descendant must become a different node or body
- when copying a node and changing its descendants, put descendant changes inside `C(..., { descendants: { ... } })` rather than assuming the copied descendant IDs will match later updates
- there is no standalone image node type; create a frame or rectangle, then apply an image fill or `G()`

## Read discipline

- keep `readDepth` low by default and inspect deeper only where needed
- combine related searches into one `pencil_batch_get` call when possible
- use `searchDepth` deliberately instead of reading the whole file blindly
- use resolved-instance reads only when you truly need to inspect shadow descendants
- use `include_schema: true` on the first `pencil_get_editor_state` call when you need to confirm schema details

## Practical order

For most `.pen` work:

1. `pencil_get_editor_state`
2. `pencil_batch_get` for reusable components
3. `pencil_get_variables`
4. packet / screenshot inspection
5. `pencil_batch_design`
6. `pencil_get_screenshot`
7. `pencil_snapshot_layout`
