# Option Cards Template

Use this after the framing brief is stable.

Default: show 2 options.
Maximum: show 3 options.

```markdown
# Option Cards

## Decision
[What decision are these options trying to settle?]

## Recommended option
[Option B]

### Option A — [name]
- Optimizes for:
- Makes harder:
- Main risk:
- Best fit when:

### Option B — [name] **Recommended**
- Optimizes for:
- Makes harder:
- Main risk:
- Best fit when:
- Why I recommend it now:

### Option C — [name] *(optional)*
- Optimizes for:
- Makes harder:
- Main risk:
- Best fit when:

## Recommendation summary
[I recommend Option B because ...]
```

## Rules

- Name the decision before naming the options.
- Tie each option to real trade-offs, not vibes.
- Never present options as equally good.
- "Recommended" must be justified using `decision-lens.md`.

## Compression rule for smaller work

For small brownfield work, compress this to:

- recommended default
- fallback
- one sentence on why the default wins

## Example

```markdown
## Decision
Where should notification preferences live?

### Option A — Separate preferences service
- Optimizes for: long-term isolation
- Makes harder: first-release speed and operational simplicity
- Main risk: adds integration and ownership overhead
- Best fit when: notifications are already becoming a platform concern

### Option B — Extend the existing account settings model **Recommended**
- Optimizes for: codebase fit and fastest safe delivery
- Makes harder: future extraction into a standalone boundary
- Main risk: mild coupling to current settings model
- Best fit when: this is a contained feature inside the current product
- Why I recommend it now: it fits the existing ownership model and keeps the first milestone focused
```
