import 'package:flutter/widgets.dart';
import 'package:project2/app/app.dart';
import 'package:project2/app/router.dart';
import 'package:project2/core/constants/app_config.dart';
import 'package:project2/core/services/notification_coordinator.dart';
import 'package:project2/features/routine/data/local_routine_settings_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final config = AppConfig.fromPlatform();
  final routineSettingsRepository = LocalRoutineSettingsRepository();
  final notificationCoordinator = NotificationCoordinator();
  final router = createAppRouter(initialLocation: config.initialLocation);

  runApp(
    StandaholicApp(
      config: config,
      router: router,
      notificationCoordinator: notificationCoordinator,
      routineSettingsRepository: routineSettingsRepository,
    ),
  );
}
