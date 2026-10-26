# Focused experience and design-regression judgments

Evaluation scope: policy transfer and review judgment, not a newly rendered outcome. Two fresh samples per source are diagnostic only, not a statistical effectiveness claim. The actual human-rejected Branding r1 remains the observed design failure. No numeric visual-quality scores are assigned.

Candidate source is `0da9cdd2c5564e51078a2ed3a43718d0af7fa6f3`; baseline is `7e6b25dfa6d464d10b7548a037393f1f32400af3`. The later `5033fae` is docs-only according to controller scope and is not the actor source tested here. Actual rendered r2 design and human approval remain pending. Historical 140/140 results are unchanged; this report is a separate campaign. Maintenance/schema were not rerun here.

## Fixture inspection

Both actual attached PNGs were opened and visually inspected. Desktop shows form left, a substantial empty “Actuellement publié” card above a draft card repeating name/hex, a small empty logo area, and publication guidance/button below. Narrow shows compounded gutters (approximately 247px content in 390px), stacked uploads, empty current state, draft, publication and wrapped footer across a long page. The picker is closed in both; horizontal scrolling is reported scenario evidence, not visible screenshot evidence. Empty fixture assets do not prove a populated preview would fail; they do support criticism of the displayed proposal and need for populated-state evidence. Image inspection/critique was evaluation-only: approximately 2 minutes of evaluator attention, not instrumented. No pilot design authoring or implementation time was spent.

## Integrity verification

- `baseline-r1`: all 11 manifest source/input/scenario/fixture/rubric hashes matched retained files. All recorded exits are 0.

  - `experience-01`: fresh ID `01a1775d-ef5b-7213-bcb2-ca9347404497`, completed, only agent-message items, extracted response exactly matches trace.

  - `experience-02`: fresh ID `01a1775d-ef5b-7ac3-8a60-10ae1e8836d0`, completed, only agent-message items, extracted response exactly matches trace.

- `candidate-r1`: all 11 manifest source/input/scenario/fixture/rubric hashes matched retained files. All recorded exits are 0.

  - `sample-01`: fresh ID `01a17761-b014-7081-af07-0c72c2f0e62a`, completed, only agent-message items, extracted response exactly matches trace.

  - `sample-02`: fresh ID `01a17761-b014-7ce2-8e2d-6bde67b5dc76`, completed, only agent-message items, extracted response exactly matches trace.

- `design-regression-r1`: all 21 manifest source/input/scenario/fixture/rubric hashes matched retained files. All recorded exits are 0.

  - `sample-01`: fresh ID `01a17761-b00f-7e41-b96d-bd3dd35356c8`, completed, only agent-message items, extracted response exactly matches trace.

  - `sample-02`: fresh ID `01a17761-b010-7112-873f-f0eb2e575a11`, completed, only agent-message items, extracted response exactly matches trace.

  - `sample-03`: fresh ID `01a17763-247e-7df3-b61a-2a7714a7584a`, completed, only agent-message items, extracted response exactly matches trace.

  - `sample-04`: fresh ID `01a17763-3631-78f3-9b85-6da8ce533e5d`, completed, only agent-message items, extracted response exactly matches trace.

  - `sample-05`: fresh ID `01a17763-b867-7e33-b4aa-3d0aa2538571`, completed, only agent-message items, extracted response exactly matches trace.


All nine IDs are distinct. Commands record fresh ephemeral GPT-6-Astra/medium processes, ignore-user-config and read-only sandbox. No actor tool calls occur in the raw traces. Manifests hash retained inputs; this does not independently attest internal model identity beyond command records.

## Frozen six-point judgments

Interpretation history: initial criterion-5 judgments were FAIL for all four because I looked for an explicit final revised-artifact approval gate. Controller challenged whether this improperly required an immediate request or the literal word exact. On whole-response reread, candidate-01’s selected revision plus “does not itself establish runtime behavior or final approval” and candidate-02’s chosen revision plus “Concept selection would not count as final approval” and pending visual approval are semantically sufficient. Final candidate criterion-5 judgments are PASS; the initial stricter interpretation is retained here, not erased. No approval is needed now because no revised design exists. Baselines lack equivalent revision/approval linkage and remain FAIL on this bounded interpretation. Criterion 3 requires separate friction treatment, not only preserving the rule; candidate-02 still fails.

### baseline-r1/experience-01.md

**1: FAIL.** Reuses facts and recognizes unknowns, but supplies no experience brief resolving or surfacing these missing context choices with recommendation/consequences; goes directly to one polished composition.

> Feature frequency and administrator preparation remain unknown; neither needs to block a first direction.

**2: FAIL.** An unresolved structural choice is not compared. Rejecting fabricated alternatives does not satisfy inexpensive genuine structural comparison here.

> I would not ask for another brief sign-off or fabricate a second concept.

**3: FAIL.** Semantics and shell are preserved, but the friction is treated only as a rule to retain; no separate product decision is surfaced.

> Preserve the selected-light-file requirement even when only the name or color changes.

**4: FAIL.** Correctly holds approval and tackles repeated empty state and mobile distance, but never identifies weak preview feedback or changes the preview content itself. Repositioning the preview is not recognition of its limited feedback.

> Keep one draft preview directly followed by publication readiness and its action.

**5: FAIL.** Separates human evidence and component feasibility and requests subsequent checks, but does not explicitly obtain approval for the exact final revised rendered design. Generic final review/visual approval does not supply that requirement.

> Human comprehension and task completion, which are **not observed**.

**6: PASS.** Direct scoped typo correction with relevant rendered verification; no extra interview, sketches or review chain.

> After editing, inspect the diff and the rendered label for correct text and any wrapping or clipping.

### baseline-r1/experience-02.md

**1: FAIL.** Reuses approved facts, but leaves experience-changing context unresolved without a recommendation about frequency/preparedness and its consequences. Starts one Paper recommendation.

> Feature frequency is unknown, so I’ll avoid optimizing around an assumed expert workflow.

**2: FAIL.** No comparison of the consequential structural choice before polishing.

> I would use the approved spec and start one Paper recommendation.

**3: FAIL.** Preserves semantics and anchors; does not surface the every-publish friction as a separate product decision.

> Preserve the requirement for a **selected** light-logo file.

**4: PASS.** Holds approval, identifies empty-current duplication, weak preview and mobile separation, then changes preview hierarchy and organization with costs. These are visible in the fixtures.

> Make the logo the preview’s visual anchor, with the name and color grouped compactly beside or below it. Keep the favicon visible.

**5: FAIL.** Useful rendered/runtime next evidence and explicit unobserved human use, but no exact final revised-design approval requirement. Final review is generic.

> The next proposed artifact is one revised desktop/narrow pair using the same first-publication content, plus a populated draft state to assess the preview.

**6: PASS.** Checks authoritative string, actual render and scoped diff; bounded maintained evidence does not impose a new approval chain.

> Correct the French typo directly. No Paper exploration, alternatives or new experience discovery.

### candidate-r1/sample-01.md

**1: PASS.** Short brief reuses approved constraints; asks only for correction of missing readiness context, recommends side-by-side desktop versus ordered mobile, and explains space/travel consequences.

> My working assumption would be occasional use with assets available, explicitly marked as an assumption.

**2: PASS.** Two comparable rough structures differ in task relationship; recommendation and tradeoffs precede polish. Routine typo uses direct path.

> Easy edit/result comparison; costs form width.

**3: PASS.** Explicit separate friction record and later preserve-unless-separately-changed statement; no new branding anchors imposed.

> The selected-light-file requirement remains intact; its rebranding friction is recorded separately, not redesigned away.

**4: PASS.** Holds proposal, connects weak preview, empty-current duplication and narrow scroll burden to task, changes preview content and grouping with tradeoffs.

> Users arriving with finished assets get little help judging their appearance.

**5: PASS.** Whole-response linkage ties the proposed packet to the selected revision and says a polished Paper direction does not establish final approval. Revised captures and scoped actual-component checks are required; human evidence remains unobserved. This states the final approval boundary without prematurely asking for approval.

> containing the brief, alternatives, selected revision, desktop/narrow targets and an explicit evidence ledger.

**6: PASS.** Direct typo correction verifies exact wording and rendered wrapping with appropriately scoped shared-string checks.

> No new usability study, component experiment or full-screen approval cycle is needed.

### candidate-r1/sample-02.md

**1: PASS.** Brief identifies task/essential/secondary/invariants and surfaces occasional/prepared assumption for correction, with structural recommendation and consequences.

> The first artifact would be a short experience brief followed by two rough Paper structures

**2: PASS.** Comparable rail and vertical sequence differ structurally with explicit width/scroll costs; typo does not inherit variants.

> I would recommend A for desktop, with B’s task order on narrow screens.

**3: FAIL.** Retains semantics and anchors, but neither checkpoint explicitly surfaces the selected-light-file-on-every-publish friction as a separate product decision. A concise reason beside disabled publication is not the missing separate decision.

> publication still requires a selected light file; parking-save remains separate; first publication has no current identity.

**4: PASS.** Rejects weak draft feedback, redundant current state and long narrow journey; changes preview hierarchy, optional asset grouping and action readiness. Actual fixtures support these observations.

> It provides little additional evidence for judging the result.

**5: PASS.** The chosen revision is the proposed packet artifact, concept selection is distinguished from final approval, and checkpoint 2 explicitly leaves visual approval pending while requiring corrected captures and focused component checks. Human use remains unobserved; the whole response establishes the approval boundary semantically.

> The proposed deliverable is a v2 packet with the chosen revision, Paper extraction, captures and separate runtime records. Concept selection would not count as final approval.

**6: PASS.** Scoped correction and verification, no new exploration/usability study or extra review chain.

> inspect the rendered label in its actual context for spelling, wrapping and clipping, and review the narrow diff.

## Comparison

