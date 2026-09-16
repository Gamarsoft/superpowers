### My initial question:
I am currently using the attached skills with Codex when I need to work with UI/UX design for the frontend of my webapp.
I want you to search for existing agent skills related to UI/UX design that could be beneficial and help Codex produce/implement better designs. For example maybe skills that would give Codex knowledge of UI/UX best practices and fondamental design principles etc.

---

Yes. **There are useful additions—but for your setup, I would add design knowledge and focused review skills, rather than another end-to-end frontend-design workflow.**

My strongest candidates are **`design-everyday-things`**, **`refactoring-ui`**, and **`web-design-guidelines`**. I would also check how much of **Impeccable’s detailed reference material** your existing integration actually makes available to Codex: its current upstream version already covers some of the usability knowledge you are looking for.

I reviewed your archive and the actual upstream skill definitions, not just directory listings. The recommendations below assess their content and compatibility with your workflow; I have **not benchmarked their effect on your application**.

## 1. What your current skills already cover

Your archive contains three complementary skills:

| Your skill                     | What it already does well                                                                                                                             |
| ------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------- |
| `frontend-direction`           | Establishes context and constraints, explores design directions, develops an interactive prototype, and produces a versioned, approved design packet. |
| `implementing-frontend-design` | Implements the approved packet in the actual application, checks fidelity and behavior, and requires independent runtime review.                      |
| `writing-ux-copy`              | Handles terminology, state-specific copy, source precedence, localization, and user-facing language.                                                  |

You already have substantial instructions about inspecting the existing application, preserving useful brownfield conventions, testing responsive behavior, handling states, and not treating an attractive screenshot as proof of a functioning interface.

**The main opportunity is to strengthen the reasoning behind design decisions.** For example:

> Rather than only asking “Is the hierarchy clear?”, give Codex a practical framework for deciding what deserves emphasis, how grouping should reflect the task, and when simplifying the interface would actually make a frequent user’s work harder.

Your `impeccable-brownfield-quality-layer.md` is particularly relevant: it already anticipates using an external quality layer without letting it replace your workflow. However, the archive contains that integration guidance—not the upstream Impeccable knowledge base itself.

---

## 2. The most relevant skills for foundational design knowledge

### A. `design-everyday-things` — my closest match to your explicit request

**Repository:** `wondelai/skills`
**Skill:** `design-everyday-things`

This is a community-authored adaptation of concepts associated with Don Norman’s *The Design of Everyday Things*. It covers discoverability, affordances and signifiers, mappings between controls and their effects, constraints, feedback, and conceptual models. It also distinguishes the difficulty of figuring out **how to perform an action** from the difficulty of understanding **what happened afterward**.

**Why I would use it in your workflow:** it encourages Codex to diagnose an interaction problem before trying to solve it with styling.

For example, imagine an unavailable action in your application. My preferred application of this framework would be to ask:

> Can the user understand why the action is unavailable, what prerequisite is missing, and how to satisfy it?

That is a better starting point than simply making the disabled button look more polished.

**Where it belongs:** during `frontend-direction`, before selecting an interaction model or approving the prototype.

**Caveat:** the skill includes a “10/10” scoring system and some overly absolute prescriptions. I would retain the explanatory concepts and diagnostic questions, but remove scoring as an approval condition. This is Wondel’s implementation of the ideas, not an official skill published by Don Norman.

**My recommendation: high-priority knowledge source, with a small local adaptation.**

### B. `refactoring-ui` — the strongest practical visual-design complement

**Repository:** `wondelai/skills`
**Skill:** `refactoring-ui`

This skill focuses on practical visual fundamentals: establishing hierarchy through emphasis and de-emphasis, using constrained spacing and typography scales, grouping related elements, managing depth, and making colors and other visual choices systematic. Its examples include Tailwind, but much of the underlying guidance concerns layout and visual relationships rather than a particular framework.

**Why I would use it:** your existing workflow can enforce consistency with an approved design; this can help Codex make better visual decisions **before that design becomes authoritative**.

For an operational application, I would use it to answer questions such as:

> Should the primary action become larger, or should competing headings, borders, badges, and secondary actions become quieter?

I would explicitly constrain it to your existing Angular application, component library, and design tokens. I would not let a Tailwind example become a reason to change the implementation stack.

**Where it belongs:** concept development and prototype refinement, followed by limited polish that stays within the approved direction.

**Caveat:** I found a concrete accessibility error in its text-size guidance, discussed below. Its visual advice is useful, but I would not treat the document as a normative accessibility reference.

**My recommendation: high-priority practical reference, after reviewing and correcting the local copy.**

### C. `ux-heuristics` — useful for explaining usability problems

**Repository:** `wondelai/skills`
**Skill:** `ux-heuristics`

This combines Nielsen-style usability heuristics with ideas from Steve Krug: system-status visibility, recognition rather than recall, orientation, error prevention and recovery, consistency, and efficiency. It provides a structured way to identify and prioritize usability problems rather than returning generic “make this cleaner” feedback.

**Why I would use it:** to review the task flow before prototype approval.

My preferred review question would be:

