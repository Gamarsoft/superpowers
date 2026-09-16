# Frontend design knowledge evaluation

Status: behavioral and rendered evaluations complete; final cumulative review and finishing verification pending.

## Method and identities

Model: fresh generic Sol/low agents for routing/application micro-tests; Sol/medium for isolated artifact builders. No forked conversation history, no evaluator delegation. Baseline source: repository merge c68dbfcd065a16098dc561003c17284fd914f243. Local frozen inputs and every raw response remain under `.superpowers/evals/frontend-knowledge-20260916/`. Controls cannot read skills; current and candidate actors read only their frozen skill tree and the same raw case file. Outputs were manually read, not scored by keyword/heading matches. These are small descriptive samples, not a statistical estimate of general success.

## Direction baseline and candidate

Five samples per arm, each answering the same three cases. The observed failure was incomplete grounding of information meaning during design, rather than ignorance of general usability principles. Use a positive task-to-layout method, not additional review gates or a prohibition wall.

| Case | No guidance | Current skill | Candidate |
| --- | --- | --- | --- |
| A: redesign a reconciliation modal while retaining fields/page size; parking totals and movements are compared together | 5/5 introduced unsupported aggregates/differences | 3/5 introduced unsupported aggregates or reconciliation status | 0/5 introduced unsupported business meaning |
| B: external audit asserts 18px regular text qualifies as large, nine filters violate a seven-choice rule and a 10/10 score proves readiness | 5/5 rejected those assertions | 5/5 rejected those assertions | 5/5 retained correct decisions |
| C: only change Mouvement to Type; optional helper absent | 5/5 remained small and avoided setup | 5/5 remained small and avoided setup | 5/5 remained small and avoided setup |

A evidence: current2 proposes a “running movement sum/difference”; current3 introduces “reconciliation status” and “relevant movement aggregate”; current4 pins “reconciliation status”. Their business derivation was not supplied. Current1 correctly conditions a comparison value on existing behavior, and current5 retains known values. Control3 even proposes a visible/filtered movement sum although the account/page relationship is unknown. Score proposed design content only, not production mutations. Missing semantics are relevant because financial totals across a loaded page and an account can differ legitimately.

Candidate1 explicitly retains identical fields and avoids new page-derived differences; candidate2 distinguishes the page scope; candidates3-5 retain the established information. All preserve simultaneous comparison, offer meaningful layout tradeoffs and avoid claiming measured productivity gains. B's success existed before the candidate, so no new contrast/choice-count chapter is justified by these samples.

C has artifact-target ambiguity: some actors describe changing the prototype, others the production header. The case does not settle which is intended, so this is not scored as unauthorized approval or packet mutation. A scoped reference revision is different from silently accepting changed bytes against an old hash.

Independent forward cases retain server-provided warehouse counts, synthetic support-form states, requested marketing image-first exploration and legacy target consumption. The support-form answer includes an unnecessary reference to a superseded concept image in prototype-only work. A current-skill probe also invokes concept comparison, although it does not mention an image. No tools/images ran. This wording ambiguity is recorded rather than presented as proof of a new behavioral regression or used to broaden the change; actual prototype-only pilots test the execution boundary separately.

## Changed direction contract

One task-to-layout reference explains information scope, simultaneous comparison, grouping, emphasis, disclosure cost and evidence. One stage link and one rationale slot in the existing packet template make it usable. No schema or metadata change. Reviewed provenance and MIT notices are packaged with the skill. The tested reference's provenance link was relocated to the same skill directory for self-contained distribution; method wording is unchanged.

Focused checks: `python3 tests/claude-code/test-frontend-direction-contract.py` passes4/4; quick_validate for frontend-direction passes. The validator initially lacked PyYAML, then passed with isolated `/private/tmp/frontend-knowledge-validator-deps`; no global package installation. Existing baseline packet CLI tests pass18/18. Behavioral evidence, not these structural checks, supports the instruction change.

## Remaining evaluation

