(function () {
  'use strict';

  var form = document.getElementById('adjustment-form');
  var modalLayer = document.getElementById('modal-layer');
  var dialog = document.getElementById('adjustment-dialog');
  var fixtureSelect = document.getElementById('fixture-select');
  var responseSelect = document.getElementById('response-select');
  var amountInput = document.getElementById('amount');
  var tenantSelect = document.getElementById('tenant');
  var reasonSelect = document.getElementById('reason');
  var noteInput = document.getElementById('note');
  var confirmedInput = document.getElementById('confirmed');
  var submitButton = document.getElementById('submit-button');
  var previewButton = document.getElementById('preview-button');
  var closeButton = document.getElementById('close-button');
  var cancelButton = document.getElementById('cancel-button');
  var reloadButton = document.getElementById('reload-button');
  var reopenButton = document.getElementById('reopen-button');
  var feedback = document.getElementById('feedback');
  var parentStatus = document.getElementById('parent-status');
  var busy = false;
  var attempted = false;
  var previewSignature = '';
  var idempotencyKey = makeKey();
  var dataSignature = '';
  var currentFixture = null;
  var attemptsByKey = {};
  var amountTouched = false;

  var fixtures = {
    empty: {
      customer: 'Camille Martin', account: 'CP-8204', balanceMinor: 12850, status: 'Actif', amount: '', direction: 'credit', tenant: 'lab', reason: '', note: '', confirmed: false
    },
    ready: {
      customer: 'Camille Martin', account: 'CP-8204', balanceMinor: 12850, status: 'Actif', amount: '2,50', direction: 'credit', tenant: 'lab', reason: 'CORRECTION', note: 'Correction d’un crédit attribué en double.', confirmed: true
    },
    long: {
      customer: 'Camille Martin — Société des mobilités métropolitaines et partenaires', account: 'CP-8204', balanceMinor: 12850, status: 'Actif', amount: '18,75', direction: 'debit', tenant: 'long', reason: 'SERVICE_RECOVERY', note: 'Rattrapage consécutif à l’interruption du service de réservation constatée par le support opérateur.', confirmed: true
    },
    'no-account': {
      customer: 'Camille Martin', account: '', balanceMinor: null, status: 'Non vérifié', amount: '', direction: 'credit', tenant: 'lab', reason: '', note: '', confirmed: false
    }
  };

  function makeKey() {
    return 'crm-customer-44-adjustment-' + Date.now() + '-' + Math.random().toString(36).slice(2, 10);
  }

  function parseCredits(value) {
    var normalized = String(value == null ? '' : value).trim();
    if (!normalized) return { valid: false, reason: 'required' };
    if (normalized.charAt(0) === '-') return { valid: false, reason: 'negative' };
    var separatorIndex = Math.max(normalized.lastIndexOf(','), normalized.lastIndexOf('.'));
    if (separatorIndex !== -1 && normalized.length - separatorIndex - 1 > 2) return { valid: false, reason: 'too-precise' };
    if (!/^(?:\d+|\d{1,3}(?:[ \u00a0\u202f]\d{3})+)(?:[,.]\d{1,2})?$/.test(normalized)) return { valid: false, reason: 'malformed' };
    var compact = normalized.replace(/[ \u00a0\u202f]/g, '');
    var match = /^(\d+)(?:[,.](\d{1,2}))?$/.exec(compact);
    if (!match) return { valid: false, reason: 'malformed' };
    var major = (match[1].replace(/^0+/, '') || '0');
    var fraction = ((match[2] || '') + '00').slice(0, 2);
    var minorText = ((major + fraction).replace(/^0+/, '') || '0');
    var max = String(Number.MAX_SAFE_INTEGER);
    if (minorText.length > max.length || (minorText.length === max.length && minorText > max)) return { valid: false, reason: 'too-large' };
    return { valid: true, minor: Number(minorText) };
  }

  function formatCredits(minor, signed) {
    if (typeof minor !== 'number') return '—';
    var sign = signed ? (minor > 0 ? '+' : minor < 0 ? '−' : '') : (minor < 0 ? '−' : '');
    var absolute = Math.abs(minor);
    var major = String(Math.floor(absolute / 100)).replace(/\B(?=(\d{3})+(?!\d))/g, '\u202f');
    var fraction = String(absolute % 100).padStart(2, '0');
    return sign + major + ',' + fraction + ' cp';
  }

  function selectedDirection() {
    return form.elements.direction.value;
  }

  function signedMinor() {
    var parsed = parseCredits(amountInput.value);
    if (!parsed.valid || parsed.minor <= 0) return null;
    return selectedDirection() === 'debit' ? -parsed.minor : parsed.minor;
  }

  function formSignature() {
    var parsed = parseCredits(amountInput.value);
    var canonicalAmount = parsed.valid ? String(parsed.minor) : 'invalid:' + amountInput.value.trim();
    return [selectedDirection(), canonicalAmount, tenantSelect.value, reasonSelect.value, noteInput.value, confirmedInput.checked].join('|');
  }

  function setText(id, value) {
    document.getElementById(id).textContent = value;
  }

  function applyFixture(name) {
    currentFixture = fixtures[name];
    if (!Array.from(tenantSelect.options).some(function (option) { return option.value === 'long'; })) {
      var longOption = document.createElement('option');
      longOption.value = 'long';
      longOption.textContent = 'Lab Solution Parking — Pôle multimodal de l’aéroport international et gare routière';
      tenantSelect.appendChild(longOption);
    }
    setText('customer-name', currentFixture.customer);
    setText('review-customer', currentFixture.customer);
    setText('account-number', currentFixture.account ? 'Compte ' + currentFixture.account : 'Compte indisponible');
    setText('current-balance', formatCredits(currentFixture.balanceMinor, false));
    setText('account-status', currentFixture.status);
    var status = document.getElementById('account-status');
    status.className = currentFixture.account ? 'status-pill status-pill--active' : 'status-pill status-pill--unknown';
    amountInput.value = currentFixture.amount;
    form.elements.direction.value = currentFixture.direction;
    tenantSelect.value = currentFixture.tenant;
    reasonSelect.value = currentFixture.reason;
    noteInput.value = currentFixture.note;
    confirmedInput.checked = currentFixture.confirmed;
    attempted = false;
    amountTouched = false;
    clearErrors();
    hideFeedback();
    previewSignature = '';
    dataSignature = formSignature();
    idempotencyKey = makeKey();
    updateInterface();
    if (modalLayer.hidden) openDialog();
  }

  function reasonLabel() {
    var option = reasonSelect.options[reasonSelect.selectedIndex];
    return reasonSelect.value && option ? option.textContent : 'À renseigner';
  }

  function updateInterface() {
    var signed = signedMinor();
    setText('signed-amount', signed == null ? '—' : formatCredits(signed, true));
    setText('review-amount', signed == null ? '—' : formatCredits(signed, true));
    setText('review-tenant', tenantSelect.options[tenantSelect.selectedIndex] ? tenantSelect.options[tenantSelect.selectedIndex].textContent : 'À renseigner');
    setText('review-reason', reasonLabel());
    var length = noteInput.value.length;
    setText('note-count', length + (length > 1 ? ' caractères' : ' caractère'));
    if (previewSignature !== formSignature()) {
      previewSignature = '';
      setText('projected-balance', 'Non prévisualisé');
      if (!busy) hideFeedback();
    }
    var signature = formSignature();
    if (dataSignature && signature !== dataSignature) idempotencyKey = makeKey();
    dataSignature = signature;
    setText('attempt-identity', idempotencyKey);
    setText('attempt-count', String(attemptsByKey[idempotencyKey] || 0));
    var valid = validate(false);
    submitButton.disabled = busy || !valid;
    submitButton.setAttribute('aria-disabled', String(submitButton.disabled));
    previewButton.disabled = busy;
    Array.from(form.querySelectorAll('input, select, textarea')).forEach(function (control) { control.disabled = busy; });
    closeButton.disabled = busy;
    cancelButton.disabled = busy;
    reloadButton.disabled = busy;
    fixtureSelect.disabled = busy;
    responseSelect.disabled = busy;
  }

  function amountErrorMessage(reason) {
    if (reason === 'required') return 'Le montant est requis.';
    if (reason === 'too-precise') return 'Saisissez au maximum deux décimales.';
    if (reason === 'negative' || reason === 'too-large') return 'Le montant doit être positif et rester dans la limite acceptée.';
    return 'Saisissez un montant Credipark valide.';
  }

  function showFieldError(fieldId, errorId, message, visible) {
    var field = document.getElementById(fieldId);
    var error = document.getElementById(errorId);
    if (field) field.classList.toggle('field--invalid', visible);
    error.hidden = !visible;
    if (message) error.textContent = message;
  }

  function validate(show) {
    var parsed = parseCredits(amountInput.value);
    var amountValid = parsed.valid && parsed.minor > 0;
    var tenantValid = !!tenantSelect.value;
    var reasonValid = !!reasonSelect.value;
    var noteValid = noteInput.value.trim().length > 0;
    var confirmationValid = confirmedInput.checked;
    if (show || amountTouched) {
      showFieldError('amount-field', 'amount-error', amountValid ? '' : amountErrorMessage(parsed.valid && parsed.minor <= 0 ? 'negative' : parsed.reason), !amountValid);
    }
    if (show) {
      document.getElementById('tenant-error').hidden = tenantValid;
      document.getElementById('reason-error').hidden = reasonValid;
      document.getElementById('note-error').hidden = noteValid;
      document.getElementById('confirmation-error').hidden = confirmationValid;
      tenantSelect.classList.toggle('invalid', !tenantValid);
      reasonSelect.classList.toggle('invalid', !reasonValid);
      noteInput.classList.toggle('invalid', !noteValid);
    }
    return amountValid && tenantValid && reasonValid && noteValid && confirmationValid;
  }

  function clearErrors() {
    showFieldError('amount-field', 'amount-error', '', false);
    ['tenant-error', 'reason-error', 'note-error', 'confirmation-error'].forEach(function (id) { document.getElementById(id).hidden = true; });
    [tenantSelect, reasonSelect, noteInput].forEach(function (control) { control.classList.remove('invalid'); });
  }

  function showFeedback(kind, title, detail, code) {
    feedback.className = 'feedback' + (kind === 'error' ? ' feedback--error' : kind === 'warning' ? ' feedback--warning' : kind === 'loading' ? ' feedback--loading' : '');
    feedback.innerHTML = '<span class="feedback__icon" aria-hidden="true">' + (kind === 'success' ? '✓' : kind === 'loading' ? '…' : '!') + '</span>' +
      '<div class="feedback__content"><span class="feedback__label">Réponse serveur simulée</span><strong>' + title + '</strong><p>' + detail + (code ? ' <span class="support-code">Code&nbsp;: ' + code + '</span>' : '') + '</p></div>';
    feedback.hidden = false;
    feedback.tabIndex = -1;
    feedback.setAttribute('role', kind === 'success' || kind === 'loading' ? 'status' : 'alert');
  }

  function hideFeedback() {
    feedback.hidden = true;
    feedback.innerHTML = '';
  }

  function setBusy(value, operation) {
    busy = value;
    submitButton.classList.toggle('is-loading', value && operation === 'submit');
    previewButton.textContent = value && operation === 'preview' ? 'Prévisualisation…' : 'Prévisualiser';
    submitButton.querySelector('.button-label').textContent = value && operation === 'submit' ? 'Enregistrement…' : 'Enregistrer l’ajustement';
    updateInterface();
  }

  function runServer(operation) {
    attempted = true;
    if (!validate(true)) {
      var firstInvalid = form.querySelector('.field--invalid input, select.invalid, textarea.invalid');
      if (!firstInvalid && !confirmedInput.checked) firstInvalid = confirmedInput;
      if (firstInvalid) firstInvalid.focus();
      updateInterface();
      return;
    }
    var requestSignature = formSignature();
    var requestKey = idempotencyKey;
    var trigger = operation === 'preview' ? previewButton : submitButton;
    attemptsByKey[requestKey] = (attemptsByKey[requestKey] || 0) + 1;
    setBusy(true, operation);
    setText('attempt-count', String(attemptsByKey[requestKey]));
    showFeedback('loading', operation === 'preview' ? 'Prévisualisation en cours' : 'Enregistrement en cours', 'La demande synthétique est en attente de la réponse simulée.', '');
    feedback.focus();
    window.setTimeout(function () {
      setBusy(false, operation);
      var response = responseSelect.value;
      var delta = signedMinor();
      var overdraw = typeof currentFixture.balanceMinor === 'number' && typeof delta === 'number' && delta < 0 && Math.abs(delta) > currentFixture.balanceMinor;
      if (overdraw) response = 'conflict';
      if (response === 'success') {
        if (operation === 'preview') {
          previewSignature = requestSignature;
          var projected = typeof currentFixture.balanceMinor === 'number' && typeof delta === 'number' ? currentFixture.balanceMinor + delta : null;
          setText('projected-balance', formatCredits(projected, false));
          showFeedback('success', 'Prévisualisation validée', projected == null ? 'Le serveur n’a pas renvoyé de solde projeté.' : 'Solde disponible après enregistrement : ' + formatCredits(projected, false) + '.', 'AUD-PREVIEW-OK');
          trigger.focus();
        } else {
          closeDialog('Enregistrement simulé terminé', 'Le serveur simulé a accepté l’écriture auditée sous la référence ' + requestKey + '. Le solde affiché dans la page parente doit maintenant être rechargé.');
        }
      } else if (response === 'conflict') {
        showFeedback('error', 'Ajustement refusé', 'Le débit dépasse le solde disponible. Aucun mouvement n’a été écrit.', 'CONFLICT');
        trigger.focus();
      } else if (response === 'forbidden') {
        showFeedback('error', 'Ajustement non autorisé pour ce profil', 'Le serveur a refusé la demande. Aucun mouvement n’a été écrit.', 'FORBIDDEN');
        trigger.focus();
      } else {
        idempotencyKey = requestKey;
        dataSignature = requestSignature;
        showFeedback('warning', 'Impossible de confirmer l’enregistrement', 'La réponse du service n’a pas été reçue. L’issue peut être incertaine. Conservez les données et réessayez sans les modifier ; la même référence de tentative sera utilisée.', 'TRANSPORT_FAILURE');
        trigger.focus();
      }
    }, 650);
  }

  function closeDialog(title, detail) {
    if (busy) return;
    modalLayer.hidden = true;
    parentStatus.hidden = false;
    setText('parent-status-title', title || 'Ajustement fermé');
    setText('parent-status-detail', detail || 'Aucune modification n’a été envoyée.');
    reopenButton.focus();
  }

  function openDialog() {
    parentStatus.hidden = true;
    modalLayer.hidden = false;
    window.setTimeout(function () { amountInput.focus(); }, 0);
  }

  form.addEventListener('input', function () {
    if (attempted) validate(true);
    updateInterface();
  });
  form.addEventListener('change', function () {
    if (attempted) validate(true);
    updateInterface();
  });
  form.addEventListener('submit', function (event) { event.preventDefault(); runServer('submit'); });
  previewButton.addEventListener('click', function () { runServer('preview'); });
  closeButton.addEventListener('click', function () { closeDialog('Ajustement fermé', 'Les données du prototype restent disponibles tant que l’état du formulaire n’est pas changé.'); });
  cancelButton.addEventListener('click', function () { closeDialog('Ajustement fermé', 'La fermeture n’a déclenché aucun nouvel envoi. Elle ne confirme pas le résultat d’une tentative précédente.'); });
  reloadButton.addEventListener('click', function () { closeDialog('Rechargement demandé à la page parente', 'Le dialogue est fermé. La page parente doit recharger le solde auprès du serveur ; aucun calcul local n’a été appliqué.'); });
  reopenButton.addEventListener('click', openDialog);
  fixtureSelect.addEventListener('change', function () { applyFixture(fixtureSelect.value); });
  responseSelect.addEventListener('change', function () {
    previewSignature = '';
    setText('projected-balance', 'Non prévisualisé');
    hideFeedback();
  });
  amountInput.addEventListener('blur', function () {
    var parsed = parseCredits(amountInput.value);
    if (parsed.valid) amountInput.value = formatCredits(parsed.minor, false).replace(' cp', '');
    amountTouched = true;
    validate(false);
    updateInterface();
  });

  document.addEventListener('keydown', function (event) {
    if (event.key === 'Escape' && !modalLayer.hidden && !busy) {
      event.preventDefault();
      closeDialog('Ajustement fermé', 'La fermeture n’a déclenché aucun nouvel envoi. Elle ne confirme pas le résultat d’une tentative précédente.');
    }
    if (event.key === 'Tab' && !modalLayer.hidden) {
      var focusable = Array.from(dialog.querySelectorAll('button:not(:disabled), input:not(:disabled), select:not(:disabled), textarea:not(:disabled)')).filter(function (element) { return element.offsetParent !== null; });
      if (!focusable.length) return;
      var first = focusable[0];
      var last = focusable[focusable.length - 1];
      if (event.shiftKey && document.activeElement === first) { event.preventDefault(); last.focus(); }
      else if (!event.shiftKey && document.activeElement === last) { event.preventDefault(); first.focus(); }
    }
  });

  window.adjustmentPrototype = {
    parseCredits: parseCredits,
    getIdempotencyKey: function () { return idempotencyKey; },
    getState: function () { return { fixture: fixtureSelect.value, response: responseSelect.value, busy: busy, valid: validate(false), previewed: previewSignature === formSignature(), key: idempotencyKey }; }
  };

  applyFixture('ready');
})();
