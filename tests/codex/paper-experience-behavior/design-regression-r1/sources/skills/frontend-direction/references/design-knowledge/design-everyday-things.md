# Design of Everyday Things — interaction sections

This is adapted knowledge from the MIT-licensed Wondel.ai skill, not the book or an official publication by its authors. Source revision: `c172996495bed0fcd26896a9416b2093fd7073f0`. [License](LICENSE.txt). Use alongside the [selection and authority rules](../design-knowledge-selection.md). Original examples are retained to support application; they are not product requirements. Third-party workflow, scoring and unrelated reference links are omitted.

Source: `design-everyday-things/SKILL.md`, version 1.4.0; Two Gulfs, seven principles, Human Error and Seven Stages of Action. Adaptations qualify universal timing, constraint and blame claims, and avoid implying unsupported undo or persistence capabilities.

## The Two Gulfs

Every interaction with a product requires bridging two gulfs:

```
USER                                    PRODUCT
  │                                        │
  ├──── Gulf of Execution ────────────────→│
  │     "How do I do what I want?"         │
  │                                        │
  │←──── Gulf of Evaluation ──────────────┤
  │     "What happened? Did it work?"      │
```

### Gulf of Execution

**The gap between what users want to do and what the product lets them do.** Users ask: What can I do here? Which control do I use?

**Bridge with:** clear signifiers, natural mappings, constraints, familiar conceptual models.

### Gulf of Evaluation

**The gap between what the product did and what users understand happened.** Users ask: What happened? Did it work? What state is the system in?

**Bridge with:** immediate visible feedback, clear system-state indicators, meaningful error messages, progress indicators.

**Design goal:** Make both gulfs as narrow as possible — action and understanding should be immediate.

## Seven Fundamental Design Principles

### 1. Discoverability

**Definition:** Can users figure out what actions are possible and how to perform them? Its five components — affordances, signifiers, constraints, mappings, feedback — are detailed below.

**Test:** Observe a representative user attempting the task; record which actions they cannot find and why. A universal time limit does not establish discoverability.

**Anti-pattern:** Relying on documentation to explain a control that could be understandable in context. Complex tasks may still need training or help.

### 2. Affordances

**Definition:** The relationship between an object's properties and a user's capabilities that determines how the object could be used.

**Key insight:** Affordances exist whether or not they are perceived — what matters for design is *perceived* affordance.

| Type | Definition | Example |
|------|------------|---------|
| **Real** | Physical capability exists | A button affords pressing |
| **Perceived** | User believes capability exists | A raised area looks clickable |
| **Hidden** | Exists but isn't obvious | Right-click context menu |
| **False** | Appears to afford action but doesn't | Decorative element that looks clickable |
| **Anti-affordance** | Prevents action | A barrier that blocks movement |

**Digital applications:**

| Element | Affordance | How to Signal |
|---------|------------|---------------|
| **Button** | Clicking/tapping | Raised, colored, shadow, hover state |
| **Text field** | Text input | Border, placeholder text, label |
| **Scroll area** | Scrolling | Scroll bar, fade at edge, partial content |

**Common failures:** flat design erasing perceived affordances (button or label?), too-small touch targets, interactive and decorative elements that look identical.

### 3. Signifiers

**Definition:** Signals that communicate where the action should take place. **Affordances determine what you CAN do; signifiers show you WHERE and HOW.**

| Type | Definition | Example |
|------|------------|---------|
| **Deliberate** | Designed to communicate | "Push" label on door, placeholder text |
| **Accidental** | Unintentional but informative | Worn path in grass (people walk here) |
| **Social** | Other people's behavior | Line of people indicates entrance |

**Digital signifiers:**

| Signifier | What It Communicates | Example |
|-----------|---------------------|---------|
| **Cursor change + hover state** | This is interactive | Pointer → hand on links; button color change |
| **Icons + labels** | Function of the element | Magnifying glass = search; "Submit", "Cancel" |
| **Color + position** | Status, category, hierarchy | Red = error, green = success; close button top-right |

**Design consideration:** Add a signifier where observed uncertainty warrants it; excessive signals compete with the task.

### 4. Mappings

**Definition:** The relationship between controls and their effects. **Natural mapping** means the spatial layout of controls matches the layout of what they control.

| Mapping Quality | Example | Why It Works/Fails |
|-----------------|---------|-------------------|
| **Natural** | Volume slider (up = louder) | Matches mental model |
| **Poor** | Light switch panel | No spatial correspondence to lights |
| **Poor** | Stovetop knobs in a row | Layout doesn't match burner positions |

**Digital principles:** controls near what they affect, layout mirroring content, direction matching expectation (scroll down = content moves up), related controls grouped.

| Technique | How It Works | Example |
|-----------|-------------|---------|
| **Proximity** | Control near target | Edit button next to content |
| **Spatial** | Layout mirrors real world | Map controls match compass directions |
| **Cultural** | Follows conventions | Red = stop/danger, green = go/safe |
| **Sequential** | Follows natural order | Steps 1, 2, 3 left to right (or top to bottom) |

### 5. Constraints

