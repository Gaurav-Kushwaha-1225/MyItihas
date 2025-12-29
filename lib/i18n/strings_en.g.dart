///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final TranslationsAppEn app = TranslationsAppEn._(_root);
	late final TranslationsCommonEn common = TranslationsCommonEn._(_root);
	late final TranslationsNavigationEn navigation = TranslationsNavigationEn._(_root);
	late final TranslationsHomeEn home = TranslationsHomeEn._(_root);
	late final TranslationsStoriesEn stories = TranslationsStoriesEn._(_root);
	late final TranslationsStoryGeneratorEn storyGenerator = TranslationsStoryGeneratorEn._(_root);
	late final TranslationsChatEn chat = TranslationsChatEn._(_root);
	late final TranslationsMapEn map = TranslationsMapEn._(_root);
	late final TranslationsCommunityEn community = TranslationsCommunityEn._(_root);
	late final TranslationsSettingsEn settings = TranslationsSettingsEn._(_root);
	late final TranslationsAuthEn auth = TranslationsAuthEn._(_root);
	late final TranslationsErrorEn error = TranslationsErrorEn._(_root);
	late final TranslationsSubscriptionEn subscription = TranslationsSubscriptionEn._(_root);
	late final TranslationsNotificationEn notification = TranslationsNotificationEn._(_root);
	late final TranslationsProfileEn profile = TranslationsProfileEn._(_root);
	late final TranslationsFeedEn feed = TranslationsFeedEn._(_root);
}

// Path: app
class TranslationsAppEn {
	TranslationsAppEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'MyItihas'
	String get name => 'MyItihas';

	/// en: 'Discover Indian Mythology'
	String get tagline => 'Discover Indian Mythology';
}

// Path: common
class TranslationsCommonEn {
	TranslationsCommonEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'OK'
	String get ok => 'OK';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Confirm'
	String get confirm => 'Confirm';

	/// en: 'Delete'
	String get delete => 'Delete';

	/// en: 'Edit'
	String get edit => 'Edit';

	/// en: 'Save'
	String get save => 'Save';

	/// en: 'Share'
	String get share => 'Share';

	/// en: 'Search'
	String get search => 'Search';

	/// en: 'Loading...'
	String get loading => 'Loading...';

	/// en: 'Error'
	String get error => 'Error';

	/// en: 'Retry'
	String get retry => 'Retry';

	/// en: 'Back'
	String get back => 'Back';

	/// en: 'Next'
	String get next => 'Next';

	/// en: 'Finish'
	String get finish => 'Finish';

	/// en: 'Skip'
	String get skip => 'Skip';

	/// en: 'Yes'
	String get yes => 'Yes';

	/// en: 'No'
	String get no => 'No';

	/// en: 'Read the full story'
	String get read_full_story => 'Read the full story';
}

// Path: navigation
class TranslationsNavigationEn {
	TranslationsNavigationEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Home'
	String get home => 'Home';

	/// en: 'Stories'
	String get stories => 'Stories';

	/// en: 'Chat'
	String get chat => 'Chat';

	/// en: 'Map'
	String get map => 'Map';

	/// en: 'Community'
	String get community => 'Community';

	/// en: 'Settings'
	String get settings => 'Settings';

	/// en: 'Profile'
	String get profile => 'Profile';
}

// Path: home
class TranslationsHomeEn {
	TranslationsHomeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'MyItihas'
	String get title => 'MyItihas';

	/// en: 'Story Generator'
	String get storyGenerator => 'Story Generator';

	/// en: 'ChatItihas'
	String get chatItihas => 'ChatItihas';

	/// en: 'Community Stories'
	String get communityStories => 'Community Stories';

	/// en: 'Maps'
	String get maps => 'Maps';

	/// en: 'Good Morning'
	String get greetingMorning => 'Good Morning';

	/// en: 'Continue reading'
	String get continueReading => 'Continue reading';

	/// en: 'Good Afternoon'
	String get greetingAfternoon => 'Good Afternoon';

	/// en: 'Good Evening'
	String get greetingEvening => 'Good Evening';

	/// en: 'Explore Stories'
	String get exploreStories => 'Explore Stories';

	/// en: 'Generate Story'
	String get generateStory => 'Generate Story';

	/// en: 'Home Content'
	String get content => 'Home Content';
}

// Path: stories
class TranslationsStoriesEn {
	TranslationsStoriesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Stories'
	String get title => 'Stories';

	/// en: 'Search by title or author...'
	String get searchHint => 'Search by title or author...';

	/// en: 'Sort by'
	String get sortBy => 'Sort by';

	/// en: 'Newest First'
	String get sortNewest => 'Newest First';

	/// en: 'Oldest First'
	String get sortOldest => 'Oldest First';