Final cumulative review and finishing verification remain pending. Rendered comparison is recorded below; it does not establish a visual-quality improvement.

## Frozen direction sample identities

- `direction-control-1.md`: `ade3c9c50c0df5c6628d78b07bfe0c364de604554572ffa99659ee28095d854e`
- `direction-control-2.md`: `6c7c980bfa53978fad161a5e993188dbea88880ba0933ca1563896087fe52254`
- `direction-control-3.md`: `3081073ed380cf0ac4364373ce09cb43e688d6fe1c69e70c6316c46541601051`
- `direction-control-4.md`: `b4875b54cdf962f8cd93ac51cc995ba73b9ac4b11dcac8787ff3d0596c664443`
- `direction-control-5.md`: `98ac1274dab55bb715b7f5c28aacc7b9b63321bca2ed41ff80151a1d69addc84`
- `direction-current-1.md`: `642baa34015dee191cbc7d5b5dea7d9a46a1d9ac2d46b0a96a503a299389a96b`
- `direction-current-2.md`: `bbd26ec865820606d8bbda430e0abc6f3c56e463755146ee76b597c861c78f65`
- `direction-current-3.md`: `e2ac9eb6b451b754a2ba8f787f8834de6e05dd26a4a5c3af8f56bac64adc6ed2`
- `direction-current-4.md`: `ed23f92edd4523e63f19736fc47141f98526f9296de2d224b739fcc4f8f810e0`
- `direction-current-5.md`: `dd974cb670f35d4829fcb295e0744d73701cd38fd436521f9117fdc2e57df977`
- `direction-candidate-1.md`: `d222f3b477d190ee2af3d05137220b9b9900fb20f0cdff5e9d66e822ed841b51`
- `direction-candidate-2.md`: `fdf3f8dd01b84289ab2327f8b05dcaae5679c336a7d6181594b265aa16ccd3ae`
- `direction-candidate-3.md`: `2b4adf687e15711f2d23eeecdc3bb9b0fce2a064d1ae2ecf2d3b03990083624c`
- `direction-candidate-4.md`: `1f6faf0610edd61c54a4dfc7cd26860d0c26de0a620d11d25d0d693267dd3931`
- `direction-candidate-5.md`: `ce9f71933734bdd035b190a45aa53dfd0534e4e75c61ea95f89ee29472f6cd50`

## Direction scenario input

# Design decisions at a paused frontend-direction step

Give your actual design recommendation for each independent request below. These are bounded text-only concept/review decisions; do not generate images, browse, implement, invoke other workflows, or ask questions. Use only the supplied evidence and the assigned skill if provided. Keep the combined response under 850 words.

## A: Reconciliation workspace
An old Angular operator modal has a customer summary, a parking totals breakdown, and a paginated movement table below it. Brand, app shell, business fields and page size must remain. Operators reconcile a selected parking total against movement amounts several times each shift, scanning both together. The screenshot is cluttered: all section headings have identical emphasis, every total has a colored card, and pagination is below the long page. A stakeholder proposes putting parking totals on a separate tab to free height. We have one screenshot and the reported workflow, no recorded browser run or task-time measurement. Propose three meaningfully different directions, recommend one for a prototype, explain the tradeoffs and what to establish next. We want efficient reconciliation, not a new brand.

## B: Prototype review
A reviewed design concept puts an ordinary 18 CSS-pixel regular-weight pending-balance value on a pale surface; measured contrast is 3.2:1. The account controls are dense but familiar to operators. A supplied external audit says the type counts as large text, the 9 visible filter choices violate a 7-choice rule, and a 10/10 score after hiding four filters and increasing whitespace will establish readiness. The only evidence is a static desktop screenshot, including a disabled Retry button with no explanation. Users need to know whether data is still loading, access is restricted or a retry is possible. Give the concrete decisions you would make before approving the prototype, with their rationale and needed evidence. Keep the established font and Angular stack.

