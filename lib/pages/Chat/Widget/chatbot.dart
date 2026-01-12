import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myitihas/pages/Chat/Widget/typing_Indicator.dart';
import 'dart:async';

import 'package:myitihas/utils/constants.dart';
import 'package:sizer/sizer.dart';

class Message {
  final String text;
  final bool isMe;
  final String time;

  Message({required this.text, required this.isMe, required this.time});
}

class ChatSession {
  final String id;
  final String title;
  final List<Message> messages;

  ChatSession({required this.id, required this.title, required this.messages});
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _textController = TextEditingController();
  final List<Message> _messages = [];
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isFriendMode = true;
  bool _isBotTyping = false;
  final List<ChatSession> _history = [];
  String? _currentSessionId;

  @override
  void initState() {
    super.initState();
    // Add initial dummy data from the image
    // _messages.add(
    //   Message(
    //     text: "Hey there! I'm Krishna, your friend. How are you doing today?",
    //     isMe: false,
    //     time: "14:22",
    //   ),
    // );
    _startNewChat();
  }

  void _startNewChat() {
    setState(() {
      _saveCurrentToHistory();
      _currentSessionId = DateTime.now().millisecondsSinceEpoch.toString();
      _messages.clear();
      _messages.add(
        Message(
          text: "Hey there! I'm Krishna, your friend. How are you doing today?",
          isMe: false,
          time: _getCurrentTime(),
        ),
      );
    });
  }

  void _saveCurrentToHistory() {
    if (_messages.isNotEmpty && _currentSessionId != null) {
      int index = _history.indexWhere((s) => s.id == _currentSessionId);

      // Create a title from the first user message or use default
      String title = "New Conversation";
      var firstUserMsg = _messages.firstWhere(
        (m) => m.isMe,
        orElse: () => _messages[0],
      );
      title = firstUserMsg.text;

      if (title.length > 25) title = "${title.substring(0, 22)}...";

      ChatSession session = ChatSession(
        id: _currentSessionId!,
        title: title,
        messages: List.from(_messages),
      );

      if (index != -1) {
        _history[index] = session;
      } else {
        _history.insert(0, session);
      }
    }
  }

  void _loadChatFromHistory(ChatSession session) {
    setState(() {
      _saveCurrentToHistory();
      _currentSessionId = session.id;
      _messages.clear();
      _messages.addAll(session.messages);
    });
    Navigator.pop(context);
  }

  void _deleteCurrentChat() async {
    final bool? confirm = await showDeleteConfirmDialog(
      context: context,
      title: "this conversation",
    );

    if (confirm == true) {
      setState(() {
        _history.removeWhere((session) => session.id == _currentSessionId);
        _messages.clear();
        _startNewChat();
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Conversation deleted")));
    }
  }

  void _handleSubmitted(String text) {
    if (text.trim().isEmpty) return;
    _textController.clear();

    setState(() {
      _messages.add(Message(text: text, isMe: true, time: _getCurrentTime()));
      _isBotTyping = true;
    });
    _scrollToBottom();

    Timer(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() {
        _isBotTyping = false;
        _messages.add(
          Message(
            text: _getDummyResponse(text),
            isMe: false,
            time: _getCurrentTime(),
          ),
        );
        _saveCurrentToHistory();
      });
      _scrollToBottom();
    });
  }

