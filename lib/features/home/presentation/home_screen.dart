import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:student_flow/app/providers.dart';
import 'package:student_flow/core/money.dart';
import 'package:student_flow/domain/models/finance_snapshot.dart';
import 'package:student_flow/domain/services/safe_to_spend_calculator.dart';
import 'package:student_flow/shared/widgets/async_content.dart';
import 'package:student_flow/shared/widgets/page_frame.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snapshot = ref.watch(financeSnapshotProvider);

    return PageFrame(
      title: 'Home',
      subtitle: 'A clear view of what is available before your next pay.',
      actions: [
        IconButton(
          tooltip: 'Refresh financial data',
          onPressed: () => ref.invalidate(financeSnapshotProvider),
          icon: const Icon(Icons.sync),
        ),
      ],
      child: snapshot.when(
        loading: () => const LoadingContent(),
        error: (error, stackTrace) => ErrorContent(
          onRetry: () => ref.invalidate(financeSnapshotProvider),
        ),
        data: (data) => _HomeContent(snapshot: data),
      ),
    );
  }
}

class _HomeContent extends ConsumerWidget {
  const _HomeContent({required this.snapshot});

  final FinanceSnapshot snapshot;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final safeToSpend = ref.watch(safeToSpendProvider);
    final dateFormat = DateFormat('d MMM yyyy', 'en_CA');
    final weekStart = DateTime(2026, 9, 7);
    final weekEnd = DateTime(2026, 9, 14);
    final weekSpending = snapshot.transactions
        .where(
          (transaction) =>
              !transaction.amount.isPositive &&
              !transaction.date.isBefore(weekStart) &&
              transaction.date.isBefore(weekEnd),
        )
        .fold(Money.zero, (total, item) => total + (-item.amount));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (snapshot.isDemoData) ...[
          const _DemoBanner(),
          const SizedBox(height: 16),
        ],
        _SafeToSpendCard(
          result: safeToSpend,
          payday: snapshot.incomeProfile.expectedNextPayday,
          paydayIsEstimate: snapshot.incomeProfile.nextPaydayIsEstimate,
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            final wide = constraints.maxWidth >= 680;
            final cards = [
              _SummaryCard(
                icon: Icons.account_balance_outlined,
                label: 'Available chequing balance',
                value: snapshot.accounts.first.availableBalance.formatCad(),
                detail: 'Account ending ${snapshot.accounts.first.mask}',
              ),
              _SummaryCard(
                icon: Icons.shopping_bag_outlined,
                label: "This week's spending",
                value: weekSpending.formatCad(),
                detail: '7–12 Sep 2026',
              ),
            ];
            if (!wide) {
              return Column(
                children: [cards.first, const SizedBox(height: 16), cards.last],
              );
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: cards.first),
                const SizedBox(width: 16),
                Expanded(child: cards.last),
              ],
            );
          },
        ),
        const SizedBox(height: 24),
        Semantics(
          header: true,
          child: Text(
            'Upcoming bills',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const SizedBox(height: 8),
        Card(
          child: Column(
            children: [
              for (
                var index = 0;
                index < snapshot.recurringBills.length;
                index++
              ) ...[
                ListTile(
                  leading: const Icon(Icons.event_outlined),
                  title: Text(snapshot.recurringBills[index].name),
                  subtitle: Text(
                    '${dateFormat.format(snapshot.recurringBills[index].nextDueDate)}'
                    '${snapshot.recurringBills[index].isEstimate ? ' · Estimated' : ''}',
                  ),
                  trailing: Text(
                    snapshot.recurringBills[index].amount.formatCad(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                if (index < snapshot.recurringBills.length - 1)
                  const Divider(height: 1),
              ],
            ],
          ),
        ),
        const SizedBox(height: 24),
        Card(
          color: Theme.of(context).colorScheme.secondaryContainer,
          child: const Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'You have room for flexible spending, based on the current demo assumptions. Your next pay and forecast are estimates, so leave extra room when shifts change.',
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _DemoBanner extends StatelessWidget {
  const _DemoBanner();

  @override
  Widget build(BuildContext context) => Card(
    color: Theme.of(context).colorScheme.tertiaryContainer,
    child: const ListTile(
      leading: Icon(Icons.science_outlined),
      title: Text('Demo data'),
      subtitle: Text(
        'These are fictional Canadian accounts and transactions. No bank is connected.',
      ),
    ),
  );
}

class _SafeToSpendCard extends ConsumerWidget {
  const _SafeToSpendCard({
    required this.result,
    required this.payday,
    required this.paydayIsEstimate,
  });

  final SafeToSpendResult? result;
  final DateTime payday;
  final bool paydayIsEstimate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (result == null) return const SizedBox.shrink();
    final date = DateFormat('d MMM yyyy', 'en_CA').format(payday);
    final input = result!.input;

    return Semantics(
      container: true,
      label:
          'Safe to spend until the next estimated payday: ${result!.spendable.formatCad()}',
      child: Card(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Safe to spend until next payday',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              ExcludeSemantics(
                child: Text(
                  result!.spendable.formatCad(),
                  style: Theme.of(context).textTheme.displaySmall
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${paydayIsEstimate ? 'Estimated payday' : 'Payday'}: $date',
              ),
              const SizedBox(height: 8),
              const Text(
                'Estimate only — not a guarantee or professional financial advice.',
              ),
              const SizedBox(height: 8),
              ExpansionTile(
                tilePadding: EdgeInsets.zero,
                childrenPadding: EdgeInsets.zero,
                title: const Text('How this was calculated'),
                children: [
                  _BreakdownRow(
                    'Available balance',
                    input.currentAvailableBalance,
                  ),
                  _BreakdownRow(
                    'Conservative expected pay',
                    input.conservativeExpectedIncome,
                    add: true,
                  ),
                  _BreakdownRow(
                    'Essential bills before payday',
                    input.upcomingEssentialBills,
                  ),
                  _BreakdownRow(
                    'Reserved groceries and essentials',
                    input.reservedEssentialVariableSpending,
                  ),
                  _BreakdownRow('Emergency buffer', input.emergencyBuffer),
                  _BreakdownRow('Safety margin', input.safetyMargin),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: OutlinedButton.icon(
                      onPressed: () => _showAssumptions(context, ref, input),
                      icon: const Icon(Icons.tune),
                      label: const Text('Adjust assumptions'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showAssumptions(
    BuildContext context,
    WidgetRef ref,
    SafeToSpendInput input,
  ) async {
    final reserved = TextEditingController(
      text: (input.reservedEssentialVariableSpending.cents / 100)
          .toStringAsFixed(2),
    );
    final buffer = TextEditingController(
      text: (input.emergencyBuffer.cents / 100).toStringAsFixed(2),
    );
    final margin = TextEditingController(
      text: (input.safetyMargin.cents / 100).toStringAsFixed(2),
    );

    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Adjust safe-to-spend assumptions'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _MoneyField(
                controller: reserved,
                label: 'Reserved essentials (CAD)',
              ),
              const SizedBox(height: 16),
              _MoneyField(controller: buffer, label: 'Emergency buffer (CAD)'),
              const SizedBox(height: 16),
              _MoneyField(controller: margin, label: 'Safety margin (CAD)'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final values = [reserved.text, buffer.text, margin.text]
                  .map((value) => double.tryParse(value.replaceAll(',', '.')))
                  .toList();
              if (values.any((value) => value == null || value < 0)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Enter zero or a positive dollar amount.'),
                  ),
                );
                return;
              }
              ref
                  .read(safeToSpendAssumptionsProvider.notifier)
                  .update(
                    reservedEssentialVariableSpending: Money.fromDollars(
                      values[0]!,
                    ),
                    emergencyBuffer: Money.fromDollars(values[1]!),
                    safetyMargin: Money.fromDollars(values[2]!),
                  );
              Navigator.pop(dialogContext);
            },
            child: const Text('Apply'),
          ),
        ],
      ),
    );
    reserved.dispose();
    buffer.dispose();
    margin.dispose();
  }
}

class _MoneyField extends StatelessWidget {
  const _MoneyField({required this.controller, required this.label});

  final TextEditingController controller;
  final String label;

  @override
  Widget build(BuildContext context) => TextField(
    controller: controller,
    keyboardType: const TextInputType.numberWithOptions(decimal: true),
    decoration: InputDecoration(labelText: label, prefixText: r'$ '),
  );
}

class _BreakdownRow extends StatelessWidget {
  const _BreakdownRow(this.label, this.amount, {this.add = false});

  final String label;
  final Money amount;
  final bool add;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      children: [
        Expanded(child: Text(label)),
        const SizedBox(width: 12),
        Text('${add ? '+' : '−'} ${amount.formatCad()}'),
      ],
    ),
  );
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.detail,
  });

  final IconData icon;
  final String label;
  final String value;
  final String detail;

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label),
                const SizedBox(height: 4),
                Text(value, style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 4),
                Text(detail),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
