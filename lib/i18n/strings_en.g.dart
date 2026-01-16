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
		  );

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final TranslationsAppEn app = TranslationsAppEn.internal(_root);
	late final TranslationsCommonEn common = TranslationsCommonEn.internal(_root);
	late final TranslationsNavigationEn navigation = TranslationsNavigationEn.internal(_root);
	late final TranslationsHomeEn home = TranslationsHomeEn.internal(_root);
	late final TranslationsHomeScreenEn homeScreen = TranslationsHomeScreenEn.internal(_root);
	late final TranslationsStoriesEn stories = TranslationsStoriesEn.internal(_root);
	late final TranslationsStoryGeneratorEn storyGenerator = TranslationsStoryGeneratorEn.internal(_root);
	late final TranslationsChatEn chat = TranslationsChatEn.internal(_root);
	late final TranslationsMapEn map = TranslationsMapEn.internal(_root);
	late final TranslationsCommunityEn community = TranslationsCommunityEn.internal(_root);
	late final TranslationsSettingsEn settings = TranslationsSettingsEn.internal(_root);
	late final TranslationsAuthEn auth = TranslationsAuthEn.internal(_root);
	late final TranslationsErrorEn error = TranslationsErrorEn.internal(_root);
	late final TranslationsSubscriptionEn subscription = TranslationsSubscriptionEn.internal(_root);
	late final TranslationsNotificationEn notification = TranslationsNotificationEn.internal(_root);
	late final TranslationsProfileEn profile = TranslationsProfileEn.internal(_root);
	late final TranslationsFeedEn feed = TranslationsFeedEn.internal(_root);
}

// Path: app
class TranslationsAppEn {
	TranslationsAppEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'MyItihas'
	String get name => 'MyItihas';

	/// en: 'Discover Indian Mythology'
	String get tagline => 'Discover Indian Mythology';
}

// Path: common
class TranslationsCommonEn {
	TranslationsCommonEn.internal(this._root);

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
	String get readFullStory => 'Read the full story';
}

// Path: navigation
class TranslationsNavigationEn {
	TranslationsNavigationEn.internal(this._root);

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
	TranslationsHomeEn.internal(this._root);

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

// Path: homeScreen
class TranslationsHomeScreenEn {
	TranslationsHomeScreenEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Hello'
	String get greeting => 'Hello';

	/// en: 'Quote of the Day'
	String get quoteOfTheDay => 'Quote of the Day';

	/// en: 'Share Quote'
	String get shareQuote => 'Share Quote';

	/// en: 'Copy Quote'
	String get copyQuote => 'Copy Quote';

	/// en: 'Quote copied to clipboard'
	String get quoteCopied => 'Quote copied to clipboard';

	/// en: 'Featured Stories'
	String get featuredStories => 'Featured Stories';

	/// en: 'Quick Actions'
	String get quickActions => 'Quick Actions';

	/// en: 'Generate Story'
	String get generateStory => 'Generate Story';

	/// en: 'Chat with Krishna'
	String get chatWithKrishna => 'Chat with Krishna';

	/// en: 'My Activity'
	String get myActivity => 'My Activity';

	/// en: 'Continue Reading'
	String get continueReading => 'Continue Reading';

	/// en: 'Saved Stories'
	String get savedStories => 'Saved Stories';

	/// en: 'See All'
	String get seeAll => 'See All';

	/// en: 'Start Reading'
	String get startReading => 'Start Reading';

	/// en: 'Explore stories to start your journey'
	String get exploreStories => 'Explore stories to start your journey';

	/// en: 'Bookmark stories you love'
	String get saveForLater => 'Bookmark stories you love';

	/// en: 'No activity yet'
	String get noActivityYet => 'No activity yet';

	/// en: '{{count}} min left'
	String minLeft({required Object count}) => '${count} min left';

	/// en: 'Activity History'
	String get activityHistory => 'Activity History';

	/// en: 'Generated a story'
	String get storyGenerated => 'Generated a story';

	/// en: 'Read a story'
	String get storyRead => 'Read a story';

	/// en: 'Bookmarked a story'
	String get storyBookmarked => 'Bookmarked a story';

	/// en: 'Shared a story'
	String get storyShared => 'Shared a story';

	/// en: 'Completed a story'
	String get storyCompleted => 'Completed a story';

	/// en: 'Today'
	String get today => 'Today';

	/// en: 'Yesterday'
	String get yesterday => 'Yesterday';

	/// en: 'This Week'
	String get thisWeek => 'This Week';

	/// en: 'Earlier'
	String get earlier => 'Earlier';

	/// en: 'Nothing to read yet'
	String get noContinueReading => 'Nothing to read yet';

	/// en: 'No saved stories yet'
	String get noSavedStories => 'No saved stories yet';

	/// en: 'Bookmark stories to save them'
	String get bookmarkStoriesToSave => 'Bookmark stories to save them';

