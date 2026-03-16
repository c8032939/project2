import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppNavigationShell extends StatelessWidget {
  const AppNavigationShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final bool useRail = MediaQuery.sizeOf(context).width >= 840;

    if (useRail) {
      return Scaffold(
        body: SafeArea(
          child: Row(
            children: [
              NavigationRail(
                selectedIndex: navigationShell.currentIndex,
                onDestinationSelected: _onDestinationSelected,
                labelType: NavigationRailLabelType.all,
                destinations: _destinations
                    .map(
                      (destination) => NavigationRailDestination(
                        icon: Icon(destination.icon),
                        label: Text(destination.label),
                      ),
                    )
                    .toList(),
              ),
              const VerticalDivider(width: 1),
              Expanded(child: navigationShell),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _onDestinationSelected,
        destinations: _destinations
            .map(
              (destination) => NavigationDestination(
                icon: Icon(destination.icon),
                label: destination.label,
              ),
            )
            .toList(),
      ),
    );
  }

  void _onDestinationSelected(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}

const List<NavigationDestinationItem> _destinations = [
  NavigationDestinationItem(label: 'Timer', icon: Icons.timer_outlined),
  NavigationDestinationItem(label: 'Settings', icon: Icons.tune_outlined),
  NavigationDestinationItem(
    label: 'Statistics',
    icon: Icons.bar_chart_outlined,
  ),
];

class NavigationDestinationItem {
  const NavigationDestinationItem({required this.label, required this.icon});

  final String label;
  final IconData icon;
}
