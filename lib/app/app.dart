import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:project2/app/theme/app_theme.dart';
import 'package:project2/core/constants/app_config.dart';
import 'package:project2/core/services/notification_coordinator.dart';
import 'package:project2/features/routine/application/routine_settings_bloc.dart';
import 'package:project2/features/routine/data/routine_settings_repository.dart';
import 'package:project2/features/timer/application/timer_bloc.dart';

class StandaholicApp extends StatelessWidget {
  const StandaholicApp({
    required this.config,
    required this.router,
    required this.notificationCoordinator,
    required this.routineSettingsRepository,
    super.key,
  });

  final AppConfig config;
  final GoRouter router;
  final NotificationCoordinator notificationCoordinator;
  final RoutineSettingsRepository routineSettingsRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<RoutineSettingsRepository>.value(
          value: routineSettingsRepository,
        ),
        RepositoryProvider<NotificationCoordinator>.value(
          value: notificationCoordinator,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<RoutineSettingsBloc>(
            create: (context) => RoutineSettingsBloc(
              routineSettingsRepository: context
                  .read<RoutineSettingsRepository>(),
            )..add(const RoutineSettingsRequested()),
          ),
          BlocProvider<TimerBloc>(
            create: (context) => TimerBloc(
              routineSettingsRepository: context
                  .read<RoutineSettingsRepository>(),
            )..add(const TimerStarted()),
          ),
        ],
        child: MaterialApp.router(
          title: config.appName,
          debugShowCheckedModeBanner: false,
          routerConfig: router,
          theme: AppTheme.light(),
        ),
      ),
    );
  }
}
