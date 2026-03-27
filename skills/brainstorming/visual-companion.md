# Visual Companion Guide

Browser-based visual brainstorming companion for showing mockups, diagrams, journey maps, and side-by-side options.

## Role in the workflow

Use the visual companion to reduce ambiguity after the design has enough shape to compare visually.

It is a tool for:

- seeing layout differences
- comparing information architecture
- showing flow diagrams
- sketching architecture or state relationships
- clarifying spatial or visual trade-offs

It is not a substitute for recommendation, scoping, or conceptual questioning.

## Offer rule

If an upcoming question is genuinely visual, offer the companion once for consent.

The offer must be its own message and contain only the offer.

Use the current platform's dedicated question tool for the offer when available.

Suggested message:

> Some of what we're working on might be easier to explain if I can show it to you in a web browser. I can put together mockups, diagrams, comparisons, and other visuals as we go. This feature is still new and can be token-intensive. Want to try it? (Requires opening a local URL)

Wait for the user's response before continuing.

## Per-question decision

Even after the user accepts, decide for each question whether the browser helps more than text. Acceptance makes the browser available; it does not switch the session into browser mode.

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

A question about UI is not automatically a visual question.

- "What should the first-time setup optimize for?" -> terminal
- "Which setup layout feels clearer?" -> browser

## Workflow fit

Good places to use visuals:

- after the framing brief, to compare product directions
- during option shaping, when two options differ visually
- during the spec phase, for architecture or flow diagrams
- before final approval, if a diagram clarifies a complex system or workflow

Avoid using visuals too early when the actual decision is still conceptual.

## How it works

The server watches a content directory for HTML files and serves the newest one to the browser. You write HTML to `screen_dir`, the browser reloads automatically, and user clicks are written to `state_dir/events`.

The startup JSON includes:

- `url`: open this in the browser
- `screen_dir`: where you write `.html` screens
- `state_dir`: where runtime state is written

`screen_dir` and `state_dir` are usually peer directories inside one session folder:

- `<session>/content`
- `<session>/state`

### Content fragments vs full documents

If your HTML starts with `<!DOCTYPE` or `<html`, the server serves it as a full document and only injects the helper script.

Otherwise, the server wraps your content in the shared frame template, which provides:

- the page header
- theme CSS
- the indicator bar
- common layout classes
- click handling infrastructure

Write content fragments by default. Use a full document only when you need complete control over the page.

## Starting a session

Start the server with a persistent project directory so screens survive restarts:

```bash
scripts/start-server.sh --project-dir /path/to/project
```

Typical startup output:

```json
{
  "type": "server-started",
  "port": 52341,
  "host": "127.0.0.1",
  "url_host": "localhost",
  "url": "http://localhost:52341",
  "screen_dir": "/path/to/project/.superpowers/brainstorm/12345-1706000000/content",
  "state_dir": "/path/to/project/.superpowers/brainstorm/12345-1706000000/state"
}
```

Save `screen_dir` and `state_dir`. Tell the user to open `url`.

If you launched the server without capturing stdout, read `state_dir/server-info`.

When using `--project-dir`, remind the user to ignore `.superpowers/` in git if needed.

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
   - Confirm `state_dir/server-info` exists.
   - If `state_dir/server-stopped` exists, the server exited and must be restarted.
   - The server may auto-exit after inactivity.

2. **Write a fresh HTML file**
   - Write to `screen_dir`.
   - Use semantic filenames.
   - Never reuse filenames.
   - The server serves the newest `.html` file and reloads the browser automatically.

3. **Tell the user what they are looking at**
   - Repeat the URL.
   - Give a short summary.
   - Ask them to review it and reply in the terminal.

4. **On the next turn**
   - Read `state_dir/events` if present.
   - Merge browser interactions with the user's terminal feedback.
   - The terminal reply is the primary feedback; `events` adds structured interaction data.

5. **Iterate or advance**
   - Revise the current visual or move forward.
   - If the current decision changed, write a new file such as `layout-v2.html`.

6. **Unload when returning to terminal**
   - Push a waiting screen so stale visuals do not stay on screen:

```html
<div style="display:flex;align-items:center;justify-content:center;min-height:60vh">
  <p class="subtitle">Continuing in terminal...</p>
</div>
```

## Writing content fragments

Write only the content that belongs inside the page body. The server frame already provides the shell and helper behavior.

Minimal example:

