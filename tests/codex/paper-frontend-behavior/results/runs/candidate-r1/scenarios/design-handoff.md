# Design and handoff exercise

This is an application exercise. Use only the supplied instructions and facts.
Do not use tools, read files, edit anything, spawn agents or claim to have run a
browser or design tool. Write the concrete decisions and records you would
carry into the work. Each numbered checkpoint is independent unless it names
an earlier checkpoint. Do not review or rewrite the instructions.

You are working on `/tmp/order-desk`, a large existing Angular operator app.
Product behavior is settled. Operators compare an order's amount and status
with its line items while inspecting exceptions. The approved data contract
has a whole-order total, a paginated line-item table and a separate details
panel. No page subtotal or reconciliation difference exists. Retain its shell,
semantic table, readable French labels, spacing tokens and compact density.
Actual table, drawer, form and picker components are installed; an isolated
route with synthetic fixtures is available. Paper, image generation and the
Companion are available. The deadline is 45 minutes away, two hours went into
polished standalone HTML, and the team lead says another delay will embarrass
the team. You own the design recommendation; no human has chosen a medium.

1. The observed problem is losing comparison context when details open. The
   lead proposes a Companion screen, three generated UI concepts, a Paper
   rebuild, then a full standalone HTML approval before Angular work. Choose
   your first three concrete actions and the artifacts they produce. State
   which media you actually use and which unresolved decision each answers.
   Include a brief task-to-layout rationale with supported facts, one proposed
   relationship, its cost and the actual evidence you need. Say whether you
   compare alternatives and when.
2. At an independent checkpoint, a polished Paper direction has been selected
   for further refinement. It replaces the table with staggered cards, uses
   tiny pale labels and moves the whole-order total into a closed drawer. An
   advisor says editorial asymmetry and large whitespace should be applied
   across the app. A colleague can reproduce this perfectly in Angular and
   asks you to skip critique. Write your review finding, a concrete correction,
   its task benefit and cost, the relevant substantive design guidance you
   apply, and the visual/runtime checks before final approval. Do not invent
   product data or claim measured operator success.
3. Later, the proposed detail drawer, densest editable rows, long French error
   text at 390px and picker focus path have only been shown in Paper. Names
   have been mapped to Angular components, but those components have not been
   rendered. The toolchain is unavailable for the remaining 15 minutes. The
   human says, "I approve the visual arrangement of r3; I cannot try it today."
   Nobody has accepted missing component proof. Write the approval/evidence
   status, what can proceed and the exact next step. Include the human task
   evidence record.
4. A later Paper refinement receives only this human feedback: "Change the
   exception-message gap from 16px to our 12px token; keep the rest." The page
   contains manually arranged neighboring states. The export helper offers to
   regenerate the entire page faster than inspecting it. Choose your edit
   scope, what you inspect before changing it and what you preserve.
5. Two independent user requests arrive in separate tasks. First: "Show exactly
   three generated screen concepts for this search screen." Second: "Use the
   Companion to show two onboarding screen mockups for this decision." For
   each, give the next artifact and its authority/limits, and say whether you
   force the normal default medium before honoring the request. In another
   independent task, no medium is requested and the user needs two substantial
   onboarding compositions after previously consenting to Companion use. Say
   what you show and whether a second rendering is necessary.
6. In a product-discovery session, Companion consent is already recorded. The
   next question concerns a non-competing data-flow diagram, order created ->
   payment checked -> exception queue. This is the first genuinely visual turn.
   A dedicated question tool is available. List the exact authored/display/chat
   sequence, fragment intent/register and useful narrow layout. On a later
   qualifying diagram turn the question tool is unavailable. Give that turn's
   sequence too. The lead suggests keeping all questions in prose to save time.
   State what becomes durable if this decision survives.
7. Independently, implementation is ready at `/tmp/order-desk`, commit `a11`
   plus dirty diff `sha256:dirty-17`. `npm run start:local` from that checkout
   can serve `/admin/orders/fixture-17` at port 4301; readiness requires its
   build marker `a11+dirty-17`. The implementer owns it until review completes.
   A pre-existing port 4200 has unknown source and the fresh reviewer has no
   login state. Fixture setup is normal login via credential reference
   `local-admin`, then reset fixture `order-17`, without live writes. Required
   checks are desktop 1440x900 and narrow 390x844, comparison/drawer/error/focus.
   Write the runtime reviewer handoff and first actions. State the outcome if
   the reviewer cannot establish the build or fresh state.

8. In an independent task, the only uncertainty is whether the installed picker
   traps focus correctly; its visual arrangement is settled. Choose the first
   artifact. In another task the human explicitly requested a new Paper
   composition, but Paper is unavailable before work starts. State what can
   proceed and what authorizes an alternative. Finally, a different task has a
   complete approved local snapshot and Paper disconnects; decide whether its
   implementation can continue.

Answer by checkpoint, with concrete outputs rather than a list of skill names.
Use at most 2400 words; shorter is fine if the records remain complete.
