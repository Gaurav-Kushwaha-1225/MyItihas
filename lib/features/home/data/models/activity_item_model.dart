import 'package:hive_ce/hive.dart';
import 'package:myitihas/features/home/domain/entities/activity_item.dart';

part 'activity_item_model.g.dart';

/// Hive model for ActivityItem persistence
@HiveType(typeId: 51)
class ActivityItemModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final int typeIndex;

  @HiveField(2)
  final String storyId;

  @HiveField(3)
  final String storyTitle;

  @HiveField(4)
  final DateTime timestamp;

  @HiveField(5)
  final String? thumbnailUrl;

  @HiveField(6)
  final String? scripture;

  ActivityItemModel({
    required this.id,
    required this.typeIndex,
    required this.storyId,
    required this.storyTitle,
    required this.timestamp,
    this.thumbnailUrl,
    this.scripture,
  });

  /// Create from domain entity
  factory ActivityItemModel.fromDomain(ActivityItem item) {
    return ActivityItemModel(
      id: item.id,
      typeIndex: item.type.index,
      storyId: item.storyId,
      storyTitle: item.storyTitle,
      timestamp: item.timestamp,
      thumbnailUrl: item.thumbnailUrl,
      scripture: item.scripture,
    );
  }

  /// Convert to domain entity
  ActivityItem toDomain() {
    return ActivityItem(
      id: id,
      type: ActivityType.values[typeIndex],
      storyId: storyId,
      storyTitle: storyTitle,
      timestamp: timestamp,
      thumbnailUrl: thumbnailUrl,
      scripture: scripture,
    );
  }
}
