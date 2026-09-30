import 'package:drift/drift.dart';
import 'package:student_flow/core/money.dart';
import 'package:student_flow/data/import/statement_import_models.dart';
import 'package:student_flow/data/local/app_database.dart';
import 'package:student_flow/domain/models/account.dart';
import 'package:student_flow/domain/models/financial_transaction.dart';

abstract interface class FinanceLocalStore {
  Future<Map<String, TransactionCategory>> loadCategoryCorrections();

  Future<void> saveCategoryCorrection(
    String transactionId,
    TransactionCategory category,
  );

  Future<Map<String, List<TransactionSplitDraft>>> loadTransactionSplits();

  Future<void> saveTransactionSplits({
    required String parentTransactionId,
    required Money originalAmount,
    required List<TransactionSplitDraft> splits,
  });

  Future<Set<String>> loadImportFingerprints();

  Future<List<FinancialTransaction>> loadImportedTransactions();

  Future<CsvColumnMapping?> loadMapping(String headerSignature);

  Future<void> saveMapping(String headerSignature, CsvColumnMapping mapping);

  Future<StatementImportResult> commitImport({
    required String fileName,
    required String accountId,
    required StatementImportPreview preview,
  });
}

final class DriftFinanceLocalStore implements FinanceLocalStore {
  DriftFinanceLocalStore(this.database, {DateTime Function()? now})
    : _now = now ?? DateTime.now;

  final StudentFlowDatabase database;
  final DateTime Function() _now;

  @override
  Future<Map<String, TransactionCategory>> loadCategoryCorrections() async {
    final rows = await database.select(database.categoryCorrections).get();
    return {
      for (final row in rows)
        row.transactionId: TransactionCategory.values[row.category],
    };
  }

  @override
  Future<void> saveCategoryCorrection(
    String transactionId,
    TransactionCategory category,
  ) {
    return database
        .into(database.categoryCorrections)
        .insertOnConflictUpdate(
          CategoryCorrectionsCompanion.insert(
            transactionId: transactionId,
            category: category.index,
            updatedAt: _now().toUtc(),
          ),
        );
  }

  @override
  Future<Map<String, List<TransactionSplitDraft>>>
  loadTransactionSplits() async {
    final rows = await database.select(database.transactionSplits).get();
    final result = <String, List<TransactionSplitDraft>>{};
    for (final row in rows) {
      result
          .putIfAbsent(row.parentTransactionId, () => [])
          .add(
            TransactionSplitDraft(
              description: row.description,
              amount: Money.fromCents(row.amountCents),
              category: TransactionCategory.values[row.category],
            ),
          );
    }
    return result;
  }

  @override
  Future<void> saveTransactionSplits({
    required String parentTransactionId,
    required Money originalAmount,
    required List<TransactionSplitDraft> splits,
  }) async {
    if (splits.length < 2) {
      throw const FormatException('A split needs at least two parts.');
    }
    if (splits.any((split) => split.amount == Money.zero)) {
      throw const FormatException('Split amounts cannot be zero.');
    }
    final total = splits.fold(Money.zero, (sum, split) => sum + split.amount);
    if (total != originalAmount) {
      throw const FormatException(
        'Split amounts must add up to the original transaction.',
      );
    }

    await database.transaction(() async {
      await (database.delete(database.transactionSplits)..where(
            (row) => row.parentTransactionId.equals(parentTransactionId),
          ))
          .go();
      final createdAt = _now().toUtc();
      await database.batch((batch) {
        for (var index = 0; index < splits.length; index++) {
          final split = splits[index];
          batch.insert(
            database.transactionSplits,
            TransactionSplitsCompanion.insert(
              id: '$parentTransactionId-part-${index + 1}',
              parentTransactionId: parentTransactionId,
              description: split.description,
              amountCents: split.amount.cents,
              category: split.category.index,
              createdAt: createdAt,
            ),
          );
        }
      });
    });
  }

  @override
  Future<Set<String>> loadImportFingerprints() async {
    final rows = await (database.select(
      database.localTransactions,
    )..where((row) => row.importFingerprint.isNotNull())).get();
    return rows.map((row) => row.importFingerprint!).toSet();
  }

