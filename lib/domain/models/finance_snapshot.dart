import 'package:student_flow/domain/models/account.dart';
import 'package:student_flow/domain/models/budget.dart';
import 'package:student_flow/domain/models/financial_transaction.dart';
import 'package:student_flow/domain/models/forecast.dart';
import 'package:student_flow/domain/models/income.dart';
import 'package:student_flow/domain/models/recurring_bill.dart';

enum SyncState { idle, syncing, upToDate, needsAttention }

final class FinanceSnapshot {
  const FinanceSnapshot({
    required this.accounts,
    required this.transactions,
    required this.incomeProfile,
    required this.incomeForecasts,
    required this.recurringBills,
    required this.budget,
    required this.cashFlowForecast,
    required this.lastSyncedAt,
    required this.syncState,
    required this.isDemoData,
  });

  final List<Account> accounts;
  final List<FinancialTransaction> transactions;
  final IncomeProfile incomeProfile;
  final List<IncomeForecast> incomeForecasts;
  final List<RecurringBill> recurringBills;
  final Budget budget;
  final CashFlowForecast cashFlowForecast;
  final DateTime lastSyncedAt;
  final SyncState syncState;
  final bool isDemoData;
}
