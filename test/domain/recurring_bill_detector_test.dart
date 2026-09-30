import 'package:flutter_test/flutter_test.dart';
import 'package:student_flow/data/providers/mock_bank_data_provider.dart';
import 'package:student_flow/domain/models/financial_transaction.dart';
import 'package:student_flow/domain/services/recurring_bill_detector.dart';

void main() {
  const detector = RecurringBillDetector();

  test(
    'finds repeated monthly rent, phone, and subscription payments',
    () async {
      final snapshot = (await MockBankDataProvider().sync()).snapshot;
      final detected = detector.detect(
        snapshot.transactions,
        referenceDate: DateTime(2026, 9, 12),
      );

      expect(detected, hasLength(3));
      expect(detected.map((bill) => bill.category).toSet(), {
        TransactionCategory.rent,
        TransactionCategory.phone,
        TransactionCategory.subscription,
      });
      expect(detected.every((bill) => bill.occurrenceCount == 3), isTrue);
    },
  );
}