**Definition:** Limiting the possible actions to prevent errors.

| Type | Mechanism | Example |
|------|-----------|---------|
| **Physical** | Shape/size prevents wrong action | USB plug only fits one way |
| **Cultural** | Social norms guide behavior | Red means stop, green means go |
| **Semantic** | Meaning restricts options | A rearview mirror only makes sense facing backward |
| **Logical** | Logic limits choices | Only one hole left for the last screw |

**Digital constraints:**

| Constraint | Implementation | Example |
|------------|---------------|---------|
| **Input validation** | Restrict what can be entered | Date picker vs. free text |
| **Disabled states** | Gray out unavailable options | "Submit" disabled until form valid |
| **Forced sequence + undo** | Steps in order; allow reversal | Wizard with locked steps; Gmail "Undo send" |

**Design consideration:** Constraints can prevent invalid actions, but can also obstruct valid work. Preserve the actual business rules; do not add prerequisites merely to simplify the interface.

### 6. Feedback

**Definition:** Communicating the results of an action back to the user. Feedback should acknowledge input promptly, communicate progress and outcome, and match the actual operation.

| Type | When to Use | Example |
|------|-------------|---------|
| **Visual** | Most actions | Button press animation, color change, checkmark |
| **Auditory** | Important events, confirmations | Success chime, error sound |
| **Haptic** | Touch devices, confirmation | Vibration on key press |
| **Progress** | Long operations | Progress bar, spinner, skeleton screen |

**Digital feedback patterns:**

| Situation | Feedback Needed | Example |
|-----------|----------------|---------|
| **Form submission** | Success/error message | "Saved!" toast or inline error |
| **Loading** | Progress indicator | Spinner, skeleton screen, percentage |
| **Error** | What went wrong + how to fix | "Invalid email. Please check format." |

**Timing:** Distinguish acknowledgement from completion. Show truthful progress for longer operations; do not invent percentages or imply that a pending operation succeeded.

**Common failures:** no feedback (did my click register?), delayed feedback (feels broken), unclear feedback, alert overload.

### 7. Conceptual Models

**Definition:** The user's mental model of how a product works.

| Model | Held By | Description |
|-------|---------|-------------|
| **Design model** | Designer | How the designer thinks it works |
| **User's model** | User | How the user thinks it works |
| **System image** | Product | What the product actually communicates |

**Goal:** The user's model should match the design model; the system image is the only bridge. Matching models let users predict outcomes and recover from errors; mismatches breed confusion, self-blame, and support calls.

**Example (thermostat):** design model — set a temperature, the system maintains it; common user model — higher setting heats faster (wrong), so users crank it to 90°F.

**Build correct models with:** familiar metaphors (desktop, trash), visible system state, clear feedback, consistent behavior, progressive disclosure.

## Human Error

When an error occurs, investigate the interface and context rather than blaming the person. Design can prevent or mitigate many errors; not every error has a single design cause.

### Types of Errors

**Slips** — correct intention, wrong action:

| Slip Type | Cause | Example | Design Fix |
|-----------|-------|---------|------------|
| **Action slip** | Wrong action on right target | Click "Delete" instead of "Edit" | Separate destructive actions |
| **Memory lapse** | Forget step in sequence | Forget attachment after writing "attached" | Gmail's attachment reminder |
| **Mode error** | Right action, wrong mode | Type in caps lock | Show mode state clearly |
| **Capture error** | Habit overrides intention | Drive to old office on autopilot | Interrupt at decision points |

**Mistakes** — wrong intention, executed correctly:

| Mistake Type | Cause | Example | Design Fix |
|-------------|-------|---------|------------|
| **Rule-based** | Apply wrong rule | Use formula for wrong situation | Provide context, confirm |
| **Knowledge-based** | Incomplete/wrong mental model | Misunderstand how system works | Better conceptual model |
| **Memory lapse** | Forget goal or plan | Forget why you opened the fridge | Reminders, history |

### Design for Error

**Prevent:** appropriate constraints, sensible defaults, forgiving input, and confirmation where consequences warrant it. Offer undo only when the system can actually reverse the action.
**Recover:** clear errors and preserved work; use partial saves or reset only where the application supports them. Explain consequential recovery actions.

**Error message checklist:**
- [ ] Says what went wrong (in human language)
- [ ] Says how to fix it
- [ ] Doesn't blame the user
- [ ] Preserves user's work
- [ ] Provides alternative path

## The Seven Stages of Action

**Norman's model for how humans interact with products:**

```
1. GOAL      → "I want to adjust the temperature"
2. PLAN      → "I'll use the thermostat"
3. SPECIFY   → "I'll press the up arrow"
4. PERFORM   → (presses button)
   ─── Gulf of Execution ───
5. PERCEIVE  → (sees display change)
6. INTERPRET → "The number went up"
7. COMPARE   → "Is this what I wanted?"
   ─── Gulf of Evaluation ───
```

**Design implications:** support stages 1-3 with signifiers, mappings, and constraints; stage 4 with good affordances; stages 5-7 with feedback and visible state. Walk any interaction through each stage to find where users get stuck.
