# Instance Overrides and Slots

## Why this matters

Most Pencil mistakes happen inside component instances, not at the top level.
Agents often know that `ref` exists, but they still misuse updates, replace the wrong node, or copy a tree and then edit descendants with stale IDs.

Transport does not change these rules:
the same component semantics apply whether you are using Pencil MCP or Pencil CLI interactive mode.

## Core model

- `reusable: true` marks a reusable component
- `type: "ref"` creates an instance of that component
- descendants inside an instance are addressed with slash-separated paths such as `instanceId/label`
- nested instance descendants use deeper paths such as `instanceId/headerSlot/title`

## Choose the right operation

| Goal | Use | Why |
|---|---|---|
| change label text, color, width, padding, or other small properties | `U(instance+"/child", { ... })` | keeps the shared component structure intact |
| replace a slot or descendant entirely with a different node type | `R(instance+"/slot", { ... })` | swaps the descendant without rebuilding the whole instance |
| insert a reusable component into a new parent | `I(parent, { type: "ref", ref: "componentId" })` | preserves connection to the reusable source |
| copy an existing non-reusable board or asset | `C("sourceId", parent, { ... })` | duplicates the real source tree |
| copy a node and customize descendants immediately | `C("sourceId", parent, { descendants: { ... } })` | descendant IDs change on copy, so customization must happen inside the copy operation |

## Safe patterns

### Update a descendant inside an instance

```javascript
saveBtn=I("toolbar",{type:"ref",ref:"button-primary"})
U(saveBtn+"/label",{content:"Save changes"})
```

### Update a nested descendant path

```javascript
card=I("content",{type:"ref",ref:"summary-card",width:"fill_container"})
U(card+"/header/title",{content:"Revenue overview"})
```

### Replace a slot inside an instance

```javascript
panel=I("content",{type:"ref",ref:"side-panel"})
customBody=R(panel+"/contentSlot",{type:"frame",layout:"vertical",gap:12})
```

### Replace only the children of a container descendant

For container-style components, keep the shared shell and replace only the children of the content area:

```javascript
sidebar=C("sidebar-shell","document",{
  descendants:{
    "content":{
      children:[
        { type:"ref", ref:"nav-item-primary" },
        { type:"ref", ref:"nav-item-secondary" }
      ]
    }
  }
})
```

### Copy and customize in one step

```javascript
mobileBoard=C("desktop-screen","document",{
  name:"Settings Mobile",
  descendants:{
    "header/title":{content:"Settings"},
    "content/sidebar":{visible:false}
  }
})
```

## Critical caveats

### Do not copy, then update old descendant IDs

This is wrong:

```javascript
copy=C("cardA","target",{name:"cardB"})
U(copy+"/title",{content:"New title"})
```

Why it fails:
the copied descendants receive new IDs, so the old descendant path assumptions may no longer be valid.

Use descendant customization inside `C(...)` instead when you need copied descendants changed immediately.

### Do not use `U()` to replace children wholesale

If the node itself should stay but its children should change, use `R()` on the target descendant or use the component override mechanism designed for children replacement.

### Do not break a shared component for a one-off tweak

If the desired variation is still structurally the same component, keep it as an instance and override only what differs.
Only create a new reusable component when the structure or semantic role is genuinely different.

## Container-style components

Panels, cards, sidebars, and shell containers often work best when:

- the outer container stays shared
- the content slot is replaced or overridden
- shared padding, border, and surface treatment stay inherited

This is usually better than rebuilding the whole panel frame locally.

## Slot semantics

Some reusable components mark a descendant with `slot` metadata to signal which child component families are expected there.
Treat those suggestions as the preferred insertion path, not as decorative metadata.

When you encounter a slot:

1. inspect which component IDs the slot recommends
2. prefer those reusable components before inventing a new child pattern
3. keep the outer shell shared and populate the slot with the approved child family

## Read strategy before editing

Before changing a component instance:

1. inspect the reusable source with `pencil_batch_get`
2. inspect the target instance path if needed
3. decide whether the change is:
   - a property update
   - a slot replacement
   - a copy-with-descendants change
4. make the smallest operation that preserves reuse
