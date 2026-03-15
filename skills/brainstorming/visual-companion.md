# Visual Companion Guide

Browser-based visual brainstorming companion for showing mockups, diagrams, journey maps, and side-by-side options.

## Role in the workflow

Use the visual companion to reduce ambiguity **after** the design has enough shape to compare visually.

It is a tool for:

- seeing layout differences
- comparing information architecture
- showing flow diagrams
- sketching architecture or state relationships
- clarifying spatial or visual trade-offs

It is **not** a substitute for recommendation, scoping, or conceptual questioning.

## Offer rule

If an upcoming question is genuinely visual, offer the companion once for consent.

The offer must be its own message and contain only the offer.

Suggested message:

> Some of what we're working on might be easier to explain if I can show it to you in a web browser. I can put together mockups, diagrams, comparisons, and other visuals as we go. This feature is still new and can be token-intensive. Want to try it? (Requires opening a local URL)

Wait for the user's response before continuing.

## Per-question decision

Even after the user accepts, decide **for each question** whether the browser helps more than text.

The test:

**Would the user understand this better by seeing it than reading it?**

## Use the browser for

- wireframes and layout comparisons
- architecture diagrams
- journey maps and service flows
- state or relationship diagrams
- side-by-side visual option comparisons
- visual hierarchy or information density questions

## Use the terminal for

- trade-off lists
- scope decisions
- recommendation + rationale
- requirements and constraints
- most conceptual questions
- most API or data-model decisions unless a diagram materially helps

A question **about** UI is not automatically a visual question.

- "What should the first-time setup optimize for?" → terminal
- "Which setup layout feels clearer?" → browser

## Workflow fit

Good places to use visuals:

- after the framing brief, to compare product directions
- during option shaping, when two options differ visually
- during the spec phase, for architecture or flow diagrams
- before final approval, if a diagram clarifies a complex system or workflow

Avoid using visuals too early when the actual decision is still conceptual.

## Operating model

The server watches a directory for HTML files and serves the newest one to the browser. You write HTML content, the user sees it, and interactions are recorded to an `.events` file.

### Project directory
Use a persistent project directory such as `/.superpowers/brainstorm/` so screens survive server restarts. Remind the user to add `.superpowers/` to `.gitignore` if needed.

## Launching the server by platform

### Claude Code
```bash
scripts/start-server.sh --project-dir /path/to/project
```

### Codex
```bash
scripts/start-server.sh --project-dir /path/to/project
```

### Gemini CLI
```bash
scripts/start-server.sh --project-dir /path/to/project --foreground
```

If the URL is unreachable from the browser, bind a non-loopback host:

```bash
scripts/start-server.sh \
  --project-dir /path/to/project \
  --host 0.0.0.0 \
  --url-host localhost
```

## The loop

1. **Check the server is alive**
   - Confirm `$SCREEN_DIR/.server-info` exists.
   - If not, restart the server.
   - The server may auto-exit after inactivity.

2. **Write a fresh HTML file**
   - Use semantic filenames.
   - Never reuse filenames.
   - Prefer writing content fragments, not full HTML documents, when the server supports wrapping.

3. **Tell the user what they are looking at**
   - Repeat the URL
   - Give a short summary
   - Ask them to review it and reply in the terminal

4. **On the next turn**
   - Read `$SCREEN_DIR/.events` if present
   - Merge browser interactions with the user's terminal feedback

5. **Iterate or advance**
   - Revise the current visual or move forward

6. **Unload when returning to terminal**
   - Push a waiting screen like:
```html
Continuing in terminal...
```

## Minimal content fragment

```html
<h2>Which layout works better?</h2>
<p>Consider readability and visual hierarchy.</p>

<div data-option="A">
  <h3>Single Column</h3>
  <p>Clean, focused reading experience</p>
</div>

<div data-option="B">
  <h3>Two Column</h3>
  <p>Sidebar navigation with main content</p>
</div>
```

## Common mistakes

- offering the companion and a question in the same message
- using the browser for conceptual trade-offs that should stay in text
- skipping the textual summary of what is on screen
- leaving stale screens visible after the conversation has moved on
- treating visuals as the decision rather than support for the decision
