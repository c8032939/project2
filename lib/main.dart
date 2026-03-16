import 'package:flutter/widgets.dart';
import 'package:project2/app/app.dart';
import 'package:project2/app/router.dart';
import 'package:project2/core/services/notification_coordinator.dart';
import 'package:project2/features/routine/data/local_routine_settings_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final routineSettingsRepository = LocalRoutineSettingsRepository();
  final notificationCoordinator = NotificationCoordinator();
  final router = createAppRouter();

  runApp(
    StandaholicApp(
      router: router,
      notificationCoordinator: notificationCoordinator,
      routineSettingsRepository: routineSettingsRepository,
    ),
  );
}
