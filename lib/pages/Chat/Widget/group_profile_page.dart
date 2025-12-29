import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myitihas/utils/constants.dart';
import 'package:sizer/sizer.dart';
import 'package:myitihas/services/supabase_service.dart';
import 'package:myitihas/core/di/injection_container.dart';
import 'package:myitihas/services/profile_service.dart';

class GroupProfilePage extends StatefulWidget {
  final String conversationId;

  const GroupProfilePage({super.key, required this.conversationId});

  @override
  State<GroupProfilePage> createState() => _GroupProfilePageState();
}

class _GroupProfilePageState extends State<GroupProfilePage> {
  final ProfileService _profileService = getIt<ProfileService>();

  bool _isLoading = true;
  String _groupName = '';
  String? _groupAvatarUrl;
  String? _groupDescription;
  List<Map<String, dynamic>> _members = [];
  String? _currentUserId;

  @override
  void initState() {
    super.initState();
    _currentUserId = SupabaseService.client.auth.currentUser?.id;
    _loadGroupData();
  }

  Future<void> _loadGroupData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Fetch group info from conversations table
      final conversationData = await SupabaseService.client
          .from('conversations')
          .select('group_name, group_avatar_url, group_description')
          .eq('id', widget.conversationId)
          .single();

      _groupName = conversationData['group_name'] ?? 'Group';
      _groupAvatarUrl = conversationData['group_avatar_url'];
      _groupDescription = conversationData['group_description'];

      // Fetch members from conversation_members table
      final membersData = await SupabaseService.client
          .from('conversation_members')
          .select('user_id, role')
          .eq('conversation_id', widget.conversationId);

      // Fetch profile data for each member
      final List<Map<String, dynamic>> membersList = [];
      for (final memberData in membersData) {
        try {
          final userId = memberData['user_id'] as String;
          final role = memberData['role'] as String? ?? 'member';

          final profile = await _profileService.getProfileById(userId);

          membersList.add({
            'user_id': userId,
            'name': profile['full_name'] ?? profile['username'] ?? 'Unknown',
            'avatar_url': profile['avatar_url'],
            'role': role,
            'is_current_user': userId == _currentUserId,
          });
        } catch (e) {
          print('Error fetching profile for member: $e');
        }
      }

