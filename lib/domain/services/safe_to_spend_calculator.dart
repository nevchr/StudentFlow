import 'package:student_flow/core/money.dart';

final class SafeToSpendInput {
  const SafeToSpendInput({
    required this.currentAvailableBalance,
    required this.conservativeExpectedIncome,
    required this.upcomingEssentialBills,
    required this.reservedEssentialVariableSpending,
    required this.emergencyBuffer,
    required this.safetyMargin,
  });

  final Money currentAvailableBalance;
  final Money conservativeExpectedIncome;
  final Money upcomingEssentialBills;
  final Money reservedEssentialVariableSpending;
  final Money emergencyBuffer;
  final Money safetyMargin;
}

final class SafeToSpendResult {
  const SafeToSpendResult({
    required this.spendable,
    required this.unclampedAmount,
    required this.input,
  });

  final Money spendable;
  final Money unclampedAmount;
  final SafeToSpendInput input;

  bool get wasClampedToZero => unclampedAmount.isNegative;
}

/// A transparent first-pass calculation, deliberately free of opaque scores.
final class SafeToSpendCalculator {
  const SafeToSpendCalculator();

  SafeToSpendResult calculate(SafeToSpendInput input) {
    final raw =
        input.currentAvailableBalance +
        input.conservativeExpectedIncome -
        input.upcomingEssentialBills -
        input.reservedEssentialVariableSpending -
        input.emergencyBuffer -
        input.safetyMargin;

    return SafeToSpendResult(
      spendable: raw.clampToZero(),
      unclampedAmount: raw,
      input: input,
    );
  }
}
