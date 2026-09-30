import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:student_flow/app/providers.dart';
import 'package:student_flow/data/import/statement_import_models.dart';
import 'package:student_flow/domain/models/financial_transaction.dart';

const _maxImportBytes = 5 * 1024 * 1024;
const _importAccountId = 'imported-chequing';

Future<StatementImportResult?> runCsvStatementImport(
  BuildContext context,
  WidgetRef ref,
) async {
  try {
    final file = await FilePicker.pickFile(
      type: FileType.custom,
      allowedExtensions: const ['csv'],
    );
    if (file == null) return null;
    final bytes = await _readBytes(file);
    if (bytes.length > _maxImportBytes) {
      throw const FormatException(
        'This file is larger than 5 MB. Split it into smaller statements.',
      );
    }

    final contents = utf8.decode(bytes, allowMalformed: false);
    final importer = ref.read(csvStatementImporterProvider);
    final document = importer.inspect(contents);
    final store = await ref.read(localFinanceStoreProvider.future);
    final remembered = await store.loadMapping(document.headerSignature);
    final suggested = remembered ?? importer.suggestMapping(document);
    if (!context.mounted) return null;

    final mapping = await showDialog<CsvColumnMapping>(
      context: context,
      builder: (context) => _MappingDialog(
        document: document,
        initial: suggested,
        wasRemembered: remembered != null,
      ),
    );
    if (mapping == null) return null;

    final existing = await store.loadImportFingerprints();
    final preview = importer.preview(
      document: document,
      mapping: mapping,
      accountId: _importAccountId,
      existingFingerprints: existing,
    );
    if (!context.mounted) return null;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => _PreviewDialog(preview: preview),
    );
    if (confirmed != true) return null;

    await store.saveMapping(document.headerSignature, mapping);
    final result = await store.commitImport(
      fileName: file.name,
      accountId: _importAccountId,
      preview: preview,
    );
    ref.invalidate(financeSnapshotProvider);
    return result;
  } on FormatException catch (error) {
    if (context.mounted) {
      _showError(context, error.message.toString());
    }
    return null;
  } catch (_) {
    if (context.mounted) {
      _showError(
        context,
        'The statement could not be imported. Check that it is a UTF-8 CSV file and try again.',
      );
    }
    return null;
  }
}

Future<Uint8List> _readBytes(PlatformFile file) async {
  return file.readAsBytes();
}

void _showError(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text('$message No data was imported.')));
}

enum _AmountMode { signed, debitAndCredit }

class _MappingDialog extends StatefulWidget {
  const _MappingDialog({
    required this.document,
    required this.initial,
    required this.wasRemembered,
  });

  final StatementDocument document;
  final CsvColumnMapping? initial;
  final bool wasRemembered;

  @override
  State<_MappingDialog> createState() => _MappingDialogState();
}

class _MappingDialogState extends State<_MappingDialog> {
  late String _dateColumn;
  late String _descriptionColumn;
  late String _amountColumn;
  late String _debitColumn;
  late String _creditColumn;
  late String _datePattern;
  late bool _expensesAreNegative;
  late _AmountMode _amountMode;

