import 'package:flutter_test/flutter_test.dart';
import 'package:student_flow/data/providers/mock_bank_data_provider.dart';
import 'package:student_flow/domain/services/payroll_detector.dart';

void main() {
  const detector = PayrollDetector();

  test('finds payroll deposits and learns a weekly pattern', () async {
    final snapshot = (await MockBankDataProvider().sync()).snapshot;
    final confirmedIds = snapshot.incomeProfile.recentPayDeposits
        .map((deposit) => deposit.transactionId)
        .toSet();
    final candidates = detector.detect(
      transactions: snapshot.transactions,
      confirmedTransactionIds: confirmedIds,
    );
    final pattern = detector.learnPattern(
      candidates: candidates,
      referenceDate: DateTime(2026, 9, 12),
    )!;

    expect(candidates, hasLength(4));
    expect(pattern.employer, 'Maple Street Cafe');
    expect(pattern.minimumAmount.cents, 43170);
    expect(pattern.maximumAmount.cents, 61238);
    expect(pattern.typicalIntervalDays, 7);
    expect(pattern.nextEstimatedPayday, DateTime(2026, 9, 18));
  });

  test('requires a confirmed candidate before learning', () async {
    final snapshot = (await MockBankDataProvider().sync()).snapshot;
    final candidates = detector.detect(transactions: snapshot.transactions);

    expect(
      detector.learnPattern(
        candidates: candidates,
        referenceDate: DateTime(2026, 9, 12),
      ),
      isNull,
    );
  });
}
