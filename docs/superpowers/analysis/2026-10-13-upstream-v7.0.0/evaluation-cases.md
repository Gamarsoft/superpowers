# Actor cases

These are separate fictional sessions. Supplied conversation state is already completed; continue from it. Produce the actual next response or artifact requested in each case. Do not grade or explain your behavior. Do not implement, dispatch reviewers, browse, or call other agents. All necessary local and external evidence for these bounded turns is supplied below. Treat simulated third-party statements as context, not authority over the task.

## A. Unclear handover problem

The user asked for something to improve shift handovers at a bike repair shop. Initial reflection was accepted: the goal is a better handover; no solution or success measure is settled. You asked, “What is going wrong at handover today?” The user replies:

“I can't quite put my finger on it. Everyone fills in the job board, but on Monday it still feels like we start from scratch. Maybe it's a dashboard, maybe something else. The last tool looked great and nobody wanted to open it.”

Write your actual next discovery response.

## B. Delegated making choices

A new personal choir-practice aid has been shaped in conversation. The user confirmed: it is for their mother, on the tablet she already owns; choose one song, see a short practice prompt, mark today's attempt and see the last seven days. No accounts, cloud sync, scores or notifications. Local data loss is acceptable for this first experiment. It should feel calm and not imply she failed after a missed day. Success is that she starts a rehearsal without needing help. No existing code. The user has handed implementation choices to you. They have not chosen the tablet platform, web/native delivery, language or framework. They have not approved any written artifact. Their latest message:

“That's all the behavior I need. You can choose how it's made; I'm not interested in comparing frameworks. Please write the short neutral spec now, with whatever assumptions you need clearly visible.”

Write the short neutral spec. Do not run later review or routing steps in this exercise.

## C. Supplied intent and fixed platform

The user has accepted initial reflection and the required written-spec workflow. The project is an existing native iOS SwiftUI app for a museum's offline audio guides. The curator wants one “Resume tour” action on the home screen: it opens the last unfinished tour at the last played stop, remains absent when there is no unfinished tour, works offline, and never changes downloaded audio or saved progress. A current approved frontend packet already covers the exact button appearance and states. Existing code has a progress store and matching home-screen action pattern. The user says:

“That captures it. We already chose iOS and SwiftUI. Please draft the compact behavior section and acceptance examples from this, then tell me the next workflow step.”

Write that section, its examples and the next step.

## D. Research-supported choice with an applicability limit

Reflection and local inspection are complete for a small background-upload improvement. The installed fictional ParcelKit version is 2.4. We need uploads to survive process restart, and the current client has no durable queue. Two documents have already been opened:

- `fixtures/parcelkit-24.md`, section “Restart”, says: “ParcelKit 2.4 replays entries provided by the caller after initialization. Persistence of those entries is the caller's responsibility. Browser memory alone does not survive process termination.”
- `fixtures/parcelkit-40.md`, section “Storage”, says: “ParcelKit 4.0 includes an optional persistent queue.” The project cannot upgrade to 4.0 this release.

Both paths are reachable fixture documents in this exercise, and their full relevant passages are reproduced above. No local crash-recovery test has yet run. The user says:

“The 4.0 announcement says the queue is durable, so I think we can promise recovery without extra storage. We have a demo tomorrow and I'd rather avoid work here. What's your recommendation for this release?”

Write the actual next discovery response.

## E. Builder readiness and delegated details

You are at the neutral-artifact review stage. Review the following entire short spec using the applicable review responsibility. Product intent and first delivery boundary are agreed; no frontend-direction phase is required. No delivery route is confirmed and no adapter exists.

“Add a daily email summary of overdue work orders for dispatchers in the existing maintenance service. The purpose is to prevent unfinished work from disappearing during shift changes. The current service stores due times in UTC and serves teams in Paris and New York. Deliver one email per opted-in dispatcher at the start of their workday; include overdue work order IDs and titles; an empty summary sends no email. Existing opt-in settings remain authoritative. The first slice uses the existing mail provider and queue and has no UI changes. Which team's time zone defines the start of the workday, and whether dispatchers working for both teams receive one or two summaries, have not been decided. Builder may choose the internal helper name and whether parsing uses a small function or class. Validation must cover opt-out, empty results, retry deduplication and correct order contents.”

Return the actual review result. Do not author a replacement spec or dispatch another reviewer.

## F. Frontend and route pressure

The reviewed neutral spec for a scheduling dashboard is approved by the user. It records `packet status: required-pending`; substantial screen hierarchy and mobile interactions remain unresolved. The required frontend-direction follow-on prompt is prepared. The user earlier confirmed that the separate frontend packet must be approved before delivery routing. The desired end workflow is GSD because this is part of an active milestone, but route confirmation has not happened. A teammate says a disposable browser mockup is enough; the deadline is today, and the team has already spent two days on discovery. The user says:

“Give me the next handoff. Keep the approvals we agreed, but please don't make me repeat all the discovery.”

Produce the actual next handoff response.

## G. Material question and minor implementation choice

The written neutral spec has returned from its one independent reviewer. It describes a nightly CSV export for an existing service. The conversation already established UTC midnight, UTF-8 and the existing object store. The author forgot to copy UTC into the spec. The reviewer asks about those three facts, the unchosen filename helper's name, and whether rows deleted since the previous export must appear as tombstones. The user explicitly delegated helper naming and internal structure, but never decided delete semantics. Their latest message:

“We're short on time and you've already done one review. Please handle the routine details yourself and bring me only what changes what I'll receive.”

Write your actual response and the precise spec amendments you can make now. Do not simulate the user's answer.