> Can a returning user complete the common task efficiently, understand the current state, and recover from a mistake without losing work?

That is distinct from checking whether the implementation matches the approved prototype: a prototype can be faithfully implemented and still embody a poor interaction.

**However, I would not automatically add another mandatory review stage for this skill.** Current Impeccable already includes Nielsen-based assessment and cognitive-load material, so this is better treated as a lighter alternative or a selective supplementary reference.

**My recommendation: useful, but lower marginal value when current Impeccable critique is already available.**

---

## 3. Impeccable: deepen your existing integration before duplicating it

**Repository:** `pbakaus/impeccable`
**Current main skill:** `impeccable`

The current upstream material is broader than a generic “make the UI look less AI-generated” prompt. In particular, its **Operate** reference targets applications, admin interfaces, and tools. It emphasizes task completion, scanability, familiar controls, appropriate information density, semantic states, and restrained expression. That is a much better fit for an operational webapp than applying landing-page aesthetics indiscriminately.

Its current critique reference also includes usability heuristics, cognitive-load assessment, interaction and information-architecture considerations, and evidence-oriented review procedures. **This materially overlaps with several separate UX-audit skills.**

For your setup, I would first establish whether your existing integration actually loads the relevant upstream material when Codex makes design decisions—not merely whether a file mentions Impeccable.

My preferred arrangement would be:

> Keep your `frontend-direction` and implementation skills in control. Consult Impeccable’s operational and craft references selectively, and incorporate relevant findings into the review stages you already have.

There is an important integration caveat: current Impeccable includes executable tooling and its own substantial orchestration, not just static Markdown advice. I would review that separately rather than assuming an upstream installation is equivalent to adding a reference document.

**My recommendation: probably the highest-leverage improvement to your existing setup, but not another workflow to run alongside it.**

---

## 4. The most useful implementation-review additions

### A. Vercel `web-design-guidelines`

**Repository:** `vercel-labs/agent-skills`
**Skill:** `web-design-guidelines`

This is a focused code-review skill. It retrieves Vercel’s Web Interface Guidelines, examines the requested files, and reports findings with file-and-line references. It is not a design-concept generator.

The underlying checklist covers practical implementation details such as semantic controls, labels, visible focus, form behavior, reduced motion, long-content handling, image dimensions, navigation state, and numeric typography. These are useful subjects to check after translating an approved design into code. Some examples and recommendations are React-oriented, so I would translate them into your application’s Angular conventions rather than apply their syntax or library choices literally.

**Where I would use it:** inside `implementing-frontend-design`, as a focused source-level review contributing to your existing verification process.

**Two adaptations I would make:**

* Use a reviewed local revision of the guidelines for reproducible reviews, rather than silently changing the rule set by fetching `main` on every run.
* Replace its `WebFetch` assumption with the tools actually available to Codex, or avoid the dependency by keeping the reviewed guidelines locally.

Both concerns follow directly from how the current skill is written.

I would also keep your `writing-ux-copy` conventions authoritative for wording and localization.

**My recommendation: the most useful new implementation-review companion to pilot first.**

### B. `fixing-accessibility`

**Repository:** `ibelick/ui-skills`
**Skill:** `fixing-accessibility`

This is a narrower helper covering accessible names, keyboard access, focus and dialogs, semantics, form errors, announcements, contrast, and motion. Importantly for your setup, it explicitly favors small, targeted fixes and discourages unrelated refactoring or UI-library migration.

**Why I would add it:** it gives Codex a concentrated checklist when implementing a dialog, combobox, form, menu, or other interaction-heavy component.

**Where it belongs:** during implementation of those components and in the corresponding runtime review—not only as an end-of-project cleanup pass.

I would use its rules as prompts for investigation, not as a compliance certificate. In your process, findings about keyboard behavior, focus restoration, and announcements should still require the appropriate runtime evidence.

**My recommendation: a good on-demand specialist, especially for custom interactions.**

---

## 5. Other worthwhile options—but not all should be installed

| Skill / repository                                         | What is useful                                                                                                                                                                                                   | My recommendation for your setup                                                                                                                                                              |
| ---------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **UI UX Pro Max** — `nextlevelbuilder/ui-ux-pro-max-skill` | Searchable reference data for styles, palettes, typography, charts, UX patterns, and stack-specific guidance. The current skill explicitly includes Angular.                                                     | Use for targeted research and comparison. Avoid making its generated design-system documents a competing authority alongside your approved packets.                                           |
| **`interface-design`** — `Dammyjay93/interface-design`     | Specifically targets product interfaces, dashboards, admin panels, and SaaS rather than marketing pages. Covers hierarchy, density, surfaces, tokens, and consistency.                                           | Worth studying, but it brings its own discovery process and persistent design-system document. I would extract relevant guidance rather than add a second design director.                    |
| **`emil-design-eng`** — `emilkowalski/skills`              | Practical design-engineering guidance, especially interaction feedback, motion, timing, easing, and deciding when animation is useful.                                                                           | A later-stage polish specialist. Apply CSS and interaction principles through Angular; do not import React dependencies simply because examples use them.                                     |
| **`ux-audit`** — `EliaAlberti/ux-audit-skill`              | Screenshot-based journey reviews with named heuristic references, severity-rated findings, and annotated evidence. Explicitly separates visible evidence from behavior that static screenshots cannot establish. | Useful for reviewing concept screens or a captured journey. Not a substitute for your browser-based implementation review, and I would review its standards-related details before adoption.  |

