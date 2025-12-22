import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:myitihas/config/routes.dart';
import 'package:myitihas/config/theme/gradient_extension.dart';

import 'package:myitihas/pages/home_content_page.dart';
import 'package:myitihas/pages/Chat/chat_itihas_page.dart';

import 'package:myitihas/features/social/presentation/pages/social_feed_page.dart';
import 'package:myitihas/features/social/presentation/pages/profile_page.dart';
import 'package:myitihas/features/social/domain/repositories/user_repository.dart';
import 'package:myitihas/core/di/injection_container.dart';

import 'package:myitihas/services/supabase_service.dart';
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
  String? _currentUserId;

  List<String> titles = [
    "Home",
    "Chat",
    // "Story Generator",
    "Social Feed",
    "Profile",
  ];

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    final userRepository = getIt<UserRepository>();
    final result = await userRepository.getCurrentUser();
    result.fold(
      (failure) => null,
      (user) {
        if (mounted) {
          setState(() {
            _currentUserId = user.id;
          });
        }
      },
    );
  }

  List<Widget> get pages => [
    const HomeContentPage(),
    const ChatItihasPage(),
    // const StoryGeneratorPage(),
    const SocialFeedPage(),
    ProfilePage(userId: _currentUserId ?? 'user_001'),
  ];

  void _handleUserIconTap() {
    // Single tap - do nothing or navigate to profile
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
                if (currentBottomBarIndex == 0)
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () => context.push('/discover'),
                    tooltip: 'Search',
                  ),
                if (currentBottomBarIndex == 3 && _currentUserId != null)
                  IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () => context.push('/settings'),
                    tooltip: 'Settings',
                  ),
                GestureDetector(
                  onTap: _handleUserIconTap,
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
