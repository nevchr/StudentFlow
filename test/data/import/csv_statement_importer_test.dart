import 'package:flutter_test/flutter_test.dart';
import 'package:student_flow/core/money.dart';
import 'package:student_flow/data/import/csv_statement_importer.dart';
import 'package:student_flow/data/import/statement_import_models.dart';
import 'package:student_flow/domain/models/financial_transaction.dart';

void main() {
  const importer = CsvStatementImporter();

  test('suggests Canadian statement columns and previews signed amounts', () {
    final document = importer.inspect('''
Date,Description,Amount
2026-09-01,September rent,-925.00
2026-09-04,Maple Cafe payroll,612.38
2026-09-01,September rent,-925.00
bad-date,Unexpected expense,-44.10
''');
    final mapping = importer.suggestMapping(document)!;

    expect(mapping.datePattern, 'yyyy-MM-dd');
    final preview = importer.preview(
      document: document,
      mapping: mapping,
      accountId: 'chequing',
    );

    expect(preview.importableCount, 2);
    expect(preview.duplicateCount, 1);
    expect(preview.rejectedCount, 1);
    expect(preview.rows[0].amount.cents, -92500);
    expect(preview.rows[0].category, TransactionCategory.rent);
    expect(preview.rows[1].amount.cents, 61238);
    expect(preview.rows[1].category, TransactionCategory.income);
  });

  test('parses separate debit and credit columns', () {
    final document = importer.inspect('''
Transaction Date,Details,Withdrawal,Deposit
12/09/2026,FreshCo,54.21,
13/09/2026,Campus payroll,,488.90
''');
    final mapping = importer.suggestMapping(document)!;

    expect(mapping.usesDebitAndCredit, isTrue);
    final preview = importer.preview(
      document: document,
      mapping: mapping,
      accountId: 'chequing',
    );

    expect(preview.errors, isEmpty);
    expect(preview.rows.map((row) => row.amount.cents), [-5421, 48890]);
    expect(preview.rows.first.category, TransactionCategory.groceries);
  });

  test('recognizes a transaction already imported', () {
    final document = importer.inspect('''
Date,Description,Amount
2026-09-12,OC Transpo,-128.75
''');
    final mapping = const CsvColumnMapping(
      dateColumn: 'Date',
      descriptionColumn: 'Description',
      amountColumn: 'Amount',
      datePattern: 'yyyy-MM-dd',
    );
    final fingerprint = importer.fingerprintFor(
      accountId: 'chequing',
      date: DateTime(2026, 9, 12),
      amount: const Money.fromCents(-12875),
      description: 'OC Transpo',
    );

    final preview = importer.preview(
      document: document,
      mapping: mapping,
      accountId: 'chequing',
      existingFingerprints: {fingerprint},
    );

    expect(preview.importableCount, 0);
    expect(preview.duplicateCount, 1);
  });
}
