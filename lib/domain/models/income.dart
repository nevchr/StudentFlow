import 'package:student_flow/core/money.dart';

enum ForecastScenario { conservative, expected, optimistic }

extension ForecastScenarioLabel on ForecastScenario {
  String get label => switch (this) {
    ForecastScenario.conservative => 'Conservative',
    ForecastScenario.expected => 'Expected',
    ForecastScenario.optimistic => 'Optimistic',
  };
}

final class PayrollCandidate {
  const PayrollCandidate({
    required this.transactionId,
    required this.employer,
    required this.date,
    required this.amount,
    required this.isConfirmed,
    required this.reason,
  });

  final String transactionId;
  final String employer;
  final DateTime date;
  final Money amount;
  final bool isConfirmed;
  final String reason;
}

final class PayrollPattern {
  const PayrollPattern({
    required this.employer,
    required this.minimumAmount,
    required this.maximumAmount,
    required this.typicalIntervalDays,
    required this.nextEstimatedPayday,
    required this.confirmedDepositCount,
  });

  final String employer;
  final Money minimumAmount;
  final Money maximumAmount;
  final int typicalIntervalDays;
  final DateTime nextEstimatedPayday;
  final int confirmedDepositCount;
}

final class PayDeposit {
  const PayDeposit({
    required this.transactionId,
    required this.employer,
    required this.date,
    required this.amount,
    required this.isConfirmed,
  });

  final String transactionId;
  final String employer;
  final DateTime date;
  final Money amount;
  final bool isConfirmed;
}

final class IncomeProfile {
  const IncomeProfile({
    required this.employer,
    required this.hourlyWage,
    required this.recentWeeklyHours,
    required this.expectedWeeklyHours,
    required this.recentPayDeposits,
    required this.expectedNextPayday,
    required this.nextPaydayIsEstimate,
  });

  final String employer;
  final Money hourlyWage;
  final List<double> recentWeeklyHours;
  final double expectedWeeklyHours;
  final List<PayDeposit> recentPayDeposits;
  final DateTime expectedNextPayday;
  final bool nextPaydayIsEstimate;
}

final class IncomeForecast {
  const IncomeForecast({
    required this.scenario,
    required this.amount,
    required this.periodStart,
    required this.periodEnd,
    required this.assumption,
  });

  final ForecastScenario scenario;
  final Money amount;
  final DateTime periodStart;
  final DateTime periodEnd;
  final String assumption;
}
