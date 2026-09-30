import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:student_flow/app/providers.dart';
import 'package:student_flow/core/money.dart';
import 'package:student_flow/domain/models/finance_snapshot.dart';
import 'package:student_flow/domain/models/income.dart';
import 'package:student_flow/shared/widgets/async_content.dart';
import 'package:student_flow/shared/widgets/page_frame.dart';

class IncomeScreen extends ConsumerStatefulWidget {
  const IncomeScreen({super.key});

  @override
  ConsumerState<IncomeScreen> createState() => _IncomeScreenState();
}

class _IncomeScreenState extends ConsumerState<IncomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _wageController = TextEditingController();
  final _hoursController = TextEditingController();
  final _confirmedTransactionIds = <String>{};
  bool _initialized = false;

  @override
  void dispose() {
    _wageController.dispose();
    _hoursController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final snapshot = ref.watch(financeSnapshotProvider);
    return PageFrame(
      title: 'Income',
      subtitle: 'Plan around changing shifts and confirm which deposits are paycheques.',
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
    final assumptions = ref.watch(incomePlanningAssumptionsProvider);
    if (!_initialized) {
      _initialized = true;
      _wageController.text = (assumptions.hourlyWage.cents / 100)
          .toStringAsFixed(2);
      _hoursController.text = assumptions.expectedWeeklyHours.toString();
      _confirmedTransactionIds.addAll(
        snapshot.incomeProfile.recentPayDeposits
            .where((deposit) => deposit.isConfirmed)
            .map((deposit) => deposit.transactionId),
      );
    }

    final detector = ref.watch(payrollDetectorProvider);
    final candidates = detector.detect(
      transactions: snapshot.transactions,
      confirmedTransactionIds: _confirmedTransactionIds,
    );
    final pattern = detector.learnPattern(
      candidates: candidates,
      referenceDate: snapshot.cashFlowForecast.generatedAt,
    );
    final forecasts =
        ref.watch(calculatedIncomeForecastsProvider) ??
        const <IncomeForecast>[];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _statusCard(pattern),
        const SizedBox(height: 16),
        _assumptionsCard(assumptions),
        const SizedBox(height: 24),
        _sectionTitle('Estimated next pay'),
        const SizedBox(height: 8),
        const Text(
          'These scenarios are planning estimates, not guarantees or tax calculations.',
        ),
        const SizedBox(height: 12),
        _forecastCards(forecasts),
        const SizedBox(height: 24),
        _sectionTitle('Possible paycheques'),
        const SizedBox(height: 8),
        const Text(
          'Confirming deposits helps StudentFlow learn the employer, amount range, and payday pattern. No employer is contacted.',
        ),
        const SizedBox(height: 12),
        Card(
          child: Column(
            children: [
              for (var index = 0; index < candidates.length; index++) ...[
                _candidateTile(candidates[index]),
                if (index < candidates.length - 1) const Divider(height: 1),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _statusCard(PayrollPattern? pattern) {
    if (pattern == null) {
      return Card(
        color: Theme.of(context).colorScheme.secondaryContainer,
        child: const ListTile(
          leading: Icon(Icons.help_outline),
          title: Text('Payday pattern needs confirmation'),
          subtitle: Text(
            'Confirm at least one paycheque below to start learning a pattern.',
          ),
        ),
      );
    }
    final nextDate = DateFormat(
      'd MMM yyyy',
      'en_CA',
    ).format(pattern.nextEstimatedPayday);
    return Card(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: ListTile(
        leading: const Icon(Icons.event_repeat_outlined),
        title: Text('Next payday estimate: $nextDate'),
        subtitle: Text(
          '${pattern.employer} · usually every ${pattern.typicalIntervalDays} days · '
          'recent range ${pattern.minimumAmount.formatCad()}–${pattern.maximumAmount.formatCad()} · '
          '${pattern.confirmedDepositCount} confirmed',
        ),
      ),
    );
  }

  Widget _assumptionsCard(IncomePlanningAssumptions assumptions) {
    final recentHours = assumptions.recentWeeklyHours
        .map((hours) => '${_formatHours(hours)} h')
        .join(', ');
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Work assumptions',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text('Recent weekly hours: $recentHours'),
              const SizedBox(height: 16),
              TextFormField(
                controller: _wageController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Hourly wage (CAD)',
                  prefixText: r'$ ',
                  helperText: 'Before estimated deductions',
                ),
                validator: (value) {
                  final amount = _parseNumber(value);
                  return amount == null || amount <= 0
                      ? 'Enter an hourly wage greater than zero.'
                      : null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _hoursController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Expected hours next week',
                  suffixText: 'hours',
                ),
                validator: (value) {
                  final hours = _parseNumber(value);
                  return hours == null || hours < 0 || hours > 80
                      ? 'Enter expected weekly hours from 0 to 80.'
                      : null;
                },
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: FilledButton.icon(
                  onPressed: _applyAssumptions,
                  icon: const Icon(Icons.calculate_outlined),
                  label: const Text('Update estimates'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _forecastCards(List<IncomeForecast> forecasts) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth >= 780
            ? (constraints.maxWidth - 24) / 3
            : constraints.maxWidth;
        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            for (final forecast in forecasts)
              SizedBox(
                width: width,
                child: _ForecastCard(forecast: forecast),
              ),
          ],
        );
      },
    );
  }

  Widget _candidateTile(PayrollCandidate candidate) {
    final date = DateFormat('d MMM yyyy', 'en_CA').format(candidate.date);
    return SwitchListTile(
      value: candidate.isConfirmed,
      onChanged: (value) {
        setState(() {
          if (value) {
            _confirmedTransactionIds.add(candidate.transactionId);
          } else {
            _confirmedTransactionIds.remove(candidate.transactionId);
          }
        });
      },
      secondary: const Icon(Icons.payments_outlined),
      title: Text('${candidate.employer} · ${candidate.amount.formatCad()}'),
      subtitle: Text('$date · ${candidate.reason}'),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }

  Widget _sectionTitle(String text) => Semantics(
    header: true,
    child: Text(text, style: Theme.of(context).textTheme.titleLarge),
  );

  void _applyAssumptions() {
    if (!_formKey.currentState!.validate()) return;
    ref
        .read(incomePlanningAssumptionsProvider.notifier)
        .update(
          hourlyWage: Money.fromDollars(_parseNumber(_wageController.text)!),
          expectedWeeklyHours: _parseNumber(_hoursController.text)!,
        );
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Income estimates updated.')));
  }

  double? _parseNumber(String? value) =>
      double.tryParse((value ?? '').trim().replaceAll(',', '.'));

  String _formatHours(double value) => value == value.roundToDouble()
      ? value.toStringAsFixed(0)
      : value.toStringAsFixed(1);
}

class _ForecastCard extends StatelessWidget {
  const _ForecastCard({required this.forecast});

  final IncomeForecast forecast;

  @override
  Widget build(BuildContext context) {
    final icon = switch (forecast.scenario) {
      ForecastScenario.conservative => Icons.shield_outlined,
      ForecastScenario.expected => Icons.balance_outlined,
      ForecastScenario.optimistic => Icons.trending_up_outlined,
    };
    return Semantics(
      container: true,
      label:
          '${forecast.scenario.label} income estimate, ${forecast.amount.formatCad()}. ${forecast.assumption}',
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon),
              const SizedBox(height: 12),
              Text(
                forecast.scenario.label,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 4),
              Text(
                forecast.amount.formatCad(),
                style: Theme.of(context).textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Text(forecast.assumption),
              const SizedBox(height: 8),
              const Text('Estimate'),
            ],
          ),
        ),
      ),
    );
  }
}
