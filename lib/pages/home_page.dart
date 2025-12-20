import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myitihas/pages/Map/akhanda_bharat_map_page.dart';
import 'package:sizer/sizer.dart';
import 'package:myitihas/config/theme/gradient_extension.dart';
import 'package:myitihas/pages/story_generator.dart';
import 'package:myitihas/utils/theme.dart';
import 'package:myitihas/features/social/presentation/pages/social_feed_page.dart';
import 'package:myitihas/features/chat/presentation/pages/chat_list_page.dart';
import 'package:myitihas/features/social/presentation/pages/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentBottomBarIndex = 0;

  final List<String> titles = [
    "Story Generator",
    "Chat",
    "Social Feed",
    "Map",
    "Profile",
  ];

  final List<Widget> pages = [
    const StoryGeneratorPage(),
    const ChatListPage(),
    const SocialFeedPage(),
    const AkhandaBharatMapPage(),
    const ProfilePage(userId: 'user_001'),
  ];
  final Gradient selectedGradient = const LinearGradient(
    colors: [
      Color(0xFF4FC3F7), // light blue
      Color(0xFF7C4DFF), // purple
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(10.h),
      child: SafeArea(
        child: Container(
          height: 8.h,
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          decoration: BoxDecoration(
            gradient: Theme.of(
              context,
            ).extension<GradientExtension>()!.heroBackgroundGradient,
            boxShadow: [
              BoxShadow(
                color: Theme.of(
                  context,
                ).colorScheme.onSurfaceVariant.withValues(alpha: 0.47),
                blurRadius: 200,
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  titles[currentBottomBarIndex],
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.sp,
                    foreground: Paint()
                      ..shader = selectedGradient.createShader(
                        Rect.fromLTWH(0, 0, 60.w, 8.h),
                      ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  context.read<ThemeBloc>().add(ToggleTheme());
                },
                child: Container(
                  width: 11.w,
                  height: 11.w,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.person, color: Colors.white, size: 16.sp),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Theme.of(context).primaryColor.withAlpha(5),
              Theme.of(context).brightness == Brightness.dark
                  ? Color(0xFF1E293B)
                  : Color(0xFFF1F5F9),
            ],
            transform: GradientRotation(3.14 / 1.5),
          ),
        ),
        key: ValueKey<int>(currentBottomBarIndex),
        child: pages[currentBottomBarIndex],
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    // NEW: blue–purple gradient (replace old pinkish one)
    final Gradient selectedGradient = const LinearGradient(
      colors: [
        Colors.cyanAccent, // light blue
        Color(0xFF7C4DFF), // purple
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    final double barHeight = 9.h;
    final double containerHeight = 13.h;

    return SizedBox(
      height: containerHeight,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 2.w, right: 2.w, bottom: 1.5.h),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32.sp),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                child: Container(
                  height: barHeight,
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.black.withOpacity(0.1)
                        : Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(32.sp),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.25),
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 3.h,
            left: 1.w,
            right: 1.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildPopupItem(
                  0,
                  Icons.auto_awesome_rounded,
                  "StoryGen",
                  isDark,
                  selectedGradient,
                ),
                _buildPopupItem(
                  1,
                  Icons.chat_bubble_rounded,
                  "Chat",
                  isDark,
                  selectedGradient,
                ),
                _buildPopupItem(
                  2,
                  Icons.forum_rounded,
                  "Social",
                  isDark,
                  selectedGradient,
                ),
                _buildPopupItem(
                  3,
                  Icons.map_rounded,
                  "Map",
                  isDark,
                  selectedGradient,
                ),
                _buildPopupItem(
                  4,
                  Icons.person_rounded,
                  "Profile",
                  isDark,
                  selectedGradient,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopupItem(
    int index,
    IconData icon,
    String label,
    bool isDark,
    Gradient selectedGradient,
  ) {
    final bool isSelected = currentBottomBarIndex == index;

    return GestureDetector(
      onTap: () => setState(() => currentBottomBarIndex = index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutBack,
            transform: Matrix4.translationValues(0, isSelected ? -1.0.h : 0, 0),
            width: isSelected ? 13.w : 6.w,
            height: isSelected ? 13.w : 6.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: isSelected ? selectedGradient : null,
            ),
            child: Icon(
              icon,
              size: isSelected ? 20.sp : 18.sp,
              color: isSelected
                  ? Colors.white
                  : (isDark ? Colors.grey[500] : Colors.grey[600]),
            ),
          ),
          SizedBox(height: 0.5.h),
          Padding(
            padding: EdgeInsets.only(bottom: 0.5.h),
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 13.5.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected
                    ? (isDark ? Colors.white : const Color(0xFF6E48AA))
                    : (isDark ? Colors.grey[500] : Colors.grey[600]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
