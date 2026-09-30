import 'package:flutter_test/flutter_test.dart';
import 'package:student_flow/data/providers/mock_bank_data_provider.dart';
import 'package:student_flow/domain/models/financial_transaction.dart';

void main() {
  test('returns the same realistic demo scenario on every sync', () async {
    final provider = MockBankDataProvider();

    final first = await provider.sync();
    final second = await provider.sync(cursor: first.nextCursor);

    expect(first.nextCursor, second.nextCursor);
    expect(first.hasMore, isFalse);
    expect(first.snapshot.isDemoData, isTrue);
    expect(
      first.snapshot.transactions.map((item) => item.id),
      second.snapshot.transactions.map((item) => item.id),
    );
    expect(first.snapshot.incomeProfile.recentWeeklyHours, [24, 19.5, 22, 17]);
    expect(
      first.snapshot.transactions
          .where((item) => item.category == TransactionCategory.income)
          .map((item) => item.amount.cents),
      [61238, 48792, 55510, 43170],
    );
  });

  test('includes both pending and posted transaction states', () async {
    final snapshot = (await MockBankDataProvider().sync()).snapshot;

    expect(
      snapshot.transactions.any(
        (item) => item.status == TransactionStatus.pending,
      ),
      isTrue,
    );
    expect(
      snapshot.transactions.any(
        (item) => item.status == TransactionStatus.posted,
      ),
      isTrue,
    );
  });
}
