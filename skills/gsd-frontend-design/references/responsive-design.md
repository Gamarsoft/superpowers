# Responsive Design

Responsive work in brownfield products should preserve the desktop operating model while making smaller viewports more usable.

## Brownfield defaults

- Do not treat mobile as a separate product unless the packet explicitly does.
- Preserve desktop throughput and hierarchy.
- Adapt the presentation, not the underlying importance of the information.

## What to preserve

- critical statuses
- primary actions
- ordering of the most important information
- recognizable shell and screen identity

## Common adaptation moves

Use these before inventing new flows:

- stack filter controls more intentionally
- convert dense rows into cards on narrow viewports
- compress secondary metadata behind disclosure
- keep the most important actions directly visible
- keep destructive or high-risk actions explicit

## Dense table guidance

For narrow screens, prefer:

- row-card view with primary actions visible
- compressed row with progressive disclosure
- sticky or repeated context only when it truly helps

Avoid:

- squeezing desktop columns until they become unreadable
- hiding status or priority cues that operators rely on
- replacing a workflow with a new one without explicit approval

## Verification

Check both:

- normal expected content
- stress cases with long labels, many badges, or error states
