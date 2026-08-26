/* PRJ-004 Dashboard 3.0 auth adapter contract. No secrets belong in this file. */
(function () {
  'use strict';

  const SESSION_ENDPOINT = '/__c3l/session';
  const ALLOWED_ROLES = new Set(['dashboard_viewer', 'dashboard_operator', 'dashboard_admin']);

  function isHex64(value) {
    return typeof value === 'string' && /^[A-Fa-f0-9]{64}$/.test(value);
  }

  function parseDate(value) {
    const t = Date.parse(value);
    return Number.isFinite(t) ? t : NaN;
  }

  function validateSession(session) {
    if (!session || session.authenticated !== true) return false;
    if (typeof session.session_id !== 'string' || session.session_id.length < 16) return false;
    if (typeof session.subject_id !== 'string' || session.subject_id.length === 0) return false;
    if (!Array.isArray(session.roles) || !session.roles.some(r => ALLOWED_ROLES.has(r))) return false;
    if (!isHex64(session.auth_context_hash)) return false;
    const issuedAt = parseDate(session.issued_at);
    const expiresAt = parseDate(session.expires_at);
    const now = Date.now();
    if (!Number.isFinite(issuedAt) || !Number.isFinite(expiresAt)) return false;
    if (issuedAt > now + 60000 || expiresAt <= now) return false;
    return true;
  }

  async function getSession() {
    const response = await fetch(SESSION_ENDPOINT, {
      method: 'GET',
      credentials: 'same-origin',
      cache: 'no-store',
      headers: { 'Accept': 'application/json' }
    });
    if (!response.ok) throw new Error('AUTHORITY_UNAVAILABLE');
    const session = await response.json();
    if (!validateSession(session)) throw new Error('AUTH_SESSION_INVALID');
    return session;
  }

  window.C3LAuthAdapter = Object.freeze({ getSession, validateSession });
})();