  @override
  Future<List<FinancialTransaction>> loadImportedTransactions() async {
    final rows = await (database.select(
      database.localTransactions,
    )..orderBy([(row) => OrderingTerm.desc(row.transactionDate)])).get();
    return rows
        .map(
          (row) => FinancialTransaction(
            id: row.id,
            accountId: row.accountId,
            date: row.transactionDate,
            description: row.description,
            amount: Money.fromCents(row.amountCents),
            category: TransactionCategory.values[row.category],
            status: TransactionStatus.values[row.transactionStatus],
            merchantName: row.merchantName,
            providerTransactionId: row.providerTransactionId,
            parentTransactionId: row.parentTransactionId,
            isPossibleDuplicate: row.isPossibleDuplicate,
          ),
        )
        .toList(growable: false);
  }

  @override
  Future<CsvColumnMapping?> loadMapping(String headerSignature) async {
    final row =
        await (database.select(database.importMappings)..where(
              (mapping) => mapping.headerSignature.equals(headerSignature),
            ))
            .getSingleOrNull();
    if (row == null) return null;
    return CsvColumnMapping(
      dateColumn: row.dateColumn,
      descriptionColumn: row.descriptionColumn,
      amountColumn: row.amountColumn,
      debitColumn: row.debitColumn,
      creditColumn: row.creditColumn,
      datePattern: row.datePattern,
      expensesAreNegative: row.expensesAreNegative,
    );
  }

  @override
  Future<void> saveMapping(String headerSignature, CsvColumnMapping mapping) {
    mapping.validate();
    return database
        .into(database.importMappings)
        .insertOnConflictUpdate(
          ImportMappingsCompanion.insert(
            headerSignature: headerSignature,
            dateColumn: mapping.dateColumn,
            descriptionColumn: mapping.descriptionColumn,
            amountColumn: Value(mapping.amountColumn),
            debitColumn: Value(mapping.debitColumn),
            creditColumn: Value(mapping.creditColumn),
            datePattern: mapping.datePattern,
            expensesAreNegative: Value(mapping.expensesAreNegative),
            updatedAt: _now().toUtc(),
          ),
        );
  }

  @override
  Future<StatementImportResult> commitImport({
    required String fileName,
    required String accountId,
    required StatementImportPreview preview,
  }) async {
    final importedRows = preview.rows.where((row) => !row.isDuplicate).toList();
    final importedAt = _now().toUtc();
    final batchId = 'import-${importedAt.microsecondsSinceEpoch}';

    await database.transaction(() async {
      await database
          .into(database.localAccounts)
          .insertOnConflictUpdate(
            LocalAccountsCompanion.insert(
              id: accountId,
              name: 'Imported chequing',
              institutionName: 'Statement import',
              mask: '----',
              accountType: AccountType.chequing.index,
              currentBalanceCents: 0,
              availableBalanceCents: 0,
            ),
          );
      await database
          .into(database.importBatches)
          .insert(
            ImportBatchesCompanion.insert(
              id: batchId,
              fileName: fileName,
              importedAt: importedAt,
              importedCount: importedRows.length,
              duplicateCount: preview.duplicateCount,
              rejectedCount: preview.rejectedCount,
            ),
          );
      await database.batch((batch) {
        for (var index = 0; index < importedRows.length; index++) {
          final row = importedRows[index];
          batch.insert(
            database.localTransactions,
            LocalTransactionsCompanion.insert(
              id: '$batchId-row-${index + 1}',
              accountId: accountId,
              transactionDate: row.date,
              description: row.description,
              amountCents: row.amount.cents,
              category: row.category.index,
              transactionStatus: TransactionStatus.posted.index,
              importFingerprint: Value(row.fingerprint),
              importBatchId: Value(batchId),
            ),
            mode: InsertMode.insertOrIgnore,
          );
        }
      });
    });

    return StatementImportResult(
      batchId: batchId,
      importedCount: importedRows.length,
      duplicateCount: preview.duplicateCount,
      rejectedCount: preview.rejectedCount,
    );
  }
}