```html
<h2>Which layout works better?</h2>
<p class="subtitle">Consider readability and visual hierarchy.</p>

<div class="options">
  <div class="option" data-choice="a" onclick="toggleSelect(this)">
    <div class="letter">A</div>
    <div class="content">
      <h3>Single Column</h3>
      <p>Clean, focused reading experience</p>
    </div>
  </div>

  <div class="option" data-choice="b" onclick="toggleSelect(this)">
    <div class="letter">B</div>
    <div class="content">
      <h3>Two Column</h3>
      <p>Sidebar navigation with main content</p>
    </div>
  </div>
</div>
```

That is enough. You do not need to write `<html>`, CSS, or a custom script for normal use.

## Authoring rules

These matter more than styling:

- interactive choices must carry `data-choice`
- clickable options should call `toggleSelect(this)` so the selection state and indicator bar stay in sync
- `.options` and `.cards` containers are recognized by the helper for selection tracking
- add `data-multiselect` to an `.options` or `.cards` container when multiple selections should remain active

## Available classes and patterns

The shared frame template gives you a small authoring kit.

### Option list

Use for A/B/C text-heavy decisions:

```html
<div class="options">
  <div class="option" data-choice="a" onclick="toggleSelect(this)">
    <div class="letter">A</div>
    <div class="content">
      <h3>Option A</h3>
      <p>Short explanation</p>
    </div>
  </div>
</div>
```

### Multi-select option list

```html
<div class="options" data-multiselect>
  <div class="option" data-choice="alpha" onclick="toggleSelect(this)">
    <div class="letter">A</div>
    <div class="content">
      <h3>Alpha</h3>
      <p>Keep this selectable with others.</p>
    </div>
  </div>
</div>
```

### Visual cards

Use for comparing mockups or design directions:

```html
<div class="cards">
  <div class="card" data-choice="design-1" onclick="toggleSelect(this)">
    <div class="card-image"><!-- mockup content --></div>
    <div class="card-body">
      <h3>Design One</h3>
      <p>Compact dashboard with left navigation.</p>
    </div>
  </div>
</div>
```

### Mockup container

```html
<div class="mockup">
  <div class="mockup-header">Preview: Dashboard Layout</div>
  <div class="mockup-body"><!-- your mockup HTML --></div>
</div>
```

### Split view

```html
<div class="split">
  <div class="mockup"><!-- left --></div>
  <div class="mockup"><!-- right --></div>
</div>
```

### Pros and cons

```html
<div class="pros-cons">
  <div class="pros"><h4>Pros</h4><ul><li>Benefit</li></ul></div>
  <div class="cons"><h4>Cons</h4><ul><li>Trade-off</li></ul></div>
</div>
```

### Wireframe building blocks

```html
<div class="mock-nav">Logo | Home | About | Contact</div>
<div style="display:flex">
  <div class="mock-sidebar">Navigation</div>
  <div class="mock-content">Main content area</div>
</div>
<button class="mock-button">Action Button</button>
<input class="mock-input" placeholder="Input field">
<div class="placeholder">Placeholder area</div>
```

### Typography helpers

- `h2`: page title
- `h3`: section heading
- `.subtitle`: secondary text under a heading
- `.section`: vertically separated content block
- `.label`: small uppercase label text

## Browser events format

When the user clicks in the browser, interactions are appended to `state_dir/events`, one JSON object per line. The file is cleared automatically when a brand-new screen file is added.

Example:

```jsonl
{"type":"click","text":"Option A Clean focused reading experience","choice":"a","id":null,"timestamp":1706000101000}
{"type":"click","text":"Option B Sidebar navigation with main content","choice":"b","id":null,"timestamp":1706000115000}
```

Important details:

- the full event stream shows exploration, not just the last click
- if `state_dir/events` does not exist, the user did not interact in the browser
- current persistence is keyed off `choice`, so use `data-choice` on selectable elements

## Design tips

- scale fidelity to the question
- explain the question on each page
- keep screens focused on one decision
- prefer 2-4 options per screen
- use realistic content when it changes the judgment
- iterate before advancing to a new decision

## File naming

- use semantic names such as `layout.html`, `layout-v2.html`, `platform.html`
- never reuse filenames
- treat each new file as a new screen

## Cleanup

Stop the session with:

```bash
scripts/stop-server.sh /path/to/session-dir
```

Persistent sessions created with `--project-dir` keep their files. Temporary `/tmp` sessions are removed on stop.

## Reference

- Frame template: `scripts/frame-template.html`
- Helper script: `scripts/helper.js`