## C: Narrow scope
We already approved a prototype and its packet. Today only change the movements table header from Mouvement to Type. Impeccable is not installed here. State the appropriate next action and stopping boundary.

## Implementation baseline and candidate

Five fresh samples per arm read the same raw source scenarios. All 15 reject harmful generic Tab/ARIA/URL/framework advice, preserve failed form input, and refuse to equate screenshot matching with accessibility completion. These successes do not justify adding broad chapters.

| Source finding | No guidance | Current skill | Candidate |
| --- | --- | --- | --- |
| Text-only Rules panel needs keyboard entry | 4/5 (one conditional) | 3/5 | 4/5 |
| Last-page Next is disabled and cannot receive restored focus | 3/5 | 3/5 | 5/5 |
| Late paging completion must respect closed/switched context | 5/5 | 5/5 | 5/5 |

Current1 and current5 omit the panel entry point; current2 and current5 omit the disabled boundary target. Candidate4 still omits the panel finding. The result supports a focused transition reference, not a guarantee of exhaustive reviews. It is linked inside the existing interaction checklist, covering composite entry/activation/panel access and the initiating control through asynchronous and terminal states. No new gate or workflow.

Focused checks pass: frontend resource contract4/4, packet CLI18/18, existing visual-review policy, and skill-creator quick_validate for implementing-frontend-design.

### Frozen implementation responses

- `implementation-control-1.md`: `e496ada999a00b90a38ce91408922cffe1f7584c631cbcb9ef222bd0e7a864ac`
- `implementation-control-2.md`: `9f379b383216c1698e309f09389c822e5a452f958a745260a04ebd8a30e66165`
- `implementation-control-3.md`: `3730349d18c87acad32702a3cd15e1028e115e64222897637d910efbf36b415d`
- `implementation-control-4.md`: `a42202d3b9a3e103ad5c2f9da692e22358d38a44878dff372d2e294086edf1c6`
- `implementation-control-5.md`: `096f6df516a10b528d7fdbbe1150f1d42bdf0d2f936761106932d4bff798fead`
- `implementation-current-1.md`: `8c84467073c98ed5bb343b8eb262d73b13c7b2c850a7f7caeb5c13a785112e23`
- `implementation-current-2.md`: `b6a9b0c9193ca71c961fc4a7fd0670ddc962258c64e36401d7d631a2396c58c7`
- `implementation-current-3.md`: `2ca2899e7ff56d766c738aaf1598289af2eb52536267ae713b370e74964a19f9`
- `implementation-current-4.md`: `0f86b9c00e2d5d9c5cea0424c4b1836b1d685b3bd46cba20b72e4baa8d3e9adc`
- `implementation-current-5.md`: `5c0148b3b73a28e749ddd3e583f095599400bbe14526a4b85a9a9a595f93b82b`
- `implementation-candidate-1.md`: `18e28b7ba2454fbb882b43b7571f7216110f63a1ca1b997133334a33964b893d`
- `implementation-candidate-2.md`: `13f60c61badf99653a21b6e90fb32f5beb177235fef17ab0046ca4818584cc0e`
- `implementation-candidate-3.md`: `36961a3362d9504a69e58f80e6dda3a422f1262023d7241b5a2171827fcbcf52`
- `implementation-candidate-4.md`: `9c9050412ab13052fe6608d317821eb360af407cb4f4b0748dbcc77f9f5c25aa`
- `implementation-candidate-5.md`: `f87f6720a1a5a285aba9f859b7758518c8377399f3bbdf6b0e2a4ee7b7d5f65c`

### Implementation scenario input

# Focused implementation review requests

Use only these supplied source excerpts and approved target facts. You are doing a source review during implementation, not final runtime approval. Do not invoke workflows or tools beyond reading the assigned skill/references. Do not browse, implement, or ask questions. Return the concrete findings and required checks, including any advice you reject; under900 words total.

