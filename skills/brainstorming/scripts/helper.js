(function() {
  const WS_URL = 'ws://' + window.location.host;
  const DEFAULT_INDICATOR_TEXT = 'Click an option above to confirm the current selection, then return to the terminal';
  let ws = null;
  let eventQueue = [];

  function connect() {
    ws = new WebSocket(WS_URL);

    ws.onopen = () => {
      eventQueue.forEach(e => ws.send(JSON.stringify(e)));
      eventQueue = [];
    };

    ws.onmessage = (msg) => {
      const data = JSON.parse(msg.data);
      if (data.type === 'reload') {
        window.location.reload();
      }
    };

    ws.onclose = () => {
      setTimeout(connect, 1000);
    };
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

  function syncIndicator(container) {
    const indicator = document.getElementById('indicator-text');
    if (!indicator) return;

    const selected = container ? Array.from(container.querySelectorAll('.selected')) : [];
    const multi = container && container.dataset.multiselect !== undefined;

    if (selected.length === 0) {
      indicator.textContent = DEFAULT_INDICATOR_TEXT;
      return;
    }

    if (multi || selected.length > 1) {
      const noun = selected.length === 1 ? 'item' : 'items';
      indicator.innerHTML = '<span class="selected-text">' + selected.length + ' ' + noun + ' selected</span> in this group — return to the terminal to continue';
      return;
    }

    indicator.innerHTML = '<span class="selected-text">Selected:</span> ' + escapeHtml(getSelectedLabel(selected[0])) + ' — return to the terminal to continue';
  }

  function syncIndicatorFromDocument() {
    const selected = Array.from(document.querySelectorAll('.selected'));
    const containers = [];

    selected.forEach((selectedEl) => {
      const container = getChoiceContainer(selectedEl);
      if (container && !containers.includes(container)) containers.push(container);
    });

    syncIndicator(containers.length === 1 ? containers[0] : null);
  }

  document.addEventListener('click', (e) => {
    const target = e.target.closest('[data-choice]');
    if (!target) return;

    sendEvent({
      type: 'click',
      text: target.textContent.trim(),
      choice: target.dataset.choice,
      id: target.id || null
    });

    setTimeout(() => {
      syncIndicator(getChoiceContainer(target));
    }, 0);
  });

  window.selectedChoice = null;

  window.toggleSelect = function(el) {
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
  };

  window.brainstorm = {
    send: sendEvent,
    choice: (value, metadata = {}) => sendEvent({ type: 'choice', choice: value, value, ...metadata })
  };

  syncIndicatorFromDocument();
  connect();
})();
