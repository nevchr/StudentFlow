import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppShell extends StatelessWidget {
  const AppShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  static const _destinations = [
    NavigationDestination(
      icon: Icon(Icons.home_outlined),
      selectedIcon: Icon(Icons.home),
      label: 'Home',
    ),
    NavigationDestination(
      icon: Icon(Icons.receipt_long_outlined),
      selectedIcon: Icon(Icons.receipt_long),
      label: 'Transactions',
    ),
    NavigationDestination(
      icon: Icon(Icons.payments_outlined),
      selectedIcon: Icon(Icons.payments),
      label: 'Income',
    ),
    NavigationDestination(
      icon: Icon(Icons.account_balance_wallet_outlined),
      selectedIcon: Icon(Icons.account_balance_wallet),
      label: 'Budget',
    ),
    NavigationDestination(
      icon: Icon(Icons.settings_outlined),
      selectedIcon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ];

  void _goTo(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final useRail = constraints.maxWidth >= 840;
        if (useRail) {
          return Scaffold(
            body: Row(
              children: [
                SafeArea(
                  child: NavigationRail(
                    selectedIndex: navigationShell.currentIndex,
                    onDestinationSelected: _goTo,
                    labelType: NavigationRailLabelType.all,
                    leading: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Semantics(
                        header: true,
                        child: const Text('StudentFlow'),
                      ),
                    ),
                    destinations: _destinations
                        .map(
                          (destination) => NavigationRailDestination(
                            icon: destination.icon,
                            selectedIcon: destination.selectedIcon,
                            label: Text(destination.label),
                          ),
                        )
                        .toList(),
                  ),
                ),
                const VerticalDivider(width: 1),
                Expanded(child: navigationShell),
              ],
            ),
          );
        }

        return Scaffold(
          body: navigationShell,
          bottomNavigationBar: NavigationBar(
            selectedIndex: navigationShell.currentIndex,
            onDestinationSelected: _goTo,
            destinations: _destinations,
          ),
        );
      },
    );
  }
}
