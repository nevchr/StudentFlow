import 'package:student_flow/core/money.dart';
import 'package:student_flow/domain/models/forecast.dart';

final class CashFlowForecaster {
  const CashFlowForecaster();

  CashFlowForecast calculate({
    required DateTime generatedAt,
    required Money openingBalance,
    required Money lowBalanceThreshold,
    required List<CashFlowEvent> events,
  }) {
    final ordered = [...events]..sort((a, b) => a.date.compareTo(b.date));
    var balance = openingBalance;
    final points = <CashFlowPoint>[
      CashFlowPoint(
        date: generatedAt,
        balance: balance,
        summary: 'Available balance now',
        isEstimate: false,
      ),
    ];
    for (final event in ordered) {
      balance += event.amount;
      points.add(
        CashFlowPoint(
          date: event.date,
          balance: balance,
          summary: event.summary,
          isEstimate: event.isEstimate,
        ),
      );
    }
    return CashFlowForecast(
      generatedAt: generatedAt,
      points: points,
      lowBalanceThreshold: lowBalanceThreshold,
    );
  }
}
