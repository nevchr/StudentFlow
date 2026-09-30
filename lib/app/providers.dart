import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_flow/core/money.dart';
import 'package:student_flow/data/import/csv_statement_importer.dart';
import 'package:student_flow/data/local/app_database.dart';
import 'package:student_flow/data/local/database_key_store.dart';
import 'package:student_flow/data/local/finance_local_store.dart';
import 'package:student_flow/data/providers/bank_data_provider.dart';
import 'package:student_flow/data/providers/mock_bank_data_provider.dart';
import 'package:student_flow/data/repositories/finance_repository.dart';
import 'package:student_flow/domain/models/finance_snapshot.dart';
import 'package:student_flow/domain/models/income.dart';
import 'package:student_flow/domain/services/budget_period_calculator.dart';
import 'package:student_flow/domain/services/cash_flow_forecaster.dart';
import 'package:student_flow/domain/services/payroll_detector.dart';
import 'package:student_flow/domain/services/recurring_bill_detector.dart';
import 'package:student_flow/domain/services/safe_to_spend_calculator.dart';
import 'package:student_flow/domain/services/variable_income_forecaster.dart';

final bankDataProvider = Provider<BankDataProvider>(
  (ref) => MockBankDataProvider(),
);

final databaseKeyStoreProvider = Provider<DatabaseKeyStore>(
  (ref) => PlatformDatabaseKeyStore(),
);

final databaseProvider = FutureProvider<StudentFlowDatabase>((ref) async {
  final database = await StudentFlowDatabase.openEncrypted(
    ref.watch(databaseKeyStoreProvider),
  );
  ref.onDispose(() => unawaited(database.close()));
  return database;
});

final localFinanceStoreProvider = FutureProvider<FinanceLocalStore>((
  ref,
) async {
  final database = await ref.watch(databaseProvider.future);
  return DriftFinanceLocalStore(database);
});

final financeRepositoryProvider = FutureProvider<FinanceRepository>((
  ref,
) async {
  final localStore = await ref.watch(localFinanceStoreProvider.future);
  return FinanceRepository(ref.watch(bankDataProvider), localStore);
});

final csvStatementImporterProvider = Provider<CsvStatementImporter>(
  (ref) => const CsvStatementImporter(),
);

final financeSnapshotProvider = FutureProvider<FinanceSnapshot>((ref) async {
  final repository = await ref.watch(financeRepositoryProvider.future);
  return repository.load();
});

final safeToSpendCalculatorProvider = Provider<SafeToSpendCalculator>(
  (ref) => const SafeToSpendCalculator(),
);

final payrollDetectorProvider = Provider<PayrollDetector>(
  (ref) => const PayrollDetector(),
);

final variableIncomeForecasterProvider = Provider<VariableIncomeForecaster>(
  (ref) => const VariableIncomeForecaster(),
);

final recurringBillDetectorProvider = Provider<RecurringBillDetector>(
  (ref) => const RecurringBillDetector(),
);

final budgetPeriodCalculatorProvider = Provider<BudgetPeriodCalculator>(
  (ref) => const BudgetPeriodCalculator(),
);

final cashFlowForecasterProvider = Provider<CashFlowForecaster>(
  (ref) => const CashFlowForecaster(),
);

final class IncomePlanningAssumptions {
  const IncomePlanningAssumptions({
    required this.hourlyWage,
    required this.recentWeeklyHours,
    required this.expectedWeeklyHours,
    required this.estimatedTakeHomeRate,
  });

  final Money hourlyWage;
  final List<double> recentWeeklyHours;
  final double expectedWeeklyHours;
  final double estimatedTakeHomeRate;
}

final class IncomePlanningAssumptionsNotifier
    extends Notifier<IncomePlanningAssumptions> {
  @override
  IncomePlanningAssumptions build() => IncomePlanningAssumptions(
    hourlyWage: Money.fromDollars(18.20),
    recentWeeklyHours: const [24, 19.5, 22, 17],
    expectedWeeklyHours: 21,
    estimatedTakeHomeRate: 0.82,
  );

  void update({
    required Money hourlyWage,
    required double expectedWeeklyHours,
  }) {
    state = IncomePlanningAssumptions(
      hourlyWage: hourlyWage,
      recentWeeklyHours: state.recentWeeklyHours,
      expectedWeeklyHours: expectedWeeklyHours,
      estimatedTakeHomeRate: state.estimatedTakeHomeRate,
    );
  }
}

