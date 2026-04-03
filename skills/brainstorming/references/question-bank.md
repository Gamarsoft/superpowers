# Question Bank

Use these as starting shapes. Do **not** dump several at once.

Each question should be asked as its own message and should usually include a recommendation.

## Universal framing questions

### User / operator
```text
I think the primary user is [X].
Alternative is [Y], but that would shift the design quite a bit.
Who should we optimize for first?
```

### Problem
```text
I think the core problem is [A].
Alternative framing is [B], which would lead to a different design.
Which one is actually driving this request?
```

### Success signal
```text
For first release, I recommend we define success as [observable outcome].
Alternative is [broader metric], but that is harder to validate quickly.
What would make this feel successful in practice?
```

### Boundary
```text
I recommend we keep [X] out of the first release.
Including it now would add [cost/risk].
Does that boundary feel right?
```

---

## Frontend-heavy questions

### Preserve vs refresh
```text
I think the safest default is to preserve the current design language and only refresh the screens that need new hierarchy.
Alternative is a broader redesign, but that adds more design and implementation risk.
Should we optimize for continuity first, or is a visible redesign part of the goal?
```

### Primary screen to perfect
```text
I recommend we perfect [screen / flow] first and let the other screens inherit from it.
Alternative is spreading attention across several surfaces at once, but that usually makes the visual direction blurry.
Which screen or step has to feel most right in the first release?
```

### Density / hierarchy bias
```text
I see two sensible directions:
- denser, operational UI that helps expert users scan quickly
- calmer, more guided UI that slows the pace but improves onboarding clarity

I recommend [choice] because [reason tied to the primary user].
Which bias is closer to what this feature needs?
```

### Visual reference appetite
```text
I recommend we generate 2–3 variants for the key screen only, then lock the direction before expanding coverage.
Alternative is generating many references up front, but that creates noise.
Does that sequencing feel right?
```

---

## Greenfield questions

### First release scope
```text
I recommend the first release focus on [single clear workflow].
Alternative is trying to cover [broader surface], but that risks a blurry first milestone.
Which workflow should the first version absolutely nail?
```

### Architecture style
```text
I see two sensible first-release shapes:
- thinner, simpler system now with more constraints
- more extensible platform shape now with more setup cost

I recommend the thinner shape unless we already know [future need] is unavoidable.
Which way should we bias?
```

### User journey
```text
I think the first version should optimize for [single primary journey].
Alternative is splitting attention across [two journeys].
Which journey matters most on day one?
```

---

## Brownfield major feature questions

### Integration point
```text
I found two likely integration points:
- [existing surface A]
- [existing surface B]

I recommend [A] because it fits the current patterns and minimizes migration risk.
Does that line up with how this codebase usually evolves?
```

### Invariant
```text
I think the key invariant is that [behavior/system property] must not break.
Is that the main non-negotiable, or is there an even more important one?
```

### Rollout
```text
I recommend a phased rollout with [safe default / hidden path / flag].
Alternative is a big switch, but that raises support and rollback risk.
What level of rollout safety do we need here?
```

### Data boundary
```text
I see a decision between:
- storing this inside [existing owner]
- creating a new boundary for it

I recommend [choice] because [fit / isolation / migration reason].
Does that match the existing ownership model?
```

---

## Brownfield small feature questions

### Smallest safe change
```text
I recommend extending [existing flow/component/API] rather than introducing a new surface.
Alternative is a new surface, but that seems heavier for the value.
Is the goal mainly to improve the existing path or create a distinct new one?
```

### Unchanged behavior
```text
To keep this small, I think [existing behavior] should remain exactly the same.
Is there any adjacent behavior that also must remain untouched?
```

### Acceptance
```text
What is the smallest observable change that would make this feature feel done?
```

Use this sparingly; usually follow with a reframed option turn.

---

## Bugfix / regression questions

### Current vs expected
```text
I think the bug is:
- current: [wrong behavior]
- expected: [correct behavior]

Is that accurate?
```

### Safety boundary
```text
Besides fixing [bug], what neighboring behavior must stay exactly as it is?
```

### Reproduction
```text
I recommend we anchor the fix around this reproduction shape:
1. [step]
2. [step]
3. [failure]

Is that the most reliable reproduction, or is there a simpler one?
```

---

## Architecture-led questions

### Trade-off question
```text
I see the core trade-off as:
- [Option A]: better for [benefit], worse for [cost]
- [Option B]: better for [benefit], worse for [cost]

I recommend [choice] because [reason tied to current constraints].
What am I missing?
```

### Reversibility
```text
I recommend we bias toward the more reversible option unless [strong reason].
How important is reversibility here compared with immediate performance or simplicity?
```

### Migration
```text
I think the real question is not just the end-state architecture, but the migration path.
I recommend [migration approach] because [risk reason].
Does that fit the reality of this system?
```