  String _getDummyResponse(String userMessage) {
    if (_isFriendMode) {
      return "That sounds interesting! As your friend, I'm always here to listen. Tell me more.";
    } else {
      return "From a perspective of wisdom: Every moment is a new beginning. Reflect on this.";
    }
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    return "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _copyFullChat() {
    if (_messages.isEmpty) return;
    String fullChat = _messages
        .map((m) {
          return "[${m.time}] ${m.isMe ? 'You' : 'Krishna'}: ${m.text}";
        })
        .join("\n\n");

    Clipboard.setData(ClipboardData(text: fullChat)).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Full chat copied to clipboard!")),
      );
    });
  }

  Future<bool?> showDeleteConfirmDialog({
    required BuildContext context,
    required String title,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Deletion"),
        content: Text("Are you sure you want to delete $title?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Delete", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color textColor = isDark ? DarkColors.textPrimary : LightColors.textPrimary;
    return Scaffold(
      key: _scaffoldKey,
      drawer: _buildHistoryDrawer(isDark, textColor),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [
                    DarkColors.accentPrimary.withOpacity(0.3), // deep navy
                    DarkColors.accentSecondary.withOpacity(0.2), // blue
                    DarkColors.accentSecondary.withOpacity(0.1), // purple tou
                  ]
                : [
                    DarkColors.accentPrimary.withOpacity(0.3), // deep navy
                    DarkColors.accentSecondary.withOpacity(0.2), // blue
                    DarkColors.accentSecondary.withOpacity(0.1),
                  ],
            stops: [0.0, 0.55, 1.0],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              SizedBox(height: 0.5.h),
              _header(isDark, textColor),
              Divider(color: textColor.withOpacity(0.2)),
              _buildModeSelector(isDark, textColor),
              SizedBox(height: 1.h),

              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                    child: Container(
                      width: 96.w,
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.blue.withOpacity(0.15)
                            : LightColors.glassBorder,
                        border: Border.all(
                          color: isDark
                              ? Colors.white.withOpacity(0.2)
                              : Colors.blueGrey.withOpacity(0.2),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // SizedBox(height: 6.h),
                          // _header(),
                          // _buildModeSelector(),
                          SizedBox(height: 2.h),
                          Row(
                            children: [
                              SizedBox(width: 2.5.h),
                              Text(
                                "Start a Conversation",
                                style: GoogleFonts.merriweather(
                                  color: textColor,
                                  fontSize: 16.sp,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 1.h),
                          _buildSuggestions(isDark, textColor),
                          SizedBox(height: 0.5.h),
                          Divider(color: textColor.withOpacity(0.2)),
                          Expanded(
                            child: ListView.builder(
                              controller: _scrollController,

                              itemCount:
                                  _messages.length + (_isBotTyping ? 1 : 0),
                              itemBuilder: (context, index) {
                                if (index == _messages.length) {
                                  return _buildTypingIndicator(
                                    isDark,
                                    textColor,
                                  );
                                }

                                final msg = _messages[index];
                                final bool isMe = msg.isMe;
                                // final bool isSelected = _selectedMessageIndices.contains(index);

                                return Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 2.h,
                                    vertical: 4,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: isMe
                                        ? MainAxisAlignment.end
                                        : MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      if (!isMe) ...[
                                        Container(
                                          padding: const EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: LightColors
                                                  .accentSecondary, // border color
                                              width: 1,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 10,
                                                spreadRadius: 3,
                                                color: DarkColors.accentPrimary
                                                    .withOpacity(0.2),
                                              ),
                                            ],
                                          ),

                                          child: CircleAvatar(
                                            radius: 16,
                                            backgroundImage: const AssetImage(
                                              'assets/images/littlekrishna.png',
                                            ),
                                            backgroundColor: Colors.transparent,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
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
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 14,
                                              vertical: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              gradient: !isMe
                                                  ? LinearGradient(
                                                      begin: Alignment.topLeft,
                                                      end:
                                                          Alignment.bottomRight,
                                                      colors: const [
                                                        DarkColors
                                                            .accentPrimary, // cyan-blue
                                                        Color(
                                                          0xFF7C4DFF,
                                                        ), // violet
                                                        Color(
                                                          0xFF5E35B1,
                                                        ), // deep purple
                                                      ],
                                                      stops: [0.2, 0.8, 1.0],
                                                    )
                                                  : null,

                                              color: isDark
                                                  ? const Color(0xFF2C3E50)
                                                  : Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topLeft: const Radius.circular(
                                                  16,
                                                ),
                                                topRight: const Radius.circular(
                                                  16,
                                                ),
                                                bottomLeft: isMe
                                                    ? const Radius.circular(16)
                                                    : Radius.zero,
                                                bottomRight: isMe
                                                    ? Radius.zero
                                                    : const Radius.circular(16),
                                              ),
                                            ),
                                            child: Text(
                                              msg.text,
                                              style: GoogleFonts.merriweather(
                                                color: isMe & !isDark
                                                    ? Colors.black
                                                    : Colors.white,
                                                fontSize: 14.5.sp,
                                                height: 1.4,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            "${msg.time} ${isMe ? 'You' : 'Krishna'}",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: textColor.withOpacity(0.6),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 1.5.h),
              _buildInputArea(isDark, textColor),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryDrawer(bool isDark, Color textColor) {
    return Drawer(
      backgroundColor: isDark ? const Color(0xFF071224) : Colors.white,
      child: Column(
        children: [
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "History",
                  style: GoogleFonts.merriweather(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                SizedBox(height: 2.h),
                GestureDetector(
                  onTap: () {
                    _startNewChat();
                    Navigator.pop(context);
                  },

                  child: Container(
                    width: 50.w,
                    padding: EdgeInsets.symmetric(vertical: 1.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color(0xFF6EC6FF), // light blue
                          Color(0xFF9B8CFF), // soft purple
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF6EC6FF).withOpacity(0.4),
                          blurRadius: 12,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add, color: Colors.white, size: 20),
                        SizedBox(width: 8),
                        Text(
                          "New Conversation",
                          style: GoogleFonts.merriweather(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _history.length,
              itemBuilder: (context, index) {
                final session = _history[index];
                return ListTile(
                  title: Text(
                    session.title,
                    style: GoogleFonts.merriweather(color: textColor),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.grey),
                    onPressed: () => setState(() => _history.removeAt(index)),
                  ),
                  onTap: () => _loadChatFromHistory(session),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _header(bool isDark, Color textColor) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back_ios_new,
              color: textColor,
              size: 18.sp,
            ),
          ),

          SizedBox(width: 2.w),

          Text(
            "Little Krishna",
            style: GoogleFonts.inter(
              color: textColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),

          SizedBox(width: 1.w),

          const Icon(Icons.verified, color: Colors.green, size: 18),

          const Spacer(),

          _circleIcon(
            icon: Icons.copy,
            onTap: _copyFullChat,
            isDark: isDark,
            textColor: textColor,
          ),

          SizedBox(width: 2.w),

          _circleIcon(
            icon: Icons.delete_outline,
            onTap: _deleteCurrentChat,
            isDark: isDark,
            textColor: textColor,
          ),
          SizedBox(width: 2.w),
          _circleIcon(
            icon: Icons.menu,
            onTap: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            isDark: isDark,
            textColor: textColor,
          ),
        ],
      ),
    );
  }

  Widget _circleIcon({
    required IconData icon,
    required VoidCallback onTap,
    required bool isDark,
    required Color textColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 5.h,
        width: 4.h,
        decoration: BoxDecoration(
          color: isDark
              ? Colors.black.withOpacity(0.1)
              : Colors.white.withOpacity(0.3),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withOpacity(0.15)),
        ),
        child: Center(
          child: Icon(icon, color: textColor, size: 18.sp),
        ),
      ),
    );
  }

  Widget _buildModeSelector(bool isDark, Color textColor) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
        color: isDark
            ? Colors.black.withOpacity(0.3)
            : Colors.white.withOpacity(0.8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // shadow color
            blurRadius: 12, // softness
            spreadRadius: 2, // size
            offset: const Offset(0, 6), // vertical elevation
          ),
        ],
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildModeButton(
            "Friend",
            Icons.favorite_border_outlined,
            _isFriendMode,
            () {
              setState(() {
                _isFriendMode = true;
              });
            },
            isDark,
            textColor,
          ),
          const SizedBox(width: 10),
          _buildModeButton(
            "Wisdom",
            Icons.auto_stories,
            !_isFriendMode,
            () {
              setState(() {
                _isFriendMode = false;
              });
            },
            isDark,
            textColor,
          ),

          IconButton(
            onPressed: () {
              // Refresh action
            },

            icon: Icon(Icons.refresh, color: textColor),
          ),
        ],
      ),
    );
  }

  Widget _buildModeButton(
    String text,
    IconData icon,
    bool isSelected,
    VoidCallback onTap,
    bool isDark,
    Color textColor,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? DarkColors.accentPrimary
              : Colors.transparent, // Light blue for selected
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(icon, color: textColor, size: 18),
            const SizedBox(width: 5),
            Text(
              text,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestions(bool isDark, Color textColor) {
    final suggestions = [
      "How are you today?",
      "Tell me a story",
      "What's up?",
      "How's your day?",
      "How to deal with stress according to Gita?",
      "What does Bhagavad Gita say about dharma?",
      "Gita teachings on karma and detachment",
    ];
    return SizedBox(
      height: 4.5.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _handleSubmitted(suggestions[index]);
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 1.w),
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: isDark
                      ? DarkColors.accentPrimary
                      : LightColors.accentPrimary,
                ),
                color: isDark
                    ? Colors.black.withOpacity(0.2)
                    : Colors.white.withOpacity(0.5),
              ),
              child: Center(
                child: Text(
                  suggestions[index],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: isDark
                        ? DarkColors.accentPrimary
                        : LightColors.accentPrimary,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTypingIndicator(bool isDark, Color textColor) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.h),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: LightColors.accentSecondary, // border color
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  spreadRadius: 3,
                  color: DarkColors.accentPrimary.withOpacity(0.2),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 16,
              backgroundImage: const AssetImage(
                'assets/images/littlekrishna.png',
              ),
              backgroundColor: Colors.transparent,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF2C3E50),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const TypingIndicator(),
          ),
        ],
      ),
    );
  }

  Widget _buildInputArea(bool isDark, Color textColor) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.h),

      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: isDark ? Colors.white.withOpacity(0.1) : Colors.white,
                border: Border.all(
                  color: isDark ? Colors.white.withOpacity(0.15) : Colors.white,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1), // shadow color
                    blurRadius: 12, // softness
                    spreadRadius: 2, // size
                    offset: const Offset(0, 6), // vertical elevation
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: "Hey Krishna! What's up?",
                        hintStyle: TextStyle(
                          color: isDark
                              ? Colors.white54
                              : Colors.black.withOpacity(0.5),
                        ),
                        border: InputBorder.none,
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
                      onSubmitted: _handleSubmitted,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.mic, color: textColor.withOpacity(0.8)),
                    onPressed: () {
                      // Voice input functionality
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () => _handleSubmitted(_textController.text),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF00B0FF),
                    Color(0xFF0080FF),
                  ], // Send button gradient
                ),
              ),
              child: const Icon(Icons.send, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
