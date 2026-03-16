import 'package:flutter/material.dart';
import 'package:project2/core/constants/app_constants.dart';

final class AppTheme {
  AppTheme._();

  static const Color background = Color(0xFFF5F1EA);
  static const Color surface = Color(0xFFFFFCF7);
  static const Color surfaceMuted = Color(0xFFF0E8DE);
  static const Color ink = Color(0xFF1E2A28);
  static const Color inkMuted = Color(0xFF55615F);
  static const Color accent = Color(0xFF355C57);
  static const Color accentSoft = Color(0xFFD8E4DE);
  static const Color warmAccent = Color(0xFFC97C5D);
  static const Color warmAccentSoft = Color(0xFFF1DDD5);
  static const Color outline = Color(0xFFD7CEC2);

  static ThemeData light() {
    final colorScheme =
        ColorScheme.fromSeed(
          seedColor: accent,
          brightness: Brightness.light,
          surface: surface,
        ).copyWith(
          primary: accent,
          onPrimary: surface,
          secondary: warmAccent,
          onSecondary: surface,
          surface: surface,
          surfaceContainerLowest: background,
          surfaceContainerLow: surface,
          surfaceContainer: surfaceMuted,
          surfaceContainerHigh: accentSoft,
          surfaceContainerHighest: warmAccentSoft,
          outline: outline,
          outlineVariant: outline,
          onSurface: ink,
          onSurfaceVariant: inkMuted,
        );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: background,
      dividerTheme: const DividerThemeData(space: 1, thickness: 1),
      cardTheme: const CardThemeData(
        elevation: 0,
        color: surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: surface,
        selectedColor: accentSoft,
        disabledColor: surfaceMuted,
        side: const BorderSide(color: outline),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
        labelStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: ink,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surface.withValues(alpha: 0.96),
        indicatorColor: accentSoft,
        surfaceTintColor: Colors.transparent,
        height: AppConstants.navigationBarHeight,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          return TextStyle(
            fontSize: 12,
            fontWeight: states.contains(WidgetState.selected)
                ? FontWeight.w600
                : FontWeight.w500,
            color: states.contains(WidgetState.selected) ? ink : inkMuted,
          );
        }),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: Colors.transparent,
        indicatorColor: accentSoft,
        selectedIconTheme: const IconThemeData(color: accent),
        unselectedIconTheme: const IconThemeData(color: inkMuted),
        selectedLabelTextStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: ink,
        ),
        unselectedLabelTextStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: inkMuted,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accent,
          foregroundColor: surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: ink,
          side: const BorderSide(color: outline),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      textTheme: const TextTheme(
        displaySmall: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w600,
          color: ink,
        ),
        headlineSmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: ink,
        ),
        titleMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: ink,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
          color: accent,
        ),
        bodyLarge: TextStyle(fontSize: 16, height: 1.5, color: ink),
        bodyMedium: TextStyle(fontSize: 14, height: 1.4, color: inkMuted),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: ink,
        ),
      ),
    );
  }
}
