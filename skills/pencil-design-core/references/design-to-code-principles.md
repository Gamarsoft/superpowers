# Design-to-Code Principles

## Purpose

Translate Pencil designs into implementation-ready guidance without losing system meaning.

## Principles

### 1. The design tree is evidence, not the whole truth
Also read:

- approved packet
- screenshots / platform runtime evidence
- current code primitives
- product constraints
- adapter-specific rules

### 2. Reuse system primitives
Map Pencil sections to the closest real shared implementation primitives before creating new code structures.

### 3. Preserve semantics
Tokens, statuses, hierarchy, and information priority matter more than node-for-node mechanical translation.

### 4. Record gaps honestly
If the design leaves something unresolved, document the gap instead of inventing silently.

### 5. Do not infer board intent during implementation

Every implementation-facing board or screenshot needs approved intent:

- `visual-truth`: visual treatment is binding.
- `semantic-guidance`: behavior, workflow, content priority, or state coverage is binding; visual treatment can adapt.
- `reference-only`: not an acceptance target.

If approval is missing, record the gap and ask before implementation. Do not let the code agent decide whether a board is a redesign target.

### 6. Delegate final code shape to the adapter
The core should not decide Angular/Nebular, React/Tailwind, or Flutter/Material structure.

### 7. Treat design and code as a two-way system

- brownfield work can start from code-to-design recreation, not only fresh design invention
- keep repo-local `.pen` files near the implementation context so agents can inspect both design and code
- if tokens are hardened in code, sync the corresponding variable intent back into Pencil rather than letting the two systems drift

## Generic workflow

1. read packet and relevant `.pen` files
2. identify shared patterns and repeated tokens
3. confirm approved board intent for each implementation reference
4. identify what must be shared versus page-local
5. translate to adapter-specific implementation guidance
6. verify against screenshots and platform runtime output using the approved intent mode
7. record deviations, compromises, and follow-up items

## Brownfield import prompts

Useful Pencil-side prompts when reconstructing an existing product into a workset:

- `Recreate the Button component from src/components/Button.tsx`
- `Import the LoginForm from my codebase into this design`
- `Create Pencil variables from my globals.css`
