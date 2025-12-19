import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:myitihas/config/routes.dart';
import 'package:myitihas/config/theme/gradient_extension.dart';

import 'package:myitihas/pages/home_content_page.dart';

import 'package:myitihas/features/chat/presentation/pages/chat_list_page.dart';
import 'package:myitihas/features/social/presentation/pages/social_feed_page.dart';
import 'package:myitihas/features/social/presentation/pages/profile_page.dart';

import 'package:myitihas/services/supabase_service.dart';
import 'package:myitihas/utils/constants.dart';
import 'package:myitihas/utils/theme.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentBottomBarIndex = 0;
  int _tapCount = 0;
  DateTime? _lastTapTime;

  List<String> titles = [
    "Home",
    "Chat",
    // "Story Generator",
    "Social Feed",
    "Profile",
  ];

  List<Widget> pages = [
    const HomeContentPage(),
    const ChatListPage(),
    // const StoryGeneratorPage(),
    const SocialFeedPage(),
    const ProfilePage(userId: 'user_001'),
  ];

  void _handleUserIconTap() {
    final now = DateTime.now();

    // Check if this is a double tap (within 300ms)
    if (_lastTapTime != null &&
        now.difference(_lastTapTime!) < Duration(milliseconds: 300)) {
      _tapCount++;

      // Double tap detected
      if (_tapCount == 2) {
        _handleDoubleTap();
        _tapCount = 0;
        _lastTapTime = null;
        return;
      }
    } else {
      _tapCount = 1;
    }

    _lastTapTime = now;

    // Single tap - toggle theme
    Future.delayed(Duration(milliseconds: 300), () {
      if (_tapCount == 1) {
        context.read<ThemeBloc>().add(ToggleTheme());
      }
      _tapCount = 0;
    });
  }

  void _handleDoubleTap() {
    final authService = SupabaseService.authService;

    if (authService.isAuthenticated()) {
      // User is logged in, logout
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text('Logout'),
              content: Text('Are you sure you want to logout?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    // Close dialog first
                    Navigator.pop(context);

                    // Call signOut - GoRouter redirect handles navigation
                    // When session becomes null, GoRouter redirects to /login
                    await authService.signOut();
                  },
                  child: Text('Logout', style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
      );
    } else {
      // Not logged in, show message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No user logged in. Long press to sign up!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _handleLongPress() {
    final authService = SupabaseService.authService;

    if (authService.isAuthenticated()) {
      // User is logged in, show their display name
      final user = authService.getCurrentUser();
      final displayName =
          user?.userMetadata?['display_name'] ??
          user?.userMetadata?['full_name'] ??
          user?.email ??
          'User';

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Logged in as: $displayName'),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.green,
          action: SnackBarAction(
            label: 'OK',
            textColor: Colors.white,
            onPressed: () {},
          ),
        ),
      );
    } else {
      // Not logged in, show message and navigate to signup
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Not logged in. Redirecting to Sign Up...'),
          duration: Duration(seconds: 2),
        ),
      );

      Future.delayed(Duration(milliseconds: 500), () {
        context.push('/signup');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double aspectRatio = MediaQuery.sizeOf(context).aspectRatio;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * 0.1),
        child: SafeArea(
          child: Container(
            height: height * 0.08,
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
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    titles[currentBottomBarIndex],
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: aspectRatio > 0.5 ? 24 : 20,
                      foreground: Paint()
                        ..shader = Theme.of(context)
                            .extension<GradientExtension>()!
                            .brandTextGradient
                            .createShader(const Rect.fromLTWH(0, 0, 200, 70)),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _handleUserIconTap,
                  onLongPress: _handleLongPress,
                  child: Container(
                    width: aspectRatio > 0.5 ? 46 : 40,
                    height: aspectRatio > 0.5 ? 46 : 40,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        switchInCurve: Curves.easeIn,
        switchOutCurve: Curves.easeOut,
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: currentBottomBarIndex == 2
            ? Container(
                key: ValueKey<int>(currentBottomBarIndex),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: 0.02),
                      Theme.of(context).colorScheme.surfaceContainerHigh,
                    ],
                    transform: const GradientRotation(3.14 / 1.5),
                  ),
                ),
                child: pages[currentBottomBarIndex],
              )
            : Container(
                key: ValueKey<int>(currentBottomBarIndex),
                child: pages[currentBottomBarIndex],
              ),
      ),
      bottomNavigationBar: Container(
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
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: NavigationBar(
          onDestinationSelected: (index) {
            setState(() {
              currentBottomBarIndex = index;
            });
          },
          selectedIndex: currentBottomBarIndex,
          backgroundColor: Colors.transparent,
          indicatorColor: Theme.of(context).colorScheme.primaryContainer,
          elevation: 0,
          height: height * 0.08,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          destinations: [
            NavigationDestination(
              icon: Icon(
                Icons.home_rounded,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              selectedIcon: Icon(
                Icons.home_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
              label: "Home",
            ),
            NavigationDestination(
              icon: Icon(
                Icons.chat_rounded,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              selectedIcon: Icon(
                Icons.chat_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
              label: "Chat",
            ),
            // NavigationDestination(
            //   icon: Center(
            //     child: Container(
            //       height: 30,
            //       decoration: BoxDecoration(
            //         shape: BoxShape.rectangle,
            //         borderRadius: BorderRadius.circular(24),
            //         gradient: Theme.of(
            //           context,
            //         ).extension<GradientExtension>()!.primaryButtonGradient,
            //         color: Theme.of(
            //           context,
            //         ).colorScheme.surfaceContainerHighest,
            //         boxShadow: [
            //           BoxShadow(
            //             color: Theme.of(
            //               context,
            //             ).colorScheme.primary.withValues(alpha: 0.4),
            //             blurRadius: 12,
            //             offset: const Offset(0, 4),
            //           ),
            //         ],
            //       ),
            //       padding: const EdgeInsets.all(12),
            //       child: Icon(
            //         CupertinoIcons.sparkles,
            //         color: Theme.of(
            //           context,
            //         ).colorScheme.surfaceContainerHighest,
            //         size: 24,
            //       ),
            //     ),
            //   ),
            //   // selectedIcon: Container(
            //   //   decoration: BoxDecoration(
            //   //     shape: BoxShape.rectangle,
            //   //     borderRadius: BorderRadius.circular(24),
            //   //     gradient: Theme.of(
            //   //       context,
            //   //     ).extension<GradientExtension>()!.primaryButtonGradient,
            //   //     boxShadow: [
            //   //       BoxShadow(
            //   //         color: Theme.of(
            //   //           context,
            //   //         ).colorScheme.primary.withValues(alpha: 0.4),
            //   //         blurRadius: 12,
            //   //         offset: const Offset(0, 4),
            //   //       ),
            //   //     ],
            //   //   ),
            //   //   padding: const EdgeInsets.all(12),
            //   //   child: const Icon(
            //   //     CupertinoIcons.sparkles,
            //   //     color: Colors.white,
            //   //     size: 24,
            //   //   ),
            //   // ),
            //   label: "Story Generator",
            // ),
            NavigationDestination(
              icon: Icon(
                Icons.people_rounded,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              selectedIcon: Icon(
                Icons.people_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
              label: "Social Feed",
            ),
            NavigationDestination(
              icon: Icon(
                Icons.person_rounded,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              selectedIcon: Icon(
                Icons.person_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
              label: "Profile",
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          StoryGeneratorRoute().go(context);
        },
        backgroundColor: Colors.transparent,
        shape: const CircleBorder(),
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: Theme.of(
              context,
            ).extension<GradientExtension>()!.primaryButtonGradient,
            boxShadow: [
              BoxShadow(
                color: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: 0.4),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(
            CupertinoIcons.sparkles,
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            size: 28,
          ),
        ),
      ),
      floatingActionButtonLocation: .centerDocked,
    );
  }
}
