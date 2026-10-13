# Guided Choice Protocol

This protocol prevents decision fatigue.

Help the user explain unclear intent, then react to grounded decisions. A recommendation is useful only when there is enough evidence to frame a real choice.

## Non-negotiable rules

1. **Reflect before questioning**
   - Restate the goal and moving pieces first.
   - Reuse an accepted reflection rather than requesting the same confirmation again.

2. **Retrieve before asking**
   - If the answer is likely in code, docs, or recent changes, inspect that before asking.

3. **One question per message**
   - Never stack several design-shaping questions in one turn.

4. **Discover intent before framing options**
   - While the goal is unclear, ask one concrete question about an incident, desired outcome, prior attempt, or anti-goal.
   - Once evidence supports a real choice, offer 2–3 viable options. Do not invent alternatives to a settled direction.

5. **Recommend one default**
   - For an understood choice, say what you recommend and why now. Do not recommend a goal before understanding the user's situation.

6. **Keep open discovery purposeful**
   - Use it to surface intent that cannot yet be framed.
   - Consecutive open questions are appropriate while that uncertainty remains; each must investigate a concrete gap.

7. **Choose the next turn from the evidence**
   - After an answer, ask about a remaining gap, synthesize what is known, or frame a supported choice. A turn count does not make speculative options valid.

8. **Synthesize every 2–3 turns**
   - Play back intent, boundaries, choices, and assumptions to reduce drift. Distinguish user decisions, observed facts, and agent calls. No word quota or extra approval loop is needed.

9. **Do not ask implementation-detail questions before the experience and boundary are understood**
   - Start with user value, scope, and constraints.
   - Only then drill into deeper technical choices.

10. **Never leave the user holding an unframed decision**
    - If the user says "I'm not sure," investigate a concrete incident or desired outcome before recommending. Avoid both vague questionnaires and forced menus.

11. **Do not under-question to look efficient**
    - GPT-5.5-style concise prompting is about removing noise, not skipping discovery.
    - Prefer one more well-framed question over hardening a weak feature frame.
    - Continue discovery until user value, scope, invariants, key states, failure behavior, and first delivery boundary are stable enough to write.

---

## Standard message shapes

## A. Reflection message

Use this before the first real question.

```text
Here’s my read so far:
- [goal]
- [major capability / workflow]
- [rough size or shape]

My current read is that the first version should probably optimize for [X].
Did I get that right?
```

## B. Guided question

Use this once the decision and viable alternatives are understood.

When external evidence changes the choice, place a brief finding before the
recommendation: supported claim with a direct source link or precise local
locator, relevant version/population/environment, and any material limit.
Distinguish your recommendation from what the source establishes. Omit the
finding for a settled preference or a choice supported only by local context.

```text
I think the next decision is [decision].

[If research-informed: Finding: [claim] ([direct source locator]; [applicability and material limit]).]
I recommend [Option B] because [reason tied to user value / safety / speed].
The alternatives are:
- [Option A]: [trade-off]
- [Option C]: [trade-off]

Which of those is closest, or what should I adjust?
```

## C. Boundary-setting question

```text
To keep the first version tight, I recommend we make [X] explicitly out of scope for now.
Alternative is to include [Y], but that adds [cost/risk].
Does that boundary feel right?
```

## D. Synthesis checkpoint

```text
So far I think we’ve settled:
- [decision 1]
- [decision 2]
- [decision 3]

That means the spec should probably optimize for [summary].
The next decision is [next decision].
```

---

## When open-ended questions are allowed

Use an open-ended question only when:

- the user’s goal is still too fuzzy to frame
- none of your options are remotely right
- the answer depends on latent intent, context, or politics you cannot infer
- the user explicitly wants to explain freely

When you do use one, keep it singular and purposeful.

### Good open-ended question

```text
What is the biggest thing you want users or operators to be able to do that they cannot do today?
```

### Bad open-ended question

```text
What are you thinking for users, roles, flows, auth, integrations, and success criteria?
```

---

## Option count limits

- Default: **2 options**
- Maximum: **3 options**
- Never present 4+ options unless the user explicitly asks for a wider survey

Too many options create reading load and hide your judgment.

---

## Recommendation rules

For an actual choice, your recommendation must say:

- which option you recommend
- what it optimizes for
- what you are consciously giving up
- why it is the best choice **for now**

Do not present options as if all are equally good.

## Discovery stop rule

After each answer, decide whether the next artifact can be drafted without hiding an implementation-shaping unknown.

Move forward when:

- the remaining unknowns are non-blocking, or
- the unknowns are explicitly recorded with the decision they block.

Keep asking when:

- the primary user or success signal is still fuzzy
- the first delivery boundary is not testable
- brownfield invariants, rollout, migration, or compatibility constraints are missing
- key UI states, failure behavior, or non-regression boundaries are unclear
- option trade-offs would be speculative without one more answer

---

## Anti-patterns

Avoid these:

- multiple open-ended questions in one message
- asking for technical preferences before intent is understood
- recommending invented problem categories because an open-question allowance ran out
- presenting options with no trade-offs
- asking technical detail questions before the problem is framed
- repeatedly asking "anything else?" instead of shaping the next decision
- burying your recommendation under too much prose

---

## Good vs bad examples

## Bad

```text
How should authentication work? What roles are there? Should there be approval flows? How should notifications work?
```

Why it is bad:
- too many questions
- no recommendation
- no prioritization
- high cognitive load

## Better

```text
For first release, I recommend email magic-link sign-in only.
Alternative is password login, but that adds reset and support overhead.
SSO can wait unless enterprise buyers need it immediately.

Does magic link fit the first milestone, or is SSO a must-have from day one?
```

## Bad

```text
What kind of dashboard do you want?
```

## Better

```text
What happened the last time someone needed this information and could not find it?
```

Once the problem is understood and both approaches are viable:

```text
I see two viable dashboard directions.

I recommend a task-first dashboard because it helps users act immediately.
Alternative is an analytics-first dashboard, which is better for oversight but slower for execution.

Which direction is closer to the first release goal?
```
