import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myitihas/config/theme/gradient_extension.dart';
import 'package:myitihas/core/di/injection_container.dart';
import 'package:myitihas/features/social/presentation/bloc/feed_bloc.dart';
import 'package:myitihas/features/social/presentation/bloc/feed_event.dart';
import 'package:myitihas/features/social/presentation/bloc/feed_state.dart';
import 'package:myitihas/features/social/presentation/utils/share_preview_generator.dart';
import 'package:myitihas/features/social/presentation/widgets/enhanced_story_card.dart';
import 'package:myitihas/features/social/presentation/widgets/share_preview_card.dart';
import 'package:myitihas/features/stories/domain/entities/story.dart';
import 'package:myitihas/i18n/strings.g.dart';

class SocialFeedPage extends StatelessWidget {
  const SocialFeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<FeedBloc>()..add(const FeedEvent.loadFeed()),
      child: const _SocialFeedView(),
    );
  }
}

class _SocialFeedView extends StatefulWidget {
  const _SocialFeedView();

  @override
  State<_SocialFeedView> createState() => _SocialFeedViewState();
}

class _SocialFeedViewState extends State<_SocialFeedView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: BlocConsumer<FeedBloc, FeedState>(
        listener: (context, state) {
          state.maybeWhen(
            error: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          return state.when(
            initial: () => _buildLoadingState(colorScheme),
            loading: () => _buildLoadingState(colorScheme),
            refreshing: (stories, currentUser, hasMore) =>
                _buildFeed(context, stories: stories, hasMore: hasMore),
            loaded: (stories, currentUser, hasMore, isLoadingMore) =>
                _buildFeed(
                  context,
                  stories: stories,
                  hasMore: hasMore,
                  isLoadingMore: isLoadingMore,
                ),
            error: (message) => _buildErrorState(context, message, colorScheme),
          );
        },
      ),
    );
  }

  Widget _buildLoadingState(ColorScheme colorScheme) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(color: colorScheme.primary),
          const SizedBox(height: 16),
          Text(
            t.feed.loading,
            style: TextStyle(color: colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(
    BuildContext context,
    String message,
    ColorScheme colorScheme,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: colorScheme.error),
            const SizedBox(height: 16),
            Text(
              t.feed.error_title,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(color: colorScheme.onSurface),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: TextStyle(color: colorScheme.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                context.read<FeedBloc>().add(const FeedEvent.loadFeed());
              },
              icon: const Icon(Icons.refresh),
              label: Text(t.feed.try_again),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeed(
    BuildContext context, {
    required List<Story> stories,
    required bool hasMore,
    bool isLoadingMore = false,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    if (stories.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.auto_stories_outlined,
              size: 64,
              color: colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              t.feed.no_stories_available,
              style: TextStyle(color: colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: 16),
            TextButton.icon(
              onPressed: () {
                context.read<FeedBloc>().add(const FeedEvent.refreshFeed());
              },
              icon: const Icon(Icons.refresh),
              label: Text(t.feed.refresh),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<FeedBloc>().add(const FeedEvent.refreshFeed());
        await Future.delayed(const Duration(milliseconds: 500));
      },
      child: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        itemCount: stories.length + (isLoadingMore ? 1 : 0),
        onPageChanged: (index) {
          HapticFeedback.selectionClick();
          setState(() => _currentPage = index);

          if (index >= stories.length - 2 && hasMore && !isLoadingMore) {
            context.read<FeedBloc>().add(const FeedEvent.loadMore());
          }
        },
        itemBuilder: (context, index) {
          if (index >= stories.length) {
            return _buildLoadingState(colorScheme);
          }

          final story = stories[index];
          final isVisible = index == _currentPage;

          return EnhancedStoryCard(
            story: story,
            isVisible: isVisible,
            onLike: () {
              context.read<FeedBloc>().add(FeedEvent.toggleLike(story.id));
            },
            onComment: () => _showCommentSheet(context, story),
            onShare: () => _showEnhancedShareDialog(context, story),
            onBookmark: () {
              context.read<FeedBloc>().add(FeedEvent.toggleBookmark(story.id));
              _announceBookmark(context, story);
            },
            onProfileTap: () {
              if (story.authorUser != null) {
                context.push('/profile/${story.authorUser!.id}');
              }
            },
            onFollowTap: () {
              // TODO: Implement follow/unfollow
            },
            onContinueReading: () {
              context.push('/home/stories/${story.id}');
            },
          );
        },
      ),
    );
  }

  void _announceBookmark(BuildContext context, Story story) {
    final message = story.isFavorite
        ? t.feed.removed_from_bookmarks
        : t.feed.bookmarked;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showCommentSheet(BuildContext context, Story story) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Text(
                    t.feed.comments,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${story.commentCount}',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(sheetContext),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.chat_bubble_outline,
                      size: 48,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      t.feed.comments_coming_soon,
                      style: TextStyle(color: colorScheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
            ),
            // Comment input
            Container(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 12,
                bottom: MediaQuery.of(context).viewInsets.bottom + 16,
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
                      decoration: InputDecoration(
                        hintText: t.feed.add_comment_hint,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: colorScheme.surface,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton.filled(
                    onPressed: () {
                      // TODO: Submit comment
                    },
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEnhancedShareDialog(BuildContext context, Story story) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final gradients = theme.extension<GradientExtension>();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      enableDrag: true,
      scrollControlDisabledMaxHeightRatio: 0.9,
      builder: (sheetContext) => Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Text(
                t.feed.share_story,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                story.title,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 24),

              _ShareOption(
                icon: Icons.image_outlined,
                title: t.feed.share_as_image,
                subtitle: t.feed.share_as_image_subtitle,
                gradients: gradients,
                colorScheme: colorScheme,
                onTap: () async {
                  Navigator.pop(sheetContext);
                  _showShareFormatPicker(context, story);
                },
              ),
              const SizedBox(height: 12),
              _ShareOption(
                icon: Icons.link,
                title: t.feed.share_link,
                subtitle: t.feed.share_link_subtitle,
                gradients: gradients,
                colorScheme: colorScheme,
                onTap: () {
                  Navigator.pop(sheetContext);
                  SharePreviewGenerator.shareLink(
                    story: story,
                    baseUrl: 'https://myitihas.com',
                  );
                  context.read<FeedBloc>().add(
                    FeedEvent.shareStory(storyId: story.id, isDirect: false),
                  );
                },
              ),
              const SizedBox(height: 12),
              _ShareOption(
                icon: Icons.text_fields,
                title: t.feed.share_as_text,
                subtitle: t.feed.share_as_text_subtitle,
                gradients: gradients,
                colorScheme: colorScheme,
                onTap: () {
                  Navigator.pop(sheetContext);
                  SharePreviewGenerator.shareAsText(story: story);
                  context.read<FeedBloc>().add(
                    FeedEvent.shareStory(storyId: story.id, isDirect: false),
                  );
                },
              ),
              const SizedBox(height: 12),
              _ShareOption(
                icon: Icons.send,
                title: t.feed.send_to_user,
                subtitle: t.feed.send_to_user_subtitle,
                gradients: gradients,
                colorScheme: colorScheme,
                onTap: () {
                  Navigator.pop(sheetContext);
                  // TODO: Show user selector
                },
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom),
            ],
          ),
        ),
      ),
    );
  }

  void _showShareFormatPicker(BuildContext context, Story story) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(t.feed.choose_format),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.web),
              title: Text(t.feed.link_preview),
              subtitle: Text(t.feed.link_preview_size),
              onTap: () async {
                Navigator.pop(dialogContext);
                _generateAndShare(context, story, SharePreviewFormat.openGraph);
              },
            ),
            ListTile(
              leading: const Icon(Icons.smartphone),
              title: Text(t.feed.story_format),
              subtitle: Text(t.feed.story_format_size),
              onTap: () async {
                Navigator.pop(dialogContext);
                _generateAndShare(context, story, SharePreviewFormat.story);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _generateAndShare(
    BuildContext context,
    Story story,
    SharePreviewFormat format,
  ) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 16),
                Text(t.feed.generating_preview),
              ],
            ),
          ),
        ),
      ),
    );

    try {
      await SharePreviewGenerator.shareWithPreview(
        context: context,
        story: story,
        format: format,
      );
    } finally {
      if (context.mounted) {
        Navigator.pop(context);
      }
    }

    if (context.mounted) {
      context.read<FeedBloc>().add(
        FeedEvent.shareStory(storyId: story.id, isDirect: false),
      );
    }
  }
}

class _ShareOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final GradientExtension? gradients;
  final ColorScheme colorScheme;
  final VoidCallback onTap;

  const _ShareOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.gradients,
    required this.colorScheme,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: gradients?.glassBorder ?? colorScheme.outlineVariant,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: gradients?.primaryButtonGradient,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: colorScheme.onPrimary, size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: colorScheme.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}
