// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StoryModelAdapter extends TypeAdapter<StoryModel> {
  @override
  final typeId = 0;

  @override
  StoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StoryModel(
      id: fields[0] as String,
      title: fields[1] as String,
      scripture: fields[2] as String,
      story: fields[3] as String,
      quotes: fields[4] as String,
      trivia: fields[5] as String,
      activity: fields[6] as String,
      lesson: fields[7] as String,
      attributes: fields[8] as StoryAttributesModel,
      imageUrl: fields[9] as String?,
      author: fields[10] as String?,
      publishedAt: fields[11] as DateTime?,
      likes: fields[12] == null ? 0 : (fields[12] as num).toInt(),
      views: fields[13] == null ? 0 : (fields[13] as num).toInt(),
      isFavorite: fields[14] == null ? false : fields[14] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, StoryModel obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.scripture)
      ..writeByte(3)
      ..write(obj.story)
      ..writeByte(4)
      ..write(obj.quotes)
      ..writeByte(5)
      ..write(obj.trivia)
      ..writeByte(6)
      ..write(obj.activity)
      ..writeByte(7)
      ..write(obj.lesson)
      ..writeByte(8)
      ..write(obj.attributes)
      ..writeByte(9)
      ..write(obj.imageUrl)
      ..writeByte(10)
      ..write(obj.author)
      ..writeByte(11)
      ..write(obj.publishedAt)
      ..writeByte(12)
      ..write(obj.likes)
      ..writeByte(13)
      ..write(obj.views)
      ..writeByte(14)
      ..write(obj.isFavorite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StoryAttributesModelAdapter extends TypeAdapter<StoryAttributesModel> {
  @override
  final typeId = 1;

  @override
  StoryAttributesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StoryAttributesModel(
      storyType: fields[0] as String,
      theme: fields[1] as String,
      mainCharacterType: fields[2] as String,
      storySetting: fields[3] as String,
      timeEra: fields[4] as String,
      narrativePerspective: fields[5] as String,
      languageStyle: fields[6] as String,
      emotionalTone: fields[7] as String,
      narrativeStyle: fields[8] as String,
      plotStructure: fields[9] as String,
      storyLength: fields[10] as String,
      references: fields[11] == null ? [] : (fields[11] as List).cast<String>(),
      tags: fields[12] == null ? [] : (fields[12] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, StoryAttributesModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.storyType)
      ..writeByte(1)
      ..write(obj.theme)
      ..writeByte(2)
      ..write(obj.mainCharacterType)
      ..writeByte(3)
      ..write(obj.storySetting)
      ..writeByte(4)
      ..write(obj.timeEra)
      ..writeByte(5)
      ..write(obj.narrativePerspective)
      ..writeByte(6)
      ..write(obj.languageStyle)
      ..writeByte(7)
      ..write(obj.emotionalTone)
      ..writeByte(8)
      ..write(obj.narrativeStyle)
      ..writeByte(9)
      ..write(obj.plotStructure)
      ..writeByte(10)
      ..write(obj.storyLength)
      ..writeByte(11)
      ..write(obj.references)
      ..writeByte(12)
      ..write(obj.tags);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoryAttributesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StoryModel _$StoryModelFromJson(Map<String, dynamic> json) => _StoryModel(
  id: json['id'] as String,
  title: json['title'] as String,
  scripture: json['scripture'] as String,
  story: json['story'] as String,
  quotes: json['quotes'] as String,
  trivia: json['trivia'] as String,
  activity: json['activity'] as String,
  lesson: json['lesson'] as String,
  attributes: StoryAttributesModel.fromJson(
    json['attributes'] as Map<String, dynamic>,
  ),
  imageUrl: json['imageUrl'] as String?,
  author: json['author'] as String?,
  publishedAt: json['publishedAt'] == null
      ? null
      : DateTime.parse(json['publishedAt'] as String).toLocal(),
  likes: (json['likes'] as num?)?.toInt() ?? 0,
  views: (json['views'] as num?)?.toInt() ?? 0,
  isFavorite: json['isFavorite'] as bool? ?? false,
);

Map<String, dynamic> _$StoryModelToJson(_StoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'scripture': instance.scripture,
      'story': instance.story,
      'quotes': instance.quotes,
      'trivia': instance.trivia,
      'activity': instance.activity,
      'lesson': instance.lesson,
      'attributes': instance.attributes,
      'imageUrl': instance.imageUrl,
      'author': instance.author,
      'publishedAt': instance.publishedAt?.toIso8601String(),
      'likes': instance.likes,
      'views': instance.views,
      'isFavorite': instance.isFavorite,
    };

_StoryAttributesModel _$StoryAttributesModelFromJson(
  Map<String, dynamic> json,
) => _StoryAttributesModel(
  storyType: json['storyType'] as String,
  theme: json['theme'] as String,
  mainCharacterType: json['mainCharacterType'] as String,
  storySetting: json['storySetting'] as String,
  timeEra: json['timeEra'] as String,
  narrativePerspective: json['narrativePerspective'] as String,
  languageStyle: json['languageStyle'] as String,
  emotionalTone: json['emotionalTone'] as String,
  narrativeStyle: json['narrativeStyle'] as String,
  plotStructure: json['plotStructure'] as String,
  storyLength: json['storyLength'] as String,
  references:
      (json['references'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
);

Map<String, dynamic> _$StoryAttributesModelToJson(
  _StoryAttributesModel instance,
) => <String, dynamic>{
  'storyType': instance.storyType,
  'theme': instance.theme,
  'mainCharacterType': instance.mainCharacterType,
  'storySetting': instance.storySetting,
  'timeEra': instance.timeEra,
  'narrativePerspective': instance.narrativePerspective,
  'languageStyle': instance.languageStyle,
  'emotionalTone': instance.emotionalTone,
  'narrativeStyle': instance.narrativeStyle,
  'plotStructure': instance.plotStructure,
  'storyLength': instance.storyLength,
  'references': instance.references,
  'tags': instance.tags,
};