      setState(() {
        _members = membersList;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading group data: $e');
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load group data: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color bgColor = isDark ? DarkColors.bgColor : LightColors.bgColor;
    Color textColor = isDark ? DarkColors.textPrimary : LightColors.textPrimary;
    Color subTextColor = isDark
        ? DarkColors.textSecondary
        : LightColors.textSecondary;
    Color accentColor = Color(0xFF3B82F6);
    Color groupColor = Color(0xFF8B5CF6); // Default purple for groups
    Color dangerColor = isDark
        ? DarkColors.dangerColor
        : LightColors.dangerColor;

    if (_isLoading) {
      return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: textColor, size: 18.sp),
            onPressed: () => context.pop(),
          ),
        ),
        body: Center(child: CircularProgressIndicator(color: accentColor)),
      );
    }

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: textColor, size: 18.sp),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: textColor, size: 20.sp),
            onPressed: () async {
              final result = await context.push(
                '/edit_group',
                extra: {'conversationId': widget.conversationId},
              );
              // Reload group data if edit was successful
              if (result == true) {
                _loadGroupData();
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.person_add_alt_1, color: textColor, size: 20.sp),
            onPressed: () {},
          ),
          SizedBox(width: 2.w),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 2.h),

            // Large Group Avatar
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 42.w,
                    height: 42.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: groupColor.withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                  ),
                  _groupAvatarUrl != null && _groupAvatarUrl!.isNotEmpty
                      ? Container(
                          width: 38.w,
                          height: 38.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 4),
                          ),
                          child: ClipOval(
                            child: Image.network(
                              _groupAvatarUrl!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return _buildFallbackAvatar(groupColor);
                              },
                            ),
                          ),
                        )
                      : _buildFallbackAvatar(groupColor),
                ],
              ),
            ),

            SizedBox(height: 2.h),

            // Group Name
            Text(
              _groupName,
              style: GoogleFonts.inter(
                color: textColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 1.h),

            // Group member count
            Text(
              "Group · ${_members.length} members",
              style: GoogleFonts.inter(color: subTextColor, fontSize: 14.sp),
            ),

            SizedBox(height: 2.h),

            // Description
            if (_groupDescription != null && _groupDescription!.isNotEmpty)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Text(
                  _groupDescription!,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: textColor,
                    fontSize: 14.sp,
                    height: 1.5,
                  ),
                ),
              ),
            if (_groupDescription != null && _groupDescription!.isNotEmpty)
              SizedBox(height: 1.h),

            SizedBox(height: 3.h),
            Divider(color: subTextColor.withOpacity(0.1), thickness: 1),

            // Participants List Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${_members.length} members",
                    style: GoogleFonts.inter(
                      color: subTextColor,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.search, color: subTextColor, size: 18.sp),
                ],
              ),
            ),

            // Participants List
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: _members.length,
              itemBuilder: (context, index) {
                final user = _members[index];
                final isAdmin = user['role'] == 'admin';
                final isCurrentUser = user['is_current_user'] == true;

                return ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 6.w,
                    vertical: 0.5.h,
                  ),
                  leading:
                      user['avatar_url'] != null &&
                          user['avatar_url'].isNotEmpty
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(user['avatar_url']),
                          backgroundColor: accentColor.withOpacity(0.2),
                        )
                      : CircleAvatar(
                          backgroundColor: accentColor.withOpacity(0.2),
                          child: Text(
                            user['name'][0].toUpperCase(),
                            style: GoogleFonts.inter(
                              color: accentColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                  title: Text(
                    isCurrentUser ? 'You' : user['name'],
                    style: GoogleFonts.inter(
                      color: textColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 15.sp,
                    ),
                  ),
                  subtitle: Text(
                    isAdmin ? 'Admin' : 'Member',
                    style: GoogleFonts.inter(
                      color: subTextColor,
                      fontSize: 14.sp,
                    ),
                  ),
                  trailing: isAdmin
                      ? Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 2.w,
                            vertical: 0.5.h,
                          ),
                          decoration: BoxDecoration(
                            color: accentColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: accentColor.withOpacity(0.3),
                            ),
                          ),
                          child: Text(
                            "Group Admin",
                            style: TextStyle(
                              color: accentColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : null,
                  onTap: () {
                    // Don't show options for current user
                    if (!isCurrentUser) {
                      _showMemberOptions(
                        context,
                        user['name']!,
                        isAdmin,
                        isDark,
                        textColor,
                        subTextColor,
                        accentColor,
                        dangerColor,
                      );
                    }
                  },
                );
              },
            ),

            Divider(color: subTextColor.withOpacity(0.1), thickness: 1),

            // Exit Group
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 6.w),
              leading: Icon(Icons.exit_to_app, color: dangerColor),
              title: Text(
                "Exit Group",
                style: TextStyle(
                  color: dangerColor,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () => _exitGroup(context, dangerColor),
            ),

            // Report Group
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 6.w),
              leading: Icon(Icons.thumb_down_alt_outlined, color: dangerColor),
              title: Text(
                "Report Group",
                style: TextStyle(
                  color: dangerColor,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () {},
            ),

            SizedBox(height: 5.h),
          ],
        ),
      ),
    );
  }

  void _showMemberOptions(
    BuildContext context,
    String memberName,
    bool isAdmin,
    bool isDark,
    Color textColor,
    Color subTextColor,
    Color accentColor,
    Color dangerColor,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: isDark ? DarkColors.glassBg : Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 2.h),

              // Handle bar
              Container(
                width: 12.w,
                height: 0.5.h,
                decoration: BoxDecoration(
                  color: subTextColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              SizedBox(height: 2.h),

              // Member name
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Text(
                  memberName,
                  style: GoogleFonts.inter(
                    color: textColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              SizedBox(height: 2.h),
              Divider(color: subTextColor.withOpacity(0.1), height: 1),

              // View Profile option
              ListTile(
                leading: Icon(
                  Icons.person_outline,
                  color: accentColor,
                  size: 20.sp,
                ),
                title: Text(
                  'View Profile',
                  style: GoogleFonts.inter(
                    color: textColor,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  context.pop(); // Close bottom sheet
                  // TODO: Navigate to profile
                },
              ),

              // Make/Dismiss Admin option
              ListTile(
                leading: Icon(
                  isAdmin
                      ? Icons.remove_moderator_outlined
                      : Icons.admin_panel_settings_outlined,
                  color: accentColor,
                  size: 20.sp,
                ),
                title: Text(
                  isAdmin ? 'Dismiss as Admin' : 'Make Group Admin',
                  style: GoogleFonts.inter(
                    color: textColor,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  context.pop(); // Close bottom sheet
                  // TODO: Toggle admin status
                },
              ),

              // Remove from group option
              ListTile(
                leading: Icon(
                  Icons.person_remove_outlined,
                  color: dangerColor,
                  size: 20.sp,
                ),
                title: Text(
                  'Remove from Group',
                  style: GoogleFonts.inter(
                    color: dangerColor,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  context.pop(); // Close bottom sheet
                  // TODO: Remove member
                },
              ),

              SizedBox(height: 2.h),
            ],
          ),
        );
      },
    );
  }

  Future<void> _exitGroup(BuildContext context, Color dangerColor) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Exit Group'),
        content: Text('Are you sure you want to exit this group?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: dangerColor),
            child: Text('Exit'),
          ),
        ],
      ),
    );

    if (confirmed == true && _currentUserId != null) {
      try {
        await SupabaseService.client
            .from('conversation_members')
            .delete()
            .eq('conversation_id', widget.conversationId)
            .eq('user_id', _currentUserId!);

        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('You have left the group')));
          // Pop back to chat list
          context.pop();
          context.pop();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Failed to exit group: $e')));
        }
      }
    }
  }

  Widget _buildFallbackAvatar(Color groupColor) {
    return Container(
      width: 38.w,
      height: 38.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: groupColor.withOpacity(0.2),
        border: Border.all(color: Colors.white, width: 4),
      ),
      child: Center(
        child: Text(
          _groupName.isNotEmpty ? _groupName[0].toUpperCase() : 'G',
          style: GoogleFonts.inter(
            fontSize: 50.sp,
            fontWeight: FontWeight.bold,
            color: groupColor,
          ),
        ),
      ),
    );
  }
}
