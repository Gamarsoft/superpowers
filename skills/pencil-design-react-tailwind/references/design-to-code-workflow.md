# React/Tailwind Design-to-Code Workflow

## Goal

Translate Pencil designs into reusable React-oriented implementation guidance without falling back to raw literal styling.

## Workflow

### 1. Read design guidance and repo conventions
Before generating code guidance:

- inspect the approved packet
- inspect relevant `.pen` files
- inspect repo token and component conventions
- inspect any responsive boards

### 2. Read variables

```text
pencil_get_variables({ filePath: "path/to/file.pen" })
```

Map each variable to the closest semantic token class or theme value in the repo.
If the repo uses Tailwind v4 token CSS, keep the mapping in `@theme` form rather than inventing ad-hoc class literals.

### 3. Read reusable components

```text
pencil_batch_get({
  filePath: "path/to/file.pen",
  patterns: [{ reusable: true }],
  readDepth: 2,
  searchDepth: 3
})
```

Translate them into reusable React components rather than repeated markup.

### 4. Read the design tree

Inspect the final design structure and decide:

- what becomes a reusable component
- what becomes a page section
- what remains page-local
- what responsive behavior changes across breakpoints

### 5. Generate mobile-first guidance

Create the base component structure for mobile/small screens first.
Then add breakpoint overrides for wider layouts.

### 6. Verify visually

Compare the resulting implementation to:

- the packet
- the `.pen` files
- screenshots
- responsive variants

## Rules

- prefer semantic class usage over raw arbitrary values
- prefer reusable components over duplicated markup
- keep token names stable across design and code
- do not generate framework-specific ornamentation that the repo does not already use

## Concrete translation rules

### Component mapping

- map Pencil reusable components to shadcn/ui or repo-native reusable components first
- if there is no obvious match, check the shadcn registry before inventing page-local markup
- map `ref` instances to component usages with props and variants, not copied JSX trees

### Styling and tokens

- use semantic utilities such as `bg-primary`, `text-foreground`, `border-border`, `rounded-md`
- use `@theme { --color-* }` and `@theme { --radius-* }` for Tailwind v4 token setup
- use `@custom-variant dark (&:where(.dark, .dark *));` if the repo relies on class-based dark mode
- never generate `bg-[#3b82f6]`, `text-[var(--primary)]`, `rounded-[6px]`, or similar arbitrary values when semantic utilities already exist

### Component implementation conventions

- use `cn()` for class merging when the repo has that utility
- use CVA for reusable component variants when the repo follows that pattern
- prefer Lucide when mapping generic Pencil icons into a Lucide-based repo
- follow React 19 conventions already adopted by the repo; do not reintroduce older `forwardRef` habits if the codebase has moved on

## Practical checklist

- [ ] did I read reusable components before generating JSX?
- [ ] did I map Pencil variables to semantic token classes instead of literals?
- [ ] did I check whether the pattern already exists in shadcn or the repo’s own library?
- [ ] is the result mobile-first and breakpoint-aware?
- [ ] do screenshots and browser output still match the approved Pencil evidence?
