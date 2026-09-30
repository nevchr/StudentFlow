# StudentFlow

StudentFlow is an accessible cash-flow companion for Canadian students with
variable income. This local-only Flutter prototype uses
fictional demo data. It does not connect to a bank, move money, or provide
professional financial advice.

## What exists now

- Android and Windows Flutter runners generated with Flutter 3.47.4.
- Material 3 navigation that changes from a bottom bar to a navigation rail on
  wider Windows layouts.
- Riverpod dependency injection/state and GoRouter navigation.
- Typed accounts, transactions, pay deposits, income forecasts, recurring
  bills, budgets, and cash-flow forecasts.
- A provider-neutral `BankDataProvider` plus deterministic Canadian demo data.
- Home and searchable/filterable Transactions screens.
- Payroll-candidate confirmation and rule-based payday-pattern learning.
- Editable hourly wage and changing-hours assumptions with conservative,
  expected, and optimistic pay estimates.
- Monthly and payday-to-payday category budgets, recurring-bill detection,
  low-balance warnings, and a text-first forecast timeline.
- Encrypted Drift/SQLite storage with a platform-protected random database key.
- Bulk CSV statement import with a review step, remembered column mappings,
  bounded input, automatic categorization, and duplicate detection.
- Category corrections and two-part transaction splits that persist locally.
- An explained safe-to-spend calculation with editable assumptions.
- Unit and widget tests for calculations, imports, persistence, core screens,
  and 200% text scaling across Home, Income, and Budget.

Settings intentionally remains the next product slice. There is still no live
bank connection or authentication backend.

## Folder structure

```text
lib/
  app/                         app, router, theme, Riverpod providers
  core/                        cross-cutting value types such as Money
  data/
    import/                    bounded CSV parsing and import models
    local/                     encrypted Drift schema and local repositories
    providers/                 bank/import/demo adapters
    repositories/              provider-neutral data access
  domain/
    models/                    typed finance entities
    services/                  deterministic business calculations
  features/
    home/presentation/         Home screen
    transactions/presentation Transactions screen
    income/presentation/       income assumptions and pay forecasts
    budget/presentation/       budgets, bill patterns, cash-flow timeline
    settings/presentation/     routed milestone placeholder
  shared/widgets/              reusable accessible UI
test/
  data/                        provider, CSV, and persistence tests
  domain/                      calculation tests
docs/                          architecture, roadmap, Plaid, and security notes
```

The dependency direction is `presentation -> repository/service -> provider`.
Budgeting code knows nothing about Plaid, CSV files, or backend SDKs.

## Build and run from source

Use Flutter 3.47.4 (Dart 3.13.3), with Flutter's `bin` directory on PATH. On Windows x64, install Visual Studio's **Desktop development with C++** workload and enable Developer Mode for plugin symlinks. Android additionally needs Android Studio/SDK and an emulator or attached device. Run `flutter doctor -v` to check your chosen target; accept Android SDK licenses with `flutter doctor --android-licenses` if using Android.

From the repository root in PowerShell:

```powershell
flutter pub get --enforce-lockfile
flutter analyze
flutter test
flutter run -d windows
```

For a native Windows debug build, run `flutter build windows --debug`; its executable is `build/windows/x64/runner/Debug/student_flow.exe`. For Android, use `flutter devices` and `flutter run -d <device-id>`, or `flutter build apk --debug` with the Android toolchain installed.

Generated Drift files are committed. After changing the schema, regenerate them with `dart run build_runner build`. Package caches, build outputs and local tooling settings are regenerated locally and are not required from Git. No real bank data or credentials are needed.

## Verification snapshot (14 September 2026)

- `dart format --set-exit-if-changed lib test`: no changes required.
- `flutter analyze`: no issues.
- `flutter test`: 24 tests passed, including safe-to-spend, variable income,
  payroll and recurring-bill detection, budgets, cash-flow forecasting, CSV
  duplicate/import, local persistence, and 200% system text-scaling coverage.
- `flutter build windows --debug`: passed with encrypted sqlite3mc and secure
  storage plugins; the app was launched successfully from
  `build\windows\x64\runner\Debug\student_flow.exe`.
- `flutter build apk --debug`: passed and produced
  `build\app\outputs\flutter-apk\app-debug.apk`.
- Android runtime: installed and launched on `StudentFlow_Pixel_8_API_36`;
  Home, Income, and Budget were verified through the Android accessibility tree,
  including the emulator's current 200% text setting.
- Encryption smoke check: the first 16 bytes of the Android and Windows
  databases do not contain SQLite's plaintext file signature.

## Product and engineering notes

- [Architecture and screen flow](docs/architecture.md)
- [Phased milestone plan](docs/milestones.md)
- [Plaid Sandbox integration plan](docs/plaid_sandbox_plan.md)
- [Threat assumptions and remaining risks](docs/threat_model.md)

## Important limitations

- All displayed data is fictional and anchored to 12 September 2026.
- Safe-to-spend assumptions, income assumptions, paycheque confirmations,
  budget target overrides, and warning settings remain session-only.
- CSV is the implemented statement format; OFX/QFX are not implemented yet.
- No authentication, notifications, live bank sync, data export/deletion UI,
  or backend is active yet.
- The database uses sqlite3mc encryption and refuses to open if the cipher is
  unavailable. This is an engineering control, not a completed security audit.
- Plaid production access and CIBC connectivity are not guaranteed. Current
  coverage, commercial terms, consent, and retention requirements must be
  rechecked immediately before any production implementation.
