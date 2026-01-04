import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myitihas/config/theme/gradient_extension.dart';
import 'package:myitihas/core/di/injection_container.dart';
import 'package:myitihas/features/social/domain/entities/content_type.dart';
import 'package:myitihas/features/social/domain/entities/feed_item.dart';
import 'package:myitihas/features/social/domain/entities/image_post.dart';
import 'package:myitihas/features/social/domain/entities/text_post.dart';
import 'package:myitihas/features/social/domain/entities/video_post.dart';
import 'package:myitihas/features/social/presentation/bloc/feed_bloc.dart';
import 'package:myitihas/features/social/presentation/bloc/feed_event.dart';
import 'package:myitihas/features/social/presentation/bloc/feed_state.dart';
import 'package:myitihas/features/social/presentation/utils/share_preview_generator.dart';
import 'package:myitihas/features/social/presentation/widgets/comment_sheet.dart';
import 'package:myitihas/features/social/presentation/widgets/feed_item_card.dart';
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

class _SocialFeedViewState extends State<_SocialFeedView>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  late TabController _tabController;
  int _currentPage = 0;

  static const _feedTypes = [
    FeedType.all,
    FeedType.stories,
    FeedType.posts,
    FeedType.videos,
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _feedTypes.length, vsync: this);
    _tabController.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) return;

    final newFeedType = _feedTypes[_tabController.index];
    context.read<FeedBloc>().add(FeedEvent.changeFeedType(newFeedType));

    // Reset page controller when switching tabs
    if (_pageController.hasClients) {
      _pageController.jumpToPage(0);
    }
    setState(() => _currentPage = 0);
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);

    return Container(
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
      child: Stack(
        children: [
          // Main content
          BlocConsumer<FeedBloc, FeedState>(
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
                refreshing: (feedItems, currentUser, hasMore, feedType) =>
                    _buildFeed(
                      context,
                      feedItems: feedItems,
                      hasMore: hasMore,
                      feedType: feedType,
                    ),
                loaded:
                    (
                      feedItems,
                      currentUser,
                      hasMore,
                      feedType,
                      isLoadingMore,
                    ) => _buildFeed(
                      context,
                      feedItems: feedItems,
                      hasMore: hasMore,
                      feedType: feedType,
                      isLoadingMore: isLoadingMore,
                    ),
                error: (message) =>
                    _buildErrorState(context, message, colorScheme),
              );
            },
          ),

          // Top tab bar overlay
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.8),
                    Colors.black.withValues(alpha: 0.4),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.7, 1.0],
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 8),
                    TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      tabAlignment: TabAlignment.center,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorColor: Colors.white,
                      indicatorWeight: 2,
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.white60,
                      labelStyle: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      unselectedLabelStyle: theme.textTheme.titleSmall,
                      dividerColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      tabs: [
                        Tab(text: t.feed.tabs.all),
                        Tab(text: t.feed.tabs.stories),
                        Tab(text: t.feed.tabs.posts),
                        Tab(text: t.feed.tabs.videos),
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState(ColorScheme colorScheme) {
    final width = MediaQuery.of(context).size.width;
    return Center(
      child: Container(
        width: width,
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
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: colorScheme.primary),
            const SizedBox(height: 16),
            Text(
              Translations.of(context).feed.loading,
              style: const TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(
    BuildContext context,
    String message,
    ColorScheme colorScheme,
  ) {
    final t = Translations.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: colorScheme.error),
            const SizedBox(height: 16),
            Text(
              t.feed.errorTitle,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: const TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                context.read<FeedBloc>().add(const FeedEvent.loadFeed());
              },
              icon: const Icon(Icons.refresh),
              label: Text(t.feed.tryAgain),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeed(
    BuildContext context, {
    required List<FeedItem> feedItems,
    required bool hasMore,
    required FeedType feedType,
    bool isLoadingMore = false,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    if (feedItems.isEmpty) {
      return _buildEmptyState(context, feedType);
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
        itemCount: feedItems.length + (isLoadingMore ? 1 : 0),
        onPageChanged: (index) {
          HapticFeedback.selectionClick();
          setState(() => _currentPage = index);

          if (index >= feedItems.length - 2 && hasMore && !isLoadingMore) {
            context.read<FeedBloc>().add(const FeedEvent.loadMore());
          }
        },
        itemBuilder: (context, index) {
          if (index >= feedItems.length) {
            return _buildLoadingState(colorScheme);
          }

          final feedItem = feedItems[index];
          final isVisible = index == _currentPage;
          
          return FeedItemCard(
            feedItem: feedItem,
            isVisible: isVisible,
            onLike: (contentId, contentType) {
              context.read<FeedBloc>().add(
                FeedEvent.toggleLike(
                  contentId: contentId,
                  contentType: contentType,
                ),
              );
            },
            onComment: (contentId, contentType) {
              feedItem.when(
                story: (story) => _showCommentSheet(
                  context,
                  story.id,
                  story.commentCount,
                  ContentType.story,
                ),
                imagePost: (post) => _showCommentSheet(
                  context,
                  post.id,
                  post.commentCount,
                  ContentType.imagePost,
                ),
                textPost: (post) => _showCommentSheet(
                  context,
                  post.id,
                  post.commentCount,
                  ContentType.textPost,
                ),
                videoPost: (post) => _showCommentSheet(
                  context,
                  post.id,
                  post.commentCount,
                  ContentType.videoPost,
                ),
              );
            },
            onShare: (contentId, contentType) {
              feedItem.whenOrNull(
                story: (story) => _showEnhancedShareDialog(context, story),
                imagePost: (post) => _showImagePostShareDialog(context, post),
                textPost: (post) => _showTextPostShareDialog(context, post),
                videoPost: (post) => _showVideoPostShareDialog(context, post),
              );
            },
            onBookmark: (contentId, contentType) {
              context.read<FeedBloc>().add(
                FeedEvent.toggleBookmark(
                  contentId: contentId,
                  contentType: contentType,
                ),
              );
              _announceBookmark(context, feedItem);
            },
            onProfileTap: () {
              final authorUser = feedItem.authorUser;
              if (authorUser != null) {
                context.push('/profile/${authorUser.id}');
              }
            },
            onFollowTap: () {
              // TODO: Implement follow/unfollow
            },
            onContinueReading: () {
              feedItem.whenOrNull(
                story: (story) => context.push('/home/stories/${story.id}'),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, FeedType feedType) {
    final t = Translations.of(context);

    IconData icon;
    String message;

    switch (feedType) {
      case FeedType.all:
        icon = Icons.feed_outlined;
        message = t.feed.noContentAvailable;
        break;
      case FeedType.stories:
        icon = Icons.auto_stories_outlined;
        message = t.feed.noStoriesAvailable;
        break;
      case FeedType.posts:
        icon = Icons.photo_library_outlined;
        message = t.feed.noImagesAvailable;
        break;
      case FeedType.videos:
        icon = Icons.videocam_outlined;
        message = t.feed.noVideosAvailable;
        break;
    }

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 64, color: Colors.white54),
          const SizedBox(height: 16),
          Text(message, style: const TextStyle(color: Colors.white70)),
          const SizedBox(height: 16),
          TextButton.icon(
            onPressed: () {
              context.read<FeedBloc>().add(const FeedEvent.refreshFeed());
            },
            icon: const Icon(Icons.refresh, color: Colors.white),
            label: Text(
              t.feed.refresh,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _announceBookmark(BuildContext context, FeedItem feedItem) {
    final t = Translations.of(context);
    final message = feedItem.isFavorite
        ? t.feed.removedFromBookmarks
        : t.feed.bookmarked;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showImagePostShareDialog(BuildContext context, ImagePost post) {
    final t = Translations.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final gradients = theme.extension<GradientExtension>();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      enableDrag: true,
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
                t.feed.sharePost,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              if (post.caption != null)
                Text(
                  post.caption!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              const SizedBox(height: 24),

              // Share with image
              _ShareOption(
                icon: Icons.image_outlined,
                title: t.feed.shareWithImage,
                subtitle: t.feed.shareWithImageSubtitle,
                gradients: gradients,
                colorScheme: colorScheme,
                onTap: () async {
                  Navigator.pop(sheetContext);
                  await SharePreviewGenerator.shareImagePostImage(post: post);
                  if (context.mounted) {
                    context.read<FeedBloc>().add(
                      FeedEvent.shareContent(
                        contentId: post.id,
                        contentType: ContentType.imagePost,
                        isDirect: false,
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 12),

              // Share link
              _ShareOption(
                icon: Icons.link,
                title: t.feed.shareLink,
                subtitle: t.feed.shareImageLinkSubtitle,
                gradients: gradients,
                colorScheme: colorScheme,
                onTap: () async {
                  Navigator.pop(sheetContext);
                  await SharePreviewGenerator.shareImagePostLink(
                    post: post,
                    baseUrl: 'https://myitihas.com',
                  );
                  if (context.mounted) {
                    context.read<FeedBloc>().add(
                      FeedEvent.shareContent(
                        contentId: post.id,
                        contentType: ContentType.imagePost,
                        isDirect: false,
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 12),

              // Copy link
              _ShareOption(
                icon: Icons.copy,
                title: t.feed.copyLink,
                subtitle: t.feed.copyLinkSubtitle,
                gradients: gradients,
                colorScheme: colorScheme,
                onTap: () async {
                  Navigator.pop(sheetContext);
                  await SharePreviewGenerator.copyImagePostLink(
                    post: post,
                    baseUrl: 'https://myitihas.com',
                  );
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(t.feed.linkCopied),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 12),

              // Send to user
              _ShareOption(
                icon: Icons.send,
                title: t.feed.sendToUser,
                subtitle: t.feed.sendToUserSubtitle,
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

  void _showTextPostShareDialog(BuildContext context, TextPost post) {
    final t = Translations.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final gradients = theme.extension<GradientExtension>();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      enableDrag: true,
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
                t.feed.shareThought,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '"${post.body.length > 50 ? '${post.body.substring(0, 50)}...' : post.body}"',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontStyle: FontStyle.italic,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 24),

              // Share as quote
              _ShareOption(
                icon: Icons.format_quote,
                title: t.feed.shareQuote,
                subtitle: t.feed.shareQuoteSubtitle,
                gradients: gradients,
                colorScheme: colorScheme,
                onTap: () async {
                  Navigator.pop(sheetContext);
                  await SharePreviewGenerator.shareTextPost(post: post);
                  if (context.mounted) {
                    context.read<FeedBloc>().add(
                      FeedEvent.shareContent(
                        contentId: post.id,
                        contentType: ContentType.textPost,
                        isDirect: false,
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 12),

              // Share link
              _ShareOption(
                icon: Icons.link,
                title: t.feed.shareLink,
                subtitle: t.feed.shareTextLinkSubtitle,
                gradients: gradients,
                colorScheme: colorScheme,
                onTap: () async {
                  Navigator.pop(sheetContext);
                  await SharePreviewGenerator.shareTextPostLink(
                    post: post,
                    baseUrl: 'https://myitihas.com',
                  );
                  if (context.mounted) {
                    context.read<FeedBloc>().add(
                      FeedEvent.shareContent(
                        contentId: post.id,
                        contentType: ContentType.textPost,
                        isDirect: false,
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 12),

              // Copy text
              _ShareOption(
                icon: Icons.copy,
                title: t.feed.copyText,
                subtitle: t.feed.copyTextSubtitle,
                gradients: gradients,
                colorScheme: colorScheme,
                onTap: () async {
                  Navigator.pop(sheetContext);
                  await SharePreviewGenerator.copyTextPostContent(post: post);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(t.feed.textCopied),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 12),

              // Copy link
              _ShareOption(
                icon: Icons.link,
                title: t.feed.copyLink,
                subtitle: t.feed.copyLinkSubtitle,
                gradients: gradients,
                colorScheme: colorScheme,
                onTap: () async {
                  Navigator.pop(sheetContext);
                  await SharePreviewGenerator.copyTextPostLink(
                    post: post,
                    baseUrl: 'https://myitihas.com',
                  );
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(t.feed.linkCopied),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 12),

              // Send to user
              _ShareOption(
                icon: Icons.send,
                title: t.feed.sendToUser,
                subtitle: t.feed.sendToUserSubtitle,
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

  void _showVideoPostShareDialog(BuildContext context, VideoPost post) {
    final t = Translations.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final gradients = theme.extension<GradientExtension>();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      enableDrag: true,
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
                t.feed.sharePost,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              if (post.caption != null && post.caption!.isNotEmpty)
                Text(
                  '"${post.caption!.length > 50 ? '${post.caption!.substring(0, 50)}...' : post.caption!}"',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontStyle: FontStyle.italic,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              const SizedBox(height: 24),

              // Share link
              _ShareOption(
                icon: Icons.link,
                title: t.feed.shareLink,
                subtitle: t.feed.shareLinkSubtitle,
                gradients: gradients,
                colorScheme: colorScheme,
                onTap: () async {
                  Navigator.pop(sheetContext);
                  final link = 'https://myitihas.com/videos/${post.id}';
                  await Clipboard.setData(ClipboardData(text: link));
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(t.feed.linkCopied),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    context.read<FeedBloc>().add(
                      FeedEvent.shareContent(
                        contentId: post.id,
                        contentType: ContentType.videoPost,
                        isDirect: false,
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 12),

              // Copy link
              _ShareOption(
                icon: Icons.copy,
                title: t.feed.copyLink,
                subtitle: t.feed.copyLinkSubtitle,
                gradients: gradients,
                colorScheme: colorScheme,
                onTap: () async {
                  Navigator.pop(sheetContext);
                  final link = 'https://myitihas.com/videos/${post.id}';
                  await Clipboard.setData(ClipboardData(text: link));
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(t.feed.linkCopied),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 12),

              // Send to user (video)
              _ShareOption(
                icon: Icons.send,
                title: t.feed.sendToUser,
                subtitle: t.feed.sendToUserSubtitle,
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

  void _showCommentSheet(
    BuildContext context,
    String contentId,
    int commentCount,
    ContentType contentType,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => CommentSheet(
        contentId: contentId,
        contentType: contentType,
        initialCommentCount: commentCount,
      ),
    );
  }

  void _showEnhancedShareDialog(BuildContext context, Story story) {
    final t = Translations.of(context);
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
                t.feed.shareStory,
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
                title: t.feed.shareAsImage,
                subtitle: t.feed.shareAsImageSubtitle,
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
                title: t.feed.shareLink,
                subtitle: t.feed.shareLinkSubtitle,
                gradients: gradients,
                colorScheme: colorScheme,
                onTap: () {
                  Navigator.pop(sheetContext);
                  SharePreviewGenerator.shareLink(
                    story: story,
                    baseUrl: 'https://myitihas.com',
                  );
                  context.read<FeedBloc>().add(
                    FeedEvent.shareContent(
                      contentId: story.id,
                      contentType: ContentType.story,
                      isDirect: false,
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              _ShareOption(
                icon: Icons.text_fields,
                title: t.feed.shareAsText,
                subtitle: t.feed.shareAsTextSubtitle,
                gradients: gradients,
                colorScheme: colorScheme,
                onTap: () {
                  Navigator.pop(sheetContext);
                  SharePreviewGenerator.shareAsText(story: story);
                  context.read<FeedBloc>().add(
                    FeedEvent.shareContent(
                      contentId: story.id,
                      contentType: ContentType.story,
                      isDirect: false,
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              _ShareOption(
                icon: Icons.send,
                title: t.feed.sendToUser,
                subtitle: t.feed.sendToUserSubtitle,
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
    final t = Translations.of(context);
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(t.feed.chooseFormat),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.web),
              title: Text(t.feed.linkPreview),
              subtitle: Text(t.feed.linkPreviewSize),
              onTap: () async {
                Navigator.pop(dialogContext);
                _generateAndShare(context, story, SharePreviewFormat.openGraph);
              },
            ),
            ListTile(
              leading: const Icon(Icons.smartphone),
              title: Text(t.feed.storyFormat),
              subtitle: Text(t.feed.storyFormatSize),
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
    final t = Translations.of(context);
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
                Text(t.feed.generatingPreview),
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
        FeedEvent.shareContent(
          contentId: story.id,
          contentType: ContentType.story,
          isDirect: false,
        ),
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
