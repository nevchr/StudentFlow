import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:csv/csv.dart';
import 'package:intl/intl.dart';
import 'package:student_flow/core/money.dart';
import 'package:student_flow/data/import/statement_import_models.dart';
import 'package:student_flow/domain/models/financial_transaction.dart';

final class CsvStatementImporter {
  const CsvStatementImporter();

  static const maxRows = 10000;
  static const maxCellLength = 2000;

  StatementDocument inspect(String contents) {
    final decoded = csv.decode(contents);
    if (decoded.isEmpty) {
      throw const FormatException('The statement is empty.');
    }
    if (decoded.length - 1 > maxRows) {
      throw const FormatException(
        'This statement has more than 10,000 rows. Split it into smaller files.',
      );
    }

    final headers = decoded.first
        .map((value) => value.toString().trim())
        .toList(growable: false);
    if (headers.isEmpty || headers.any((header) => header.isEmpty)) {
      throw const FormatException('Every statement column needs a heading.');
    }
    if (headers.map(_normalizeHeader).toSet().length != headers.length) {
      throw const FormatException('Statement column headings must be unique.');
    }

    final rows = <Map<String, String>>[];
    for (final decodedRow in decoded.skip(1)) {
      if (decodedRow.every((value) => value.toString().trim().isEmpty)) {
        continue;
      }
      final row = <String, String>{};
      for (var index = 0; index < headers.length; index++) {
        final value = index < decodedRow.length
            ? decodedRow[index].toString().trim()
            : '';
        if (value.length > maxCellLength) {
          throw FormatException(
            'A value in row ${rows.length + 2} is too long to import.',
          );
        }
        row[headers[index]] = value;
      }
      rows.add(row);
    }

    final normalizedHeaders = headers.map(_normalizeHeader).toList()..sort();
    final signature = sha256.convert(utf8.encode(normalizedHeaders.join('|')));
    return StatementDocument(
      headerSignature: signature.toString(),
      headers: headers,
      rows: rows,
    );
  }

  CsvColumnMapping? suggestMapping(StatementDocument document) {
    String? find(List<String> names) {
      for (final header in document.headers) {
        if (names.contains(_normalizeHeader(header))) return header;
      }
      return null;
    }

    final date = find(['date', 'transaction date', 'posted date']);
    final description = find([
      'description',
      'details',
      'merchant',
      'merchant name',
      'name',
    ]);
    final amount = find(['amount', 'transaction amount']);
    final debit = find(['debit', 'withdrawal', 'withdrawals']);
    final credit = find(['credit', 'deposit', 'deposits']);
    if (date == null || description == null) return null;
    if (amount == null && debit == null && credit == null) return null;

    return CsvColumnMapping(
      dateColumn: date,
      descriptionColumn: description,
      amountColumn: amount,
      debitColumn: amount == null ? debit : null,
      creditColumn: amount == null ? credit : null,
      datePattern: _suggestDatePattern(document.rows, date),
    );
  }

  StatementImportPreview preview({
    required StatementDocument document,
    required CsvColumnMapping mapping,
    required String accountId,
    Set<String> existingFingerprints = const {},
  }) {
    mapping.validate();
    final rows = <StatementImportRow>[];
    final errors = <StatementImportError>[];
    final seenFingerprints = <String>{...existingFingerprints};

    for (var index = 0; index < document.rows.length; index++) {
      final source = document.rows[index];
      final rowNumber = index + 2;
      try {
        final date = _parseDate(
          source[mapping.dateColumn] ?? '',
          mapping.datePattern,
        );
        final description = (source[mapping.descriptionColumn] ?? '').trim();
        if (description.isEmpty) {
          throw const FormatException('Description is empty.');
        }
        final amount = _parseAmount(source, mapping);
        if (amount == Money.zero) {
          throw const FormatException('Amount cannot be zero.');
        }
        final fingerprint = fingerprintFor(
          accountId: accountId,
          date: date,
          amount: amount,
          description: description,
        );
        final isDuplicate = !seenFingerprints.add(fingerprint);
        rows.add(
          StatementImportRow(
            rowNumber: rowNumber,
            date: date,
            description: description,
            amount: amount,
            category: _categorize(description, amount),
            fingerprint: fingerprint,
            isDuplicate: isDuplicate,
          ),
        );
      } on FormatException catch (error) {
        errors.add(
          StatementImportError(
            rowNumber: rowNumber,
            message: error.message.toString(),
          ),
        );
      }
    }

    return StatementImportPreview(rows: rows, errors: errors);
  }