	/// en: 'Most Popular'
	String get sortPopular => 'Most Popular';

	/// en: 'No stories found'
	String get noStories => 'No stories found';

	/// en: 'Loading stories...'
	String get loadingStories => 'Loading stories...';

	/// en: 'Failed to load stories'
	String get errorLoadingStories => 'Failed to load stories';

	/// en: 'Story Details'
	String get storyDetails => 'Story Details';

	/// en: 'Continue reading'
	String get continueReading => 'Continue reading';

	/// en: 'Read More'
	String get readMore => 'Read More';

	/// en: 'Read Less'
	String get readLess => 'Read Less';

	/// en: 'Author'
	String get author => 'Author';

	/// en: 'Published on'
	String get publishedOn => 'Published on';

	/// en: 'Category'
	String get category => 'Category';

	/// en: 'Tags'
	String get tags => 'Tags';

	/// en: 'Failed to load story'
	String get failed_to_load => 'Failed to load story';
}

// Path: storyGenerator
class TranslationsStoryGeneratorEn {
	TranslationsStoryGeneratorEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Story Generator'
	String get title => 'Story Generator';

	/// en: 'Create your own mythological story'
	String get subtitle => 'Create your own mythological story';

	/// en: 'Quick Start'
	String get quickStart => 'Quick Start';

	/// en: 'Interactive'
	String get interactive => 'Interactive';

	/// en: 'Raw Prompt'
	String get rawPrompt => 'Raw Prompt';

	/// en: 'Your Story Prompt'
	String get yourStoryPrompt => 'Your Story Prompt';

	/// en: 'Write Your Prompt'
	String get writeYourPrompt => 'Write Your Prompt';

	/// en: 'Select Scripture'
	String get selectScripture => 'Select Scripture';

	/// en: 'Select Story Type'
	String get selectStoryType => 'Select Story Type';

	/// en: 'Select Character'
	String get selectCharacter => 'Select Character';

	/// en: 'Select Theme'
	String get selectTheme => 'Select Theme';

	/// en: 'Select Setting'
	String get selectSetting => 'Select Setting';

	/// en: 'Select Language'
	String get selectLanguage => 'Select Language';

	/// en: 'Story Length'
	String get selectLength => 'Story Length';

	/// en: 'More Options'
	String get moreOptions => 'More Options';

	/// en: 'Random'
	String get random => 'Random';

	/// en: 'Generate Story'
	String get generate => 'Generate Story';

	/// en: 'Generating your story...'
	String get generating => 'Generating your story...';

	/// en: 'Creating Your Story'
	String get creatingYourStory => 'Creating Your Story';

	/// en: 'Consulting the ancient scriptures...'
	String get consultingScriptures => 'Consulting the ancient scriptures...';

	/// en: 'Weaving your tale...'
	String get weavingTale => 'Weaving your tale...';

	/// en: 'Adding divine wisdom...'
	String get addingWisdom => 'Adding divine wisdom...';

	/// en: 'Polishing the narrative...'
	String get polishingNarrative => 'Polishing the narrative...';

	/// en: 'Almost there...'
	String get almostThere => 'Almost there...';

	/// en: 'Your Generated Story'
	String get generatedStory => 'Your Generated Story';

	/// en: 'AI Generated'
	String get aiGenerated => 'AI Generated';

	/// en: 'Regenerate'
	String get regenerate => 'Regenerate';

	/// en: 'Save Story'
	String get saveStory => 'Save Story';

	/// en: 'Share Story'
	String get shareStory => 'Share Story';

	/// en: 'New Story'
	String get newStory => 'New Story';

	/// en: 'Saved'
	String get saved => 'Saved';

	/// en: 'Story saved to your library'
	String get storySaved => 'Story saved to your library';

	/// en: 'Story'
	String get story => 'Story';

	/// en: 'Lesson'
	String get lesson => 'Lesson';

	/// en: 'Did You Know?'
	String get didYouKnow => 'Did You Know?';

	/// en: 'Activity'
	String get activity => 'Activity';

	/// en: 'Optional: Refine with options'
	String get optionalRefine => 'Optional: Refine with options';

	/// en: 'Apply Options'
	String get applyOptions => 'Apply Options';

	/// en: 'Language'
	String get language => 'Language';

	/// en: 'Story Format'
	String get storyFormat => 'Story Format';

	late final TranslationsStoryGeneratorStoryLengthEn storyLength = TranslationsStoryGeneratorStoryLengthEn._(_root);
	late final TranslationsStoryGeneratorFormatEn format = TranslationsStoryGeneratorFormatEn._(_root);
	late final TranslationsStoryGeneratorHintsEn hints = TranslationsStoryGeneratorHintsEn._(_root);
	late final TranslationsStoryGeneratorErrorsEn errors = TranslationsStoryGeneratorErrorsEn._(_root);
}

