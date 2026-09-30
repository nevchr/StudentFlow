import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:student_flow/data/local/database_key_store.dart';

part 'app_database.g.dart';

@DataClassName('LocalAccountRow')
class LocalAccounts extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get institutionName => text()();
  TextColumn get mask => text()();
  IntColumn get accountType => integer()();
  IntColumn get currentBalanceCents => integer()();
  IntColumn get availableBalanceCents => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('LocalTransactionRow')
class LocalTransactions extends Table {
  TextColumn get id => text()();
  TextColumn get accountId => text().references(LocalAccounts, #id)();
  DateTimeColumn get transactionDate => dateTime()();
  TextColumn get description => text()();
  IntColumn get amountCents => integer()();
  IntColumn get category => integer()();
  IntColumn get transactionStatus => integer()();
  TextColumn get merchantName => text().nullable()();
  TextColumn get providerTransactionId => text().nullable().unique()();
  TextColumn get parentTransactionId => text().nullable()();
  BoolColumn get isPossibleDuplicate =>
      boolean().withDefault(const Constant(false))();
  TextColumn get importFingerprint => text().nullable().unique()();
  TextColumn get importBatchId => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('CategoryCorrectionRow')
class CategoryCorrections extends Table {
  TextColumn get transactionId => text()();
  IntColumn get category => integer()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {transactionId};
}

@DataClassName('TransactionSplitRow')
class TransactionSplits extends Table {
  TextColumn get id => text()();
  TextColumn get parentTransactionId => text()();
  TextColumn get description => text()();
  IntColumn get amountCents => integer()();
  IntColumn get category => integer()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('ImportMappingRow')
class ImportMappings extends Table {
  TextColumn get headerSignature => text()();
  TextColumn get dateColumn => text()();
  TextColumn get descriptionColumn => text()();
  TextColumn get amountColumn => text().nullable()();
  TextColumn get debitColumn => text().nullable()();
  TextColumn get creditColumn => text().nullable()();
  TextColumn get datePattern => text()();
  BoolColumn get expensesAreNegative =>
      boolean().withDefault(const Constant(true))();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {headerSignature};
}

@DataClassName('ImportBatchRow')
class ImportBatches extends Table {
  TextColumn get id => text()();
  TextColumn get fileName => text()();
  DateTimeColumn get importedAt => dateTime()();
  IntColumn get importedCount => integer()();
  IntColumn get duplicateCount => integer()();
  IntColumn get rejectedCount => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DriftDatabase(
  tables: [
    LocalAccounts,
    LocalTransactions,
    CategoryCorrections,
    TransactionSplits,
    ImportMappings,
    ImportBatches,
  ],
)
final class StudentFlowDatabase extends _$StudentFlowDatabase {
  StudentFlowDatabase(super.executor);

  static Future<StudentFlowDatabase> openEncrypted(
    DatabaseKeyStore keyStore,
  ) async {
    final key = await keyStore.getOrCreateKey();
    final supportDirectory = await getApplicationSupportDirectory();
    final file = File(path.join(supportDirectory.path, 'studentflow.sqlite'));
    return StudentFlowDatabase(_openEncrypted(file, key));
  }

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
      await customStatement('PRAGMA secure_delete = ON');
    },
  );
}

QueryExecutor _openEncrypted(File file, String key) {
  return NativeDatabase.createInBackground(
    file,
    setup: (rawDatabase) {
      final cipher = rawDatabase.select('PRAGMA cipher;');
      if (cipher.isEmpty) {
        throw StateError(
          'Encrypted SQLite is unavailable. Refusing to open financial data.',
        );
      }

      final escapedKey = key.replaceAll("'", "''");
      rawDatabase.execute("PRAGMA key = '$escapedKey';");
      rawDatabase.execute('SELECT count(*) FROM sqlite_master;');
      rawDatabase.execute('PRAGMA foreign_keys = ON;');
      rawDatabase.execute('PRAGMA secure_delete = ON;');
    },
  );
}
