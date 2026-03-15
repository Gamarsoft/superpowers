# Framing Brief Template

Write this before deep design work.

Keep it short. The goal is clarity, not polish.

```markdown
# Framing Brief

## Request
[One-sentence description of the request]

## Primary user / operator
[Who should the first version optimize for?]

## Job / problem
[What are they trying to do or what pain are they trying to remove?]

## Current workaround / current behavior
[How is this handled today?]

## Desired outcome
[What should be possible after this work ships?]

## Success signal
[What observable outcome would make this feel successful?]

## Why now
[Why is this worth doing now?]

## Constraints
- [technical]
- [product]
- [process]
- [brownfield constraint if applicable]

## Non-goals
- [explicitly out of scope]
- [explicitly out of scope]

## Unknowns to close
- [question or risk]
- [question or risk]
```

## Quality bar

A good framing brief is:

- specific about the user or operator
- specific about the problem
- explicit about success
- explicit about what is **not** in scope
- short enough to steer the next questions

## Common failure modes

### Too abstract
Bad:
- "Improve the platform experience"

Better:
- "Reduce time for account managers to assemble a compliant customer proposal"

### Too solution-shaped
Bad:
- "Build a dashboard with filters, exports, and alerts"

Better:
- "Give operations staff a fast way to detect and act on delivery failures"

### No boundary
Bad:
- "This should support all current and future workflows"

Better:
- "First release supports the triage workflow only; reporting and automation are deferred"