Baseline-01 passes 1/6; baseline-02 passes 2/6. Candidate-01 passes 6/6; candidate-02 passes 5/6. These are requirement tallies, not visual-quality scores. Both candidates gain context-aware briefs and real structural comparison. Candidate-01 adds explicit separate friction handling; baseline-02 already supplied the stronger preview critique which both candidates retain. Candidate-02 omits candidate-01’s separate product-friction treatment. All four retain the direct typo path and separate human-use uncertainty from component proof. Candidate whole-response revision/approval linkage also improves on the baselines; see preserved criterion-5 interpretation history. No observed baseline-to-candidate loss on a previously passed criterion; no claim of statistically demonstrated improvement or improved rendered usability.

## Unchanged design-handoff D01–D15

All five complete responses were read against the full original design-handoff scenario and unchanged rubric. Each passes D01–D15 (75/75 mandatory assertions in this separate regression campaign). The table gives the semantic grounds; exact response evidence by checkpoint follows for every sample. Full checkpoint quotations preserve context rather than keyword matching. D02 is satisfied by a stated proposal/required test versus supplied facts, even where the word hypothesis is not used. D01 sample-05 correctly starts with behavior evidence and conditionally uses Paper when substantial composition remains unresolved; it does not force composition work for a settled local correction.

| Criterion | All five | Evidence checkpoint and semantic rationale |
|---|---|---|

| D01 | PASS | Checkpoint 1: Paper resolves substantial composition; actual Angular slice resolves behavior; routine multi-medium/full-HTML chain rejected. |

| D02 | PASS | Checkpoint 1: Whole-order versus paginated scope retained; visible-context relationship, space cost, provisional recommendation and necessary evidence supplied without invented data. |

| D03 | PASS | Checkpoint 2: Rejects hidden total, staggered cards and pale labels; restores table/alignment/readability/density with task benefit and space costs. |

| D04 | PASS | Checkpoint 2: Applies hierarchy/alignment/mappings substantively, with narrow/long-content, contrast and focus/component verification; no measured human success claim. |

| D05 | PASS | Checkpoint 3: r3 arrangement approval remains scoped; required checks unavailable/pending, no invented degradation; named checks required before dependent finalization or explicit scoped acceptance. |

| D06 | PASS | Checkpoint 3: Separate visual/functional/human evidence; realistic task, expectation and unobserved outcome, no compulsory human study. |

| D07 | PASS | Checkpoint 4: Current artwork/tokens inspected, manual neighbors checkpointed/preserved, only 16-to-12 gap changed. |

| D08 | PASS | Checkpoint 5: Exactly three images and two explicit Companion mockups honored directly; authority remains concept/simulation only. |

| D09 | PASS | Checkpoint 5: Default substantial onboarding uses Paper alternatives before selection, no duplicate rendering from earlier Companion consent. |

| D10 | PASS | Checkpoint 6: Context reused, minimal capture/degraded path, project-dir startup plus returned fields, persistent process and complete keyed URL. |

| D11 | PASS | Checkpoint 6: Subject-specific map/diagram with three stages, labeled accessible narrow ordering and no invented selectable alternatives. |

| D12 | PASS | Checkpoint 6: Artifact precedes explanation/question tool; later unavailable-tool fallback explicit, surviving direction preserved durably outside raw HTML. |

| D13 | PASS | Checkpoint 7: All seven handoff fields include exact checkout/dirty identity, command, 4301 route, readiness, login/reset, dimensions/states and ownership. |

| D14 | PASS | Checkpoint 7: Fresh reviewer establishes build and auth/fixture before recapture; unknown 4200 untouched; missing build/state cannot pass. |

| D15 | PASS | Checkpoint 8: Picker behavior slice first; unavailable requested Paper requires explicit medium substitution while independent work proceeds; immutable approved local snapshot consumable offline. |

### Exact evidence: design-regression-r1/sample-01.md

Per-sample disposition: D01 PASS, D02 PASS, D03 PASS, D04 PASS, D05 PASS, D06 PASS, D07 PASS, D08 PASS, D09 PASS, D10 PASS, D11 PASS, D12 PASS, D13 PASS, D14 PASS, D15 PASS.


> All records below are proposed; no tools or runtime checks have been performed.
> 
> **1. First three actions**
> 
> 1. **Record the brief and inspect the affected baseline.** Produce brief/extraction notes covering the operator’s comparison task, current drawer behavior, retained shell/table/French copy/tokens, affected library coverage and current approval identities. Propose a maintenance allowance limited to the touched order screen and its relevant components; leave agreement pending. Operator frequency and familiarity remain unknown.
> 2. **Compare two rough Paper structures before polishing.** Use identical order, line items, exceptions, shell and widths:
>    - A: persistent whole-order summary above the semantic table, with details beside it.
>    - B: compact order summary beside the table, with selected details adjacent.
>    
>    Produce two identified rough structures with benefit/cost notes. Recommend A initially because it preserves table width better; test whether opening details still leaves enough comparison context.
> 3. **Build the smallest isolated Angular slice for the selected structure.** Use the installed table and drawer with synthetic fixtures. Produce proposed runtime records and captures for comparison visibility, dense rows, long French content, narrow reflow and keyboard/focus. Record actual outcomes only after execution.
> 
> The information relationship is **whole-order amount/status visible alongside line-item evidence while details are inspected**. The total covers the whole order; the table is paginated. Neither concept adds a page subtotal or reconciliation difference. Persistent context costs vertical space or table width; actual component rendering must establish whether the remaining space supports comparison.
> 
> Use Paper for unresolved composition and Angular for component behavior. The proposed Companion → images → Paper → full standalone HTML sequence adds no necessary evidence. Existing HTML is contextual work, not proof of Angular feasibility. Deadline pressure and sunk effort do not change the proof requirements.
> 
> **2. Review of the selected Paper direction**
> 
> Proposed verdict: **requires changes**. Selection for refinement is not final approval.
> 
> | Visible finding | Task consequence | Concrete correction and cost |
> |---|---|---|
> | Staggered cards replace the retained semantic table | Comparable fields lose consistent alignment; the retained table constraint is violated | Restore compact semantic rows with aligned amounts and stable columns. This limits editorial variation. |
> | Tiny pale labels | Operators may struggle to identify amount/status meaning | Restore readable French labels using established type and contrast roles; reduce competing emphasis instead. Labels may require more space. |
> | Whole-order total is inside a closed drawer | Opening details removes the persistent comparison anchor | Keep total and status visible outside disclosure; disclose occasional details only. This consumes some persistent space. |
> 
> Apply **Refactoring UI: Visual Hierarchy, Spacing & Sizing, Typography, Layout & Composition**: quiet secondary emphasis, retain useful density, group related information and align comparable records. Editorial asymmetry is not a general prescription for operational rows.
> 
> Apply **Design of Everyday Things: Mappings and Conceptual Models**: put details controls near their target and make the total’s whole-order scope clear. Do not imply that the current page explains the entire total.
> 
> Before final approval, inspect the corrected rendered revision for hierarchy, readable labels, contrast, density and retained anchors. Exercise actual Angular table/drawer behavior with representative long content, desktop and narrow widths, paging, exceptions and keyboard/focus. Compare equivalent fixtures and captures against the corrected source. Record defects and corrections before requesting final approval. Faithful reproduction of the defective Paper version is insufficient; no measured operator benefit is claimed.
> 
> **3. r3 visual approval with missing component proof**
> 
> Proposed record:
> 
> ```text
> Design revision: r3
> Human decision: “I approve the visual arrangement of r3; I cannot try it today.”
> Approval reference/date: retain the actual conversation reference and date;
> not supplied in this exercise.
> Visual arrangement: approved within the quoted scope.
> Packet status: required-pending.
> Accepted degraded limitations: none.
> Agent component verification: unavailable; not passed.
> ```
> 
> Retain these required checks as `unavailable`, with distinct records:
> 
> - `drawer-comparison`
> - `dense-editable-rows`
> - `french-error-390`
> - `picker-focus`
> 
> Each record should state the toolchain outage, retain its missing gate and all seven runtime handoff fields, marking unknown values pending with reasons. Component-name mappings do not establish rendered results. Do not fabricate source recovery or use the unavailable-source exception without its required explicit degraded acceptance.
> 
> Can proceed: preserve r3’s source and captures, document visual approval, prepare fixtures/setup and retain pending evidence records. Finalization and dependent production implementation remain blocked.
> 
> **Exact next step:** restore the toolchain and render the smallest actual-component slice covering those four checks. If proof remains unavailable and delivery is sought, present those exact missing checks and their limits for explicit degraded-evidence acceptance. The existing quote does not supply that acceptance.
> 
> Human task evidence:
> 
> ```text
> Person: approving human; representative-operator status unknown.
> Proposed tasks:
> 1. Identify the order amount/status while inspecting an exception’s details.
> 2. Find a line item relevant to that exception.
> Expected outcome: preserve whole-order versus paginated-item scope and locate
> relevant evidence without losing comparison context.
> Attempt: not attempted; human unavailable today.
> Observed outcome/confusion: not observed.
> Remaining hypothesis: the arrangement supports comparison and detail discovery.
> ```
> 
> Unobserved human use alone does not invalidate visual approval.
> 
> **4. Narrow spacing feedback**
> 
> Change only the exception-message gap from 16px to the established 12px token.
> 
> Before mutation, inspect the affected node, current token value, current source/version and any changes since the shared baseline. Retain a checkpoint and identify the exact gap being changed.
> 
> Preserve manually arranged neighboring states, their positions/content and all unaffected choices. Use a targeted mutation, not whole-page regeneration. Inspect the affected result and capture its exact revision; retain the feedback as authority for this scoped change. Do not reopen composition or overwrite the original approval snapshot.
> 
> **5. Explicit media requests and prior Companion consent**
> 
> | Independent task | Next artifact | Authority and limits |
> |---|---|---|
> | Exactly three generated search-screen concepts | Three separate images, A-v1/B-v1/C-v1, using the same supported content, viewport and retained anchors; each differs meaningfully in hierarchy or interaction | Initially `reference-only`. Retain outputs and prompt provenance; inspect for invented controls, missing content and readability. Selection is not final approval or runtime proof. |
> | Two Companion onboarding mockups | Two identifiable simulated product surfaces using `experience` intent and the `product-mockup` register | Temporary decision evidence. Show supported onboarding content and honest simulated states; preserve task order at narrow width. Durable authority requires approved v2 evidence. |
> | Two substantial onboarding compositions; no medium requested; prior Companion consent | Two rough Paper compositions comparing task flow/hierarchy before polishing | Prior consent does not choose Companion for screen composition. No duplicate Companion rendering is necessary. Actual-component proof remains necessary for sensitive decisions. |
> 
> Honor the two explicit medium requests directly; do not force Paper first. Generated or simulated text cannot redefine approved copy or business behavior.
> 
> **6. First visual Companion turn and later fallback**
> 
> First turn’s proposed sequence:
> 
> 1. Reuse instruction context, then available repository design context; if insufficient, make one minimal session capture. If still insufficient, visibly declare degraded context.
> 2. Record proposed startup:
> 
>    ```text
>    Project directory: /tmp/order-desk
>    Start command: bash <resolved-skill-dir>/scripts/start-server.sh \
>      --project-dir /tmp/order-desk --open
>    Server lifetime: retained Codex session through the visual discussion.
>    Returned session: url, screen_dir, state_dir pending successful startup.
>    ```
> 
> 3. After successful startup, retain actual returned fields and the complete keyed URL.
> 4. Author a uniquely named fragment: intent `map`, root `vc-canvas` with `data-vc-register="diagram"`, dominant `vc-stage`, directly labeled nodes and directional connections:
>    **Order created → Payment checked → Exception queue**.
>    Identify this as a conceptual flow; do not invent payment outcomes or branching rules.
> 5. Use no selection options or `data-choice`: there are no competing alternatives. At narrow width, recompose top-to-bottom in the same DOM/reading order. Provide an accessible title/description and non-color-only connections.
> 6. Check visual fit, concrete subject content, useful encoding, clear viewing task and honest fidelity; verify desktop/390px readability and overflow.
> 7. Make the artifact viewable, share its complete keyed URL, and explain: “This diagram shows the proposed sequence and handoff into the exception queue.”
> 8. Use the dedicated question tool for the decision: “Does this sequence accurately represent the flow we should carry forward?”
> 
> On a later qualifying diagram turn: confirm server availability, author a new uniquely named fragment, perform the same scoped checks, display it, explain its viewing task, then ask the confirmation in plain terminal text. Explicitly record **degraded behavior: dedicated question tool unavailable**.
> 
> The lead’s prose-only suggestion does not replace the artifact-first path for these qualifying visual questions.
> 
> If retained, write the chosen flow visibly into carry-forward notes and the frontend-direction follow-on prompt. It becomes durable design direction only through approved v2 evidence with scoped authority; browser events and temporary HTML alone do not provide that authority.
> 
> **7. Independent runtime reviewer handoff**
> 
> ```text
> Implementation under review:
> - Checkout/build: /tmp/order-desk; commit a11 plus dirty diff sha256:dirty-17.
> - Start command and working directory: npm run start:local;
>   cwd /tmp/order-desk; serve on port 4301.
> - Base URL and target route:
>   http://localhost:4301/admin/orders/fixture-17
> - Readiness check: verify launch provenance from the recorded checkout and
>   dirty source; confirm the served build marker a11+dirty-17 and target readiness.
> - Authentication and fixture/state setup: fresh browser context; normal login
>   using credential reference local-admin; reset fixture order-17, without live writes.
> - Required viewports/platforms: web desktop 1440x900 and narrow 390x844;
>   comparison, drawer, error and focus states.
> - Server owner/lifetime: implementer owns the review server and keeps it
>   available until independent review and recapture complete.
> ```
> 
> Also carry the producing packet’s exact entry, revision, descriptor hash, approval reference and limits unchanged. Those values are not supplied here; do not invent them.
> 
> Reviewer’s first actions:
> 
> 1. Read project instructions, task, approved packet/brief and reference/runtime records; validate the supplied packet expectations before dependent review.
> 2. Establish the recorded source plus dirty-diff identity and launch provenance on 4301. Leave the unrelated 4200 server untouched.
> 3. Open a fresh browser context, authenticate and establish `order-17` independently.
> 4. Independently exercise and recapture the required states/viewports, compare binding references, and inspect relevant console/network behavior.
> 
> If build identity or fresh state cannot be established, use **REQUEST_CHANGES** or **ESCALATE**, never approval. Record findings and `Visual Review Completion Gates`: instructions, isolation, source identity, state setup, recapture, reference checklist, viewport scope, console/network checks and every missing gate.
> 
> **8. Three independent capability decisions**
> 
> - **Only picker focus is uncertain:** first artifact is a focused isolated Angular slice using the installed picker. Exercise keyboard entry, navigation, focus containment where required, dismissal and focus return. Record source/setup and observed results. No composition exploration is needed.
> - **Explicit new Paper composition, Paper unavailable:** continue independent brief, app/source/token and affected-library inspection. Record the unavailable capability and unverified composition. Propose an available alternative, such as rough sketches followed by an actual Angular slice, and obtain an explicit medium decision before substituting it.
> - **Complete approved local snapshot, Paper disconnects:** implementation may continue after validating the exact v2 handoff expectations and inspecting its retained source, references and runtime records. Live Paper access is not a consumption gate. Any deferred library upkeep retains unchanged last-verified identities and a specific pending reason; report it separately from application delivery.

