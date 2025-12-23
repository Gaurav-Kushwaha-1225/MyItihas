/// Enum representing the different types of content in the social feed
enum ContentType {
  story,
  imagePost,
  textPost;

  String get displayName {
    switch (this) {
      case ContentType.story:
        return 'Story';
      case ContentType.imagePost:
        return 'Image';
      case ContentType.textPost:
        return 'Text';
    }
  }
}
