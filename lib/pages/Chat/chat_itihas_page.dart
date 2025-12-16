import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myitihas/utils/constants.dart';
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

    // Filter Logic based on selected tab
    List<Map<String, dynamic>> displayedChats = [];
    if (_selectedTabIndex == 0) {
      displayedChats = _chats.where((c) => c['type'] == 'chat').toList();
    } else if (_selectedTabIndex == 1) {
      displayedChats = _chats.where((c) => c['type'] == 'group').toList();
    } else {
      displayedChats = []; // Status not implemented yet
    }

    return Column(
      children: [
        if (_isSelectionMode)
          _buildSelectionHeader(isDark)
        else
          SizedBox(height: 2.h),

        // Search Bar
        Container(
          margin: EdgeInsets.symmetric(horizontal: 1.w),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(30.sp),
            border: Border.all(
              color: isDark ? DarkColors.glassBorder : LightColors.glassBorder,
              width: 1.5,
            ),
          ),
          child: TextField(
            style: GoogleFonts.inter(
              color: isDark ? DarkColors.textPrimary : LightColors.textPrimary,
              fontSize: 13.sp,
            ),
            decoration: InputDecoration(
              hintText:
                  _selectedTabIndex == 1
                      ? "Search groups..."
                      : "Search conversations...",
              hintStyle: TextStyle(
                color:
                    isDark
                        ? DarkColors.textSecondary
                        : LightColors.textSecondary,
                fontSize: 15.sp,
              ),
              prefixIcon: Icon(
                Icons.search_rounded,
                color: Theme.of(context).primaryColor,
                size: 20.sp,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 2.h),
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
                        gradient:
                            isSelected
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
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w500,
                          color:
                              isSelected
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
              () => context.push('/new_chat'),
            ),
            SizedBox(width: 3.w),
            _buildHeaderActionButton(isDark, CupertinoIcons.camera_fill, () {}),
          ],
        ),

        SizedBox(height: 2.5.h),

        // List
        Expanded(
          child:
              displayedChats.isEmpty
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
                            color:
                                isSelected
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
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                        width: 5.w,
                                        height: 5.w,
                                        decoration: BoxDecoration(
                                          color: DarkColors.profileGreen,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color:
                                                isDark
                                                    ? DarkColors.bgColor
                                                    : Colors.white,
                                            width: 2,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.check,
                                          size: 10.sp,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  else if (chat['isOnline'] == true)
                                    Positioned(
                                      right: 0,
                                      bottom: 0,
                                      child: Container(
                                        width: 4.w,
                                        height: 4.w,
                                        decoration: BoxDecoration(
                                          color: DarkColors.profileGreen,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color:
                                                isDark
                                                    ? DarkColors.bgColor
                                                    : Colors.white,
                                            width: 2.5,
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
                                        color:
                                            isDark
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
                                        color:
                                            chat['isTyping'] == true
                                                ? Theme.of(context).primaryColor
                                                : (isDark
                                                    ? DarkColors.textSecondary
                                                    : LightColors
                                                        .textSecondary),
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
                                        color:
                                            isDark
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
                                          gradient:
                                              isDark
                                                  ? DarkColors
                                                      .messageUserGradient
                                                  : LightColors
                                                      .messageUserGradient,
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
    );
  }

  Widget _buildSelectionHeader(bool isDark) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.5.h),
      color: isDark ? DarkColors.glassBg : Colors.white,
      child: Row(
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
      ),
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
