# Plaid Sandbox integration plan

This plan is isolated from the domain and budgeting code. It is not a claim that
live CIBC connectivity will be approved or reliable.

## Current public-documentation checkpoint

Checked 12 September 2026:

- Plaid's public CIBC page lists Canada plus Balance and Transactions support,
  among other products and account types.
- Plaid warns that its public coverage table is not real-time. Before production,
  query `/institutions/get` using the intended country, products, account types,
  and Plaid team, and confirm CIBC in the Plaid Dashboard.
- Transactions pricing uses a subscription model; exact eligible pricing is
  provided through Production access or sales, so no dollar estimate is assumed.
- Sandbox is free test data and does not reproduce every institution-specific
  production behaviour. New Canadian customers must configure a Link use case
  for production Data Transparency Messaging.
- Production requires an access request and completed application/company
  profile. StudentFlow must supply its own privacy notice and obtain required
  consent.

These facts can change and must be revalidated immediately before live testing.

## Proposed boundary

```text
Flutter client
  -> authenticated StudentFlow backend endpoint
       -> Plaid /link/token/create
       -> Plaid /item/public_token/exchange
       -> encrypted server token store
       -> Plaid /transactions/sync with per-item cursor

Plaid SYNC_UPDATES_AVAILABLE webhook
  -> verified/idempotent backend handler
       -> loop /transactions/sync until has_more is false
       -> upsert added/modified and remove deleted transaction records
       -> publish a user-scoped sync status
```

The client receives a short-lived Link token and normalized financial records.
It never receives a Plaid secret or permanent access token. StudentFlow never
collects or stores a CIBC username or password; institution authentication occurs
inside the user-authorized Link/institution flow.

## Sandbox implementation checklist

1. Create separate Plaid Sandbox and Supabase development projects.
2. Store Plaid client ID/secret in backend secret management only.
3. Add authenticated endpoints for Link-token creation and public-token exchange.
4. Initialize only required products and country code `CA`; disclose the precise
   budgeting use case before Link.
5. Immediately call `/transactions/sync`, persist its cursor server-side, and
   handle every page until `has_more` is false.
6. Handle added, modified, and removed transactions idempotently. Preserve
   pending-to-posted relationships where supplied.
7. Verify webhook authenticity using Plaid's current recommended verification
   procedure, protect against replay, and redact payloads from logs.
8. Implement disconnect with `/item/remove`, token deletion, local cache cleanup,
   and a clear partial-failure recovery path.
9. Test consent expiry, update mode, provider outages, duplicate webhook delivery,
   pagination, deleted transactions, and reconnects.
10. Keep statement import and demo providers available behind the same interface.

## Production gates

- Confirm CIBC Transactions and Balance coverage for the exact account subtypes
  using live Plaid tooling; verify quality with consenting test users.
- Obtain Plaid approval, confirm exact pricing/contract terms, and complete Link
  consent/data-transparency configuration.
- Complete Canadian privacy and legal review, including meaningful consent,
  retention schedule, cross-border processing, access/export/deletion, breach
  response, and provincial requirements where applicable.
- Document what StudentFlow retains, why, where, for how long, and what Plaid may
  retain under its then-current terms. Invoke provider deletion/disconnection
  APIs and verify their outcomes.
- If any gate fails, evaluate another reputable Canadian aggregator; otherwise
  ship bulk OFX/QFX/CSV import plus demo mode without changing domain services.

## Official references

- https://plaid.com/institutions/cibc/
- https://plaid.com/docs/institutions/
- https://plaid.com/docs/sandbox/
- https://plaid.com/docs/transactions/
- https://plaid.com/docs/transactions/webhooks/
- https://plaid.com/docs/link/data-transparency-messaging-migration-guide/
- https://plaid.com/docs/launch-checklist/
- https://plaid.com/pricing/
- https://plaid.com/legal/