// Path: chat
class TranslationsChatEn {
	TranslationsChatEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'ChatItihas'
	String get title => 'ChatItihas';

	/// en: 'Chat with AI about mythology'
	String get subtitle => 'Chat with AI about mythology';

	/// en: 'Friend Mode'
	String get friendMode => 'Friend Mode';

	/// en: 'Philosophical Mode'
	String get philosophicalMode => 'Philosophical Mode';

	/// en: 'Type your message...'
	String get typeMessage => 'Type your message...';

	/// en: 'Send'
	String get send => 'Send';

	/// en: 'New Chat'
	String get newChat => 'New Chat';

	/// en: 'Chat History'
	String get chatHistory => 'Chat History';

	/// en: 'Clear Chat'
	String get clearChat => 'Clear Chat';

	/// en: 'No messages yet. Start a conversation!'
	String get noMessages => 'No messages yet. Start a conversation!';

	/// en: 'Chat List Page'
	String get list_page => 'Chat List Page';
}

// Path: map
class TranslationsMapEn {
	TranslationsMapEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Akhanda Bharata'
	String get title => 'Akhanda Bharata';

	/// en: 'Explore historical locations'
	String get subtitle => 'Explore historical locations';

	/// en: 'Search location...'
	String get searchLocation => 'Search location...';

	/// en: 'View Details'
	String get viewDetails => 'View Details';

	/// en: 'Show Route'
	String get showRoute => 'Show Route';

	/// en: 'Historical Information'
	String get historicalInfo => 'Historical Information';

	/// en: 'Nearby Places'
	String get nearbyPlaces => 'Nearby Places';
}

// Path: community
class TranslationsCommunityEn {
	TranslationsCommunityEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Community'
	String get title => 'Community';

	/// en: 'Trending'
	String get trending => 'Trending';

	/// en: 'Following'
	String get following => 'Following';

	/// en: 'Followers'
	String get followers => 'Followers';

	/// en: 'Posts'
	String get posts => 'Posts';

	/// en: 'Follow'
	String get follow => 'Follow';

	/// en: 'Unfollow'
	String get unfollow => 'Unfollow';

	/// en: 'Share your story...'
	String get shareYourStory => 'Share your story...';

	/// en: 'Post'
	String get post => 'Post';

	/// en: 'Like'
	String get like => 'Like';

	/// en: 'Comment'
	String get comment => 'Comment';

	/// en: 'Comments'
	String get comments => 'Comments';

	/// en: 'No posts yet'
	String get noPostsYet => 'No posts yet';
}

// Path: settings
class TranslationsSettingsEn {
	TranslationsSettingsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Settings'
	String get title => 'Settings';

	/// en: 'Language'
	String get language => 'Language';

	/// en: 'Theme'
	String get theme => 'Theme';

	/// en: 'Light'
	String get themeLight => 'Light';

	/// en: 'Dark'
	String get themeDark => 'Dark';

	/// en: 'System Default'
	String get themeSystem => 'System Default';

	/// en: 'Notifications'
	String get notifications => 'Notifications';

	/// en: 'Account'
	String get account => 'Account';

	/// en: 'Privacy'
	String get privacy => 'Privacy';

	/// en: 'About'
	String get about => 'About';

	/// en: 'Version'
	String get version => 'Version';

	/// en: 'Logout'
	String get logout => 'Logout';
}

// Path: auth
class TranslationsAuthEn {
	TranslationsAuthEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Login'
	String get login => 'Login';

	/// en: 'Sign Up'
	String get signup => 'Sign Up';

	/// en: 'Email'
	String get email => 'Email';

	/// en: 'Password'
	String get password => 'Password';

	/// en: 'Confirm Password'
	String get confirmPassword => 'Confirm Password';

	/// en: 'Forgot Password?'
	String get forgotPassword => 'Forgot Password?';

	/// en: 'Reset Password'
	String get resetPassword => 'Reset Password';

	/// en: 'Don't have an account?'
	String get dontHaveAccount => 'Don\'t have an account?';

	/// en: 'Already have an account?'
	String get alreadyHaveAccount => 'Already have an account?';

	/// en: 'Login successful'
	String get loginSuccess => 'Login successful';

	/// en: 'Sign up successful'
	String get signupSuccess => 'Sign up successful';

	/// en: 'Login failed'
	String get loginError => 'Login failed';

	/// en: 'Sign up failed'
	String get signupError => 'Sign up failed';
}

// Path: error
class TranslationsErrorEn {
	TranslationsErrorEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'No internet connection'
	String get network => 'No internet connection';

	/// en: 'Server error occurred'
	String get server => 'Server error occurred';

	/// en: 'Failed to load cached data'
	String get cache => 'Failed to load cached data';

