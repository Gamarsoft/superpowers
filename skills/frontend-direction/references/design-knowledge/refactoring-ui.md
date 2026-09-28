# Refactoring UI — substantive design sections

This is adapted knowledge from the MIT-licensed Wondel.ai skill, not the book or an official publication by its authors. Source revision: `c172996495bed0fcd26896a9416b2093fd7073f0`. [License](LICENSE.txt). Use alongside the [selection and authority rules](../design-knowledge-selection.md). Original examples are retained to support application; they are not product requirements. Third-party workflow, scoring and unrelated reference links are omitted.

Source: `refactoring-ui/SKILL.md`, version 1.5.1; sections 1–7. Adaptations correct contrast units and replace universal density, scale, width and label prescriptions with project-scoped choices. Tailwind examples illustrate relationships; they do not authorize adding Tailwind.

### 1. Visual Hierarchy

**Core concept:** Not everything can be important. Create hierarchy through three levers: size, weight, and color.

**Why it works:** When every element competes for attention, nothing stands out; deliberately de-emphasizing secondary content makes primary content powerful by contrast.

**Key insights:**
- Combine levers, don't multiply — primary text = large OR bold OR dark, not all three; save "all three" for the single most important element
- Labels support the data, but must remain readable and discoverable. Use relative emphasis; uppercase or reduced contrast is not required.
- Semantic color ≠ visual weight — a muted secondary button often beats screaming red for routine destructive actions

**Product applications:**

| Context | Hierarchy Technique | Example |
|---------|---------------------|---------|
| **Form fields** | De-emphasize labels, emphasize values | Small uppercase label above large value |
| **Dashboards** | Key metric large, context small | "$42,300" large, "vs last month" small |
| **Tables** | De-emphasize headers, emphasize data | Headers uppercase small gray, data normal |

**Design patterns:**
- Three-level hierarchy: Size (large/base/small), Weight (bold/medium/normal), Color (dark/medium/light gray)
- Button hierarchy: primary (filled), secondary (outlined or muted), tertiary (text only)

**Ethical boundary:** Don't use hierarchy tricks to hide important information like pricing, terms, or cancellation options.

### 2. Spacing & Sizing

**Core concept:** Use a constrained spacing scale, not arbitrary values. Spacing defines relationships — closer elements read as more related.

**Why it works:** Arbitrary spacing (padding: 13px) creates inconsistency; a fixed scale forces deliberate decisions and harmonious layouts. Choose spacing for the task: dense operator interfaces can remain readable when relationships and hierarchy are clear.

**Key insights:**
- An example scale: 4, 8, 16, 24, 32, 48, 64px; reuse the project scale when one exists.
- Compare spacing against the real content and viewport; preserve useful information density.
- Spacing between groups must exceed spacing within groups
- Consider readable prose measure (often 45-75 characters); choose form and data widths from content, relationships and viewport rather than a universal maximum.

**Product applications:**

| Context | Spacing Strategy | Example |
|---------|-----------------|---------|
| **Icon + label** | Tight coupling (4px) | Small gap keeps them connected |
| **Card sections** | Section separation (24px) | Title, content, footer blocks |
| **Page sections** | Major sections (48-64px) | Hero, features, testimonials |

**CSS patterns:**
- `p-1`(4px) `p-2`(8px) `p-4`(16px) `p-6`(24px) `p-8`(32px) `p-12`(48px) `p-16`(64px)
- `max-w-prose`(65ch) `max-w-md`(28rem) `max-w-lg`(32rem) `max-w-xl`(36rem)
- `gap-2` for related items, `gap-6` for section separation

### 3. Typography

**Core concept:** Use a modular type scale, constrain line heights by context, and limit to two font families maximum.

**Why it works:** A modular scale (steps growing ~1.2× each) creates natural visual rhythm; tight line heights on headings and relaxed on body text improve readability in each context.

**Key insights:**
- Scale: 12, 14, 16, 18, 20, 24, 30, 36px (~1.2 modular, hand-tuned)
- Headings: tight line height (1.0-1.25); body: relaxed (1.5-1.75); wider text needs more line height
- Avoid weights below 400 for body text; use bold (600-700) for emphasis, not everything
- Two fonts max: one for headings, one for body (or one family with weight variation)

**Product applications:**

| Context | Typography Rule | Example |
|---------|----------------|---------|
| **Hero headline** | 36px, line-height 1.1, bold | Large impactful statement |
| **Body text** | 16px, line-height 1.75, normal | Comfortable reading |
| **Captions/labels** | 12-14px, line-height 1.5, medium gray | Secondary information |

**CSS patterns:**
- `text-xs`(12px) `text-sm`(14px) `text-base`(16px) `text-lg`(18px) `text-xl`(20px)
- `font-normal`(400) `font-medium`(500) `font-semibold`(600) `font-bold`(700)
- `leading-tight`(1.25) `leading-normal`(1.5) `leading-relaxed`(1.75)

### 4. Color

**Core concept:** Build a systematic palette with 5-9 shades per color, add subtle saturation to grays, and design in grayscale first.

**Why it works:** Random colors clash; a predefined shade system ensures consistency, and HSL adjustments create natural-feeling lighter and darker variants.