final incomePlanningAssumptionsProvider =
    NotifierProvider<
      IncomePlanningAssumptionsNotifier,
      IncomePlanningAssumptions
    >(IncomePlanningAssumptionsNotifier.new);

final calculatedIncomeForecastsProvider = Provider<List<IncomeForecast>?>((
  ref,
) {
  final snapshot = ref.watch(financeSnapshotProvider).asData?.value;
  if (snapshot == null) return null;
  final assumptions = ref.watch(incomePlanningAssumptionsProvider);
  return ref
      .watch(variableIncomeForecasterProvider)
      .calculate(
        VariableIncomeForecastInput(
          hourlyWage: assumptions.hourlyWage,
          recentWeeklyHours: assumptions.recentWeeklyHours,
          expectedWeeklyHours: assumptions.expectedWeeklyHours,
          periodStart: snapshot.cashFlowForecast.generatedAt,
          periodEnd: snapshot.incomeProfile.expectedNextPayday,
          estimatedTakeHomeRate: assumptions.estimatedTakeHomeRate,
        ),
      );
});

final class SafeToSpendAssumptions {
  const SafeToSpendAssumptions({
    required this.reservedEssentialVariableSpending,
    required this.emergencyBuffer,
    required this.safetyMargin,
  });

  final Money reservedEssentialVariableSpending;
  final Money emergencyBuffer;
  final Money safetyMargin;
}

final class SafeToSpendAssumptionsNotifier
    extends Notifier<SafeToSpendAssumptions> {
  @override
  SafeToSpendAssumptions build() => SafeToSpendAssumptions(
    reservedEssentialVariableSpending: Money.fromDollars(135),
    emergencyBuffer: Money.fromDollars(700),
    safetyMargin: Money.fromDollars(75),
  );

  void update({
    required Money reservedEssentialVariableSpending,
    required Money emergencyBuffer,
    required Money safetyMargin,
  }) {
    state = SafeToSpendAssumptions(
      reservedEssentialVariableSpending: reservedEssentialVariableSpending,
      emergencyBuffer: emergencyBuffer,
      safetyMargin: safetyMargin,
    );
  }
}

final safeToSpendAssumptionsProvider =
    NotifierProvider<SafeToSpendAssumptionsNotifier, SafeToSpendAssumptions>(
      SafeToSpendAssumptionsNotifier.new,
    );

final safeToSpendProvider = Provider<SafeToSpendResult?>((ref) {
  final snapshot = ref.watch(financeSnapshotProvider).asData?.value;
  if (snapshot == null) return null;

  final forecasts = ref.watch(calculatedIncomeForecastsProvider);
  if (forecasts == null) return null;
  final conservativeIncome = forecasts
      .firstWhere((item) => item.scenario == ForecastScenario.conservative)
      .amount;
  final payday = snapshot.incomeProfile.expectedNextPayday;
  final essentialBills = snapshot.recurringBills
      .where((bill) => bill.isEssential && !bill.nextDueDate.isAfter(payday))
      .fold(Money.zero, (sum, bill) => sum + bill.amount);
  final assumptions = ref.watch(safeToSpendAssumptionsProvider);

  return ref
      .watch(safeToSpendCalculatorProvider)
      .calculate(
        SafeToSpendInput(
          currentAvailableBalance: snapshot.accounts.first.availableBalance,
          conservativeExpectedIncome: conservativeIncome,
          upcomingEssentialBills: essentialBills,
          reservedEssentialVariableSpending:
              assumptions.reservedEssentialVariableSpending,
          emergencyBuffer: assumptions.emergencyBuffer,
          safetyMargin: assumptions.safetyMargin,
        ),
      );
});
