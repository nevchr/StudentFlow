import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:student_flow/features/budget/presentation/budget_screen.dart';
import 'package:student_flow/features/home/presentation/home_screen.dart';
import 'package:student_flow/features/income/presentation/income_screen.dart';
import 'package:student_flow/features/settings/presentation/settings_screen.dart';
import 'package:student_flow/features/transactions/presentation/transactions_screen.dart';
import 'package:student_flow/shared/widgets/app_shell.dart';

GoRouter buildAppRouter() => GoRouter(
  initialLocation: '/home',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          AppShell(navigationShell: navigationShell),
      branches: [
        _branch('/home', const HomeScreen()),
        _branch('/transactions', const TransactionsScreen()),
        _branch('/income', const IncomeScreen()),
        _branch('/budget', const BudgetScreen()),
        _branch('/settings', const SettingsScreen()),
      ],
    ),
  ],
);

StatefulShellBranch _branch(String path, Widget child) {
  return StatefulShellBranch(
    routes: [
      GoRoute(
        path: path,
        pageBuilder: (context, state) => NoTransitionPage(child: child),
      ),
    ],
  );
}
