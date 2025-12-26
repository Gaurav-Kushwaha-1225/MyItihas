import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myitihas/pages/Chat/Widget/status_page.dart';
import 'package:myitihas/utils/constants.dart';
import 'package:myitihas/utils/theme.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class ChatItihasPage extends StatefulWidget {
  const ChatItihasPage({super.key});

  @override
  State<ChatItihasPage> createState() => _ChatItihasPageState();
}

class _ChatItihasPageState extends State<ChatItihasPage> {
  int _selectedTabIndex = 0;
  final List<String> _tabs = ["Chats", "Groups", "Status"];

  // Selection State
  final Set<int> _selectedIndices = {};
  bool get _isSelectionMode => _selectedIndices.isNotEmpty;

  // Mock Data with Types
  final List<Map<String, dynamic>> _chats = [
    {
      "name": "Aditya Gupta",
      "msg": "Ok, Let me check",
      "time": "09:38 AM",
      "unread": 0,
      "isOnline": true,
      "color": Colors.blueAccent,
      "type": "chat",
    },
    {
      "name": "Piyush Sharma",
      "msg": "Piyush is typing...",
      "time": "09:30 AM",
      "unread": 2,
      "isOnline": true,
      "isTyping": true,
      "color": Colors.orangeAccent,
      "type": "chat",
    },
    {
      "name": "Old Group",
      "msg": "See you tomorrow at the temple...",
      "time": "Yesterday",
      "unread": 5,
      "isOnline": false,
      "color": Colors.purpleAccent,
      "type": "group", // Identifies as a group
    },
    {
      "name": "Ram Kumar",
      "msg": "Oh... thank you so much!",
      "time": "26 May",
      "unread": 0,
      "isOnline": true,
      "color": Colors.teal,
      "type": "chat",
    },
    {
      "name": "Devotees United",
      "msg": "Admin: Event started.",
      "time": "12:00 PM",
      "unread": 10,
      "isOnline": false,
      "color": Colors.indigoAccent,
      "type": "group", // Identifies as a group
    },
  ];

  void _toggleSelection(int index) {
    setState(() {
      if (_selectedIndices.contains(index)) {
        _selectedIndices.remove(index);
      } else {
        _selectedIndices.add(index);
      }
    });
  }

