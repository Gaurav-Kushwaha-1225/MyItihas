import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:myitihas/core/logging/talker_setup.dart';
import 'package:myitihas/features/home/data/models/activity_item_model.dart';
import 'package:myitihas/features/home/domain/entities/activity_item.dart';

/// Local data source for activity tracking using Hive
@lazySingleton
class ActivityLocalDataSource {
  static const String _boxName = 'user_activity';
  Box<ActivityItemModel>? _box;

  /// Initialize the Hive box
  Future<void> init() async {
    if (_box != null && _box!.isOpen) return;

    if (!Hive.isAdapterRegistered(51)) {
      Hive.registerAdapter(ActivityItemModelAdapter());
    }

    _box = await Hive.openBox<ActivityItemModel>(_boxName);
    talker.info('📊 ActivityLocalDataSource initialized');
  }

  /// Ensure box is initialized
  Future<Box<ActivityItemModel>> _getBox() async {
    if (_box == null || !_box!.isOpen) {
      await init();
    }
    return _box!;
  }

  /// Record a new activity
  Future<void> recordActivity(ActivityItem activity) async {
    try {
      final box = await _getBox();
      final model = ActivityItemModel.fromDomain(activity);
      await box.put(activity.id, model);
      talker.info('📊 Recorded activity: ${activity.actionDescription}');
    } catch (e, st) {
      talker.error('Failed to record activity', e, st);
    }
  }

  /// Get all activities sorted by timestamp (most recent first)
  Future<List<ActivityItem>> getAllActivities() async {
    try {
      final box = await _getBox();
      final activities = box.values.map((m) => m.toDomain()).toList();
      activities.sort((a, b) => b.timestamp.compareTo(a.timestamp));
      return activities;
    } catch (e, st) {
      talker.error('Failed to get activities', e, st);
      return [];
    }
  }

  /// Get recent activities (limited count)
  Future<List<ActivityItem>> getRecentActivities({int limit = 20}) async {
    final activities = await getAllActivities();
    return activities.take(limit).toList();
  }

  /// Get activities by type
  Future<List<ActivityItem>> getActivitiesByType(ActivityType type) async {
    final activities = await getAllActivities();
    return activities.where((a) => a.type == type).toList();
  }

  /// Get activities for a specific story
  Future<List<ActivityItem>> getActivitiesForStory(String storyId) async {
    final activities = await getAllActivities();
    return activities.where((a) => a.storyId == storyId).toList();
  }

  /// Get activities grouped by date
  Future<Map<DateTime, List<ActivityItem>>> getActivitiesGroupedByDate() async {
    final activities = await getAllActivities();
    final grouped = <DateTime, List<ActivityItem>>{};

    for (final activity in activities) {
      final dateOnly = DateTime(
        activity.timestamp.year,
        activity.timestamp.month,
        activity.timestamp.day,
      );

      grouped.putIfAbsent(dateOnly, () => []).add(activity);
    }

    return grouped;
  }

  /// Delete activity by ID
  Future<void> deleteActivity(String id) async {
    try {
      final box = await _getBox();
      await box.delete(id);
    } catch (e, st) {
      talker.error('Failed to delete activity', e, st);
    }
  }

  /// Clear all activities
  Future<void> clearAll() async {
    try {
      final box = await _getBox();
      await box.clear();
      talker.info('📊 Cleared all activities');
    } catch (e, st) {
      talker.error('Failed to clear activities', e, st);
    }
  }

  /// Helper to create a unique activity ID
  static String generateActivityId() {
    return '${DateTime.now().millisecondsSinceEpoch}_${DateTime.now().microsecond}';
  }
}
