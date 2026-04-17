# Layout and Overflow

## Why this matters

Overflow, clipping, and accidental overlap are some of the most common Pencil defects.
They are especially easy to miss on dense screens and narrow artboards.

## Prevention strategy

### For text

- prefer width constrained to the parent
- avoid fixed widths that exceed the parent
- allow wrapping for longer content where appropriate
- use truncation/max-lines intentionally for labels, badges, or compact rows

Example:

```javascript
title = I("parent", {
  type: "text",
  content: "Long text",
  width: "fill_container"
})
```

### For containers

- prefer auto-layout structure when the section benefits from it
- use `width: "fill_container"` on child frames when they should follow parent width
- use padding on parents rather than manual offset hacks
- use `gap` for internal spacing rather than fake spacer nodes

### For mobile-width artboards

Typical safe range:

- 375–393px for common mobile mockups
- keep direct children inside the artboard with horizontal padding
- verify long labels, pills, tables, and action clusters early

## Required check after meaningful layout edits

```text
pencil_snapshot_layout({
  filePath: "path/to/file.pen",
  parentId: "sectionNodeId",
  maxDepth: 3,
  problemsOnly: true
})
```

Fix any reported:

- clipped nodes
- overlapping siblings
- content outside parent bounds
- off-frame children

## Fix patterns

| Problem | Common fix |
|---|---|
| text overflow | `width: "fill_container"`, wrap or truncate intentionally |
| child wider than parent | constrain child width, add padding, remove fixed width |
| cramped container | add padding or increase gap |
| overlapping siblings | move to auto-layout or adjust gap / child sizing |
| off-frame content | realign parent/child relationship and bounds |

## Brownfield note

When recreating a dense existing screen, preserve density but still fix accidental overflow and broken compression.
Density is allowed; broken layout is not.
