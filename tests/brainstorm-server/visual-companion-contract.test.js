const fs = require('fs');
const path = require('path');
const assert = require('assert');

const guidePath = path.join(__dirname, '../../skills/brainstorming/visual-companion.md');
const skillEntrypointPath = path.join(__dirname, '../../skills/brainstorming/SKILL.md');
const examplesDir = path.join(__dirname, '../../skills/brainstorming/examples/visual-companion');
const pressureScenarioPath = path.join(
  __dirname,
  '../../skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md'
);

const guide = fs.readFileSync(guidePath, 'utf-8');
const skillEntrypoint = fs.readFileSync(skillEntrypointPath, 'utf-8');

const expectedArchetypes = [
  'side-by-side comparison',
  'ranked alternatives',
  'annotated recommendation',
  'carry-forward summary'
];

const expectedExampleFiles = [
  'side-by-side-comparison.html',
  'ranked-alternatives.html',
  'annotated-recommendation.html',
  'carry-forward-summary.html'
];

const expectedM002RefreshFiles = [
  'side-by-side-comparison.html',
  'ranked-alternatives.html',
  'annotated-recommendation.html'
];

const expectedM003PressureScenarioHeadings = [
  'first qualifying visual turn starts the companion path',
  'artifact-first sequencing before the terminal prompt',
  'question-tool continuity after earlier browser use',
  'explicit degraded fallback when the question tool is unavailable'
];

function assertIncludes(haystack, needle, context) {
  assert(
    haystack.includes(needle),
    `Expected ${context} to include "${needle}"`
  );
}

function assertOrdered(haystack, orderedNeedles, context) {
  let previousIndex = -1;
  for (const needle of orderedNeedles) {
    const idx = haystack.indexOf(needle);
    assert(idx >= 0, `Expected ${context} to include "${needle}"`);
    assert(
      idx > previousIndex,
      `Expected ${context} order to keep "${needle}" after previous workflow step`
    );
    previousIndex = idx;
  }
}

function getBetween(content, startMarker, endMarker, context) {
  const start = content.indexOf(startMarker);
  assert(start >= 0, `Expected ${context} to include start marker "${startMarker}"`);

  const end = content.indexOf(endMarker, start + startMarker.length);
  assert(end >= 0, `Expected ${context} to include end marker "${endMarker}"`);

  return content.slice(start, end);
}

function getBoldNumberedLabels(content) {
  return [...content.matchAll(/^\d+\.\s+\*\*(.+?)\*\*/gm)].map((match) =>
    match[1].trim().toLowerCase()
  );
}

function getMarkdownSection(content, heading, context) {
  const startMarker = `## ${heading}\n`;
  const start = content.indexOf(startMarker);

  assert(start >= 0, `Expected ${context} to include section heading "## ${heading}"`);

  const sectionStart = start + startMarker.length;
  const nextHeading = content.indexOf('\n## ', sectionStart);
  const sectionEnd = nextHeading >= 0 ? nextHeading : content.length;

  return content.slice(sectionStart, sectionEnd);
}

