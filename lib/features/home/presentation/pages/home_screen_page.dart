import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:myitihas/config/theme/gradient_extension.dart';
import 'package:myitihas/core/di/injection_container.dart';
import 'package:myitihas/features/home/presentation/bloc/home_bloc.dart';
import 'package:myitihas/features/home/presentation/bloc/home_event.dart';
import 'package:myitihas/features/home/presentation/bloc/home_state.dart';
import 'package:myitihas/features/home/presentation/widgets/continue_reading_section.dart';
import 'package:myitihas/features/home/presentation/widgets/create_post_card.dart';
import 'package:myitihas/features/home/presentation/widgets/featured_stories_section.dart';
import 'package:myitihas/features/home/presentation/widgets/hero_generate_button.dart';
import 'package:myitihas/features/home/presentation/widgets/my_generated_stories_section.dart';
import 'package:myitihas/features/home/presentation/widgets/saved_stories_section.dart';
import 'package:myitihas/features/home/presentation/widgets/secondary_actions_row.dart';
import 'package:myitihas/features/stories/domain/entities/story.dart';
import 'package:myitihas/i18n/strings.g.dart';
import 'package:myitihas/services/post_service.dart';

/// Main HomeScreen page - the primary landing experience
class HomeScreenPage extends StatelessWidget {
  const HomeScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeBloc>()..add(const HomeEvent.loadHome()),
      child: const _HomeScreenView(),
    );
  }
}

class _HomeScreenView extends StatefulWidget {
  const _HomeScreenView();

  @override
  State<_HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<_HomeScreenView>
    with SingleTickerProviderStateMixin {
  late AnimationController _greetingController;
  late Animation<double> _greetingFade;
  late Animation<Offset> _greetingSlide;

  @override
  void initState() {
    super.initState();
    _greetingController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _greetingFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _greetingController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _greetingSlide =
        Tween<Offset>(begin: const Offset(-0.1, 0), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _greetingController,
            curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
          ),
        );

    _greetingController.forward();
  }

  @override
  void dispose() {
    _greetingController.dispose();
    super.dispose();
  }

