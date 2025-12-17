import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myitihas/pages/Chat/chat_itihas_page.dart';
import 'package:myitihas/pages/stories_page.dart';
import 'package:myitihas/pages/story_generator.dart';
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
    "Story Generator",
    "ChatItihas",
    "Community Stories",
    "",
    "Maps",
  ];

  List<Widget> pages = [
    StoryGeneratorPage(),
    ChatItihasPage(),
    StoriesPage(),
    Center(child: Text("Maps Page")),
    Center(child: Text("Maps Page")),
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
    double height = MediaQuery.of(context).size.height;
    double aspectRatio = MediaQuery.of(context).size.aspectRatio;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * 0.1),
        child: SafeArea(
          child: Container(
            height: height * 0.08,
            decoration: BoxDecoration(
              gradient:
                  Theme.of(context).brightness == Brightness.dark
                      ? DarkColors.featureCardGradient
                      : LightColors.featureCardGradient,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).secondaryHeaderColor.withAlpha(120),
                  blurRadius: 200,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    titles[currentBottomBarIndex],
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: aspectRatio > 0.5 ? 24 : 20,
                      foreground:
                          Paint()
                            ..shader = (Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? DarkColors.messageUserGradient
                                    : LightColors.messageUserGradient)
                                .createShader(Rect.fromLTWH(0, 0, 200, 70)),
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
                      gradient: RadialGradient(
                        colors: [
                          Color(0xFF1d4ed8).withAlpha(127),
                          Color(0xFF1d4ed8),
                        ],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.person, color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
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
        padding: EdgeInsets.all(10),
        child: pages[currentBottomBarIndex],
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient:
              Theme.of(context).brightness == Brightness.dark
                  ? DarkColors.messageUserGradient
                  : LightColors.messageUserGradient,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.transparent,
          elevation: 0,
          shape: CircleBorder(),
          child: Icon(
            CupertinoIcons.pencil,
            color: Colors.white,
            weight: 700,
            size: aspectRatio > 0.5 ? 30 : 28,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: height * 0.12,
        decoration: BoxDecoration(
          gradient:
              Theme.of(context).brightness == Brightness.dark
                  ? DarkColors.featureCardGradient
                  : LightColors.featureCardGradient,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).secondaryHeaderColor.withAlpha(120),
              blurRadius: 200,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              currentBottomBarIndex = index;
            });
          },
          elevation: 0,
          currentIndex: currentBottomBarIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Theme.of(context).secondaryHeaderColor,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedIconTheme: IconThemeData(
            size: 25,
            color: Theme.of(context).primaryColor,
          ),
          unselectedIconTheme: IconThemeData(
            size: 20,
            color: Theme.of(context).secondaryHeaderColor.withOpacity(0.6),
          ),
          items: [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.sparkles),
              label: "Storys",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_rounded),
              label: "Chats",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.video_library_rounded),
              label: "Academics",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.child_care_rounded),
              label: "Job Portal",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map_rounded),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
