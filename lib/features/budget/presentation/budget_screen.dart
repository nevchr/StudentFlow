import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:student_flow/app/providers.dart';
import 'package:student_flow/core/money.dart';
import 'package:student_flow/domain/models/budget.dart';
import 'package:student_flow/domain/models/finance_snapshot.dart';
import 'package:student_flow/domain/models/financial_transaction.dart';
import 'package:student_flow/domain/models/forecast.dart';
import 'package:student_flow/domain/models/income.dart';
import 'package:student_flow/domain/models/recurring_bill.dart';
import 'package:student_flow/shared/widgets/async_content.dart';
import 'package:student_flow/shared/widgets/page_frame.dart';

class BudgetScreen extends ConsumerStatefulWidget {
  const BudgetScreen({super.key});

  @override
  ConsumerState<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends ConsumerState<BudgetScreen> {
  BudgetPeriodKind _periodKind = BudgetPeriodKind.monthly;
  final _targetOverrides = <TransactionCategory, Money>{};
  Money? _lowBalanceThreshold;

  @override
  Widget build(BuildContext context) {
    final snapshot = ref.watch(financeSnapshotProvider);
    return PageFrame(
      title: 'Budget',
      subtitle: 'Compare monthly and payday-to-payday plans, with every estimate explained.',
      actions: [
        IconButton(
          tooltip: 'Adjust planning safeguards',
          onPressed: snapshot.hasValue
              ? () => _showSafeguards(snapshot.requireValue)
              : null,
          icon: const Icon(Icons.tune),
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
    _lowBalanceThreshold ??= snapshot.cashFlowForecast.lowBalanceThreshold;
    final referenceDate = _dateOnly(snapshot.cashFlowForecast.generatedAt);
    final periodStart = _periodKind == BudgetPeriodKind.monthly
        ? snapshot.budget.periodStart
        : referenceDate;
    final periodEnd = _periodKind == BudgetPeriodKind.monthly
        ? snapshot.budget.periodEnd
        : snapshot.incomeProfile.expectedNextPayday;
    final plan = ref
        .watch(budgetPeriodCalculatorProvider)
        .calculate(
          budget: snapshot.budget,
          transactions: snapshot.transactions,
          kind: _periodKind,
          periodStart: periodStart,
          periodEnd: periodEnd,
          targetOverrides: _targetOverrides,
        );
    final detectedBills = ref
        .watch(recurringBillDetectorProvider)
        .detect(snapshot.transactions, referenceDate: referenceDate);
    final forecast = _buildForecast(snapshot, plan, referenceDate);
    final lowestBalance = forecast.points
        .map((point) => point.balance.cents)
        .reduce((lowest, amount) => amount < lowest ? amount : lowest);
    final hasLowBalance = lowestBalance < _lowBalanceThreshold!.cents;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SegmentedButton<BudgetPeriodKind>(
          segments: [
            for (final kind in BudgetPeriodKind.values)
              ButtonSegment(value: kind, label: Text(kind.label)),
          ],
          selected: {_periodKind},
          onSelectionChanged: (selection) {
            setState(() => _periodKind = selection.single);
          },
        ),
        const SizedBox(height: 16),
        _periodSummary(plan),
        const SizedBox(height: 24),
        _sectionTitle('Category plan'),
        const SizedBox(height: 8),
        const Text(
          'Targets are adjustable planning amounts. Spending comes from synchronized or imported transactions.',
        ),
        const SizedBox(height: 12),
        for (final category in plan.categories) ...[
          _categoryCard(category, snapshot.budget),
          const SizedBox(height: 8),
        ],
        const SizedBox(height: 16),
        _sectionTitle('Recurring bills detected'),
        const SizedBox(height: 8),
        _detectedBillsCard(detectedBills),
        const SizedBox(height: 24),
        _sectionTitle('Forecasted balance timeline'),
        const SizedBox(height: 8),
        const Text(
          'Text summaries accompany every forecast point. Actual balances may differ when hours, bills, or pending transactions change.',
        ),
        const SizedBox(height: 12),
        _lowBalanceBanner(hasLowBalance, lowestBalance),
        const SizedBox(height: 12),
        _timelineCard(forecast),
      ],
    );
  }

  CashFlowForecast _buildForecast(
    FinanceSnapshot snapshot,
    BudgetPlan plan,
    DateTime referenceDate,
  ) {
    final events = <CashFlowEvent>[];
    for (final bill in snapshot.recurringBills) {
      if (bill.nextDueDate.isAfter(referenceDate) &&
          !bill.nextDueDate.isAfter(plan.periodEnd)) {
        events.add(
          CashFlowEvent(
            date: bill.nextDueDate,
            amount: -bill.amount,
            summary: '${bill.name} due',
            kind: CashFlowEventKind.bill,
            isEstimate: bill.isEstimate,
          ),
        );
      }
    }

    final forecasts = ref.watch(calculatedIncomeForecastsProvider);
    final expected = forecasts
        ?.where((forecast) => forecast.scenario == ForecastScenario.expected)
        .firstOrNull;
    final payday = snapshot.incomeProfile.expectedNextPayday;
    if (expected != null && !payday.isAfter(plan.periodEnd)) {
      events.add(
        CashFlowEvent(
          date: payday,
          amount: expected.amount,
          summary: 'Expected pay estimate',
          kind: CashFlowEventKind.income,
          isEstimate: true,
        ),
      );
    }

    final reservedVariables = plan.categories
        .where(
          (category) =>
              category.isEssential &&
              const {
                TransactionCategory.groceries,
                TransactionCategory.transit,
                TransactionCategory.schoolSupplies,
              }.contains(category.category),
        )
        .fold(Money.zero, (total, category) => total + category.remaining);
    if (reservedVariables.isPositive) {
      events.add(
        CashFlowEvent(
          date: plan.periodEnd,
          amount: -reservedVariables,
          summary: 'Reserved essential variable spending',
          kind: CashFlowEventKind.reservedSpending,
          isEstimate: true,
        ),
      );
    }

    return ref
        .watch(cashFlowForecasterProvider)
        .calculate(
          generatedAt: referenceDate,
          openingBalance: snapshot.accounts.first.availableBalance,
          lowBalanceThreshold: _lowBalanceThreshold!,
          events: events,
        );
  }

  Widget _periodSummary(BudgetPlan plan) {
    final date = DateFormat('d MMM yyyy', 'en_CA');
    return Semantics(
      container: true,
      label:
          '${plan.kind.label} budget from ${date.format(plan.periodStart)} to ${date.format(plan.periodEnd)}. '
          '${plan.totalSpent.formatCad()} spent of ${plan.totalTarget.formatCad()}. '
          '${plan.totalRemaining.formatCad()} remaining.',
      child: Card(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                plan.kind.label,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 4),
              Text(
                '${date.format(plan.periodStart)}–${date.format(plan.periodEnd)}',
              ),
              const SizedBox(height: 12),
              Text(
                '${plan.totalRemaining.formatCad()} remaining',
                style: Theme.of(context).textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 4),
              Text(
                '${plan.totalSpent.formatCad()} spent of ${plan.totalTarget.formatCad()} planned',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _categoryCard(BudgetCategoryProgress category, Budget monthlyBudget) {
    final status = category.isOverTarget
        ? '${(category.spent - category.target).formatCad()} over target'
        : '${category.remaining.formatCad()} remaining';
    return Semantics(
      container: true,
      label:
          '${category.category.label}. ${category.spent.formatCad()} spent of ${category.target.formatCad()}. $status. '
          '${category.isEssential ? 'Essential category.' : 'Flexible category.'}',
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    category.isOverTarget
                        ? Icons.warning_amber_outlined
                        : Icons.category_outlined,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          category.category.label,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(category.isEssential ? 'Essential' : 'Flexible'),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () => _editTarget(category, monthlyBudget),
                  child: const Text('Edit monthly target'),
                ),
              ),
              const SizedBox(height: 12),
              ExcludeSemantics(
                child: LinearProgressIndicator(value: category.progress),
              ),
              const SizedBox(height: 8),
              Text(
                '${category.spent.formatCad()} of ${category.target.formatCad()} · $status',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detectedBillsCard(List<DetectedRecurringBill> bills) {
    if (bills.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            'No repeated monthly payments were found yet. More transaction history may reveal patterns.',
          ),
        ),
      );
    }
    final date = DateFormat('d MMM yyyy', 'en_CA');
    return Card(
      child: Column(
        children: [
          for (var index = 0; index < bills.length; index++) ...[
            ListTile(
              leading: const Icon(Icons.repeat),
              title: Text(
                '${bills[index].name} · ${bills[index].typicalAmount.formatCad()}',
              ),
              subtitle: Text(
                '${bills[index].occurrenceCount} similar payments · about every '
                '${bills[index].typicalIntervalDays} days · next estimated '
                '${date.format(bills[index].nextEstimatedDate)}',
              ),
            ),
            if (index < bills.length - 1) const Divider(height: 1),
          ],
        ],
      ),
    );
  }

  Widget _lowBalanceBanner(bool hasLowBalance, int lowestBalanceCents) {
    final lowest = Money.fromCents(lowestBalanceCents);
    return Card(
      color: hasLowBalance
          ? Theme.of(context).colorScheme.errorContainer
          : Theme.of(context).colorScheme.secondaryContainer,
      child: ListTile(
        leading: Icon(
          hasLowBalance
              ? Icons.warning_amber_outlined
              : Icons.check_circle_outline,
        ),
        title: Text(
          hasLowBalance ? 'Low-balance warning' : 'Above your warning level',
        ),
        subtitle: Text(
          'Lowest forecast balance: ${lowest.formatCad()}. Warning level: ${_lowBalanceThreshold!.formatCad()}.',
        ),
      ),
    );
  }

  Widget _timelineCard(CashFlowForecast forecast) {
    final date = DateFormat('d MMM yyyy', 'en_CA');
    return Card(
      child: Column(
        children: [
          for (var index = 0; index < forecast.points.length; index++) ...[
            ListTile(
              leading: Icon(index == 0 ? Icons.flag_outlined : Icons.timeline),
              title: Text(forecast.points[index].balance.formatCad()),
              subtitle: Text(
                '${date.format(forecast.points[index].date)} · '
                '${forecast.points[index].summary}'
                '${forecast.points[index].isEstimate ? ' · Estimate' : ''}',
              ),
            ),
            if (index < forecast.points.length - 1) const Divider(height: 1),
          ],
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) => Semantics(
    header: true,
    child: Text(text, style: Theme.of(context).textTheme.titleLarge),
  );

  Future<void> _editTarget(
    BudgetCategoryProgress category,
    Budget monthlyBudget,
  ) async {
    final monthlyCategory = monthlyBudget.categories.singleWhere(
      (item) => item.category == category.category,
    );
    final monthlyTarget =
        _targetOverrides[category.category] ?? monthlyCategory.target;
    final controller = TextEditingController(
      text: (monthlyTarget.cents / 100).toStringAsFixed(2),
    );
    final result = await showDialog<Money>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('Edit monthly ${category.category.label} target'),
        content: TextField(
          controller: controller,
          autofocus: true,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            labelText: 'Target amount (CAD)',
            prefixText: r'$ ',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final value = _parseMoney(controller.text);
              if (value == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Enter zero or a positive dollar amount.'),
                  ),
                );
                return;
              }
              Navigator.pop(dialogContext, value);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
    controller.dispose();
    if (result != null && mounted) {
      setState(() => _targetOverrides[category.category] = result);
    }
  }

  Future<void> _showSafeguards(FinanceSnapshot snapshot) async {
    final assumptions = ref.read(safeToSpendAssumptionsProvider);
    final bufferController = TextEditingController(
      text: (assumptions.emergencyBuffer.cents / 100).toStringAsFixed(2),
    );
    final thresholdController = TextEditingController(
      text:
          ((_lowBalanceThreshold ??
                          snapshot.cashFlowForecast.lowBalanceThreshold)
                      .cents /
                  100)
              .toStringAsFixed(2),
    );
    final result = await showDialog<List<Money>>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Planning safeguards'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: bufferController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Emergency buffer target (CAD)',
                  prefixText: r'$ ',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: thresholdController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Low-balance warning level (CAD)',
                  prefixText: r'$ ',
                ),
              ),
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
              final buffer = _parseMoney(bufferController.text);
              final threshold = _parseMoney(thresholdController.text);
              if (buffer == null || threshold == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Enter zero or positive dollar amounts.'),
                  ),
                );
                return;
              }
              Navigator.pop(dialogContext, [buffer, threshold]);
            },
            child: const Text('Apply'),
          ),
        ],
      ),
    );
    bufferController.dispose();
    thresholdController.dispose();
    if (result == null || !mounted) return;
    ref
        .read(safeToSpendAssumptionsProvider.notifier)
        .update(
          reservedEssentialVariableSpending:
              assumptions.reservedEssentialVariableSpending,
          emergencyBuffer: result[0],
          safetyMargin: assumptions.safetyMargin,
        );
    setState(() => _lowBalanceThreshold = result[1]);
  }

  Money? _parseMoney(String value) {
    final amount = double.tryParse(value.trim().replaceAll(',', '.'));
    return amount == null || amount < 0 ? null : Money.fromDollars(amount);
  }

  DateTime _dateOnly(DateTime value) =>
      DateTime(value.year, value.month, value.day);
}
