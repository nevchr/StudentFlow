import 'package:student_flow/core/money.dart';
import 'package:student_flow/domain/models/financial_transaction.dart';
import 'package:student_flow/domain/models/income.dart';

final class PayrollDetector {
  const PayrollDetector();

  List<PayrollCandidate> detect({
    required List<FinancialTransaction> transactions,
    Set<String> confirmedTransactionIds = const {},
  }) {
    final candidates = <PayrollCandidate>[];
    for (final transaction in transactions) {
      if (!transaction.amount.isPositive) continue;
      final normalized = transaction.description.toLowerCase();
      final hasPayrollLanguage = _payrollTerms.any(normalized.contains);
      final wasConfirmed = confirmedTransactionIds.contains(transaction.id);
      if (!hasPayrollLanguage && !wasConfirmed) continue;

      candidates.add(
        PayrollCandidate(
          transactionId: transaction.id,
          employer: _employerFrom(transaction.description),
          date: transaction.date,
          amount: transaction.amount,
          isConfirmed: wasConfirmed,
          reason: hasPayrollLanguage
              ? 'Description looks like payroll'
              : 'Previously confirmed as a paycheque',
        ),
      );
    }
    candidates.sort((a, b) => b.date.compareTo(a.date));
    return candidates;
  }

  PayrollPattern? learnPattern({
    required List<PayrollCandidate> candidates,
    required DateTime referenceDate,
  }) {
    final confirmed = candidates.where((item) => item.isConfirmed).toList()
      ..sort((a, b) => a.date.compareTo(b.date));
    if (confirmed.isEmpty) return null;

    final employerCounts = <String, int>{};
    for (final item in confirmed) {
      employerCounts.update(
        item.employer,
        (count) => count + 1,
        ifAbsent: () => 1,
      );
    }
    final employer = employerCounts.entries.reduce((best, item) {
      if (item.value != best.value) {
        return item.value > best.value ? item : best;
      }
      return item.key.compareTo(best.key) < 0 ? item : best;
    }).key;

    final amounts = confirmed.map((item) => item.amount.cents).toList()..sort();
    final intervals = <int>[];
    for (var index = 1; index < confirmed.length; index++) {
      final days = confirmed[index].date
          .difference(confirmed[index - 1].date)
          .inDays;
      if (days > 0) intervals.add(days);
    }
    intervals.sort();
    final interval = intervals.isEmpty ? 7 : intervals[intervals.length ~/ 2];
    var nextPayday = confirmed.last.date.add(Duration(days: interval));
    while (!nextPayday.isAfter(referenceDate)) {
      nextPayday = nextPayday.add(Duration(days: interval));
    }

    return PayrollPattern(
      employer: employer,
      minimumAmount: Money.fromCents(amounts.first),
      maximumAmount: Money.fromCents(amounts.last),
      typicalIntervalDays: interval,
      nextEstimatedPayday: nextPayday,
      confirmedDepositCount: confirmed.length,
    );
  }

  static const _payrollTerms = [
    'payroll',
    'pay cheque',
    'paycheque',
    'salary',
    'direct deposit pay',
  ];

  String _employerFrom(String description) {
    var employer = description;
    for (final term in _payrollTerms) {
      employer = employer.replaceAll(RegExp(term, caseSensitive: false), '');
    }
    employer = employer.replaceAll(RegExp(r'\s+'), ' ').trim();
    return employer.isEmpty ? 'Employer not identified' : employer;
  }
}
