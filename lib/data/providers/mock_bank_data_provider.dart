import 'package:student_flow/core/money.dart';
import 'package:student_flow/data/providers/bank_data_provider.dart';
import 'package:student_flow/domain/models/account.dart';
import 'package:student_flow/domain/models/budget.dart';
import 'package:student_flow/domain/models/finance_snapshot.dart';
import 'package:student_flow/domain/models/financial_transaction.dart';
import 'package:student_flow/domain/models/forecast.dart';
import 'package:student_flow/domain/models/income.dart';
import 'package:student_flow/domain/models/recurring_bill.dart';

/// A fixed scenario anchored on 12 September 2026 so screenshots and tests are
/// repeatable. It contains no real account or identity data.
final class MockBankDataProvider implements BankDataProvider {
  @override
  String get providerName => 'StudentFlow demo data';

  @override
  Future<BankSyncResult> sync({String? cursor}) async {
    return BankSyncResult(
      snapshot: _snapshot(),
      nextCursor: 'demo-2026-09-12-v1',
      hasMore: false,
    );
  }

  FinanceSnapshot _snapshot() {
    final accounts = [
      Account(
        id: 'account-chequing',
        name: 'Student chequing',
        institutionName: 'Demo Canadian Bank',
        mask: '1842',
        type: AccountType.chequing,
        currentBalance: Money.fromDollars(1875.07),
        availableBalance: Money.fromDollars(1842.67),
      ),
      Account(
        id: 'account-savings',
        name: 'Tuition savings',
        institutionName: 'Demo Canadian Bank',
        mask: '2601',
        type: AccountType.savings,
        currentBalance: Money.fromDollars(3150),
        availableBalance: Money.fromDollars(3150),
      ),
    ];

    final transactions = [
      _transaction(
        'txn-001',
        '2026-09-12',
        'Metro groceries',
        -46.82,
        TransactionCategory.groceries,
        status: TransactionStatus.pending,
      ),
      _transaction(
        'txn-002',
        '2026-09-11',
        'OC Transpo monthly pass',
        -128.75,
        TransactionCategory.transit,
      ),
      _transaction(
        'txn-003',
        '2026-09-10',
        'Campus coffee',
        -4.65,
        TransactionCategory.dining,
      ),
      _transaction(
        'txn-004',
        '2026-09-09',
        'Textbook marketplace',
        -78.40,
        TransactionCategory.schoolSupplies,
      ),
      _transaction(
        'txn-005',
        '2026-09-08',
        'FreshCo',
        -62.19,
        TransactionCategory.groceries,
      ),
      _transaction(
        'txn-006',
        '2026-09-06',
        'Laptop charger replacement',
        -89.99,
        TransactionCategory.unexpected,
      ),
      _transaction(
        'txn-007',
        '2026-09-05',
        'Campus bookstore',
        -34.25,
        TransactionCategory.schoolSupplies,
      ),
      _transaction(
        'txn-008',
        '2026-09-04',
        'Maple Street Cafe payroll',
        612.38,
        TransactionCategory.income,
      ),
      _transaction(
        'txn-009',
        '2026-09-03',
        'Tuition savings transfer',
        -150,
        TransactionCategory.tuitionSavings,
      ),
      _transaction(
        'txn-010',
        '2026-09-01',
        'September rent',
        -925,
        TransactionCategory.rent,
      ),
      _transaction(
        'txn-011',
        '2026-08-28',
        'Maple Street Cafe payroll',
        487.92,
        TransactionCategory.income,
      ),
      _transaction(
        'txn-012',
        '2026-08-21',
        'Maple Street Cafe payroll',
        555.10,
        TransactionCategory.income,
      ),
      _transaction(
        'txn-013',
        '2026-08-17',
        'Phone plan',
        -58.76,
        TransactionCategory.phone,
      ),
      _transaction(
        'txn-014',
        '2026-08-15',
        'Music subscription',
        -12.99,
        TransactionCategory.subscription,
      ),
      _transaction(
        'txn-015',
        '2026-08-14',
        'Maple Street Cafe payroll',
        431.70,
        TransactionCategory.income,
      ),
      _transaction(
        'txn-016',
        '2026-08-01',
        'August rent',
        -925,
        TransactionCategory.rent,
      ),
      _transaction(
        'txn-017',
        '2026-07-17',
        'Phone plan',
        -58.76,
        TransactionCategory.phone,
      ),
      _transaction(
        'txn-018',
        '2026-07-15',
        'Music subscription',
        -12.99,
        TransactionCategory.subscription,
      ),
      _transaction(
        'txn-019',
        '2026-07-01',
        'July rent',
        -925,
        TransactionCategory.rent,
      ),
      _transaction(
        'txn-020',
        '2026-06-17',
        'Phone plan',
        -58.76,
        TransactionCategory.phone,
      ),
      _transaction(
        'txn-021',
        '2026-06-15',
        'Music subscription',
        -12.99,
        TransactionCategory.subscription,
      ),
    ];

    final incomeProfile = IncomeProfile(
      employer: 'Maple Street Cafe',
      hourlyWage: Money.fromDollars(18.20),
      recentWeeklyHours: const [24, 19.5, 22, 17],
      expectedWeeklyHours: 21,
      recentPayDeposits: [
        _payDeposit('txn-008', '2026-09-04', 612.38),
        _payDeposit('txn-011', '2026-08-28', 487.92),
        _payDeposit('txn-012', '2026-08-21', 555.10),
        _payDeposit('txn-015', '2026-08-14', 431.70),
      ],
      expectedNextPayday: DateTime(2026, 9, 18),
      nextPaydayIsEstimate: true,
    );

    final recurringBills = [
      RecurringBill(
        id: 'bill-music',
        name: 'Music subscription',
        amount: Money.fromDollars(12.99),
        nextDueDate: DateTime(2026, 9, 15),
        category: TransactionCategory.subscription,
        isEssential: false,
        isEstimate: false,
      ),
      RecurringBill(
        id: 'bill-phone',
        name: 'Phone plan',
        amount: Money.fromDollars(58.76),
        nextDueDate: DateTime(2026, 9, 17),
        category: TransactionCategory.phone,
        isEssential: true,
        isEstimate: false,
      ),
      RecurringBill(
        id: 'bill-rent',
        name: 'October rent',
        amount: Money.fromDollars(925),
        nextDueDate: DateTime(2026, 10),
        category: TransactionCategory.rent,
        isEssential: true,
        isEstimate: false,
      ),
    ];

    return FinanceSnapshot(
      accounts: accounts,
      transactions: transactions,
      incomeProfile: incomeProfile,
      incomeForecasts: [
        _incomeForecast(
          ForecastScenario.conservative,
          420,
          'About 17 hours after estimated deductions',
        ),
        _incomeForecast(
          ForecastScenario.expected,
          515,
          'About 21 hours after estimated deductions',
        ),
        _incomeForecast(
          ForecastScenario.optimistic,
          610,
          'About 25 hours after estimated deductions',
        ),
      ],
      recurringBills: recurringBills,
      budget: Budget(
        periodStart: DateTime(2026, 9),
        periodEnd: DateTime(2026, 9, 30),
        emergencyBufferTarget: Money.fromDollars(700),
        categories: [
          _budget(TransactionCategory.rent, 925, 925, true),
          _budget(TransactionCategory.groceries, 360, 109.01, true),
          _budget(TransactionCategory.transit, 128.75, 128.75, true),
          _budget(TransactionCategory.tuitionSavings, 300, 150, true),
          _budget(TransactionCategory.phone, 58.76, 0, true),
          _budget(TransactionCategory.subscription, 25, 0, false),
          _budget(TransactionCategory.schoolSupplies, 175, 112.65, true),
        ],
      ),
      cashFlowForecast: CashFlowForecast(
        generatedAt: DateTime(2026, 9, 12, 9, 15),
        lowBalanceThreshold: Money.fromDollars(500),
        points: [
          CashFlowPoint(
            date: DateTime(2026, 9, 12),
            balance: Money.fromDollars(1842.67),
            summary: 'Available balance',
            isEstimate: false,
          ),
          CashFlowPoint(
            date: DateTime(2026, 9, 17),
            balance: Money.fromDollars(1635.92),
            summary: 'After phone, subscription, and reserved essentials',
            isEstimate: true,
          ),
          CashFlowPoint(
            date: DateTime(2026, 9, 18),
            balance: Money.fromDollars(2055.92),
            summary: 'After conservative estimated pay',
            isEstimate: true,
          ),
        ],
      ),
      lastSyncedAt: DateTime(2026, 9, 12, 9, 15),
      syncState: SyncState.upToDate,
      isDemoData: true,
    );
  }

