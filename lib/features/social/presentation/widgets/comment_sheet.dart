import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myitihas/config/theme/gradient_extension.dart';
import 'package:myitihas/core/di/injection_container.dart';
import 'package:myitihas/features/social/domain/entities/comment.dart';
import 'package:myitihas/features/social/domain/entities/content_type.dart';
import 'package:myitihas/features/social/domain/repositories/social_repository.dart';
import 'package:myitihas/features/social/presentation/widgets/comment_tile.dart';
import 'package:myitihas/i18n/strings.g.dart';

class CommentSheet extends StatefulWidget {
  final String contentId;
  final ContentType contentType;
  final int initialCommentCount;

  const CommentSheet({
    super.key,
    required this.contentId,
    required this.contentType,
    required this.initialCommentCount,
  });

  @override
  State<CommentSheet> createState() => _CommentSheetState();
}

class _CommentSheetState extends State<CommentSheet> {
  final _commentController = TextEditingController();
  final _focusNode = FocusNode();
  final _scrollController = ScrollController();

  List<Comment> _comments = [];
  bool _isLoading = true;
  bool _isPosting = false;
  String? _error;
  String? _replyToCommentId;
  String? _replyToUserName;

  @override
  void initState() {
    super.initState();
    _loadComments();
  }

  @override
  void dispose() {
    _commentController.dispose();
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadComments() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final repository = getIt<SocialRepository>();
      final result = await repository.getCommentsTree(widget.contentId);

      result.fold(
        (failure) => setState(() => _error = failure.message),
        (comments) => setState(() => _comments = comments),
      );
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _postComment() async {
    final text = _commentController.text.trim();
    if (text.isEmpty) return;

    setState(() => _isPosting = true);
    HapticFeedback.mediumImpact();

    try {
      final repository = getIt<SocialRepository>();
      final result = await repository.addComment(
        storyId: widget.contentId,
        text: text,
        parentCommentId: _replyToCommentId,
      );

      result.fold(
        (failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(failure.message)),
          );
        },
        (comment) {
          _commentController.clear();
          _cancelReply();
          _loadComments(); // Refresh comments
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to post: $e')),
      );
    } finally {
      setState(() => _isPosting = false);
    }
  }

  void _startReply(String commentId, String userName) {
    setState(() {
      _replyToCommentId = commentId;
      _replyToUserName = userName;
    });
    _focusNode.requestFocus();
  }

  void _cancelReply() {
    setState(() {
      _replyToCommentId = null;
      _replyToUserName = null;
    });
  }

  Future<void> _likeComment(String commentId) async {
    HapticFeedback.lightImpact();
    final repository = getIt<SocialRepository>();

    // Find the comment and check if liked
    final comment = _findComment(commentId, _comments);
    if (comment == null) return;

    if (comment.isLikedByCurrentUser) {
      await repository.unlikeComment(commentId);
    } else {
      await repository.likeComment(commentId);
    }

    _loadComments(); // Refresh
  }

  Comment? _findComment(String id, List<Comment> comments) {
    for (final comment in comments) {
      if (comment.id == id) return comment;
      final found = _findComment(id, comment.replies);
      if (found != null) return found;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final gradients = theme.extension<GradientExtension>();
    final t = Translations.of(context);

    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 12.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Text(
                  t.feed.comments,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 8.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    '${_comments.length}',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),
          Divider(height: 1),
          // Comments list
          Expanded(
            child: _buildContent(colorScheme, t),
          ),
          if (_replyToUserName != null)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer.withValues(alpha: 0.3),
                border: Border(
                  top: BorderSide(color: colorScheme.outlineVariant),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.reply,
                    size: 16.sp,
                    color: colorScheme.primary,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Replying to $_replyToUserName',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.primary,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: _cancelReply,
                    child: Icon(
                      Icons.close,
                      size: 16.sp,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          Container(
            padding: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
              top: 12.h,
              bottom: MediaQuery.of(context).viewInsets.bottom + 16.h,
            ),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              border: Border(
                top: BorderSide(color: colorScheme.outlineVariant),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    focusNode: _focusNode,
                    decoration: InputDecoration(
                      hintText: _replyToUserName != null
                          ? 'Reply to $_replyToUserName...'
                          : t.feed.addCommentHint,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.r),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: colorScheme.surface,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                    ),
                    maxLines: null,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _postComment(),
                  ),
                ),
                SizedBox(width: 8.w),
                Container(
                  decoration: BoxDecoration(
                    gradient: gradients?.primaryButtonGradient,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: _isPosting ? null : _postComment,
                    icon: _isPosting
                        ? SizedBox(
                            width: 20.w,
                            height: 20.w,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Icon(Icons.send, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(ColorScheme colorScheme, Translations t) {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 48.sp,
              color: Colors.red,
            ),
            SizedBox(height: 16.h),
            Text(_error!),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: _loadComments,
              child: Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_comments.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: 48.sp,
              color: colorScheme.onSurfaceVariant,
            ),
            SizedBox(height: 16.h),
            Text(
              'No comments yet',
              style: TextStyle(color: colorScheme.onSurfaceVariant),
            ),
            SizedBox(height: 8.h),
            Text(
              'Be the first to comment!',
              style: TextStyle(
                color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadComments,
      child: ListView.separated(
        controller: _scrollController,
        padding: EdgeInsets.symmetric(vertical: 8.h),
        itemCount: _comments.length,
        separatorBuilder: (_, __) => Divider(
          height: 1,
          indent: 16.w,
          endIndent: 16.w,
        ),
        itemBuilder: (context, index) {
          final comment = _comments[index];
          return CommentTile(
            comment: comment,
            onLike: () => _likeComment(comment.id),
            onReply: () => _startReply(comment.id, comment.userName),
            onProfileTap: () {
              // Navigate to profile
            },
          );
        },
      ),
    );
  }
}
