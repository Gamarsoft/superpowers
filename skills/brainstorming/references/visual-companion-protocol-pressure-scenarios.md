# Visual Companion Protocol Pressure Scenarios

Use these named pressure scenarios when evolving the visual-companion workflow. They extend `references/test-scenarios.md` with M003's protocol-specific failure family and are meant to keep authored workflow guidance aligned with the real decision sequence.

Keep scenarios synthetic, protocol-focused, and reusable. They are not runtime logs.

## first qualifying visual turn starts the companion path

### Setup

User says:
> I can picture two onboarding layouts, but I need to see them side by side before I choose.

The session has stayed terminal-only so far. The user already accepted that browser visuals are allowed if they become useful.

### Required outcome

The first later turn that is genuinely visual must start the companion path instead of remaining terminal-only. The workflow should treat this as the moment to author a comparison artifact, show the user something viewable, and continue the decision from there.

### Failure signature

Failure if:
- the docs allow the agent to keep discussing the choice purely in terminal after a qualifying visual turn appears
- the workflow treats browser use as optional hand-waving instead of a required path once the turn is materially easier to judge by seeing
- the first qualifying visual turn can be skipped without violating the authored protocol

### Why current docs miss this

The current authored docs define when the companion is useful, but they do not yet state that the first later genuinely visual turn must start the companion path rather than staying terminal-only.

## artifact-first sequencing before the terminal prompt

### Setup

User says:
> Show me the two dashboard navigation directions and then ask which one we should carry forward.

A qualifying visual turn is already in progress.

### Required outcome

The agent must author or refresh the visual artifact first, make it viewable, tell the user what they are looking at and what decision it supports, and only then ask the terminal decision or confirmation prompt.

### Failure signature

Failure if:
- the docs permit asking the terminal decision question before a viewable artifact exists
- the browser turn can begin with a prompt instead of an artifact the user can inspect
- the sequencing between artifact delivery and terminal confirmation is ambiguous enough that either order appears compliant

### Why current docs miss this

The current guide explains how to write screens and how to iterate, but it does not yet lock the per-turn protocol to artifact-first sequencing before the terminal prompt.

## question-tool continuity after earlier browser use

### Setup

Earlier in the session, the user already saw one browser artifact and gave feedback. A new qualifying visual turn now needs another comparison or recommendation.

### Required outcome

Even after earlier browser use, the agent must still deliver the terminal decision prompt for each qualifying visual turn through the platform's dedicated question tool when that tool is available. Prior browser activity does not waive the decision-prompt requirement.

### Failure signature

Failure if:
- the docs imply that once the companion has already been opened, later qualifying visual turns may rely on freeform terminal text instead of the question tool
- the terminal decision prompt becomes optional after an earlier browser round
- continuity of the question-tool requirement depends on whether the browser was already used in the same session

### Why current docs miss this

The current workflow prefers the platform question tool in general, but it does not yet say explicitly that the terminal decision prompt must remain present for qualifying visual turns even after earlier browser use.

## explicit degraded fallback when the question tool is unavailable

### Setup

A qualifying visual turn needs a terminal decision prompt, but the current platform's dedicated question tool is unavailable in this environment.

### Required outcome

The agent may fall back to plain terminal text for the decision prompt, but the docs must name that as degraded behavior explicitly. The fallback should preserve the same framing and should not silently redefine the normal protocol.

### Failure signature

Failure if:
- the docs allow plain terminal fallback without naming it as degraded behavior
- question-tool unavailability silently changes the protocol instead of exposing a bounded fallback state
- the fallback wording is implicit enough that later edits could normalize the degraded path as if it were the standard flow

### Why current docs miss this

The current authored workflow allows plain-text fallback when the tool is unavailable, but it does not yet describe that path as an explicit degraded fallback within the visual-companion protocol.
