import 'package:student_flow/domain/models/finance_snapshot.dart';

/// Replaceable boundary for Plaid, another aggregator, statement import, or
/// deterministic demo data. Provider credentials never belong in this client.
abstract interface class BankDataProvider {
  String get providerName;

  Future<BankSyncResult> sync({String? cursor});
}

final class BankSyncResult {
  const BankSyncResult({
    required this.snapshot,
    required this.nextCursor,
    required this.hasMore,
  });

  final FinanceSnapshot snapshot;
  final String nextCursor;
  final bool hasMore;
}
