import 'package:flutter_test/flutter_test.dart';
import 'package:project2/app/app.dart';
import 'package:project2/app/router.dart';
import 'package:project2/app/theme/app_theme.dart';
import 'package:project2/core/services/notification_coordinator.dart';
import 'package:project2/features/routine/data/local_routine_settings_repository.dart';

void main() {
  testWidgets('redirects the root route to the timer shell', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      StandaholicApp(
        router: createAppRouter(),
        notificationCoordinator: NotificationCoordinator(),
        routineSettingsRepository: LocalRoutineSettingsRepository(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Standaholic'), findsOneWidget);
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
    expect(theme.navigationBarTheme.height, 72);
  });

  testWidgets('navigates to placeholder settings and statistics routes', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      StandaholicApp(
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
}
