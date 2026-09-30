import 'package:student_flow/core/money.dart';
import 'package:student_flow/domain/models/financial_transaction.dart';

enum BudgetPeriodKind { monthly, paydayToPayday }

extension BudgetPeriodKindLabel on BudgetPeriodKind {
  String get label => switch (this) {
    BudgetPeriodKind.monthly => 'Monthly',
    BudgetPeriodKind.paydayToPayday => 'Until payday',
  };
}

final class BudgetCategoryProgress {
  const BudgetCategoryProgress({
    required this.category,
    required this.target,
    required this.spent,
    required this.isEssential,
  });

  final TransactionCategory category;
  final Money target;
  final Money spent;
  final bool isEssential;

  Money get remaining => (target - spent).clampToZero();
  bool get isOverTarget => spent.cents > target.cents;
  double get progress => target.cents <= 0
      ? (spent.cents > 0 ? 1 : 0)
      : (spent.cents / target.cents).clamp(0, 1).toDouble();
}

final class BudgetPlan {
  const BudgetPlan({
    required this.kind,
    required this.periodStart,
    required this.periodEnd,
    required this.categories,
  });

  final BudgetPeriodKind kind;
  final DateTime periodStart;
  final DateTime periodEnd;
  final List<BudgetCategoryProgress> categories;

  Money get totalTarget =>
      categories.fold(Money.zero, (total, category) => total + category.target);

  Money get totalSpent =>
      categories.fold(Money.zero, (total, category) => total + category.spent);

  Money get totalRemaining => categories.fold(
    Money.zero,
    (total, category) => total + category.remaining,
  );
}

final class BudgetCategory {
  const BudgetCategory({
    required this.category,
    required this.target,
    required this.spent,
    required this.isEssential,
  });

  final TransactionCategory category;
  final Money target;
  final Money spent;
  final bool isEssential;
}

final class Budget {
  const Budget({
    required this.periodStart,
    required this.periodEnd,
    required this.categories,
    required this.emergencyBufferTarget,
  });

  final DateTime periodStart;
  final DateTime periodEnd;
  final List<BudgetCategory> categories;
  final Money emergencyBufferTarget;
}
