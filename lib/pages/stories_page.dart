import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myitihas/core/di/injection_container.dart';
import 'package:myitihas/features/stories/presentation/bloc/stories_bloc.dart';
import 'package:myitihas/config/theme/gradient_extension.dart';
import 'package:myitihas/features/stories/presentation/pages/story_detail_page.dart';
import 'package:myitihas/features/stories/presentation/widgets/story_card.dart';
import 'package:myitihas/i18n/strings.g.dart';

class StoriesPage extends StatelessWidget {
  const StoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<StoriesBloc>()..add(const StoriesEvent.loadStories()),
      child: const _StoriesPageContent(),
    );
  }
}

class _StoriesPageContent extends StatefulWidget {
  const _StoriesPageContent();

  @override
  State<_StoriesPageContent> createState() => _StoriesPageContentState();
}

class _StoriesPageContentState extends State<_StoriesPageContent> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    double aspectRatio = MediaQuery.of(context).size.aspectRatio;

    return Column(
      children: [
        // Search and Sort Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 5,
              child: TextFormField(
                controller: _searchController,
                autofocus: false,
                onChanged: (query) {
                  context.read<StoriesBloc>().add(
                    StoriesEvent.searchStories(query),
                  );
                },
                decoration: InputDecoration(
                  hintText: t.stories.search_hint,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Theme.of(context).primaryColor,
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            context.read<StoriesBloc>().add(
                              const StoriesEvent.searchStories(''),
                            );
                          },
                        )
                      : null,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: aspectRatio > 0.5 ? 14 : 10,
                    horizontal: aspectRatio > 0.5 ? 20 : 16,
                  ),
                  filled: true,
                  fillColor: Theme.of(context).canvasColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: aspectRatio > 0.5 ? 16 : 10),
            Expanded(
              flex: 1,
              child: PopupMenuButton<String>(
                onSelected: (value) {
                  context.read<StoriesBloc>().add(
                    StoriesEvent.sortStories(value),
                  );
                },
                splashRadius: 0,
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: "newest",
                    child: Text(t.stories.sort_newest),
                  ),
                  PopupMenuItem(
                    value: "oldest",
                    child: Text(t.stories.sort_oldest),
                  ),
                  PopupMenuItem(
                    value: "popular",
                    child: Text(t.stories.sort_popular),
                  ),
                ],
                offset: const Offset(0, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Theme.of(context).cardColor,
                child: Container(
                  width: aspectRatio > 0.5 ? 50 : 45,
                  height: aspectRatio > 0.5 ? 50 : 45,
                  decoration: BoxDecoration(
                    gradient: Theme.of(
                      context,
                    ).extension<GradientExtension>()!.primaryButtonGradient,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.sort_rounded,
                    color: Colors.white,
                    size: aspectRatio > 0.5 ? 28 : 24,
                    weight: 700,
                  ),
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 16.h),

        // Stories List
        Expanded(
          child: BlocBuilder<StoriesBloc, StoriesState>(
            builder: (context, state) {
              return state.when(
                initial: () => Center(child: Text(t.stories.loading_stories)),
                loading: () => const Center(child: CircularProgressIndicator()),
                loaded:
                    (stories, searchQuery, sortBy, filterType, filterTheme) {
                      if (stories.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.book_outlined,
                                size: 64.sp,
                                color: Theme.of(context).disabledColor,
                              ),
                              SizedBox(height: 16.h),
                              Text(
                                t.stories.no_stories,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        );
                      }

                      return RefreshIndicator(
                        onRefresh: () async {
                          context.read<StoriesBloc>().add(
                            const StoriesEvent.refreshStories(),
                          );
                        },
                        child: ListView.builder(
                          itemCount: stories.length,
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          itemBuilder: (context, index) {
                            final story = stories[index];
                            return StoryCard(
                              story: story,
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => StoryDetailPage(
                                      story: story,
                                      onFavorite: () {
                                        context.read<StoriesBloc>().add(
                                          StoriesEvent.toggleFavorite(story.id),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                              onFavorite: () {
                                context.read<StoriesBloc>().add(
                                  StoriesEvent.toggleFavorite(story.id),
                                );
                              },
                            );
                          },
                        ),
                      );
                    },
                error: (message) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 64.sp,
                        color: Theme.of(context).colorScheme.error,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        t.stories.error_loading_stories,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        message,
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16.h),
                      ElevatedButton.icon(
                        onPressed: () {
                          context.read<StoriesBloc>().add(
                            const StoriesEvent.loadStories(),
                          );
                        },
                        icon: const Icon(Icons.refresh),
                        label: Text(t.common.retry),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