  void _showShareToFeedDialog(BuildContext context, Story story) {
    final t = Translations.of(context);
    final captionController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (bottomSheetContext) {
        final theme = Theme.of(bottomSheetContext);
        final colorScheme = theme.colorScheme;

        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(bottomSheetContext).viewInsets.bottom,
          ),
          child: Container(
            padding: EdgeInsets.all(16.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      t.homeScreen.shareStoryTitle,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(bottomSheetContext),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),

                SizedBox(height: 16.h),

                // Story preview
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: colorScheme.outlineVariant.withValues(alpha: 0.5),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 60.w,
                        height: 60.h,
                        decoration: BoxDecoration(
                          color: colorScheme.tertiary.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: story.imageUrl != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8.r),
                                child: Image.network(
                                  story.imageUrl!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Icon(
                                    Icons.auto_stories,
                                    color: colorScheme.tertiary,
                                  ),
                                ),
                              )
                            : Icon(
                                Icons.auto_stories,
                                color: colorScheme.tertiary,
                              ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              story.title,
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              story.scripture,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16.h),

                // Caption input
                Text(
                  t.homeScreen.shareStoryMessage,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: 8.h),
                TextField(
                  controller: captionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: t.homeScreen.shareStoryHint,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),

                SizedBox(height: 24.h),

                // Share button
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () async {
                      Navigator.pop(bottomSheetContext);
                      await _shareStoryToFeed(
                        context,
                        story,
                        captionController.text,
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.h),
                      child: Text(t.homeScreen.shareToFeed),
                    ),
                  ),
                ),

                SizedBox(height: 8.h),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _shareStoryToFeed(
    BuildContext context,
    Story story,
    String caption,
  ) async {
    final t = Translations.of(context);
    final postService = getIt<PostService>();

    try {
      await postService.createPost(
        postType: PostType.storyShare,
        content: caption.isNotEmpty ? caption : story.lesson,
        title: story.title,
        sharedStoryId: story.id,
        metadata: {
          'story_title': story.title,
          'story_scripture': story.scripture,
          'story_image_url': story.imageUrl,
          'story_lesson': story.lesson,
        },
      );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(t.homeScreen.sharedToFeed),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to share: ${e.toString()}'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  String _getGreeting(BuildContext context, String greetingKey) {
    final t = Translations.of(context);
    switch (greetingKey) {
      case 'morning':
        return t.home.greetingMorning;
      case 'afternoon':
        return t.home.greetingAfternoon;
      case 'evening':
        return t.home.greetingEvening;
      default:
        return t.home.greetingMorning;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final gradients = theme.extension<GradientExtension>();
    final t = Translations.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async {
            context.read<HomeBloc>().add(const HomeEvent.refresh());
            // Wait a bit for the refresh to complete
            await Future.delayed(const Duration(milliseconds: 500));
          },
          color: colorScheme.primary,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: ClampingScrollPhysics(),
            ),
            slivers: [
              // App bar with greeting
              SliverAppBar(
                expandedHeight: 80.h,
                floating: true,
                pinned: false,
                backgroundColor: Colors.transparent,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: isDark
                            ? [
                                colorScheme.surface,
                                colorScheme.surface.withValues(alpha: 0),
                              ]
                            : [
                                colorScheme.surface,
                                colorScheme.surface.withValues(alpha: 0),
                              ],
                      ),
                    ),
                    child: SafeArea(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FadeTransition(
                              opacity: _greetingFade,
                              child: SlideTransition(
                                position: _greetingSlide,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Greeting row
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _getGreeting(
                                                context,
                                                state.greetingKey,
                                              ),
                                              style: theme.textTheme.titleMedium
                                                  ?.copyWith(
                                                    color: colorScheme
                                                        .onSurfaceVariant,
                                                  ),
                                            ),
                                            SizedBox(height: 4.h),
                                            ShaderMask(
                                              shaderCallback: (bounds) =>
                                                  (gradients?.brandTextGradient ??
                                                          LinearGradient(
                                                            colors: [
                                                              colorScheme
                                                                  .primary,
                                                              colorScheme
                                                                  .secondary,
                                                            ],
                                                          ))
                                                      .createShader(bounds),
                                              child: Text(
                                                t.app.name,
                                                style: theme
                                                    .textTheme
                                                    .headlineMedium
                                                    ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        // Notification & profile buttons
                                        Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                context.push('/notifications');
                                              },
                                              icon: Icon(
                                                Icons.notifications_outlined,
                                                color: colorScheme
                                                    .onSurfaceVariant,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 8.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Featured Stories
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: 20.h),
                  child: FeaturedStoriesSection(
                    stories: state.featuredStories,
                    isLoading: state.isFeaturedLoading,
                    onStoryTap: (story) {
                      context.push('/home/stories/${story.id}');
                    },
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: 16.h),
                  child: const CreatePostCard(),
                ),
              ),

              // Quote of the Day
              // SliverToBoxAdapter(
              //   child: Padding(
              //     padding: EdgeInsets.only(top: 4.h),
              //     child: QuoteCard(
              //       quote: state.quote,
              //       isLoading: state.isQuoteLoading,
              //       onShare: () {
              //         context.read<HomeBloc>().add(
              //           const HomeEvent.shareQuote(),
              //         );
              //       },
              //       onCopy: () {
              //         context.read<HomeBloc>().add(const HomeEvent.copyQuote());
              //         ScaffoldMessenger.of(context).showSnackBar(
              //           SnackBar(
              //             content: Text(t.homeScreen.quoteCopied),
              //             behavior: SnackBarBehavior.floating,
              //             duration: const Duration(seconds: 2),
              //           ),
              //         );
              //       },
              //     ),
              //   ),
              // ),

              // HERO: Generate Story Button
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: 16.h),
                  child: HeroGenerateButton(
                    onTap: () {
                      context.push('/story-generator');
                    },
                  ),
                ),
              ),

              // Secondary Actions (Chat & Activity)
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: 12.h),
                  child: SecondaryActionsRow(
                    onChatWithKrishna: () {
                      context.push('/chatbot');
                    },
                    onMyActivity: () {
                      context.push('/activity');
                    },
                  ),
                ),
              ),

              // Continue Reading
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: 20.h),
                  child: ContinueReadingSection(
                    stories: state.continueReading,
                    isLoading: state.isContinueReadingLoading,
                    onStoryTap: (progress) {
                      context.push('/home/stories/${progress.storyId}');
                    },
                    onSeeAll: () {
                      // Navigate to full continue reading list
                      context.push('/activity');
                    },
                    onExplore: () {
                      // Navigate to stories or social feed
                      context.go('/home');
                    },
                  ),
                ),
              ),

              // My Generated Stories
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: 20.h),
                  child: MyGeneratedStoriesSection(
                    stories: state.myGeneratedStories,
                    isLoading: state.isMyGeneratedStoriesLoading,
                    onStoryTap: (story) {
                      context.push('/story-generator/${story.id}');
                    },
                    onShareToFeed: (story) {
                      _showShareToFeedDialog(context, story);
                    },
                    onSeeAll: () {
                      context.push('/story-generator');
                    },
                    onCreateNew: () {
                      context.push('/story-generator');
                    },
                  ),
                ),
              ),

              // Saved Stories
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: 20.h),
                  child: SavedStoriesSection(
                    stories: state.savedStories,
                    isLoading: state.isSavedStoriesLoading,
                    onStoryTap: (story) {
                      context.push('/home/stories/${story.id}');
                    },
                    onSeeAll: () {
                      // Navigate to saved stories list
                      context.push('/saved-stories');
                    },
                  ),
                ),
              ),

              // Bottom padding
              SliverToBoxAdapter(child: SizedBox(height: 80.h)),
            ],
          ),
        );
      },
    );
  }
}