function getH2Headings(content) {
  return [...content.matchAll(/^##\s+(.+)$/gm)].map((match) => match[1].trim().toLowerCase());
}

function assertArchetypeLabels() {
  const v1Section = getBetween(
    guide,
    '## v1 authoring contract',
    'Do not invent extra archetypes in v1.',
    'visual-companion.md'
  );

  const listedArchetypes = getBoldNumberedLabels(v1Section);

  assert.deepStrictEqual(
    listedArchetypes,
    expectedArchetypes,
    `Expected exact v1 archetype list in order: ${expectedArchetypes.join(', ')}`
  );
}

function assertRoutingRule() {
  for (const [name, doc] of [
    ['visual-companion.md', guide],
    ['SKILL.md', skillEntrypoint]
  ]) {
    assertIncludes(doc, '/frontend-design', name);
    assertIncludes(doc, '$frontend-design', name);
  }

  assertIncludes(
    guide,
    'route the structuring step through **`/frontend-design`** or **`$frontend-design`**',
    'visual-companion.md routing rule'
  );
}

function assertGenuinelyVisualRoutingBoundary() {
  const guideOfferSection = getBetween(
    guide.toLowerCase(),
    '## offer rule',
    'suggested offer message:',
    'visual-companion.md offer rule'
  );
  const guideDecisionSection = getBetween(
    guide.toLowerCase(),
    '## per-question decision rule',
    '## runtime compatibility boundary (do not exceed)',
    'visual-companion.md per-question decision rule'
  );
  const skillVisualSection = getBetween(
    skillEntrypoint.toLowerCase(),
    '## visual companion',
    '## common mistakes to avoid',
    'SKILL.md visual companion section'
  );

  assertIncludes(guideOfferSection, 'genuinely visual', 'visual-companion.md offer rule');
  assertIncludes(
    guideDecisionSection,
    'materially easier to judge by seeing',
    'visual-companion.md visual routing threshold'
  );
  assertIncludes(
    guideDecisionSection,
    'than by reading',
    'visual-companion.md visual routing threshold'
  );
  assertIncludes(
    guideDecisionSection,
    'conceptual, scope, and text-first',
    'visual-companion.md terminal fallback boundary'
  );
  assertIncludes(
    guideDecisionSection,
    'stay in terminal',
    'visual-companion.md terminal fallback boundary'
  );

  assertIncludes(
    skillVisualSection,
    'materially easier to judge by seeing',
    'SKILL.md visual routing threshold'
  );
  assertIncludes(
    skillVisualSection,
    'than by reading',
    'SKILL.md visual routing threshold'
  );
  assertIncludes(
    skillVisualSection,
    'conceptual, scope, and text-first',
    'SKILL.md terminal fallback boundary'
  );
  assertIncludes(
    skillVisualSection,
    'stay in terminal',
    'SKILL.md terminal fallback boundary'
  );
}

function assertWorkflowAndDegradedMode() {
  const workflowOrder = [
    'instruction context',
    'repo design-context source if present',
    'one-time minimal session capture',
    'degraded mode'
  ];

  const guideWorkflowSection = getBetween(
    guide.toLowerCase(),
    '## first-use design-context workflow (bounded, required order)',
    'degraded mode means:',
    'visual-companion.md workflow section'
  );
  const skillWorkflowSection = getBetween(
    skillEntrypoint.toLowerCase(),
    'follow first-use workflow in order:',
    'preserve compatibility boundary language:',
    'SKILL.md workflow summary'
  );

  assertOrdered(guideWorkflowSection, workflowOrder, 'visual-companion.md workflow section');
  assertOrdered(skillWorkflowSection, workflowOrder, 'SKILL.md workflow summary');

  assertIncludes(
    guide,
    'proceed in **degraded mode** and say so explicitly.',
    'visual-companion.md degraded-mode rule'
  );
  assertIncludes(guide, 'Degraded mode means:', 'visual-companion.md degraded-mode explanation');
}

function assertPreDisplayQualityGate() {
  const qualityGateSection = getBetween(
    guide,
    '## Pre-display quality gate',
    '## Runtime compatibility boundary (do not exceed)',
    'visual-companion.md pre-display quality gate'
  );

  const checklistLabels = getBoldNumberedLabels(qualityGateSection);

  assert.deepStrictEqual(
    checklistLabels,
    [
      'genuinely visual fit',
      'concrete subject-specific visual content',
      'visible differences that support the decision',
      'clear recommendation or comparison legibility'
    ],
    'Expected exact pre-display quality gate checklist labels in order'
  );

  assertIncludes(
    qualityGateSection,
    'No placeholder screens.',
    'visual-companion.md placeholder-screen ban'
  );
  assertIncludes(
    qualityGateSection,
    'If any checklist item fails, revise the artifact or stay in terminal.',
    'visual-companion.md revise-or-stay-terminal rule'
  );
}

function assertCompatibilityBoundary() {
  assertIncludes(
    guide,
    '`full-document` screens remain supported for compatibility, but they are not the v1 default surface.',
    'visual-companion.md compatibility boundary'
  );
  assertIncludes(
    guide,
    'Do not introduce new required metadata keys beyond `data-choice` in v1.',
    'visual-companion.md metadata boundary'
  );

  assertIncludes(
    skillEntrypoint,
    'full-document` compatibility support',
    'SKILL.md compatibility summary'
  );
  assertIncludes(
    skillEntrypoint,
    'no new required metadata beyond `data-choice`',
    'SKILL.md metadata summary'
  );
}

function assertExampleKitPresence() {
  for (const fileName of expectedExampleFiles) {
    const filePath = path.join(examplesDir, fileName);
    assert(fs.existsSync(filePath), `Expected example file to exist: ${filePath}`);

    const content = fs.readFileSync(filePath, 'utf-8');
    assert(content.trim().length > 0, `Expected example file to be non-empty: ${filePath}`);
    assertIncludes(content, 'data-choice', `${fileName} interaction metadata`);
    assertIncludes(content, 'toggleSelect(this)', `${fileName} selection behavior`);
  }

  const links = [...guide.matchAll(/\(examples\/visual-companion\/([a-z-]+\.html)\)/g)].map(
    (match) => match[1]
  );

  assert.deepStrictEqual(
    links,
    expectedExampleFiles,
    `Expected guide example links in order: ${expectedExampleFiles.join(', ')}`
  );
}

function assertActiveExampleRefreshBoundary() {
  const refreshBoundarySection = getBetween(
    guide,
    '### Active example refresh boundary (M002)',
    'All examples stay fragment-first and use only the existing `data-choice` interaction boundary.',
    'visual-companion.md active example refresh boundary'
  );

  const listedFiles = [...refreshBoundarySection.matchAll(/`([a-z-]+\.html)`/g)].map((match) => match[1]);

  assert.deepStrictEqual(
    listedFiles.slice(0, expectedM002RefreshFiles.length),
    expectedM002RefreshFiles,
    `Expected exact M002 active refresh file list in order: ${expectedM002RefreshFiles.join(', ')}`
  );
  assertIncludes(
    refreshBoundarySection,
    '`carry-forward-summary.html` stays outside this refresh boundary unless a direct contradiction is found.',
    'visual-companion.md active example refresh boundary exclusion'
  );
}

function assertCarryForwardGuidance() {
  assertIncludes(
    guide,
    'Carry-forward continuity must live in visible authored copy, not in helper state, hidden metadata, or persisted browser events.',
    'visual-companion.md carry-forward rule'
  );
  assertIncludes(guide, 'Use **Chosen direction**', 'visual-companion.md chosen-direction rule');
  assertIncludes(guide, 'Use **Still open**', 'visual-companion.md still-open rule');
  assertIncludes(guide, 'Use **Degraded mode**', 'visual-companion.md degraded-mode carry-forward rule');
  assertIncludes(
    guide,
    'These labels should stay correct whether `state/events` exists, is empty, or was cleared on a newer screen.',
    'visual-companion.md state/events independence rule'
  );

  const annotatedRecommendation = fs.readFileSync(
    path.join(examplesDir, 'annotated-recommendation.html'),
    'utf-8'
  );
  const carryForwardSummary = fs.readFileSync(
    path.join(examplesDir, 'carry-forward-summary.html'),
    'utf-8'
  );

  assertIncludes(
    annotatedRecommendation,
    'click-assisted follow-up',
    'annotated-recommendation.html explicit carry-forward context'
  );
  assertIncludes(
    annotatedRecommendation,
    'Chosen direction',
    'annotated-recommendation.html chosen-direction wording'
  );
  assertIncludes(
    carryForwardSummary,
    'terminal-only follow-up',
    'carry-forward-summary.html explicit terminal-only context'
  );
  assertIncludes(
    carryForwardSummary,
    'Chosen direction',
    'carry-forward-summary.html chosen-direction wording'
  );
  assertIncludes(
    carryForwardSummary,
    'Still open',
    'carry-forward-summary.html still-open wording'
  );
  assertIncludes(
    carryForwardSummary,
    'Degraded mode',
    'carry-forward-summary.html degraded-mode wording'
  );
}

function assertM003PressureScenarioArtifact() {
  assert(
    fs.existsSync(pressureScenarioPath),
    `Expected M003 pressure-scenario artifact to exist: ${pressureScenarioPath}`
  );

  const pressureScenarios = fs.readFileSync(pressureScenarioPath, 'utf-8');
  const headings = getH2Headings(pressureScenarios);

  assert.deepStrictEqual(
    headings,
    expectedM003PressureScenarioHeadings,
    `Expected exact M003 pressure scenario headings in order: ${expectedM003PressureScenarioHeadings.join(', ')}`
  );

  for (const heading of expectedM003PressureScenarioHeadings) {
    const section = getMarkdownSection(
      pressureScenarios.toLowerCase(),
      heading,
      'visual-companion-protocol-pressure-scenarios.md'
    );

    assertIncludes(section, '### setup', `${heading} setup section`);
    assertIncludes(section, '### required outcome', `${heading} required outcome section`);
    assertIncludes(section, '### failure signature', `${heading} failure signature section`);
    assertIncludes(section, '### why current docs miss this', `${heading} rationale section`);
  }
}

function assertM003FirstQualifyingVisualTurnStartup() {
  const skillVisualSection = getBetween(
    skillEntrypoint.toLowerCase(),
    '## visual companion',
    '## common mistakes to avoid',
    'SKILL.md visual companion section'
  );

  assertIncludes(
    skillVisualSection,
    'the first later genuinely visual question must start the companion path instead of remaining terminal-only.',
    'SKILL.md first qualifying visual turn startup rule'
  );
}

function assertM003ArtifactFirstSequencing() {
  const guideDecisionSection = getBetween(
    guide.toLowerCase(),
    '## per-question decision rule',
    '## pre-display quality gate',
    'visual-companion.md per-question protocol section'
  );

  assertOrdered(
    guideDecisionSection,
    [
      'author or refresh the visual artifact first',
      'tell the user what they are viewing and what decision it supports',
      'ask the decision or confirmation in terminal with the platform question tool'
    ],
    'visual-companion.md artifact-first sequencing rule'
  );
}

function assertM003QuestionToolContinuityAndDegradedFallback() {
  const skillVisualSection = getBetween(
    skillEntrypoint.toLowerCase(),
    '## visual companion',
    '## common mistakes to avoid',
    'SKILL.md visual companion section'
  );

  assertIncludes(
    skillVisualSection,
    'the terminal decision prompt must stay present for qualifying visual turns even after the companion has already been opened earlier in the session.',
    'SKILL.md question-tool continuity rule'
  );
  assertIncludes(
    skillVisualSection,
    'if the platform question tool is unavailable, the agent may fall back to plain terminal text, but that is degraded behavior and should be named as such.',
    'SKILL.md degraded fallback naming rule'
  );
}

function run() {
  assertArchetypeLabels();
  assertRoutingRule();
  assertGenuinelyVisualRoutingBoundary();
  assertWorkflowAndDegradedMode();
  assertPreDisplayQualityGate();
  assertCompatibilityBoundary();
  assertExampleKitPresence();
  assertActiveExampleRefreshBoundary();
  assertCarryForwardGuidance();
  assertM003PressureScenarioArtifact();
  assertM003FirstQualifyingVisualTurnStartup();
  assertM003ArtifactFirstSequencing();
  assertM003QuestionToolContinuityAndDegradedFallback();

  console.log('PASS: visual companion contract + archetype kit assertions passed');
}

try {
  run();
} catch (error) {
  console.error('FAIL: visual companion contract + archetype kit assertions failed');
  console.error(error.message);
  process.exit(1);
}
