import 'package:flutter/material.dart';

class BackgroundDecoration {
  static BoxDecoration premiumDark() {
    return const BoxDecoration(
      gradient: RadialGradient(
        center: Alignment(0, -0.5), // Focus light slightly above the center
        radius: 1.5,
        colors: [
          Color(0xFF1E3A5F), // Lighter Navy Blue (Center Glow)
          Color(0xFF0D1B2A), // Deep Navy Blue (Outer)
          Color(0xFF070B14), // Almost Black (Edges)
        ],
        stops: [0.0, 0.6, 1.0],
      ),
    );
  }

  // Optional: Add a subtle overlay for that "frosted glass" look
  static Widget buildStackBackground({required Widget child}) {
    return Container(
      decoration: premiumDark(),
      child: Stack(
        children: [
          // Subtle glow effect in the top-right
          Positioned(
            top: -100,
            right: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blueAccent.withOpacity(0.05),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
