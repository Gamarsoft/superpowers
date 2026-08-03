const fs = require('fs');
const path = require('path');
const assert = require('assert');

const FRAME_PATH = path.join(__dirname, '../../skills/brainstorming/scripts/frame-template.html');
const SERVER_PATH = path.join(__dirname, '../../skills/brainstorming/scripts/server.cjs');
const DIAGRAM_PATH = path.join(__dirname, '../../skills/brainstorming/examples/visual-companion/architecture-data-flow.html');
const RETRY_POLICY_PATH = path.join(__dirname, '../../skills/brainstorming/examples/visual-companion/retry-policy-review.html');
const CARRY_FORWARD_PATH = path.join(__dirname, '../../skills/brainstorming/examples/visual-companion/carry-forward-summary.html');
const frame = fs.readFileSync(FRAME_PATH, 'utf-8');
const server = fs.readFileSync(SERVER_PATH, 'utf-8');
const diagram = fs.readFileSync(DIAGRAM_PATH, 'utf-8');

const TOKENS = {
  light: {
    '--vc-canvas': '#F4F3EF',
    '--vc-surface': '#FCFBF8',
    '--vc-subtle': '#EBE9E3',
    '--vc-boundary': '#C8C5BC',
    '--vc-ink': '#181A17',
    '--vc-muted': '#5F625D',
    '--vc-faint': '#7A7E76',
    '--vc-info': '#2457D6',
    '--vc-success': '#18794E',
    '--vc-caution': '#8A4B08',
    '--vc-danger': '#B42318',
    '--vc-selected-surface': '#E8EEFF',
    '--vc-focus': '#2457D6'
  },
  dark: {
    '--vc-canvas': '#151614',
    '--vc-surface': '#1D1F1C',
    '--vc-subtle': '#242721',
    '--vc-boundary': '#44483F',
    '--vc-ink': '#F2F1EC',
    '--vc-muted': '#B6B8B1',
    '--vc-faint': '#8F948B',
    '--vc-info': '#9AB6FF',
    '--vc-success': '#6EE7B7',
    '--vc-caution': '#F5C26B',
    '--vc-danger': '#FF8A80',
    '--vc-selected-surface': '#273555',
    '--vc-focus': '#B7CAFF'
  }
};

function cssRule(selector) {
  let selectorIndex = frame.indexOf(selector);
  let matchingRuleIndex = -1;
  while (selectorIndex >= 0) {
    const nextBrace = frame.indexOf('{', selectorIndex + selector.length);
    if (matchingRuleIndex < 0 && /^\s*$/.test(frame.slice(selectorIndex + selector.length, nextBrace))) {
      matchingRuleIndex = selectorIndex;
    }
    selectorIndex = frame.indexOf(selector, selectorIndex + selector.length);
  }
  assert(matchingRuleIndex >= 0, `Missing CSS rule for ${selector}`);
  const openBrace = frame.indexOf('{', matchingRuleIndex + selector.length);
  const closeBrace = frame.indexOf('}', openBrace);
  assert(openBrace >= 0 && closeBrace >= 0, `Malformed CSS rule for ${selector}`);
  return frame.slice(openBrace + 1, closeBrace);
}

function assertDeclaration(rule, declaration, context) {
  assert(
    rule.replace(/\s+/g, ' ').includes(declaration),
    `Expected ${context} to include ${declaration}`
  );
}

function test(name, fn) {
  try {
    fn();
    console.log(`  PASS: ${name}`);
  } catch (error) {
    console.error(`  FAIL: ${name}`);
    console.error(`    ${error.message}`);
    process.exitCode = 1;
  }
}

console.log('\n--- Visual Companion Design Kit ---');

test('provides every approved opaque light and dark token', () => {
  const darkTheme = frame.match(/@media\s*\(prefers-color-scheme:\s*dark\)\s*\{([\s\S]*?)\n\s*\}/);
  assert(darkTheme, 'Missing dark color-scheme media query');

  for (const [theme, tokens] of Object.entries(TOKENS)) {
    const source = theme === 'light' ? frame : darkTheme[1];
    for (const [token, value] of Object.entries(tokens)) {
      assert(
        source.includes(`${token}: ${value};`),
        `Missing approved ${theme} token ${token}: ${value}`
      );
    }
  }
});

test('consumes every register-scoped custom property it declares', () => {
  const registerTokens = [...new Set(
    [...frame.matchAll(/(--vc-register-[\w-]+)\s*:/g)].map((match) => match[1])
  )];
  const unusedTokens = registerTokens.filter((token) => {
    const escapedToken = token.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
    return !new RegExp(`var\\(\\s*${escapedToken}(?:\\s*[,\\)])`).test(frame);
  });

  assert.deepStrictEqual(
    unusedTokens,
    [],
    `Register-scoped custom properties must affect rendered CSS: ${unusedTokens.join(', ')}`
  );
});

