# External research during brainstorming

Status: design approved by the user in this chat on 2026-10-01.

Approved neutral revision: SHA-256
`f30607a9add8efdef62a8a542a882689a5cb21f07b4d6ba6136c745408105eab`.

Track: architecture-led change. Frontend packet status: not-required.

## Purpose and chosen direction

Superpowers brainstorming should investigate external facts before they shape a
guided question, its viable options, or its recommendation. Research applies to
product, domain, UX and technical decisions. It runs when a material factual
unknown needs outside evidence, rather than before every question.

The user confirmed this breadth and authorized proceeding with the recommended
cadence on 2026-10-01. Work takes place in the base checkout on
`codex/brainstorming-decision-research`, as subsequently requested.

The first delivery adds this behavior to the existing brainstorming workflow,
preserves the evidence behind consequential choices in its neutral spec, and
allows subsequent planning to reuse applicable findings. It retains local
context gathering, reflection, one guided question per message, written specs,
independent review and user approval.

## Problem and success signal

The primary users are people shaping a change with a Superpowers agent and the
agents that later plan that change. Current brainstorming gathers topic-specific
repository context before reflection. External library research is explicitly
required during planning, but brainstorming has no corresponding contract for
evidence behind its questions or for retaining that evidence in its spec.

Success means a consequential external claim is checked before it influences a
choice, the human can follow its source and limits, and a fresh planner can
recover why the selected approach fits. A settled preference or a question
already answered by current local evidence should incur no additional research.

The baseline exercises for this design use synthetic sources. They can establish
behavior within those exercises, not the quality of live search rankings or the
cause of the user's earlier GSD source-selection experience.

## First delivery boundary

In scope:

- A conditional research step within guided discovery, after local context and
  reflection have established the goal.
- A focused supporting reference for source selection, applicability, evidence
  presentation, stopping and failure behavior.
- Evidence alongside research-informed questions and option cards.
- A conditional evidence section in the neutral spec and corresponding review
  checks.
- Reuse of matching, sufficiently detailed research in planning and Context7
  work, with new research for material gaps or changed conditions.
- Before/after behavioral exercises and applicable existing regression checks.

Out of scope: a GSD configuration dependency, a global research setting, a new
mandatory researcher role, persistent cross-project research caching, a general
research service, changes to delivery routing or role pins, and implementation
of the features being brainstormed. Product and UX evidence may inform behavior
choices; the separate frontend-direction packet workflow remains intact.

## Research behavior

### Identify the decision before choosing a source

For the next discovery decision, distinguish what local evidence already
establishes, what only the user can choose, and what depends on an external fact.
Research is warranted when resolving that last category could change a viable
option, recommendation, first delivery boundary, invariant or material risk.

Use the actual uncertainty and applicability constraints to frame the lookup.
For example, check whether the installed library version supports a required
recovery behavior, or whether a UX study covers the intended users and task.
Generic popularity or "best practices" searches are insufficient by themselves
to settle either question. Explicitly requested external research still runs.

The initial reflection need not wait for a broad research pass. Reading a
user-supplied reference to understand the request remains ordinary context
gathering. Detailed design choices still follow reflection.

### Select and inspect evidence

Choose sources for the particular claim. Version-matched official documentation,
source and release notes establish documented software behavior. Standards bodies
establish what their standards say. Original studies and observed product usage
provide evidence about their populations and tasks. A vendor claim describes
what the vendor asserts; it does not establish a comparative benefit by itself.

Search engines and Context7 are retrieval mechanisms. Inspect the underlying
source and its applicability rather than assigning confidence from the tool's
name, result rank or retrieval date. Open the relevant source passage for a claim
that will determine the recommendation; a search snippet alone is not enough.

Preserve useful existing behavior: match versions and deployment conditions,
distinguish current evidence from stale material, trace repeated articles back
to their original evidence, and keep study limitations visible. For a material
comparison, check evidence that could contradict the preferred option. One
direct, applicable source can establish a narrow factual claim; extra source
counts are not a universal requirement. Absence of a finding does not establish
that a capability is impossible.

