import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myitihas/utils/constants.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/services.dart';
import 'package:myitihas/core/di/injection_container.dart';
import 'package:myitihas/services/chat_service.dart';
import 'package:myitihas/models/chat_message.dart';
import 'package:myitihas/services/supabase_service.dart';

class ChatDetailPage extends StatefulWidget {
  final String? conversationId; // Now nullable
  final String userId;
  final String name;
  final String? avatarUrl;
  final String? avatarColor;
  final bool isGroup; // Added parameter

  const ChatDetailPage({
    super.key,
    this.conversationId, // Optional
    required this.userId,
    required this.name,
    this.avatarUrl,
    this.avatarColor,
    this.isGroup = false, // Default false
  });

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final ChatService _chatService = getIt<ChatService>();
  final TextEditingController _messageController = TextEditingController();
  final Set<int> _selectedMessageIndices = {};
  bool get _isSelectionMode => _selectedMessageIndices.isNotEmpty;

  List<ChatMessage> _messages = [];
  bool _isLoading = true;
  bool _isSending = false;
  StreamSubscription<ChatMessage>? _messageSubscription;
  String? _currentUserId;
  bool _messageSent = false;
  String? _conversationId; // Mutable conversation ID

  @override
  void initState() {
    super.initState();
    _currentUserId = SupabaseService.client.auth.currentUser?.id;
    _conversationId = widget.conversationId; // Initialize from widget
    if (_conversationId != null) {
      _loadMessages();
      _subscribeToMessages();
      // Mark conversation as read when user opens the chat
      _chatService.markConversationAsRead(_conversationId!);
    } else {
      // No conversation yet, just show empty state
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _messageSubscription?.cancel();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _loadMessages() async {
    if (_conversationId == null) return; // No conversation yet

    setState(() {
      _isLoading = true;
    });

    try {
      final messages = await _chatService.getMessages(_conversationId!);
      setState(() {
        _messages = messages;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to load messages: $e')));
      }
    }
  }

  void _subscribeToMessages() {
    if (_conversationId == null) return; // No conversation yet

    _messageSubscription = _chatService
        .subscribeToMessages(_conversationId!)
        .listen((newMessage) {
          setState(() {
            _messages.add(newMessage);
          });
        });
  }

  Future<void> _sendMessage() async {
    final content = _messageController.text.trim();
    if (content.isEmpty || _isSending) return;

    setState(() {
      _isSending = true;
    });

    try {
      // If no conversation exists, create it first
      if (_conversationId == null) {
        final newConversationId = await _chatService.getOrCreateDM(
          widget.userId,
        );
        setState(() {
          _conversationId = newConversationId;
        });
        // Start subscribing to messages for this new conversation
        _subscribeToMessages();
      }

      // Optimistically add message to UI
      final optimisticMessage = ChatMessage(
        id: 'temp_${DateTime.now().millisecondsSinceEpoch}',
        conversationId: _conversationId!,
        senderId: _currentUserId!,
        content: content,
        createdAt: DateTime.now(), // Local time for display
      );

      setState(() {
        _messages.add(optimisticMessage);
      });

      _messageController.clear();

      await _chatService.sendMessage(
        conversationId: _conversationId!,
        content: content,
      );
      _messageSent = true;
    } catch (e) {
      // Remove optimistic message on error
      if (_messages.isNotEmpty) {
        setState(() {
          _messages.removeWhere((msg) => msg.id.startsWith('temp_'));
        });
      }
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to send message: $e')));
      }
    } finally {
      setState(() {
        _isSending = false;
      });
    }
  }

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

    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        if (didPop && _messageSent) {
          // Navigation already happened, just set the result
          // This is handled by the back button pop already
        }
      },
      child: Scaffold(
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
                ?isDark ? Colors.transparent.withOpacity(0.5) : null,
                DarkColors.glowPrimary.withAlpha(50),

                // ?isDark ? DarkColors.glassBg : null,
                isDark
                    ? DarkColors.accentSecondary.withOpacity(0.1)
                    : DarkColors.glassBorder,
                ?isDark ? Colors.transparent.withOpacity(0.4) : null,
              ],
              transform: GradientRotation(2.8 / 1.8),
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: _isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: isDark
                              ? DarkColors.accentPrimary
                              : LightColors.accentPrimary,
                        ),
                      )
                    : ListView.builder(
                        reverse: true,
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                        itemCount: _messages.length,
                        itemBuilder: (context, index) {
                          // Reverse the index to display newest at bottom
                          final reversedIndex = _messages.length - 1 - index;
                          final msg = _messages[reversedIndex];
                          bool isMe = msg.senderId == _currentUserId;
                          bool isSelected = _selectedMessageIndices.contains(
                            reversedIndex,
                          );

                          return GestureDetector(
                            onLongPress: () {
                              HapticFeedback.mediumImpact();
                              _toggleSelection(reversedIndex);
                            },
                            onTap: () {
                              if (_isSelectionMode)
                                _toggleSelection(reversedIndex);
                            },
                            child: Container(
                              color: isSelected
                                  ? highlightColor
                                  : Colors.transparent,
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
                                    _buildAvatar(15.sp, 13.sp),
                                    SizedBox(width: 2.w),
                                  ],
                                  Column(
                                    crossAxisAlignment: isMe
                                        ? CrossAxisAlignment.end
                                        : CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        constraints: BoxConstraints(
                                          maxWidth: 70.w,
                                        ),
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
                                                    color: Colors.black
                                                        .withOpacity(0.05),
                                                    blurRadius: 5,
                                                    offset: Offset(0, 2),
                                                  ),
                                                ],
                                        ),
                                        child: Text(
                                          msg.content,
                                          style: GoogleFonts.inter(
                                            color: isMe
                                                ? Colors.white
                                                : textColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.5.sp,
                                            height: 1.4,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 0.5.h),

                                      // --- Time + Status Icon ---
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "${_formatTime(msg.createdAt)} ${isMe ? 'You' : widget.name}",
                                            style: GoogleFonts.inter(
                                              fontSize: 12.sp,
                                              color: subTextColor.withOpacity(
                                                0.7,
                                              ),
                                            ),
                                          ),
                                          if (isMe) ...[
                                            SizedBox(width: 1.5.w),
                                            _buildStatusIcon(3),
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
                      Container(
                        padding: EdgeInsets.all(1.5.w),
                        decoration: BoxDecoration(
                          color: isDark ? Colors.white10 : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.add,
                          color: subTextColor,
                          size: 18.sp,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          decoration: BoxDecoration(
                            color: isDark
                                ? Colors.white10
                                : Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TextField(
                            controller: _messageController,
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.w700,
                            ),
                            decoration: InputDecoration(
                              hintText: "Type your message",

                              hintStyle: TextStyle(color: subTextColor),
                              border: InputBorder.none,
                              suffixIcon: Icon(
                                Icons.emoji_emotions_outlined,
                                color: subTextColor,
                              ),
                              filled: false,
                              fillColor: Colors.transparent,

                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,

                              isDense: true,

                              contentPadding: EdgeInsets.symmetric(
                                vertical: 1.5.h,
                                horizontal: 0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 2.w),
                      GestureDetector(
                        onTap: _sendMessage,
                        child: Container(
                          padding: EdgeInsets.all(3.w),
                          decoration: BoxDecoration(
                            color: _isSending
                                ? Color(0xFF3B82F6).withOpacity(0.5)
                                : Color(0xFF3B82F6),
                            shape: BoxShape.circle,
                          ),
                          child: _isSending
                              ? SizedBox(
                                  width: 16.sp,
                                  height: 16.sp,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Icon(
                                  Icons.send_rounded,
                                  color: Colors.white,
                                  size: 16.sp,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
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
                onPressed: () => context.pop(_messageSent),
              ),
              SizedBox(width: 2.w),

              GestureDetector(
                onTap: _navigateToProfile,
                child: _buildAvatar(18.sp, 14.sp),
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
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '$displayHour:$minute $period';
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

  // Build avatar with NetworkImage and initials fallback
  Widget _buildAvatar(double radius, double fontSize) {
    final avatarUrl = widget.avatarUrl;
    final fallbackColor = widget.avatarColor != null
        ? Color(int.parse(widget.avatarColor!))
        : Color(0xFF3B82F6);

    if (avatarUrl != null && avatarUrl.isNotEmpty) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: fallbackColor.withOpacity(0.2),
        child: ClipOval(
          child: Image.network(
            avatarUrl,
            width: radius * 2,
            height: radius * 2,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return _buildInitialsAvatar(radius, fontSize, fallbackColor);
            },
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return _buildInitialsAvatar(radius, fontSize, fallbackColor);
            },
          ),
        ),
      );
    }

    return _buildInitialsAvatar(radius, fontSize, fallbackColor);
  }

  Widget _buildInitialsAvatar(double radius, double fontSize, Color color) {
    return CircleAvatar(
      backgroundColor: color.withOpacity(0.2),
      radius: radius,
      child: Text(
        widget.name.isNotEmpty ? widget.name[0].toUpperCase() : '?',
        style: GoogleFonts.inter(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
