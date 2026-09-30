import 'package:student_flow/core/money.dart';
import 'package:student_flow/domain/models/financial_transaction.dart';
import 'package:student_flow/domain/models/recurring_bill.dart';

final class RecurringBillDetector {
  const RecurringBillDetector();

  List<DetectedRecurringBill> detect(
    List<FinancialTransaction> transactions, {
    required DateTime referenceDate,
  }) {
    final groups = <String, List<FinancialTransaction>>{};
    for (final transaction in transactions) {
      if (!transaction.amount.isNegative ||
          transaction.status != TransactionStatus.posted) {
        continue;
      }
      final key = _normalizedMerchant(transaction.description);
      groups.putIfAbsent(key, () => []).add(transaction);
    }

    final detected = <DetectedRecurringBill>[];
    for (final entries in groups.values) {
      if (entries.length < 2) continue;
      entries.sort((a, b) => a.date.compareTo(b.date));
      final intervals = <int>[];
      for (var index = 1; index < entries.length; index++) {
        final days = entries[index].date
            .difference(entries[index - 1].date)
            .inDays;
        if (days >= 25 && days <= 40) intervals.add(days);
      }
      if (intervals.isEmpty) continue;
      intervals.sort();
      final typicalInterval = intervals[intervals.length ~/ 2];
      final amounts = entries.map((item) => item.amount.cents.abs()).toList()
        ..sort();
      final typicalAmount = amounts[amounts.length ~/ 2];
      var nextDate = entries.last.date.add(Duration(days: typicalInterval));
      while (!nextDate.isAfter(referenceDate)) {
        nextDate = nextDate.add(Duration(days: typicalInterval));
      }

      detected.add(
        DetectedRecurringBill(
          name: _displayName(entries.last.description),
          typicalAmount: Money.fromCents(typicalAmount),
          nextEstimatedDate: nextDate,
          category: entries.last.category,
          occurrenceCount: entries.length,
          typicalIntervalDays: typicalInterval,
        ),
      );
    }
    detected.sort((a, b) => a.nextEstimatedDate.compareTo(b.nextEstimatedDate));
    return detected;
  }

  String _normalizedMerchant(String value) {
    const months =
        r'january|february|march|april|may|june|july|august|september|october|november|december';
    return value
        .toLowerCase()
        .replaceAll(RegExp(months), '')
        .replaceAll(RegExp(r'\d+'), '')
        .replaceAll(RegExp(r'[^a-z]+'), ' ')
        .trim()
        .replaceAll(RegExp(r'\s+'), ' ');
  }

  String _displayName(String value) {
    final cleaned = value
        .replaceAll(
          RegExp(
            r'january|february|march|april|may|june|july|august|september|october|november|december',
            caseSensitive: false,
          ),
          '',
        )
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
    return cleaned.isEmpty ? value : cleaned;
  }
}
