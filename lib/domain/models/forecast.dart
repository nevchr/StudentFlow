import 'package:student_flow/core/money.dart';

enum CashFlowEventKind { income, bill, reservedSpending }

final class CashFlowEvent {
  const CashFlowEvent({
    required this.date,
    required this.amount,
    required this.summary,
    required this.kind,
    required this.isEstimate,
  });

  /// Positive amounts add to the balance; negative amounts reduce it.
  final DateTime date;
  final Money amount;
  final String summary;
  final CashFlowEventKind kind;
  final bool isEstimate;
}

final class CashFlowPoint {
  const CashFlowPoint({
    required this.date,
    required this.balance,
    required this.summary,
    required this.isEstimate,
  });

  final DateTime date;
  final Money balance;
  final String summary;
  final bool isEstimate;
}

final class CashFlowForecast {
  const CashFlowForecast({
    required this.generatedAt,
    required this.points,
    required this.lowBalanceThreshold,
  });

  final DateTime generatedAt;
  final List<CashFlowPoint> points;
  final Money lowBalanceThreshold;
}
