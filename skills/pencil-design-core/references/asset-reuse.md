# Asset Reuse

## Why this matters

Generated images are not deterministic.
If a logo, illustration, or hero asset already exists, regenerating it usually creates inconsistency.

## Step-by-step

### 1. Search for existing assets

```text
pencil_batch_get({
  filePath: "path/to/file.pen",
  patterns: [
    { name: "logo" },
    { name: "brand" },
    { name: "icon" },
    { name: "image" }
  ],
  searchDepth: 5
})
```

You can also search by likely frame names.

### 2. Copy the existing asset

When a match exists, copy it instead of regenerating it.

```javascript
logoCopy = C("existingLogoNodeId", "targetParentId", { width: 120, height: 40 })
```

If the asset is part of a reusable component, prefer inserting that component as a `ref`.

### 3. Adjust size and position

After copying, resize or reposition carefully without changing the brand treatment.

### 4. Generate only when the asset truly does not exist

Use `G()` or other image generation only for genuinely new assets.

There is no standalone image node type in Pencil.
When you need a new bitmap asset:

1. insert a frame or rectangle
2. apply the asset to that node
3. use `G(nodeId, "stock", "...")` for stock imagery or `G(nodeId, "ai", "...")` for an AI-generated fill when the asset is truly new

## Special rule for logos

Always copy the existing logo or wordmark.
Never regenerate a logo that already exists in the document or approved packet.

## Icon rule

For icons, prefer reusable icon components or `icon_font` usage over generating bitmap icons.
Generated imagery is for images and illustrations, not routine UI iconography.

## Common mistakes

| Mistake | Better approach |
|---|---|
| generating a second logo | copy the existing one |
| redrawing a known icon or brand element | reuse the existing asset |
| using a different crop or ratio on shared imagery accidentally | copy first, then adjust deliberately |
| generating a bitmap icon for a normal UI control | use an icon component or `icon_font` |
