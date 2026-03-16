import 'package:project2/core/constants/app_constants.dart';

enum AppEnvironment {
  development,
  staging,
  production;

  static AppEnvironment parse(String? rawValue) {
    final normalizedValue = rawValue?.trim().toLowerCase();

    return switch (normalizedValue) {
      'production' || 'prod' => AppEnvironment.production,
      'staging' || 'stage' => AppEnvironment.staging,
      _ => AppEnvironment.development,
    };
  }
}

final class AppConfig {
  const AppConfig({
    required this.environment,
    required this.initialLocation,
    required this.enableDiagnostics,
  });

  factory AppConfig.fromPlatform() {
    return AppConfig.fromEnvironment(
      environment: const String.fromEnvironment(_environmentKey),
      initialLocation: const String.fromEnvironment(_initialLocationKey),
      enableDiagnostics: _parseOptionalBool(
        const String.fromEnvironment(_diagnosticsKey),
      ),
    );
  }

  factory AppConfig.fromEnvironment({
    String? environment,
    String? initialLocation,
    bool? enableDiagnostics,
  }) {
    final resolvedEnvironment = AppEnvironment.parse(environment);

    return AppConfig(
      environment: resolvedEnvironment,
      initialLocation: _sanitizeInitialLocation(initialLocation),
      enableDiagnostics:
          enableDiagnostics ?? resolvedEnvironment != AppEnvironment.production,
    );
  }

  static const _environmentKey = 'STANDAHOLIC_ENV';
  static const _initialLocationKey = 'STANDAHOLIC_INITIAL_LOCATION';
  static const _diagnosticsKey = 'STANDAHOLIC_ENABLE_DIAGNOSTICS';

  final AppEnvironment environment;
  final String initialLocation;
  final bool enableDiagnostics;

  bool get isProduction => environment == AppEnvironment.production;

  String get appName => AppConstants.appName;

  static bool? _parseOptionalBool(String rawValue) {
    final normalizedValue = rawValue.trim().toLowerCase();

    return switch (normalizedValue) {
      'true' => true,
      'false' => false,
      _ => null,
    };
  }

  static String _sanitizeInitialLocation(String? rawValue) {
    const supportedLocations = {
      AppConstants.rootRoutePath,
      AppConstants.timerRoutePath,
      AppConstants.settingsRoutePath,
      AppConstants.statisticsRoutePath,
    };

    final normalizedValue = rawValue?.trim();
    if (normalizedValue == null || normalizedValue.isEmpty) {
      return AppConstants.rootRoutePath;
    }

    if (supportedLocations.contains(normalizedValue)) {
      return normalizedValue;
    }

    return AppConstants.rootRoutePath;
  }
}
