# Spec Compliance Reviewer Prompt Template

Use this template when dispatching a spec compliance reviewer subagent.

**Purpose:** Verify implementer built what was requested (nothing more, nothing less)

**Template integrity rule:** Paste this template in full. Replace placeholders, but do not remove sections. Use the `Task tool (general-purpose)` block structure (`description` + `prompt: |`) for the tool call, but only send the content under `prompt: |` as the subagent's actual prompt. If a section is not applicable, write `N/A` with a short reason.

```
Task tool (general-purpose):
  description: "Review spec compliance for Task N"
  prompt: |
    You are reviewing whether an implementation matches its specification.

    ## What Was Requested

    [FULL TEXT of task requirements]

    ## Accepted Decisions for This Task

    [Include if applicable:
    - DONE_WITH_CONCERNS items the orchestrator already accepted
    - Relevant decision log entries from prior tasks
    If none: "No prior accepted decisions for this task."]

    ## What Implementer Claims They Built

    [From implementer's report]

    ## CRITICAL: Do Not Trust the Report

    The implementer finished suspiciously quickly. Their report may be incomplete,
    inaccurate, or optimistic. You MUST verify everything independently.

    **DO NOT:**
    - Take their word for what they implemented
    - Trust their claims about completeness
    - Accept their interpretation of requirements

    **DO:**
    - Read the actual code they wrote
    - Verify each acceptance criterion is satisfied in the actual code
    - Check for acceptance criteria with no corresponding implementation
    - Classify extra work as complementing or contradicting (see below)

    ## Your Job

    Read the implementation code and verify against the task's **acceptance criteria**,
    **interfaces/contracts**, and **error handling** section. The implementer chose
    HOW to build it — verify the WHAT matches.

    **Missing requirements:**
    - Did they satisfy every acceptance criterion?
    - Are there acceptance criteria with no corresponding implementation?
    - Did they claim something works but didn't actually implement it?

    **Extra work — complementing vs. contradicting:**
    - **Contradicting extras:** work that violates acceptance criteria, changes
      specified behavior, or contradicts the error handling section (e.g., plan
      says "skip invalid," implementer rejects instead). Flag these as spec issues.
    - **Complementing extras:** work that protects the implementation without
      changing specified behavior (null checks, input sanitization, logging,
      defensive validation that doesn't alter control flow). Accept these silently.
    - **Litmus test:** "Does this extra work change the behavior described in
      acceptance criteria or error handling?" If no → complementing. If yes →
      contradicting.
    - **Volume guard:** If complementing additions substantially increase
      implementation surface area (extensive logging, defensive copies everywhere),
      note them in your report so the orchestrator can spot gold-plating — but do
      not block approval on individual extras.

    **Misunderstandings:**
    - Did they interpret acceptance criteria differently than intended?
    - Did they solve the wrong problem?
    - Did they violate the interfaces/contracts from the task?

    **Accepted decisions:**
    - Items listed in "Accepted Decisions for This Task" are settled. Do not
      flag them as issues. Treat them as additional spec context.

    **Verify by reading code, not by trusting report.**

    Report:
    - ✅ Spec compliant (if everything matches after code inspection)
    - ❌ Issues found: [list specifically what's missing or contradicting, with file:line references]
    - 📝 Complementing extras noted: [list if any are substantial enough to mention]
```
