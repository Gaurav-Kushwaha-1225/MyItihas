import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';
import '../../domain/entities/story.dart';

part 'story_model.freezed.dart';
part 'story_model.g.dart';

@freezed
@HiveType(typeId: 0)
abstract class StoryModel with _$StoryModel {
  const factory StoryModel({
    @HiveField(0) required String id,
    @HiveField(1) required String title,
    @HiveField(2) required String scripture,
    @HiveField(3) required String story,
    @HiveField(4) required String quotes,
    @HiveField(5) required String trivia,
    @HiveField(6) required String activity,
    @HiveField(7) required String lesson,
    @HiveField(8) required StoryAttributesModel attributes,
    @HiveField(9) String? imageUrl,
    @HiveField(10) String? author,
    @HiveField(11) DateTime? publishedAt,
    @HiveField(12) @Default(0) int likes,
    @HiveField(13) @Default(0) int views,
    @HiveField(14) @Default(false) bool isFavorite,
  }) = _StoryModel;

  const StoryModel._();

  factory StoryModel.fromJson(Map<String, dynamic> json) =>
      _$StoryModelFromJson(json);

  Story toEntity() {
    return Story(
      id: id,
      title: title,
      scripture: scripture,
      story: story,
      quotes: quotes,
      trivia: trivia,
      activity: activity,
      lesson: lesson,
      attributes: attributes.toEntity(),
      imageUrl: imageUrl,
      author: author,
      publishedAt: publishedAt,
      likes: likes,
      views: views,
      isFavorite: isFavorite,
    );
  }

  factory StoryModel.fromEntity(Story entity) {
    return StoryModel(
      id: entity.id,
      title: entity.title,
      scripture: entity.scripture,
      story: entity.story,
      quotes: entity.quotes,
      trivia: entity.trivia,
      activity: entity.activity,
      lesson: entity.lesson,
      attributes: StoryAttributesModel.fromEntity(entity.attributes),
      imageUrl: entity.imageUrl,
      author: entity.author,
      publishedAt: entity.publishedAt,
      likes: entity.likes,
      views: entity.views,
      isFavorite: entity.isFavorite,
    );
  }
}

@freezed
@HiveType(typeId: 1)
abstract class StoryAttributesModel with _$StoryAttributesModel {
  const factory StoryAttributesModel({
    @HiveField(0) required String storyType,
    @HiveField(1) required String theme,
    @HiveField(2) required String mainCharacterType,
    @HiveField(3) required String storySetting,
    @HiveField(4) required String timeEra,
    @HiveField(5) required String narrativePerspective,
    @HiveField(6) required String languageStyle,
    @HiveField(7) required String emotionalTone,
    @HiveField(8) required String narrativeStyle,
    @HiveField(9) required String plotStructure,
    @HiveField(10) required String storyLength,
    @HiveField(11) @Default([]) List<String> references,
    @HiveField(12) @Default([]) List<String> tags,
  }) = _StoryAttributesModel;

  const StoryAttributesModel._();

  factory StoryAttributesModel.fromJson(Map<String, dynamic> json) =>
      _$StoryAttributesModelFromJson(json);

  StoryAttributes toEntity() {
    return StoryAttributes(
      storyType: storyType,
      theme: theme,
      mainCharacterType: mainCharacterType,
      storySetting: storySetting,
      timeEra: timeEra,
      narrativePerspective: narrativePerspective,
      languageStyle: languageStyle,
      emotionalTone: emotionalTone,
      narrativeStyle: narrativeStyle,
      plotStructure: plotStructure,
      storyLength: storyLength,
      references: references,
      tags: tags,
    );
  }

  factory StoryAttributesModel.fromEntity(StoryAttributes entity) {
    return StoryAttributesModel(
      storyType: entity.storyType,
      theme: entity.theme,
      mainCharacterType: entity.mainCharacterType,
      storySetting: entity.storySetting,
      timeEra: entity.timeEra,
      narrativePerspective: entity.narrativePerspective,
      languageStyle: entity.languageStyle,
      emotionalTone: entity.emotionalTone,
      narrativeStyle: entity.narrativeStyle,
      plotStructure: entity.plotStructure,
      storyLength: entity.storyLength,
      references: entity.references,
      tags: entity.tags,
    );
  }
}
