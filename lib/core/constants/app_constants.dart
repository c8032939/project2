import 'package:project2/features/routine/domain/desk_phase.dart';

final class AppConstants {
  AppConstants._();

  static const appName = 'Standaholic';
  static const appShellEyebrow = 'Desk rhythm';

  static const rootRoutePath = '/';
  static const timerRoutePath = '/timer';
  static const settingsRoutePath = '/settings';
  static const statisticsRoutePath = '/statistics';

  static const defaultPhaseOrder = [
    DeskPhase.sitting,
    DeskPhase.standing,
    DeskPhase.walking,
  ];

  static const desktopNavigationBreakpoint = 840.0;
  static const compactHeaderBreakpoint = 640.0;
  static const pageContentMaxWidth = 960.0;

  static const navigationBarHeight = 72.0;

  static const surfaceRadius = 24.0;
  static const featureHeaderRadius = 28.0;
  static const shellSurfaceRadius = 32.0;
}
