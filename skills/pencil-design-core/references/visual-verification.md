# Visual Verification

## Why this matters

The node tree does not tell you whether a section actually looks right.
Only rendered output reveals subtle alignment, spacing, and readability issues.

## Section-by-section verification loop

Do not build an entire screen and only check it once.

```text
Build section -> screenshot -> inspect -> layout check -> fix -> continue
```

## Step 1 — Take a screenshot

```text
pencil_get_screenshot({
  filePath: "path/to/file.pen",
  nodeId: "sectionNodeId"
})
```

Take a final full-screen screenshot when the entire screen is done.

## Step 2 — Analyze the screenshot

Check:

### Alignment
- are key edges aligned?
- do columns and cards line up cleanly?
- do action clusters sit where they should?

### Spacing
- is padding consistent?
- do gaps feel system-driven rather than accidental?
- is vertical rhythm stable?

### Typography
- are headings and body text clearly differentiated?
- is any text clipped or awkwardly wrapped?
- are badges, pills, and helper text legible?

### Surface hierarchy
- do cards, panels, and backgrounds read as intended?
- are dividers and borders too weak or too strong?

### Completeness
- are expected icons, labels, counters, and controls present?
- are there empty or broken areas?

## Step 3 — Run layout checks too

```text
pencil_snapshot_layout({
  filePath: "path/to/file.pen",
  parentId: "sectionNodeId",
  maxDepth: 3,
  problemsOnly: true
})
```

## Step 4 — Fix and re-verify

If issues appear:

1. update the nodes
2. take another screenshot
3. run layout checks again
4. only move on when the section is stable

## Final review checklist

- [ ] overall hierarchy is clear
- [ ] spacing is consistent from top to bottom
- [ ] density feels intentional, not cramped by accident
- [ ] no clipping or overlap remains
- [ ] the screen still looks like the intended product family
