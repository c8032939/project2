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
    expect(find.text('Timer'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('Statistics'), findsOneWidget);
  });

  testWidgets('switches between top-level routes from the shared shell', (
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

    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();

    expect(find.text('Settings'), findsWidgets);
    expect(find.textContaining('routine preferences'), findsOneWidget);

    await tester.tap(find.text('Statistics'));
    await tester.pumpAndSettle();

    expect(find.text('Statistics'), findsWidgets);
    expect(
      find.textContaining('daily standing, sitting, and walking'),
      findsOneWidget,
    );
  });

  testWidgets('supports direct navigation to a top-level route', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      StandaholicApp(
        router: createAppRouter(initialLocation: AppRoute.settings.path),
        notificationCoordinator: NotificationCoordinator(),
        routineSettingsRepository: LocalRoutineSettingsRepository(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Settings'), findsWidgets);
    expect(find.textContaining('routine preferences'), findsOneWidget);
  });
}
