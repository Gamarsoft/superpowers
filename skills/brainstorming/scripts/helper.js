(function() {
  const MIN_RECONNECT_MS = 500;
  const MAX_RECONNECT_MS = 30000;
  const TOMBSTONE_AFTER_MS = 15000; // show the "paused" overlay after this long disconnected
  const DEFAULT_INDICATOR_TEXT = 'Choose an option in this artifact, then return to the conversation.';
  const RECOVERY_INDICATOR_TEXT = 'Connection lost. Reconnect before choosing an option.';

  // Pure: next backoff delay (doubles, capped). Exported for unit tests.
  function nextReconnectDelay(current, max) {
    return Math.min(current * 2, max);
  }
  if (typeof module !== 'undefined' && module.exports) {
    module.exports = { nextReconnectDelay, MIN_RECONNECT_MS, MAX_RECONNECT_MS, TOMBSTONE_AFTER_MS };
  }

  // Everything below is browser-only; bail out when loaded in Node (tests).
  if (typeof window === 'undefined') return;

  let ws = null;
  let eventQueue = [];
  let reconnectDelay = MIN_RECONNECT_MS;
  let reconnectTimer = null;
  let disconnectedSince = null;
  let everConnected = false;
  let tombstoneShown = false;
  let connectionState = 'connecting';
  let choicesAvailable = false;

  function sessionKey() {
    try {
      return window.sessionStorage && window.sessionStorage.getItem('brainstorm-session-key');
    } catch (e) {}
    return null;
  }

  function websocketUrl() {
    const key = sessionKey();
    return 'ws://' + window.location.host + (key ? '/?key=' + encodeURIComponent(key) : '');
  }

  function reloadAfterRecovery() {
    const key = sessionKey();
    if (key) {
      window.location.replace('/?key=' + encodeURIComponent(key));
    } else {
      window.location.reload();
    }
  }

  function choiceElements() {
    return typeof document.querySelectorAll === 'function'
      ? Array.from(document.querySelectorAll('[data-choice]'))
      : [];
  }

  function setChoicesAvailable(available) {
    choicesAvailable = available;
    choiceElements().forEach((choice) => {
      if (typeof choice.setAttribute === 'function') {
        choice.setAttribute('aria-disabled', available ? 'false' : 'true');
      }
    });
  }

  // Reflect connection state in the frame's status pill (absent on full-doc screens).
  function setStatus(state) {
    const map = {
      connecting:   ['Connecting…',   'var(--text-tertiary)'],
      connected:    ['Connected',     'var(--success)'],
      reconnecting: ['Reconnecting…', 'var(--warning)'],
      disconnected: ['Disconnected',  'var(--error)']
    };
    connectionState = map[state] ? state : 'disconnected';
    const [text, color] = map[connectionState];
    const el = typeof document.querySelector === 'function'
      ? document.querySelector('.status')
      : null;
    if (el) {
      el.textContent = text;
      el.style.setProperty('--status-color', color);
    }
    setChoicesAvailable(connectionState === 'connected');
    syncIndicatorFromDocument();
  }

  // Self-styled so it works on framed and full-document screens alike.
  function showTombstone() {
    if (tombstoneShown) return;
    tombstoneShown = true;
    const el = document.createElement('div');
    el.id = 'bs-tombstone';
    el.style.cssText = 'position:fixed;inset:0;z-index:99999;display:flex;' +
      'align-items:center;justify-content:center;padding:2rem;text-align:center;' +
      'background:rgba(20,20,22,0.92);color:#f5f5f7;font-family:system-ui,sans-serif';
    el.innerHTML = '<div style="max-width:480px">' +
      '<h2 style="margin:0 0 .5rem;font-weight:600">Companion paused</h2>' +
      '<p style="margin:0;opacity:.85">This brainstorm companion has stopped. ' +
      'Ask your coding agent to bring it back — this page reconnects automatically.</p></div>';
    if (document.body) document.body.appendChild(el);
  }

  function connect() {
    if (reconnectTimer) { clearTimeout(reconnectTimer); reconnectTimer = null; }
    setStatus(everConnected ? 'reconnecting' : 'connecting');
    ws = new WebSocket(websocketUrl());

    ws.onopen = () => {
      const recovered = tombstoneShown;
      everConnected = true;
      disconnectedSince = null;
      reconnectDelay = MIN_RECONNECT_MS;
      tombstoneShown = false;
      setStatus('connected');
      eventQueue.forEach(e => ws.send(JSON.stringify(e)));
      eventQueue = [];
      // Recovered from a tombstoned outage (e.g. the server restarted on the same
      // port) — reload through the keyed bootstrap when possible so the cookie is
      // refreshed before the visible URL returns to bare /.
      if (recovered) reloadAfterRecovery();
    };

    ws.onmessage = (msg) => {
      let data;
      try { data = JSON.parse(msg.data); } catch (e) { return; }
      if (data.type === 'reload') window.location.reload();
    };

    ws.onclose = () => {
      ws = null;
      if (disconnectedSince === null) disconnectedSince = Date.now();
      if (Date.now() - disconnectedSince >= TOMBSTONE_AFTER_MS) {
        setStatus('disconnected');
        showTombstone();
      } else {
        setStatus('reconnecting');
      }
      reconnectTimer = setTimeout(connect, reconnectDelay);
      reconnectDelay = nextReconnectDelay(reconnectDelay, MAX_RECONNECT_MS);
    };

    // Let onclose own reconnection so we don't schedule it twice.
    ws.onerror = () => { try { ws.close(); } catch (e) {} };
  }

  function sendEvent(event) {
    event.timestamp = Date.now();
    if (ws && ws.readyState === WebSocket.OPEN) {
      ws.send(JSON.stringify(event));
    } else {
      eventQueue.push(event);
    }
  }

  function escapeHtml(value) {
    return String(value)
      .replace(/&/g, '&amp;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;')
      .replace(/"/g, '&quot;')
      .replace(/'/g, '&#39;');
  }

  function getChoiceContainer(target) {
    return target ? (target.closest('.options') || target.closest('.cards')) : null;
  }

  function getSelectedLabel(selectedEl) {
    return selectedEl.querySelector('h3, .content h3, .card-body h3')?.textContent?.trim()
      || selectedEl.dataset.choice
      || 'Current selection';
  }

  function syncChoiceState(choice) {
    choice.setAttribute('aria-pressed', choice.classList.contains('selected') ? 'true' : 'false');
  }

  function syncChoiceStates(container) {
    if (!container || typeof container.querySelectorAll !== 'function') return;
    Array.from(container.querySelectorAll('[data-choice]')).forEach(syncChoiceState);
  }

  function hydrateChoices() {
    if (typeof document.querySelectorAll !== 'function') return;
    choiceElements().forEach((choice) => {
      if (!choice.hasAttribute('role')) choice.setAttribute('role', 'button');
      if (!choice.hasAttribute('tabindex')) choice.setAttribute('tabindex', '0');
      syncChoiceState(choice);
      choice.setAttribute('aria-disabled', choicesAvailable ? 'false' : 'true');
    });
  }

  function setFooterVisible(footer, visible) {
    if (!footer) return;
    footer.hidden = !visible;
    if (typeof footer.setAttribute === 'function') {
      footer.setAttribute('aria-hidden', visible ? 'false' : 'true');
    }
  }

  function syncIndicator(container, selectedChoices) {
    const indicator = typeof document.getElementById === 'function'
      ? document.getElementById('indicator-text')
      : null;
    if (!indicator) return;
    const footer = typeof indicator.closest === 'function'
      ? indicator.closest('.indicator-bar')
      : null;
    if (choiceElements().length === 0) {
      setFooterVisible(footer, false);
      return;
    }
    setFooterVisible(footer, true);

    if (connectionState === 'disconnected' || connectionState === 'reconnecting') {
      indicator.textContent = RECOVERY_INDICATOR_TEXT;
      return;
    }

    const selected = selectedChoices || (container ? Array.from(container.querySelectorAll('.selected')) : []);
    const multi = container && container.dataset.multiselect !== undefined;

    if (selected.length === 0) {
      indicator.textContent = DEFAULT_INDICATOR_TEXT;
      return;
    }

    if (multi || selected.length > 1) {
      indicator.innerHTML = '<span class="selected-text">' + selected.length + ' options selected.</span> Return to the conversation to continue.';
      return;
    }

    indicator.innerHTML = '<span class="selected-text">Selected:</span> ' + escapeHtml(getSelectedLabel(selected[0])) + '. Return to the conversation to continue.';
  }

  function syncIndicatorFromDocument() {
    if (typeof document.querySelectorAll !== 'function') return;
    const selected = Array.from(document.querySelectorAll('.selected'));
    const containers = [];

    selected.forEach((selectedEl) => {
      const container = getChoiceContainer(selectedEl);
      if (container && !containers.includes(container)) containers.push(container);
    });

    syncIndicator(
      containers.length === 1 ? containers[0] : null,
      containers.length > 1 ? selected : undefined
    );
  }

  // Capture clicks on choice elements
  document.addEventListener('click', (e) => {
    const target = e.target && typeof e.target.closest === 'function'
      ? e.target.closest('[data-choice]')
      : null;
    if (!target || !choicesAvailable) return;

    sendEvent({
      type: 'click',
      text: target.textContent.trim(),
      choice: target.dataset.choice,
      id: target.id || null
    });

    setTimeout(() => {
      const container = getChoiceContainer(target);
      syncChoiceStates(container);
      syncChoiceState(target);
      syncIndicator(container);
    }, 0);

  });

  // Progressively activate authored choices without requiring extra metadata.
  document.addEventListener('keydown', (e) => {
    const target = e.target && typeof e.target.closest === 'function'
      ? e.target.closest('[data-choice]')
      : null;
    if (!target || !choicesAvailable || (e.key !== 'Enter' && e.key !== ' ')) return;
    if (e.repeat) return;
    if (String(target.tagName).toLowerCase() === 'button') return;
    if (e.key === ' ') e.preventDefault();
    target.click();
  });

  // Frame UI: selection tracking
  window.selectedChoice = null;

  window.toggleSelect = function(el) {
    if (!choicesAvailable) return;
    const container = getChoiceContainer(el);
    const multi = container && container.dataset.multiselect !== undefined;
    if (container && !multi) {
      container.querySelectorAll('.option, .card').forEach(o => o.classList.remove('selected'));
    }
    if (multi) {
      el.classList.toggle('selected');
    } else {
      el.classList.add('selected');
    }
    window.selectedChoice = el.dataset.choice;
    syncChoiceStates(container);
    syncChoiceState(el);
  };

  // Expose API for explicit use
  window.brainstorm = {
    send: sendEvent,
    choice: (value, metadata = {}) => sendEvent({ type: 'choice', choice: value, value, ...metadata })
  };

  hydrateChoices();
  syncIndicatorFromDocument();
  connect();
})();
