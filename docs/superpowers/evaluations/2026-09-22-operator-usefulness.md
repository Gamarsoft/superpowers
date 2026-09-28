# Operator usefulness: B2 follow-through

## Outcome and scope

Preserve fuller Refactoring UI/DOET access and optional project-local Impeccable consultation. Approved B2 shows the result of references, prototyping and operator feedback together; it does not isolate a causal benefit from source loading. The maintained change in this continuation is a focused audience/usefulness section in writing-ux-copy. Existing frontend-direction and implementing-frontend-design already route copy work there. Their guidance is not duplicated or expanded.

B2 is frozen in [the canonical packet](../specs/2026-09-22--credipark-adjustment--frontend/packet.md), revision `b2-operator-copy-approved-2026-09-22`, descriptor SHA256 `43e165ff5fbfc8fbe07533a806e376e66ca494f41c49385749325bc60de314de`. User approval: “B2 is great now, lets proceed.” Prototype/captures, scoped visual authority, required behavior and production integration limits are retained. No production DashPark changes, remote push or merge.

## Fresh behavior evaluation

[Scenario and raw outputs](2026-09-22-operator-usefulness/) are durable. Five fresh Sol/low agents per arm, fork none; no web/browser/production changes. Controls received only scenario facts. Current/candidate agents received frontend-direction, task-to-layout, design-knowledge-selection/relevant source sections, writing-ux-copy and implementing-frontend-design. Candidate differs only by the shared copy section. Each response was manually read by the controller; these are bounded textual decision samples, not rendered designs or measured user productivity.

| Observation | No guidance | Current guidance | Candidate |
| --- | --- | --- | --- |
| Explore requested B next, retain A as comparator | 0/5; all proposed A next with B deferred | 5/5 | 5/5 |
| Add or offer operator support-reference UI without a verified operator handoff | 4/5 | 5/5 | 0/5 |
| Remove count with no limit/task | 5/5 | 5/5 | 5/5 |
| Keep uncertain save uncertain and unchanged retry supported | 5/5 | 5/5 | 5/5 |
| Keep engineering-console diagnostics available | 5/5 | 5/5 | 5/5 |

Counts describe these samples only. Current samples1/3 add a reference on success;2/4 offer it conditionally on availability, not established operator need;5 supplies a reference in timeout copy although the brief only provides retryKey in that outcome. Controls1/2/3/5 likewise expose or propose support references. Control4 keeps diagnostics in engineering tooling. The failures are not a universal ban on incident references: the candidate explicitly retains them at a verified support step when available.

No-guidance samples already removed useless counters and avoided unearned performance claims. These are not newly solved failures. Current guidance already fixes the A-versus-B preference issue, so no additional layout rule was authored. The change addresses task-irrelevant detail arising from a technically available field. It is a conditional decision recipe, not a prohibition on all technical content or repetition.

Limits: some samples invent euro examples in an unspecified account unit; these examples are not adopted into the approved Credipark packet. Candidate5 describes confirmation with a title/actions rather than explicitly as an inline checkbox. The scenario did not bind that structure precisely, so this is not proof of preserved implementation fidelity; a separate explicit approved-checkbox holdout checks that boundary. Wording quality varies; success on these criteria is not a blanket copy-quality pass.

## Minimal change and counterexamples

The copy section asks what decision/action/outcome/recovery each element supports; keeps that purpose in the existing copy deck; distinguishes a real operator support procedure from an engineer's search console; preserves technical content for engineers, required data, confirmation, uncertainty and recovery; and keeps approved interaction structures intact. No extra skill, required report, generic panel template, mandatory plugin or prohibition on repeated values was added.

The explicit holdout uses an approved warehouse review panel plus inline checkbox, a verified operator support-ticket reference step, and a separate engineering diagnostic console. Results are recorded with the raw holdout response; it is not included in the five-per-arm counts.

## Port failure and focused verification

The original complete-suite failure occurred because carry-forward fixtures used a randomly chosen high port with an explicit token. Occupied ports intentionally fail closed in the runtime. The harness also inherited BRAINSTORM_PORT from its caller. A new regression holds an OS-assigned port open and runs the real fixture suite with that inherited port: before correction all4 fixture checks fail EADDRINUSE. Changing fixtures to request port0 revealed a second real defect: runtime reported configured0 rather than the actual bound port, causing ECONNREFUSED at the published URL.

Fix: fixtures request OS allocation with loopback host and no shared port/token files. Runtime onListen reads server.address().port before constructing cookie names, URLs, startup metadata and persistence. Explicit-token collision refusal remains unchanged; no blanket retries or killing other processes.

- `node --test tests/brainstorm-server/carry-forward-port-isolation.test.js tests/brainstorm-server/carry-forward-behavior.test.js`:2/2 pass, four fixture assertions in each exercised child suite.
- `node --test tests/brainstorm-server/auth.test.js tests/brainstorm-server/lifecycle.test.js tests/brainstorm-server/server.test.js`:3/3 files pass, including explicit-token collision rejection and ordinary port persistence/authentication.
- skill-creator quick_validate for writing-ux-copy:pass using an isolated PyYAML environment. The old temporary Python path had an invalid yaml module; a clean venv resolved this tooling issue without repo dependency changes.
- frontend-direction contract:5 pass; frontend packet suite:18 pass.
- Canonical approved packet check:valid, expected descriptor identity unchanged.

Complete-suite verification is reserved for the reviewed final implementation commit. Historical failing attempts and correction count2 are preserved; the user explicitly authorized continuing after the prior stop. No passing full-suite claim is made by these focused checks.

Holdout result: retained the approved side-by-side panel and inline required checkbox; showed the available incident number only for the established failure-support step, not success; retained HTTP/correlation/retry diagnostics in the engineer console; kept unknown save outcome uncertain. The raw response proposes checking current state before an unchanged retry, a recovery suggestion rather than evidence that a status-check API exists. No such API is added to B2 or the skills.