### Exact evidence: design-regression-r1/sample-02.md

Per-sample disposition: D01 PASS, D02 PASS, D03 PASS, D04 PASS, D05 PASS, D06 PASS, D07 PASS, D08 PASS, D09 PASS, D10 PASS, D11 PASS, D12 PASS, D13 PASS, D14 PASS, D15 PASS.


> All actions and records below are proposed; no execution is claimed.
> 
> **1. First three actions**
> 
> 1. **Record the scoped brief and baseline evidence.** Target: order comparison while inspecting exceptions. Preserve whole-order total semantics, pagination, separate details panel, semantic table, French labels, shell, tokens and compact density. Record affected library coverage only; propose a five-minute upkeep allowance within the 45-minute deadline, with unfinished upkeep marked pending. Artifact: brief, extraction notes and risk list in existing packet evidence.
> 2. **Compare two rough Paper structures before polishing.** Keep fixtures, shell and widths equal:
>    - Persistent order summary above the table, with details alongside it.
>    - Persistent order context rail beside the table, with details in a separate panel.
>    
>    Recommend the first provisionally: total and status remain visible while operators inspect rows and exceptions; it costs vertical table space. The rail alternative costs table width. Artifacts: two rough structures, scoped comparison rationale and selected-direction notes. No human selection or final approval is presumed.
> 3. **Build the smallest isolated Angular slice to test the recommendation.** Render the installed table and details component with synthetic fixtures, long French content and representative pagination. Test comparison visibility, drawer behavior, narrow reflow and keyboard focus. Artifact: component-risk mapping and runtime evidence with recoverable source, setup, exact source identity and captures.
> 
> The supported relationship is **whole-order total/status visible alongside line-item evidence and opened details**. No page subtotal or difference is introduced. Required evidence concerns whether the real components preserve that relationship at actual widths and short heights, without hiding essential columns or disrupting focus.
> 
> Use Paper for unresolved composition and Angular for component behavior. Do not add Companion, generated concepts or another full standalone HTML recreation. The earlier HTML effort and deadline do not establish design quality or replace required proof.
> 
> **2. Review of the selected Paper direction**
> 
> Proposed verdict: **requires changes**. Selection for refinement is not final approval.
> 
> | Visible finding | Task consequence | Concrete correction |
> |---|---|---|
> | Staggered cards replace the semantic table | Comparable fields lose alignment; a retained constraint is violated | Restore the semantic table with consistent row rhythm and aligned amounts/status |
> | Tiny pale labels | French field meanings become difficult to read | Use established readable typography and verified foreground/background contrast; reduce competing emphasis through weight and grouping |
> | Whole-order total sits in a closed drawer | Opening details removes essential comparison context | Keep total and status visible outside the details disclosure |
> 
> Apply Refactoring UI’s **Visual Hierarchy**, **Spacing & Sizing**, **Typography**, and **Layout & Composition**: quiet secondary emphasis, reuse project scales, preserve useful density and consistently align comparable records. Apply Design of Everyday Things’ **Mappings** and **Conceptual Models**: place controls near their targets and make the total’s whole-order scope clear.
> 
> Benefit: comparison facts remain accessible and rows remain scannable. Cost: persistent context consumes space; the actual layout must balance row visibility against panel width. Editorial asymmetry and large whitespace are not app-wide requirements.
> 
> Before final approval, inspect corrected Paper captures at comparable content and widths, then render the dense table/details slice in Angular. Check long labels, paging, drawer open/closed, error text, narrow reflow, keyboard access and focus return. Record observed defects and corrections. Faithful Angular reproduction alone cannot approve a consequential design defect; no productivity improvement is claimed.
> 
> **3. Visual approval with missing component proof**
> 
> Proposed record:
> 
> ```text
> Design revision: r3
> Human decision: “I approve the visual arrangement of r3; I cannot try it today.”
> Approval scope: visual arrangement only
> Decision date/reference: pending capture from the actual decision record
> Packet status: required-pending
> Accepted degraded limitations: none
> Agent component verification: not performed; toolchain unavailable
> ```
> 
> Retain proposed required checks individually:
> 
> | Check ID | State/scope | Result |
> |---|---|---|
> | `drawer-comparison` | Open details while comparing order and rows | unavailable |
> | `dense-row-editing` | Densest editable rows | unavailable |
> | `french-error-390` | Long French error text at 390px | unavailable |
> | `picker-focus` | Keyboard entry, navigation, exit and focus return | unavailable |
> 
> Each unavailable record retains its reason, all seven runtime handoff fields, and recoverable source where available. Unknown values remain pending with reasons. Component names are mappings, not runtime results. Do not finalize using `source: null` without the schema’s explicitly accepted degraded limitation.
> 
> Preserving r3 source, captures, mappings and approval evidence can proceed. Dependent production implementation and final packet handoff remain blocked.
> 
> **Exact next step:** present the four missing checks for an explicit decision: wait for restored Angular tooling and run them, or accept each named unavailable-proof limitation. Only explicit acceptance permits `approved-with-degraded-evidence`; visual approval alone does not.
> 
> Human task evidence:
> 
> ```text
> Proposed task: Identify the order total/status and inspect an exception
> while retaining the relevant line-item context.
> Person: approving human; operator role not established
> Expected outcome: identify whole-order scope and the relevant exception evidence
> Attempt: none; person unavailable today
> Observed outcome/confusion: not observed
> Remaining hypothesis: comparison context and detail retrieval are understandable
> ```
> 
> Human unavailability alone does not invalidate the scoped visual approval.
> 
> **4. Narrow spacing feedback**
> 
> Change only the exception-message gap from 16px to the existing 12px token.
> 
> Before mutation, inspect the current Paper file/page identity, affected node and parent layout, current token value, relevant styles and any changes since the baseline. Preserve a checkpoint and identify whether shared styling would unintentionally change other states.
> 
> Apply a targeted mutation; preserve manually arranged neighboring states, their positions, copy, component choices and unaffected styling. Do not regenerate the page. Recapture the affected region and inspect wrapping and adjacency. Record the exact scoped feedback and resulting revision; preserve the prior approval snapshot and pending gates.
> 
> **5. Explicit media requests and the default**
> 
> - **Exactly three generated search concepts:** propose three separate images, `A-v1`, `B-v1`, `C-v1`, using equal viewport, supported search content, shell and constraints. Each tests a meaningful hierarchy or interaction relationship. Inspect for invented controls, missing information and unreadable content before presentation. Retain outputs and prompt provenance. They begin as `reference-only`; selection permits refinement, not final implementation authority. Do not require Paper first.
> - **Two Companion onboarding mockups:** propose two honestly labeled simulated product surfaces using the `experience` intent and `product-mockup` register. Preserve supported onboarding behavior and show meaningful task differences. The explicit request authorizes that medium; do not force Paper first. Temporary mockups remain decision context until retained decisions enter an approved v2 packet. Runtime proof and final approval remain required.
> - **No requested medium; two substantial onboarding compositions:** show two rough Paper structures with comparable content, then refine the chosen structure. Prior Companion consent does not select Companion for screen composition. No duplicate Companion or standalone rendering is necessary. An actual-component slice remains necessary where interaction or component risks require it.
> 
> **6. First and later Companion diagram turns**
> 
> For the first visual turn, propose this sequence:
> 
> 1. Reuse supplied constraints and available repository design context; if insufficient, obtain only minimal cues once or explicitly label degraded context.
> 2. Prepare startup record:
> 
>    ```text
>    Project directory: /tmp/order-desk
>    Start command: bash <resolved-skill-dir>/scripts/start-server.sh --project-dir /tmp/order-desk --open
>    Server lifetime: pending platform-managed session retained across turns
>    Returned session: url=pending; screen_dir=pending; state_dir=pending
>    ```
> 
> 3. Start the session; record actual returned fields only after success.
> 4. Author a new fragment in the returned screen directory:
>    - Intent: `map`.
>    - Root: `class="vc-canvas" data-vc-register="diagram"`.
>    - Dominant stage: **order created → payment checked → exception queue**.
>    - Direct labels, arrows, accessible title/description.
>    - No options, `data-choice` or selection behavior: these are non-competing stages.
> 5. At narrow width, recompose vertically in the same reading order. Verify desktop and 390px readability, no viewport overflow and no color-only meaning. Apply all five pre-display checks.
> 6. Make it viewable, share the complete returned keyed URL, and explain: “This diagram shows the proposed sequence and handoffs.”
> 7. Then use the dedicated question tool: “Does this sequence correctly describe the flow, or is a step or condition missing?”
> 
> On a later qualifying turn: confirm session availability, author a newly named diagram fragment, verify it, display it, explain the specific viewing task, then ask the decision in plain terminal text. Explicitly record **degraded questioning: dedicated question tool unavailable**.
> 
> Do not keep qualifying diagram questions prose-only after consent merely to save time. If the decision survives, carry the agreed sequence and unresolved conditions into visible authored copy and the follow-on prompt. Durable frontend direction requires approved v2 evidence; browser events and temporary fragments are not authority.
> 
> **7. Independent runtime reviewer handoff**
> 
> ```text
> Implementation under review:
> - Checkout/build: /tmp/order-desk; commit a11 plus dirty diff sha256:dirty-17
> - Start command and working directory: npm run start:local; /tmp/order-desk
> - Base URL and target route: http://localhost:4301/admin/orders/fixture-17
> - Readiness check: verify launch from the recorded checkout and dirty snapshot;
>   confirm served build marker a11+dirty-17 and target route readiness
> - Authentication and fixture/state setup: fresh browser context; normal login
>   using credential reference local-admin; reset fixture order-17;
>   synthetic fixture only, without live writes
> - Required viewports/platforms: web desktop 1440x900 and narrow 390x844;
>   comparison, drawer, error and focus states
> - Server owner/lifetime: implementer; retained through independent review
>   and recapture completion
> ```
> 
> First proposed reviewer actions:
> 
> 1. Read project instructions, task, approved packet/brief, reference scopes and runtime evidence. Obtain the producing handoff’s exact entry, revision, descriptor hash, approval reference and limitations; these were not supplied here.
> 2. Validate that supplied identity before dependent review. Confirm the recorded dirty snapshot is available and matches the served build.
> 3. Use port 4301 from the known checkout. Leave unknown port 4200 untouched.
> 4. Establish login and fixture state independently in a fresh browser context.
> 5. Independently recapture both viewports, exercise the required states, inspect reference fidelity and relevant console/network evidence.
> 
> If build identity or fresh state cannot be established, record the missing gate and issue **REQUEST_CHANGES** or **ESCALATE**, never approval. Old captures cannot substitute.
> 
> The review artifact records findings, verdict, decision and **Visual Review Completion Gates** covering instructions, isolation, served identity/state, independent recapture, reference checklist, platform coverage, console/network checks and missing gates. Fixture evidence does not prove backend integration.
> 
> **8. Focus-only uncertainty and unavailable Paper**
> 
> - **Picker focus uncertainty:** first artifact is a small isolated actual-Angular-component slice with keyboard/focus observations. Test the applicable focus contract, including opening, navigation, closing and return. Preserve settled visual arrangement; no composition exploration is needed.
> - **Explicit new Paper composition, Paper unavailable:** report the capability gap. App/source inspection, supported-content mapping, brief and risk identification may proceed. Propose an available alternative—for example, rough sketches plus a focused Angular slice—but obtain an explicit medium decision before substituting it. No prose packet can stand in for the requested visual loop.
> - **Complete approved local snapshot, Paper disconnects:** implementation may continue offline after validating the v2 packet against the producer’s expected revision and descriptor hash and inspecting its binding payload. Live Paper access is not a consumption gate. Preserve the snapshot; record any deferred library upkeep separately with unchanged last-verified identities.