	/// en: 'Request timed out'
	String get timeout => 'Request timed out';

	/// en: 'Resource not found'
	String get notFound => 'Resource not found';

	/// en: 'Validation failed'
	String get validation => 'Validation failed';

	/// en: 'An unexpected error occurred'
	String get unexpected => 'An unexpected error occurred';

	/// en: 'Please try again'
	String get tryAgain => 'Please try again';
}

// Path: subscription
class TranslationsSubscriptionEn {
	TranslationsSubscriptionEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Free'
	String get free => 'Free';

	/// en: 'Plus'
	String get plus => 'Plus';

	/// en: 'Pro'
	String get pro => 'Pro';

	/// en: 'Upgrade to Pro'
	String get upgradeToPro => 'Upgrade to Pro';

	/// en: 'Features'
	String get features => 'Features';

	/// en: 'Subscribe'
	String get subscribe => 'Subscribe';

	/// en: 'Current Plan'
	String get currentPlan => 'Current Plan';

	/// en: 'Manage Plan'
	String get managePlan => 'Manage Plan';
}

// Path: notification
class TranslationsNotificationEn {
	TranslationsNotificationEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Notifications'
	String get title => 'Notifications';

	/// en: 'Mark all read'
	String get markAllRead => 'Mark all read';

	/// en: 'No notifications yet'
	String get noNotifications => 'No notifications yet';

	/// en: 'Error:'
	String get errorPrefix => 'Error:';

	/// en: 'Retry'
	String get retry => 'Retry';

	/// en: '{{actorName}} liked your story'
	String get likedYourStory => '{{actorName}} liked your story';

	/// en: '{{actorName}} commented on your story'
	String get commentedOnYourStory => '{{actorName}} commented on your story';

	/// en: '{{actorName}} replied to your comment'
	String get repliedToYourComment => '{{actorName}} replied to your comment';

	/// en: '{{actorName}} started following you'
	String get startedFollowingYou => '{{actorName}} started following you';

	/// en: '{{actorName}} sent you a message'
	String get sentYouAMessage => '{{actorName}} sent you a message';
}

// Path: profile
class TranslationsProfileEn {
	TranslationsProfileEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Followers'
	String get followers => 'Followers';

	/// en: 'Following'
	String get following => 'Following';

	/// en: 'Unfollow'
	String get unfollow => 'Unfollow';

	/// en: 'Follow'
	String get follow => 'Follow';

	/// en: 'About'
	String get about => 'About';

	/// en: 'Stories'
	String get stories => 'Stories';
}

// Path: feed
class TranslationsFeedEn {
	TranslationsFeedEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Loading stories...'
	String get loading => 'Loading stories...';

	/// en: 'Oops! Something went wrong'
	String get errorTitle => 'Oops! Something went wrong';

	/// en: 'Try Again'
	String get tryAgain => 'Try Again';

	/// en: 'No stories available'
	String get noStoriesAvailable => 'No stories available';

	/// en: 'No image posts available'
	String get noImagesAvailable => 'No image posts available';

	/// en: 'No text posts available'
	String get noTextPostsAvailable => 'No text posts available';

	/// en: 'No content available'
	String get noContentAvailable => 'No content available';

	/// en: 'Refresh'
	String get refresh => 'Refresh';

	/// en: 'Comments'
	String get comments => 'Comments';

	/// en: 'Comments coming soon'
	String get commentsComingSoon => 'Comments coming soon';

	/// en: 'Add a comment...'
	String get addCommentHint => 'Add a comment...';

	/// en: 'Share Story'
	String get shareStory => 'Share Story';

	/// en: 'Share Post'
	String get sharePost => 'Share Post';

	/// en: 'Share Thought'
	String get shareThought => 'Share Thought';

	/// en: 'Share as Image'
	String get shareAsImage => 'Share as Image';

	/// en: 'Create a beautiful preview card'
	String get shareAsImageSubtitle => 'Create a beautiful preview card';

	/// en: 'Share Link'
	String get shareLink => 'Share Link';

	/// en: 'Copy or share the story link'
	String get shareLinkSubtitle => 'Copy or share the story link';

	/// en: 'Copy or share the post link'
	String get shareImageLinkSubtitle => 'Copy or share the post link';

	/// en: 'Copy or share the thought link'
	String get shareTextLinkSubtitle => 'Copy or share the thought link';

	/// en: 'Share as Text'
	String get shareAsText => 'Share as Text';

	/// en: 'Share the story excerpt'
	String get shareAsTextSubtitle => 'Share the story excerpt';

	/// en: 'Share Quote'
	String get shareQuote => 'Share Quote';

	/// en: 'Share as a quotable text'
	String get shareQuoteSubtitle => 'Share as a quotable text';

