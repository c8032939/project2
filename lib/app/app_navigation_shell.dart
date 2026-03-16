import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project2/core/constants/app_constants.dart';
import 'package:project2/core/constants/app_strings.dart';
import 'package:project2/shared/widgets/app_surface_card.dart';

class AppNavigationShell extends StatelessWidget {
  const AppNavigationShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool useRail =
        MediaQuery.sizeOf(context).width >=
        AppConstants.desktopNavigationBreakpoint;

    if (useRail) {
      return Scaffold(
        body: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                theme.scaffoldBackgroundColor,
                theme.colorScheme.surfaceContainerLowest,
              ],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: AppSurfaceCard(
                padding: EdgeInsets.zero,
                borderRadius: const BorderRadius.all(
                  Radius.circular(AppConstants.shellSurfaceRadius),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 260,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 24, 16, 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppConstants.appName,
                              style: theme.textTheme.headlineSmall,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              AppStrings.navigationSummary,
                              style: theme.textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 24),
                            Expanded(
                              child: NavigationRail(
                                selectedIndex: navigationShell.currentIndex,
                                onDestinationSelected: _onDestinationSelected,
                                labelType: NavigationRailLabelType.all,
                                leading: _PhaseSummaryCard(
                                  useCompactLayout: false,
                                ),
                                destinations: _destinations
                                    .map(
                                      (destination) =>
                                          NavigationRailDestination(
                                            icon: Icon(destination.icon),
                                            label: Text(destination.label),
                                          ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    VerticalDivider(
                      width: 1,
                      color: theme.colorScheme.outlineVariant,
                    ),
                    Expanded(child: navigationShell),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              theme.scaffoldBackgroundColor,
              theme.colorScheme.surfaceContainerLowest,
            ],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: _PhaseSummaryCard(useCompactLayout: true),
              ),
              Expanded(child: navigationShell),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: NavigationBar(
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
          ),
        ),
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

class _PhaseSummaryCard extends StatelessWidget {
  const _PhaseSummaryCard({required this.useCompactLayout});

  final bool useCompactLayout;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppSurfaceCard(
      tone: AppSurfaceTone.accent,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Daily flow', style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(AppStrings.phaseSummary, style: theme.textTheme.bodyMedium),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final phase in AppConstants.defaultPhaseOrder)
                Chip(
                  label: Text(phase.label),
                  visualDensity: useCompactLayout
                      ? VisualDensity.compact
                      : VisualDensity.standard,
                ),
            ],
          ),
        ],
      ),
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
