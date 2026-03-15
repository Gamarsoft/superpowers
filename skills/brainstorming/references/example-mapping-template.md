# Example Mapping Template

Use this before final approval.

For each major capability or workflow, create one example map.

## Template

```markdown
# Example Map — [Capability / Story]

## Story
[Short statement of the user or operator goal]

## Rules
- [rule]
- [rule]
- [rule]

## Examples
1. Given ...
   When ...
   Then ...

2. Given ...
   When ...
   Then ...

## Open Questions
- [question]
- [question]

## Out of Scope / Deferred
- [item]
- [item]
```

## Rules for use

- Keep rules atomic.
- Examples should be concrete, not aspirational.
- Use examples to expose edge cases and ambiguous wording.
- If example mapping uncovers new scope, either:
  - add it consciously, or
  - move it to deferred / out of scope

## Minimum bar

At least one example map for each major capability in the spec.

## Good prompts for generating maps

- "What rules must always hold true here?"
- "What is a normal successful example?"
- "What is a realistic edge case?"
- "What question is still unresolved?"
- "What did we discover that should stay out of scope?"

## Why this exists

Polished prose can hide ambiguity.
Example mapping forces the design into something testable and handoff-ready.
