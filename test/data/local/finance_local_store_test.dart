import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:student_flow/core/money.dart';
import 'package:student_flow/data/import/csv_statement_importer.dart';
import 'package:student_flow/data/import/statement_import_models.dart';
import 'package:student_flow/data/local/app_database.dart';
import 'package:student_flow/data/local/finance_local_store.dart';
import 'package:student_flow/data/providers/mock_bank_data_provider.dart';
import 'package:student_flow/data/repositories/finance_repository.dart';
import 'package:student_flow/domain/models/financial_transaction.dart';

void main() {
  late StudentFlowDatabase database;
  late DriftFinanceLocalStore store;

  setUp(() {
    database = StudentFlowDatabase(NativeDatabase.memory());
    store = DriftFinanceLocalStore(
      database,
      now: () => DateTime.utc(2026, 9, 12, 10),
    );
  });

  tearDown(() => database.close());

  test('remembers a CSV mapping and persists a bulk import', () async {
    const importer = CsvStatementImporter();
    final document = importer.inspect('''
Date,Description,Amount
2026-09-10,FreshCo,-62.19
2026-09-11,Campus payroll,488.90
''');
    final mapping = importer.suggestMapping(document)!;
    final preview = importer.preview(
      document: document,
      mapping: mapping,
      accountId: 'imported-chequing',
    );

    await store.saveMapping(document.headerSignature, mapping);
    final result = await store.commitImport(
      fileName: 'september.csv',
      accountId: 'imported-chequing',
      preview: preview,
    );

    final remembered = await store.loadMapping(document.headerSignature);
    final transactions = await store.loadImportedTransactions();
    expect(remembered?.amountColumn, 'Amount');
    expect(remembered?.datePattern, 'yyyy-MM-dd');
    expect(result.importedCount, 2);
    expect(transactions, hasLength(2));
    expect(await store.loadImportFingerprints(), hasLength(2));
  });

  test('category corrections and splits survive repository reloads', () async {
    await store.saveCategoryCorrection(
      'txn-002',
      TransactionCategory.schoolSupplies,
    );
    await store.saveTransactionSplits(
      parentTransactionId: 'txn-001',
      originalAmount: const Money.fromCents(-4682),
      splits: const [
        TransactionSplitDraft(
          description: 'Metro groceries - food',
          amount: Money.fromCents(-4000),
          category: TransactionCategory.groceries,
        ),
        TransactionSplitDraft(
          description: 'Metro groceries - supplies',
          amount: Money.fromCents(-682),
          category: TransactionCategory.schoolSupplies,
        ),
      ],
    );

    final snapshot = await FinanceRepository(
      MockBankDataProvider(),
      store,
    ).load();

    expect(snapshot.transactions.any((item) => item.id == 'txn-001'), isFalse);
    expect(
      snapshot.transactions.where(
        (item) => item.parentTransactionId == 'txn-001',
      ),
      hasLength(2),
    );
    expect(
      snapshot.transactions
          .singleWhere((item) => item.id == 'txn-002')
          .category,
      TransactionCategory.schoolSupplies,
    );
  });

  test('rejects splits whose parts do not equal the original', () async {
    expect(
      () => store.saveTransactionSplits(
        parentTransactionId: 'txn-001',
        originalAmount: const Money.fromCents(-4682),
        splits: const [
          TransactionSplitDraft(
            description: 'Part one',
            amount: Money.fromCents(-2000),
            category: TransactionCategory.groceries,
          ),
          TransactionSplitDraft(
            description: 'Part two',
            amount: Money.fromCents(-2000),
            category: TransactionCategory.other,
          ),
        ],
      ),
      throwsFormatException,
    );
  });
}
