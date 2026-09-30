import 'package:flutter_test/flutter_test.dart';
import 'package:student_flow/core/money.dart';
import 'package:student_flow/data/providers/mock_bank_data_provider.dart';
import 'package:student_flow/domain/models/budget.dart';
import 'package:student_flow/domain/models/financial_transaction.dart';
import 'package:student_flow/domain/models/forecast.dart';
import 'package:student_flow/domain/services/budget_period_calculator.dart';
import 'package:student_flow/domain/services/cash_flow_forecaster.dart';

void main() {
  test('prorates targets and uses only payday-period spending', () async {
    final snapshot = (await MockBankDataProvider().sync()).snapshot;
    final plan = const BudgetPeriodCalculator().calculate(
      budget: snapshot.budget,
      transactions: snapshot.transactions,
      kind: BudgetPeriodKind.paydayToPayday,
      periodStart: DateTime(2026, 9, 12),
      periodEnd: DateTime(2026, 9, 18),
    );

    final groceries = plan.categories.singleWhere(
      (item) => item.category == TransactionCategory.groceries,
    );
    expect(groceries.target.cents, 8400);
    expect(groceries.spent.cents, 4682);
    expect(groceries.remaining.cents, 3718);
  });

  test('cash-flow events update balances in date order', () {
    final forecast = const CashFlowForecaster().calculate(
      generatedAt: DateTime(2026, 9, 12),
      openingBalance: Money.fromDollars(1000),
      lowBalanceThreshold: Money.fromDollars(700),
      events: [
        CashFlowEvent(
          date: DateTime(2026, 9, 18),
          amount: Money.fromDollars(300),
          summary: 'Expected pay',
          kind: CashFlowEventKind.income,
          isEstimate: true,
        ),
        CashFlowEvent(
          date: DateTime(2026, 9, 15),
          amount: Money.fromDollars(-400),
          summary: 'Rent due',
          kind: CashFlowEventKind.bill,
          isEstimate: false,
        ),
      ],
    );

    expect(forecast.points.map((point) => point.balance.cents), [
      100000,
      60000,
      90000,
    ]);
    expect(forecast.points[1].summary, 'Rent due');
    expect(forecast.points[2].isEstimate, isTrue);
  });
}