### Exact evidence: design-regression-r1/sample-03.md

Per-sample disposition: D01 PASS, D02 PASS, D03 PASS, D04 PASS, D05 PASS, D06 PASS, D07 PASS, D08 PASS, D09 PASS, D10 PASS, D11 PASS, D12 PASS, D13 PASS, D14 PASS, D15 PASS.


> All records below are proposed; no tools, files, designs or runtime checks have been executed.
> 
> **1. First three actions**
> 
> 1. **Record a scoped brief and inspect the comparison problem.** Proposed artifact: packet evidence containing the experience brief, retained anchors and current-state extraction. Operators need the whole-order amount and status alongside paginated line items while inspecting exceptions. Preserve the Angular shell, semantic table, French labels, spacing tokens and compact density. Record initial library coverage as the touched order screen and relevant shared components; propose a five-minute upkeep allowance, with any remainder explicitly pending.
> 2. **Compare two inexpensive Paper structures before polishing.** Proposed artifacts: comparable structures A and B using identical content, shell and widths:
>    - A: persistent order summary above the table, with details beside it.
>    - B: compact order-context rail beside the table, with details opening in the remaining workspace.
>    
>    Both keep the whole-order total visible and clearly scoped. A costs vertical space; B costs table width. Recommend A initially because dense editable rows need width, subject to the component check.
> 3. **Build the smallest isolated Angular slice for the preferred structure.** Proposed artifact: synthetic comparison/drawer fixture with the installed table and drawer, plus a risk-to-component evidence record. Test whether opening details preserves the total, status and relevant row context at desktop and narrow widths. Include long French content and keyboard/focus behavior.
> 
> The unresolved composition question gets Paper comparisons; drawer behavior and table feasibility get actual Angular components. No Companion, generated images or full standalone recreation is needed. The existing polished HTML is reference-only unless independently shown to answer a specific remaining question.
> 
> Task-to-layout rationale: the supported relationship is **whole-order context alongside the records being inspected**, not a calculation from the visible page. No page subtotal or reconciliation difference is introduced. Evidence must establish readable density, maintained comparison context, workable reflow and focus—not merely attractive screenshots. Deadline pressure and sunk effort do not establish those facts.
> 
> **2. Review of the selected Paper direction**
> 
> Proposed verdict: **requires changes**. Selection for refinement is not final approval.
> 
> | Visible problem | Task consequence | Concrete correction |
> |---|---|---|
> | Staggered cards replace the semantic table | Corresponding line-item values become harder to compare; an explicit retained constraint is violated | Restore aligned semantic table rows with consistent treatment |
> | Tiny pale French labels | Operators may struggle to identify field meaning and exception context | Use established readable typography and checked text/background contrast; reduce competing emphasis through weight and grouping |
> | Whole-order total inside a closed drawer | Opening or closing details removes the comparison reference | Keep total and status visible in a compact persistent order-summary region |
> | Broad whitespace and editorial asymmetry | Dense operational content loses space without a demonstrated task benefit | Use existing spacing tokens and consistent operational alignment within this screen |
> 
> The benefit is persistent context and comparable records. Costs include space reserved for the summary and tighter limits on the details region. These are hypotheses to verify, not measured operator improvements.
> 
> Apply the supplied **Visual Hierarchy**, **Spacing & Sizing**, **Typography**, and **Layout & Composition** guidance: quiet secondary emphasis, preserve useful density, keep labels readable and align comparable records. Apply **Mappings** and **Conceptual Models** to place details near their relevant rows while distinguishing whole-order scope from page scope. The advisor’s recommendation grants no app-wide redesign authority.
> 
> Before final approval, inspect corrected captures at equivalent content and widths; render the table/drawer arrangement in Angular; exercise dense rows, long labels, exceptions, narrow reflow and focus. Record each consequential defect, correction and remaining limitation. Offer an unguided task such as “Identify the order’s total and status, then inspect a line-item exception.” Record actual human participation separately.
> 
> **3. Visual approval without component proof**
> 
> Proposed record:
> 
> ```text
> Design revision: r3
> Human decision: “I approve the visual arrangement of r3; I cannot try it today.”
> Visual approval: recorded for arrangement only
> Packet status: required-pending
> Accepted degraded limitations: none
> Actual-component proof: unavailable; toolchain unavailable
> Finalization and dependent production implementation: blocked
> ```
> 
> Retain these proposed required check IDs:
> 
> - `drawer-comparison-context`
> - `dense-editable-rows`
> - `french-errors-390`
> - `picker-focus-path`
> 
> Each remains recorded as unavailable with its specific missing proof; none becomes passed through a component-name mapping. Retain local check records and all seven runtime handoff fields, marking unknown values pending with reasons. Do not fabricate source recovery, execution results or a valid final descriptor.
> 
> Source preservation, copy/state mapping, capture organization and recovery planning can proceed. Sensitive details remain provisional.
> 
> **Exact next step:** restore the Angular toolchain and render the smallest synthetic slice covering those four checks, then record actual results. If unavailable evidence must be accepted instead, obtain explicit human acceptance naming each missing check and its limits before using `approved-with-degraded-evidence`. Arrangement approval does not supply that acceptance.
> 
> Proposed human-task record:
> 
> ```text
> Tasks: Identify whole-order total/status while inspecting an exception;
>        correct an editable-row error and use the picker by keyboard.
> Participant: Approving human; operator role not supplied
> Expected outcome: Maintain scope/context and complete supported interactions
> Attempt: Not attempted; human unavailable today
> Observed outcome/confusion: Not observed
> Remaining hypotheses: Comparison context, error recovery and keyboard
>                      discoverability remain unobserved in human use
> ```
> 
> Human unavailability alone does not invalidate visual approval; missing required component proof keeps the packet pending.
> 
> **4. Narrow spacing feedback**
> 
> Change only the exception-message gap from 16px to the existing 12px token.
> 
> Before mutation, inspect the current Paper file/page identity, affected node and parent layout, current token values, and relevant manual changes against the last checkpoint. Preserve a checkpoint first.
> 
> Preserve neighboring states, their manual arrangement, copy, other spacing, hierarchy and unaffected design choices. Decline full-page regeneration. Capture and inspect the affected result, including relevant wrapping, then record the precise scoped revision. The feedback authorizes this correction, not broader cleanup.
> 
> **5. Explicit medium requests and default composition**
> 
> | Task | Next proposed artifact | Authority and limits |
> |---|---|---|
> | Exactly three generated search concepts | Three separate images, A-v1/B-v1/C-v1, with identical supported search content, viewport and retained anchors; distinct hierarchy or interaction ideas | Initially `reference-only`; retain prompt provenance and inspect for invented controls or missing content. Selection is not final approval. Exact copy and actual-component proof remain required |
> | Two Companion onboarding mockups | Two simulated product surfaces using `experience` intent and `product-mockup` register, with task-derived narrow reading order | Temporary decision evidence. Label simulated behavior and assumptions; preserve any selected idea through a later approved v2 packet |
> 
> Neither explicit request requires Paper first. Honor the requested medium and count.
> 
> For the independent task requesting two substantial onboarding compositions without a medium choice, show two rough **Paper structures**, then refine the chosen one. Earlier Companion consent does not make it the screen-composition medium. No duplicate Companion, image or standalone HTML rendering is required. Add an actual-component slice only for unresolved component-sensitive or interaction decisions.
> 
> **6. Companion data-flow decision**
> 
> Proposed first-turn sequence:
> 
> 1. Reuse supplied instruction constraints and available project design context. If insufficient, make one minimal context capture; otherwise explicitly record degraded context. Do not invent project styling.
> 2. Record startup inputs before starting:
> 
>    ```text
>    Project directory: /tmp/order-desk
>    Start command: bash <resolved-skill-dir>/scripts/start-server.sh --project-dir /tmp/order-desk --open
>    Server lifetime: persistent platform session through the decision
>    Returned session: url, screen_dir and state_dir pending successful startup
>    ```
> 
> 3. Author a new fragment with `map` intent:
> 
>    ```html
>    <section class="vc-canvas" data-vc-register="diagram">
>      <!-- Accessible title/description and dominant vc-stage:
>           Order created → Payment checked → Exception queue -->
>    </section>
>    ```
> 
>    Use directly labeled nodes and connectors. Mark that routing conditions are unspecified; the diagram must not imply every order necessarily enters the exception queue. No `.options`, `data-choice` or selection controls: there are no competing choices.
> 4. Specify desktop left-to-right flow and narrow top-to-bottom flow in the same reading order. Keep labels readable without zoom or horizontal viewport scrolling.
> 5. Check visual fit, concrete content, useful encoding, clear viewing task and honest fidelity; verify desktop and 390px presentation.
> 6. Make the artifact viewable, share the complete returned keyed URL, and explain: “This shows the proposed order-processing sequence; inspect the handoffs and the still-unspecified exception routing.”
> 7. Use the dedicated question tool for confirmation: “Does this sequence capture the intended flow, and what condition sends an order to the exception queue?”
> 
> On the later qualifying turn: confirm server availability, author a **new filename**, perform the same checks, display first, then explain the specific viewing task. Ask the confirmation in plain terminal text and explicitly identify the missing question-tool fallback as degraded behavior.
> 
> Keeping everything in prose would skip the accepted visual path for these qualifying turns. If the decision survives, carry the agreed flow and unresolved conditions in visible authored copy and the frontend-direction follow-on. Durable design authority comes from its approved v2 evidence, not temporary Companion files or click events.
> 
> **7. Independent reviewer runtime handoff**
> 
> ```text
> Implementation under review:
> - Checkout/build: /tmp/order-desk; commit a11 plus dirty diff
>   sha256:dirty-17. Retain the actual dirty patch/source recovery evidence.
> - Start command and working directory: npm run start:local;
>   cwd /tmp/order-desk.
> - Base URL and target route:
>   http://localhost:4301/admin/orders/fixture-17
> - Readiness check: Establish a traceable launch from that checkout with
>   the recorded dirty edits; confirm served build marker a11+dirty-17
>   and the target route is ready.
> - Authentication and fixture/state setup: Fresh browser context;
>   normal login using credential reference local-admin; reset fixture
>   order-17 without live writes. Exact reset procedure must be supplied
>   if not independently discoverable.
> - Required viewports/platforms: Web desktop 1440x900 and narrow 390x844;
>   comparison, drawer, error and focus states.
> - Server owner/lifetime: Implementer owns the review server and keeps
>   it available until independent review and recapture complete.
> ```
> 
> First proposed reviewer actions:
> 
> 1. Read project instructions, task and exact approved packet/brief. Recover any missing producer entry, revision, descriptor hash, approval reference and limitations; these were not supplied in this checkpoint. Validate both expected identities before dependent review.
> 2. Confirm source/build provenance on port 4301. Leave unknown port 4200 untouched; its availability proves nothing about this implementation.
> 3. Establish login and fixture state independently in a fresh context.
> 4. Recapture both viewport scopes, exercise the named states, inspect relevant console/network behavior, and complete the scoped reference checklist.
> 
> Record findings, verdict, decision and **Visual Review Completion Gates**, including every missing gate. If build identity or fresh state cannot be established, use **REQUEST_CHANGES** or **ESCALATE**, never approval. Fixture results establish only their documented synthetic scope.
> 
> **8. Focus uncertainty, unavailable Paper and offline consumption**
> 
> - **Picker focus is the only uncertainty:** first artifact is a focused isolated Angular picker slice using the installed component. Exercise keyboard entry, movement, dismissal and focus return against its intended interaction contract. Record actual observations and source identity. No composition exploration is needed.
> - **New Paper composition explicitly requested, Paper unavailable:** report the capability gap; continue independent brief, app/source, token and state inspection. Propose a concrete available alternative, such as rough local sketches for the composition decision, and obtain explicit authorization before substituting it. Availability of another tool is not authorization.
> - **Complete approved local snapshot, Paper disconnects:** implementation can continue offline after validating the producer’s expected revision and descriptor hash and inspecting the retained source, captures, runtime evidence and approval. Live Paper access is not a consumption gate. Preserve the immutable packet and record any deferred library upkeep separately.

