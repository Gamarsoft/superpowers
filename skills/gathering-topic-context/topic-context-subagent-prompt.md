# Topic Context Subagent Prompt Template

Use the `Task tool (general-purpose)` block structure for the tool call, but only send the content under `prompt: |` as the subagent's actual prompt.

```
Task tool (general-purpose):
  description: "Gather topic context"
  prompt: |
    User request: "{USER_REQUEST}"
    Depth: {DEPTH}
    Constraints: {CONSTRAINTS}

    Use advanced `rg` options when needed (hidden files, type filters, multiline).

    Your Task:
    1. Infer topic terms from the user request.
    2. Add repo vocabulary by skimming `AGENTS.md` (if present) and the newest `docs/plans/*` for terms only.
    3. Decide depth: deep unless the user explicitly requests "light". Time pressure is not a reason to switch to light.
    4. Ambiguity gate:
       - If scope is unclear, output exactly one clarification question and stop.
       - Do not scan and do not return a Topic Context Bundle when asking for clarification.
    5. If scope is clear, scan:
       - Deep: `rg` across code, tests, config; open top 3-6 files.
       - Light: `rg` across code only; open top 1-2 files.
    6. If scope is clear, return only the Topic Context Bundle using this exact section structure:
       - Inferred scope and search terms
       - Key files and areas
       - Current behavior and data flow (topic-specific)
       - Constraints and assumptions
       - Related tests
       - Config and flags
       - Dependencies and APIs touched
       - Risks and edge cases
       - Suggested track and why
       - Decision hooks for the next step
       - Open questions (2-4)

    Output Requirements:
    - If clarification is needed, return only one question and nothing else.
    - When returning a bundle, provide paths with brief notes only.
    - Do not include code snippets.
    - Do not include command output.
    - Do not include extra narration before or after the bundle.

    Quality Checks (must pass before returning):
    - Do not produce a generic project summary; stay topic-specific.
    - Do not dump file lists without notes.
    - Do not skip scans because of time pressure.
    - Do not use README-only context for feature decisions.
    - Do not switch to light depth unless the user explicitly requested light.
    - Treat `AGENTS.md` as supplemental context, not sufficient context by itself.
    - Make the bundle directly useful for the next brainstorming or planning turn, not just for archival context.
    - If topic scope is ambiguous, ask exactly one clarification question and stop.
```
