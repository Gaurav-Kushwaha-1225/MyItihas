// ignore_for_file: unused_element, unused_field

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:myitihas/core/di/injection_container.dart';
import 'package:myitihas/features/stories/domain/entities/story.dart';
import 'package:myitihas/features/social/domain/entities/share.dart';
import 'package:myitihas/features/social/domain/entities/comment.dart';
import 'package:myitihas/features/social/domain/repositories/social_repository.dart';
import 'package:myitihas/features/social/presentation/bloc/comment_bloc.dart';
import 'package:myitihas/features/social/presentation/bloc/comment_event.dart';
import 'package:myitihas/features/social/presentation/bloc/comment_state.dart';
import 'package:myitihas/features/social/presentation/widgets/svg_avatar.dart';
import 'package:myitihas/features/home/domain/repositories/continue_reading_repository.dart';
import 'package:myitihas/utils/constants.dart';

class StoryDetailPage extends StatefulWidget {
  final Story story;
  final VoidCallback? onFavorite;

  const StoryDetailPage({super.key, required this.story, this.onFavorite});

  @override
  State<StoryDetailPage> createState() => _StoryDetailPageState();
}

class _StoryDetailPageState extends State<StoryDetailPage> {
  late final SocialRepository _socialRepository;
  late bool _isLiked;
  late int _likeCount;
  late int _shareCount;
  late int _commentCount;

  @override
  void initState() {
    super.initState();
    _socialRepository = getIt<SocialRepository>();

    _isLiked = widget.story.isLikedByCurrentUser;
    _likeCount = widget.story.likes;
    _shareCount = widget.story.shareCount;
    _commentCount = widget.story.commentCount;

    _loadSocialStats();

    // Add to continue reading list
    getIt<ContinueReadingRepository>().addStoryToContinueReading(widget.story);
  }

  Future<void> _loadSocialStats() async {
    final likedResult = await _socialRepository.isStoryLiked(widget.story.id);
    final likeCountResult = await _socialRepository.getStoryLikeCount(
      widget.story.id,
    );
    final shareCountResult = await _socialRepository.getStoryShareCount(
      widget.story.id,
    );

    if (!mounted) return;

    setState(() {
      likedResult.fold((_) {}, (liked) => _isLiked = liked);
      likeCountResult.fold((_) {}, (count) => _likeCount = count);
      shareCountResult.fold((_) {}, (count) => _shareCount = count);
    });
  }

