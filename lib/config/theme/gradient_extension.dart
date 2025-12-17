import 'package:flutter/material.dart';

class GradientExtension extends ThemeExtension<GradientExtension> {
  final Gradient primaryButtonGradient;
  final Gradient brandTextGradient;
  final Gradient heroBackgroundGradient;
  final Color glassBackground;
  final Color glassBorder;

  const GradientExtension({
    required this.primaryButtonGradient,
    required this.brandTextGradient,
    required this.heroBackgroundGradient,
    required this.glassBackground,
    required this.glassBorder,
  });

  /// Light theme gradient configuration
  static final GradientExtension light = GradientExtension(
    primaryButtonGradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF3B82F6),
        Color(0xFF6366F1),
      ],
    ),
    brandTextGradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF1E293B),
        Color(0xFF3B82F6),
      ],
    ),
    heroBackgroundGradient: const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFFFFFFFF),
        Color(0xFFF8FAFC),
        Color(0xFFE2E8F0),
      ],
      stops: [0.0, 0.5, 1.0],
    ),
    glassBackground: const Color(0xFFFFFFFF).withValues(alpha: 0.8),
    glassBorder: const Color(0xFF3B82F6).withValues(alpha: 0.15),
  );

  /// Dark theme gradient configuration
  static final GradientExtension dark = GradientExtension(
    primaryButtonGradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF38BDF8),
        Color(0xFFA78BFA),
      ],
    ),
    brandTextGradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFFE2E8F0),
        Color(0xFF38BDF8),
      ],
    ),
    heroBackgroundGradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF0F172A),
        Color(0xFF1E293B),
        Color(0xFF0F172A),
      ],
      stops: [0.0, 0.5, 1.0],
    ),
    glassBackground: const Color(0xFF0F172A).withValues(alpha: 0.5),
    glassBorder: const Color(0xFF38BDF8).withValues(alpha: 0.15),
  );

  @override
  ThemeExtension<GradientExtension> copyWith({
    Gradient? primaryButtonGradient,
    Gradient? brandTextGradient,
    Gradient? heroBackgroundGradient,
    Color? glassBackground,
    Color? glassBorder,
  }) {
    return GradientExtension(
      primaryButtonGradient:
          primaryButtonGradient ?? this.primaryButtonGradient,
      brandTextGradient: brandTextGradient ?? this.brandTextGradient,
      heroBackgroundGradient:
          heroBackgroundGradient ?? this.heroBackgroundGradient,
      glassBackground: glassBackground ?? this.glassBackground,
      glassBorder: glassBorder ?? this.glassBorder,
    );
  }

  @override
  ThemeExtension<GradientExtension> lerp(
    covariant ThemeExtension<GradientExtension>? other,
    double t,
  ) {
    if (other is! GradientExtension) return this;

    return GradientExtension(
      primaryButtonGradient: Gradient.lerp(
        primaryButtonGradient,
        other.primaryButtonGradient,
        t,
      )!,
      brandTextGradient: Gradient.lerp(
        brandTextGradient,
        other.brandTextGradient,
        t,
      )!,
      heroBackgroundGradient: Gradient.lerp(
        heroBackgroundGradient,
        other.heroBackgroundGradient,
        t,
      )!,
      glassBackground: Color.lerp(glassBackground, other.glassBackground, t)!,
      glassBorder: Color.lerp(glassBorder, other.glassBorder, t)!,
    );
  }
}
