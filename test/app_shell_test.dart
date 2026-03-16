import 'package:flutter_test/flutter_test.dart';
import 'package:project2/app/app.dart';
import 'package:project2/app/router.dart';
import 'package:project2/app/theme/app_theme.dart';
import 'package:project2/core/constants/app_config.dart';
import 'package:project2/core/constants/app_constants.dart';
import 'package:project2/core/services/notification_coordinator.dart';
import 'package:project2/features/routine/data/local_routine_settings_repository.dart';

void main() {
  testWidgets('redirects the root route to the timer shell', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      StandaholicApp(
        config: AppConfig.fromEnvironment(),
        router: createAppRouter(),
        notificationCoordinator: NotificationCoordinator(),
        routineSettingsRepository: LocalRoutineSettingsRepository(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text(AppConstants.appName), findsOneWidget);
    expect(find.text('Timer'), findsOneWidget);
    expect(find.text('Daily flow'), findsOneWidget);
    expect(find.text('Current phase'), findsOneWidget);
    expect(find.text('Sitting'), findsWidgets);
    expect(find.text('Sitting -> Standing -> Walking'), findsOneWidget);
  });

  test('app theme exposes the shared calm palette', () {
    final theme = AppTheme.light();

    expect(theme.scaffoldBackgroundColor, AppTheme.background);
    expect(theme.colorScheme.primary, AppTheme.accent);
    expect(theme.colorScheme.secondary, AppTheme.warmAccent);
    expect(theme.navigationBarTheme.height, AppConstants.navigationBarHeight);
  });

  testWidgets('navigates to placeholder settings and statistics routes', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      StandaholicApp(
        config: AppConfig.fromEnvironment(),
        router: createAppRouter(initialLocation: AppRoute.timer.path),
        notificationCoordinator: NotificationCoordinator(),
        routineSettingsRepository: LocalRoutineSettingsRepository(),
      ),
    );

    await tester.pumpAndSettle();

    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();

    expect(find.text('Routine settings'), findsOneWidget);
    expect(find.text('Navigation foundation'), findsOneWidget);
    expect(
      find.text('Settings will stay local-first and calm by default.'),
      findsOneWidget,
    );

    await tester.tap(find.text('Statistics'));
    await tester.pumpAndSettle();

    expect(find.text('Statistics'), findsWidgets);
    expect(find.text('Prepared for growth'), findsOneWidget);
    expect(
      find.text(
        'Trends will build on timestamped activity data, not day-only counters.',
      ),
      findsOneWidget,
    );
  });

  test('app config keeps safe defaults and sanitizes unsupported routes', () {
    final defaultConfig = AppConfig.fromEnvironment();
    final configured = AppConfig.fromEnvironment(
      environment: 'production',
      initialLocation: '/unknown',
    );

    expect(defaultConfig.appName, AppConstants.appName);
    expect(defaultConfig.environment, AppEnvironment.development);
    expect(defaultConfig.initialLocation, AppConstants.rootRoutePath);
    expect(defaultConfig.enableDiagnostics, isTrue);

    expect(configured.environment, AppEnvironment.production);
    expect(configured.initialLocation, AppConstants.rootRoutePath);
    expect(configured.enableDiagnostics, isFalse);
    expect(configured.isProduction, isTrue);
  });

  test('app config accepts supported environment-safe route overrides', () {
    final config = AppConfig.fromEnvironment(
      environment: 'staging',
      initialLocation: AppConstants.statisticsRoutePath,
    );

    expect(config.environment, AppEnvironment.staging);
    expect(config.initialLocation, AppConstants.statisticsRoutePath);
    expect(config.enableDiagnostics, isTrue);
  });
}