  void _exitSelectionMode() {
    setState(() {
      _selectedIndices.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? DarkColors.textPrimary : LightColors.textPrimary;
    final glassBg = isDark ? DarkColors.glassBg : Colors.white.withOpacity(0.9);
    final accentColor = isDark
        ? DarkColors.accentPrimary
        : LightColors.accentPrimary;

    final Gradient selectedGradient = LinearGradient(
      colors: isDark
          ? [Colors.white, DarkColors.accentPrimary]
          : [textColor, textColor],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );

    // Filter Logic based on selected tab
    List<Map<String, dynamic>> displayedChats = [];
    if (_selectedTabIndex == 0) {
      displayedChats = _chats.where((c) => c['type'] == 'chat').toList();
    } else if (_selectedTabIndex == 1) {
      displayedChats = _chats.where((c) => c['type'] == 'group').toList();
    } else {
      displayedChats = []; // Status not implemented yet
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.5.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            DarkColors.accentPrimary.withAlpha(5),

            isDark ? Color(0xFF1E293B) : Color(0xFFF1F5F9),
          ],
          transform: GradientRotation(3.14 / 1.5),
        ),
      ),

      child: Column(
        children: [
          SizedBox(height: 6.h),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Map",
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
                  child: Icon(
                    Icons.dark_mode,
                    color: isDark ? Colors.white : Colors.black,
                    size: 18.sp,
                  ),
                ),
              ],
            ),
          ),
          if (_isSelectionMode)
            _buildSelectionHeader(isDark)
          else
            SizedBox(height: 2.h),

          // Search Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                height: 6.5.h,
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.black.withOpacity(0.35)
                      : Colors.white.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: isDark
                        ? Colors.white.withOpacity(0.25)
                        : Colors.grey.withOpacity(0.45),
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.search,
                      color: isDark
                          ? Colors.white.withOpacity(0.85)
                          : Colors.black87,
                      size: 22.sp,
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: Material(
                        type: MaterialType.transparency,
                        child: TextField(
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withOpacity(0.85)
                                : Colors.black87,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          cursorColor: isDark
                              ? Colors.white.withOpacity(0.85)
                              : Colors.black87,
                          decoration: InputDecoration(
                            hintText: _selectedTabIndex == 1
                                ? "Search groups..."
                                : "Search conversations...",
                            hintStyle: TextStyle(
                              color: isDark
                                  ? Colors.white.withOpacity(0.85)
                                  : Colors.black87,
                              fontSize: 16.sp,
                            ),

                            filled: false,
                            fillColor: Colors.transparent,

                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,

                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: 2.5.h),

          // Tabs
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.5.w),
                child: Row(
                  children: List.generate(_tabs.length, (index) {
                    bool isSelected = _selectedTabIndex == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedTabIndex = index;
                          _exitSelectionMode();
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 3.w),
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.w,
                          vertical: 1.2.h,
                        ),
                        decoration: BoxDecoration(
                          gradient: isSelected
                              ? (isDark
                                    ? DarkColors.messageUserGradient
                                    : LightColors.messageUserGradient)
                              : null,
                          color: isSelected ? null : Colors.transparent,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Text(
                          _tabs[index],
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w500,
                            color: isSelected
                                ? Colors.white
                                : (isDark
                                      ? DarkColors.textSecondary
                                      : LightColors.textSecondary),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              _buildHeaderActionButton(
                isDark,
                Icons.add,
                () => context.push('/new-chat'),
              ),
              SizedBox(width: 3.w),
              _buildHeaderActionButton(
                isDark,
                CupertinoIcons.camera_fill,
                () {},
              ),
            ],
          ),

          SizedBox(height: 1.h),

          // List
          Expanded(
            child: _selectedTabIndex == 2
                ? const StatusPage()
                : displayedChats.isEmpty
                ? Center(
                    child: Text(
                      "No ${_tabs[_selectedTabIndex]} found",
                      style: TextStyle(
                        color: isDark ? Colors.grey : Colors.black54,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 1.w),
                    itemCount: displayedChats.length,
                    itemBuilder: (context, index) {
                      final chat = displayedChats[index];
                      final isSelected = _selectedIndices.contains(index);

                      return GestureDetector(
                        onLongPress: () => _toggleSelection(index),
                        onTap: () {
                          if (_isSelectionMode) {
                            _toggleSelection(index);
                          } else {
                            context.push(
                              '/chat_detail',
                              extra: {
                                'name': chat['name'],
                                'color': chat['color'],
                                'isGroup':
                                    chat['type'] == 'group', // Pass group flag
                              },
                            );
                          }
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          margin: EdgeInsets.only(bottom: 0.5.h),
                          padding: EdgeInsets.symmetric(
                            vertical: 1.5.h,
                            horizontal: 1.w,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? (isDark
                                      ? Colors.white.withOpacity(0.05)
                                      : Colors.blue.withOpacity(0.05))
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(15.sp),
                          ),
                          child: Row(
                            children: [
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    width: 14.w,
                                    height: 14.w,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: chat['color'].withOpacity(0.2),
                                    ),
                                    child: Center(
                                      child: Text(
                                        chat['name'][0],
                                        style: GoogleFonts.inter(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                          color: chat['color'],
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (isSelected)
                                    Positioned(
                                      bottom: -1,
                                      right: -1,
                                      child: Container(
                                        width: 5.w,
                                        height: 5.w,
                                        decoration: BoxDecoration(
                                          color: DarkColors.profileGreen,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: isDark
                                                ? DarkColors.bgColor
                                                : Colors.white,
                                            width: 1,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.check_sharp,
                                          size: 16.sp,

                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  else if (chat['isOnline'] == true)
                                    Positioned(
                                      right: 1,
                                      bottom: 1,
                                      child: Container(
                                        width: 3.w,
                                        height: 3.w,
                                        decoration: BoxDecoration(
                                          color: DarkColors.profileGreen,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: isDark
                                                ? DarkColors.bgColor
                                                : Colors.white,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              SizedBox(width: 4.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      chat['name'],
                                      style: GoogleFonts.inter(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w700,
                                        color: isDark
                                            ? DarkColors.textPrimary
                                            : LightColors.textPrimary,
                                      ),
                                    ),
                                    SizedBox(height: 0.5.h),
                                    Text(
                                      chat['msg'],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.inter(
                                        fontSize: 14.sp,
                                        color: chat['isTyping'] == true
                                            ? isDark
                                                  ? DarkColors.accentPrimary
                                                  : LightColors.accentPrimary
                                            : (isDark
                                                  ? DarkColors.textSecondary
                                                  : LightColors.textSecondary),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (!isSelected)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      chat['time'],
                                      style: GoogleFonts.inter(
                                        fontSize: 12.sp,
                                        color: isDark
                                            ? DarkColors.textSecondary
                                            : LightColors.textSecondary,
                                      ),
                                    ),
                                    if (chat['unread'] > 0) ...[
                                      SizedBox(height: 0.5.h),
                                      Container(
                                        height: 2.5.h,
                                        width: 2.5.h,
                                        padding: EdgeInsets.all(0.5.h),
                                        decoration: BoxDecoration(
                                          gradient: isDark
                                              ? DarkColors.messageUserGradient
                                              : LightColors.messageUserGradient,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Text(
                                            chat['unread'].toString(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionHeader(bool isDark) {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            Icons.close,
            color: isDark ? Colors.white : Colors.black,
            size: 20.sp,
          ),
          onPressed: _exitSelectionMode,
        ),
        SizedBox(width: 2.w),
        Text(
          "${_selectedIndices.length}",
          style: GoogleFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        Spacer(),
        IconButton(
          icon: Icon(
            Icons.notifications_off_outlined,
            color: isDark ? Colors.white : Colors.black,
            size: 20.sp,
          ),
          onPressed: _exitSelectionMode,
        ),
        IconButton(
          icon: Icon(
            Icons.delete_outline,
            color: isDark ? Colors.white : Colors.black,
            size: 20.sp,
          ),
          onPressed: _exitSelectionMode,
        ),
      ],
    );
  }

  Widget _buildHeaderActionButton(
    bool isDark,
    IconData icon,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 8.w,
        height: 8.w,
        decoration: BoxDecoration(
          color: isDark ? DarkColors.glassBg : Colors.grey.shade200,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 18.sp,
          color: isDark ? DarkColors.accentPrimary : LightColors.accentPrimary,
        ),
      ),
    );
  }
}
