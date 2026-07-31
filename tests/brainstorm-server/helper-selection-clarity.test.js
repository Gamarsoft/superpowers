const fs = require('fs');
const path = require('path');
const vm = require('vm');
const assert = require('assert');

const helperPath = path.join(__dirname, '../../skills/brainstorming/scripts/helper.js');
const frameTemplatePath = path.join(__dirname, '../../skills/brainstorming/scripts/frame-template.html');
const helperSource = fs.readFileSync(helperPath, 'utf-8');
const frameTemplate = fs.readFileSync(frameTemplatePath, 'utf-8');

const DEFAULT_INDICATOR_TEXT = 'Click an option above to confirm the current selection, then return to the terminal';
const WORKFLOW_BANNED_STRINGS = ['Chosen direction', 'Still open', 'state/events'];

class FakeClassList {
  constructor(element, initial = []) {
    this.element = element;
    this.values = new Set(initial.filter(Boolean));
    this.sync();
  }

  add(...tokens) {
    tokens.forEach((token) => this.values.add(token));
    this.sync();
  }

  remove(...tokens) {
    tokens.forEach((token) => this.values.delete(token));
    this.sync();
  }

  toggle(token) {
    if (this.values.has(token)) {
      this.values.delete(token);
      this.sync();
      return false;
    }

    this.values.add(token);
    this.sync();
    return true;
  }

  contains(token) {
    return this.values.has(token);
  }

  sync() {
    this.element.className = Array.from(this.values).join(' ');
  }
}

class FakeElement {
  constructor(tagName, { id = '', classes = [], dataset = {}, text = '', attributes = {} } = {}) {
    this.tagName = String(tagName).toLowerCase();
    this.id = id;
    this.dataset = { ...dataset };
    this.parentElement = null;
    this.children = [];
    this.classList = new FakeClassList(this, classes);
    this._textContent = text;
    this.innerHTML = '';
    this.attributes = new Map(Object.entries(attributes));
    this.clickCount = 0;
  }

  append(...children) {
    children.forEach((child) => {
      child.parentElement = this;
      this.children.push(child);
    });
    return this;
  }

  get textContent() {
    if (this.innerHTML) return this.innerHTML;
    return this._textContent + this.children.map((child) => child.textContent).join('');
  }

  set textContent(value) {
    this._textContent = String(value);
    this.innerHTML = '';
  }

  hasAttribute(name) {
    return this.attributes.has(name);
  }

  getAttribute(name) {
    return this.attributes.has(name) ? this.attributes.get(name) : null;
  }

  setAttribute(name, value) {
    this.attributes.set(name, String(value));
  }

  matchesSimple(selector) {
    if (!selector) return false;
    if (selector.startsWith('.')) return this.classList.contains(selector.slice(1));
    if (selector === '[data-choice]') return this.dataset.choice !== undefined;
    return this.tagName === selector.toLowerCase();
  }

  matchesSelector(selector) {
    const parts = selector.trim().split(/\s+/).filter(Boolean);
    if (parts.length === 0) return false;
    if (!this.matchesSimple(parts[parts.length - 1])) return false;

    let currentAncestor = this.parentElement;
    for (let i = parts.length - 2; i >= 0; i -= 1) {
      while (currentAncestor && !currentAncestor.matchesSimple(parts[i])) {
        currentAncestor = currentAncestor.parentElement;
      }
      if (!currentAncestor) return false;
      currentAncestor = currentAncestor.parentElement;
    }

    return true;
  }

  querySelectorAll(selector) {
    const selectors = selector.split(',').map((part) => part.trim()).filter(Boolean);
    const matches = [];

    function visit(node) {
      node.children.forEach((child) => {
        if (selectors.some((candidate) => child.matchesSelector(candidate))) {
          matches.push(child);
        }
        visit(child);
      });
    }

    visit(this);
    return matches;
  }

  querySelector(selector) {
    return this.querySelectorAll(selector)[0] || null;
  }

