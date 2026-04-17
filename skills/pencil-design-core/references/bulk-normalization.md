# Bulk Normalization

Use this when a `.pen` file has drift that can be consolidated safely.

## Good use cases

- many hardcoded fills should map to one token
- repeated spacing values should become a smaller scale
- multiple near-duplicate components should become reusable
- the same border or radius treatment is repeated inconsistently

## Workflow

1. audit property values

```text
pencil_search_all_unique_properties({
  filePath: "path/to/file.pen"
})
```

2. identify safe consolidation candidates
3. create or confirm the target token/component
4. replace matching properties in bulk only when the change is genuinely system-safe

```text
pencil_replace_all_matching_properties(...)
```

5. verify screenshots and layout after each bulk pass

## Warning

Bulk normalization is powerful but dangerous.
Use it to consolidate drift, not to silently redesign the product.
