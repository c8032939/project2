import 'package:project2/app/app_navigation_shell.dart';
import 'package:go_router/go_router.dart';
import 'package:project2/core/constants/app_constants.dart';
import 'package:project2/features/settings/presentation/settings_placeholder_page.dart';
import 'package:project2/features/statistics/presentation/statistics_placeholder_page.dart';
import 'package:project2/features/timer/presentation/timer_shell_page.dart';

enum AppRoute {
  timer(name: 'timer', path: AppConstants.timerRoutePath),
  settings(name: 'settings', path: AppConstants.settingsRoutePath),
  statistics(name: 'statistics', path: AppConstants.statisticsRoutePath);

  const AppRoute({required this.name, required this.path});

  final String name;
  final String path;
}

GoRouter createAppRouter({
  String initialLocation = AppConstants.rootRoutePath,
}) {
  return GoRouter(
    initialLocation: initialLocation,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppNavigationShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoute.timer.path,
                name: AppRoute.timer.name,
                builder: (context, state) => const TimerShellPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoute.settings.path,
                name: AppRoute.settings.name,
                builder: (context, state) => const SettingsPlaceholderPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoute.statistics.path,
                name: AppRoute.statistics.name,
                builder: (context, state) => const StatisticsPlaceholderPage(),
              ),
            ],
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      if (state.matchedLocation == AppConstants.rootRoutePath) {
        return AppRoute.timer.path;
      }

      return null;
    },
  );
}
