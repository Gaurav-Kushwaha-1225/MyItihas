import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myitihas/config/theme/gradient_extension.dart';
import 'package:myitihas/core/di/injection_container.dart';
import 'package:myitihas/services/post_service.dart';

import '../bloc/create_post_bloc.dart';
import '../bloc/create_post_event.dart';
import '../bloc/create_post_state.dart';

class CreatePostPage extends StatelessWidget {
  const CreatePostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CreatePostBloc>()
        ..add(const CreatePostEvent.initialize()),
      child: const _CreatePostView(),
    );
  }
}

class _CreatePostView extends StatefulWidget {
  const _CreatePostView();

  @override
  State<_CreatePostView> createState() => _CreatePostViewState();
}

class _CreatePostViewState extends State<_CreatePostView>
    with TickerProviderStateMixin {
  final _contentController = TextEditingController();
  final _titleController = TextEditingController();
  final _imagePicker = ImagePicker();
  final _contentFocusNode = FocusNode();

  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _contentController.dispose();
    _titleController.dispose();
    _contentFocusNode.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    final state = context.read<CreatePostBloc>().state;
    if (!state.hasContent) return true;

    final shouldDiscard = await showDialog<bool>(
      context: context,
      builder: (context) => _DiscardDialog(),
    );
    return shouldDiscard ?? false;
  }

  Future<void> _pickImages() async {
    HapticFeedback.selectionClick();
    try {
      final images = await _imagePicker.pickMultiImage(
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );
      if (images.isNotEmpty && mounted) {
        final files = images.map((xFile) => File(xFile.path)).toList();
        context.read<CreatePostBloc>().add(CreatePostEvent.addMedia(files));
      }
    } catch (e) {
      _showErrorSnackBar('Failed to pick images');
    }
  }

  Future<void> _pickVideo() async {
    HapticFeedback.selectionClick();
    try {
      final video = await _imagePicker.pickVideo(
        source: ImageSource.gallery,
        maxDuration: const Duration(minutes: 5),
      );
      if (video != null && mounted) {
        context.read<CreatePostBloc>().add(
              CreatePostEvent.addMedia([File(video.path)]),
            );
      }
    } catch (e) {
      _showErrorSnackBar('Failed to pick video');
    }
  }

  Future<void> _takePhoto() async {
    HapticFeedback.selectionClick();
    try {
      final photo = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );
      if (photo != null && mounted) {
        context.read<CreatePostBloc>().add(
              CreatePostEvent.addMedia([File(photo.path)]),
            );
      }
    } catch (e) {
      _showErrorSnackBar('Failed to capture photo');
    }
  }

  void _showErrorSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final gradients = theme.extension<GradientExtension>();
    final isDark = theme.brightness == Brightness.dark;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldPop = await _onWillPop();
        if (shouldPop && mounted) context.pop();
      },
      child: BlocConsumer<CreatePostBloc, CreatePostState>(
        listener: (context, state) {
          if (state.isSuccess) {
            HapticFeedback.heavyImpact();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    const Icon(Icons.check_circle, color: Colors.white),
                    const SizedBox(width: 12),
                    const Text('Post created!'),
                  ],
                ),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
            context.pop(true);
          } else if (state.errorMessage != null) {
            _showErrorSnackBar(state.errorMessage!);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: isDark ? const Color(0xFF0F0F14) : Colors.grey[50],
            body: CustomScrollView(
              slivers: [
                _buildAppBar(context, state, colorScheme, gradients, isDark),
                SliverToBoxAdapter(
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Column(
                          children: [
                            SizedBox(height: 16.h),
                            _buildPostTypePills(context, state, colorScheme, gradients),
                            SizedBox(height: 20.h),
                            _buildContentCard(context, state, colorScheme, isDark),
                            SizedBox(height: 16.h),
                            if (state.postType == PostType.image ||
                                state.postType == PostType.video)
                              _buildMediaSection(context, state, colorScheme, isDark),
                            _buildVisibilitySection(context, state, colorScheme, isDark),
                            SizedBox(height: 100.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAppBar(
    BuildContext context,
    CreatePostState state,
    ColorScheme colorScheme,
    GradientExtension? gradients,
    bool isDark,
  ) {
    return SliverAppBar(
      floating: true,
      backgroundColor: isDark ? const Color(0xFF0F0F14) : Colors.grey[50],
      elevation: 0,
      leading: IconButton(
        icon: Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.close_rounded,
            color: colorScheme.onSurface,
            size: 20.sp,
          ),
        ),
        onPressed: () async {
          final shouldPop = await _onWillPop();
          if (shouldPop && mounted) context.pop();
        },
      ),
      title: Text(
        'Create Post',
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 12.w),
          child: _buildPostButton(context, state, gradients),
        ),
      ],
    );
  }

  Widget _buildPostButton(
    BuildContext context,
    CreatePostState state,
    GradientExtension? gradients,
  ) {
    if (state.isSubmitting) {
      return Container(
        width: 80.w,
        height: 36.h,
        alignment: Alignment.center,
        child: SizedBox(
          width: 20.w,
          height: 20.w,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }

    return GestureDetector(
      onTap: state.canSubmit
          ? () {
              HapticFeedback.mediumImpact();
              context.read<CreatePostBloc>().add(const CreatePostEvent.submit());
            }
          : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(
          gradient: state.canSubmit ? gradients?.primaryButtonGradient : null,
          color: state.canSubmit ? null : Colors.grey.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: state.canSubmit
              ? [
                  BoxShadow(
                    color: (gradients?.primaryButtonGradient as LinearGradient?)
                            ?.colors
                            .first
                            .withValues(alpha: 0.3) ??
                        Colors.blue.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Text(
          'Post',
          style: TextStyle(
            color: state.canSubmit ? Colors.white : Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildPostTypePills(
    BuildContext context,
    CreatePostState state,
    ColorScheme colorScheme,
    GradientExtension? gradients,
  ) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(28.r),
      ),
      child: Row(
        children: [
          _buildTypePill(
            context: context,
            icon: Icons.text_fields_rounded,
            label: 'Text',
            isSelected: state.postType == PostType.text,
            onTap: () => context.read<CreatePostBloc>().add(
                  const CreatePostEvent.selectType(PostType.text),
                ),
            gradients: gradients,
          ),
          _buildTypePill(
            context: context,
            icon: Icons.image_rounded,
            label: 'Image',
            isSelected: state.postType == PostType.image,
            onTap: () => context.read<CreatePostBloc>().add(
                  const CreatePostEvent.selectType(PostType.image),
                ),
            gradients: gradients,
          ),
          _buildTypePill(
            context: context,
            icon: Icons.videocam_rounded,
            label: 'Video',
            isSelected: state.postType == PostType.video,
            onTap: () => context.read<CreatePostBloc>().add(
                  const CreatePostEvent.selectType(PostType.video),
                ),
            gradients: gradients,
          ),
        ],
      ),
    );
  }

  Widget _buildTypePill({
    required BuildContext context,
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    required GradientExtension? gradients,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          HapticFeedback.selectionClick();
          onTap();
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(vertical: 10.h),
          decoration: BoxDecoration(
            gradient: isSelected ? gradients?.primaryButtonGradient : null,
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18.sp,
                color: isSelected
                    ? Colors.white
                    : Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              SizedBox(width: 6.w),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected
                      ? Colors.white
                      : Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContentCard(
    BuildContext context,
    CreatePostState state,
    ColorScheme colorScheme,
    bool isDark,
  ) {
    final hintText = switch (state.postType) {
      PostType.text => "What's on your mind? ✨",
      PostType.image => 'Write a caption for your photo...',
      PostType.video => 'Describe your video...',
      PostType.storyShare => 'Add your thoughts...',
    };

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A24) : Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.05)
              : Colors.grey.withValues(alpha: 0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Title field
          TextField(
            controller: _titleController,
            enabled: !state.isSubmitting,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              hintText: 'Add a title (optional)',
              hintStyle: TextStyle(
                color: colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                fontWeight: FontWeight.w500,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
            ),
            maxLength: 100,
            buildCounter: (_, {required currentLength, required isFocused, maxLength}) =>
                null,
            onChanged: (value) => context.read<CreatePostBloc>().add(
                  CreatePostEvent.updateTitle(value),
                ),
          ),
          Divider(
            height: 1,
            color: colorScheme.outline.withValues(alpha: 0.1),
          ),
          // Content field
          TextField(
            controller: _contentController,
            focusNode: _contentFocusNode,
            enabled: !state.isSubmitting,
            style: TextStyle(fontSize: 15.sp, height: 1.5),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(16.w),
            ),
            maxLines: null,
            minLines: state.postType == PostType.text ? 8 : 4,
            maxLength: 2000,
            buildCounter: (context,
                {required currentLength, required isFocused, maxLength}) {
              return Padding(
                padding: EdgeInsets.only(right: 16.w, bottom: 12.h),
                child: Text(
                  '$currentLength/2000',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                  ),
                ),
              );
            },
            onChanged: (value) => context.read<CreatePostBloc>().add(
                  CreatePostEvent.updateContent(value),
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildMediaSection(
    BuildContext context,
    CreatePostState state,
    ColorScheme colorScheme,
    bool isDark,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Media preview
        if (state.mediaFiles.isNotEmpty)
          _buildMediaPreview(context, state, colorScheme, isDark),

        // Add media buttons
        if ((state.postType == PostType.image && state.mediaFiles.length < 10) ||
            (state.postType == PostType.video && state.mediaFiles.isEmpty))
          _buildMediaButtons(context, state, colorScheme, isDark),

        SizedBox(height: 16.h),
      ],
    );
  }

  Widget _buildMediaPreview(
    BuildContext context,
    CreatePostState state,
    ColorScheme colorScheme,
    bool isDark,
  ) {
    if (state.postType == PostType.video && state.mediaFiles.isNotEmpty) {
      return Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1A1A24) : Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: colorScheme.primary.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(Icons.videocam_rounded, color: colorScheme.primary),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                state.mediaFiles.first.path.split('/').last,
                style: TextStyle(fontSize: 14.sp),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
              icon: Icon(Icons.close, color: Colors.red),
              onPressed: () => context.read<CreatePostBloc>().add(
                    const CreatePostEvent.removeMedia(0),
                  ),
            ),
          ],
        ),
      );
    }

    // Image grid
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      child: Wrap(
        spacing: 8.w,
        runSpacing: 8.h,
        children: state.mediaFiles.asMap().entries.map((entry) {
          return _buildImageThumbnail(context, entry.key, entry.value);
        }).toList(),
      ),
    );
  }

  Widget _buildImageThumbnail(BuildContext context, int index, File file) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Image.file(
            file,
            width: 100.w,
            height: 100.w,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 4.w,
          right: 4.w,
          child: GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              context.read<CreatePostBloc>().add(CreatePostEvent.removeMedia(index));
            },
            child: Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.6),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close_rounded,
                size: 14.sp,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMediaButtons(
    BuildContext context,
    CreatePostState state,
    ColorScheme colorScheme,
    bool isDark,
  ) {
    if (state.postType == PostType.video) {
      return _buildMediaButton(
        icon: Icons.video_library_rounded,
        label: 'Select Video',
        onTap: _pickVideo,
        colorScheme: colorScheme,
        isDark: isDark,
      );
    }

    return Row(
      children: [
        Expanded(
          child: _buildMediaButton(
            icon: Icons.photo_library_rounded,
            label: 'Gallery',
            onTap: _pickImages,
            colorScheme: colorScheme,
            isDark: isDark,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _buildMediaButton(
            icon: Icons.camera_alt_rounded,
            label: 'Camera',
            onTap: _takePhoto,
            colorScheme: colorScheme,
            isDark: isDark,
          ),
        ),
      ],
    );
  }

  Widget _buildMediaButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required ColorScheme colorScheme,
    required bool isDark,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1A1A24) : Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: colorScheme.primary.withValues(alpha: 0.3),
            width: 1.5,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, size: 28.sp, color: colorScheme.primary),
            SizedBox(height: 8.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVisibilitySection(
    BuildContext context,
    CreatePostState state,
    ColorScheme colorScheme,
    bool isDark,
  ) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A24) : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.05)
              : Colors.grey.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Who can see this?',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              _buildVisibilityOption(
                context: context,
                icon: Icons.public_rounded,
                label: 'Public',
                isSelected: state.visibility == PostVisibility.public,
                onTap: () => context.read<CreatePostBloc>().add(
                      const CreatePostEvent.changeVisibility(PostVisibility.public),
                    ),
                colorScheme: colorScheme,
              ),
              SizedBox(width: 8.w),
              _buildVisibilityOption(
                context: context,
                icon: Icons.people_rounded,
                label: 'Followers',
                isSelected: state.visibility == PostVisibility.followers,
                onTap: () => context.read<CreatePostBloc>().add(
                      const CreatePostEvent.changeVisibility(PostVisibility.followers),
                    ),
                colorScheme: colorScheme,
              ),
              SizedBox(width: 8.w),
              _buildVisibilityOption(
                context: context,
                icon: Icons.lock_rounded,
                label: 'Private',
                isSelected: state.visibility == PostVisibility.private,
                onTap: () => context.read<CreatePostBloc>().add(
                      const CreatePostEvent.changeVisibility(PostVisibility.private),
                    ),
                colorScheme: colorScheme,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVisibilityOption({
    required BuildContext context,
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    required ColorScheme colorScheme,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          HapticFeedback.selectionClick();
          onTap();
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(vertical: 10.h),
          decoration: BoxDecoration(
            color: isSelected
                ? colorScheme.primary.withValues(alpha: 0.15)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isSelected
                  ? colorScheme.primary
                  : colorScheme.outline.withValues(alpha: 0.2),
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                size: 20.sp,
                color: isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant,
              ),
              SizedBox(height: 4.h),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DiscardDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      title: Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: Colors.orange),
          SizedBox(width: 8.w),
          Text('Discard Post?'),
        ],
      ),
      content: Text(
        'You have unsaved changes. Are you sure you want to discard this post?',
        style: TextStyle(color: colorScheme.onSurfaceVariant),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text('Keep Editing'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          child: Text('Discard'),
        ),
      ],
    );
  }
}
