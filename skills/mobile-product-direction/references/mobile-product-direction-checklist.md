# Mobile Product Direction Checklist

Use this reference when creating mobile-first flow direction, a frontend packet, or a GSD handoff.

## Source Anchors

- Apple Human Interface Guidelines: native platform behavior, layout, navigation, motion, privacy, and iOS polish.
- Material Design 3: cross-platform component grammar, layout, navigation, gestures, and content style.
- Android Core App Quality: Android consistency, platform expectations, and Material components where possible.
- NN/g Mobile UX: task focus, navigation, forms, readability, cognitive load, and user behavior.
- W3C WCAG mobile guidance: orientation, reflow, gestures, target size, and motion alternatives.
- Baymard: checkout, booking, account, ecommerce, search, and transactional mobile flows.
- Mobbin/Pttrns: pattern mining only; extract conventions, do not clone visuals.

## Product Direction Questions

- What job is the user trying to complete on a phone?
- What is the fastest successful path?
- What is the safest recovery path?
- What must be visible immediately?
- What can move to search, filters, sheets, details, or account?
- What device conditions matter: one-handed use, outdoors, low signal, in motion, payment, identity, privacy, or interruption?
- Which task has the highest trust, safety, money, or time risk?
- Which screens require native platform behavior instead of a web-style flow?

## Screen Inventory Requirements

Include only screens and states needed for implementation direction:

- first run / onboarding
- authenticated and unauthenticated entry
- main task start
- search/browse or dashboard
- details
- creation/checkout/booking/submission
- confirmation
- active status or tracking
- account/support/settings
- recovery and cancellation

## State Matrix

For each important screen, decide whether these states apply:

- loading
- empty
- partial or degraded data
- error
- offline
- permission denied
- validation
- disabled or unavailable
- unauthenticated
- success or confirmation
- destructive or irreversible
- expired, cancelled, delayed, or changed

## Transactional Add-On

For booking, checkout, payment, orders, subscriptions, and accounts, explicitly cover:

- price or cost breakdown
- cancellation/refund/change policy
- saved payment or native wallet path
- confirmation receipt
- support/contact route
- retry/recovery when payment or booking fails
- fraud, privacy, or sensitive data exposure
