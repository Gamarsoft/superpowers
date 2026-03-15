# Guided Choice Protocol

This protocol prevents decision fatigue.

The user should be reacting to shaped decisions, not inventing the whole design from a blank page.

## Non-negotiable rules

1. **Reflect before questioning**
   - Restate the goal and moving pieces first.

2. **Retrieve before asking**
   - If the answer is likely in code, docs, or recent changes, inspect that before asking.

3. **One question per message**
   - Never stack several design-shaping questions in one turn.

4. **Prefer framed options**
   - Offer 2–3 viable options when the decision matters.

5. **Recommend one default**
   - Say what you recommend and why now.

6. **Use open-ended questions sparingly**
   - Only to surface intent that cannot yet be framed.
   - Never ask more than one open-ended question in a row.

7. **Reframe immediately**
   - After an open-ended answer, the next turn must convert that answer into options, boundaries, or a synthesis.

8. **Synthesize every 2–3 turns**
   - Confirm progress and reduce drift.

9. **Do not ask implementation-detail questions before the experience and boundary are understood**
   - Start with user value, scope, and constraints.
   - Only then drill into deeper technical choices.

10. **Never leave the user holding an unframed decision**
    - If the user says "I'm not sure," that is a cue to sharpen your recommendation, not ask another vague question.

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

Use this for most discovery turns.

```text
I think the next decision is [decision].

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

Your recommendation must say:

- which option you recommend
- what it optimizes for
- what you are consciously giving up
- why it is the best choice **for now**

Do not present options as if all are equally good.

---

## Anti-patterns

Avoid these:

- multiple open-ended questions in one message
- asking for preferences before presenting a default
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
I see two viable dashboard directions.

I recommend a task-first dashboard because it helps users act immediately.
Alternative is an analytics-first dashboard, which is better for oversight but slower for execution.

Which direction is closer to the first release goal?
```
