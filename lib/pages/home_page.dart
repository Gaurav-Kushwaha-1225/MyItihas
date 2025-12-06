import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myitihas/utils/constants.dart';
import 'package:myitihas/utils/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentBottomBarIndex = 0;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * 0.1),
        child: SafeArea(
          child: Container(
            height: height * 0.1,
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
                    'MyItihas',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: 25,
                      color: Theme.of(context).textTheme.displayMedium?.color,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    context.read<ThemeBloc>().add(ToggleTheme());
                  },
                  child: Container(
                    width: 46,
                    height: 46,
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
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).brightness == Brightness.dark
                  ? Color(0xFF0F172A)
                  : Color(0xFFF8FAFC),
              Theme.of(context).brightness == Brightness.dark
                  ? Color(0xFF1E293B)
                  : Color(0xFFF1F5F9),
            ],
          ),
        ),
        child: Center(
          child: Text('Welcome to the Home Page!', style: GoogleFonts.inter()),
        ),
      ),
      bottomNavigationBar: Container(
        height: height * 0.1,
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
          selectedIconTheme: IconThemeData(size: 30, color: Theme.of(context).primaryColor),
          unselectedIconTheme: IconThemeData(
            size: 30,
            color: Theme.of(context).secondaryHeaderColor.withOpacity(0.6),
          ),
          items: [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.sparkles, size: 40),
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