	/// en: 'Share with Image'
	String get shareWithImage => 'Share with Image';

	/// en: 'Share the image with caption'
	String get shareWithImageSubtitle => 'Share the image with caption';

	/// en: 'Copy Link'
	String get copyLink => 'Copy Link';

	/// en: 'Copy link to clipboard'
	String get copyLinkSubtitle => 'Copy link to clipboard';

	/// en: 'Copy Text'
	String get copyText => 'Copy Text';

	/// en: 'Copy the quote to clipboard'
	String get copyTextSubtitle => 'Copy the quote to clipboard';

	/// en: 'Link copied to clipboard'
	String get linkCopied => 'Link copied to clipboard';

	/// en: 'Text copied to clipboard'
	String get textCopied => 'Text copied to clipboard';

	/// en: 'Send to User'
	String get sendToUser => 'Send to User';

	/// en: 'Share directly with a friend'
	String get sendToUserSubtitle => 'Share directly with a friend';

	/// en: 'Choose Format'
	String get chooseFormat => 'Choose Format';

	/// en: 'Link Preview'
	String get linkPreview => 'Link Preview';

	/// en: '1200 × 630'
	String get linkPreviewSize => '1200 × 630';

	/// en: 'Story Format'
	String get storyFormat => 'Story Format';

	/// en: '1080 × 1920 (Instagram/Stories)'
	String get storyFormatSize => '1080 × 1920 (Instagram/Stories)';

	/// en: 'Generating preview...'
	String get generatingPreview => 'Generating preview...';

	/// en: 'Bookmarked'
	String get bookmarked => 'Bookmarked';

	/// en: 'Removed from bookmarks'
	String get removedFromBookmarks => 'Removed from bookmarks';

	/// en: 'Unlike, {{count}} likes'
	String get unlike => 'Unlike, {{count}} likes';

	/// en: 'Like, {{count}} likes'
	String get like => 'Like, {{count}} likes';

	/// en: '{{count}} comments'
	String get commentCount => '{{count}} comments';

	/// en: 'Share, {{count}} shares'
	String get shareCount => 'Share, {{count}} shares';

	/// en: 'Remove bookmark'
	String get removeBookmark => 'Remove bookmark';

	/// en: 'Bookmark'
	String get addBookmark => 'Bookmark';

	/// en: 'Quote'
	String get quote => 'Quote';

	/// en: 'Quote copied to clipboard'
	String get quoteCopied => 'Quote copied to clipboard';

	/// en: 'Copy'
	String get copy => 'Copy';

	/// en: 'Tap to view full quote'
	String get tapToViewFullQuote => 'Tap to view full quote';

	/// en: 'Quote from MyItihas'
	String get quoteFromMyitihas => 'Quote from MyItihas';

	late final TranslationsFeedTabsEn tabs = TranslationsFeedTabsEn._(_root);
}

// Path: storyGenerator.storyLength
class TranslationsStoryGeneratorStoryLengthEn {
	TranslationsStoryGeneratorStoryLengthEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Short'
	String get short => 'Short';

	/// en: 'Medium'
	String get medium => 'Medium';

	/// en: 'Long'
	String get long => 'Long';

	/// en: 'Epic'
	String get epic => 'Epic';
}

// Path: storyGenerator.format
class TranslationsStoryGeneratorFormatEn {
	TranslationsStoryGeneratorFormatEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Narrative'
	String get narrative => 'Narrative';

	/// en: 'Dialogue-based'
	String get dialogue => 'Dialogue-based';

	/// en: 'Poetic'
	String get poetic => 'Poetic';

	/// en: 'Scriptural'
	String get scriptural => 'Scriptural';
}

// Path: storyGenerator.hints
class TranslationsStoryGeneratorHintsEn {
	TranslationsStoryGeneratorHintsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Tell me a story about Krishna teaching Arjuna...'
	String get krishnaTeaching => 'Tell me a story about Krishna teaching Arjuna...';

	/// en: 'Write an epic tale of a warrior seeking redemption...'
	String get warriorRedemption => 'Write an epic tale of a warrior seeking redemption...';

	/// en: 'Create a story about the wisdom of the sages...'
	String get sageWisdom => 'Create a story about the wisdom of the sages...';

	/// en: 'Narrate the journey of a devoted seeker...'
	String get devotedSeeker => 'Narrate the journey of a devoted seeker...';

	/// en: 'Share the legend of divine intervention...'
	String get divineIntervention => 'Share the legend of divine intervention...';
}

// Path: storyGenerator.errors
class TranslationsStoryGeneratorErrorsEn {
	TranslationsStoryGeneratorErrorsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Please complete all required options'
	String get incompletePrompt => 'Please complete all required options';

