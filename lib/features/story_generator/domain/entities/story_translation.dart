class TranslatedStory {
  final String title;
  final String story;
  final String moral;
  final String lang;

  const TranslatedStory({
    required this.title,
    required this.story,
    required this.moral,
    required this.lang,
  });

  factory TranslatedStory.fromJson(Map<String, dynamic> json) {
    return TranslatedStory(
      title: (json['title'] ?? '').toString(),
      story: (json['story'] ?? '').toString(),
      moral: (json['moral'] ?? '').toString(),
      lang: (json['lang'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'story': story,
        'moral': moral,
        'lang': lang,
      };
}
