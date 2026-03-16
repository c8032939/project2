import 'package:flutter_test/flutter_test.dart';
import 'package:project2/app/app.dart';
import 'package:project2/app/router.dart';
import 'package:project2/core/services/notification_coordinator.dart';
import 'package:project2/features/routine/data/local_routine_settings_repository.dart';

void main() {
  testWidgets('renders the standaholic shell with default routine', (
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
    expect(find.text('Current phase'), findsOneWidget);
    expect(find.text('Sitting'), findsWidgets);
    expect(find.text('Sitting -> Standing -> Walking'), findsOneWidget);
  });

  testWidgets('supports deep linking to settings', (WidgetTester tester) async {
    await tester.pumpWidget(
      StandaholicApp(
        router: createAppRouter(initialLocation: AppRoute.settingsPath),
        notificationCoordinator: NotificationCoordinator(),
        routineSettingsRepository: LocalRoutineSettingsRepository(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('Routing foundation'), findsOneWidget);
  });

  testWidgets('supports deep linking to statistics', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      StandaholicApp(
        router: createAppRouter(initialLocation: AppRoute.statisticsPath),
        notificationCoordinator: NotificationCoordinator(),
        routineSettingsRepository: LocalRoutineSettingsRepository(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Statistics'), findsOneWidget);
    expect(find.text('Navigation target'), findsOneWidget);
  });
}