	/// en: 'Failed to generate story. Please try again.'
	String get generationFailed => 'Failed to generate story. Please try again.';
}

// Path: feed.tabs
class TranslationsFeedTabsEn {
	TranslationsFeedTabsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'All'
	String get all => 'All';

	/// en: 'Stories'
	String get stories => 'Stories';

	/// en: 'Images'
	String get images => 'Images';

	/// en: 'Thoughts'
	String get text => 'Thoughts';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.name' => 'MyItihas',
			'app.tagline' => 'Discover Indian Mythology',
			'common.ok' => 'OK',
			'common.cancel' => 'Cancel',
			'common.confirm' => 'Confirm',
			'common.delete' => 'Delete',
			'common.edit' => 'Edit',
			'common.save' => 'Save',
			'common.share' => 'Share',
			'common.search' => 'Search',
			'common.loading' => 'Loading...',
			'common.error' => 'Error',
			'common.retry' => 'Retry',
			'common.back' => 'Back',
			'common.next' => 'Next',
			'common.finish' => 'Finish',
			'common.skip' => 'Skip',
			'common.yes' => 'Yes',
			'common.no' => 'No',
			'common.read_full_story' => 'Read the full story',
			'navigation.home' => 'Home',
			'navigation.stories' => 'Stories',
			'navigation.chat' => 'Chat',
			'navigation.map' => 'Map',
			'navigation.community' => 'Community',
			'navigation.settings' => 'Settings',
			'navigation.profile' => 'Profile',
			'home.title' => 'MyItihas',
			'home.storyGenerator' => 'Story Generator',
			'home.chatItihas' => 'ChatItihas',
			'home.communityStories' => 'Community Stories',
			'home.maps' => 'Maps',
			'home.greetingMorning' => 'Good Morning',
			'home.continueReading' => 'Continue reading',
			'home.greetingAfternoon' => 'Good Afternoon',
			'home.greetingEvening' => 'Good Evening',
			'home.exploreStories' => 'Explore Stories',
			'home.generateStory' => 'Generate Story',
			'home.content' => 'Home Content',
			'stories.title' => 'Stories',
			'stories.searchHint' => 'Search by title or author...',
			'stories.sortBy' => 'Sort by',
			'stories.sortNewest' => 'Newest First',
			'stories.sortOldest' => 'Oldest First',
			'stories.sortPopular' => 'Most Popular',
			'stories.noStories' => 'No stories found',
			'stories.loadingStories' => 'Loading stories...',
			'stories.errorLoadingStories' => 'Failed to load stories',
			'stories.storyDetails' => 'Story Details',
			'stories.continueReading' => 'Continue reading',
			'stories.readMore' => 'Read More',
			'stories.readLess' => 'Read Less',
			'stories.author' => 'Author',
			'stories.publishedOn' => 'Published on',
			'stories.category' => 'Category',
			'stories.tags' => 'Tags',
			'stories.failed_to_load' => 'Failed to load story',
			'storyGenerator.title' => 'Story Generator',
			'storyGenerator.subtitle' => 'Create your own mythological story',
			'storyGenerator.quickStart' => 'Quick Start',
			'storyGenerator.interactive' => 'Interactive',
			'storyGenerator.rawPrompt' => 'Raw Prompt',
			'storyGenerator.yourStoryPrompt' => 'Your Story Prompt',
			'storyGenerator.writeYourPrompt' => 'Write Your Prompt',
			'storyGenerator.selectScripture' => 'Select Scripture',
			'storyGenerator.selectStoryType' => 'Select Story Type',
			'storyGenerator.selectCharacter' => 'Select Character',
			'storyGenerator.selectTheme' => 'Select Theme',
			'storyGenerator.selectSetting' => 'Select Setting',
			'storyGenerator.selectLanguage' => 'Select Language',
			'storyGenerator.selectLength' => 'Story Length',
			'storyGenerator.moreOptions' => 'More Options',
			'storyGenerator.random' => 'Random',
			'storyGenerator.generate' => 'Generate Story',
			'storyGenerator.generating' => 'Generating your story...',
			'storyGenerator.creatingYourStory' => 'Creating Your Story',
			'storyGenerator.consultingScriptures' => 'Consulting the ancient scriptures...',
			'storyGenerator.weavingTale' => 'Weaving your tale...',
			'storyGenerator.addingWisdom' => 'Adding divine wisdom...',
			'storyGenerator.polishingNarrative' => 'Polishing the narrative...',
			'storyGenerator.almostThere' => 'Almost there...',
			'storyGenerator.generatedStory' => 'Your Generated Story',
			'storyGenerator.aiGenerated' => 'AI Generated',
			'storyGenerator.regenerate' => 'Regenerate',
			'storyGenerator.saveStory' => 'Save Story',
			'storyGenerator.shareStory' => 'Share Story',
			'storyGenerator.newStory' => 'New Story',
			'storyGenerator.saved' => 'Saved',
			'storyGenerator.storySaved' => 'Story saved to your library',
			'storyGenerator.story' => 'Story',
			'storyGenerator.lesson' => 'Lesson',
			'storyGenerator.didYouKnow' => 'Did You Know?',
			'storyGenerator.activity' => 'Activity',
			'storyGenerator.optionalRefine' => 'Optional: Refine with options',
			'storyGenerator.applyOptions' => 'Apply Options',
			'storyGenerator.language' => 'Language',
			'storyGenerator.storyFormat' => 'Story Format',
			'storyGenerator.storyLength.short' => 'Short',
			'storyGenerator.storyLength.medium' => 'Medium',
			'storyGenerator.storyLength.long' => 'Long',
			'storyGenerator.storyLength.epic' => 'Epic',
			'storyGenerator.format.narrative' => 'Narrative',
			'storyGenerator.format.dialogue' => 'Dialogue-based',
			'storyGenerator.format.poetic' => 'Poetic',
			'storyGenerator.format.scriptural' => 'Scriptural',
			'storyGenerator.hints.krishnaTeaching' => 'Tell me a story about Krishna teaching Arjuna...',
			'storyGenerator.hints.warriorRedemption' => 'Write an epic tale of a warrior seeking redemption...',
			'storyGenerator.hints.sageWisdom' => 'Create a story about the wisdom of the sages...',
			'storyGenerator.hints.devotedSeeker' => 'Narrate the journey of a devoted seeker...',
			'storyGenerator.hints.divineIntervention' => 'Share the legend of divine intervention...',
			'storyGenerator.errors.incompletePrompt' => 'Please complete all required options',
			'storyGenerator.errors.generationFailed' => 'Failed to generate story. Please try again.',
			'chat.title' => 'ChatItihas',
			'chat.subtitle' => 'Chat with AI about mythology',
			'chat.friendMode' => 'Friend Mode',
			'chat.philosophicalMode' => 'Philosophical Mode',
			'chat.typeMessage' => 'Type your message...',
			'chat.send' => 'Send',
			'chat.newChat' => 'New Chat',
			'chat.chatHistory' => 'Chat History',
			'chat.clearChat' => 'Clear Chat',
			'chat.noMessages' => 'No messages yet. Start a conversation!',
			'chat.list_page' => 'Chat List Page',
			'map.title' => 'Akhanda Bharata',
			'map.subtitle' => 'Explore historical locations',
			'map.searchLocation' => 'Search location...',
			'map.viewDetails' => 'View Details',
			'map.showRoute' => 'Show Route',
			'map.historicalInfo' => 'Historical Information',
			'map.nearbyPlaces' => 'Nearby Places',
			'community.title' => 'Community',
			'community.trending' => 'Trending',
			'community.following' => 'Following',
			'community.followers' => 'Followers',
			'community.posts' => 'Posts',
			'community.follow' => 'Follow',
			'community.unfollow' => 'Unfollow',
			'community.shareYourStory' => 'Share your story...',
			'community.post' => 'Post',
			'community.like' => 'Like',
			'community.comment' => 'Comment',
			'community.comments' => 'Comments',
			'community.noPostsYet' => 'No posts yet',
			'settings.title' => 'Settings',
			'settings.language' => 'Language',
			'settings.theme' => 'Theme',
			'settings.themeLight' => 'Light',
			'settings.themeDark' => 'Dark',
			'settings.themeSystem' => 'System Default',
			'settings.notifications' => 'Notifications',
			'settings.account' => 'Account',
			'settings.privacy' => 'Privacy',
			'settings.about' => 'About',
			'settings.version' => 'Version',
			'settings.logout' => 'Logout',
			'auth.login' => 'Login',
			'auth.signup' => 'Sign Up',
			'auth.email' => 'Email',
			'auth.password' => 'Password',
			'auth.confirmPassword' => 'Confirm Password',
			'auth.forgotPassword' => 'Forgot Password?',
			'auth.resetPassword' => 'Reset Password',
			'auth.dontHaveAccount' => 'Don\'t have an account?',
			'auth.alreadyHaveAccount' => 'Already have an account?',
			'auth.loginSuccess' => 'Login successful',
			'auth.signupSuccess' => 'Sign up successful',
			'auth.loginError' => 'Login failed',
			'auth.signupError' => 'Sign up failed',
			'error.network' => 'No internet connection',
			'error.server' => 'Server error occurred',
			'error.cache' => 'Failed to load cached data',
			'error.timeout' => 'Request timed out',
			'error.notFound' => 'Resource not found',
			'error.validation' => 'Validation failed',
			'error.unexpected' => 'An unexpected error occurred',
			'error.tryAgain' => 'Please try again',
			'subscription.free' => 'Free',
			'subscription.plus' => 'Plus',
			'subscription.pro' => 'Pro',
			'subscription.upgradeToPro' => 'Upgrade to Pro',
			'subscription.features' => 'Features',
			'subscription.subscribe' => 'Subscribe',
			'subscription.currentPlan' => 'Current Plan',
			'subscription.managePlan' => 'Manage Plan',
			'notification.title' => 'Notifications',
			'notification.markAllRead' => 'Mark all read',
			'notification.noNotifications' => 'No notifications yet',
			'notification.errorPrefix' => 'Error:',
			'notification.retry' => 'Retry',
			'notification.likedYourStory' => '{{actorName}} liked your story',
			'notification.commentedOnYourStory' => '{{actorName}} commented on your story',
			'notification.repliedToYourComment' => '{{actorName}} replied to your comment',
			'notification.startedFollowingYou' => '{{actorName}} started following you',
			'notification.sentYouAMessage' => '{{actorName}} sent you a message',
			'profile.followers' => 'Followers',
			'profile.following' => 'Following',
			'profile.unfollow' => 'Unfollow',
			'profile.follow' => 'Follow',
			'profile.about' => 'About',
			'profile.stories' => 'Stories',
			'feed.loading' => 'Loading stories...',
			'feed.errorTitle' => 'Oops! Something went wrong',
			'feed.tryAgain' => 'Try Again',
			'feed.noStoriesAvailable' => 'No stories available',
			'feed.noImagesAvailable' => 'No image posts available',
			'feed.noTextPostsAvailable' => 'No text posts available',
			'feed.noContentAvailable' => 'No content available',
			'feed.refresh' => 'Refresh',
			'feed.comments' => 'Comments',
			'feed.commentsComingSoon' => 'Comments coming soon',
			'feed.addCommentHint' => 'Add a comment...',
			'feed.shareStory' => 'Share Story',
			'feed.sharePost' => 'Share Post',
			'feed.shareThought' => 'Share Thought',
			'feed.shareAsImage' => 'Share as Image',
			'feed.shareAsImageSubtitle' => 'Create a beautiful preview card',
			'feed.shareLink' => 'Share Link',
			'feed.shareLinkSubtitle' => 'Copy or share the story link',
			'feed.shareImageLinkSubtitle' => 'Copy or share the post link',
			'feed.shareTextLinkSubtitle' => 'Copy or share the thought link',
			'feed.shareAsText' => 'Share as Text',
			'feed.shareAsTextSubtitle' => 'Share the story excerpt',
			'feed.shareQuote' => 'Share Quote',
			'feed.shareQuoteSubtitle' => 'Share as a quotable text',
			'feed.shareWithImage' => 'Share with Image',
			'feed.shareWithImageSubtitle' => 'Share the image with caption',
			'feed.copyLink' => 'Copy Link',
			'feed.copyLinkSubtitle' => 'Copy link to clipboard',
			'feed.copyText' => 'Copy Text',
			'feed.copyTextSubtitle' => 'Copy the quote to clipboard',
			'feed.linkCopied' => 'Link copied to clipboard',
			'feed.textCopied' => 'Text copied to clipboard',
			'feed.sendToUser' => 'Send to User',
			'feed.sendToUserSubtitle' => 'Share directly with a friend',
			'feed.chooseFormat' => 'Choose Format',
			'feed.linkPreview' => 'Link Preview',
			'feed.linkPreviewSize' => '1200 × 630',
			'feed.storyFormat' => 'Story Format',
			'feed.storyFormatSize' => '1080 × 1920 (Instagram/Stories)',
			'feed.generatingPreview' => 'Generating preview...',
			'feed.bookmarked' => 'Bookmarked',
			'feed.removedFromBookmarks' => 'Removed from bookmarks',
			'feed.unlike' => 'Unlike, {{count}} likes',
			'feed.like' => 'Like, {{count}} likes',
			'feed.commentCount' => '{{count}} comments',
			'feed.shareCount' => 'Share, {{count}} shares',
			'feed.removeBookmark' => 'Remove bookmark',
			'feed.addBookmark' => 'Bookmark',
			'feed.quote' => 'Quote',
			'feed.quoteCopied' => 'Quote copied to clipboard',
			'feed.copy' => 'Copy',
			'feed.tapToViewFullQuote' => 'Tap to view full quote',
			'feed.quoteFromMyitihas' => 'Quote from MyItihas',
			'feed.tabs.all' => 'All',
			'feed.tabs.stories' => 'Stories',
			'feed.tabs.images' => 'Images',
			'feed.tabs.text' => 'Thoughts',
			_ => null,
		};
	}
}