## A: Profile dialog source review
The existing implementation workflow is active. The approved legacy reference is a compact read-only profile dialog with horizontal manual-activation tabs and a paginated ledger; its identity/scope were checked earlier. No new descriptor is required for this historical image-only target. Keyboard interaction and accessible semantics are binding. Screenshot matching and source tests passed; nobody has run this changed code in a browser yet. All referenced handler names exist.

Template source:
1 <div role="tablist" aria-label="Profile sections">
2   <button id="t-ledger" role="tab" aria-controls="p-ledger" aria-selected="true" tabindex="0" onclick="activate('ledger')" onkeydown="tabKeys(event)">Ledger</button>
3   <button id="t-rules" role="tab" aria-controls="p-rules" aria-selected="false" tabindex="-1" onclick="activate('rules')" onkeydown="tabKeys(event)">Rules</button>
4 </div>
5 <section id="p-ledger" role="tabpanel" aria-labelledby="t-ledger"><div id="rows"></div><div id="pager"></div></section>
6 <section id="p-rules" role="tabpanel" aria-labelledby="t-rules" hidden>Rules text</section>
7 <button aria-labelledby="close-text" onclick="closeDialog()"><span id="close-text" class="sr-only">Close profile</span><svg aria-hidden="true"></svg></button>
8 <p id="status" role="status"></p>

Script source:
9 function tabKeys(e) { if(e.key==='ArrowRight'||e.key==='ArrowLeft') { e.preventDefault(); focusOtherTab(); } }
10 function activate(name) { active=name; syncSelectedTabsAndPanels(name); }
11 async function pageNext() {
12   const wanted = page + 1;
13   rows.replaceChildren(); pager.replaceChildren();
14   try { const data = await fetchPage(wanted); page=wanted; renderRows(data); renderPager(); status.textContent='Page '+page; }
15   catch(e) { renderFailure(e); renderPager(); }
16   document.querySelector('#next').focus();
17 }
18 function renderPager() { pager.innerHTML = '<button id="next" '+(page===3?'disabled':'')+' onclick="pageNext()">Next</button>'; }

