import 'package:flutter_test/flutter_test.dart';
import 'package:student_flow/core/money.dart';
import 'package:student_flow/domain/services/safe_to_spend_calculator.dart';

void main() {
  const calculator = SafeToSpendCalculator();

  test('uses the documented inputs in integer cents', () {
    final result = calculator.calculate(
      SafeToSpendInput(
        currentAvailableBalance: Money.fromDollars(1842.67),
        conservativeExpectedIncome: Money.fromDollars(420),
        upcomingEssentialBills: Money.fromDollars(58.76),
        reservedEssentialVariableSpending: Money.fromDollars(135),
        emergencyBuffer: Money.fromDollars(700),
        safetyMargin: Money.fromDollars(75),
      ),
    );

    expect(result.spendable, Money.fromDollars(1293.91));
    expect(result.unclampedAmount, Money.fromDollars(1293.91));
    expect(result.wasClampedToZero, isFalse);
  });

  test('never presents a negative amount as spendable', () {
    final result = calculator.calculate(
      const SafeToSpendInput(
        currentAvailableBalance: Money.fromCents(10000),
        conservativeExpectedIncome: Money.zero,
        upcomingEssentialBills: Money.fromCents(8000),
        reservedEssentialVariableSpending: Money.fromCents(4000),
        emergencyBuffer: Money.fromCents(5000),
        safetyMargin: Money.fromCents(1000),
      ),
    );

    expect(result.spendable, Money.zero);
    expect(result.unclampedAmount, const Money.fromCents(-8000));
    expect(result.wasClampedToZero, isTrue);
  });

  test('keeps cent precision across additions and subtractions', () {
    final result = calculator.calculate(
      const SafeToSpendInput(
        currentAvailableBalance: Money.fromCents(101),
        conservativeExpectedIncome: Money.fromCents(2),
        upcomingEssentialBills: Money.fromCents(1),
        reservedEssentialVariableSpending: Money.fromCents(1),
        emergencyBuffer: Money.zero,
        safetyMargin: Money.zero,
      ),
    );

    expect(result.spendable, const Money.fromCents(101));
  });
}
