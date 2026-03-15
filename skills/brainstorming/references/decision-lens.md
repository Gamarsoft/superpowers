# Decision Lens

Use this lens when comparing options. It keeps recommendations consistent and prevents "interesting" choices from outranking practical ones.

## Core dimensions

Score each option informally across these dimensions.

### 1. User value
- Does this make the primary user or operator noticeably better off?
- Does it solve the real problem or just create optionality?

### 2. Codebase fit
- Does it align with the existing architecture, ownership model, and patterns?
- Does it reduce surprise for future maintainers?

### 3. Delivery risk
- How likely is this option to create hidden scope, migration pain, rollout risk, or brittle implementation?
- What could go wrong during delivery?

### 4. Reversibility
- If we learn the choice was wrong, how painful is it to change later?
- Lower confidence should usually increase the value of reversibility.

### 5. Operational cost
- What support, observability, maintenance, or training burden does this option create?

## Default weighting

Use this weighting unless the user has clearly different priorities.

| Dimension | Default weight |
|----------|----------------|
| User value | Highest |
| Codebase fit | High |
| Delivery risk | High |
| Reversibility | Medium |
| Operational cost | Medium |

## Track-specific emphasis

### Greenfield
Bias toward:
- user value
- delivery risk
- first-release simplicity

### Brownfield major feature
Bias toward:
- codebase fit
- delivery risk
- operational cost

### Brownfield small feature
Bias toward:
- codebase fit
- smallest safe boundary
- reversibility

### Bugfix / regression
Bias toward:
- correctness
- unchanged neighboring behavior
- regression safety

### Architecture-led change
Bias toward:
- codebase fit
- migration safety
- reversibility
- long-term operational cost

## Recommendation pattern

When recommending an option, explicitly state:

1. what it optimizes for
2. what it makes harder
3. why it wins **for now**
4. what you are consciously deferring

## Example

```text
I recommend Option B.

It optimizes for codebase fit and a smaller first milestone.
What it makes harder is future extensibility compared with Option C.
I still recommend it because the current uncertainty is in rollout and integration, not in future platform scale.
We can defer the more extensible shape until there is real pressure for it.
```
