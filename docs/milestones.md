# Phased implementation plan

## Milestone 1 — working local slice (implemented)

- Generate Android and Windows projects.
- Establish Material 3, Riverpod, GoRouter, Canadian formatting, and accessible
  responsive navigation.
- Add typed finance models, a provider-neutral bank boundary, deterministic demo
  data, Home, Transactions, and safe-to-spend tests.
- Record production integration, security, accessibility, and setup decisions.

## Milestone 2 — secure local-first workflows (in progress)

- Implemented encrypted Drift storage, a fail-closed cipher check, and
  platform-protected keys. Migration coverage is still required before schema 2.
- Implemented bulk CSV import, remembered mappings, batch preview, and automatic
  duplicate skipping. OFX/QFX and manual ambiguous-match review remain.
- Implemented persisted category corrections and two-part transaction splits.
- Add encrypted export, delete-imported-data, and local data-reset flows.

## Milestone 3 — variable income and budgeting (core implemented)

- Implemented payroll candidate detection, confirmation controls, and payday
  pattern learning from confirmed deposits.
- Implemented hourly wage and changing recent/expected shift assumptions.
- Implemented conservative, expected, and optimistic income scenarios, always labelled
  as estimates.
- Implemented recurring-bill detection, monthly/payday budgets, low-balance
  warnings, and an accessible text-first forecast timeline.
- Added deterministic and edge-case tests for payroll, income, budgeting, and
  forecasting. Property-based coverage remains a later hardening task.
- Persist income confirmations and planning overrides after the next schema
  migration is designed and tested.

## Milestone 4 — isolated Plaid Sandbox backend

- Add Supabase Auth and row-level policies after confirming a suitable hosting
  region and privacy posture.
- Create server-only functions for Link tokens, public-token exchange, item
  removal, cursor-based transaction sync, and verified webhook handling.
- Store provider access tokens only in backend secret storage/encrypted records.
- Implement a client adapter that calls StudentFlow's backend, never Plaid with
  permanent credentials.
- Exercise pending-to-posted updates, removed transactions, pagination,
  idempotency, reconnects, and consent expiry in Sandbox.

## Milestone 5 — privacy and accessible beta

- Finish connection, disconnection, account deletion, export, notification, and
  accessibility settings.
- Run TalkBack, 200% text scaling, contrast, non-colour cues, 48-pixel target,
  reduced-motion, keyboard, and screen-reader test passes.
- Add log-redaction tests, abuse controls, rate limits, monitoring, backup and
  incident-response plans.
- Complete a Canadian privacy/legal review and clear every Plaid production gate
  before attempting live CIBC access.

## Explicitly out of scope for the MVP

Money transfers, bill payments, credit decisions, investment advice, advertising
use of financial data, and selling financial data.
