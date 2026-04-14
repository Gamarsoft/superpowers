# Stitch Source Capture Workflow

Use this file whenever Stitch is part of packet creation.

## Goal

Make the frontend packet usable for both humans and later agents.

Humans need a readable gallery. Agents need durable identifiers and local mirrors.

## Required outputs when Stitch is used

Always write:

- `stitch-sources.json`
- one `*.meta.json` per selected or retained screen
- one full-resolution `*.png` per selected or retained screen
- one `*.html` mirror per selected or retained screen when available

## Required fields per screen

For every selected or retained screen variant, capture:

- `screenKey` — stable logical key like `s3-preferred`
- `packetSection` — where the screen is referenced in the packet
- `selectionStatus` — `preferred`, `comparison`, `rejected-but-retained`, or `state-only`
- `projectId`
- `screenId`
- `resourceName`
- `screenTitle`
- `deviceType`
- `width`
- `height`
- `screenshotPath`
- `htmlPath`
- `metaPath`
- `whySelected`
- `notes`

## Local mirror rules

- Use human-stable filenames based on packet screen keys.
- Keep mirrors under `selected-direction/` when the screen is part of the chosen gallery.
- If a screen is only supporting evidence, it may live elsewhere, but still include it in the manifest.

### Full-resolution Stitch screenshots

- Stitch screenshot URLs returned by MCP commonly come from `lh3.googleusercontent.com`.
- Those CDN URLs usually resolve to a 512px-wide preview when used as-is.
- Append `=s0` before downloading the screenshot mirror to request the original asset with no resize.

```text
Preview URL:
https://lh3.googleusercontent.com/aida/.../screenshot.png

Original-resolution URL:
https://lh3.googleusercontent.com/aida/.../screenshot.png=s0
```

- Treat `=s0` as required for local PNG mirrors unless the source is already a non-Google original file.
- If only the preview URL is available or the original cannot be fetched, record that degraded state explicitly instead of pretending the mirror is full resolution.

## Packet integration rules

### Packet Summary

Add:

- selected Stitch source manifest path
- retrieval mode: `live MCP + local mirror`, `local mirror only`, or `preview only (degraded)`

### Screen inventory

For each key screen, record whether a Stitch source exists and where it is mirrored locally.

### Reference gallery

Under each retained screen image, add a **Stitch source** block:

```markdown
**Stitch source**

- Project ID:
- Screen ID:
- Resource:
- Device:
- Size:
- Screenshot mirror:
- HTML mirror:
- Metadata:
```

## If source capture is incomplete

Never guess IDs.

If any of these are missing, say so explicitly:

- no live `screenId`
- HTML mirror unavailable
- only preview image available
- dimensions unavailable

That limitation must appear in both `stitch-sources.json` and the packet.
