import 'package:flutter/material.dart';

@Deprecated('Use Material 3 ColorScheme and GradientExtension instead')
class DarkColors {
  // Base colors
  static const Color bgColor = Color(0xFF020617);
  static const Color textPrimary = Color(0xFFE2E8F0);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color accentPrimary = Color(0xFF38BDF8);
  static const Color accentSecondary = Color(0xFFA78BFA);

  // Glass and glow effects
  static const Color glassBg = Color.fromRGBO(15, 23, 42, 0.5);
  static const Color glassBorder = Color.fromRGBO(56, 189, 248, 0.15);
  static const Color glassHoverBorder = Color.fromRGBO(56, 189, 248, 0.4);
  static const Color shadowColor = Color.fromRGBO(0, 0, 0, 0.5);
  static const Color glowPrimary = Color.fromRGBO(56, 189, 248, 0.1);
  static const Color glowSecondary = Color.fromRGBO(167, 139, 250, 0.1);

  // UI elements
  static const Color profileRed = Color(0xFFF87171);
  static const Color profileGreen = Color(0xFF4ADE80);
  static const Color profileSidebarBg = Color.fromRGBO(0, 0, 0, 0.2);
  static const Color profileInputBg = Color.fromRGBO(0, 0, 0, 0.2);
  static const Color inputBg = Color.fromRGBO(2, 6, 23, 0.7);
  static const Color messageBotBg = Color(0xFF1E293B);
  static const Color messageUserBgStart = Color(0xFF38BDF8);
  static const Color messageUserBgEnd = Color(0xFFA78BFA);
  static const Color dangerColor = Color(0xFFEF4444);
  static const Color highlightBg = Color.fromRGBO(56, 189, 248, 0.3);

  // Gradients
  static const LinearGradient messageUserGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [messageUserBgStart, messageUserBgEnd],
  );

  static const RadialGradient epicRightGradient = RadialGradient(
    center: Alignment.center,
    colors: [Color(0xFF1E293B), Color(0xFF020617)],
  );

  static const LinearGradient featureCardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
  );
}

@Deprecated('Use Material 3 ColorScheme and GradientExtension instead')
class LightColors {
  // Base colors
  static const Color bgColor = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF475569);
  static const Color accentPrimary = Color(0xFF3B82F6);
  static const Color accentSecondary = Color(0xFF8B5CF6);

  // Glass and glow effects
  static const Color glassBg = Color.fromRGBO(255, 255, 255, 0.8);
  static const Color glassBorder = Color.fromRGBO(59, 130, 246, 0.15);
  static const Color glassHoverBorder = Color.fromRGBO(59, 130, 246, 0.4);
  static const Color shadowColor = Color.fromRGBO(0, 0, 0, 0.08);
  static const Color glowPrimary = Color.fromRGBO(59, 130, 246, 0.1);
  static const Color glowSecondary = Color.fromRGBO(139, 92, 246, 0.1);

  // UI elements
  static const Color profileRed = Color(0xFFDC2626);
  static const Color profileGreen = Color(0xFF059669);
  static const Color profileSidebarBg = Color.fromRGBO(248, 250, 252, 0.9);
  static const Color profileInputBg = Color.fromRGBO(241, 245, 249, 0.8);
  static const Color inputBg = Color(0xFFF8FAFC);
  static const Color messageBotBg = Color(0xFFF1F5F9);
  static const Color messageUserBgStart = Color(0xFF3B82F6);
  static const Color messageUserBgEnd = Color(0xFF8B5CF6);
  static const Color dangerColor = Color(0xFFDC2626);
  static const Color highlightBg = Color.fromRGBO(59, 130, 246, 0.15);
  static const Color cardBg = Color.fromRGBO(255, 255, 255, 0.9);

  // Gradients
  static const LinearGradient messageUserGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [messageUserBgStart, messageUserBgEnd],
  );

  static const LinearGradient epicRightGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFF8FAFC), Color(0xFFE2E8F0)],
  );

  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFFFFF), Color(0xFFF8FAFC), Color(0xFFE2E8F0)],
  );

  static const LinearGradient featureCardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFFFFF), Color(0xFFF8FAFC)],
  );
}
