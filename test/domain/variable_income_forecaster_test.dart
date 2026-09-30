import 'package:flutter_test/flutter_test.dart';
import 'package:student_flow/core/money.dart';
import 'package:student_flow/domain/models/income.dart';
import 'package:student_flow/domain/services/variable_income_forecaster.dart';

void main() {
  const forecaster = VariableIncomeForecaster();

  test('builds transparent scenarios from changing hours', () {
    final result = forecaster.calculate(
      VariableIncomeForecastInput(
        hourlyWage: Money.fromDollars(18.20),
        recentWeeklyHours: const [24, 19.5, 22, 17],
        expectedWeeklyHours: 21,
        periodStart: DateTime(2026, 9, 12),
        periodEnd: DateTime(2026, 9, 18),
      ),
    );

    expect(result.map((item) => item.scenario), ForecastScenario.values);
    expect(result.map((item) => item.amount.cents), [25072, 31340, 36041]);
    expect(result.first.assumption, contains('16.8 hours'));
    expect(result.first.assumption, contains('82% take-home'));
  });

  test('rejects invalid wage, hours, and take-home assumptions', () {
    VariableIncomeForecastInput input({
      Money wage = Money.zero,
      List<double> recent = const [],
      double expected = 10,
      double rate = 0.82,
    }) => VariableIncomeForecastInput(
      hourlyWage: wage,
      recentWeeklyHours: recent,
      expectedWeeklyHours: expected,
      periodStart: DateTime(2026, 9, 12),
      periodEnd: DateTime(2026, 9, 18),
      estimatedTakeHomeRate: rate,
    );

    expect(() => forecaster.calculate(input()), throwsFormatException);
    expect(
      () => forecaster.calculate(
        input(wage: Money.fromDollars(18), expected: -1),
      ),
      throwsFormatException,
    );
    expect(
      () => forecaster.calculate(input(wage: Money.fromDollars(18), rate: 1.1)),
      throwsFormatException,
    );
  });
}