test('keeps the legacy frame variables, comparison classes, and fragment markers', () => {
  for (const marker of [
    '--bg-primary:',
    '--text-primary:',
    '--comparison-soft-bg:',
    '.option {',
    '.card {',
    '.mockup {',
    '<!-- CONTENT -->',
    'id="claude-content"',
    'data-comparison-kit="fragment-shell"'
  ]) {
    assert(frame.includes(marker), `Legacy compatibility marker is missing: ${marker}`);
  }
});

test('defines shared technical-editorial type roles', () => {
  const roles = {
    '.vc-display': ['font-size: clamp(2rem, 4vw, 3.5rem);', 'line-height: 1.02;', 'font-weight: 720;', 'letter-spacing: -0.035em;'],
    '.vc-heading': ['font-size: clamp(1.5rem, 2.4vw, 2.25rem);', 'line-height: 1.1;', 'font-weight: 700;', 'letter-spacing: -0.025em;'],
    '.vc-subheading': ['font-size: 1.125rem;', 'line-height: 1.25;', 'font-weight: 650;'],
    '.vc-body': ['font-size: 1rem;', 'line-height: 1.55;', 'max-width: 72ch;'],
    '.vc-label': ['font-size: 0.6875rem;', 'line-height: 1.2;', 'letter-spacing: 0.12em;', 'text-transform: uppercase;'],
    '.vc-annotation': ['font-size: 0.8125rem;', 'line-height: 1.45;', 'font-weight: 450;'],
    '.vc-mono': ['font-family: ui-monospace, SFMono-Regular, Menlo, Consolas, monospace;', 'font-variant-numeric: tabular-nums;']
  };

  assert(frame.includes('"Segoe UI"'), 'Shared system font stack must include Segoe UI');
  for (const [selector, declarations] of Object.entries(roles)) {
    const rule = cssRule(selector);
    declarations.forEach((declaration) => assertDeclaration(rule, declaration, selector));
  }
});

test('exposes composition hooks and gives each exemplar a meaningful register rule', () => {
  for (const selector of [
    '.vc-canvas',
    '.vc-section',
    '.vc-cluster',
    '.vc-split',
    '.vc-rail',
    '.vc-stage',
    '.vc-callout',
    '.vc-legend',
    '.vc-choice'
  ]) {
    cssRule(selector);
  }

  const registerContracts = [
    {
      name: 'diagram',
      exemplar: diagram,
      rule: '.vc-canvas[data-vc-register="diagram"] .vc-split'
    },
    {
      name: 'product-mockup',
      exemplar: fs.readFileSync(RETRY_POLICY_PATH, 'utf-8'),
      rule: '.vc-canvas[data-vc-register="product-mockup"] .vc-rail'
    },
    {
      name: 'editorial',
      exemplar: fs.readFileSync(CARRY_FORWARD_PATH, 'utf-8'),
      rule: '.vc-canvas[data-vc-register="editorial"] .vc-split'
    }
  ];
  for (const { name, exemplar, rule } of registerContracts) {
    assert(
      exemplar.includes(`data-vc-register="${name}"`),
      `${name} exemplar must expose its register root`
    );
    cssRule(rule);
  }

  assertDeclaration(cssRule('.vc-callout'), 'border-inline-start: 3px solid var(--vc-info);', '.vc-callout');
  assertDeclaration(cssRule('.vc-stage'), 'border: 1px solid var(--vc-boundary);', '.vc-stage');
  assertDeclaration(cssRule('.vc-section'), 'box-shadow: none;', '.vc-section');
});

