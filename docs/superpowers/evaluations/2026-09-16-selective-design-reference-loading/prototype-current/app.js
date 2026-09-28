(() => {
  "use strict";

  const fixtures = {
    empty: {
      customer: "Camille Martin",
      account: "CP-8204",
      balanceMinor: 12850,
      status: "Compte disponible",
      amount: "",
      direction: "credit",
      parking: "lab-solution",
      reason: "",
      note: "",
      confirmed: false,
    },
    ready: {
      customer: "Camille Martin",
      account: "CP-8204",
      balanceMinor: 12850,
      status: "Compte disponible",
      amount: "2,50",
      direction: "credit",
      parking: "lab-solution",
      reason: "CORRECTION",
      note: "Correction d’un crédit accordé par le support.",
      confirmed: true,
    },
    long: {
      customer: "Camille Martin-Ben Abdallah de la Direction des opérations",
      account: "CP-8204",
      balanceMinor: 12850,
      status: "Compte disponible",
      amount: "2,50",
      direction: "debit",
      parking: "aeroport",
      reason: "REVERSAL_CORRECTION",
      note: "Correction d’annulation après vérification du dossier transmis par le parking.",
      confirmed: true,
    },
    "no-account": {
      customer: "Camille Martin",
      account: "Compte indisponible",
      balanceMinor: null,
      status: "Statut du compte inconnu",
      amount: "",
      direction: "credit",
      parking: "lab-solution",
      reason: "",
      note: "",
      confirmed: false,
    },
  };

  const els = Object.fromEntries(
    [
      "fixture-select", "response-select", "modal-layer", "adjustment-dialog", "adjustment-form", "customer-label",
      "account-label", "balance-label", "account-status", "server-message", "amount", "amount-help", "amount-error",
      "signed-summary", "signed-amount", "signed-description", "guardrail-copy", "parking", "reason", "note", "confirmed",
      "confirmation-row", "reload-button", "close-button", "header-close", "preview-button", "submit-button", "parent-report",
      "parent-report-title", "parent-report-detail", "reopen-button", "request-debug-value",
    ].map((id) => [id, document.getElementById(id)]),
  );

  let busy = false;
  let attempted = false;
  let amountTouched = false;
  let requestIdentity = makeIdentity();
  let snapshot = "";
  let operationTimer = null;
  const requestAttempts = new Map();

  function parseAmount(value) {
    const normalized = String(value === null || value === undefined ? "" : value).trim();
    if (!normalized) return { valid: false, reason: "required" };
    if (normalized.charAt(0) === "-") return { valid: false, reason: "positive" };
    const decimalIndex = Math.max(normalized.lastIndexOf(","), normalized.lastIndexOf("."));
    if (decimalIndex !== -1 && normalized.length - decimalIndex - 1 > 2) return { valid: false, reason: "precision" };
    if (!/^(?:\d+|\d{1,3}(?:[ \u00a0\u202f]\d{3})+)(?:[,.]\d{1,2})?$/.test(normalized)) {
      return { valid: false, reason: "invalid" };
    }
    const compact = normalized.replace(/[ \u00a0\u202f]/g, "");
    const match = /^(\d+)(?:[,.](\d{1,2}))?$/.exec(compact);
    if (!match) return { valid: false, reason: "invalid" };
    const major = stripLeadingZeroes(match[1]);
    const fraction = `${match[2] || ""}00`;
    const minorText = stripLeadingZeroes(major + fraction.slice(0, 2));
    if (isGreaterThanMaxSafeInteger(minorText)) return { valid: false, reason: "positive" };
    const minor = Number(minorText);
    if (minor <= 0) return { valid: false, reason: "positive" };
    return { valid: true, minor };
  }

  function stripLeadingZeroes(value) {
    const stripped = value.replace(/^0+/, "");
    return stripped.length > 0 ? stripped : "0";
  }

  function isGreaterThanMaxSafeInteger(value) {
    const maximum = String(Number.MAX_SAFE_INTEGER);
    const normalized = stripLeadingZeroes(value);
    if (normalized.length !== maximum.length) return normalized.length > maximum.length;
    return normalized > maximum;
  }

  function formatCredits(minor, signed = false) {
    if (typeof minor !== "number") return "—";
    const sign = signed ? (minor > 0 ? "+" : minor < 0 ? "−" : "") : (minor < 0 ? "−" : "");
    return `${sign}${(Math.abs(minor) / 100).toLocaleString("fr-FR", { minimumFractionDigits: 2, maximumFractionDigits: 2 })} cp`;
  }

  function updateRequestDebug() {
    els["request-debug-value"].textContent = `${requestIdentity} · non envoyée`;
  }

  function registerSimulatedRequest(action) {
    const attempts = (requestAttempts.get(requestIdentity) || 0) + 1;
    requestAttempts.set(requestIdentity, attempts);
    const operation = action === "preview" ? "prévisualisation" : "enregistrement";
    els["request-debug-value"].textContent = `${requestIdentity} · ${operation} · tentative ${attempts}`;
  }

  function currentDirection() {
    return document.querySelector('input[name="direction"]:checked').value;
  }

  function currentPayload() {
    const parsed = parseAmount(els.amount.value);
    return {
      amountMinor: parsed.valid ? parsed.minor * (currentDirection() === "debit" ? -1 : 1) : null,
      tenantId: els.parking.value,
      reasonCode: els.reason.value,
      operatorNote: els.note.value.trim(),
      confirmation: els.confirmed.checked ? "CONFIRMED_AUDITED_ADJUSTMENT" : "",
    };
  }

  function payloadSnapshot() {
    return JSON.stringify(currentPayload());
  }

  function makeIdentity() {
    return `crm-customer-8204-adjustment-${Date.now()}-${Math.random().toString(36).slice(2, 10)}`;
  }

  function refreshIdentityIfChanged() {
    const next = payloadSnapshot();
    if (snapshot && next !== snapshot) {
      requestIdentity = makeIdentity();
      updateRequestDebug();
    }
    snapshot = next;
  }

  function setFixture(name) {
    const data = fixtures[name];
    els["customer-label"].textContent = data.customer;
    els["account-label"].textContent = data.account;
    els["balance-label"].textContent = formatCredits(data.balanceMinor);
    els["account-status"].textContent = data.status;
    els.amount.value = data.amount;
    document.querySelector(`input[name="direction"][value="${data.direction}"]`).checked = true;
    els.parking.value = data.parking;
    els.reason.value = data.reason;
    els.note.value = data.note;
    els.confirmed.checked = data.confirmed;
    attempted = false;
    amountTouched = false;
    requestIdentity = makeIdentity();
    updateRequestDebug();
    snapshot = payloadSnapshot();
    clearMessages();
    validate(false);
    updateSignedSummary();
    if (els["modal-layer"].hidden) openDialog();
  }

  function updateSignedSummary() {
    const parsed = parseAmount(els.amount.value);
    const debit = currentDirection() === "debit";
    els["signed-summary"].hidden = !parsed.valid;
    if (!parsed.valid) return;
    const signedMinor = parsed.minor * (debit ? -1 : 1);
    els["signed-amount"].textContent = formatCredits(signedMinor, true);
    els["signed-description"].textContent = debit
      ? "Le solde sera débité après validation du serveur."
      : "Le solde sera crédité après validation du serveur.";
    els["guardrail-copy"].textContent = debit
      ? "Le débit ne peut pas dépasser le solde disponible. Aucun solde dû n’est créé."
      : "Aucun solde dû n’est créé. Le serveur confirme le nouveau solde.";
  }

  function validate(showErrors) {
    const amount = parseAmount(els.amount.value);
    const checks = {
      parking: Boolean(els.parking.value),
      reason: Boolean(els.reason.value),
      note: Boolean(els.note.value.trim()),
      confirmed: els.confirmed.checked,
    };
    const amountMessages = {
      required: "Le montant est requis.",
      invalid: "Saisissez un montant Credipark valide.",
      precision: "Saisissez au maximum deux décimales.",
      positive: "Le montant doit être positif.",
    };
    const reveal = showErrors || attempted;
    const revealAmount = reveal || amountTouched;
    els["amount-error"].hidden = amount.valid || !revealAmount;
    els["amount-error"].textContent = amount.valid ? "" : amountMessages[amount.reason];
    els.amount.closest(".field").classList.toggle("is-invalid", !amount.valid && revealAmount);
    Object.entries(checks).forEach(([name, valid]) => {
      const error = document.querySelector(`[data-error-for="${name}"]`);
      error.hidden = valid || !reveal;
      const field = name === "confirmed" ? els["confirmation-row"] : els[name].closest(".field");
      field.classList.toggle("is-invalid", !valid && reveal);
    });
    const formValid = amount.valid && Object.values(checks).every(Boolean);
    els["submit-button"].disabled = busy || !formValid;
    els["preview-button"].disabled = busy;
    return formValid;
  }

  function clearMessages() {
    els["server-message"].hidden = true;
    els["server-message"].className = "server-message";
    els["server-message"].innerHTML = "";
    els["submit-button"].querySelector(".button-label").textContent = "Enregistrer l’ajustement";
  }

  function showMessage(kind, title, body, extra = "") {
    const message = els["server-message"];
    message.className = `server-message server-message--${kind}`;
    message.innerHTML = `<div><strong>${title}</strong><span>${body}</span>${extra ? `<small>${extra}</small>` : ""}</div>`;
    message.hidden = false;
    message.scrollIntoView({ block: "nearest", behavior: "smooth" });
  }

  function setBusy(value, action) {
    busy = value;
    els["adjustment-dialog"].setAttribute("aria-busy", String(value));
    els["submit-button"].querySelector(".spinner").hidden = !(value && action === "submit");
    els["preview-button"].textContent = value && action === "preview" ? "Prévisualisation…" : "Prévisualiser";
    [els["fixture-select"], els["response-select"], els["reload-button"], els["close-button"], els["header-close"]].forEach((el) => { el.disabled = value; });
    Array.from(els["adjustment-form"].elements).forEach((el) => { el.disabled = value; });
    validate(false);
  }

  function runOperation(action) {
    attempted = true;
    if (!validate(true)) {
      const firstInvalid = els["adjustment-form"].querySelector(".is-invalid input, .is-invalid select, .is-invalid textarea");
      if (firstInvalid) firstInvalid.focus();
      return;
    }
    setBusy(true, action);
    showMessage("loading", "Réponse serveur simulée", action === "preview" ? "Vérification de l’ajustement…" : "Enregistrement de l’ajustement…");
    els["server-message"].focus();
    operationTimer = window.setTimeout(() => finishOperation(action), 700);
  }

  function restoreActionFocus(action) {
    const target = action === "preview" ? els["preview-button"] : els["submit-button"];
    window.requestAnimationFrame(() => target.focus());
  }

  function finishOperation(action) {
    setBusy(false, action);
    const response = els["response-select"].value;
    const payload = { ...currentPayload(), idempotencyKey: requestIdentity };
    registerSimulatedRequest(action);
    const fixture = fixtures[els["fixture-select"].value];
    const overdraw = response === "success" && typeof fixture.balanceMinor === "number" && payload.amountMinor < 0 && Math.abs(payload.amountMinor) > fixture.balanceMinor;
    if (overdraw) {
      showMessage(
        "error",
        "Conflit · réponse serveur simulée",
        "L’ajustement négatif ne peut pas dépasser le solde disponible.",
        "Code support : CONFLICT. Les informations saisies sont conservées.",
      );
      if (action === "submit") els["submit-button"].querySelector(".button-label").textContent = "Réessayer l’enregistrement";
      restoreActionFocus(action);
      return;
    }
    if (response === "success" && action === "preview") {
      const projected = typeof fixture.balanceMinor === "number" ? fixture.balanceMinor + payload.amountMinor : null;
      showMessage(
        "success",
        "Prévisualisation validée · réponse serveur simulée",
        `Solde disponible après enregistrement : ${formatCredits(projected)}.`,
        "Cette prévisualisation n’est pas requise pour enregistrer.",
      );
      restoreActionFocus(action);
      return;
    }
    if (response === "success" && action === "submit") {
      closeDialog(
        "Ajustement simulé enregistré",
        "Le dialogue a renvoyé completed=true. Le parent peut maintenant recharger les données autoritatives.",
      );
      return;
    }
    const failure = {
      conflict: ["Conflit · réponse serveur simulée", "L’ajustement négatif ne peut pas dépasser le solde disponible.", "Code support : CONFLICT"],
      forbidden: ["Ajustement non autorisé · réponse serveur simulée", "Ajustement non autorisé pour ce profil.", "Code support : FORBIDDEN"],
      service: ["Résultat non confirmé · réponse serveur simulée", "Le service n’a pas confirmé le résultat de l’enregistrement.", "Code support : SERVICE_FAILURE. Vous pouvez réessayer sans modifier les données"],
    }[response];
    showMessage("error", failure[0], failure[1], `${failure[2]}. Les informations saisies sont conservées.`);
    if (action === "submit") {
      els["submit-button"].querySelector(".button-label").textContent = "Réessayer l’enregistrement";
    }
    validate(false);
    restoreActionFocus(action);
  }

  function closeDialog(title, detail) {
    if (busy) return;
    window.clearTimeout(operationTimer);
    els["modal-layer"].hidden = true;
    els["parent-report-title"].textContent = title || "Ajustement fermé";
    els["parent-report-detail"].textContent = detail || "Le dialogue a renvoyé cancel. La fermeture n’a déclenché aucun nouvel envoi.";
    els["parent-report"].hidden = false;
    els["reopen-button"].focus();
  }

  function openDialog() {
    els["parent-report"].hidden = true;
    els["modal-layer"].hidden = false;
    window.requestAnimationFrame(() => els.amount.focus());
  }

  function reloadAndClose() {
    closeDialog("Rechargement demandé", "Le dialogue a renvoyé reload=true et s’est fermé. Le parent doit recharger le solde depuis le serveur.");
  }

  function trapFocus(event) {
    if (event.key !== "Tab" || els["modal-layer"].hidden) return;
    const focusable = Array.from(els["adjustment-dialog"].querySelectorAll('button:not(:disabled), input:not(:disabled), select:not(:disabled), textarea:not(:disabled)'));
    if (!focusable.length) return;
    const first = focusable[0];
    const last = focusable[focusable.length - 1];
    if (event.shiftKey && document.activeElement === first) { event.preventDefault(); last.focus(); }
    if (!event.shiftKey && document.activeElement === last) { event.preventDefault(); first.focus(); }
  }

  els["fixture-select"].addEventListener("change", (event) => setFixture(event.target.value));
  els["response-select"].addEventListener("change", clearMessages);
  els["adjustment-form"].addEventListener("input", () => {
    refreshIdentityIfChanged();
    clearMessages();
    updateSignedSummary();
    validate(false);
  });
  els["adjustment-form"].addEventListener("change", () => {
    refreshIdentityIfChanged();
    clearMessages();
    updateSignedSummary();
    validate(false);
  });
  els.amount.addEventListener("blur", () => { amountTouched = true; validate(false); });
  els["preview-button"].addEventListener("click", () => runOperation("preview"));
  els["submit-button"].addEventListener("click", () => runOperation("submit"));
  els["reload-button"].addEventListener("click", reloadAndClose);
  els["close-button"].addEventListener("click", () => closeDialog());
  els["header-close"].addEventListener("click", () => closeDialog());
  els["reopen-button"].addEventListener("click", openDialog);
  document.addEventListener("keydown", (event) => {
    if (event.key === "Escape" && !els["modal-layer"].hidden && !busy) { event.preventDefault(); closeDialog(); return; }
    trapFocus(event);
  });

  setFixture("ready");
  window.requestAnimationFrame(() => els.amount.focus());
})();
