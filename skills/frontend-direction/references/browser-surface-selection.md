# Browser Surface Selection

Use this rule whenever browser interaction is needed for frontend capture, verification, comparison, or local UI inspection.

## Selection Rule

- If running in Codex App, use `browser:control-in-app-browser` and the in-app browser.
- If that capability is unavailable, discover installed browser capabilities, then use `playwright-cli` and prefer `playwright-cli open --headed ...`.

Do not default to `playwright-cli` when the Codex App in-app browser is available.

## Why

The in-app browser is the preferred browser surface in Codex App.

Use it for:

- local UI inspection
- screenshot capture
- comparison surfaces
- browser-grounded baseline capture
- visual verification

Use `playwright-cli` as the non-Codex-App fallback.

## Practical Rule

When a workflow says "capture the running app", "use browser-grounded evidence", "open the visual companion", or "verify in a browser", apply this selection rule first.
