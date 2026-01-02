import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myitihas/utils/constants.dart';
import 'package:sizer/sizer.dart';
import 'package:myitihas/services/profile_service.dart';
import 'package:myitihas/services/supabase_service.dart';
import 'package:myitihas/core/di/injection_container.dart';

class AddGroupMembersPage extends StatefulWidget {
  final String conversationId;
  final List<String> existingMemberIds;

  const AddGroupMembersPage({
    super.key,
    required this.conversationId,
    required this.existingMemberIds,
  });

  @override
  State<AddGroupMembersPage> createState() => _AddGroupMembersPageState();
}

class _AddGroupMembersPageState extends State<AddGroupMembersPage> {
  final ProfileService _profileService = getIt<ProfileService>();
  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> _allUsers = [];
  List<Map<String, dynamic>> _filteredUsers = [];
  Set<String> _selectedUserIds = {};
  bool _isLoading = true;
  String? _currentUserId;

  @override
  void initState() {
    super.initState();
    _currentUserId = SupabaseService.client.auth.currentUser?.id;
    _loadUsers();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadUsers() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final users = await _profileService.fetchPublicProfiles(limit: 1000, offset: 0);
      // Filter out current user and existing members
      final filteredUsers = users.where((user) {
        final userId = user['id'] as String;
        return userId != _currentUserId;
      }).toList();

      setState(() {
        _allUsers = filteredUsers;
        _filteredUsers = filteredUsers;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load users: $e')),
        );
      }
    }
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredUsers = _allUsers;
      } else {
        _filteredUsers = _allUsers.where((user) {
          final username = (user['username'] as String? ?? '').toLowerCase();
          final fullName = (user['full_name'] as String? ?? '').toLowerCase();
          return username.contains(query) || fullName.contains(query);
        }).toList();
      }
    });
  }

  void _toggleUserSelection(String userId) {
    // Check if user is already in group
    if (widget.existingMemberIds.contains(userId)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User is already in the group')),
      );
      return;
    }

    setState(() {
      if (_selectedUserIds.contains(userId)) {
        _selectedUserIds.remove(userId);
      } else {
        _selectedUserIds.add(userId);
      }
    });
  }

  void _showConfirmationDialog() {
    if (_selectedUserIds.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one user')),
      );
      return;
    }

    final selectedUsers = _allUsers
        .where((user) => _selectedUserIds.contains(user['id']))
        .toList();

    showDialog(
      context: context,
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        final textColor = isDark ? DarkColors.textPrimary : LightColors.textPrimary;
        final accentColor = const Color(0xFF3B82F6);

        return AlertDialog(
          title: Text(
            'Add Members',
            style: GoogleFonts.inter(fontWeight: FontWeight.bold),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add the following users to the group?',
                  style: GoogleFonts.inter(fontSize: 14.sp),
                ),
                SizedBox(height: 2.h),
                Wrap(
                  spacing: 3.w,
                  runSpacing: 2.h,
                  children: selectedUsers.map((user) {
                    final name = user['full_name'] ?? user['username'] ?? 'User';
                    final avatarUrl = user['avatar_url'] as String?;

                    return SizedBox(
                      width: 20.w,
                      child: Column(
                        children: [
                          avatarUrl != null && avatarUrl.isNotEmpty
                              ? CircleAvatar(
                                  radius: 8.w,
                                  backgroundImage: NetworkImage(avatarUrl),
                                  backgroundColor: accentColor.withOpacity(0.2),
                                )
                              : CircleAvatar(
                                  radius: 8.w,
                                  backgroundColor: accentColor.withOpacity(0.2),
                                  child: Text(
                                    name[0].toUpperCase(),
                                    style: GoogleFonts.inter(
                                      color: accentColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                ),
                          SizedBox(height: 0.5.h),
                          Text(
                            name,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _addMembersToGroup();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: accentColor,
              ),
              child: Text(
                'Add',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _addMembersToGroup() async {
    try {
      final now = DateTime.now().toIso8601String();
      final memberRows = _selectedUserIds.map((userId) {
        return {
          'conversation_id': widget.conversationId,
          'user_id': userId,
          'role': 'member',
          'last_read_at': null,
          'joined_at': now,
        };
      }).toList();

      await SupabaseService.client
          .from('conversation_members')
          .insert(memberRows);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${_selectedUserIds.length} member(s) added to group'),
          ),
        );
        context.pop(true); // Return true to indicate success
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add members: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color bgColor = isDark ? DarkColors.bgColor : LightColors.bgColor;
    Color textColor = isDark ? DarkColors.textPrimary : LightColors.textPrimary;
    Color subTextColor = isDark ? DarkColors.textSecondary : LightColors.textSecondary;
    Color accentColor = const Color(0xFF3B82F6);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: textColor, size: 18.sp),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Add Members',
          style: GoogleFonts.inter(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
            child: TextField(
              controller: _searchController,
              style: GoogleFonts.inter(color: textColor),
              decoration: InputDecoration(
                hintText: 'Search users...',
                hintStyle: GoogleFonts.inter(color: subTextColor),
                prefixIcon: Icon(Icons.search, color: subTextColor),
                filled: true,
                fillColor: isDark ? DarkColors.glassBg : Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: _isLoading
                ? Center(
                    child: CircularProgressIndicator(color: accentColor),
                  )
                : _filteredUsers.isEmpty
                    ? Center(
                        child: Text(
                          'No users found',
                          style: GoogleFonts.inter(color: subTextColor),
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        itemCount: _filteredUsers.length,
                        itemBuilder: (context, index) {
                          final user = _filteredUsers[index];
                          final userId = user['id'] as String;
                          final name = user['full_name'] ?? user['username'] ?? 'Unknown';
                          final avatarUrl = user['avatar_url'] as String?;
                          final isSelected = _selectedUserIds.contains(userId);
                          final isInGroup = widget.existingMemberIds.contains(userId);

                          return ListTile(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 4.w,
                              vertical: 1.h,
                            ),
                            leading: Stack(
                              children: [
                                avatarUrl != null && avatarUrl.isNotEmpty
                                    ? CircleAvatar(
                                        radius: 7.w,
                                        backgroundImage: NetworkImage(avatarUrl),
                                        backgroundColor: accentColor.withOpacity(0.2),
                                      )
                                    : CircleAvatar(
                                        radius: 7.w,
                                        backgroundColor: accentColor.withOpacity(0.2),
                                        child: Text(
                                          name[0].toUpperCase(),
                                          style: GoogleFonts.inter(
                                            color: accentColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                if (isSelected)
                                  Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: accentColor,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: bgColor,
                                          width: 2,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 16.sp,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            title: Text(
                              name,
                              style: GoogleFonts.inter(
                                color: textColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: isInGroup
                                ? Text(
                                    'Already in group',
                                    style: GoogleFonts.inter(
                                      color: subTextColor,
                                      fontSize: 12.sp,
                                    ),
                                  )
                                : null,
                            trailing: isInGroup
                                ? Icon(Icons.check_circle, color: Colors.grey)
                                : null,
                            onTap: () => _toggleUserSelection(userId),
                          );
                        },
                      ),
          ),
        ],
      ),
      floatingActionButton: _selectedUserIds.isNotEmpty
          ? FloatingActionButton(
              backgroundColor: accentColor,
              onPressed: _showConfirmationDialog,
              child: Icon(Icons.arrow_forward, color: Colors.white),
            )
          : null,
    );
  }
}
