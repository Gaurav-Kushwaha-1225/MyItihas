import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myitihas/core/di/injection_container.dart';
import 'package:myitihas/services/chat_service.dart';
import 'package:myitihas/services/supabase_service.dart';
import 'package:myitihas/utils/constants.dart';
import 'package:sizer/sizer.dart';

class CreateGroupPage extends StatefulWidget {
  final List<Map<String, dynamic>> selectedUsers;

  const CreateGroupPage({super.key, required this.selectedUsers});

  @override
  State<CreateGroupPage> createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  final TextEditingController _groupNameController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  final ChatService _chatService = getIt<ChatService>();
  File? _selectedGroupImage;
  bool _isCreating = false;

  @override
  void dispose() {
    _groupNameController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _selectedGroupImage = File(image.path);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to pick image: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _createGroup() async {
    // Validate group name
    final groupName = _groupNameController.text.trim();
    if (groupName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a group name'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // Validate avatar selection
    if (_selectedGroupImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select a group avatar'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      _isCreating = true;
    });

    try {
      // Get current user ID
      final currentUserId = SupabaseService.client.auth.currentUser?.id;
      if (currentUserId == null) {
        throw Exception('User not authenticated');
      }

      // Prepare member user IDs (selected users + current user)
      final memberUserIds = [
        currentUserId,
        ...widget.selectedUsers.map((user) => user['id'] as String),
      ];

      // Create group conversation
      final conversationId = await _chatService.createGroupConversation(
        groupName: groupName,
        memberUserIds: memberUserIds,
        avatarFile: _selectedGroupImage!,
      );

      if (mounted) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Group "$groupName" created successfully!'),
            backgroundColor: Colors.green,
          ),
        );

        // Navigate back to chat home (pop twice to go back to chat list)
        context.pop(); // Pop create_group_page
        context.pop(); // Pop new_group_page
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isCreating = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to create group: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? DarkColors.textPrimary : LightColors.textPrimary;
    final subTextColor = isDark
        ? DarkColors.textSecondary
        : LightColors.textSecondary;
    final accentColor = isDark
        ? DarkColors.accentPrimary
        : LightColors.accentPrimary;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(6.h),
        child: Container(
          decoration: BoxDecoration(
            gradient: isDark
                ? DarkColors.featureCardGradient
                : LightColors.featureCardGradient,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).secondaryHeaderColor.withAlpha(50),
                blurRadius: 10,
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: textColor),
                    onPressed: () => context.pop(),
                  ),
                  Expanded(
                    child: Text(
                      "New Group",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        fontSize: 18.sp,
                        foreground: Paint()
                          ..shader =
                              (isDark
                                      ? DarkColors.messageUserGradient
                                      : LightColors.messageUserGradient)
                                  .createShader(Rect.fromLTWH(0, 0, 200, 70)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              DarkColors.accentPrimary.withAlpha(5),
              isDark ? Color(0xFF1E293B) : Color(0xFFF1F5F9),
            ],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 4.w),
          children: [
            // Group Avatar Section
            Center(
              child: Stack(
                children: [
                  // Circle Avatar with image or "G" fallback
                  _selectedGroupImage != null
                      ? CircleAvatar(
                          radius: 15.w,
                          backgroundImage: FileImage(_selectedGroupImage!),
                          backgroundColor: accentColor.withOpacity(0.2),
                        )
                      : Container(
                          width: 30.w,
                          height: 30.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: accentColor.withOpacity(0.2),
                            border: Border.all(
                              color: accentColor.withOpacity(0.3),
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'G',
                              style: GoogleFonts.inter(
                                fontSize: 48.sp,
                                fontWeight: FontWeight.bold,
                                color: accentColor,
                              ),
                            ),
                          ),
                        ),
                  // Camera Icon
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        padding: EdgeInsets.all(2.w),
                        decoration: BoxDecoration(
                          color: accentColor,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isDark ? DarkColors.bgColor : Colors.white,
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 16.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 4.h),

            // Group Name Text Field
            Container(
              decoration: BoxDecoration(
                color: isDark ? DarkColors.glassBg : Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withOpacity(0.1)
                      : Colors.grey.withOpacity(0.3),
                ),
              ),
              child: TextField(
                controller: _groupNameController,
                style: TextStyle(
                  color: textColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                  hintText: 'Group Name',
                  hintStyle: TextStyle(color: subTextColor, fontSize: 16.sp),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 5.w,
                    vertical: 2.h,
                  ),
                ),
              ),
            ),

            SizedBox(height: 4.h),

            // Participants Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: Text(
                'Participants: ${widget.selectedUsers.length}',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: subTextColor,
                ),
              ),
            ),

            SizedBox(height: 2.h),

            // Participants List (Wrap layout)
            Wrap(
              spacing: 3.w,
              runSpacing: 2.h,
              children: widget.selectedUsers.map((user) {
                final username = user['username'] as String? ?? 'Unknown';
                final fullName = user['full_name'] as String?;
                final avatarUrl = user['avatar_url'] as String?;

                return SizedBox(
                  width: 20.w,
                  child: Column(
                    children: [
                      // Avatar
                      avatarUrl != null && avatarUrl.isNotEmpty
                          ? CircleAvatar(
                              radius: 8.w,
                              backgroundImage: NetworkImage(avatarUrl),
                              onBackgroundImageError: (_, _) {},
                              backgroundColor: accentColor.withOpacity(0.2),
                            )
                          : Container(
                              width: 16.w,
                              height: 16.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: accentColor.withOpacity(0.2),
                              ),
                              child: Center(
                                child: Text(
                                  (fullName ?? username).isNotEmpty
                                      ? (fullName ?? username)[0].toUpperCase()
                                      : '?',
                                  style: GoogleFonts.inter(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                    color: accentColor,
                                  ),
                                ),
                              ),
                            ),
                      SizedBox(height: 1.h),
                      // Name
                      Text(
                        fullName ?? username,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          color: textColor,
                          fontWeight: FontWeight.w500,
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

      // Create Button
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 2.h, right: 2.w),
        child: FloatingActionButton.extended(
          onPressed: _isCreating ? null : _createGroup,
          backgroundColor: _isCreating ? Colors.grey : accentColor,
          icon: _isCreating
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : Icon(Icons.check, color: Colors.white),
          label: Text(
            _isCreating ? 'Creating...' : 'Create',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
