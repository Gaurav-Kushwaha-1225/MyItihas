import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myitihas/utils/constants.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:myitihas/core/di/injection_container.dart';
import 'package:myitihas/services/profile_service.dart';
import 'package:myitihas/services/chat_service.dart';

class NewChatPage extends StatefulWidget {
  const NewChatPage({super.key});

  @override
  State<NewChatPage> createState() => _NewChatPageState();
}

class _NewChatPageState extends State<NewChatPage> {
  final ProfileService _profileService = getIt<ProfileService>();
  final ChatService _chatService = getIt<ChatService>();
  final TextEditingController _searchController = TextEditingController();
  
  List<Map<String, dynamic>> _allUsers = [];
  List<Map<String, dynamic>> _filteredUsers = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadUsers();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadUsers() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final users = await _profileService.fetchPublicProfiles(
        limit: 100,
        offset: 0,
      );
      
      setState(() {
        _allUsers = users;
        _filteredUsers = users;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load users: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    
    if (query.isEmpty) {
      setState(() {
        _filteredUsers = _allUsers;
      });
    } else {
      setState(() {
        _filteredUsers = _allUsers.where((user) {
          final username = (user['username'] ?? '').toLowerCase();
          final fullName = (user['full_name'] ?? '').toLowerCase();
          return username.contains(query) || fullName.contains(query);
        }).toList();
      });
    }
  }

  //
  // BUILD

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(6.h),
        child: _buildAppBar(context, isDark),
      ),
      body: _buildBody(context, isDark),
    );
  }

  //
  // APP BAR

  Widget _buildAppBar(BuildContext context, bool isDark) {
    final textColor = isDark ? DarkColors.textPrimary : LightColors.textPrimary;

    return Container(
      decoration: BoxDecoration(
        gradient: isDark
            ? DarkColors.featureCardGradient
            : LightColors.featureCardGradient,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).secondaryHeaderColor.withAlpha(120),
            blurRadius: 200,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: textColor),
              onPressed: () => context.pop(),
            ),
            Expanded(
              child: Text(
                "New Chat",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  fontSize: 18.sp,
                  foreground: Paint()
                    ..shader =
                        (isDark
                                ? DarkColors.messageUserGradient
                                : LightColors.messageUserGradient)
                            .createShader(const Rect.fromLTWH(0, 0, 200, 70)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //
  // BODY

  Widget _buildBody(BuildContext context, bool isDark) {
    return Container(
      decoration: _buildBackgroundGradient(context, isDark),
      child: Column(
        children: [
          _buildSearchBar(isDark),
          _buildNewGroupOption(context, isDark),
          _buildUsersList(isDark),
        ],
      ),
    );
  }

  //
  // BACKGROUND

  BoxDecoration _buildBackgroundGradient(BuildContext context, bool isDark) {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [
          DarkColors.accentPrimary.withAlpha(5),
          isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
        ],
        transform: const GradientRotation(3.14 / 1.5),
      ),
    );
  }

  //
  // SEARCH BAR

  Widget _buildSearchBar(bool isDark) {
    final textColor = isDark ? DarkColors.textPrimary : LightColors.textPrimary;
    final secondaryTextColor = isDark
        ? DarkColors.textSecondary
        : LightColors.textSecondary;
    final inputBg = isDark ? DarkColors.inputBg : LightColors.inputBg;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: inputBg,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isDark ? DarkColors.glassBorder : LightColors.glassBorder,
          ),
        ),
        child: TextField(
          controller: _searchController,
          style: TextStyle(color: textColor),
          decoration: InputDecoration(
            hintText: "Search name or number",
            hintStyle: TextStyle(color: secondaryTextColor),
            prefixIcon: Icon(Icons.search, color: secondaryTextColor),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
          ),
        ),
      ),
    );
  }

  //
  // NEW GROUP OPTION

  Widget _buildNewGroupOption(BuildContext context, bool isDark) {
    final textColor = isDark ? DarkColors.textPrimary : LightColors.textPrimary;
    final secondaryTextColor = isDark
        ? DarkColors.textSecondary
        : LightColors.textSecondary;
    final accentColor = isDark
        ? DarkColors.accentPrimary
        : LightColors.accentPrimary;

    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundColor: accentColor,
            child: Icon(Icons.group_add, color: Colors.white),
          ),
          title: Text(
            "New group",
            style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
          ),
          onTap: () => context.push('/new-group'),
        ),
        Divider(color: secondaryTextColor.withOpacity(0.2)),
      ],
    );
  }

  //
  // USERS LIST

  Widget _buildUsersList(bool isDark) {
    final textColor = isDark ? DarkColors.textPrimary : LightColors.textPrimary;
    final secondaryTextColor = isDark
        ? DarkColors.textSecondary
        : LightColors.textSecondary;
    final accentColor = isDark
        ? DarkColors.accentPrimary
        : LightColors.accentPrimary;

    if (_isLoading) {
      return Expanded(
        child: Center(
          child: CircularProgressIndicator(
            color: accentColor,
          ),
        ),
      );
    }

    if (_errorMessage != null) {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 48,
                color: secondaryTextColor,
              ),
              SizedBox(height: 16),
              Text(
                _errorMessage!,
                style: TextStyle(
                  color: secondaryTextColor,
                  fontSize: 14.sp,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loadUsers,
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentColor,
                ),
                child: Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (_filteredUsers.isEmpty) {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.people_outline,
                size: 48,
                color: secondaryTextColor,
              ),
              SizedBox(height: 16),
              Text(
                _searchController.text.isEmpty
                    ? 'No users found'
                    : 'No users match your search',
                style: TextStyle(
                  color: secondaryTextColor,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Expanded(
      child: ListView(
        children: [
          _buildSectionTitle("People on MyItihas", secondaryTextColor),
          ..._filteredUsers.map(
            (user) => _buildUserTile(user, textColor, accentColor),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, Color color) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 15.sp,
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  //
  // USER TILE

  Widget _buildUserTile(
    Map<String, dynamic> user,
    Color textColor,
    Color accentColor,
  ) {
    final userId = user['id'] as String;
    final username = user['username'] as String?;
    final fullName = user['full_name'] as String?;
    final avatarUrl = user['avatar_url'] as String?;
    
    final displayName = fullName ?? username ?? 'Unknown User';
    final subtitle = username != null && fullName != null ? '@$username' : null;

    return ListTile(
      leading: _buildAvatar(displayName, avatarUrl, accentColor),
      title: Text(
        displayName,
        style: TextStyle(
          fontSize: 15.sp,
          color: textColor,
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: TextStyle(
                fontSize: 12.sp,
                color: textColor.withOpacity(0.6),
              ),
            )
          : null,
      onTap: () async {
        print('Selected user: $userId');
        
        // Navigate to chat detail page without creating conversation
        // Conversation will be created on first message
        context.push('/chat_detail', extra: {
          'conversationId': null, // Don't create yet
          'userId': userId,
          'name': displayName,
          'avatarUrl': avatarUrl,
          'isGroup': false,
        });
      },
    );
  }

  Widget _buildAvatar(String displayName, String? avatarUrl, Color accentColor) {
    if (avatarUrl != null && avatarUrl.isNotEmpty) {
      return CircleAvatar(
        backgroundImage: NetworkImage(avatarUrl),
        onBackgroundImageError: (_, __) {
          // Fallback handled by the next widget
        },
        child: null,
      );
    }
    
    // Fallback to initials
    return CircleAvatar(
      backgroundColor: accentColor.withOpacity(0.2),
      child: Text(
        displayName.isNotEmpty ? displayName[0].toUpperCase() : '?',
        style: TextStyle(
          fontSize: 18.sp,
          color: accentColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
