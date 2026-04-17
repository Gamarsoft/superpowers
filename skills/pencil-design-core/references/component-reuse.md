# Component Reuse

## Why this matters

Reusable Pencil components are the closest equivalent to design-system components.
Ignoring them creates drift, duplication, and worse design-to-code translation.

## Step-by-step

### 1. List reusable components

Start every meaningful design task with a reusable-component inventory.

```text
pencil_batch_get({
  filePath: "path/to/file.pen",
  patterns: [{ reusable: true }],
  readDepth: 2,
  searchDepth: 3
})
```

Use the result to find likely matches by:

- name
- structure
- child labels
- size and layout behavior
- variant naming

### 2. Identify the closest match

Look for:

- buttons
- cards
- fields
- nav items
- headers
- badges
- tables or table-like row patterns
- dialog shells
- common layout wrappers

### 3. Insert as a `ref`

When a match exists, insert an instance instead of rebuilding it.

```javascript
btn = I("parentFrameId", {
  type: "ref",
  ref: "btn-primary",
  width: "fill_container"
})
```

### 4. Customize the instance

Update the instance or its descendants rather than breaking the shared structure.

```javascript
U(btn + "/label", { content: "Save" })
```

Common safe customizations:

- label text
- icon swap
- width or alignment
- status or variant token
- optional child visibility when the component supports it

For nested instances, use slash-separated descendant paths such as:

```javascript
U(card + "/header/title", { content: "Account limits" })
```

If the component exposes a content slot or placeholder area, replace that descendant instead of rebuilding the outer frame:

```javascript
body=R(card + "/contentSlot", { type: "frame", layout: "vertical", gap: 12 })
```

Read `instance-overrides-and-slots.md` for when to use `U()`, `R()`, or descendant overrides inside `C(...)`.

### 5. Create a new reusable component only when needed

If no suitable reusable component exists:

1. create the pattern carefully
2. verify it visually
3. mark it reusable if it should become shared
4. use it consistently from then on

## What to compare before creating a new component

- Is the same purpose already covered by an existing component?
- Is there an existing component with slightly different labeling that can be adapted?
- Is there a shared shell pattern that should be reused instead of nested local frames?
- Would a new component actually reduce drift, or just add a duplicate?

## Brownfield rule

When extracting a real product into Pencil, prefer reflecting the **actual** shared primitive from the repo or browser over inventing a cleaner but nonexistent one.

## Inspection tip

If the source component structure is unclear, inspect the reusable source first.
Use resolved-instance reads sparingly and only when you specifically need to inspect shadow descendants before targeting an override.

## Common mistakes

| Mistake | Better approach |
|---|---|
| Rebuilding a button, card, or field from scratch | Insert a reusable component as `ref` |
| Duplicating a component tree manually | Make or reuse a shared component |
| Over-customizing an instance until it becomes a new component | Either keep the shared pattern or create a deliberate new reusable component |
| Choosing by name only | Compare both name and structure |
| Replacing an outer component just to change its body content | Replace the relevant slot or descendant instead |
