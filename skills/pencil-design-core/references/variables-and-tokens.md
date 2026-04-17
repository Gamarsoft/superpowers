# Variables and Tokens

## Why this matters

Variables are the design-side equivalent of tokens.
Hardcoded values make theming, normalization, and code translation harder.

## Step-by-step

### 1. Read all variables

```text
pencil_get_variables({ filePath: "path/to/file.pen" })
```

Inspect:

- colors
- surfaces
- foreground/text colors
- semantic statuses
- border radius
- spacing
- typography
- theme variants if present

### 2. Map intended styles to variables

Before applying any style, check whether an existing variable already expresses it.

| What you want | Do not use | Use instead |
|---|---|---|
| brand color | `fill: "#3b82f6"` | the closest brand variable |
| text color | raw hex | semantic foreground variable |
| border radius | fixed number | semantic radius variable |
| page background | raw fill color | background/surface variable |

### 3. Apply variables instead of raw values

Use the variable reference form supported by the current `.pen` schema returned by `pencil_get_editor_state`.

Typical `.pen` bindings look like:

```json
{
  "fill": "$color.background",
  "textColor": "$color.text",
  "fontSize": "$text.title"
}
```

If the document already uses dotted token names such as `color.background` or `text.title`, preserve that hierarchy instead of flattening it.

### 4. Create missing variables deliberately

If a value truly needs a new variable:

```text
pencil_set_variables({
  filePath: "path/to/file.pen",
  variables: {
    "warning": { "value": "#f59e0b" }
  }
})
```

Only create missing variables when the new token is justified by the system, not just by one screen-local flourish.

## Brownfield guidance

When the current product is inconsistent, separate:

- **observed current values** — what the product actually uses today
- **normalization targets** — what shared tokens should absorb over time

Do not pretend the system is already cleaner than it is.

## Themes

If the file supports themed variables, prefer using them rather than duplicated hardcoded light/dark values.

Theme rules that matter in practice:

- the first value on each theme axis is the default for that axis
- when a variable has multiple themed values, the last satisfied themed value wins
- object-level theme settings cascade to descendants, so keep theme overrides as high in the tree as practical

## Generic code-translation rule

When handing the design to code:

- use semantic token names
- preserve the token hierarchy
- let the adapter decide the framework-specific mapping
- do not turn semantic tokens back into raw literals

## Checklist

Before styling anything:

- [ ] did I read variables first?
- [ ] am I using the closest semantic variable?
- [ ] is a new variable actually justified?
- [ ] am I recording normalization opportunities where the source system drifts?
- [ ] am I preserving existing `.pen` token naming and theme structure instead of flattening it?
