import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myitihas/utils/constants.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/services.dart';

class ChatDetailPage extends StatefulWidget {
  final String name;
  final String avatarColor;
  final bool isGroup; // Added parameter

  const ChatDetailPage({
    super.key,
    required this.name,
    this.avatarColor = "0xFF2196F3",
    this.isGroup = false, // Default false
  });

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final TextEditingController _messageController = TextEditingController();
  final Set<int> _selectedMessageIndices = {};
  bool get _isSelectionMode => _selectedMessageIndices.isNotEmpty;

  // Mock Messages
  final List<Map<String, dynamic>> _messages = [
    {
      "isMe": false,
      "msg": "Hey, how are you?",
      "time": "10:30 AM",
      "status": 3,
    },
    {"isMe": true, "msg": "Hello", "time": "10:31 AM", "status": 3},
    {"isMe": true, "msg": "I'm good.", "time": "10:35 AM", "status": 1},
  ];

  void _toggleSelection(int index) {
    setState(() {
      if (_selectedMessageIndices.contains(index)) {
        _selectedMessageIndices.remove(index);
      } else {
        _selectedMessageIndices.add(index);
      }
    });
  }

  void _clearSelection() {
    setState(() {
      _selectedMessageIndices.clear();
    });
  }

  // --- NEW: Navigation Logic ---
  void _navigateToProfile() {
    if (widget.isGroup) {
      context.push(
        '/group_profile',
        extra: {'name': widget.name, 'color': widget.avatarColor},
      );
    } else {
      context.push('/profile_detail', extra: {'name': widget.name});
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color textColor = isDark ? DarkColors.textPrimary : LightColors.textPrimary;
    Color subTextColor = isDark
        ? DarkColors.textSecondary
        : LightColors.textSecondary;
    Color highlightColor = isDark
        ? Colors.white.withOpacity(0.1)
        : Color(0xFF3B82F6).withOpacity(0.15);

    return Scaffold(
      backgroundColor: isDark ? DarkColors.bgColor : LightColors.bgColor,

      appBar: PreferredSize(
        preferredSize: Size.fromHeight(8.h),
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 200),
          child: _isSelectionMode
              ? _buildSelectionHeader(isDark)
              : _buildNormalHeader(isDark, textColor, subTextColor),
        ),
      ),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Theme.of(context).primaryColor.withAlpha(30),
              isDark ? Color(0xFF1E293B) : Color(0xFFF1F5F9),
            ],
            transform: GradientRotation(3.14 / 1.5),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 2.h),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final msg = _messages[index];
                  bool isMe = msg['isMe'];
                  bool isSelected = _selectedMessageIndices.contains(index);

                  return GestureDetector(
                    onLongPress: () {
                      HapticFeedback.mediumImpact();
                      _toggleSelection(index);
                    },
                    onTap: () {
                      if (_isSelectionMode) _toggleSelection(index);
                    },
                    child: Container(
                      color: isSelected ? highlightColor : Colors.transparent,
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.w,
                        vertical: 1.h,
                      ),
                      child: Row(
                        mainAxisAlignment: isMe
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (!isMe) ...[
                            CircleAvatar(
                              backgroundColor: Color(
                                int.parse(widget.avatarColor),
                              ).withOpacity(0.2),
                              radius: 15.sp,
                              child: Text(
                                widget.name[0],
                                style: GoogleFonts.inter(
                                  color: Color(int.parse(widget.avatarColor)),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.sp,
                                ),
                              ),
                            ),
                            SizedBox(width: 2.w),
                          ],
                          Column(
                            crossAxisAlignment: isMe
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              Container(
                                constraints: BoxConstraints(maxWidth: 70.w),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 4.w,
                                  vertical: 1.5.h,
                                ),
                                decoration: BoxDecoration(
                                  color: isMe
                                      ? Color(0xFF3B82F6) // Blue for me
                                      : (isDark
                                            ? DarkColors.glassBg
                                            : Colors.white),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15.sp),
                                    topRight: Radius.circular(15.sp),
                                    bottomLeft: isMe
                                        ? Radius.circular(15.sp)
                                        : Radius.circular(0),
                                    bottomRight: isMe
                                        ? Radius.circular(0)
                                        : Radius.circular(15.sp),
                                  ),
                                  boxShadow: isMe
                                      ? []
                                      : [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.05,
                                            ),
                                            blurRadius: 5,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                ),
                                child: Text(
                                  msg['msg'],
                                  style: GoogleFonts.inter(
                                    color: isMe ? Colors.white : textColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.5.sp,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                              SizedBox(height: 0.5.h),

                              // --- UPDATED: Time + Status Icon ---
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "${msg['time']} ${isMe ? 'You' : widget.name}",
                                    style: GoogleFonts.inter(
                                      fontSize: 12.sp,
                                      color: subTextColor.withOpacity(0.7),
                                    ),
                                  ),
                                  if (isMe) ...[
                                    SizedBox(width: 1.5.w),
                                    // Added Helper function call
                                    _buildStatusIcon(msg['status'] ?? 0),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            if (!_isSelectionMode)
              Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: isDark ? DarkColors.glassBg : Colors.white,
                  border: Border(
                    top: BorderSide(
                      color: isDark ? Colors.white10 : Colors.grey.shade100,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.add, color: subTextColor, size: 20.sp),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        decoration: BoxDecoration(
                          color: isDark ? Colors.white10 : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: TextField(
                          controller: _messageController,
                          style: TextStyle(color: textColor),
                          decoration: InputDecoration(
                            hintText: "Type a message...",
                            hintStyle: TextStyle(color: subTextColor),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Icon(Icons.mic, color: subTextColor, size: 20.sp),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildNormalHeader(bool isDark, Color textColor, Color subTextColor) {
    return Container(
      key: ValueKey("NormalHeader"),
      decoration: BoxDecoration(
        color: isDark ? DarkColors.glassBg : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  size: 16.sp,
                  color: textColor,
                ),
                onPressed: () => context.pop(),
              ),
              SizedBox(width: 2.w),

              GestureDetector(
                onTap: _navigateToProfile,
                child: CircleAvatar(
                  backgroundColor: Color(
                    int.parse(widget.avatarColor),
                  ).withOpacity(0.2),
                  radius: 18.sp,
                  child: Text(
                    widget.name[0],
                    style: GoogleFonts.inter(
                      color: Color(int.parse(widget.avatarColor)),
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 3.w),

              Expanded(
                child: GestureDetector(
                  onTap: _navigateToProfile,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.name,
                        style: GoogleFonts.inter(
                          color: textColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 2.w,
                            height: 2.w,
                            decoration: BoxDecoration(
                              color: DarkColors.profileGreen,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 1.5.w),
                          Text(
                            "Online",
                            style: GoogleFonts.inter(
                              color: subTextColor,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              IconButton(
                icon: Icon(
                  Icons.videocam_rounded,
                  color: subTextColor,
                  size: 20.sp,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.call, color: subTextColor, size: 18.sp),
                onPressed: () {},
              ),
              PopupMenuButton<String>(
                icon: Icon(Icons.more_horiz, color: subTextColor, size: 20.sp),
                color: isDark ? DarkColors.glassBg : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                onSelected: (value) {
                  if (value == 'view') _navigateToProfile();
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  PopupMenuItem(
                    value: 'view',
                    child: Text(
                      widget.isGroup ? 'Group Info' : 'View Contact',
                      style: TextStyle(color: textColor),
                    ),
                  ),
                  PopupMenuItem(
                    value: 'block',
                    child: Text(
                      widget.isGroup ? 'Exit Group' : 'Block',
                      style: TextStyle(
                        color: isDark
                            ? DarkColors.dangerColor
                            : LightColors.dangerColor,
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    value: 'report',
                    child: Text(
                      'Report',
                      style: TextStyle(
                        color: isDark
                            ? DarkColors.dangerColor
                            : LightColors.dangerColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ... (Selection Header and Status Icon helpers remain the same)
  Widget _buildSelectionHeader(bool isDark) {
    Color iconColor = isDark ? Colors.white : Colors.black87;
    Color selectionBg = isDark ? DarkColors.glassBg : Colors.grey.shade100;
    return Container(
      key: ValueKey("SelectionHeader"),
      color: selectionBg,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back, color: iconColor),
                onPressed: _clearSelection,
              ),
              AnimatedSwitcher(
                duration: Duration(milliseconds: 200),
                child: Text(
                  "${_selectedMessageIndices.length}",
                  key: ValueKey(_selectedMessageIndices.length),
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: iconColor,
                  ),
                ),
              ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.reply, color: iconColor),
                onPressed: _clearSelection,
              ),
              IconButton(
                icon: Icon(Icons.star_border, color: iconColor),
                onPressed: _clearSelection,
              ),
              IconButton(
                icon: Icon(Icons.delete_outline, color: iconColor),
                onPressed: _clearSelection,
              ),
              IconButton(
                icon: Icon(Icons.copy, color: iconColor),
                onPressed: _clearSelection,
              ),
              IconButton(
                icon: Icon(Icons.forward, color: iconColor),
                onPressed: _clearSelection,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIcon(int status) {
    double iconSize = 14.5.sp;
    switch (status) {
      case 0:
        return Icon(
          Icons.access_time,
          size: iconSize * 0.9,
          color: Colors.grey,
        );
      case 1:
        return Icon(Icons.check, size: iconSize, color: Colors.grey);
      case 2:
        return Icon(Icons.done_all, size: iconSize, color: Colors.grey);
      case 3:
        return Icon(Icons.done_all, size: iconSize, color: Color(0xFF53BDEB));
      default:
        return SizedBox();
    }
  }
}
