import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:myitihas/config/theme/gradient_extension.dart';
import 'package:myitihas/core/di/injection_container.dart';
import 'package:myitihas/features/social/domain/repositories/user_repository.dart';
import 'package:myitihas/features/social/presentation/widgets/svg_avatar.dart';

class EditProfilePage extends StatefulWidget {
  final String userId;
  final String currentDisplayName;
  final String currentBio;
  final String currentAvatarUrl;

  const EditProfilePage({
    super.key,
    required this.userId,
    required this.currentDisplayName,
    required this.currentBio,
    required this.currentAvatarUrl,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late final TextEditingController _displayNameController;
  late final TextEditingController _bioController;
  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;
  bool _isLoading = false;
  bool _hasChanges = false;

  @override
  void initState() {
    super.initState();
    _displayNameController = TextEditingController(text: widget.currentDisplayName);
    _bioController = TextEditingController(text: widget.currentBio);

    _displayNameController.addListener(_checkForChanges);
    _bioController.addListener(_checkForChanges);
  }

  void _checkForChanges() {
    final hasChanges = _displayNameController.text != widget.currentDisplayName ||
        _bioController.text != widget.currentBio ||
        _selectedImage != null;
    if (hasChanges != _hasChanges) {
      setState(() {
        _hasChanges = hasChanges;
      });
    }
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    _bioController.dispose();
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
          _selectedImage = File(image.path);
          _checkForChanges();
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

  Future<void> _saveChanges() async {
    final logger = getIt<Talker>();
    logger.info('💾 [UI] Save Changes initiated');
    
    if (_displayNameController.text.trim().isEmpty) {
      logger.warning('⚠️ [UI] Validation failed: Display name is empty');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Display name cannot be empty'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final userRepository = getIt<UserRepository>();
      logger.debug('[UI] Display Name: ${_displayNameController.text.trim()}');
      logger.debug('[UI] Bio: ${_bioController.text.trim()}');
      logger.debug('[UI] Has selected image: ${_selectedImage != null}');
      
      String? uploadedAvatarUrl;

      // Step 1: Upload profile photo if user selected one
      if (_selectedImage != null) {
        logger.info('📸 [UI] Uploading selected photo...');
        final uploadResult = await userRepository.uploadProfilePhoto(
          userId: widget.userId,
          imageFile: _selectedImage!,
        );

        await uploadResult.fold(
          (failure) async {
            // Photo upload failed - show error but continue with other updates
            logger.error('❌ [UI] Photo upload failed: ${failure.message}');
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Failed to upload photo: ${failure.message}'),
                  backgroundColor: Colors.orange,
                ),
              );
            }
          },
          (avatarUrl) async {
            logger.info('✅ [UI] Photo uploaded successfully: $avatarUrl');
            uploadedAvatarUrl = avatarUrl;
            
            // Clear cache for old avatar URL to force refresh
            if (widget.currentAvatarUrl.isNotEmpty) {
              await CachedNetworkImage.evictFromCache(widget.currentAvatarUrl);
            }
            // Also evict the new URL to ensure fresh load
            await CachedNetworkImage.evictFromCache(avatarUrl);
          },
        );
      } else {
        logger.info('⏭️ [UI] No photo selected, skipping upload');
      }

      // Step 2: Update display name and bio
      logger.info('📝 [UI] Updating profile information...');
      final result = await userRepository.updateUserProfile(
        userId: widget.userId,
        displayName: _displayNameController.text.trim(),
        bio: _bioController.text.trim(),
      );

      result.fold(
        (failure) {
          logger.error('❌ [UI] Profile update failed: ${failure.message}');
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to update profile: ${failure.message}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        (_) {
          logger.info('✅ [UI] Profile update successful');
          if (mounted) {
            final message = uploadedAvatarUrl != null
                ? 'Profile and photo updated successfully'
                : 'Profile updated successfully';
            logger.info('🎉 [UI] $message');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: Colors.green,
              ),
            );
            context.pop(true); // Return true to indicate success
          }
        },
      );
    } catch (e) {
      logger.error('❌ [UI] Unexpected error in _saveChanges', e);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An unexpected error occurred: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Photo Section
            Center(
              child: Column(
                children: [
                  Stack(
                    children: [
                      // Avatar Display
                      _selectedImage != null
                          ? CircleAvatar(
                              radius: 60,
                              backgroundImage: FileImage(_selectedImage!),
                            )
                          : SvgAvatar(
                              imageUrl: widget.currentAvatarUrl,
                              radius: 60,
                              fallbackText: widget.currentDisplayName,
                            ),
                      // Edit Button Overlay
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: Theme.of(context)
                                .extension<GradientExtension>()!
                                .primaryButtonGradient,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Theme.of(context).colorScheme.surface,
                              width: 3,
                            ),
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 20,
                            ),
                            onPressed: _isLoading ? null : _pickImage,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: _isLoading ? null : _pickImage,
                    child: const Text(
                      'Change Profile Photo',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Display Name Field
            Text(
              'Display Name',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _displayNameController,
              enabled: !_isLoading,
              decoration: InputDecoration(
                hintText: 'Enter your display name',
                filled: true,
                fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
              maxLength: 50,
            ),
            const SizedBox(height: 24),

            // Bio Field
            Text(
              'Bio',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _bioController,
              enabled: !_isLoading,
              decoration: InputDecoration(
                hintText: 'Tell us about yourself...',
                filled: true,
                fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
              maxLines: 5,
              maxLength: 150,
            ),
            const SizedBox(height: 32),

            // Save Button (alternative to app bar button)
            if (_hasChanges)
              SizedBox(
                width: double.infinity,
                height: 48,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: Theme.of(context)
                        .extension<GradientExtension>()!
                        .primaryButtonGradient,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _saveChanges,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Text(
                            'Save Changes',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
