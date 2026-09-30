import 'package:student_flow/data/providers/bank_data_provider.dart';
import 'package:student_flow/data/local/finance_local_store.dart';
import 'package:student_flow/domain/models/finance_snapshot.dart';
import 'package:student_flow/domain/models/financial_transaction.dart';

final class FinanceRepository {
  const FinanceRepository(this._bankDataProvider, this._localStore);

  final BankDataProvider _bankDataProvider;
  final FinanceLocalStore _localStore;

  Future<FinanceSnapshot> load() async {
    final result = await _bankDataProvider.sync();
    final snapshot = result.snapshot;
    final corrections = await _localStore.loadCategoryCorrections();
    final splitGroups = await _localStore.loadTransactionSplits();
    final imported = await _localStore.loadImportedTransactions();
    final combined = [...snapshot.transactions, ...imported];
    final transactions = <FinancialTransaction>[];

    for (final transaction in combined) {
      final splits = splitGroups[transaction.id];
      if (splits == null || splits.isEmpty) {
        transactions.add(
          _withCategory(
            transaction,
            corrections[transaction.id] ?? transaction.category,
          ),
        );
        continue;
      }
      for (var index = 0; index < splits.length; index++) {
        final split = splits[index];
        transactions.add(
          FinancialTransaction(
            id: '${transaction.id}-part-${index + 1}',
            accountId: transaction.accountId,
            date: transaction.date,
            description: split.description,
            amount: split.amount,
            category: split.category,
            status: transaction.status,
            merchantName: transaction.merchantName,
            parentTransactionId: transaction.id,
          ),
        );
      }
    }

    transactions.sort((a, b) => b.date.compareTo(a.date));
    return FinanceSnapshot(
      accounts: snapshot.accounts,
      transactions: transactions,
      incomeProfile: snapshot.incomeProfile,
      incomeForecasts: snapshot.incomeForecasts,
      recurringBills: snapshot.recurringBills,
      budget: snapshot.budget,
      cashFlowForecast: snapshot.cashFlowForecast,
      lastSyncedAt: snapshot.lastSyncedAt,
      syncState: snapshot.syncState,
      isDemoData: snapshot.isDemoData,
    );
  }

  FinancialTransaction _withCategory(
    FinancialTransaction transaction,
    TransactionCategory category,
  ) => FinancialTransaction(
    id: transaction.id,
    accountId: transaction.accountId,
    date: transaction.date,
    description: transaction.description,
    amount: transaction.amount,
    category: category,
    status: transaction.status,
    merchantName: transaction.merchantName,
    providerTransactionId: transaction.providerTransactionId,
    parentTransactionId: transaction.parentTransactionId,
    isPossibleDuplicate: transaction.isPossibleDuplicate,
  );
}
