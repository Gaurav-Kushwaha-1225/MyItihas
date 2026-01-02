import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:myitihas/core/logging/talker_setup.dart';

part 'reading_progress_service.g.dart';

/// Model representing reading progress for a story
@HiveType(typeId: 50)
class ReadingProgress extends HiveObject {
  @HiveField(0)
  final String storyId;

  @HiveField(1)
  final String storyTitle;

  @HiveField(2)
  final double scrollPosition;

  @HiveField(3)
  final double totalLength;

  @HiveField(4)
  final DateTime lastReadAt;

  @HiveField(5)
  final String? thumbnailUrl;

  @HiveField(6)
  final String? scripture;

  ReadingProgress({
    required this.storyId,
    required this.storyTitle,
    required this.scrollPosition,
    required this.totalLength,
    required this.lastReadAt,
    this.thumbnailUrl,
    this.scripture,
  });

  /// Progress percentage (0.0 - 1.0)
  double get percentage =>
      totalLength > 0 ? (scrollPosition / totalLength).clamp(0.0, 1.0) : 0.0;

  /// Estimated reading time left in minutes (assuming 200 words per minute, ~5 chars per word)
  int get minutesLeft {
    final remainingLength = totalLength - scrollPosition;
    final wordsRemaining = remainingLength / 5;
    return (wordsRemaining / 200).ceil();
  }

  /// Whether the story is considered complete (>95% read)
  bool get isComplete => percentage >= 0.95;

  ReadingProgress copyWith({
    String? storyId,
    String? storyTitle,
    double? scrollPosition,
    double? totalLength,
    DateTime? lastReadAt,
    String? thumbnailUrl,
    String? scripture,
  }) {
    return ReadingProgress(
      storyId: storyId ?? this.storyId,
      storyTitle: storyTitle ?? this.storyTitle,
      scrollPosition: scrollPosition ?? this.scrollPosition,
      totalLength: totalLength ?? this.totalLength,
      lastReadAt: lastReadAt ?? this.lastReadAt,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      scripture: scripture ?? this.scripture,
    );
  }
}

/// Service for tracking and persisting reading progress using Hive
@lazySingleton
class ReadingProgressService {
  static const String _boxName = 'reading_progress';
  Box<ReadingProgress>? _box;

  /// Initialize the Hive box
  Future<void> init() async {
    if (_box != null && _box!.isOpen) return;

    if (!Hive.isAdapterRegistered(50)) {
      Hive.registerAdapter(ReadingProgressAdapter());
    }

    _box = await Hive.openBox<ReadingProgress>(_boxName);
    talker.info('📖 ReadingProgressService initialized');
  }

  /// Ensure box is initialized
  Future<Box<ReadingProgress>> _getBox() async {
    if (_box == null || !_box!.isOpen) {
      await init();
    }
    return _box!;
  }

  /// Save or update reading progress for a story
  Future<void> saveProgress({
    required String storyId,
    required String storyTitle,
    required double scrollPosition,
    required double totalLength,
    String? thumbnailUrl,
    String? scripture,
  }) async {
    try {
      final box = await _getBox();

      final progress = ReadingProgress(
        storyId: storyId,
        storyTitle: storyTitle,
        scrollPosition: scrollPosition,
        totalLength: totalLength,
        lastReadAt: DateTime.now(),
        thumbnailUrl: thumbnailUrl,
        scripture: scripture,
      );

      await box.put(storyId, progress);
      talker.info(
        '📖 Saved progress for "$storyTitle": ${(progress.percentage * 100).toStringAsFixed(1)}%',
      );
    } catch (e, st) {
      talker.error('Failed to save reading progress', e, st);
    }
  }

  /// Get reading progress for a specific story
  Future<ReadingProgress?> getProgress(String storyId) async {
    try {
      final box = await _getBox();
      return box.get(storyId);
    } catch (e, st) {
      talker.error('Failed to get reading progress', e, st);
      return null;
    }
  }

  /// Get all stories currently in progress (not complete)
  Future<List<ReadingProgress>> getAllInProgress() async {
    try {
      final box = await _getBox();
      final allProgress = box.values.toList();

      // Filter to only in-progress stories (started but not complete)
      final inProgress = allProgress
          .where((p) => p.percentage > 0.01 && !p.isComplete)
          .toList();

      // Sort by last read (most recent first)
      inProgress.sort((a, b) => b.lastReadAt.compareTo(a.lastReadAt));

      return inProgress;
    } catch (e, st) {
      talker.error('Failed to get in-progress stories', e, st);
      return [];
    }
  }

  /// Get all completed stories
  Future<List<ReadingProgress>> getCompleted() async {
    try {
      final box = await _getBox();
      final allProgress = box.values.toList();

      final completed = allProgress.where((p) => p.isComplete).toList();
      completed.sort((a, b) => b.lastReadAt.compareTo(a.lastReadAt));

      return completed;
    } catch (e, st) {
      talker.error('Failed to get completed stories', e, st);
      return [];
    }
  }

  /// Clear reading progress for a specific story
  Future<void> clearProgress(String storyId) async {
    try {
      final box = await _getBox();
      await box.delete(storyId);
      talker.info('📖 Cleared progress for story: $storyId');
    } catch (e, st) {
      talker.error('Failed to clear reading progress', e, st);
    }
  }

  /// Clear all reading progress
  Future<void> clearAll() async {
    try {
      final box = await _getBox();
      await box.clear();
      talker.info('📖 Cleared all reading progress');
    } catch (e, st) {
      talker.error('Failed to clear all reading progress', e, st);
    }
  }

  /// Mark a story as complete
  Future<void> markComplete({
    required String storyId,
    required String storyTitle,
    required double totalLength,
    String? thumbnailUrl,
    String? scripture,
  }) async {
    await saveProgress(
      storyId: storyId,
      storyTitle: storyTitle,
      scrollPosition: totalLength,
      totalLength: totalLength,
      thumbnailUrl: thumbnailUrl,
      scripture: scripture,
    );
  }
}
