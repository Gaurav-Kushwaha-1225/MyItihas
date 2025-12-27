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
import 'package:myitihas/core/di/injection_container.dart';
import 'package:myitihas/services/chat_service.dart';
import 'package:myitihas/services/profile_service.dart';
import 'package:myitihas/models/conversation.dart';
import 'package:myitihas/services/supabase_service.dart';

class ChatItihasPage extends StatefulWidget {
  const ChatItihasPage({super.key});

  @override
  State<ChatItihasPage> createState() => _ChatItihasPageState();
}

class _ChatItihasPageState extends State<ChatItihasPage> {
  final ChatService _chatService = getIt<ChatService>();
  final ProfileService _profileService = getIt<ProfileService>();

  int _selectedTabIndex = 0;
  final List<String> _tabs = ["Chats", "Groups", "Status"];

  // Selection State
  final Set<int> _selectedIndices = {};
  bool get _isSelectionMode => _selectedIndices.isNotEmpty;

  // Real conversation data
  List<Conversation> _conversations = [];
  Map<String, Map<String, dynamic>> _userProfiles =
      {}; // conversationId -> user profile
  bool _isLoading = true;
  String? _currentUserId;

  @override
  void initState() {
    super.initState();
    _currentUserId = SupabaseService.client.auth.currentUser?.id;
    _loadConversations();
  }

  Future<void> _loadConversations() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final conversations = await _chatService.getMyConversations();

      // Fetch other user profiles for each conversation
      for (final conversation in conversations) {
        try {
          final otherUserId = await _getOtherUserId(conversation.id);
          if (otherUserId != null) {
            final profile = await _profileService.getProfileById(otherUserId);
            _userProfiles[conversation.id] = profile;
          }
        } catch (e) {
          print(
            'Error fetching profile for conversation ${conversation.id}: $e',
          );
        }
      }

      setState(() {
        _conversations = conversations;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load conversations: $e')),
        );
      }
    }
  }

  Future<String?> _getOtherUserId(String conversationId) async {
    try {
      final members = await SupabaseService.client
          .from('conversation_members')
          .select('user_id')
          .eq('conversation_id', conversationId);

      for (final member in members as List) {
        final userId = member['user_id'] as String;
        if (userId != _currentUserId) {
          return userId;
        }
      }
    } catch (e) {
      print('Error getting other user ID: $e');
    }
    return null;
  }

  String _formatChatTime(DateTime? dateTime) {
    if (dateTime == null) return '';

    final now = DateTime.now();
    final difference = now.difference(dateTime);

    // Today: show time (e.g., "3:45 PM")
    if (difference.inDays == 0) {
      final hour = dateTime.hour;
      final minute = dateTime.minute.toString().padLeft(2, '0');
      final period = hour >= 12 ? 'PM' : 'AM';
      final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
      return '$displayHour:$minute $period';
    }

    // Yesterday
    if (difference.inDays == 1) {
      return 'Yesterday';
    }

    // This week: show day name
    if (difference.inDays < 7) {
      const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      return days[dateTime.weekday - 1];
    }

    // Older: show date (e.g., "26 Dec")
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${dateTime.day} ${months[dateTime.month - 1]}';
  }

  String _formatTimestamp(DateTime timestamp) {
    // Convert to local time
    final localTime = timestamp.toLocal();
    final now = DateTime.now();
    final difference = now.difference(localTime);

    // Today: show time (e.g., "3:45 PM")
    if (difference.inDays == 0) {
      final hour = localTime.hour;
      final minute = localTime.minute.toString().padLeft(2, '0');
      final period = hour >= 12 ? 'PM' : 'AM';
      final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
      return '$displayHour:$minute $period';
    }

    // Yesterday
    if (difference.inDays == 1) {
      return 'Yesterday';
    }

    // This week: show day name
    if (difference.inDays < 7) {
      const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      return days[localTime.weekday - 1];
    }

    // Older: show date (e.g., "26 Dec")
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${localTime.day} ${months[localTime.month - 1]}';
  }

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

    // No need to filter logic anymore - just show conversations
    // Groups tab will show groups when we add group support later

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
              _buildHeaderActionButton(isDark, Icons.add, () async {
                await context.push('/new-chat');
                // Refresh conversations after returning from new chat
                _loadConversations();
              }),
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
                : _isLoading
                ? Center(child: CircularProgressIndicator(color: accentColor))
                : _conversations.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat_bubble_outline,
                          size: 64,
                          color: isDark
                              ? DarkColors.textSecondary
                              : LightColors.textSecondary,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No chats yet',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: isDark
                                ? DarkColors.textSecondary
                                : LightColors.textSecondary,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Tap + to start a new chat',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: isDark
                                ? DarkColors.textSecondary
                                : LightColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 1.w),
                    itemCount: _conversations.length,
                    itemBuilder: (context, index) {
                      final conversation = _conversations[index];
                      final profile = _userProfiles[conversation.id];
                      final isSelected = _selectedIndices.contains(index);

                      // Extract user data
                      final userName = profile != null
                          ? (profile['full_name'] as String? ??
                                profile['username'] as String? ??
                                'Unknown User')
                          : 'Unknown User';
                      final avatarUrl = profile?['avatar_url'] as String?;
                      final otherUserId = profile?['id'] as String? ?? '';

                      return GestureDetector(
                        onLongPress: () => _toggleSelection(index),
                        onTap: () async {
                          if (_isSelectionMode) {
                            _toggleSelection(index);
                          } else {
                            final result = await context.push(
                              '/chat_detail',
                              extra: {
                                'conversationId': conversation.id,
                                'userId': otherUserId,
                                'name': userName,
                                'avatarUrl': avatarUrl,
                                'isGroup': conversation.isGroup,
                              },
                            );
                            // Always refresh conversations after returning from chat
                            // (markAsRead was called, or messages might have been sent)
                            _loadConversations();
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
                                  // Avatar with NetworkImage or initials
                                  avatarUrl != null && avatarUrl.isNotEmpty
                                      ? CircleAvatar(
                                          radius: 7.w,
                                          backgroundImage: NetworkImage(
                                            avatarUrl,
                                          ),
                                          onBackgroundImageError: (_, __) {},
                                          backgroundColor: isDark
                                              ? DarkColors.glassBg
                                              : LightColors.glassBg,
                                        )
                                      : Container(
                                          width: 14.w,
                                          height: 14.w,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(
                                              0xFF3B82F6,
                                            ).withOpacity(0.2),
                                          ),
                                          child: Center(
                                            child: Text(
                                              userName.isNotEmpty
                                                  ? userName[0].toUpperCase()
                                                  : '?',
                                              style: GoogleFonts.inter(
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF3B82F6),
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
                                    ),
                                ],
                              ),
                              SizedBox(width: 4.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      userName,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.inter(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w700,
                                        color: isDark
                                            ? DarkColors.textPrimary
                                            : LightColors.textPrimary,
                                      ),
                                    ),
                                    SizedBox(height: 0.5.h),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            conversation.lastMessage ?? 'Tap to chat',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.inter(
                                              fontSize: 14.sp,
                                              color: isDark
                                                  ? DarkColors.textSecondary
                                                  : LightColors.textSecondary,
                                            ),
                                          ),
                                        ),
                                        if (conversation.lastMessageAt != null) ...[
                                          SizedBox(width: 2.w),
                                          Text(
                                            _formatTimestamp(conversation.lastMessageAt!),
                                            style: GoogleFonts.inter(
                                              fontSize: 12.sp,
                                              color: isDark
                                                  ? DarkColors.textSecondary
                                                  : LightColors.textSecondary,
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ],
                                ),
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
