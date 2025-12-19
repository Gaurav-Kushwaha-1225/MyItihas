import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart' show Either;
import 'package:myitihas/core/di/injection_container.dart';
import 'package:myitihas/core/errors/failures.dart';
import 'package:myitihas/features/stories/domain/entities/story.dart';
import 'package:myitihas/features/stories/domain/usecases/get_story_by_id.dart';
import 'package:myitihas/features/stories/presentation/pages/story_detail_page.dart';
import 'package:myitihas/i18n/strings.g.dart';

class StoryDetailRoutePage extends StatefulWidget {
  final String id;

  const StoryDetailRoutePage({super.key, required this.id});

  @override
  State<StoryDetailRoutePage> createState() => _StoryDetailRoutePageState();
}

class _StoryDetailRoutePageState extends State<StoryDetailRoutePage> {
  late Future<Either<Failure, Story>> _future;

  @override
  void initState() {
    super.initState();
    _future = getIt<GetStoryById>()(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return FutureBuilder<Either<Failure, Story>>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final result = snapshot.data;
        if (result == null) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(t.stories.failed_to_load),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _future = getIt<GetStoryById>()(widget.id);
                      });
                    },
                    child: Text(t.common.retry),
                  ),
                ],
              ),
            ),
          );
        }

        return result.fold(
          (failure) => Scaffold(
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(failure.message, textAlign: TextAlign.center),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _future = getIt<GetStoryById>()(widget.id);
                      });
                    },
                    child: Text(t.common.retry),
                  ),
                ],
              ),
            ),
          ),
          (story) => StoryDetailPage(story: story),
        );
      },
    );
  }
}