	/// en: 'My Stories'
	String get myGeneratedStories => 'My Stories';

	/// en: 'No stories created yet'
	String get noGeneratedStoriesYet => 'No stories created yet';

	/// en: 'Generate your first story using AI'
	String get createYourFirstStory => 'Generate your first story using AI';

	/// en: 'Share to Feed'
	String get shareToFeed => 'Share to Feed';

	/// en: 'Story shared to feed'
	String get sharedToFeed => 'Story shared to feed';

	/// en: 'Share Story'
	String get shareStoryTitle => 'Share Story';

	/// en: 'Add a caption for your story (optional)'
	String get shareStoryMessage => 'Add a caption for your story (optional)';

	/// en: 'Caption'
	String get shareStoryCaption => 'Caption';

	/// en: 'What would you like to say about this story?'
	String get shareStoryHint => 'What would you like to say about this story?';
}

// Path: stories
class TranslationsStoriesEn {
	TranslationsStoriesEn.internal(this._root);

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
	String get failedToLoad => 'Failed to load story';
}

// Path: storyGenerator
class TranslationsStoryGeneratorEn {
	TranslationsStoryGeneratorEn.internal(this._root);

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

	late final TranslationsStoryGeneratorStoryLengthEn storyLength = TranslationsStoryGeneratorStoryLengthEn.internal(_root);
	late final TranslationsStoryGeneratorFormatEn format = TranslationsStoryGeneratorFormatEn.internal(_root);
	late final TranslationsStoryGeneratorHintsEn hints = TranslationsStoryGeneratorHintsEn.internal(_root);
	late final TranslationsStoryGeneratorErrorsEn errors = TranslationsStoryGeneratorErrorsEn.internal(_root);
}

// Path: chat
class TranslationsChatEn {
	TranslationsChatEn.internal(this._root);

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
	String get listPage => 'Chat List Page';
}

// Path: map
class TranslationsMapEn {
	TranslationsMapEn.internal(this._root);

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
	TranslationsCommunityEn.internal(this._root);

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
	TranslationsSettingsEn.internal(this._root);

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
	TranslationsAuthEn.internal(this._root);

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
	TranslationsErrorEn.internal(this._root);

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
	TranslationsSubscriptionEn.internal(this._root);

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
	TranslationsNotificationEn.internal(this._root);

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
	String likedYourStory({required Object actorName}) => '${actorName} liked your story';

	/// en: '{{actorName}} commented on your story'
	String commentedOnYourStory({required Object actorName}) => '${actorName} commented on your story';

	/// en: '{{actorName}} replied to your comment'
	String repliedToYourComment({required Object actorName}) => '${actorName} replied to your comment';

	/// en: '{{actorName}} started following you'
	String startedFollowingYou({required Object actorName}) => '${actorName} started following you';

	/// en: '{{actorName}} sent you a message'
	String sentYouAMessage({required Object actorName}) => '${actorName} sent you a message';
}

// Path: profile
class TranslationsProfileEn {
	TranslationsProfileEn.internal(this._root);

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
	TranslationsFeedEn.internal(this._root);

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
	String unlike({required Object count}) => 'Unlike, ${count} likes';

	/// en: 'Like, {{count}} likes'
	String like({required Object count}) => 'Like, ${count} likes';

	/// en: '{{count}} comments'
	String commentCount({required Object count}) => '${count} comments';

	/// en: 'Share, {{count}} shares'
	String shareCount({required Object count}) => 'Share, ${count} shares';

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

	late final TranslationsFeedTabsEn tabs = TranslationsFeedTabsEn.internal(_root);

	/// en: 'Tap to show caption'
	String get tapToShowCaption => 'Tap to show caption';

	/// en: 'No videos available'
	String get noVideosAvailable => 'No videos available';
}

// Path: storyGenerator.storyLength
class TranslationsStoryGeneratorStoryLengthEn {
	TranslationsStoryGeneratorStoryLengthEn.internal(this._root);

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
	TranslationsStoryGeneratorFormatEn.internal(this._root);

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
	TranslationsStoryGeneratorHintsEn.internal(this._root);

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
	TranslationsStoryGeneratorErrorsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Please complete all required options'
	String get incompletePrompt => 'Please complete all required options';

	/// en: 'Failed to generate story. Please try again.'
	String get generationFailed => 'Failed to generate story. Please try again.';
}

// Path: feed.tabs
class TranslationsFeedTabsEn {
	TranslationsFeedTabsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'All'
	String get all => 'All';

	/// en: 'Stories'
	String get stories => 'Stories';

	/// en: 'Posts'
	String get posts => 'Posts';

	/// en: 'Videos'
	String get videos => 'Videos';

	/// en: 'Images'
	String get images => 'Images';

	/// en: 'Thoughts'
	String get text => 'Thoughts';
}
