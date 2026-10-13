The next handoff is the separate frontend-direction session. The neutral spec has already passed independent review and user approval; carry those decisions forward without restarting discovery. Frontend packet status remains `required-pending`.

Use the prepared bootstrap: [courier frontend follow-on](docs/superpowers/specs/courier--frontend-follow-on.md), with the approved [courier product spec](docs/superpowers/specs/courier.md) as the product authority.

Ready-to-paste continuation:

> Continue frontend direction for the courier dispatch dashboard using `docs/superpowers/specs/courier--frontend-follow-on.md` and the approved, independently reviewed `docs/superpowers/specs/courier.md`. Reuse the recorded product decisions, scope and first delivery boundary; do not restart discovery. Preserve existing dispatch queues. Native Android handheld support is required, and the existing Android app is Kotlin. Carry that platform and stack constraint into the implementation-facing targets; a web mockup cannot establish an approved native target.
>
> Resolve the remaining mobile layout and error/retry states in this separate session. Carry the spec's flows, screen families, constraints and copy decisions forward; explicitly identify remaining copy gaps and failure-state behavior rather than inventing prior agreement. Temporary web concepts may support a decision, but they are not approved UI. Every implementation-facing reference needs explicit reference-intent approval. Return the durable frontend packet with exact targets, state coverage, copy, verification expectations and evidence under the packet finalization contract.
>
> Finding: the supplied, already opened `fixtures/offline-v3.md#replay` says installed transport 3.1 requires caller-owned persistent replay. Applies/limits: this finding covers the installed 3.1 transport; the v5 automatic-persistence announcement does not apply, and upgrading is excluded. No recovery test has run. Preserve caller-owned replay as the recovery responsibility and carry the recovery verification gap into the packet and subsequent planning; do not claim recovery works or that transport supplies persistence. Resolve the visible failure/retry experience consistently with that responsibility.
>
> Keep packet status `required-pending` until the user explicitly approves the separate packet. If evidence is degraded, record every material limit and obtain explicit approval of those constraints before using `approved-with-degraded-evidence`. A deadline, a teammate's request or an unapproved mockup does not satisfy that gate. Do not route or start UI implementation from this continuation.

GSD remains the likely delivery fit because you prefer continuity with the active milestone, but no route is confirmed. After separate packet approval, ask for confirmation of exactly one delivery route. Only then create its adapter and routing metadata; independently review that adapter before transition. For confirmed GSD, prepare the handoff and steering note with requirement lineage reconciled against the existing milestone.

Material limit: this handoff can start frontend direction, not implementation. The mobile target is unresolved, the packet lacks approval, and recovery remains untested. The CEO's demo deadline changes none of the recorded approval or native-device constraints.