**Key insights:**
- A palette may use several shades from near-white to near-black; reuse the project palette. The sample uses `#111827` as a dark neutral.
- Pure grays look lifeless — tint them (cool UI: blue like `#64748b`; warm UI: yellow/brown like `#78716c`)
- HSL: lighter = raise lightness, lower saturation, hue toward 60°; darker = the reverse, hue toward 0°/240°
- Contrast minimums: 4.5:1 body text, 3:1 qualifying large text (18pt regular or 14pt bold, approximately 24px or 18.67px); use `#374151` (gray-700) on white, not lighter grays

**Product applications:**

| Context | Color Strategy | Example |
|---------|---------------|---------|
| **Primary palette** | 9 shades (50-900) of brand color | Blue-500 buttons, Blue-100 backgrounds |
| **Semantic colors** | Success/warning/error with shade ranges | Green-500 success, Red-500 errors |
| **Text colors** | Three levels: dark, medium, light | `text-gray-900`, `text-gray-600`, `text-gray-400` |

**CSS patterns:**
- `text-gray-900`(dark) `text-gray-600`(medium) `text-gray-400`(light)
- `bg-blue-50` for subtle backgrounds, `bg-blue-500` for primary actions
- `border-gray-200` for subtle borders, `border-gray-300` for stronger

### 5. Depth & Shadows

**Core concept:** Use a shadow scale to convey elevation — small shadows for slightly raised elements, large shadows for floating ones.

**Why it works:** The eye reads shadow size as height above the page; a consistent scale makes elevation legible, so users intuit what's interactive, floating, or background.

**Key insights:**
- Small shadows = raised slightly (buttons, cards); large = floating (modals, dropdowns)
- Good shadows have two parts: a tight dark shadow for crispness plus a larger soft one for atmosphere
- Depth without shadows: lighter top border + darker bottom border, subtle gradients, overlapping elements
- Don't overuse — if everything floats, nothing has depth; shadow color is transparent dark, never opaque gray

**Product applications:**

| Context | Shadow Level | Example |
|---------|-------------|---------|
| **Buttons** | `shadow-sm` (subtle raise) | Slightly elevated above surface |
| **Dropdowns** | `shadow-lg` (floating) | Menu clearly above content |
| **Modals** | `shadow-xl` (highest) | Overlay detached from page |

**CSS patterns:**
- `shadow-sm`: `0 1px 2px rgba(0,0,0,0.05)`
- `shadow-md`: `0 4px 6px rgba(0,0,0,0.1)`
- `shadow-lg`: `0 10px 15px rgba(0,0,0,0.1)`
- `shadow-xl`: `0 20px 25px rgba(0,0,0,0.15)`

### 6. Images & Icons

**Core concept:** Treat images as design elements, not afterthoughts. Size icons deliberately and use overlays to keep text readable on images.

**Why it works:** Poorly sized icons look awkward and unstyled images break consistency; deliberate treatment (overlays, object-fit, radius) makes interfaces feel polished.

**Key insights:**
- Size icons relative to context; use sets with consistent stroke width and style
- Never stretch or distort — use `object-fit: cover` with fixed aspect ratios and crop deliberately
- Text over images needs an overlay (semi-transparent gradient)
- Empty states are an opportunity — use illustrations plus a clear CTA, not just text

**Product applications:**

| Context | Image/Icon Technique | Example |
|---------|---------------------|---------|
| **Hero images** | Semi-transparent gradient overlay | Text readable over any photo |
| **Avatars** | Consistent size, rounded, fallback initials | 40px circle, object-fit cover |
| **Empty states** | Custom illustration + CTA | Friendly illustration with "Get started" |

**CSS patterns:**
- `object-fit: cover` with fixed `aspect-ratio` for consistent display
- Icon sizing: `w-4 h-4` inline, `w-6 h-6` navigation, `w-8 h-8` feature icons
- Overlay: `bg-gradient-to-t from-black/60 to-transparent` for text on images

### 7. Layout & Composition

**Core concept:** Don't center everything. Use alignment, overlap, and emphasis variation to create engaging compositions.

**Why it works:** A consistent left edge gives the eye a fixed return point per line, so it costs less to scan; centered multi-line text moves that edge every line and slows reading.

**Key insights:**
- Left-align by default; center only short headlines, heroes, single-action CTAs, and empty states
- Cards don't need to contain everything — let images bleed to edges or overlap containers
- Vary visual treatment in lists and feeds — feature some items, minimize others
- Use alignment to create relationships between unrelated elements

**Product applications:**

| Context | Layout Strategy | Example |
|---------|----------------|---------|
| **Hero sections** | Centered text, generous spacing | Short headline + subtext + single CTA |
| **Blog feeds** | Varied card sizes for emphasis | First post large, rest in 2-column grid |
| **Content pages** | Constrained width, left-aligned | `max-w-prose` container with left text |

**CSS patterns:**
- `text-left` by default, `text-center` only for heroes and short headlines
- `grid grid-cols-3 gap-6` for feature grids; `max-w-4xl mx-auto` for page containers
- `overflow-hidden` on cards with `object-fit: cover` images that bleed to edges