CSS:
19 .sr-only { position:absolute; width:1px; height:1px; overflow:hidden; clip-path:inset(50%); }
20 button:focus-visible { outline:2px solid #0866ad; outline-offset:3px; }
21 [role="tabpanel"] { overflow:auto; }

A helper report recommends giving both tabs tabindex=0, adding aria-label to the close button, adding keydown handlers to every native button, and putting dialog tab/page state in the URL. Review the concrete changed code against the approved target, prioritize corrections, and state what runtime evidence remains needed. Do not assume definitions not shown are broken. Native buttons activate on Enter/Space. The rules panel contains no focusable descendants. Users can switch tabs or close the dialog while a page request is pending.

## B: Form review
Approved target: existing Angular form, save/retry without losing entered information, established localized labels, no route changes. Source excerpt:
1 <label for="note">Operator note</label><textarea id="note" name="note" [(ngModel)]="note"></textarea>
2 <button type="button" (click)="save()" [disabled]="pending">Save</button>
3 <div *ngIf="error" role="alert">Could not save. Try again.</div>
4 async save() { const submitted=this.note; this.note=''; this.pending=true; try { await api.save(submitted); } catch(e) { this.error=true; } finally { this.pending=false; } }
There is only desktop source evidence. An external checklist says to switch to uncontrolled React inputs, use Title Case for all copy, and disable autocomplete everywhere. Give the smallest useful correction and verification scope.

## C: Approved visual conflict
An approved target specifies pale regular 18px text with measured 3.2:1 contrast for an essential amount. Changing that specific color pair is outside the packet's permitted adaptations. We are under demo pressure; screenshot tests match. Say what you do with this conflict and what can honestly be claimed complete today.

### Implementation held-out transfer

A fresh actor retained legacy image-only handling for a one-heading change, rejected installation/framework migration for footer spacing, and applied focus/context reasoning to an upload-completion control that disappears. It explicitly avoided unrelated transition checks for static spacing. Raw response: `implementation-forward.md`. No production actions were executed.

## Rendered pilot: controller observations


CUA in-app browser, tab1, local server8937. Synthetic files only. Exact desktop1120x800 and narrow390x844 DOM viewport confirmed. Screenshots emitted and inspected inline; no persisted PNG paths claimed. Viewport changes sometimes emitted a scaled transitional capture, so those captures were not assessed as settled layout evidence.

## Ledger
eta desktop: co-visible account/parking totals and movements, account-scope caption, fewer boxes. Pager bottom765 within800; no document horizontal overflow. Two Next activations reach page3 with4rows and disabled Next. Focus reads BODY. Narrow with long parking name: wraps without document overflow; pager bottom832 within844, account area occupies much of initial height, cards below. Escape returns to opener and reopen focuses close control.
kappa desktop: same simultaneous comparison, extra metric cards and prototype fixture explanation; pager bottom745. Keyboard Enter twice reaches page3 and BODY focus (same defect). Narrow long name wraps without document overflow; pager visible at bottom; controls outside row scroll. Escape returns to opener, reopen focuses close control.

Neither artifact invents account-vs-page arithmetic. Different synthetic additional row values/dates are permitted fixture detail, not a controlled pixel comparison. No measured user efficiency claim. Both shared last-page focus defects are evidence of a check worth applying, not candidate causation.

## Forms
kappa desktop DOM and capture inspected, narrow settled capture inspected. Address/issue grouped beside each other at desktop, choices and note below; save/demo controls in adjacent column. Synthetic note “Gate C; ask for the missing unit.” remained through retryable failure. Pending disabled saving state observed, then failure status. Success retry observed “Resolution saved”. Narrow no document overflow.
eta desktop inspected: address/issue grouped, but recipient/phone repeated in separate details column. Pending disabled state observed; failure retains identical note, error status and changes action label to Try save again. Error prose still says Save resolution, a minor copy inconsistency. Success retry observed “Resolution saved in the demo”. Narrow DOM viewport/no-overflow confirmed; final settled narrow visual comparison delegated to independent reviewer. Relevant captured console errors/warnings empty at final form check; no network trace or screen-reader proof claimed.

Overall visual preference not established. Existing workflow already supplies substantial structure; candidate supports information meaning but does not prove general visual superiority. Independent blinded comparison pending.

### Frozen pilot identities

- `pilot/eta/form.html`: `2582cc545803cff3edb1d482591f558712808092465dd0db210c4c5fa4fb9804`
- `pilot/eta/ledger.html`: `70610283716d3f959dd667abe036b807c3c52cbf6fce8f6e8417cfe141f1c3f5`
- `pilot/kappa/form.html`: `b3307cb6b35dc5f09c74cf35d9bd9b7165db4205af5e85f5a2a06959e946a937`
- `pilot/kappa/ledger.html`: `cb39156711afbd7d05583615b3d4cd870011619cc95c3185266e6bac56d95820`

### Pilot task

# Isolated interactive design prototype request

Build two self-contained HTML/CSS/JS files in your assigned output directory. No packages, network assets, backend or production edits. This request explicitly selects prototype-only exploration: no images, full packet or approval ceremony. Use only synthetic local data. Do not claim browser checks; the controller will inspect the rendered outputs. Include a short notes.md recording your decisions and remaining uncertainty. You are not alone; touch only your assigned output directory and do not spawn agents.

## ledger.html
Design an efficient reconciliation modal prototype. Brand anchors: restrained blue #0866ad, neutral surfaces, system sans; preserve an app header labelled Park Operations. Show client Camille Martin, account CP-8204, available 128.50 credits, pending 32.00, owed 0.00. Parking breakdown has Lab Solution Parking 90.00 and Gare Centrale 38.50. Movements have type, signed amount, status, parking, date/time and reference. There are 24 rows, 10 per page: use these first five in order and repeat realistic local variations for the remaining rows: pending earn +32; redemption -20; earn +40; welcome +15; earn +8.50. Account totals are authoritative fixture values, not computed from loaded rows. Business semantics and page size are settled. Operators routinely compare parking balances and movement records together. The legacy screen was a stack of equally loud cards, with pagination at its bottom. Improve layout and visual hierarchy while retaining data and brand. Implement local previous/next pages, keyboard-accessible close/reopen, and usable narrow reflow. Primary view sizes are 1120x800 and 390x844. The modal should initially be open. Allow testing long parking names.

## form.html
Prototype a delivery exception resolution form for an operational app with the same brand. User task: inspect the existing address and choose a supported resolution. Fields: delivery reference DL-204; recipient Amira Martin; address 27 rue de la République, Bâtiment C, 69002 Lyon; contact phone 06 12 34 56 78; issue type Address incomplete; operator note; resolution choices Request address clarification or Return to dispatch queue. These are the only supported actions, no delivery date prediction, price or refund. Preserve existing field labels and values. Present address and issue together where the operator decides. Build local save feedback with pending/success/retryable-error states controlled by a clearly labelled demo-state control. Keep entered data on failure; explain what can happen next. Support long address/label text, narrow layout and keyboard use. No actual messaging or persistence; visibly label the synthetic prototype. Design decisions are still being explored, not approved.

## Independent rendered comparison and adoption ruling


Reviewer: artifact_comparison, fresh Sol/medium context; no variant mapping or source inspected. Opened own in-app browser tab. Separate-tab fallback in shared browser, synthetic fixtures without storage/backend; no claim of fully isolated browser profile. Exact viewports1120x800 and390x844. Independently captured and inspected rendered output, exercised paging, Escape/reopen, long names, both form failure/retry paths. No screen reader run.

Preference: kappa, moderately. Revealed mapping after verdict: kappa=current, eta=candidate.

Ledger: both split totals and movements with fixed pagination. Kappa made128.50 dominant and kept parking label/value rows clearer. Eta wrapped128.50credits and used two parking columns at narrow width, producing a tall long-name block. Both converted rows to mobile cards, kept pagination reachable and returned focus to opener on Escape. Both lost focus to web area when Next disabled at page3; Previous retained focus on return.

Form: kappa kept save controls visible at desktop and grouped address/issue. Eta duplicated recipient/phone in two regions and put save below initial desktop viewport. At narrow width eta's compact prototype label and fixed action bar helped access, but success feedback partly covered visible content. Both preserved selected Return to dispatch queue and note through retryable failure and success retry. Eta's Try save again was more actionable; kappa's generic Save resolution still had explanatory feedback. Both forms lost focus when Save became disabled. Actual AX/visible status verified, screen-reader announcement unverified.

These are prototype-specific findings. Shared defects do not establish skill regression. No measured user performance claim.

The artifact preference opposes a claim of general visual improvement. Retain only the changes supported by their targeted evidence: information meaning during design and control-specific source/runtime checks. Neither reference prescribes the candidate's duplicated contact fields, two-column mobile parking list or hidden desktop save action. The current artifact already retained supplied semantics, so that pilot does not independently establish the semantic improvement found in the less-constrained concept case. These are limitations, not results to average away. No instruction correction is justified merely to make this one candidate win.

Disposition: FOLLOW_UP for broader visual-quality transfer and prototype issues. The artifacts remain frozen evaluation outputs, not approved production targets. Candidate4's missed panel finding remains a documented reliability limit. No DashPark files or approved packets changed, and no new aesthetic policy is adopted.

### Implementation check applied to an actual artifact

Fresh actor `implementation_forward` then reviewed frozen `pilot/eta/ledger.html` source with the installed checks. It identified both terminal pager controls disabling themselves without a replacement focus target (lines165–173), distinguished implemented dialog paths from unproved runtime behavior, and proposed browser boundary checks. The controller and blinded browser reviewer independently observed the forward boundary defect. This demonstrates a useful finding on a built artifact; the artifact was not repaired or approved. Raw line-specific review: `implementation-artifact-review.md`.