  FinancialTransaction _transaction(
    String id,
    String isoDate,
    String description,
    num dollars,
    TransactionCategory category, {
    TransactionStatus status = TransactionStatus.posted,
  }) {
    return FinancialTransaction(
      id: id,
      accountId: 'account-chequing',
      date: DateTime.parse(isoDate),
      description: description,
      merchantName: description,
      amount: Money.fromDollars(dollars),
      category: category,
      status: status,
      providerTransactionId: 'demo-$id',
    );
  }

  PayDeposit _payDeposit(String id, String isoDate, num dollars) => PayDeposit(
    transactionId: id,
    employer: 'Maple Street Cafe',
    date: DateTime.parse(isoDate),
    amount: Money.fromDollars(dollars),
    isConfirmed: true,
  );

  IncomeForecast _incomeForecast(
    ForecastScenario scenario,
    num dollars,
    String assumption,
  ) => IncomeForecast(
    scenario: scenario,
    amount: Money.fromDollars(dollars),
    periodStart: DateTime(2026, 9, 12),
    periodEnd: DateTime(2026, 9, 18),
    assumption: assumption,
  );

  BudgetCategory _budget(
    TransactionCategory category,
    num target,
    num spent,
    bool isEssential,
  ) => BudgetCategory(
    category: category,
    target: Money.fromDollars(target),
    spent: Money.fromDollars(spent),
    isEssential: isEssential,
  );
}
