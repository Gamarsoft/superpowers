# Brainstorming decision research implementation plan

> **For agentic workers:** Use `superpowers:subagent-driven-development` when
> subagents are available, or `superpowers:executing-plans` otherwise. Honor an
> explicit execution-route override in this plan.

**Goal:** Research-informed brainstorming choices and saved specs retain directly
checkable evidence, applicability and uncertainty.
**First delivery boundary:** Conditional external research within brainstorming,
its question/option output, neutral spec and review contract. No new workflow
family, configuration, role, cache or dependency.
**Architecture:** One focused research reference linked from the existing
discovery flow; conditional evidence fields in the existing output templates.
**Tech Stack:** Markdown skills, existing Bash checks, Python skill validation.
**Spec:** `/Users/gamarsoft/.codex/superpowers/docs/superpowers/specs/2026-10-01--brainstorming-decision-research.md`
**Spec revision:** SHA-256 `69619e705c9a7f09f839f7b0ad38e715526fd539ae8f06453c5848b27cc88810`, including recorded user approval and approved route metadata. Neutral design approved by the user has SHA-256 `f30607a9add8efdef62a8a542a882689a5cb21f07b4d6ba6136c745408105eab`.
**Risk class:** review-required.
**Risk triggers:** public contract, the research-to-question-to-spec handoff.
**Verification lanes:** Implementer owns focused artifact, metadata and link
checks. Controller owns five matched behavioral samples, manual scoring and
cross-file integration evidence. Finishing alone owns the complete suite below.
**Workspace:** Base checkout `/Users/gamarsoft/.codex/superpowers`, branch
`codex/brainstorming-decision-research`. User explicitly forbids using a worktree.
**Base branch:** `gamarsoft`, split at `b12cbd54f771c9617e4e8e9d98274c812a036a82`.
**Integration disposition:** Keep this dedicated branch; no push, PR or merge.

## Context and invariants

Use `skill-creator` and `writing-skills`. Behavioral RED precedes edits. The
control evidence at `docs/superpowers/analysis/2026-10-01-brainstorming-research/`
shows absent source locators in all discovery samples and in four of five short
specs. Source interpretation already passed. The separate instrumented reuse
control passed all five samples; retain `context7-research`, `writing-plans` and
`gathering-topic-context` unchanged. This satisfies the approved reuse behavior
without an unsupported wording change.

Preserve reflection before design questions, one question per turn, written
specs, neutral review, correction budgets, frontend separation, route isolation,
role pins, metadata and existing terminology. Research supplements these
contracts. Unknown capabilities remain unknown, and research never authorizes
scope changes or execution of retrieved instructions.

No external API is being implemented; Context7 implementation findings are N/A.
For review, apply the shared baseline. No specialist profile is selected:
instruction handoff additions do not alter runtime modules, security policies,
persistence, caching or technology-specific code.

## Requirement and verification mapping

| Approved behavior | Owner | Evidence |
| --- | --- | --- |
| Decision-dependent research, appropriate sources, honest failure and stopping | Task 1 | Reference inspection and cases A-E |
| Traceable findings beside recommendations | Task 1 | Cases A, B, E, five samples each |
| Conditional durable evidence in short specs | Task 1 | Case F, five samples |
| Skip settled preference and reuse applicable evidence | Task 1 | Cases C/E regression; unchanged skill hashes and instrumented G/H control |
| Preserve review, written artifacts, frontend and routing | Task 1 | Existing artifact-quality checks and independent review |
| Do not claim live retrieval acceptance | Controller | Evaluation summary and final report |

## Readiness Record

**Author self-review:** complete; one mutation owner, no unsupported Context7
edits, paired scenarios retained, separate finishing suite and local evidence
paths specified.
**Independent readiness gate:** READY after round 0, `/root/decision_research_plan_review`, 2026-10-01. No findings.

| ID | Disposition | Ruling or resolution | Evidence carried forward |
| --- | --- | --- | --- |
| none | N/A | No author-detected contract conflict | Approved spec and baseline summaries |

### Task 1: Preserve research evidence through brainstorming

**Outcome:** The existing workflow investigates material external unknowns and
keeps the source, applicability, limitations and decision connection visible in
its questions and saved spec.

