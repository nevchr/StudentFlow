# Threat assumptions and remaining risks

## Assets to protect

Financial transactions and balances, income and employer information, provider
tokens, authentication sessions, account-link metadata, exports, notification
content, and derived forecasts.

## Trust boundaries

- The Flutter client and its local database are on a user-controlled device.
- StudentFlow backend functions authenticate users and enforce row ownership.
- Bank aggregators and financial institutions are independent processors with
  their own consent and retention behaviour.
- Imported statements are untrusted files and may be malformed or malicious.

## Baseline controls

- TLS only, short-lived user sessions, strict backend authorization, least
  privilege, rate limits, and explicit row-level access policies.
- Bank-provider secrets and permanent provider tokens only in backend secret or
  encrypted server storage; never in Flutter assets, builds, logs, crash reports,
  analytics, or notifications.
- Redaction by default for balances, transaction text, account masks, tokens,
  authorization headers, and webhook payloads.
- Idempotent sync/import, bounded parsers, file-size limits, and transactionally
  applied batches.
- Disconnect and account deletion revoke provider access first, then delete
  server and local data with visible retry/recovery status.
- No advertising use, sale of financial data, transfers, or bill payment.

## Implemented local controls

- sqlite3mc encrypts the Drift database on native targets. Startup checks the
  cipher and fails closed if the encrypted engine is absent.
- A random 256-bit key is stored with platform secure storage rather than in app
  source, preferences, logs, or the database itself.
- Android backup and device-transfer extraction are disabled for StudentFlow.
- CSV files are decoded as strict UTF-8, bounded by file/row/cell limits,
  previewed before commit, and inserted transactionally.

## Open security decisions before real data

- Independently review the sqlite3mc configuration and test at-rest encryption,
  key loss, schema migrations, and recovery on Android, Windows, and later iOS.
- Decide whether any local fields can remain outside the encrypted database for
  indexing or notifications. Default to none until reviewed.
- Select a backend region and document cross-border processing and subprocessors.
- Define session duration, re-authentication for export/delete/disconnect, device
  compromise assumptions, backup policy, and database migration rollback.
- Add dependency scanning, secret scanning, signed builds, provenance, secure
  update strategy, penetration testing, and an incident-response process.

## Residual risks

A rooted phone, compromised Windows account, screen capture, malicious
accessibility service, or compromised backend/provider may expose data despite
application controls. Forecasts can be wrong because of missing/pending
transactions, changing shifts, delayed bank updates, or incorrect categorization.
The UI must continue to label estimates and explain recovery instead of implying
certainty.

The connected provider still supplies fictional demo data. Imported CSV rows,
category corrections, splits, and layout mappings are persisted locally. This
milestone's paycheque confirmations, wage/hours assumptions, budget overrides,
and warning settings are session-only. None of this makes the app
production-ready: export/deletion UX, external review, release hardening, and
device-specific security tests remain.