  @override
  Widget build(BuildContext context) {
    // final t = Translations.of(context);
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    bool isDark = theme.brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Theme.of(context).primaryColor.withAlpha(5),
                Theme.of(context).brightness == Brightness.dark
                    ? Color(0xFF1E293B)
                    : Color(0xFFF1F5F9),
              ],
              transform: GradientRotation(3.14 / 1.5),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: screenSize.height * 0.115,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.7),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_rounded),
                      onPressed: () {
                        context.pop();
                      },
                    ),
                    Spacer(),
                    if (widget.onFavorite != null)
                      IconButton(
                        icon: Icon(
                          widget.story.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: widget.story.isFavorite
                              ? theme.colorScheme.error
                              : null,
                        ),
                        onPressed: widget.onFavorite,
                      ),
                    IconButton(
                      icon: const Icon(Icons.share),
                      onPressed: () {
                        _showShareDialog(context);
                      },
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
                  Container(
                    width: screenSize.width,
                    height: screenSize.height * 0.4,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.15),
                          blurRadius: 100,
                          spreadRadius: 0,
                          offset: const Offset(0, -6),
                        ),
                      ],
                    ),
                    child: widget.story.imageUrl != null
                        ? Image.network(
                            widget.story.imageUrl!,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  color: Theme.of(context).cardColor,
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset("assets/logo.png"),
                          )
                        : Image.asset(
                            ("assets/logo.png"),
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Center(
                                  child: Icon(
                                    Icons.error_outline_rounded,
                                    color: Colors.red.shade200,
                                  ),
                                ),
                          ),
                  ),
                  Container(
                    width: screenSize.width,
                    height: screenSize.height * 0.4,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Colors.black, Colors.transparent],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: screenSize.width,
                      height: screenSize.height * 0.3,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 5,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              if (widget.story.attributes.storyType.isNotEmpty)
                                Chip(
                                  padding: EdgeInsets.zero,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  label: Text(
                                    widget.story.attributes.storyType,
                                  ),
                                  labelStyle: Theme.of(
                                    context,
                                  ).textTheme.labelSmall,
                                  visualDensity: VisualDensity.compact,
                                  backgroundColor: Colors.transparent,
                                  side: BorderSide(width: 0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadiusGeometry.circular(
                                      20,
                                    ),
                                  ),
                                ),
                              SizedBox(width: screenSize.width * 0.02),
                              if (widget.story.attributes.theme.isNotEmpty)
                                Chip(
                                  padding: EdgeInsets.zero,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  label: Text(widget.story.attributes.theme),
                                  labelStyle: Theme.of(
                                    context,
                                  ).textTheme.labelSmall,
                                  visualDensity: VisualDensity.compact,
                                  backgroundColor: Colors.transparent,
                                  side: BorderSide(width: 0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadiusGeometry.circular(
                                      20,
                                    ),
                                  ),
                                ),

                              SizedBox(width: screenSize.width * 0.02),
                              if (widget
                                  .story
                                  .attributes
                                  .mainCharacterType
                                  .isNotEmpty)
                                Flexible(
                                  fit: FlexFit.loose,
                                  child: Chip(
                                    padding: EdgeInsets.zero,
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    label: Text(
                                      widget.story.attributes.mainCharacterType,
                                    ),
                                    labelStyle: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                    visualDensity: VisualDensity.compact,
                                    backgroundColor: Colors.transparent,
                                    side: BorderSide(width: 0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadiusGeometry.circular(20),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          Text(
                            widget.story.title,
                            maxLines: 2,
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: screenSize.height * 0.005),
                          Text(
                            widget.story.scripture,
                            maxLines: 1,
                            style: theme.textTheme.bodySmall?.copyWith(
                              overflow: TextOverflow.ellipsis,
                              color: isDark
                                  ? DarkColors.textSecondary
                                  : LightColors.textSecondary,
                            ),
                          ),
                          SizedBox(height: screenSize.height * 0.005),
                          Row(
                            children: [
                              Text(
                                widget.story.authorUser != null
                                    ? widget.story.authorUser!.displayName
                                    : "By AI StoryTeller",
                                maxLines: 1,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  overflow: TextOverflow.ellipsis,
                                  color: isDark
                                      ? DarkColors.textPrimary
                                      : LightColors.textPrimary,
                                ),
                              ),
                              Text(
                                "  •  ",
                                maxLines: 1,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  overflow: TextOverflow.ellipsis,
                                  color: isDark
                                      ? DarkColors.textPrimary
                                      : LightColors.textPrimary,
                                ),
                              ),
                              Text(
                                "15 min read",
                                maxLines: 1,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  overflow: TextOverflow.ellipsis,
                                  color: isDark
                                      ? DarkColors.textPrimary
                                      : LightColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenSize.height * 0.01),

              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 8),
              //   child: _StorySocialActionsRow(
              //     isLiked: _isLiked,
              //     likeCount: _likeCount,
              //     commentCount: _commentCount,
              //     shareCount: _shareCount,
              //     onLike: _toggleLike,
              //     onComment: () => _showCommentsBottomSheet(context),
              //     onShare: () => _showShareDialog(context),
              //   ),
              // ),
              SizedBox(height: screenSize.height * 0.01),

              // Story content
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: widget.story.story.isNotEmpty
                            ? widget.story.story[0]
                            : '',
                        style: theme.textTheme.bodyMedium!.copyWith(
                          fontSize:
                              theme.textTheme.bodyLarge!.fontSize! *
                              2, // bigger
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      TextSpan(
                        text: widget.story.story.length > 1
                            ? widget.story.story.substring(1)
                            : '',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),

              // Quotes section
              if (widget.story.quotes.isNotEmpty)
                SizedBox(height: screenSize.height * 0.02),
              if (widget.story.quotes.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Quote\n",
                          style: theme.textTheme.bodyMedium!.copyWith(
                            fontSize:
                                theme.textTheme.bodyLarge!.fontSize! *
                                2, // bigger
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        TextSpan(
                          text: widget.story.quotes,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),

              // Trivia section
              if (widget.story.trivia.isNotEmpty)
                SizedBox(height: screenSize.height * 0.02),
              if (widget.story.trivia.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Trivia\n",
                          style: theme.textTheme.bodyMedium!.copyWith(
                            fontSize:
                                theme.textTheme.bodyLarge!.fontSize! *
                                2, // bigger
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        TextSpan(
                          text: widget.story.trivia,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),

              // Lesson section
              if (widget.story.lesson.isNotEmpty)
                SizedBox(height: screenSize.height * 0.02),
              if (widget.story.lesson.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Lesson\n",
                          style: theme.textTheme.bodyMedium!.copyWith(
                            fontSize:
                                theme.textTheme.bodyLarge!.fontSize! *
                                2, // bigger
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        TextSpan(
                          text: widget.story.lesson,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),

              // Activity section
              if (widget.story.activity.isNotEmpty)
                SizedBox(height: screenSize.height * 0.02),
              if (widget.story.activity.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Activity\n",
                          style: theme.textTheme.bodyMedium!.copyWith(
                            fontSize:
                                theme.textTheme.bodyLarge!.fontSize! *
                                2, // bigger
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        TextSpan(
                          text: widget.story.activity,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),

              SizedBox(height: screenSize.height * 0.02),
              // Metadata (author, published date, etc.)
              if (widget.story.author != null ||
                  widget.story.publishedAt != null) ...[
                Divider(),
                SizedBox(height: screenSize.height * 0.01),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.story.author != null)
                        _buildMetadataRow(
                          context,
                          Icons.person,
                          'Author',
                          widget.story.author!,
                        ),
                      if (widget.story.publishedAt != null)
                        _buildMetadataRow(
                          context,
                          Icons.calendar_today,
                          'Published',
                          '${widget.story.publishedAt!.day}/${widget.story.publishedAt!.month}/${widget.story.publishedAt!.year}',
                        ),
                      _buildMetadataRow(
                        context,
                        Icons.visibility,
                        'Views',
                        '${widget.story.views}',
                      ),
                      _buildMetadataRow(
                        context,
                        Icons.thumb_up,
                        'Likes',
                        '$_likeCount',
                      ),
                    ],
                  ),
                ),
              ],
              SizedBox(height: screenSize.height * 0.03),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _toggleLike() async {
    final wasLiked = _isLiked;

    setState(() {
      _isLiked = !wasLiked;
      _likeCount = wasLiked ? _likeCount - 1 : _likeCount + 1;
    });

    final result = wasLiked
        ? await _socialRepository.unlikeStory(widget.story.id)
        : await _socialRepository.likeStory(widget.story.id);

    if (!mounted) return;

    result.fold((failure) {
      setState(() {
        _isLiked = wasLiked;
        _likeCount = wasLiked ? _likeCount + 1 : _likeCount - 1;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(failure.message)));
    }, (_) {});
  }

  Future<void> _shareExternally() async {
    setState(() {
      _shareCount += 1;
    });

    final result = await _socialRepository.shareStory(
      storyId: widget.story.id,
      shareType: ShareType.external,
    );

    if (!mounted) return;

    result.fold(
      (failure) {
        setState(() {
          _shareCount -= 1;
        });
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(failure.message)));
      },
      (_) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Shared')));
      },
    );
  }

  Future<void> _showCommentsBottomSheet(BuildContext context) async {
    final didPost = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _CommentsSheet(storyId: widget.story.id),
    );

    if (didPost == true && mounted) {
      setState(() {
        _commentCount += 1;
      });
    }
  }

  Future<void> _showShareDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Share Story'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.message),
              title: const Text('Share via Message'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Coming soon')));
              },
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Share Externally'),
              onTap: () async {
                Navigator.pop(context);
                await _shareExternally();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetadataRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          Icon(icon, size: 16.sp, color: theme.colorScheme.secondary),
          SizedBox(width: 8.w),
          Text(
            '$label: ',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(child: Text(value, style: theme.textTheme.bodyMedium)),
        ],
      ),
    );
  }
}

