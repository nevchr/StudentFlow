import 'package:student_flow/core/money.dart';

enum TransactionStatus { pending, posted }

enum TransactionCategory {
  income,
  rent,
  groceries,
  transit,
  tuitionSavings,
  subscription,
  phone,
  schoolSupplies,
  dining,
  unexpected,
  other,
}

extension TransactionCategoryLabel on TransactionCategory {
  String get label => switch (this) {
    TransactionCategory.income => 'Income',
    TransactionCategory.rent => 'Rent',
    TransactionCategory.groceries => 'Groceries',
    TransactionCategory.transit => 'Transit',
    TransactionCategory.tuitionSavings => 'Tuition savings',
    TransactionCategory.subscription => 'Subscriptions',
    TransactionCategory.phone => 'Phone',
    TransactionCategory.schoolSupplies => 'School supplies',
    TransactionCategory.dining => 'Dining',
    TransactionCategory.unexpected => 'Unexpected expense',
    TransactionCategory.other => 'Other',
  };
}

final class FinancialTransaction {
  const FinancialTransaction({
    required this.id,
    required this.accountId,
    required this.date,
    required this.description,
    required this.amount,
    required this.category,
    required this.status,
    this.merchantName,
    this.providerTransactionId,
    this.parentTransactionId,
    this.isPossibleDuplicate = false,
  });

  final String id;
  final String accountId;
  final DateTime date;
  final String description;

  /// Positive values are money in; negative values are money out.
  final Money amount;
  final TransactionCategory category;
  final TransactionStatus status;
  final String? merchantName;
  final String? providerTransactionId;

  /// Split rows point to the original transaction.
  final String? parentTransactionId;
  final bool isPossibleDuplicate;
}
