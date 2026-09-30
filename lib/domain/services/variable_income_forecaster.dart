import 'dart:math' as math;

import 'package:student_flow/core/money.dart';
import 'package:student_flow/domain/models/income.dart';

final class VariableIncomeForecastInput {
  const VariableIncomeForecastInput({
    required this.hourlyWage,
    required this.recentWeeklyHours,
    required this.expectedWeeklyHours,
    required this.periodStart,
    required this.periodEnd,
    this.estimatedTakeHomeRate = 0.82,
  });

  final Money hourlyWage;
  final List<double> recentWeeklyHours;
  final double expectedWeeklyHours;
  final DateTime periodStart;
  final DateTime periodEnd;

  /// A user-visible planning assumption, not a tax calculation.
  final double estimatedTakeHomeRate;
}

final class VariableIncomeForecaster {
  const VariableIncomeForecaster();

  List<IncomeForecast> calculate(VariableIncomeForecastInput input) {
    if (input.hourlyWage.cents <= 0) {
      throw const FormatException('Hourly wage must be greater than zero.');
    }
    if (input.expectedWeeklyHours < 0 ||
        input.recentWeeklyHours.any((hours) => hours < 0)) {
      throw const FormatException('Weekly hours cannot be negative.');
    }
    if (input.estimatedTakeHomeRate <= 0 || input.estimatedTakeHomeRate > 1) {
      throw const FormatException('Take-home rate must be between 0 and 1.');
    }

    final recent = [...input.recentWeeklyHours]..sort();
    final lowerObserved = recent.isEmpty
        ? input.expectedWeeklyHours
        : recent.first;
    final upperObserved = recent.isEmpty
        ? input.expectedWeeklyHours
        : recent.last;
    final conservativeHours = math.min(
      input.expectedWeeklyHours * 0.8,
      lowerObserved,
    );
    final optimisticHours = math.max(
      input.expectedWeeklyHours * 1.15,
      upperObserved,
    );

    return [
      _forecast(input, ForecastScenario.conservative, conservativeHours),
      _forecast(input, ForecastScenario.expected, input.expectedWeeklyHours),
      _forecast(input, ForecastScenario.optimistic, optimisticHours),
    ];
  }

  IncomeForecast _forecast(
    VariableIncomeForecastInput input,
    ForecastScenario scenario,
    double hours,
  ) {
    final cents = (input.hourlyWage.cents * hours * input.estimatedTakeHomeRate)
        .round();
    return IncomeForecast(
      scenario: scenario,
      amount: Money.fromCents(cents),
      periodStart: input.periodStart,
      periodEnd: input.periodEnd,
      assumption:
          '${hours.toStringAsFixed(hours == hours.roundToDouble() ? 0 : 1)} hours at '
          '${input.hourlyWage.formatCad()} per hour, using an '
          '${(input.estimatedTakeHomeRate * 100).round()}% take-home planning estimate',
    );
  }
}