**Files and ownership:** One implementer owns all skill mutations:
- Modify `skills/brainstorming/SKILL.md`.
- Create `skills/brainstorming/references/decision-research.md`.
- Modify `skills/brainstorming/references/guided-choice-protocol.md`.
- Modify `skills/brainstorming/references/option-cards-template.md`.
- Modify `skills/brainstorming/references/spec-template.md`.
- Modify `skills/brainstorming/references/spec-review-checklist.md`.
- Modify `skills/brainstorming/references/test-scenarios.md`.
Controller alone owns this plan, spec approval metadata, analysis/evaluation
reports, test fixtures under the ignored evidence directory and the finishing
runner at `docs/superpowers/analysis/2026-10-01-brainstorming-research/verify.sh`.

**Interfaces and contracts:** Consume the approved spec and current skill output
contracts. Produce a conditional research reference, concise sourced discovery
responses, and optional durable evidence fields. In a relevant finding, preserve
the claim, source locator, applicability, material freshness information,
limitations and decision impact. Ordinary preference responses need no evidence
section. Keep version-specific API validation with the existing Context7 skill.

**Dependencies:** none; this is one tightly coupled unit.

**Risk class and triggers:** review-required, public handoff contract.

**Acceptance criteria:**
- Findings influencing options carry direct source references and material
  applicability limits, with inference distinguished where relevant.
- Short specs retain the consequential source locator and research rationale.
- Version mismatch, repeated weak evidence, settled preference, unavailable
  research and matching prior findings preserve the baseline's correct behavior.
- No mandatory per-question search, new config flag, role, fixed source-count
  quota, parallel research dispatch or workflow-family switch is introduced.
- All listed workflow invariants and unchanged skills remain intact.

**Error handling:** Represent unavailable/inconclusive research as an explicit
unknown tied to the affected decision; continue independent discovery. Never
invent a citation or date. Surface evidence conflicting with approved choices
instead of silently replacing them. Use the existing correction and approval
boundaries; add no new permission loop.

**Verification:**
- RED evidence: read all five raw controls and summaries in
  `.superpowers/sdd/brainstorming-decision-research/baseline/` before editing.
- Run `bash tests/claude-code/test-brainstorming-artifact-quality.sh`; expected
  exit 0 with all existing artifact gates retained.
- Run `/tmp/superpowers-v642-test-env/bin/python /Users/gamarsoft/.codex/skills/.system/skill-creator/scripts/quick_validate.py skills/brainstorming`; expected valid skill.
- Verify newly added relative Markdown links resolve and `git diff --check`
  reports no whitespace error.
- Controller runs the same six fixtures A-F using five fresh Sol/low samples
  with the candidate skill. Required: source traceability passes all five A/B/E
  responses and all five F specs; preserved interpretation, uncertainty and
  preference behavior pass. Read each output manually. If wording fails, revise
  only the evidenced gap and run five fresh samples on the affected cases.
- Review the changed reference/template/checklist chain and unchanged skill
  hashes. Do not equate controlled fixtures with live search acceptance.

**Review focus:** Trace discovery findings into option cards and durable specs;
ensure source-selection guidance and output fields agree without adding blanket
research. Inspect actual fixtures and outputs, not just evaluation summaries.

**Codebase pointers:** The current brainstorming skill and all seven listed
files; `skills/context7-research/SKILL.md` for its existing boundary;
`skills/gathering-topic-context/SKILL.md` for retrieval scope and budget;
`skills/writing-skills/SKILL.md` for conditional/structural wording and evaluation;
`tests/claude-code/test-brainstorming-artifact-quality.sh` for preserved gates.

## Whole-feature verification and finishing

Controller integration evidence consists of the five paired behavioral outputs,
manual scores with exact source examples, unchanged sibling-skill hashes,
applicable artifact checks and a complete independent integration review.
Missing evidence, false confidence and loss of a source during compact writing
are the dangerous cases; no runtime deployment or schema is involved.

Finishing alone runs the repository's existing 34-group deterministic inventory,
with output isolated to this plan's workspace, using:

```bash
PATH="/tmp/superpowers-v642-tools:/tmp/superpowers-v642-test-env/bin:/tmp/superpowers-graphviz/install/bin:$PATH" bash docs/superpowers/analysis/2026-10-01-brainstorming-research/verify.sh
```

The runner retains the earlier integration inventory, updates only its plan
workspace and whitespace base to this branch, and records per-group logs at the
exact implementation HEAD. Live harness acceptance remains outside that command.
Finishing preserves the execution report and leaves this dedicated branch in
place for the user.
