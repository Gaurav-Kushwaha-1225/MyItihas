import 'package:flutter/material.dart';

class AppColorSchemes {
  /// Light color scheme matching website light theme
  static ColorScheme get lightColorScheme => const ColorScheme(
    brightness: Brightness.light,

    primary: Color(0xFF3B82F6),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFDBE7FF),
    onPrimaryContainer: Color(0xFF001849),
    secondary: Color(0xFF8B5CF6),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFE8DEFF),
    onSecondaryContainer: Color(0xFF270059),
    tertiary: Color(0xFFE879F9),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFFBD5FF),
    onTertiaryContainer: Color(0xFF3D0042),
    error: Color(0xFFDC2626), // --danger-color (light)
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFFFDAD6),
    onErrorContainer: Color(0xFF410002),
    surface: Color(0xFFFFFFFF),
    onSurface: Color(0xFF1E293B),
    surfaceContainerHighest: Color(0xFFF8FAFC),
    surfaceContainerHigh: Color(0xFFFAFBFC),
    surfaceContainer: Color(0xFFF1F5F9),
    surfaceContainerLow: Color(0xFFFCFCFC),
    surfaceContainerLowest: Color(0xFFFFFFFF),
    onSurfaceVariant: Color(0xFF475569),
    outline: Color(0xFFCBD5E1),
    outlineVariant: Color(0xFFE2E8F0),
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),

    inverseSurface: Color(0xFF1E293B),
    onInverseSurface: Color(0xFFF1F5F9),
    inversePrimary: Color(0xFF60A5FA),
    surfaceTint: Color(0xFF3B82F6),
  );

  /// Dark color scheme matching website dark theme
  static ColorScheme get darkColorScheme => const ColorScheme(
    brightness: Brightness.dark,

    primary: Color(0xFF38BDF8),
    onPrimary: Color(0xFF003547),
    primaryContainer: Color(0xFF004D66),
    onPrimaryContainer: Color(0xFFB8E7FF),
    secondary: Color(0xFFA78BFA),
    onSecondary: Color(0xFF3B2770),
    secondaryContainer: Color(0xFF523D88),
    onSecondaryContainer: Color(0xFFE8DEFF),
    tertiary: Color(0xFFE879F9),
    onTertiary: Color(0xFF4D0057),
    tertiaryContainer: Color(0xFF6E007C),
    onTertiaryContainer: Color(0xFFFBD5FF),
    error: Color(0xFFEF4444),
    onError: Color(0xFF690005),
    errorContainer: Color(0xFF93000A),
    onErrorContainer: Color(0xFFFFDAD6),
    surface: Color(0xFF020617),
    onSurface: Color(0xFFE2E8F0),
    surfaceContainerHighest: Color(0xFF1E293B),
    surfaceContainerHigh: Color(0xFF0F172A),
    surfaceContainer: Color(0xFF0F172A),
    surfaceContainerLow: Color(0xFF020617),
    surfaceContainerLowest: Color(0xFF000000),
    onSurfaceVariant: Color(0xFF94A3B8),
    outline: Color(0xFF475569),
    outlineVariant: Color(0xFF334155),
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),

    inverseSurface: Color(0xFFE2E8F0),
    onInverseSurface: Color(0xFF1E293B),
    inversePrimary: Color(0xFF006491),
    surfaceTint: Color(0xFF38BDF8),
  );
}
