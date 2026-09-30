import 'package:intl/intl.dart';

/// Money is stored as integer cents so budgeting never depends on binary
/// floating-point rounding.
final class Money implements Comparable<Money> {
  const Money.fromCents(this.cents);

  factory Money.fromDollars(num dollars) =>
      Money.fromCents((dollars * 100).round());

  static const zero = Money.fromCents(0);

  final int cents;

  bool get isNegative => cents < 0;
  bool get isPositive => cents > 0;

  Money operator +(Money other) => Money.fromCents(cents + other.cents);
  Money operator -(Money other) => Money.fromCents(cents - other.cents);
  Money operator -() => Money.fromCents(-cents);

  Money clampToZero() => isNegative ? zero : this;

  String formatCad() => NumberFormat.simpleCurrency(
    locale: 'en_CA',
    name: 'CAD',
  ).format(cents / 100);

  @override
  int compareTo(Money other) => cents.compareTo(other.cents);

  @override
  bool operator ==(Object other) => other is Money && other.cents == cents;

  @override
  int get hashCode => cents.hashCode;

  @override
  String toString() => 'Money($cents cents CAD)';
}
