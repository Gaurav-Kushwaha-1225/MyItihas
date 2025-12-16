import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myitihas/pages/Chat/chat_itihas_page.dart';
import 'package:myitihas/pages/stories_page.dart';
import 'package:myitihas/pages/story_generator.dart';
import 'package:myitihas/utils/constants.dart';
import 'package:myitihas/utils/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentBottomBarIndex = 0;

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
                  onTap: () {
                    context.read<ThemeBloc>().add(ToggleTheme());
                  },
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