  closest(selector) {
    let node = this;
    while (node) {
      if (node.matchesSelector(selector)) return node;
      node = node.parentElement;
    }
    return null;
  }
}

class FakeDocument {
  constructor(root) {
    this.root = root;
    this.listeners = {};
  }

  addEventListener(type, handler) {
    this.listeners[type] = handler;
  }

  getElementById(id) {
    return this.root.querySelector(`#${id}`) || findById(this.root, id);
  }

  querySelectorAll(selector) {
    return this.root.querySelectorAll(selector);
  }

  dispatchClick(target) {
    assert(this.listeners.click, 'Expected helper to register a document click listener');
    this.listeners.click({ target });
  }

  dispatchKeydown(target, key) {
    assert(this.listeners.keydown, 'Expected helper to register a document keydown listener');
    let defaultPrevented = false;
    this.listeners.keydown({
      target,
      key,
      preventDefault() {
        defaultPrevented = true;
      }
    });
    return { defaultPrevented };
  }
}

function findById(node, id) {
  for (const child of node.children) {
    if (child.id === id) return child;
    const nested = findById(child, id);
    if (nested) return nested;
  }
  return null;
}

function createOption(label, choice, { selected = false, attributes = {} } = {}) {
  const option = new FakeElement('div', {
    classes: ['option'].concat(selected ? ['selected'] : []),
    dataset: { choice },
    attributes
  });
  const letter = new FakeElement('div', { classes: ['letter'], text: choice.slice(0, 1).toUpperCase() });
  const content = new FakeElement('div', { classes: ['content'] });
  const heading = new FakeElement('h3', { text: label });
  const body = new FakeElement('p', { text: `${label} description` });
  content.append(heading, body);
  option.append(letter, content);
  return option;
}

function buildHarness({
  selectedInSingle = [],
  selectedInMulti = [],
  singleAttributes = [],
  includeIndicator = true
} = {}) {
  const indicator = new FakeElement('span', { id: 'indicator-text', text: DEFAULT_INDICATOR_TEXT });
  const indicatorBar = new FakeElement('div', { classes: ['indicator-bar'] }).append(indicator);

  const singleOptions = [
    createOption('Option A · Inline release banner', 'inline-release-banner', {
      selected: selectedInSingle.includes(0),
      attributes: singleAttributes[0]
    }),
    createOption('Option B · Activity feed card', 'activity-feed-card', {
      selected: selectedInSingle.includes(1),
      attributes: singleAttributes[1]
    })
  ];

  const multiOptions = [
    createOption('Permission fallback copy', 'permission-error-copy', {
      selected: selectedInMulti.includes(0)
    }),
    createOption('Default file format', 'default-format', {
      selected: selectedInMulti.includes(1)
    }),
    createOption('Post-export completion signal', 'post-export-notification', {
      selected: selectedInMulti.includes(2)
    })
  ];

  const singleContainer = new FakeElement('div', { classes: ['options'] }).append(...singleOptions);
  const multiContainer = new FakeElement('div', {
    classes: ['options'],
    dataset: { multiselect: '' }
  }).append(...multiOptions);
  const standaloneChoice = createOption('Standalone choice', 'standalone-choice');

  const root = new FakeElement('body').append(singleContainer, multiContainer, standaloneChoice);
  if (includeIndicator) root.append(indicatorBar);
  const document = new FakeDocument(root);
  const websocketMessages = [];

  class FakeWebSocket {
    constructor(url) {
      this.url = url;
      this.sent = [];
      this.readyState = FakeWebSocket.OPEN;
    }

    send(payload) {
      const parsed = JSON.parse(payload);
      this.sent.push(parsed);
      websocketMessages.push(parsed);
    }
  }

  FakeWebSocket.OPEN = 1;

  const window = {
    location: {
      host: 'localhost:3334',
      reload() {
        window.reloadCalled = true;
      }
    },
    selectedChoice: null
  };
  window.window = window;

  vm.runInNewContext(helperSource, {
    window,
    document,
    WebSocket: FakeWebSocket,
    Date: { now: () => 1710000000000 },
    setTimeout: (fn) => {
      fn();
      return 1;
    },
    clearTimeout: () => {},
    console
  }, { filename: helperPath });

  [...singleOptions, ...multiOptions, standaloneChoice].forEach((option) => {
    option.click = () => {
      option.clickCount += 1;
      window.toggleSelect(option);
      document.dispatchClick(option);
    };
  });

  return {
    document,
    indicator,
    singleOptions,
    multiOptions,
    standaloneChoice,
    websocketMessages,
    window
  };
}

