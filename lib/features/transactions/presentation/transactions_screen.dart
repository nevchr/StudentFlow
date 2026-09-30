import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:student_flow/app/providers.dart';
import 'package:student_flow/core/money.dart';
import 'package:student_flow/data/import/statement_import_models.dart';
import 'package:student_flow/domain/models/finance_snapshot.dart';
import 'package:student_flow/domain/models/financial_transaction.dart';
import 'package:student_flow/features/transactions/application/statement_import_flow.dart';
import 'package:student_flow/shared/widgets/async_content.dart';
import 'package:student_flow/shared/widgets/page_frame.dart';

enum _StatusFilter { all, posted, pending }

class TransactionsScreen extends ConsumerStatefulWidget {
  const TransactionsScreen({super.key});

  @override
  ConsumerState<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends ConsumerState<TransactionsScreen> {
  String _query = '';
  _StatusFilter _status = _StatusFilter.all;

  @override
  Widget build(BuildContext context) {
    final snapshot = ref.watch(financeSnapshotProvider);
    return PageFrame(
      title: 'Transactions',
      subtitle: 'Search activity, import a statement, or correct categories.',
      actions: [
        IconButton(
          tooltip: 'Import CSV statement',
          onPressed: _importCsv,
          icon: const Icon(Icons.upload_file_outlined),
        ),
      ],
      child: snapshot.when(
        loading: () => const LoadingContent(),
        error: (error, stackTrace) => ErrorContent(
          onRetry: () => ref.invalidate(financeSnapshotProvider),
        ),
        data: _buildContent,
      ),
    );
  }

  Widget _buildContent(FinanceSnapshot snapshot) {
    final query = _query.trim().toLowerCase();
    final transactions = snapshot.transactions.where((transaction) {
      final matchesQuery =
          query.isEmpty ||
          transaction.description.toLowerCase().contains(query) ||
          transaction.category.label.toLowerCase().contains(query);
      final matchesStatus = switch (_status) {
        _StatusFilter.all => true,
        _StatusFilter.posted => transaction.status == TransactionStatus.posted,
        _StatusFilter.pending =>
          transaction.status == TransactionStatus.pending,
      };
      return matchesQuery && matchesStatus;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          color: Theme.of(context).colorScheme.secondaryContainer,
          child: const ListTile(
            leading: Icon(Icons.storage_outlined),
            title: Text('Local data is ready'),
            subtitle: Text(
              'Demo data and imported statements stay on this device. No bank is connected.',
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          onChanged: (value) => setState(() => _query = value),
          textInputAction: TextInputAction.search,
          decoration: const InputDecoration(
            labelText: 'Search transactions',
            hintText: 'Try groceries, payroll, or transit',
            prefixIcon: Icon(Icons.search),
          ),
        ),
        const SizedBox(height: 12),
        Semantics(
          label: 'Filter transaction status',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final status in _StatusFilter.values)
                ChoiceChip(
                  label: Text(_statusLabel(status)),
                  selected: _status == status,
                  onSelected: (_) => setState(() => _status = status),
                ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Semantics(
          liveRegion: true,
          child: Text(
            '${transactions.length} ${transactions.length == 1 ? 'transaction' : 'transactions'}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        const SizedBox(height: 8),
        if (transactions.isEmpty)
          const Card(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                'No transactions match these filters. Clear the search or choose All.',
              ),
            ),
          )
        else
          ...transactions.map(_transactionCard),
      ],
    );
  }

  Widget _transactionCard(FinancialTransaction transaction) {
    final category = transaction.category;
    final isIncome = transaction.amount.isPositive;
    final amountText =
        '${isIncome ? '+' : '−'}${(isIncome ? transaction.amount : -transaction.amount).formatCad()}';
    final date = DateFormat('d MMM yyyy', 'en_CA').format(transaction.date);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Semantics(
        container: true,
        label:
            '${transaction.description}, $amountText, $date, ${category.label}, ${transaction.status.name}',
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ExcludeSemantics(
                        child: Text(
                          transaction.description,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    ExcludeSemantics(
                      child: Text(
                        amountText,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ExcludeSemantics(
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(date),
                      if (transaction.status == TransactionStatus.pending)
                        const Chip(
                          avatar: Icon(Icons.schedule, size: 18),
                          label: Text('Pending'),
                        ),
                      if (transaction.isPossibleDuplicate)
                        const Chip(
                          avatar: Icon(Icons.copy_outlined, size: 18),
                          label: Text('Possible duplicate'),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    SizedBox(
                      height: 48,
                      child: ActionChip(
                        avatar: const Icon(Icons.edit_outlined, size: 18),
                        label: Text(category.label),
                        tooltip:
                            'Change category for ${transaction.description}',
                        onPressed: transaction.parentTransactionId == null
                            ? () => _changeCategory(transaction, category)
                            : null,
                      ),
                    ),
                    if (transaction.parentTransactionId == null)
                      SizedBox(
                        height: 48,
                        child: ActionChip(
                          avatar: const Icon(Icons.call_split, size: 18),
                          label: const Text('Split'),
                          tooltip: 'Split ${transaction.description}',
                          onPressed: () => _splitTransaction(transaction),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _importCsv() async {
    final result = await runCsvStatementImport(context, ref);
    if (!mounted || result == null) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Imported ${result.importedCount} transactions. '
          'Skipped ${result.duplicateCount} duplicates and '
          '${result.rejectedCount} invalid rows.',
        ),
      ),
    );
  }

  Future<void> _changeCategory(
    FinancialTransaction transaction,
    TransactionCategory current,
  ) async {
    var selected = current;
    final result = await showDialog<TransactionCategory>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Change category'),
          content: DropdownButtonFormField<TransactionCategory>(
            initialValue: selected,
            isExpanded: true,
            decoration: const InputDecoration(labelText: 'Category'),
            items: [
              for (final category in TransactionCategory.values)
                DropdownMenuItem(value: category, child: Text(category.label)),
            ],
            onChanged: (value) {
              if (value != null) setDialogState(() => selected = value);
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext, selected),
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
    if (result == null) return;
    final store = await ref.read(localFinanceStoreProvider.future);
    await store.saveCategoryCorrection(transaction.id, result);
    ref.invalidate(financeSnapshotProvider);
  }

  Future<void> _splitTransaction(FinancialTransaction transaction) async {
    final result = await showDialog<List<TransactionSplitDraft>>(
      context: context,
      builder: (context) => _SplitTransactionDialog(transaction: transaction),
    );
    if (result == null || !mounted) return;
    try {
      final store = await ref.read(localFinanceStoreProvider.future);
      await store.saveTransactionSplits(
        parentTransactionId: transaction.id,
        originalAmount: transaction.amount,
        splits: result,
      );
      ref.invalidate(financeSnapshotProvider);
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Transaction split saved.')));
    } on FormatException catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.message)));
    }
  }

  String _statusLabel(_StatusFilter status) => switch (status) {
    _StatusFilter.all => 'All',
    _StatusFilter.posted => 'Posted',
    _StatusFilter.pending => 'Pending',
  };
}

class _SplitTransactionDialog extends StatefulWidget {
  const _SplitTransactionDialog({required this.transaction});

  final FinancialTransaction transaction;

  @override
  State<_SplitTransactionDialog> createState() =>
      _SplitTransactionDialogState();
}

class _SplitTransactionDialogState extends State<_SplitTransactionDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _firstAmount;
  late final TextEditingController _secondAmount;
  late TransactionCategory _firstCategory;
  late TransactionCategory _secondCategory;

  @override
  void initState() {
    super.initState();
    final absoluteCents = widget.transaction.amount.cents.abs();
    final firstCents = absoluteCents ~/ 2;
    _firstAmount = TextEditingController(text: _dollars(firstCents));
    _secondAmount = TextEditingController(
      text: _dollars(absoluteCents - firstCents),
    );
    _firstCategory = widget.transaction.category;
    _secondCategory = widget.transaction.category;
  }

  @override
  void dispose() {
    _firstAmount.dispose();
    _secondAmount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Split transaction'),
      content: SizedBox(
        width: 440,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'The parts must total ${widget.transaction.amount.formatCad()}.',
              ),
              const SizedBox(height: 16),
              _partFields(
                label: 'First part',
                controller: _firstAmount,
                category: _firstCategory,
                onCategoryChanged: (value) =>
                    setState(() => _firstCategory = value),
              ),
              const SizedBox(height: 16),
              _partFields(
                label: 'Second part',
                controller: _secondAmount,
                category: _secondCategory,
                onCategoryChanged: (value) =>
                    setState(() => _secondCategory = value),
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
        FilledButton(onPressed: _save, child: const Text('Save split')),
      ],
    );
  }

  Widget _partFields({
    required String label,
    required TextEditingController controller,
    required TransactionCategory category,
    required ValueChanged<TransactionCategory> onCategoryChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(label, style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            labelText: 'Amount',
            prefixText: r'$ ',
          ),
          validator: (value) => _parseCents(value) == null
              ? 'Enter an amount greater than zero, such as 12.50.'
              : null,
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<TransactionCategory>(
          initialValue: category,
          isExpanded: true,
          decoration: const InputDecoration(labelText: 'Category'),
          items: [
            for (final item in TransactionCategory.values)
              DropdownMenuItem(value: item, child: Text(item.label)),
          ],
          onChanged: (value) {
            if (value != null) onCategoryChanged(value);
          },
        ),
      ],
    );
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    final firstCents = _parseCents(_firstAmount.text)!;
    final secondCents = _parseCents(_secondAmount.text)!;
    final expected = widget.transaction.amount.cents.abs();
    if (firstCents + secondCents != expected) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'The parts total ${Money.fromCents(firstCents + secondCents).formatCad()}, '
            'but must total ${Money.fromCents(expected).formatCad()}.',
          ),
        ),
      );
      return;
    }
    final sign = widget.transaction.amount.isNegative ? -1 : 1;
    Navigator.pop(context, [
      TransactionSplitDraft(
        description: '${widget.transaction.description} - part 1',
        amount: Money.fromCents(firstCents * sign),
        category: _firstCategory,
      ),
      TransactionSplitDraft(
        description: '${widget.transaction.description} - part 2',
        amount: Money.fromCents(secondCents * sign),
        category: _secondCategory,
      ),
    ]);
  }

  static int? _parseCents(String? value) {
    if (value == null) return null;
    final amount = double.tryParse(value.trim().replaceAll(',', ''));
    if (amount == null || amount <= 0) return null;
    return (amount * 100).round();
  }

  static String _dollars(int cents) => (cents / 100).toStringAsFixed(2);
}
