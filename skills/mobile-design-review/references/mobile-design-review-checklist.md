# Mobile Design Review Checklist

Use this reference when reviewing a mobile design artifact.

## Artifact Types

- Product/flow direction: review jobs, screen inventory, primary actions, state coverage, and native assumptions.
- Mockup/image reference: review hierarchy, visual thesis, component roles, native fit, and missing states.
- Implementation screenshot: compare against approved direction, platform evidence, accessibility, and compact devices.
- Prototype: review navigation, interruption handling, gestures, forms, and recovery paths.

## Product Mode Checks

### Transactional, Booking, Commerce

- Price, fee, time, cancellation, and confirmation are clear.
- Payment or reservation failure has recovery.
- Native wallet/payment paths are considered where relevant.
- Support/contact and receipt paths exist.
- Legal or policy text is readable and accessible.

### Search, Map, Discovery

- Search is immediately available.
- Filters are understandable, removable, and resettable.
- Map/list relationship is clear when geography matters.
- Empty and no-results states help the user recover.
- Recent, saved, or repeated tasks are easy to resume.

### Account, Utility, Service

- Sensitive settings are protected from accidental changes.
- Status, next action, and support route are visible.
- Offline or degraded mode preserves useful information.
- Notifications and permissions are tied to user value.

## Native Feel Checks

- The app does not look like a web page squeezed into a phone.
- Navigation, sheets, pickers, and gestures match platform expectations.
- Checkout, auth, account, and support flows preserve trust.
- Safe areas and system bars are respected.
- Platform differences are either intentionally adapted or documented.

## Evidence Expectations

- Compact phone proof.
- Larger phone proof where layout changes.
- Tablet/landscape proof when in scope.
- Text scaling proof for changed screens.
- Key state proof: loading, empty, error, offline, permission, validation, success.
- Accessibility evidence when implementation exists.

## Generic AI-Mobile Warning Signs

- Gradient hero dominates a task-first screen.
- Many rounded promo cards compete for attention.
- Bottom navigation has too many destinations.
- Swipe-only actions.
- Webview checkout without native trust affordances.
- Tiny gray legal or price text.
- Excessive blur, glass, bokeh, or decorative charts.
- Dashboard widgets where the user needs one clear task.