test('makes choice states accessible without movement or permanent elevation', () => {
  const choice = cssRule('.vc-choice');
  const hover = cssRule('.vc-choice:hover');
  const focus = cssRule('.vc-choice:focus-visible');
  const selected = cssRule('.vc-choice.selected[aria-pressed="true"]');
  const marker = cssRule('.vc-choice.selected[aria-pressed="true"]::before');
  const unavailable = cssRule('.vc-choice[aria-disabled="true"], .vc-choice.unavailable');
  const unavailableMarker = cssRule('.vc-choice[aria-disabled="true"]::after, .vc-choice.unavailable::after');

  assertDeclaration(choice, 'min-height: 44px;', '.vc-choice');
  assertDeclaration(choice, 'box-shadow: 0 2px 8px rgba(0, 0, 0, 0.10);', '.vc-choice');
  assertDeclaration(hover, 'border-color: var(--vc-info);', '.vc-choice:hover');
  assertDeclaration(hover, 'color: var(--vc-ink);', '.vc-choice:hover');
  assert(!/transform\s*:/.test(hover), 'Choice hover must not move the element');
  assertDeclaration(focus, 'outline: 3px solid var(--vc-focus);', '.vc-choice:focus-visible');
  assertDeclaration(focus, 'outline-offset: 2px;', '.vc-choice:focus-visible');
  assertDeclaration(selected, 'background: var(--vc-selected-surface);', 'selected choice');
  assertDeclaration(selected, 'border-color: var(--vc-info);', 'selected choice');
  assertDeclaration(marker, 'content: "✓";', 'selected choice marker');
  assertDeclaration(unavailable, 'pointer-events: none;', 'unavailable choice');
  assertDeclaration(unavailable, 'color: var(--vc-muted);', 'unavailable choice');
  assertDeclaration(unavailable, 'border-style: dashed;', 'unavailable choice');
  assertDeclaration(unavailableMarker, 'content: "Unavailable";', 'unavailable choice marker');
});

test('uses reduced-motion and responsive composition fallbacks', () => {
  for (const media of [
    '@media (prefers-reduced-motion: reduce)',
    '@media (max-width: 820px)',
    '@media (max-width: 760px)',
    '@media (max-width: 700px)'
  ]) {
    assert(frame.includes(media), `Missing responsive or motion fallback: ${media}`);
  }

  const reducedMotion = frame.match(/@media \(prefers-reduced-motion: reduce\)\s*\{([\s\S]*?)\n\s*\}/);
  assert(reducedMotion && reducedMotion[1].includes('transition: none;'), 'Reduced motion must provide instantaneous feedback');
  assert(frame.includes('grid-template-columns: 1fr;'), 'Narrow layouts must fall back to one column');
  assert(frame.includes('height: 42px;'), 'Header must stay within the approved 40–44px height');
});

test('lets the diagram exemplar consume the approved diagram composition hooks', () => {
  for (const hook of [
    'class="vc-canvas" data-vc-register="diagram"',
    'class="vc-stage"',
    'vc-legend'
  ]) {
    assert(diagram.includes(hook), `Diagram exemplar must consume ${hook}`);
  }

  assert(
    diagram.includes('@media (max-width: 699px)'),
    'Diagram exemplar must define its narrow recomposition below 700px'
  );
  assert(
    diagram.includes('grid-template-columns: 1fr;'),
    'Diagram narrow layout must recompose to one column rather than scale a desktop canvas'
  );
});

test('keeps the trust-boundary meaning visible when the narrow diagram hides connectors', () => {
  const narrowStart = diagram.indexOf('@media (max-width: 699px)');
  const narrowDiagram = diagram.slice(narrowStart);

  assert(narrowStart >= 0, 'Diagram exemplar must define a narrow breakpoint');
  assert(
    narrowDiagram.includes('.vc-flow-connectors,\n      .vc-flow-trust-label {\n        display: none;'),
    'Narrow diagram must hide its desktop connector layer and label'
  );
  assert(
    narrowDiagram.includes('.vc-flow-trust-boundary--narrow {\n        display: block;'),
    'Narrow diagram must reveal a trust-boundary annotation when desktop connectors are hidden'
  );
  assert(
    diagram.includes('Trust boundary: Browser request enters validated API processing.'),
    'Narrow diagram must visibly explain where the trust boundary changes'
  );
});

test('lets the retry-policy review consume the product-mockup register and shared choice hooks', () => {
  assert(fs.existsSync(RETRY_POLICY_PATH), 'Expected retry-policy review exemplar to exist');
  const review = fs.readFileSync(RETRY_POLICY_PATH, 'utf-8');

  for (const hook of [
    'class="vc-canvas" data-vc-register="product-mockup"',
    'class="vc-stage vc-retry-review"',
    'class="vc-product-bar"',
    'class="vc-rail vc-cluster vc-product-nav"',
    'class="vc-section vc-product-section"',
    'class="vc-rail vc-section vc-product-evidence"',
    'class="options vc-product-actions"',
    'class="option vc-choice vc-choice--approve"',
    'class="option vc-choice vc-choice--reject"'
  ]) {
    assert(review.includes(hook), `Retry-policy review must consume ${hook}`);
  }

  for (const copy of [
    'Simulated product surface',
    'Review retry policy change',
    'Compare the current safeguards with the proposed limits before deciding.',
    'Ready for review',
    'Current policy',
    'Proposed change',
    'Evidence',
    'Guardrails',
    'Approve change',
    'Reject change'
  ]) {
    assert(review.includes(copy), `Retry-policy review must preserve approved copy: ${copy}`);
  }

  assert(review.includes('data-choice="approve-retry-policy"'), 'Approve action must use the existing data-choice boundary');
  assert(review.includes('data-choice="reject-retry-policy"'), 'Reject action must use the existing data-choice boundary');
  assert(review.includes('onclick="toggleSelect(this)"'), 'Retry-policy actions must use the existing selection behavior');
});

