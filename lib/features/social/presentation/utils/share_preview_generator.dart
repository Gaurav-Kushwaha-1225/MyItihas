import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:myitihas/features/stories/domain/entities/story.dart';
import 'package:myitihas/features/social/domain/entities/image_post.dart';
import 'package:myitihas/features/social/domain/entities/text_post.dart';
import 'package:myitihas/features/social/presentation/widgets/share_preview_card.dart';

/// Utility class for generating shareable preview images from stories
class SharePreviewGenerator {
  static Future<String?> generatePreviewImage({
    required BuildContext context,
    required Story story,
    SharePreviewFormat format = SharePreviewFormat.openGraph,
  }) async {
    try {
      final repaintKey = GlobalKey();

      final widget = MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Theme.of(context),
        home: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: SharePreviewCard(
              story: story,
              format: format,
              repaintKey: repaintKey,
            ),
          ),
        ),
      );

      final repaintBoundary = RenderRepaintBoundary();
      final view = View.of(context);
      final renderView = RenderView(
        view: view,
        child: RenderPositionedBox(
          alignment: Alignment.center,
          child: repaintBoundary,
        ),
        configuration: ViewConfiguration(
          logicalConstraints: BoxConstraints.tight(format.size),
          devicePixelRatio: 3.0,
        ),
      );

      final pipelineOwner = PipelineOwner();
      pipelineOwner.rootNode = renderView;
      renderView.prepareInitialFrame();

      final buildOwner = BuildOwner(focusManager: FocusManager());
      final rootElement = RenderObjectToWidgetAdapter<RenderBox>(
        container: repaintBoundary,
        child: widget,
      ).attachToRenderTree(buildOwner);

      buildOwner.buildScope(rootElement);
      pipelineOwner.flushLayout();
      pipelineOwner.flushCompositingBits();
      pipelineOwner.flushPaint();

      final image = await repaintBoundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData == null) return null;

      final bytes = byteData.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final fileName =
          'myitihas_story_${story.id}_${DateTime.now().millisecondsSinceEpoch}.png';
      final file = File('${tempDir.path}/$fileName');
      await file.writeAsBytes(bytes);

      return file.path;
    } catch (e) {
      debugPrint('Error generating preview image: $e');
      return null;
    }
  }

  static Future<void> shareWithPreview({
    required BuildContext context,
    required Story story,
    SharePreviewFormat format = SharePreviewFormat.openGraph,
    String? customMessage,
  }) async {
    final imagePath = await generatePreviewImage(
      context: context,
      story: story,
      format: format,
    );

    final message =
        customMessage ??
        '${story.title}\n\n"${_truncate(story.quotes, 100)}"\n\nRead more on MyItihas';

    if (imagePath != null) {
      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(imagePath)],
          text: message,
          subject: story.title,
        ),
      );
    } else {
      await SharePlus.instance.share(
        ShareParams(text: message, subject: story.title),
      );
    }
  }

  static Future<void> shareAsText({
    required Story story,
    String? customMessage,
  }) async {
    final message =
        customMessage ??
        '''${story.title}

From ${story.scripture}

"${_truncate(story.quotes, 150)}"

${_truncate(story.story, 200)}

Read the full story on MyItihas''';

    await SharePlus.instance.share(
      ShareParams(text: message, subject: story.title),
    );
  }

  static Future<void> shareLink({
    required Story story,
    required String baseUrl,
  }) async {
    final url = '$baseUrl/stories/${story.id}';
    final message = '${story.title}\n\n$url';

    await SharePlus.instance.share(
      ShareParams(text: message, subject: story.title),
    );
  }

  static String _truncate(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength - 3)}...';
  }

  // ============ Image Post Sharing ============

  static Future<void> shareImagePost({
    required ImagePost post,
    String? customMessage,
  }) async {
    final authorName = post.authorUser?.displayName ?? 'MyItihas User';
    final message =
        customMessage ??
        '''${post.caption ?? 'Beautiful image'}

📍 ${post.location ?? 'India'}

Shared by $authorName on MyItihas

#MyItihas ${post.tags.map((t) => '#$t').join(' ')}''';

    await SharePlus.instance.share(
      ShareParams(text: message, subject: post.caption ?? 'MyItihas Post'),
    );
  }

  static Future<void> shareImagePostLink({
    required ImagePost post,
    required String baseUrl,
  }) async {
    final url = '$baseUrl/posts/image/${post.id}';
    final message = '${post.caption ?? 'Check out this post'}\n\n$url';

    await SharePlus.instance.share(
      ShareParams(text: message, subject: post.caption ?? 'MyItihas Post'),
    );
  }

  static Future<void> shareImagePostImage({required ImagePost post}) async {
    // Share the image URL directly - in a real app you'd download and share
    final message =
        '''${post.caption ?? ''}

📍 ${post.location ?? 'India'}

${post.imageUrl}

Shared via MyItihas''';

    await SharePlus.instance.share(
      ShareParams(text: message, subject: post.caption ?? 'MyItihas Image'),
    );
  }

  static Future<void> copyImagePostLink({
    required ImagePost post,
    required String baseUrl,
  }) async {
    final url = '$baseUrl/posts/image/${post.id}';
    await Clipboard.setData(ClipboardData(text: url));
  }

  // ============ Text Post Sharing ============

  static Future<void> shareTextPost({
    required TextPost post,
    String? customMessage,
  }) async {
    final authorName = post.authorUser?.displayName ?? 'MyItihas';
    final message =
        customMessage ??
        '''"${post.body}"

— $authorName

Shared via MyItihas

#MyItihas ${post.tags.map((t) => '#$t').join(' ')}''';

    await SharePlus.instance.share(
      ShareParams(text: message, subject: 'Thought from MyItihas'),
    );
  }

  static Future<void> shareTextPostLink({
    required TextPost post,
    required String baseUrl,
  }) async {
    final url = '$baseUrl/posts/text/${post.id}';
    final message = '"${_truncate(post.body, 100)}"\n\n$url';

    await SharePlus.instance.share(
      ShareParams(text: message, subject: 'Thought from MyItihas'),
    );
  }

  static Future<void> copyTextPostLink({
    required TextPost post,
    required String baseUrl,
  }) async {
    final url = '$baseUrl/posts/text/${post.id}';
    await Clipboard.setData(ClipboardData(text: url));
  }

  static Future<void> copyTextPostContent({required TextPost post}) async {
    final authorName = post.authorUser?.displayName ?? 'MyItihas';
    final text = '"${post.body}"\n\n— $authorName';
    await Clipboard.setData(ClipboardData(text: text));
  }

  // ============ Story Link Copy ============

  static Future<void> copyStoryLink({
    required Story story,
    required String baseUrl,
  }) async {
    final url = '$baseUrl/stories/${story.id}';
    await Clipboard.setData(ClipboardData(text: url));
  }
}

Future<Uint8List?> captureWidget(
  GlobalKey key, {
  double pixelRatio = 3.0,
}) async {
  try {
    final boundary =
        key.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    if (boundary == null) return null;

    final image = await boundary.toImage(pixelRatio: pixelRatio);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    return byteData?.buffer.asUint8List();
  } catch (e) {
    debugPrint('Error capturing widget: $e');
    return null;
  }
}