function runClickFlow(harness, option) {
  harness.window.toggleSelect(option);
  harness.document.dispatchClick(option);
}

function run() {
  let passed = 0;
  let failed = 0;

  function test(name, fn) {
    try {
      fn();
      console.log(`  PASS: ${name}`);
      passed += 1;
    } catch (error) {
      console.log(`  FAIL: ${name}`);
      console.log(`    ${error.message}`);
      failed += 1;
    }
  }

  console.log('\n--- Helper selection clarity ---');

  test('frame template exposes the clearer default selection guidance as a live status surface', () => {
    assert(
      frameTemplate.replace(/\s+/g, ' ').includes(DEFAULT_INDICATOR_TEXT),
      'frame-template.html should expose the updated default selection guidance'
    );
    assert(
      frameTemplate.includes('role="status"') && frameTemplate.includes('aria-live="polite"'),
      'indicator surface should stay observable as a live status region'
    );
  });

  test('helper keeps default guidance when no authored selection exists', () => {
    const harness = buildHarness();
    assert.strictEqual(harness.indicator.textContent, DEFAULT_INDICATOR_TEXT);
  });

  test('helper hydrates a uniquely authored selected container from current DOM state', () => {
    const harness = buildHarness({ selectedInSingle: [0] });
    assert.strictEqual(
      harness.indicator.innerHTML,
      '<span class="selected-text">Selected:</span> Option A · Inline release banner — return to the terminal to continue'
    );
  });

  test('helper hydrates choice semantics and pressed state while preserving authored attributes', () => {
    const harness = buildHarness({
      selectedInSingle: [0],
      singleAttributes: [
        { role: 'switch', tabindex: '2', 'aria-pressed': 'false' },
        {}
      ]
    });

    assert.strictEqual(harness.singleOptions[0].getAttribute('role'), 'switch');
    assert.strictEqual(harness.singleOptions[0].getAttribute('tabindex'), '2');
    assert.strictEqual(harness.singleOptions[0].getAttribute('aria-pressed'), 'true');
    assert.strictEqual(harness.singleOptions[1].getAttribute('role'), 'button');
    assert.strictEqual(harness.singleOptions[1].getAttribute('tabindex'), '0');
    assert.strictEqual(harness.singleOptions[1].getAttribute('aria-pressed'), 'false');
  });

  test('Enter follows the existing click path exactly once and synchronizes single-select state', () => {
    const harness = buildHarness({ selectedInSingle: [0] });

    const event = harness.document.dispatchKeydown(harness.singleOptions[1], 'Enter');

    assert.strictEqual(event.defaultPrevented, false, 'Enter should not need scroll prevention');
    assert.strictEqual(harness.singleOptions[1].clickCount, 1);
    assert.strictEqual(harness.websocketMessages.length, 1, 'keyboard activation should emit one click event');
    assert.strictEqual(harness.websocketMessages[0].choice, 'activity-feed-card');
    assert.strictEqual(harness.singleOptions[0].classList.contains('selected'), false);
    assert.strictEqual(harness.singleOptions[0].getAttribute('aria-pressed'), 'false');
    assert.strictEqual(harness.singleOptions[1].classList.contains('selected'), true);
    assert.strictEqual(harness.singleOptions[1].getAttribute('aria-pressed'), 'true');
  });

  test('Space prevents scrolling and follows the existing scoped multiselect click path once', () => {
    const harness = buildHarness({ selectedInSingle: [0], selectedInMulti: [0] });

    const event = harness.document.dispatchKeydown(harness.multiOptions[1].children[1], ' ');

    assert.strictEqual(event.defaultPrevented, true, 'Space should prevent page scrolling');
    assert.strictEqual(harness.multiOptions[1].clickCount, 1);
    assert.strictEqual(harness.websocketMessages.length, 1);
    assert.strictEqual(harness.multiOptions[0].getAttribute('aria-pressed'), 'true');
    assert.strictEqual(harness.multiOptions[1].getAttribute('aria-pressed'), 'true');
    assert.strictEqual(harness.singleOptions[0].getAttribute('aria-pressed'), 'true');
  });

  test('unrelated keys and targets do not activate choices', () => {
    const harness = buildHarness();
    const outside = new FakeElement('div', { text: 'Outside' });

    const unrelatedKey = harness.document.dispatchKeydown(harness.singleOptions[0], 'Escape');
    const unrelatedTarget = harness.document.dispatchKeydown(outside, 'Enter');

    assert.strictEqual(unrelatedKey.defaultPrevented, false);
    assert.strictEqual(unrelatedTarget.defaultPrevented, false);
    assert.strictEqual(harness.singleOptions[0].clickCount, 0);
    assert.strictEqual(harness.websocketMessages.length, 0);
  });

  test('pressed state stays synchronized for a choice without a selection container', () => {
    const harness = buildHarness();

    harness.document.dispatchKeydown(harness.standaloneChoice, 'Enter');

    assert.strictEqual(harness.standaloneChoice.classList.contains('selected'), true);
    assert.strictEqual(harness.standaloneChoice.getAttribute('aria-pressed'), 'true');
    assert.strictEqual(harness.websocketMessages.length, 1);
  });

  test('helper tolerates a full document without the fragment frame indicator', () => {
    const harness = buildHarness({ includeIndicator: false, selectedInSingle: [0] });

    harness.document.dispatchKeydown(harness.singleOptions[1], 'Enter');

    assert.strictEqual(harness.singleOptions[1].getAttribute('aria-pressed'), 'true');
    assert.strictEqual(harness.websocketMessages.length, 1);
  });

  test('single-select indicator stays container-scoped and renders the selected label', () => {
    const harness = buildHarness({ selectedInMulti: [0] });

    runClickFlow(harness, harness.singleOptions[1]);

    assert.strictEqual(
      harness.indicator.innerHTML,
      '<span class="selected-text">Selected:</span> Option B · Activity feed card — return to the terminal to continue'
    );
    assert.strictEqual(
      harness.singleOptions[0].classList.contains('selected'),
      false,
      'single-select toggle should clear sibling .selected state before helper rendering'
    );
    assert.strictEqual(
      harness.websocketMessages[harness.websocketMessages.length - 1].choice,
      'activity-feed-card',
      'click capture should still emit the clicked data-choice value'
    );
  });

  test('multiselect indicator reports only that container count, not selections elsewhere on the page', () => {
    const harness = buildHarness({ selectedInSingle: [0], selectedInMulti: [0] });

    runClickFlow(harness, harness.multiOptions[1]);

    assert.strictEqual(
      harness.indicator.innerHTML,
      '<span class="selected-text">2 items selected</span> in this group — return to the terminal to continue'
    );
    assert.strictEqual(
      harness.multiOptions[0].classList.contains('selected') && harness.multiOptions[1].classList.contains('selected'),
      true,
      'multiselect toggle should preserve existing selected siblings in the same container'
    );
  });

  test('helper stays outside workflow semantics and state/events carry-forward logic', () => {
    for (const banned of WORKFLOW_BANNED_STRINGS) {
      assert(
        !helperSource.includes(banned),
        `Helper drifted into workflow semantics: ${banned}`
      );
    }
  });

  console.log(`\n--- Results: ${passed} passed, ${failed} failed ---`);
  if (failed > 0) process.exit(1);
}

run();
