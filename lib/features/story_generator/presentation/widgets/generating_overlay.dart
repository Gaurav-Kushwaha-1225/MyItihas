import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Full-screen overlay shown during story generation
class GeneratingOverlay extends StatefulWidget {
  final String? message;
  final VoidCallback? onCancel;

  const GeneratingOverlay({super.key, this.message, this.onCancel});

  @override
  State<GeneratingOverlay> createState() => _GeneratingOverlayState();
}

class _GeneratingOverlayState extends State<GeneratingOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  final List<String> _defaultMessages = [
    'Consulting the ancient scriptures...',
    'Weaving your tale...',
    'Adding divine wisdom...',
    'Polishing the narrative...',
    'Almost there...',
  ];

  int _messageIndex = 0;
  Timer? _messageTimer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _scaleAnimation = Tween<double>(
      begin: 0.7,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _controller.forward();

    // Start message rotation if no external message provided
    if (widget.message == null) {
      _startMessageRotation();
    }
  }

  void _startMessageRotation() {
    _messageTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (mounted) {
        setState(() {
          _messageIndex = (_messageIndex + 1) % _defaultMessages.length;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _messageTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final currentMessage = widget.message ?? _defaultMessages[_messageIndex];

    return Material(
      color: Colors.transparent,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          color: colorScheme.scrim.withValues(alpha: 0.85),
          child: SafeArea(
            child: Center(
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 40.w),
                  padding: EdgeInsets.all(32.w),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(24.r),
                    boxShadow: [
                      BoxShadow(
                        color: colorScheme.primary.withValues(alpha: 0.2),
                        blurRadius: 30,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Animated icon
                      _AnimatedGeneratorIcon(),
                      SizedBox(height: 24.h),
                      // Title
                      Text(
                        'Creating Your Story',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      // Progress message
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        child: Text(
                          currentMessage,
                          key: ValueKey(currentMessage),
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: colorScheme.onSurfaceVariant,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      // Progress indicator
                      SizedBox(
                        width: 200.w,
                        child: LinearProgressIndicator(
                          borderRadius: BorderRadius.circular(4.r),
                          backgroundColor: colorScheme.primaryContainer
                              .withValues(alpha: 0.3),
                        ),
                      ),
                      if (widget.onCancel != null) ...[
                        SizedBox(height: 24.h),
                        TextButton(
                          onPressed: widget.onCancel,
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: colorScheme.error),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AnimatedGeneratorIcon extends StatefulWidget {
  @override
  State<_AnimatedGeneratorIcon> createState() => _AnimatedGeneratorIconState();
}

class _AnimatedGeneratorIconState extends State<_AnimatedGeneratorIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    _rotationAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.15,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: 1.0 + ((_pulseAnimation.value - 1.0) * 0.5),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Outer glow ring
              Transform.rotate(
                angle: _rotationAnimation.value * 2 * 3.14159,
                child: Container(
                  width: 80.w,
                  height: 80.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: SweepGradient(
                      colors: [
                        colorScheme.primary.withValues(alpha: 0.0),
                        colorScheme.primary.withValues(alpha: 0.5),
                        colorScheme.secondary.withValues(alpha: 0.5),
                        colorScheme.primary.withValues(alpha: 0.0),
                      ],
                    ),
                  ),
                ),
              ),
              // Inner circle
              Container(
                width: 64.w,
                height: 64.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [colorScheme.primary, colorScheme.secondary],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.primary.withValues(alpha: 0.4),
                      blurRadius: 16,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.auto_stories_rounded,
                  color: Colors.white,
                  size: 32.sp,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
