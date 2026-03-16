import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:project2/app/navigation/app_navigation_scaffold.dart';
import 'package:project2/features/settings/presentation/settings_placeholder_page.dart';
import 'package:project2/features/statistics/presentation/statistics_placeholder_page.dart';
import 'package:project2/features/timer/presentation/timer_shell_page.dart';

final class AppRoute {
  AppRoute._();

  static const timerName = 'timer';
  static const timerPath = '/';

  static const settingsName = 'settings';
  static const settingsPath = '/settings';

  static const statisticsName = 'statistics';
  static const statisticsPath = '/statistics';
}

GoRouter createAppRouter({String initialLocation = AppRoute.timerPath}) {
  final rootNavigatorKey = GlobalKey<NavigatorState>(
    debugLabel: 'app-root-router',
  );

  return GoRouter(
    initialLocation: initialLocation,
    navigatorKey: rootNavigatorKey,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppNavigationScaffold(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoute.timerPath,
                name: AppRoute.timerName,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: TimerShellPage()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoute.settingsPath,
                name: AppRoute.settingsName,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: SettingsPlaceholderPage()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoute.statisticsPath,
                name: AppRoute.statisticsName,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: StatisticsPlaceholderPage()),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
