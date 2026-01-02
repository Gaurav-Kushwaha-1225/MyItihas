import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myitihas/utils/constants.dart';
import 'package:sizer/sizer.dart';
import 'package:myitihas/services/supabase_service.dart';
import 'package:myitihas/core/di/injection_container.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show FileOptions;

class EditGroupPage extends StatefulWidget {
  final String conversationId;

  const EditGroupPage({super.key, required this.conversationId});

  @override
  State<EditGroupPage> createState() => _EditGroupPageState();
}

class _EditGroupPageState extends State<EditGroupPage> {
  final TextEditingController _groupNameController = TextEditingController();
  final TextEditingController _groupDescriptionController =
      TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final logger = getIt<Talker>();

  File? _selectedGroupImage;
  String? _currentAvatarUrl;
  bool _isLoading = true;
  bool _isSaving = false;
  bool _avatarChanged = false;

  @override
  void initState() {
    super.initState();
    _loadGroupData();
  }

  @override
  void dispose() {
    _groupNameController.dispose();
    _groupDescriptionController.dispose();
    super.dispose();
  }

  Future<void> _loadGroupData() async {
    try {
      final data = await SupabaseService.client
          .from('conversations')
          .select('group_name, group_description, group_avatar_url')
          .eq('id', widget.conversationId)
          .single();

      setState(() {
        _groupNameController.text = data['group_name'] ?? '';
        _groupDescriptionController.text = data['group_description'] ?? '';
        _currentAvatarUrl = data['group_avatar_url'];
        _isLoading = false;
      });
    } catch (e) {
      logger.error('Error loading group data', e);
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

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() {
          _selectedGroupImage = File(pickedFile.path);
          _avatarChanged = true;
        });
      }
    } catch (e) {
      logger.error('Error picking image', e);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to pick image: $e')));
      }
    }
  }

  Future<void> _saveChanges() async {
    final groupName = _groupNameController.text.trim();

    if (groupName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a group name')),
      );
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      String? newAvatarUrl = _currentAvatarUrl;

      // Handle avatar update if changed
      if (_avatarChanged && _selectedGroupImage != null) {
        // Delete old avatar if exists
        if (_currentAvatarUrl != null && _currentAvatarUrl!.isNotEmpty) {
          try {
            final oldPath = '${widget.conversationId}/avatar.jpg';
            await SupabaseService.client.storage.from('group_avatar').remove([
              oldPath,
            ]);
            logger.debug('Deleted old avatar: $oldPath');
          } catch (e) {
            logger.warning('Failed to delete old avatar', e);
          }
        }

        // Upload new avatar
        final avatarPath = '${widget.conversationId}/avatar.jpg';
        await SupabaseService.client.storage
            .from('group_avatar')
            .upload(
              avatarPath,
              _selectedGroupImage!,
              fileOptions: FileOptions(cacheControl: '3600', upsert: true),
            );

        // Get public URL
        newAvatarUrl = SupabaseService.client.storage
            .from('group_avatar')
            .getPublicUrl(avatarPath);
        logger.debug('Uploaded new avatar: $avatarPath');
      }

      // Update conversations table
      final updateResponse = await SupabaseService.client
          .from('conversations')
          .update({
            'group_name': groupName,
            'group_description': _groupDescriptionController.text.trim(),
            'group_avatar_url': newAvatarUrl,
          })
          .eq('id', widget.conversationId)
          .select();

      logger.info('Group updated successfully: $updateResponse');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Group updated successfully')),
        );
        context.pop(true); // Return true to indicate success
      }
    } catch (e) {
      logger.error('Error saving group changes', e);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to save changes: $e')));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
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
    Color accentColor = const Color(0xFF3B82F6);
    Color groupColor = const Color(0xFF8B5CF6);

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
          title: Text(
            'Edit Group',
            style: GoogleFonts.inter(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
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
        title: Text(
          'Edit Group',
          style: GoogleFonts.inter(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 4.h),

              // Group Avatar with Camera Button
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 35.w,
                    height: 35.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: groupColor.withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                  ),
                  _selectedGroupImage != null
                      ? Container(
                          width: 32.w,
                          height: 32.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 4),
                          ),
                          child: ClipOval(
                            child: Image.file(
                              _selectedGroupImage!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : (_currentAvatarUrl != null &&
                            _currentAvatarUrl!.isNotEmpty)
                      ? Container(
                          width: 32.w,
                          height: 32.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 4),
                          ),
                          child: ClipOval(
                            child: Image.network(
                              _currentAvatarUrl!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return _buildFallbackAvatar(groupColor);
                              },
                            ),
                          ),
                        )
                      : _buildFallbackAvatar(groupColor),

                  // Camera Button
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
                          border: Border.all(color: bgColor, width: 3),
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 18.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 4.h),

              // Group Name Input
              TextField(
                controller: _groupNameController,
                style: GoogleFonts.inter(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                  labelText: 'Group Name',
                  labelStyle: GoogleFonts.inter(color: subTextColor),
                  filled: true,
                  fillColor: isDark ? DarkColors.glassBg : Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 4.w,
                    vertical: 2.h,
                  ),
                ),
              ),

              SizedBox(height: 2.h),

              // Group Description Input
              TextField(
                controller: _groupDescriptionController,
                style: GoogleFonts.inter(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Description (Optional)',
                  labelStyle: GoogleFonts.inter(color: subTextColor),
                  filled: true,
                  fillColor: isDark ? DarkColors.glassBg : Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 4.w,
                    vertical: 2.h,
                  ),
                ),
              ),

              SizedBox(height: 4.h),

              // Save Button
              SizedBox(
                width: double.infinity,
                height: 6.h,
                child: ElevatedButton(
                  onPressed: _isSaving ? null : _saveChanges,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: _isSaving
                      ? SizedBox(
                          height: 20.sp,
                          width: 20.sp,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          'Save Changes',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),

              SizedBox(height: 3.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFallbackAvatar(Color groupColor) {
    return Container(
      width: 32.w,
      height: 32.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: groupColor.withOpacity(0.2),
        border: Border.all(color: Colors.white, width: 4),
      ),
      child: Center(
        child: Text(
          _groupNameController.text.isNotEmpty
              ? _groupNameController.text[0].toUpperCase()
              : 'G',
          style: GoogleFonts.inter(
            fontSize: 40.sp,
            fontWeight: FontWeight.bold,
            color: groupColor,
          ),
        ),
      ),
    );
  }
}