  @override
  void initState() {
    super.initState();
    final headers = widget.document.headers;
    final initial = widget.initial;
    _dateColumn = initial?.dateColumn ?? headers.first;
    _descriptionColumn =
        initial?.descriptionColumn ??
        (headers.length > 1 ? headers[1] : headers.first);
    _amountColumn = initial?.amountColumn ?? headers.last;
    _debitColumn = initial?.debitColumn ?? headers.last;
    _creditColumn = initial?.creditColumn ?? headers.last;
    _datePattern = initial?.datePattern ?? 'dd/MM/yyyy';
    _expensesAreNegative = initial?.expensesAreNegative ?? true;
    _amountMode = initial?.usesDebitAndCredit == true
        ? _AmountMode.debitAndCredit
        : _AmountMode.signed;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Match statement columns'),
      content: SizedBox(
        width: 520,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.wasRemembered
                    ? 'StudentFlow remembered this layout. Review it before importing.'
                    : 'Choose what each column means. This mapping will be remembered for matching statements.',
              ),
              const SizedBox(height: 16),
              _columnDropdown(
                label: 'Transaction date',
                value: _dateColumn,
                onChanged: (value) => setState(() => _dateColumn = value),
              ),
              const SizedBox(height: 12),
              _columnDropdown(
                label: 'Description or merchant',
                value: _descriptionColumn,
                onChanged: (value) =>
                    setState(() => _descriptionColumn = value),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<_AmountMode>(
                initialValue: _amountMode,
                decoration: const InputDecoration(labelText: 'Amount layout'),
                items: const [
                  DropdownMenuItem(
                    value: _AmountMode.signed,
                    child: Text('One amount column'),
                  ),
                  DropdownMenuItem(
                    value: _AmountMode.debitAndCredit,
                    child: Text('Separate debit and credit columns'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) setState(() => _amountMode = value);
                },
              ),
              const SizedBox(height: 12),
              if (_amountMode == _AmountMode.signed) ...[
                _columnDropdown(
                  label: 'Amount',
                  value: _amountColumn,
                  onChanged: (value) => setState(() => _amountColumn = value),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Expenses use negative numbers'),
                  subtitle: const Text(
                    'Turn this off if withdrawals are positive in this statement.',
                  ),
                  value: _expensesAreNegative,
                  onChanged: (value) =>
                      setState(() => _expensesAreNegative = value),
                ),
              ] else ...[
                _columnDropdown(
                  label: 'Debit or withdrawal',
                  value: _debitColumn,
                  onChanged: (value) => setState(() => _debitColumn = value),
                ),
                const SizedBox(height: 12),
                _columnDropdown(
                  label: 'Credit or deposit',
                  value: _creditColumn,
                  onChanged: (value) => setState(() => _creditColumn = value),
                ),
              ],
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: _datePattern,
                decoration: const InputDecoration(labelText: 'Date format'),
                items: const [
                  DropdownMenuItem(
                    value: 'yyyy-MM-dd',
                    child: Text('YYYY-MM-DD'),
                  ),
                  DropdownMenuItem(
                    value: 'dd/MM/yyyy',
                    child: Text('DD/MM/YYYY'),
                  ),
                  DropdownMenuItem(
                    value: 'MM/dd/yyyy',
                    child: Text('MM/DD/YYYY'),
                  ),
                  DropdownMenuItem(
                    value: 'yyyy/MM/dd',
                    child: Text('YYYY/MM/DD'),
                  ),
                  DropdownMenuItem(
                    value: 'd MMM yyyy',
                    child: Text('D Mon YYYY'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) setState(() => _datePattern = value);
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(
            context,
            CsvColumnMapping(
              dateColumn: _dateColumn,
              descriptionColumn: _descriptionColumn,
              datePattern: _datePattern,
              amountColumn: _amountMode == _AmountMode.signed
                  ? _amountColumn
                  : null,
              debitColumn: _amountMode == _AmountMode.debitAndCredit
                  ? _debitColumn
                  : null,
              creditColumn: _amountMode == _AmountMode.debitAndCredit
                  ? _creditColumn
                  : null,
              expensesAreNegative: _expensesAreNegative,
            ),
          ),
          child: const Text('Preview'),
        ),
      ],
    );
  }

  Widget _columnDropdown({
    required String label,
    required String value,
    required ValueChanged<String> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      isExpanded: true,
      decoration: InputDecoration(labelText: label),
      items: [
        for (final header in widget.document.headers)
          DropdownMenuItem(value: header, child: Text(header)),
      ],
      onChanged: (value) {
        if (value != null) onChanged(value);
      },
    );
  }
}

class _PreviewDialog extends StatelessWidget {
  const _PreviewDialog({required this.preview});

  final StatementImportPreview preview;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('d MMM yyyy', 'en_CA');
    return AlertDialog(
      title: const Text('Review statement import'),
      content: SizedBox(
        width: 640,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  Chip(label: Text('${preview.importableCount} ready')),
                  Chip(
                    label: Text('${preview.duplicateCount} duplicates skipped'),
                  ),
                  Chip(
                    label: Text('${preview.rejectedCount} rows need attention'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'Nothing is saved until you choose Import. Duplicate rows are skipped.',
              ),
              const SizedBox(height: 12),
              for (final row in preview.rows.take(8))
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    row.isDuplicate
                        ? Icons.copy_outlined
                        : Icons.check_circle_outline,
                  ),
                  title: Text(row.description),
                  subtitle: Text(
                    '${dateFormat.format(row.date)} · ${row.category.label}'
                    '${row.isDuplicate ? ' · Duplicate, skipped' : ''}',
                  ),
                  trailing: Text(row.amount.formatCad()),
                ),
              if (preview.errors.isNotEmpty) ...[
                const Divider(),
                Text(
                  'Rows needing attention',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                for (final error in preview.errors.take(5))
                  Text('Row ${error.rowNumber}: ${error.message}'),
              ],
              if (preview.rows.length > 8)
                Text(
                  '${preview.rows.length - 8} more parsed rows are not shown.',
                ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Back'),
        ),
        FilledButton(
          onPressed: preview.importableCount == 0
              ? null
              : () => Navigator.pop(context, true),
          child: Text('Import ${preview.importableCount}'),
        ),
      ],
    );
  }
}
