# Architecture and initial product shape

## Decisions

StudentFlow uses feature-oriented presentation code around a small domain core.
Money is integer CAD cents. This makes calculations deterministic and avoids
rounding surprises from floating-point values. Dates are `DateTime` values in
the domain and are rendered with Canadian English formats at the UI boundary.

Riverpod owns dependencies and shared assumptions. GoRouter owns the five-tab
shell. Repositories translate provider results into domain models. A
`BankDataProvider` implementation may be Plaid-backed, another aggregator,
statement import, or demo data without changing budgeting services.

Supabase is the working backend choice because SQL, row-level security, auth,
and server-side Edge Functions fit the data model. No Supabase client is added
in this milestone. Hosting region, Canadian privacy requirements, and deletion
behaviour remain production gates; Firebase is still a viable substitution if
those checks favour it.

Drift/SQLite is the offline data store. Native builds use sqlite3mc and a random
256-bit database key held by platform secure storage. Startup verifies that the
cipher is present and refuses to open the database instead of silently falling
back to ordinary SQLite. The schema and migrations live in `data/local`, and
generated Drift rows are translated to domain entities in the repository layer.

## Initial screen flow

```text
Launch / authentication gate (later)
  -> Home
       -> safe-to-spend explanation
       -> editable assumptions
       -> upcoming bill detail (later)
  -> Transactions
       -> search and status filters
       -> category correction
       -> CSV preview and bulk import
       -> remembered column mapping and duplicate skipping
       -> split transaction
  -> Income
       -> detected and confirmed paycheques
       -> learned employer, amount range, and payday pattern
       -> editable wage / changing-hours assumptions
       -> conservative, expected, and optimistic estimates
  -> Budget
       -> monthly / payday-to-payday category plans
       -> detected recurring bills
       -> low-balance warning and text-first forecast timeline
  -> Settings & privacy
       -> connections, export, delete, notifications, accessibility (next)
```

The same destinations use a bottom navigation bar on phones and a labelled
navigation rail on wide screens. Routes use no transition animation, which
respects reduced-motion needs by default.

## Data model

- `Account`: institution, masked identifier, account type, current and
  available balances.
- `FinancialTransaction`: signed amount, date, category, pending/posted state,
  provider ID, duplicate marker, and optional split-parent ID.
- `IncomeProfile`: employer, hourly wage, changing weekly hours, confirmed pay
  deposits, and estimated payday.
- `IncomeForecast`: conservative, expected, or optimistic amount with period and
  plain-language assumption.
- `PayrollCandidate` and `PayrollPattern`: transaction evidence, confirmation,
  employer, amount range, typical interval, and estimated next payday.
- `RecurringBill`: amount, due date, category, essential flag, and estimate flag.
- `DetectedRecurringBill`: repeated-payment evidence and estimated next date.
- `Budget`: period, category targets/spend, and emergency-buffer target.
- `BudgetPlan`: a calculated monthly or payday-period view with per-category
  progress.
- `CashFlowForecast`: dated balance points with text summaries and estimate
  markers.

## Safe-to-spend v1

```text
available balance
+ conservative expected income before payday
- essential bills due by payday
- reserved essential variable spending
- emergency buffer
- safety margin
```

The result is clamped at zero, every input is shown, and the three user-controlled
reserves can be adjusted. This is an estimate, not an AI score, guarantee, or
professional financial advice.

## Implemented CSV import design

The statement importer parses an entire CSV into staging rows, previews the
result, remembers mappings by normalized-header signature, and commits accepted
rows in one database transaction. Duplicate detection uses a SHA-256 fingerprint
of account, date, amount in cents, and normalized description, including matches
inside the same file. Input is limited to 5 MB, 10,000 rows, and 2,000 characters
per cell. Duplicate and invalid rows are not committed. OFX/QFX and ambiguous
duplicate review are later additions; manual entry remains a correction tool,
not the main workflow.
