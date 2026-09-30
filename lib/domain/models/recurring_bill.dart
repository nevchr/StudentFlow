import 'package:student_flow/core/money.dart';
import 'package:student_flow/domain/models/financial_transaction.dart';

final class DetectedRecurringBill {
  const DetectedRecurringBill({
    required this.name,
    required this.typicalAmount,
    required this.nextEstimatedDate,
    required this.category,
    required this.occurrenceCount,
    required this.typicalIntervalDays,
  });

  final String name;
  final Money typicalAmount;
  final DateTime nextEstimatedDate;
  final TransactionCategory category;
  final int occurrenceCount;
  final int typicalIntervalDays;
}

final class RecurringBill {
  const RecurringBill({
    required this.id,
    required this.name,
    required this.amount,
    required this.nextDueDate,
    required this.category,
    required this.isEssential,
    required this.isEstimate,
  });

  final String id;
  final String name;
  final Money amount;
  final DateTime nextDueDate;
  final TransactionCategory category;
  final bool isEssential;
  final bool isEstimate;
}