test('lets the narrow retry review shrink instead of clipping at 200% text zoom', () => {
  const review = fs.readFileSync(RETRY_POLICY_PATH, 'utf-8');
  const narrowStart = review.indexOf('@media (max-width: 819px)');
  const compactStart = review.indexOf('@media (max-width: 420px)');
  const narrowReview = review.slice(narrowStart, compactStart);

  assert(narrowStart >= 0 && compactStart > narrowStart, 'Retry-policy review must define its narrow layout range');
  assert(
    /\.vc-product-body\s*\{[\s\S]*?min-width:\s*0;[\s\S]*?\}/.test(narrowReview),
    'Narrow product body must allow its grid track to shrink when text is zoomed to 200%'
  );
  assert(
    /\.vc-product-body\s*>\s*\*\s*\{[\s\S]*?min-width:\s*0;[\s\S]*?\}/.test(narrowReview),
    'Narrow product regions must not force the body track wider than the viewport at 200% text zoom'
  );
  assert(
    /\.vc-product-proposed\s*\{[\s\S]*?overflow-x:\s*auto;[\s\S]*?\}/.test(narrowReview),
    'The dense proposed-change table must scroll inside its labeled region at 200% text zoom'
  );
});

test('lets the carry-forward memo consume the editorial composition hooks without choices', () => {
  assert(fs.existsSync(CARRY_FORWARD_PATH), 'Expected carry-forward summary exemplar to exist');
  const memo = fs.readFileSync(CARRY_FORWARD_PATH, 'utf-8');

  for (const hook of [
    'class="vc-canvas" data-vc-register="editorial"',
    'class="vc-section vc-carry-conclusion"',
    'class="vc-split vc-carry-layout"',
    'class="vc-rail vc-carry-rail"',
    'class="vc-callout vc-carry-fidelity"',
    'class="vc-annotation"'
  ]) {
    assert(memo.includes(hook), `Carry-forward memo must consume ${hook}`);
  }

  assert(memo.includes('max-width: 72ch;'), 'Carry-forward memo must bound its reading measure');
  assert(memo.includes('grid-template-columns: minmax(0, 1fr) minmax(224px, 256px);'), 'Carry-forward memo must use the approved desktop rail width');
  assert(memo.includes('@media (max-width: 759px)'), 'Carry-forward memo must define its narrow ordered flow');
  assert(memo.includes('grid-template-areas:\n          "conclusion"\n          "evidence"\n          "open"\n          "deferred";'), 'Carry-forward memo narrow flow must put decisions before assumptions');
  assert(!memo.includes('data-choice'), 'Carry-forward memo must remain read-only');
  assert(!memo.includes('toggleSelect(this)'), 'Carry-forward memo must not attach selection behavior');
});

test('keeps the approved waiting message character-for-character in the main-region shell', () => {
  assert(
    server.includes('Waiting for the next visual artifact…'),
    'Waiting state must be exactly "Waiting for the next visual artifact…"'
  );
});

test('gives the real waiting page the approved dark color-scheme palette', () => {
  assert(
    /@media\s*\(prefers-color-scheme:\s*dark\)\s*\{[\s\S]*body\s*\{[^}]*background:\s*#151614;[^}]*color:\s*#F2F1EC;[\s\S]*h1\s*\{[^}]*color:\s*#F2F1EC;[\s\S]*p,\s*\.brand\s*\{[^}]*color:\s*#B6B8B1;[\s\S]*\.brand-logo\s*\{[^}]*filter:\s*none;/i.test(server),
    'Waiting page must honor the approved dark canvas, ink, muted, and logo treatment'
  );
});

test('keeps narrow current-policy labels visibly separated from their values', () => {
  const retryPolicy = fs.readFileSync(RETRY_POLICY_PATH, 'utf-8');
  assert(
    /@media\s*\(max-width:\s*819px\)[\s\S]*\.vc-product-nav\s+\.vc-product-table\s+td:last-child\s*\{[^}]*padding-left:\s*12px;/i.test(retryPolicy),
    'Narrow current-policy values need a stable text gap under copy expansion'
  );
});

if (process.exitCode) {
  process.exit(process.exitCode);
}

console.log('PASS: visual companion design-kit contract checks passed');
