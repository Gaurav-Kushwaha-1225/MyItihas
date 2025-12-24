/// Enum representing the different types of content in the social feed
enum ContentType {
  story,
  imagePost,
  textPost,
  videoPost;

  String get displayName {
    switch (this) {
      case ContentType.story:
        return 'Story';
      case ContentType.imagePost:
        return 'Image';
      case ContentType.textPost:
        return 'Text';
      case ContentType.videoPost:
        return 'Video';
    }
  }
}
