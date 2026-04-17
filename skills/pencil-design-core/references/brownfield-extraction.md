# Brownfield Extraction

## Goal

Recreate the **real** product language in Pencil before improving it.

This is not a greenfield invention exercise.

## Extraction order

1. foundations / tokens
2. shell
3. shared patterns
4. feature-specific boards
5. optional variants only for real decision axes

## What to capture first

- shared shell structure
- page title and action-row behavior
- surface hierarchy
- recurring cards, forms, tables, badges, filters
- status semantics
- spacing rhythm
- actual density of operational screens
- must-preserve mobile behaviors that already work

## Separate three layers

### Observed current truth
What the current product actually does today.

### Conservative normalization target
What can be safely consolidated without changing product identity.

### Optional exploration
What can be explored only if the human explicitly wants alternatives.

## Do not do this

- do not silently redesign the shell during extraction
- do not replace dense workflows with airy consumer layouts
- do not “clean up” away runtime state, warnings, badges, or operational actions
- do not flatten a real legacy product into a generic AI dashboard aesthetic

## Useful repo-grounded questions

- what is shared versus page-local today?
- which patterns already exist but are only partially extracted?
- where is the real drift: color, spacing, layout wrappers, or component duplication?
- what must remain recognizable to current users?
