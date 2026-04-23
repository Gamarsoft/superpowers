---
name: webapp-testing
description: Use when validating or debugging local web UI behavior and you need browser-grounded evidence such as snapshots, screenshots, console logs, or traces. In Codex App use `browser-use:browser`; otherwise use `playwright-cli`.
---

# Webapp Testing

## Overview

Use a real browser to validate local UI behavior, collect runtime evidence, and verify flows.

Browser surface selection:

- in Codex App: use `browser-use:browser` with the in-app browser
- otherwise: use `playwright-cli` and prefer `playwright-cli open --headed ...`

Core workflow: open -> wait (if needed) -> snapshot -> act by ref -> re-snapshot -> verify -> collect evidence.

## When to Use

- Validate a UI flow end-to-end (routing, forms, CRUD, auth redirects).
- Debug bugs that only reproduce in a real browser.
- Gather evidence: snapshots/refs, screenshots, console, network, and traces.

Usually NOT needed for:

- Pure backend logic (use unit/integration tests).
- Static inspection where no runtime JS state matters.

## Browser Selection

Apply this rule first:

- if running in Codex App, prefer the in-app browser through `browser-use:browser`
- otherwise use `playwright-cli` and favor headed mode with `--headed`

Do not default to `playwright-cli` when the in-app browser is available.

## Setup

For the `playwright-cli` path, assume the command is available in your environment.

Sanity check:

```bash
playwright-cli --help
```

## Quick Start (`playwright-cli` fallback)

```bash
playwright-cli open --headed http://localhost:5173
playwright-cli snapshot

# pick refs from the snapshot output, then interact
playwright-cli click e15
playwright-cli fill e3 "me@example.com"
playwright-cli press Enter

# re-snapshot after significant UI changes
playwright-cli snapshot
```

## Core Pattern (Reconnaissance -> Action -> Evidence)

### 1) Navigate

```bash
playwright-cli open --headed http://localhost:5173
```

### 2) Stabilize (only if needed)

Prefer deterministic waits. If you need load stabilization, use `run-code`:

```bash
playwright-cli run-code "await page.waitForLoadState('networkidle')"
```

### 3) Snapshot and choose refs

```bash
playwright-cli snapshot
```

Snapshots return elements with refs like:

```yaml
- button "Submit" [ref=e6]
- textbox "Email" [ref=e3]
```

### 4) Act using refs

```bash
playwright-cli click e6
playwright-cli fill e3 "me@example.com"
playwright-cli press Enter
```

### 5) Verify outcomes (without dumping huge output)

Use small, targeted `eval` checks:

```bash
playwright-cli eval "document.title"
playwright-cli eval "el => el.textContent" e6
```

If refs feel stale, re-snapshot and pick new refs.

## Token Discipline

- Don’t paste full snapshots into chat unless necessary; copy only the 5-15 relevant lines.
- Prefer artifacts (screenshot/trace) over long textual dumps.
- Re-snapshot after navigation/modals/major DOM changes to avoid stale refs.

## Evidence Collection

Prefer producing at least one concrete artifact per debugging session.

### Screenshot / PDF

```bash
playwright-cli screenshot
playwright-cli screenshot e5
playwright-cli pdf
```

### Console / Network

```bash
playwright-cli console
playwright-cli console warning
playwright-cli network
```

### Tracing

```bash
playwright-cli tracing-start
# reproduce the issue
playwright-cli tracing-stop
```

## Command Cheat Sheet (`playwright-cli` fallback)

Core:

```bash
playwright-cli open --headed https://example.com/
playwright-cli close
playwright-cli type "search query"
playwright-cli click e3
playwright-cli dblclick e7
playwright-cli fill e5 "user@example.com"
playwright-cli drag e2 e8
playwright-cli hover e4
playwright-cli select e9 "option-value"
playwright-cli upload ./document.pdf
playwright-cli check e12
playwright-cli uncheck e12
playwright-cli snapshot
playwright-cli eval "document.title"
playwright-cli eval "el => el.textContent" e5
playwright-cli dialog-accept
playwright-cli dialog-accept "confirmation text"
playwright-cli dialog-dismiss
playwright-cli resize 1920 1080
```

Navigation:

```bash
playwright-cli go-back
playwright-cli go-forward
playwright-cli reload
```

Tabs:

```bash
playwright-cli tab-list
playwright-cli tab-new
playwright-cli tab-new https://example.com/page
playwright-cli tab-close
playwright-cli tab-close 2
playwright-cli tab-select 0
```

DevTools:

```bash
playwright-cli console
playwright-cli network
playwright-cli run-code "await page.waitForTimeout(1000)"
playwright-cli tracing-start
playwright-cli tracing-stop
```

Sessions:

```bash
playwright-cli --session=mysession open --headed example.com
playwright-cli --session=mysession click e6
playwright-cli session-list
playwright-cli session-stop mysession
playwright-cli session-stop-all
playwright-cli session-delete
playwright-cli session-delete mysession
```

## Integration With Other Skills

- Use **superpowers:systematic-debugging** for flaky/timing-sensitive issues; always capture evidence (console/network/trace).
- Use **superpowers:verification-before-completion** before claiming “fixed”: include at least one artifact (screenshot/trace) plus a short description of verified behavior.
