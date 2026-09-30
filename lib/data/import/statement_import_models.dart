import 'package:student_flow/core/money.dart';
import 'package:student_flow/domain/models/financial_transaction.dart';

final class CsvColumnMapping {
  const CsvColumnMapping({
    required this.dateColumn,
    required this.descriptionColumn,
    required this.datePattern,
    this.amountColumn,
    this.debitColumn,
    this.creditColumn,
    this.expensesAreNegative = true,
  });

  final String dateColumn;
  final String descriptionColumn;
  final String? amountColumn;
  final String? debitColumn;
  final String? creditColumn;
  final String datePattern;
  final bool expensesAreNegative;

  bool get usesSignedAmount => amountColumn != null;
  bool get usesDebitAndCredit => debitColumn != null || creditColumn != null;

  void validate() {
    if (dateColumn.isEmpty || descriptionColumn.isEmpty) {
      throw const FormatException('Choose date and description columns.');
    }
    if (usesSignedAmount == usesDebitAndCredit) {
      throw const FormatException(
        'Choose one amount column or separate debit and credit columns.',
      );
    }
  }
}

final class StatementDocument {
  const StatementDocument({
    required this.headerSignature,
    required this.headers,
    required this.rows,
  });

  final String headerSignature;
  final List<String> headers;
  final List<Map<String, String>> rows;
}

final class StatementImportRow {
  const StatementImportRow({
    required this.rowNumber,
    required this.date,
    required this.description,
    required this.amount,
    required this.category,
    required this.fingerprint,
    required this.isDuplicate,
  });

  final int rowNumber;
  final DateTime date;
  final String description;
  final Money amount;
  final TransactionCategory category;
  final String fingerprint;
  final bool isDuplicate;
}

final class StatementImportError {
  const StatementImportError({required this.rowNumber, required this.message});

  final int rowNumber;
  final String message;
}

final class StatementImportPreview {
  const StatementImportPreview({required this.rows, required this.errors});

  final List<StatementImportRow> rows;
  final List<StatementImportError> errors;

  int get importableCount => rows.where((row) => !row.isDuplicate).length;
  int get duplicateCount => rows.where((row) => row.isDuplicate).length;
  int get rejectedCount => errors.length;
}

final class StatementImportResult {
  const StatementImportResult({
    required this.batchId,
    required this.importedCount,
    required this.duplicateCount,
    required this.rejectedCount,
  });

  final String batchId;
  final int importedCount;
  final int duplicateCount;
  final int rejectedCount;
}

final class TransactionSplitDraft {
  const TransactionSplitDraft({
    required this.description,
    required this.amount,
    required this.category,
  });

  final String description;
  final Money amount;
  final TransactionCategory category;
}
