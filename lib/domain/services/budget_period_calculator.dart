import 'package:student_flow/core/money.dart';
import 'package:student_flow/domain/models/budget.dart';
import 'package:student_flow/domain/models/financial_transaction.dart';

final class BudgetPeriodCalculator {
  const BudgetPeriodCalculator();

  BudgetPlan calculate({
    required Budget budget,
    required List<FinancialTransaction> transactions,
    required BudgetPeriodKind kind,
    required DateTime periodStart,
    required DateTime periodEnd,
    Map<TransactionCategory, Money> targetOverrides = const {},
  }) {
    if (periodEnd.isBefore(periodStart)) {
      throw const FormatException('Budget period end must follow its start.');
    }
    final inclusiveDays = periodEnd.difference(periodStart).inDays + 1;
    final monthDays =
        DateTime(budget.periodStart.year, budget.periodStart.month + 1)
            .difference(
              DateTime(budget.periodStart.year, budget.periodStart.month),
            )
            .inDays;
    final ratio = kind == BudgetPeriodKind.monthly
        ? 1.0
        : inclusiveDays / monthDays;

    final categories = budget.categories
        .map((category) {
          final baseTarget =
              targetOverrides[category.category] ?? category.target;
          final target = Money.fromCents((baseTarget.cents * ratio).round());
          final spent = transactions
              .where(
                (transaction) =>
                    transaction.amount.isNegative &&
                    transaction.category == category.category &&
                    !_dateOnly(transaction.date)
                        .isBefore(_dateOnly(periodStart)) &&
                    !_dateOnly(transaction.date).isAfter(_dateOnly(periodEnd)),
              )
              .fold(
                Money.zero,
                (total, transaction) => total + (-transaction.amount),
              );
          return BudgetCategoryProgress(
            category: category.category,
            target: target,
            spent: spent,
            isEssential: category.isEssential,
          );
        })
        .toList(growable: false);

    return BudgetPlan(
      kind: kind,
      periodStart: periodStart,
      periodEnd: periodEnd,
      categories: categories,
    );
  }

  DateTime _dateOnly(DateTime value) =>
      DateTime(value.year, value.month, value.day);
}