Of these, **UI UX Pro Max is the most different from what you already have**: I would use it as a searchable reference library, not another autonomous design workflow.

One pack I would **not install unchanged** for your application is `ibelick/ui-skills`’s **`baseline-ui`**. Its current instructions explicitly prescribe Tailwind, `motion/react`, and React-oriented primitives/utilities. That makes it substantially more stack-prescriptive than its general-sounding name suggests.

---

## 6. Why I recommend reviewed local adaptations, not blindly trusting the packs

The research surfaced a recurring issue: useful design knowledge is often mixed with subjective preferences, oversimplifications, or concrete errors.

### An actual contrast-rule error

Wondel’s `refactoring-ui` describes large text using an **“18px+”** threshold. WCAG’s large-text definition is **18 points for regular text or 14 points for bold text**—approximately **24 CSS pixels** and **18.7 CSS pixels**, respectively. Thus, ordinary 18px text does not automatically qualify for the relaxed large-text contrast threshold.

That does not invalidate the entire skill, but it is a good reason not to grant it unquestioned authority.

### Cognitive-load principles turned into arbitrary limits

Wondel’s usability skill includes a “7 ± 2” choice-reduction rule. Impeccable’s current critique material similarly turns working-memory guidance into several fixed visible-choice thresholds. I would remove these as automatic pass/fail rules. NN/g explicitly warns against treating seven as the general answer to how many navigation items an interface should have.

For your application, I would instead require a contextual explanation: Are choices meaningfully grouped? Are they familiar to the user? Does hiding them introduce extra work?

### Self-assigned scores are not validation

Several of the Wondel skills demand a “10/10” result. I would not let that override the much stronger evidence requirements in your existing skills. Their scoring systems are part of the community-authored prompts, not proof that users can successfully complete the task.

My preferred finding format would be:

> **Observed issue → affected task → relevant principle → proposed change → evidence needed to verify it.**

That preserves useful design reasoning without encouraging Codex to optimize a self-generated score.

---

## 7. How I would integrate these into your exact workflow

I would keep your existing three skills as the only workflow owners and introduce the additional material selectively.

| Existing stage                                      | Additional material I would consult                                        | Expected contribution                                                                            |
| --------------------------------------------------- | -------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------ |
| Understand the task and choose an interaction model | `design-everyday-things`; Impeccable’s operational guidance                | Explain the user’s goal, expected behavior, potential misunderstandings, and necessary feedback. |
| Develop and refine concepts                         | `refactoring-ui`; selected Impeccable references; optionally UI UX Pro Max | Improve hierarchy, grouping, density, typography, and consistency before approval.               |
| Review the prototype                                | Either Impeccable critique or a selected usability rubric                  | Identify task-level problems without introducing a duplicate approval process.                   |
| Implement and verify                                | `web-design-guidelines`; `fixing-accessibility` when relevant              | Produce concrete implementation findings that feed your existing independent review.             |

I would make one integration rule explicit:

> Additional skills provide knowledge and findings. They do not silently replace the approved design packet, redefine the workflow, migrate the frontend stack, or create a second source of design truth.

When a finding reveals a genuine conflict—such as an approved visual choice that creates an accessibility problem—I would require Codex to surface it for resolution, not either ignore it or silently redesign the page.

### Keep optional helpers explicitly invoked

Codex supports project-scoped skills under `.agents/skills/`. Its documentation also supports disabling implicit invocation for a helper through that skill’s `agents/openai.yaml`:

```yaml
policy:
  allow_implicit_invocation: false
```

This retains explicit use while preventing the helper from automatically taking over a matching task. Codex also does not merge skills with identical names, so I would give locally adapted helpers distinct names rather than create more competing `frontend-design` definitions. ([ChatGPT Learn][1])

For any adapted reference, I would record the upstream repository and revision, preserve its license information, and document the corrections. That makes subsequent updates reviewable.

## My final selection for you

**Start with a small set rather than installing every promising pack:**

1. **Verify and deepen the existing Impeccable integration**, especially its operational and detailed critique material.
2. **Add reviewed `design-everyday-things` and `refactoring-ui` references** to strengthen interaction reasoning and visual fundamentals.
3. **Pilot `web-design-guidelines` as the implementation-review companion**, with `fixing-accessibility` available for interaction-heavy components.

I would keep `ux-heuristics`, UI UX Pro Max, `interface-design`, and Emil’s design-engineering skill available for specific needs—not load all of them on every frontend task.

**The intended improvement is not “more design instructions.” It is better explanations for design choices, followed by concrete checks that those choices work in your actual application.**

[1]: https://learn.chatgpt.com/docs/build-skills "Build skills | ChatGPT Learn"
