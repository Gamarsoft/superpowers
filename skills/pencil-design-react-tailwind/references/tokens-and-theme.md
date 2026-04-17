# Tokens and Theme

## Principle

If a semantic token exists, use the semantic token.
Do not drop back to raw values.

## Tailwind v4 rules

- use `@import "tailwindcss"` instead of older `@tailwind` directives
- define semantic color tokens with `@theme { --color-* }`
- define semantic radii with `@theme { --radius-* }`
- use `@custom-variant dark (&:where(.dark, .dark *));` when the repo uses class-based dark mode
- do not fall back to `tailwind.config.ts` token wiring when the repo already uses Tailwind v4 CSS-first theming

## Common semantic mappings

| Design intent | Prefer |
|---|---|
| primary surface/action | semantic primary token class |
| primary foreground text | semantic primary-foreground token class |
| page background | semantic background token class |
| default text | semantic foreground token class |
| muted surface | semantic muted token class |
| muted text | semantic muted-foreground token class |
| border | semantic border token class |
| focus ring | semantic ring token class |
| card surface | semantic card token class |

## Token example

```css
@import "tailwindcss";

@theme {
  --color-background: oklch(100% 0 0);
  --color-foreground: oklch(14.5% 0.025 264);
  --color-primary: oklch(14.5% 0.025 264);
  --color-primary-foreground: oklch(98% 0.01 264);
  --color-border: oklch(91% 0.01 264);
  --radius-md: 0.375rem;
}

@custom-variant dark (&:where(.dark, .dark *));
```

## Radius mapping

Use semantic size names like:

- `sm`
- `md`
- `lg`
- `xl`

Do not emit raw radius literals when semantic radius tokens exist.

## What to avoid

- arbitrary literal value classes when semantic tokens already exist
- repeated inline theme values
- ad-hoc per-component token names that break consistency
- `bg-[#3b82f6]`, `text-[var(--primary)]`, `rounded-[6px]`, or similar arbitrary classes when semantic utilities exist