Use existing Context7 research for library-specific questions when applicable.
If that retrieval mechanism is unavailable during brainstorming, available
official sources can still inform the discussion. This does not waive any
existing pre-implementation verification requirement.

### Present findings and ask one question

A research-informed discovery response contains:

1. A short account of the findings that change the choice, with direct source
   links or precise local source references and material applicability limits.
2. The recommendation and its project-specific trade-off, distinguishing an
   inference from a documented fact where the distinction matters.
3. One framed question, normally with two or three viable options.

Do not reproduce a research report in every turn. Reuse already established
findings by reference when needed. Research does not turn the agent's inference
into a user decision, supply evidence for an unstated customer preference, or
override a confirmed constraint silently.

### Stop, reuse and handle uncertainty

Stop when the evidence is sufficient to frame the current choice honestly, or
when available sources cannot resolve its uncertainty. Continue searching only
if a concrete missing fact could still change that choice; do not expand into a
general ecosystem survey or repeat searches to polish the answer.

Reuse findings when the claim, version, environment, population or other relevant
conditions still match, and the source is sufficiently current for that claim.
A recorded access date does not make old material current. Recheck on a material
change, conflicting evidence, a stale time-sensitive claim, or an unresolved gap.

If research is unavailable or inconclusive, state what is unknown and which
decision it affects. Continue independent preference and scope questions. Offer
a viable narrower or reversible option when one exists, without inventing new
product scope. An unsupported capability stays an open dependency or an explicit
conditional boundary; it must not become a verified requirement. If new evidence
conflicts with a previously approved choice, surface the conflict for a bounded
decision instead of silently changing that choice.

## Durable evidence and downstream use

When external evidence materially shaped a choice, the neutral spec includes a
compact evidence section or a linked appendix. Each consequential finding keeps:

- the supported claim and a direct source locator;
- the relevant version, environment, population or scope, as applicable;
- the source date/version and access date when freshness matters;
- limitations, contradictions or unresolved observations that affect its use;
- the decision it informed, distinguishing the evidence from the chosen policy.

Keep only findings needed to understand or verify the design. Unsuccessful
research retains the unresolved claim, why it remains unresolved and the decision
or later verification it blocks. Do not fabricate dates or copy whole sources.
For a local source, use a precise path and relevant location rather than implying
that it is a publicly accessible URL. Omit the section when no external evidence
affected the design.

Planning consumes this evidence as part of the approved spec. Findings can
satisfy already-completed documentation research when they cover the exact API,
version, configuration and caveats the plan needs. Otherwise research the missing
portion. A high-level product finding is not proof that an implementation API is
correct. Local tests and verification remain required regardless of documentation.

## Integration and invariants

The intended changes are concentrated in `skills/brainstorming/SKILL.md`, a
supporting research reference, its guided-choice and option-card guidance, its
spec template and review checklist, and its behavioral scenarios. The smallest
necessary reuse clarification may also affect `skills/context7-research/SKILL.md`
and `skills/writing-plans/SKILL.md`; it requires its own baseline exercise before
editing those instructions.

Keep `gathering-topic-context` focused on the codebase. Preserve its existing
depth, retrieval budget and role selection. The controller can perform a small
lookup directly. Research delegation is optional and remains subject to the
platform's authorization and model policies; this design introduces no new
mandatory agent, model pin, review pass or tool dependency.

Preserve the current written-spec path, reflection order, one-question cadence,
neutral artifact review, correction limits, user approval, frontend separation
and exactly-one-confirmed-delivery-route contract. No change to source trust
allows retrieved content to become executable instructions.

## Alternatives considered

| Approach | Benefit | Cost and reason for selection |
| --- | --- | --- |
| Research when a decision needs external facts | Focuses effort on evidence that can change the choice; permits follow-up as the discussion evolves | Requires judgment about material uncertainty; selected by the user |
| Research before every discussion area | Simple cadence and broad coverage | Adds work to local facts and preferences; may introduce irrelevant evidence |
| Broad research after framing, before discovery | Useful for unfamiliar domains with many shared unknowns | May study options later ruled out and delay the first useful question; available when the particular decision warrants it, not the default |

