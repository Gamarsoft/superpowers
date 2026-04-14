# Source of Truth

Read this before designing or changing code.

## Precedence order

Use the strongest available source in this order:

### Functional contract

1. **Approved spec and approved handoff**
2. **Current product behavior** when the spec is silent

### Visual contract

1. **Existing product UI and design system** for brownfield work
2. **Frontend direction packet**
3. **`stitch-sources.json` and inline per-screen Stitch source metadata**
4. **Live Stitch screen retrieval** by `projectId` + `screenId`
5. **Local HTML mirrors**
6. **Local full-resolution screenshot mirrors**
7. **`.stitch/DESIGN.md`**
8. **Existing component library, tokens, and app-shell conventions**
9. **This skill's design-quality references**
10. **Freeform invention** only for genuinely unspecified gaps

Later items never overrule earlier items without an explicit reason.

## What to extract from the packet

Capture these before coding:

- linked spec and route or flow scope
- visual thesis
- chosen direction for each key screen
- responsive contract
- state coverage
- accessibility constraints
- **Must preserve**
- **May adapt**
- **Explicit no-gos**
- verification plan
- Stitch source manifest and retained screen keys when Stitch is used

## Brownfield rule

Brownfield default is preservation.

Preserve:

- existing tokens and spacing rhythm
- established navigation patterns
- component APIs and affordances
- copy conventions and interaction expectations

Only diverge when the packet or spec explicitly authorizes it.

## When the packet and code disagree

1. Check whether the packet intentionally calls for a change.
2. Check whether the existing code pattern is a local inconsistency rather than a system rule.
3. Prefer the packet for intentional new direction.
4. Prefer the existing system when the packet is silent.
5. If Stitch-backed source evidence exists, use it to clarify the intended layout or hierarchy before guessing.
6. If the conflict remains material, surface it instead of silently choosing.

## Degraded mode

If no packet exists, say so explicitly.

Then use, in order:

- existing product UI
- `.stitch/DESIGN.md`
- current screenshots or wireframes
- this skill's reference files

Keep invention conservative and avoid accidental redesign.

## Deviation rule

If you must deviate from the packet or design system, record:

- what changed
- why the original direction could not be implemented as written
- whether the deviation is visual only or behavior-affecting
- whether Stitch source evidence was consulted
- what should be updated in the packet after implementation
