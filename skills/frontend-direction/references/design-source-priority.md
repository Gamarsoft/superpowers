# Design Source Priority

Use this file to keep UI direction grounded, especially in brownfield products.

The question is not “what tool can generate the prettiest screen?”
The question is “what source should win when sources disagree?”

## Source priority order

Higher sources outrank lower sources unless the human explicitly approves a redesign.

1. **Current live product behavior and representative screenshots**
   - Real shell, density, hierarchy, and state treatment
   - The current operator or user workflow
   - What people already rely on in production

2. **Current codebase primitives and shared patterns**
   - shared shell/layout components
   - theme variables / tokens / SCSS foundations
   - reusable page patterns
   - reusable tables, forms, dialogs, tabs, cards, filters, badges

3. **Repo-level anchoring docs, audits, and prior art**
   - frontend anchoring docs
   - `PRODUCT.md`
   - `DESIGN.md`
   - prior design reviews
   - implementation notes about what must stay unchanged
   - previous approved frontend direction packets that are still current

4. **Approved frontend packet support files**
   - `brownfield-ui-extraction.md`
   - `screen-index.md`
   - `chatgpt-image-2/` approved generated images when selected as visual truth
   - `pencil-workset.md` when Pencil is selected

5. **Selected durable visual-truth source**
   - approved ChatGPT Images 2 generated image files saved in the packet folder when the human selected image-only visual truth
   - `.pen` files that intentionally mirror current reality
   - extracted foundations, shell, pattern boards, and feature boards
   - selected Pencil variants that were consciously chosen

6. **Wireframes and written spec**
   - structural intent
   - behavior intent
   - still subordinate to observed product truth in brownfield work

7. **Temporary HTML visual-companion artifacts**
   - only for bounded comparison or explanation
   - never the durable packet source of truth
   - ideas must be translated back into the approved visual-truth source or the packet before they are considered real design direction

## Adapter rule

The chosen Pencil adapter does **not** outrank product truth or the selected visual-truth source.
It only helps interpret Pencil-backed design in a way that fits the target stack.

Examples:
- Angular + Nebular brownfield -> `pencil-design-angular-nebular`
- React / Tailwind / shadcn -> `pencil-design-react-tailwind`

## Default call by project type

### Brownfield
Preserve and extend the current product language.
Start from extraction, not invention.

### Greenfield
Start from the spec and user goal, but still prefer a converged approved visual-truth source over scattered generated screenshots. That source may be Pencil boards or approved ChatGPT Images 2 references saved in the packet folder.

## Rules

- Never let a lower-priority source silently override a higher-priority source.
- If no durable frontend baseline exists yet, create retained browser evidence from the running app before treating generated artifacts as trustworthy.
- In Impeccable v3 projects, use `PRODUCT.md` and `DESIGN.md` as anchoring context, but do not let them silently override observed brownfield runtime truth.
- If a generated concept conflicts with a must-preserve brownfield pattern, the pattern wins unless the human explicitly approves change.
- The frontend packet should point to **stable repo artifacts** first:
  - screenshots
  - extraction notes
  - approved ChatGPT Images 2 generated images when selected as visual truth
  - `.pen` files when Pencil is selected
- HTML companion screens can support a decision, but should not become the durable reference set.

## Brownfield continuity checks

Before accepting a new visual direction, ask:

- does this preserve the shell users already know?
- does this preserve the density bias where the workflow needs throughput?
- does this preserve the component vocabulary already present in the app?
- does this improve a specific pain point, or just look newer?
- would this fit the current implementation stack without forcing hidden redesign work?

## Angular / Nebular note

In older Angular + Nebular products, preserve:
- header and sidebar rhythm
- card and form structure
- operator action visibility
- status/badge language
- table and filter behavior
- configuration grouping patterns that already work

Do not let a tool collapse the product into a generic modern dashboard.