class _StorySocialActionsRow extends StatelessWidget {
  final bool isLiked;
  final int likeCount;
  final int commentCount;
  final int shareCount;
  final VoidCallback onLike;
  final VoidCallback onComment;
  final VoidCallback onShare;

  const _StorySocialActionsRow({
    required this.isLiked,
    required this.likeCount,
    required this.commentCount,
    required this.shareCount,
    required this.onLike,
    required this.onComment,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _ActionChipButton(
          icon: isLiked ? Icons.favorite : Icons.favorite_border,
          label: '$likeCount',
          color: isLiked ? theme.colorScheme.error : null,
          onTap: onLike,
        ),
        SizedBox(width: 12.w),
        _ActionChipButton(
          icon: Icons.comment,
          label: '$commentCount',
          onTap: onComment,
        ),
        SizedBox(width: 12.w),
        _ActionChipButton(
          icon: Icons.share,
          label: '$shareCount',
          onTap: onShare,
        ),
      ],
    );
  }
}

class _ActionChipButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;
  final VoidCallback onTap;

  const _ActionChipButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest.withValues(
            alpha: 0.35,
          ),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18.sp, color: color ?? theme.iconTheme.color),
            SizedBox(width: 6.w),
            Text(
              label,
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CommentsSheet extends StatefulWidget {
  final String storyId;

  const _CommentsSheet({required this.storyId});

  @override
  State<_CommentsSheet> createState() => _CommentsSheetState();
}

class _CommentsSheetState extends State<_CommentsSheet> {
  final TextEditingController _controller = TextEditingController();
  bool _didPost = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (_) =>
          getIt<CommentBloc>()..add(CommentEvent.loadComments(widget.storyId)),
      child: BlocListener<CommentBloc, CommentState>(
        listener: (context, state) {
          state.maybeWhen(
            error: (message) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(message)));
            },
            orElse: () {},
          );
        },
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.85,
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Comments',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () => Navigator.pop(context, _didPost),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                Expanded(
                  child: BlocBuilder<CommentBloc, CommentState>(
                    builder: (context, state) {
                      return state.when(
                        initial: () => const SizedBox.shrink(),
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        loaded: (storyId, comments, collapsedStates, isAdding) {
                          if (comments.isEmpty) {
                            return const Center(child: Text('No comments yet'));
                          }

                          return ListView(
                            padding: EdgeInsets.all(16.w),
                            children: [
                              for (final c in comments)
                                _CommentTile(comment: c),
                            ],
                          );
                        },
                        error: (message) => Center(
                          child: Padding(
                            padding: EdgeInsets.all(16.w),
                            child: Text(message, textAlign: TextAlign.center),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 16.w,
                    right: 16.w,
                    top: 12.h,
                    bottom: 16.h + MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          decoration: const InputDecoration(
                            hintText: 'Add a comment…',
                          ),
                          minLines: 1,
                          maxLines: 3,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      BlocBuilder<CommentBloc, CommentState>(
                        builder: (context, state) {
                          final isAdding = state.maybeWhen(
                            loaded:
                                (
                                  storyId,
                                  comments,
                                  collapsedStates,
                                  isAddingComment,
                                ) => isAddingComment,
                            orElse: () => false,
                          );

                          return IconButton(
                            onPressed: isAdding
                                ? null
                                : () {
                                    final text = _controller.text.trim();
                                    if (text.isEmpty) return;

                                    context.read<CommentBloc>().add(
                                      CommentEvent.addComment(
                                        storyId: widget.storyId,
                                        text: text,
                                      ),
                                    );
                                    _controller.clear();
                                    setState(() {
                                      _didPost = true;
                                    });
                                  },
                            icon: const Icon(Icons.send),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CommentTile extends StatelessWidget {
  final Comment comment;

  const _CommentTile({required this.comment});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final depth = comment.depth;

    return Padding(
      padding: EdgeInsets.only(left: (depth * 16).w, bottom: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgAvatar(
                imageUrl: comment.userAvatar,
                radius: 16,
                fallbackText: comment.userName,
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comment.userName,
                      style: theme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(comment.text),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            context.read<CommentBloc>().add(
                              CommentEvent.toggleLike(
                                storyId: comment.storyId,
                                commentId: comment.id,
                              ),
                            );
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                comment.isLikedByCurrentUser
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                size: 16.sp,
                                color: comment.isLikedByCurrentUser
                                    ? theme.colorScheme.error
                                    : theme.iconTheme.color,
                              ),
                              SizedBox(width: 6.w),
                              Text('${comment.likeCount}'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          if (comment.replies.isNotEmpty) ...[
            SizedBox(height: 12.h),
            for (final r in comment.replies) _CommentTile(comment: r),
          ],
        ],
      ),
    );
  }
}