## Example mapping and acceptance

| Situation | Required observable behavior |
| --- | --- |
| Search returns current documentation for version 4 while the repo uses version 2 | Inspect applicable version evidence before recommending; cite it and do not assign version 4 capabilities to version 2 |
| Three articles repeat one vendor study on a different population | Treat them as one underlying study, retain applicability limits, and avoid presenting repetition as independent corroboration |
| A company glossary settles a label and no empirical question remains | Preserve the chosen term and proceed without an external research detour |
| Search is unavailable and regional capability is unverified | Expose the uncertainty and its affected decision; continue independent discussion without presenting the capability as established |
| Current session findings already cover the same version and scope | Reuse them; investigate only newly material unknowns |
| A researched choice moves into a short spec | Retain its claim, source, applicability, limitations and decision connection so a fresh planner can check it |
| Planning needs API details absent from the brainstorming evidence | Research the missing details while reusing the supported findings; keep implementation verification intact |
| Research contradicts an approved choice | Surface the conflict and ask one bounded question; do not silently replace the approved decision |

## Validation and release boundaries

Use the current skills as the no-new-guidance control. Run at least five fresh
samples per tested wording variant, then inspect each output manually. Cases
within a single agent are correlated and must be reported as such. Separate
correct evidence interpretation, source traceability, retained spec evidence,
research reuse, appropriate skipping and workflow invariants when scoring.

Only claim improvement on dimensions where the baseline actually fails. Preserve
baseline successes as regression checks. Run the same pressure cases against the
candidate, including time pressure, an attractive prior sketch and authoritative
but inapplicable material. If an added rule has no demonstrated failure to fix,
narrow or omit it rather than adding prose for its own sake.

Validate modified skill metadata and links and run applicable existing
brainstorming artifact checks. Evidence from controlled fixtures is not live
retrieval acceptance; report that limitation. A later live trial can assess query
quality and source discovery without making that a claimed result of these tests.

No unresolved user decision blocks this design. Exact wording and reference
placement remain implementation choices. Automatic research configuration,
cross-session cache infrastructure and a dedicated researcher role are deferred.

## Source context

- `skills/brainstorming/SKILL.md`, especially local context, reflection, guided
  discovery, stopping and neutral artifact gates.
- `skills/gathering-topic-context/SKILL.md`, its repository scope and retrieval
  budget.
- `skills/context7-research/SKILL.md` and `skills/writing-plans/SKILL.md`, existing
  version-aware documentation research and downstream findings.
- `/Volumes/Workspace/Tools/AI/gsd-core/gsd-core/workflows/discuss-phase/modes/default.md:20`,
  per-area research before questions.
- `/Volumes/Workspace/Tools/AI/gsd-core/gsd-core/workflows/quick.md:274`, evidence
  before discussion decisions become locked planning context.
- `/Volumes/Workspace/Tools/AI/gsd-core/agents/gsd-advisor-researcher.md:57`, the
  comparison output and tool-based trust ordering.
- `/Volumes/Workspace/Tools/AI/gsd-core/agents/gsd-phase-researcher.md:28`, stronger
  claim-provenance rules in the full phase researcher.
- [Context7 API guide](https://context7.com/docs/api-guide), inspected 2026-10-01:
  source selection and version pinning are available retrieval controls, not
  guarantees that a returned claim applies to the current decision.

## Delivery Route

- Recommendation: Superpowers, because this bounded skill change needs a saved
  task plan, before/after behavioral evidence and independent review.
- Confirmed route: Superpowers.
- Neutral artifact approval: `../analysis/2026-10-01-brainstorming-research/spec-review.md`
  records READY; the user's following reply was "approved".
- Confirmation: approved continuation of the existing Superpowers workflow in
  this chat. The controller retains that route under the session's authorization
  rather than reopening the workflow choice.
- Delivery output: the single writing-plans invocation recorded in
  `../analysis/2026-10-01-brainstorming-research/delivery-adapter.md`.
- Delivery review: approved, `/root/decision_research_adapter_review` returned
  READY on 2026-10-01; see the recorded adapter review.