  String fingerprintFor({
    required String accountId,
    required DateTime date,
    required Money amount,
    required String description,
  }) {
    final normalizedDescription = description
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]+'), ' ')
        .trim()
        .replaceAll(RegExp(r'\s+'), ' ');
    final datePart = DateFormat('yyyy-MM-dd').format(date);
    final canonical =
        '$accountId|$datePart|${amount.cents}|$normalizedDescription';
    return sha256.convert(utf8.encode(canonical)).toString();
  }

  DateTime _parseDate(String value, String pattern) {
    if (value.trim().isEmpty) {
      throw const FormatException('Date is empty.');
    }
    try {
      // The statement pattern determines the date order. Avoiding an explicit
      // locale keeps this pure service usable before Flutter starts.
      return DateFormat(pattern).parseStrict(value.trim());
    } on FormatException {
      throw FormatException('Date does not match $pattern.');
    }
  }

  Money _parseAmount(Map<String, String> row, CsvColumnMapping mapping) {
    if (mapping.amountColumn case final amountColumn?) {
      final amount = _parseDecimal(row[amountColumn] ?? '');
      return Money.fromDollars(mapping.expensesAreNegative ? amount : -amount);
    }

    final debit = _parseOptionalDecimal(
      mapping.debitColumn == null ? '' : row[mapping.debitColumn!] ?? '',
    );
    final credit = _parseOptionalDecimal(
      mapping.creditColumn == null ? '' : row[mapping.creditColumn!] ?? '',
    );
    if (debit != null && credit != null) {
      throw const FormatException('Both debit and credit have values.');
    }
    if (debit == null && credit == null) {
      throw const FormatException('Debit and credit are both empty.');
    }
    return Money.fromDollars(credit ?? -debit!);
  }

  num _parseDecimal(String value) {
    final parsed = _parseOptionalDecimal(value);
    if (parsed == null) throw const FormatException('Amount is empty.');
    return parsed;
  }

  num? _parseOptionalDecimal(String value) {
    var normalized = value.trim();
    if (normalized.isEmpty) return null;
    final parentheses = normalized.startsWith('(') && normalized.endsWith(')');
    normalized = normalized
        .replaceAll(RegExp('cad', caseSensitive: false), '')
        .replaceAll(r'$', '')
        .replaceAll(',', '')
        .replaceAll(' ', '')
        .replaceAll('(', '')
        .replaceAll(')', '');
    final parsed = num.tryParse(normalized);
    if (parsed == null) throw FormatException('Invalid amount: $value.');
    return parentheses ? -parsed : parsed;
  }

  String _suggestDatePattern(
    List<Map<String, String>> rows,
    String dateColumn,
  ) {
    final sample = rows
        .map((row) => row[dateColumn] ?? '')
        .firstWhere((value) => value.isNotEmpty, orElse: () => '');
    if (RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(sample)) return 'yyyy-MM-dd';
    if (RegExp(r'^\d{4}/\d{2}/\d{2}$').hasMatch(sample)) return 'yyyy/MM/dd';
    return 'dd/MM/yyyy';
  }

  TransactionCategory _categorize(String description, Money amount) {
    final value = description.toLowerCase();
    if (amount.isPositive &&
        (value.contains('payroll') || value.contains('pay cheque'))) {
      return TransactionCategory.income;
    }
    if (value.contains('rent')) return TransactionCategory.rent;
    if (value.contains('grocery') ||
        value.contains('metro') ||
        value.contains('freshco')) {
      return TransactionCategory.groceries;
    }
    if (value.contains('transit') || value.contains('presto')) {
      return TransactionCategory.transit;
    }
    if (value.contains('phone') || value.contains('mobile')) {
      return TransactionCategory.phone;
    }
    if (value.contains('tuition')) return TransactionCategory.tuitionSavings;
    if (value.contains('book') || value.contains('school')) {
      return TransactionCategory.schoolSupplies;
    }
    return TransactionCategory.other;
  }

  String _normalizeHeader(String value) =>
      value.toLowerCase().trim().replaceAll(RegExp(r'\s+'), ' ');
}