### Exact evidence: design-regression-r1/sample-04.md

Per-sample disposition: D01 PASS, D02 PASS, D03 PASS, D04 PASS, D05 PASS, D06 PASS, D07 PASS, D08 PASS, D09 PASS, D10 PASS, D11 PASS, D12 PASS, D13 PASS, D14 PASS, D15 PASS.


> All records below are proposed actions based on the supplied facts; none report tool execution.
> 
> **1. Start with the comparison task**
> 
> 1. **Establish the scoped baseline.** Inspect the current order screen, drawer behavior, relevant Angular components/tokens and affected library entries. Produce a short brief and extraction record: operators compare whole-order amount/status against paginated line items while investigating exceptions; preserve shell, semantic table, French labels, spacing tokens and compact density. Record operator familiarity/frequency as unknown. Limit library upkeep to affected entries within an agreed allowance; no catalog expansion.
> 2. **Compare two rough Paper structures before polishing.** Use identical content, shell and widths:
>    - A: whole-order summary above the table, with details beside it.
>    - B: whole-order summary in a compact context rail, table beside it, and details in a bounded panel.
> 
>    Recommend A initially because it preserves more table width. Record each structure’s benefit and cost, then refine the stronger direction. Neither is approved merely because it is selected.
> 3. **Render the smallest Angular slice that resolves the risk.** Use the installed table and drawer on the isolated fixture route. Produce component-risk observations and runtime evidence for comparison visibility, opening/closing details, long content, narrow reflow and keyboard/focus. Preserve recoverable source, dependencies, dirty changes and the seven runtime handoff fields.
> 
> Task-to-layout record:
> 
> > Problem: opening details loses comparison context. Supported facts: total is whole-order; rows are paginated; details are separate. Proposed relationship: keep whole-order amount/status visible alongside the relevant line-item context while details are open. Cost: reduced table space or additional vertical space, particularly on narrow screens. Required evidence: actual Angular rendering at representative widths and short heights, long French content, paging, drawer transitions and focus restoration.
> 
> Use Paper for unresolved composition and Angular for behavior/component feasibility. The proposed Companion → image concepts → Paper → standalone HTML sequence adds no necessary evidence. The existing HTML is exploratory context; time invested and deadline pressure do not establish approval or component proof. No page subtotal or reconciliation difference is introduced.
> 
> **2. Review the selected Paper direction**
> 
> Proposed verdict: **requires changes**.
> 
> Finding:
> 
> > In the selected direction, staggered cards break consistent line-item comparison and violate the retained semantic-table constraint. Tiny pale labels make field meanings difficult to read. Closing the whole-order total inside a drawer removes the context operators need while inspecting exceptions. Selection for refinement is not final approval; perfect Angular reproduction would reproduce these defects.
> 
> Correction:
> 
> - Restore the semantic table with consistent rows and aligned comparable values.
> - Keep whole-order total and status visible outside the closed drawer.
> - Restore readable French labels using established type, contrast and spacing tokens.
> - Use the details panel for contextual information without hiding essential comparison facts.
> 
> Benefit: makes amount, status and line-item context available for comparison. Cost: the persistent summary occupies space; a side panel can narrow the table, so its width and narrow-screen ordering need testing.
> 
> Apply these substantive sections:
> 
> - **Refactoring UI—Visual Hierarchy, Typography, Spacing & Sizing:** reduce competing emphasis, keep labels readable and distinguish groups through existing spacing.
> - **Layout & Composition:** operational records need consistent alignment; editorial asymmetry is not a prescription for comparable rows.
> - **Design of Everyday Things—Mappings and Conceptual Models:** place details controls near their targets and make the whole-order scope clear.
> - **Feedback:** distinguish loading, errors and completed actions truthfully.
> 
> Before final approval, review corrected Paper captures at comparable content/widths, then render the sensitive table/drawer slice in Angular. Check long rows, narrow reflow, readable labels, paging, opening/closing details, error states and focus. Record visible problems, corrections and remaining limits. Offer an operator task without prescribing clicks; claim no measured success unless actually observed. The advisor’s app-wide proposal grants no additional scope.
> 
> **3. Visual approval with missing component proof**
> 
> Proposed record:
> 
> ```text
> Design revision: r3
> Visual approval: human approved the visual arrangement of r3
> Approval evidence: supplied statement; actual decision date/reference must be retained
> Packet status: required-pending
> Agent component verification: unavailable; toolchain unavailable
> Accepted degraded limitations: none
> ```
> 
> Retain these required check IDs and unavailable records:
> 
> - `drawer-comparison`
> - `dense-editable-rows`
> - `french-error-390`
> - `picker-focus`
> 
> Each record names the missing behavior, affected state and toolchain limitation. Retain all seven runtime fields, marking unknowns pending with reasons. Component names are mappings, not evidence. Do not assert recoverable runtime source or use an accepted-degradation exception that has not been granted.
> 
> What can proceed: preserve unchanged r3 Paper exports, captures, copy, tokens, mappings and the actual visual approval statement; prepare runtime setup and unresolved-check records. Final packet delivery and dependent production implementation remain blocked.
> 
> Exact next step: when the toolchain returns, render the four sensitive cases using installed Angular components on the isolated route and record outcomes. Correct failures; obtain approval for any material resulting design change. Alternatively, present the exact unavailable limitations for explicit degraded-scope acceptance. The supplied statement does not provide that acceptance.
> 
> Human task record:
> 
> ```text
> Proposed task: identify the order amount/status and inspect an exception
>               while retaining the relevant line-item context
> Person: approving human; representative-operator role unknown
> Attempt: not attempted; unavailable today
> Expected outcome: correctly identify whole-order scope and relevant item details
> Observed outcome/confusion: not observed
> Remaining hypothesis: arrangement supports comparison without losing context
> ```
> 
> Human unavailability alone does not block visual approval. Missing required component evidence does block finalization here.
> 
> **4. Change only the exception-message gap**
> 
> Inspect the exact message/group nodes, their current styles, the current 12px token value and affected state instances. Re-read current artwork and compare it with the prior baseline to identify manual or concurrent edits. Preserve a checkpoint before mutation.
> 
> Change only the specified exception-message gap from 16px to the existing 12px token. Preserve neighboring states, manual arrangement, typography, copy, dimensions and all unaffected decisions. Do not regenerate the page.
> 
> Inspect the changed region and relevant long/narrow states afterward. Record the targeted delta and evidence. The scoped instruction authorizes this edit; it does not authorize broader redesign. Preserve any earlier approved snapshot unchanged.
> 
> **5. Explicit media requests and the default**
> 
> | Independent request | Next artifact | Authority and limits |
> |---|---|---|
> | Exactly three generated search-screen concepts | Three separate images, A-v1/B-v1/C-v1, using equal viewport/content, retained anchors and supported controls; each tests a different composition or task relationship. | Initially `reference-only`. Inspect for invented behavior, omitted content and unreadable copy before showing them. Retain outputs and prompt provenance. Selection does not establish final approval or runtime behavior. |
> | Two Companion onboarding mockups | Two honestly labeled simulated product surfaces using `experience` intent and `product-mockup` register, with task-derived narrow ordering. | Temporary decision evidence. Simulated interactions do not prove actual components, persistence or backend behavior. Surviving choices require approved v2 evidence. |
> 
> Honor both requests directly without first forcing Paper. Required component proof and final approval still apply.
> 
> For two substantial onboarding compositions with **no requested medium**, show two rough Paper structures using comparable supported content. Previous Companion consent does not select Companion for screen composition. Refine the chosen structure there; no duplicate Companion or standalone rendering is required. Use a focused actual-app slice only for relevant interaction/component risks.
> 
> **6. Companion diagram sequence**
> 
> The diagram is genuinely visual, and consent already exists. Proposed first-turn sequence:
> 
> 1. Reuse supplied instructions and available project design context; if insufficient, make one minimal capture when permitted, otherwise visibly declare degraded context.
> 2. Prepare the startup record:
> 
>    ```text
>    Project directory: /tmp/order-desk
>    Start command: bash <resolved skill-dir>/scripts/start-server.sh --project-dir /tmp/order-desk --open
>    Server lifetime: retained Codex session through subsequent visual turns
>    Returned session: url=pending; screen_dir=pending; state_dir=pending
>    ```
> 
> 3. Start the server and retain actual returned fields only after success.
> 4. Author a uniquely named fragment with `map` intent and `data-vc-register="diagram"`. Show a dominant labeled sequence: **order created → payment checked → exception queue**. State any unresolved routing condition explicitly rather than implying every order enters the queue. No `.options`, `data-choice` or fabricated competing choices.
> 5. At narrow width, arrange the sequence vertically in the same DOM/reading order. Provide direct labels and an accessible description; avoid sideways page scrolling and color-only meaning.
> 6. Check visual fit, subject specificity, useful encoding, clear viewing task and honest fidelity, plus desktop/390px rendering.
> 7. Make the artifact viewable, share the actual complete keyed URL and explain that it supports confirming the sequence and exception routing.
> 8. Ask the terminal confirmation using the dedicated question tool.
> 
> On a later qualifying diagram turn: verify the retained server, author a new uniquely named fragment, perform the same display checks, display it, then explain the viewing task and ask the decision in plain terminal text. Explicitly record that the unavailable question tool requires this fallback.
> 
> Keeping every question in prose would skip the accepted visual path for these qualifying turns. Textual follow-up questions can stay in terminal.
> 
> If the decision survives, preserve the sequence and unresolved conditions in visible **Chosen direction**/**Still open** copy and the frontend-direction follow-on. Any durable design authority comes from scoped approved v2 evidence, not temporary files or click events.
> 
> **7. Independent runtime review**
> 
> Proposed dispatch:
> 
> ```text
> Implementation under review:
> - Checkout/build: /tmp/order-desk; commit a11 plus dirty diff sha256:dirty-17
> - Start command and working directory: npm run start:local; /tmp/order-desk
> - Base URL and target route: http://localhost:4301/admin/orders/fixture-17
> - Readiness check: verify launch provenance from the recorded checkout and
>   dirty diff; confirm served build marker a11+dirty-17 and target readiness
> - Authentication and fixture/state setup: fresh browser context; normal login
>   using credential reference local-admin; reset fixture order-17;
>   synthetic state only, without live writes
> - Required viewports/platforms: web desktop 1440x900 and narrow 390x844;
>   comparison, drawer, error and focus states
> - Server owner/lifetime: implementer; keep reviewed server available until
>   independent review and recapture complete
> ```
> 
> Also carry the producing packet’s unchanged entry, expected revision/hash, approval reference and accepted limits. Those values are not supplied here; recover them rather than invent them.
> 
> Reviewer’s first actions:
> 
> 1. Read project instructions, task, approved packet and runtime evidence; validate the supplied packet expectations before dependent review.
> 2. Confirm checkout and dirty-source identity, launch/identify the reviewed server on 4301 and verify its build provenance and marker. Leave unknown port 4200 alone.
> 3. Create a fresh browser context, independently log in and reset the fixture.
> 4. Independently open the route, exercise required states and recapture both viewports. Complete the scoped reference checklist and relevant console/network checks.
> 
> Record **Visual Review Completion Gates**: instructions, fresh isolation, served-source identity, independent state setup/recapture, reference checklist, desktop/narrow coverage, diagnostics and missing gates.
> 
> If build identity or fresh state cannot be established, use **ESCALATE**, naming the missing gate; do not approve. Connection or route failure likewise requires **REQUEST_CHANGES** or **ESCALATE**. Implementer screenshots cannot substitute for independent runtime proof.
> 
> **8. Three independent decisions**
> 
> - **Only picker focus behavior is uncertain:** first artifact is a minimal actual Angular picker slice with synthetic state. Exercise keyboard entry, opening, relevant focus containment, closing and return focus. Record actual behavior against the picker’s intended interaction contract. No composition exploration is needed.
> - **Explicit new Paper composition, but Paper is unavailable:** continue independent app/source inspection, brief preparation and risk identification. Report unavailable Paper authoring and propose a specific available alternative, such as rough standalone structural sketches with provisional fidelity. An explicit human available-medium decision authorizes substitution; availability alone does not.
> - **Complete approved local snapshot, then Paper disconnects:** implementation can continue offline after validating the exact v2 packet against the producer’s expected revision/hash and inspecting its binding payload and approval. Live Paper access is not a consumption gate. Preserve the snapshot and record any deferred library upkeep separately.

### Exact evidence: design-regression-r1/sample-05.md

Per-sample disposition: D01 PASS, D02 PASS, D03 PASS, D04 PASS, D05 PASS, D06 PASS, D07 PASS, D08 PASS, D09 PASS, D10 PASS, D11 PASS, D12 PASS, D13 PASS, D14 PASS, D15 PASS.


> All actions and records below are proposals; no tools or checks have been run.
> 
> 1. **Start with the comparison problem.**
> 
>    First three actions:
> 
>    1. Inspect the current drawer behavior, affected Angular source/tokens, state evidence and relevant library entries. Produce a short brownfield extraction and experience brief inside the packet: operators must compare whole-order amount/status with paginated line items while inspecting exceptions; preserve the shell, semantic table, French labels, spacing tokens and compact density. Record affected library coverage and a bounded upkeep allowance, with any unagreed allowance explicitly pending.
>    2. Build the smallest isolated Angular fixture slice using the installed table and drawer. Test whether opening details obscures the order context or relevant rows, and how focus and scrolling behave. Produce a risk/component/evidence record with recoverable source, dependencies, dirty changes and all seven runtime handoff fields.
>    3. If substantial composition remains unresolved, compare two rough Paper structures with identical content and widths before polishing: a compact persistent order summary above the table, versus an order-context rail alongside the table and details. Produce scoped comparison captures, source extraction and a recommendation. If the actual-component slice establishes a sufficient local correction, refine that directly without concept exploration.
> 
>    **Rationale:** The total describes the whole order; table rows describe a paginated subset. Keep the total and status visible while the operator inspects rows and exceptions. A persistent summary costs vertical space; a context rail costs table width. Neither introduces a subtotal or reconciliation difference.
> 
>    Required evidence includes actual drawer behavior, densest rows, long French content, short-height scrolling, narrow reflow and keyboard/focus behavior. Use Angular for interaction uncertainty and Paper only for unresolved composition. The proposed Companion → image concepts → Paper → full HTML sequence adds no necessary proof. Existing polished HTML may inform inspection but does not establish Angular feasibility. Deadline pressure and sunk effort do not change the evidence required.
> 
> 2. **Review verdict: requires changes.**
> 
>    Proposed finding:
> 
>    > Selected Paper refinement, revision identity not supplied. In the line-item region, staggered cards remove the retained semantic table and disrupt repeated row comparison. Tiny pale labels make field meanings difficult to read. Closing the whole-order total inside a drawer hides information required during the primary comparison task. Faithful Angular reproduction would preserve these defects.
> 
>    Correction: restore aligned semantic rows with consistent treatment; use readable French labels and established type/spacing tokens; keep whole-order total and status visible with the table while details open. Preserve compact operational density and the existing shell.
> 
>    Benefit: order context and comparable line-item fields remain available together. Cost: persistent context occupies space, and detail-panel width may need adjustment.
> 
>    Apply the supplied Refactoring UI sections on visual hierarchy, spacing, typography and layout: quiet secondary emphasis, group related facts and align comparable records. Apply Design of Everyday Things’ mappings and conceptual models: locate controls near their targets and clearly distinguish whole-order information from paginated rows. Editorial asymmetry and generous whitespace are not app-wide requirements.
> 
>    Before final approval, inspect corrected captures at comparable content and widths for hierarchy, readable contrast, alignment and scope clarity. Render the actual table/drawer combination, dense editable rows, long errors, narrow layout and focus transitions. Record observed defects and corrections, then present the concrete final revision for approval. Any human task outcome remains separate; no productivity improvement has been measured.
> 
> 3. **Visual arrangement approved; required evidence remains pending.**
> 
>    Proposed record:
> 
>    ```text
>    Design revision: r3
>    Human decision: “I approve the visual arrangement of r3; I cannot try it today.”
>    Approval date/reference: retain actual decision metadata; not supplied here
>    Visual approval scope: arrangement of r3
>    Packet status: required-pending
>    Accepted degraded limitations: none
>    ```
> 
>    Retain these proposed required check IDs as `unavailable`, with local records and the specific toolchain limitation:
> 
>    - `drawer-comparison`
>    - `dense-editable-rows`
>    - `french-error-390`
>    - `picker-focus`
> 
>    Component-name mappings establish no observed results. Each record must retain seven handoff fields, marking unknown values pending with reasons. Do not fabricate recoverable source or treat `source: null` as an accepted degraded exception.
> 
>    Source preservation, extraction, copy/state mapping, fixture preparation and independent implementation planning may proceed. Finalization and dependent production implementation remain blocked.
> 
>    **Exact next step:** restore the toolchain and render the focused Angular slice for those four checks. If unavailable evidence must instead be accepted, present each missing check and its precise limitation for explicit human acceptance. Only then could `approved-with-degraded-evidence` apply; the existing statement does not supply that acceptance.
> 
>    Human task record:
> 
>    ```text
>    Proposed tasks:
>    - Identify the scope of the displayed total while inspecting an exception.
>    - Find the relevant line item and inspect its details without losing order context.
>    Participant: approving human; representative-operator status unknown
>    Attempt: none; unavailable today
>    Expected outcome: correct scope understanding and retained comparison context
>    Observed outcome/confusion: not observed
>    Remaining hypothesis: arrangement supports comparison and exception inspection
>    Agent functional checks: required checks unavailable
>    ```
> 
>    Human unavailability alone does not invalidate the visual approval.
> 
> 4. **Change only the exception-message gap.**
> 
>    Before mutation, inspect the current affected node, its parent layout, current token values and any changes since the shared baseline. Retain a checkpoint and identify the manually arranged neighboring states.
> 
>    Apply the existing 12px token to the specified gap. Preserve all other spacing, composition, copy, states, manual organization and concurrent edits. Do not regenerate the page.
> 
>    Proposed record: “Scoped feedback: exception-message gap 16px → existing 12px token; all other choices retained.” Inspect the resulting affected state and neighboring geometry for accidental changes. Carry the revision into the existing review; do not infer whole-packet final approval from this narrow instruction.
> 
> 5. **Honor explicit medium requests.**
> 
>    - **Exactly three generated search concepts:** produce three separate images, proposed IDs `A-v1`, `B-v1`, `C-v1`, with equal task, supported content, viewport and retained anchors. Each explores a meaningful hierarchy or interaction difference. Inspect for invented controls, missing information and unreadable content before presentation; retain prompts, source roles and outputs. They begin `reference-only`. Selection permits refinement, not final implementation authority. Do not force Paper first.
>    - **Two Companion onboarding mockups:** produce two simulated product surfaces using the `experience` intent and `product-mockup` register. Preserve supported onboarding behavior, make assumptions visible and place review commentary outside the simulated UI. These are temporary decision artifacts, not actual-component proof or an approved handoff. Do not force Paper first.
>    - **No requested medium; two substantial onboarding compositions:** compare two rough Paper structures before polishing. Earlier Companion consent does not select Companion for screen composition. Show the Paper comparison directly; duplicating it in Companion, generated images or standalone HTML is unnecessary. Runtime slices remain necessary for any sensitive component or interaction decisions.
> 
> 6. **Use the first qualifying visual turn.**
> 
>    Proposed sequence:
> 
>    1. Reuse instruction constraints, then available repository design context; if needed, capture minimal cues once. Explicitly label degraded context if still insufficient.
>    2. Prepare the startup record:
> 
>       ```text
>       Project directory: /tmp/order-desk
>       Start command: bash <resolved-skill-dir>/scripts/start-server.sh --project-dir /tmp/order-desk --open
>       Server lifetime: proposed retained Codex foreground session across turns
>       Returned session: url=pending; screen_dir=pending; state_dir=pending
>       ```
> 
>       Resolve the actual skill path before execution; fill returned fields only after successful startup.
>    3. Author a new fragment with intent `map` and root `class="vc-canvas" data-vc-register="diagram"`. Use one dominant stage showing directly labeled nodes and arrows: **Order created → Payment checked → Exception queue**. Do not invent additional branches or outcomes. Add an accessible title/description. No selection options or `data-choice`: this diagram has no competing alternatives.
>    4. Recompose vertically at narrow width in the same reading order. Check desktop and 390px readability, overflow and non-color-dependent meaning, plus the five pre-display quality checks.
>    5. Make the artifact viewable, share the complete returned keyed URL, and explain: “This diagram shows the proposed event sequence for confirmation.”
>    6. Use the dedicated question tool: “Does this sequence correctly represent the flow we should carry forward?”
> 
>    On a later qualifying diagram turn: confirm server availability, author a newly named fragment, check it, display it, explain its viewing task, then ask the terminal confirmation in plain text. Record: “Degraded question delivery: dedicated question tool unavailable.” Browser events do not replace terminal feedback.
> 
>    Keeping all questions in prose would skip the already-consented visual path for this qualifying task. If the decision survives, preserve it in visible authored carry-forward copy and the frontend-direction follow-on. It becomes durable design authority only through scoped, approved v2 evidence—not raw Companion files or hidden event state.
> 
> 7. **Proposed independent-review runtime handoff.**
> 
>    ```text
>    Implementation under review:
>    - Checkout/build: /tmp/order-desk; commit a11 plus dirty diff sha256:dirty-17
>    - Start command and working directory: npm run start:local; /tmp/order-desk
>    - Base URL and target route: http://localhost:4301/admin/orders/fixture-17
>    - Readiness check: verify launch from the recorded checkout with dirty-17 applied;
>      confirm served build marker a11+dirty-17 and target route readiness
>    - Authentication and fixture/state setup: fresh browser context; normal login
>      using credential reference local-admin; reset fixture order-17; no live writes
>    - Required viewports/platforms: web desktop 1440x900 and narrow 390x844;
>      comparison, drawer, error and focus states
>    - Server owner/lifetime: implementer; keep server available until independent
>      review and recapture complete
>    ```
> 
>    First actions: read project instructions and task, then validate the supplied approved packet identity and inspect its binding references and runtime records. Exact packet entry, expected revision/hash and approval reference are not supplied here and must be recovered from the producing handoff.
> 
>    Establish the reviewed checkout and dirty-source identity; launch or verify its port-4301 server. Leave the unrelated port-4200 server alone. Open a fresh browser context, log in independently, reset the fixture and confirm the intended build/state. Independently exercise and recapture both viewports and required states; complete the reference-intent checklist and relevant console/network checks.
> 
>    Record findings and `Visual Review Completion Gates`, including missing gates. If build identity or fresh state cannot be established, use `REQUEST_CHANGES` or `ESCALATE`; do not approve from implementer screenshots, an accessible port or prior login state.
> 
> 8. **Choose the artifact that resolves the remaining uncertainty.**
> 
>    - **Picker focus only:** first artifact is a minimal isolated Angular slice with the installed picker and working keyboard interactions. Record opening, focus entry, traversal, escape/close and focus return against the picker’s intended behavior. Keep settled visuals; no composition exploration is needed.
>    - **Explicit new Paper composition, Paper unavailable:** continue independent app/source inspection, experience brief, supported content and risk preparation. Record the missing capability. Propose a concrete available alternative—such as rough sketches for composition plus Angular for sensitive behavior—and obtain explicit authorization before substituting it. Do not silently replace the requested visual loop with prose or HTML.
>    - **Complete approved local snapshot, Paper disconnects:** implementation may continue after validating the producer’s exact v2 expectations and inspecting the retained payload and approval. Live Paper access is not a consumption gate. Preserve the immutable snapshot, perform required app/runtime review, and record any unavailable library upkeep separately with unchanged last-verified identities.

## Candidate-r2 targeted follow-up (source 3ad8a83)

This appendix preserves all baseline/candidate-r1 verdicts and interpretation history above. Two new experience responses use source `3ad8a833e842d5a9c5e6dee971eb6498b25ebfed`. Of the six injected source hashes, only task-to-layout changed from 0da9cdd. The original scenario, six-point acceptance and both image hashes are unchanged. The five D01–D15 regression responses remain evidence at **0da9cdd only**; they were not rerun at 3ad8a83.

Integrity: independently recomputed all 11 manifest hashes with no mismatch, confirmed both exits 0, one completed turn per trace, only agent-message items/no actor tool calls, exact Markdown-to-trace response equality, and fresh IDs distinct from all nine prior IDs.

- `sample-01`: `01a17770-5ad0-7390-bf8d-3fb3761329ed`.

- `sample-02`: `01a17770-5ad0-7b20-a8b2-8631ea469780`.


### candidate-r2/sample-01.md

**1: PASS.** Reuses facts in a short experience brief, surfaces frequency/readiness unknowns and asks one targeted readiness question with recommendation and consequences; continues independent structural work.

> I recommend optimizing for prepared assets, with visual color selection secondary; that makes setup shorter but makes experimentation less prominent.

**2: PASS.** Two rough comparable form/preview and sequential structures resolve hierarchy/task organization with width and travel costs before polish; routine typo avoids alternatives.

> I would provisionally favor A for desktop and B’s task sequence for narrow screens.

**3: PASS.** Explicitly identifies repeated file selection even for name/color change as retained friction, while preserving validations, selected-file semantics, separate save and admin anchors.

> Changing that requires a separate product decision. Copy can explain it but cannot remove it.

**4: PASS.** Rejects proposal despite technical packet success. Concrete critique addresses empty-current duplication, weak preview and long narrow separation; changes grouping, preview and publication placement with costs.

> Place a compact draft preview immediately after the asset group, showing actual selected assets when present.

**5: PASS.** Explicit concrete-revision approval boundary; proposed component slice and missing-evidence status, screenshot critique, limited picker evidence and unobserved human use stay separate. Selected-asset rendering and corrected narrow behavior remain to be demonstrated.

> I would show the concrete revision for final approval, with its limits, rather than treating a concept selection or the time limit as approval.

**6: PASS.** Direct copy fix with actual-context spelling/wrap/clipping verification, no sketches/interview or extra review chain.

> If rendering cannot be checked, report that specific limitation. Do not claim the correction was verified or reopen the settled design.


### candidate-r2/sample-02.md

**1: PASS.** Reuses approved business and styling constraints in experience brief, flags unknown familiarity/preparation and requests one optional readiness answer with consequences.

> I recommend optimizing for that prepared workflow; users still choosing assets would benefit from more guidance.

**2: PASS.** Real side-by-side versus sequential alternatives with width/scroll tradeoffs, selected recommendation and pre-polish comparison; typo remains direct.

> two rough Paper structures using identical content, shell and widths

**3: PASS.** Explicit newly selected-file repeat-work friction is separately recorded, not silently removed or merely hidden in helper copy; established admin semantics remain.

> Removing that requirement needs a separate product decision; this design preserves it.

**4: PASS.** Holds rendered proposal, addresses concrete duplication, weak feedback and narrow length/gutters. Supported selected-asset preview and adjacent preview/publication alter task organization, not just polish.

> The draft preview mainly repeats entered values; its empty logo box cannot help assess finished assets.

**5: FAIL.** Strong evidence separation and corrected-state checks, but checkpoint 1/2 does not tie final approval to a chosen/final revised artifact as candidate-r1 did. “For the existing final review” remains generic. The exact version/supersession warning occurs solely under independent checkpoint 3 and cannot establish the redesign approval gate. No immediate approval request or particular word is required; omission concerns artifact-to-approval linkage.

> **Visual approval:** pending; these captures require revision.

**6: PASS.** Direct typo correction verifies rendered copy and scopes checks to impact. Conditional new handoff preserves historical identity without imposing mandatory exploration or additional review chain.

> No concepts, Paper recreation or renewed experience discovery are warranted.


### Approval-boundary ambiguity retained

Sample-02 contains “For the existing final review, I would offer two tasks without prescribing clicks” in checkpoint 2, and “Do not claim the earlier approval covers a newly revised artifact.” in checkpoint 3. The scenario explicitly says “Each checkpoint is independent.” Criterion 5 is therefore a bounded FAIL: the redesign has pending visual approval and strong evidence requirements, but its final revised artifact/approval linkage remains implicit. Unlike candidate-r1, there is no chosen/selected revision tied to a proposed packet and contrasted with final approval in checkpoints 1/2. A broader reading of generic final review could yield PASS, but would also require reconsidering the earlier baseline interpretation; this appendix does not silently change that standard.

Sample-01 passes 6/6; sample-02 passes 5/6. Both now explicitly separate the selected-light-file friction as a product decision, addressing candidate-r1 sample-02’s omitted criterion 3. Sample-02 drops the explicit revision/final-approval linkage seen in candidate-r1; the supported omission remains a failure. These are requirement tallies, not visual-quality scores or statistical effectiveness evidence.

The fixture critique uses the same already-inspected PNGs; no additional image-authoring or pilot-design work occurred during this follow-up. Actor decisions do not demonstrate an improved rendered design or human task evidence. Actual rendered r2 and human approval remain pending. Historical 140/140 and the separate 0da9cdd design-regression evidence remain unchanged.
