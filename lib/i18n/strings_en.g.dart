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
	late final TranslationsStoriesEn stories = TranslationsStoriesEn.internal(_root);
	late final TranslationsStoryGeneratorEn story_generator = TranslationsStoryGeneratorEn.internal(_root);
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
	String get read_full_story => 'Read the full story';
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
	String get story_generator => 'Story Generator';

	/// en: 'ChatItihas'
	String get chat_itihas => 'ChatItihas';

	/// en: 'Community Stories'
	String get community_stories => 'Community Stories';

	/// en: 'Maps'
	String get maps => 'Maps';

	/// en: 'Good Morning'
	String get greeting_morning => 'Good Morning';

	/// en: 'Continue reading'
	String get continue_reading => 'Continue reading';

	/// en: 'Good Afternoon'
	String get greeting_afternoon => 'Good Afternoon';

	/// en: 'Good Evening'
	String get greeting_evening => 'Good Evening';

	/// en: 'Explore Stories'
	String get explore_stories => 'Explore Stories';

	/// en: 'Generate Story'
	String get generate_story => 'Generate Story';

	/// en: 'Home Content'
	String get content => 'Home Content';
}

// Path: stories
class TranslationsStoriesEn {
	TranslationsStoriesEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Stories'
	String get title => 'Stories';

	/// en: 'Search by title or author...'
	String get search_hint => 'Search by title or author...';

	/// en: 'Sort by'
	String get sort_by => 'Sort by';

	/// en: 'Newest First'
	String get sort_newest => 'Newest First';

	/// en: 'Oldest First'
	String get sort_oldest => 'Oldest First';

	/// en: 'Most Popular'
	String get sort_popular => 'Most Popular';

	/// en: 'No stories found'
	String get no_stories => 'No stories found';

	/// en: 'Loading stories...'
	String get loading_stories => 'Loading stories...';

	/// en: 'Failed to load stories'
	String get error_loading_stories => 'Failed to load stories';

	/// en: 'Story Details'
	String get story_details => 'Story Details';

	/// en: 'Continue reading'
	String get continue_reading => 'Continue reading';

	/// en: 'Read More'
	String get read_more => 'Read More';

	/// en: 'Read Less'
	String get read_less => 'Read Less';

	/// en: 'Author'
	String get author => 'Author';

	/// en: 'Published on'
	String get published_on => 'Published on';

	/// en: 'Category'
	String get category => 'Category';

	/// en: 'Tags'
	String get tags => 'Tags';

	/// en: 'Failed to load story'
	String get failed_to_load => 'Failed to load story';
}

// Path: story_generator
class TranslationsStoryGeneratorEn {
	TranslationsStoryGeneratorEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Story Generator'
	String get title => 'Story Generator';

	/// en: 'Create your own mythological story'
	String get subtitle => 'Create your own mythological story';

	/// en: 'Select Character'
	String get select_character => 'Select Character';

	/// en: 'Select Theme'
	String get select_theme => 'Select Theme';

	/// en: 'Select Language'
	String get select_language => 'Select Language';

	/// en: 'Story Length'
	String get select_length => 'Story Length';

	/// en: 'Generate Story'
	String get generate => 'Generate Story';

	/// en: 'Generating your story...'
	String get generating => 'Generating your story...';

	/// en: 'Your Generated Story'
	String get generated_story => 'Your Generated Story';

	/// en: 'Regenerate'
	String get regenerate => 'Regenerate';

	/// en: 'Save Story'
	String get save_story => 'Save Story';

	/// en: 'Share Story'
	String get share_story => 'Share Story';

	late final TranslationsStoryGeneratorStoryLengthEn story_length = TranslationsStoryGeneratorStoryLengthEn.internal(_root);
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
	String get friend_mode => 'Friend Mode';

	/// en: 'Philosophical Mode'
	String get philosophical_mode => 'Philosophical Mode';

	/// en: 'Type your message...'
	String get type_message => 'Type your message...';

	/// en: 'Send'
	String get send => 'Send';

	/// en: 'New Chat'
	String get new_chat => 'New Chat';

	/// en: 'Chat History'
	String get chat_history => 'Chat History';

	/// en: 'Clear Chat'
	String get clear_chat => 'Clear Chat';

	/// en: 'No messages yet. Start a conversation!'
	String get no_messages => 'No messages yet. Start a conversation!';

	/// en: 'Chat List Page'
	String get list_page => 'Chat List Page';
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
	String get search_location => 'Search location...';

	/// en: 'View Details'
	String get view_details => 'View Details';

	/// en: 'Show Route'
	String get show_route => 'Show Route';

	/// en: 'Historical Information'
	String get historical_info => 'Historical Information';

	/// en: 'Nearby Places'
	String get nearby_places => 'Nearby Places';
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
	String get share_your_story => 'Share your story...';

	/// en: 'Post'
	String get post => 'Post';

	/// en: 'Like'
	String get like => 'Like';

	/// en: 'Comment'
	String get comment => 'Comment';

	/// en: 'Comments'
	String get comments => 'Comments';

	/// en: 'No posts yet'
	String get no_posts_yet => 'No posts yet';
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
	String get theme_light => 'Light';

	/// en: 'Dark'
	String get theme_dark => 'Dark';

	/// en: 'System Default'
	String get theme_system => 'System Default';

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
	String get confirm_password => 'Confirm Password';

	/// en: 'Forgot Password?'
	String get forgot_password => 'Forgot Password?';

	/// en: 'Reset Password'
	String get reset_password => 'Reset Password';

	/// en: 'Don't have an account?'
	String get dont_have_account => 'Don\'t have an account?';

	/// en: 'Already have an account?'
	String get already_have_account => 'Already have an account?';

	/// en: 'Login successful'
	String get login_success => 'Login successful';

	/// en: 'Sign up successful'
	String get signup_success => 'Sign up successful';

	/// en: 'Login failed'
	String get login_error => 'Login failed';

	/// en: 'Sign up failed'
	String get signup_error => 'Sign up failed';
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
	String get not_found => 'Resource not found';

	/// en: 'Validation failed'
	String get validation => 'Validation failed';

	/// en: 'An unexpected error occurred'
	String get unexpected => 'An unexpected error occurred';

	/// en: 'Please try again'
	String get try_again => 'Please try again';
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
	String get upgrade_to_pro => 'Upgrade to Pro';

	/// en: 'Features'
	String get features => 'Features';

	/// en: 'Subscribe'
	String get subscribe => 'Subscribe';

	/// en: 'Current Plan'
	String get current_plan => 'Current Plan';

	/// en: 'Manage Plan'
	String get manage_plan => 'Manage Plan';
}

// Path: notification
class TranslationsNotificationEn {
	TranslationsNotificationEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Notifications'
	String get title => 'Notifications';

	/// en: 'Mark all read'
	String get mark_all_read => 'Mark all read';

	/// en: 'No notifications yet'
	String get no_notifications => 'No notifications yet';

	/// en: 'Error:'
	String get error_prefix => 'Error:';

	/// en: 'Retry'
	String get retry => 'Retry';

	/// en: '{{actorName}} liked your story'
	String liked_your_story({required Object ActorName}) => '${ActorName} liked your story';

	/// en: '{{actorName}} commented on your story'
	String commented_on_your_story({required Object ActorName}) => '${ActorName} commented on your story';

	/// en: '{{actorName}} replied to your comment'
	String replied_to_your_comment({required Object ActorName}) => '${ActorName} replied to your comment';

	/// en: '{{actorName}} started following you'
	String started_following_you({required Object ActorName}) => '${ActorName} started following you';

	/// en: '{{actorName}} sent you a message'
	String sent_you_a_message({required Object ActorName}) => '${ActorName} sent you a message';
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
	String get error_title => 'Oops! Something went wrong';

	/// en: 'Try Again'
	String get try_again => 'Try Again';

	/// en: 'No stories available'
	String get no_stories_available => 'No stories available';

	/// en: 'Refresh'
	String get refresh => 'Refresh';

	/// en: 'Comments'
	String get comments => 'Comments';

	/// en: 'Comments coming soon'
	String get comments_coming_soon => 'Comments coming soon';

	/// en: 'Add a comment...'
	String get add_comment_hint => 'Add a comment...';

	/// en: 'Share Story'
	String get share_story => 'Share Story';

	/// en: 'Share as Image'
	String get share_as_image => 'Share as Image';

	/// en: 'Create a beautiful preview card'
	String get share_as_image_subtitle => 'Create a beautiful preview card';

	/// en: 'Share Link'
	String get share_link => 'Share Link';

	/// en: 'Copy or share the story link'
	String get share_link_subtitle => 'Copy or share the story link';

	/// en: 'Share as Text'
	String get share_as_text => 'Share as Text';

	/// en: 'Share the story excerpt'
	String get share_as_text_subtitle => 'Share the story excerpt';

	/// en: 'Send to User'
	String get send_to_user => 'Send to User';

	/// en: 'Share directly with a friend'
	String get send_to_user_subtitle => 'Share directly with a friend';

	/// en: 'Choose Format'
	String get choose_format => 'Choose Format';

	/// en: 'Link Preview'
	String get link_preview => 'Link Preview';

	/// en: '1200 × 630'
	String get link_preview_size => '1200 × 630';

	/// en: 'Story Format'
	String get story_format => 'Story Format';

	/// en: '1080 × 1920 (Instagram/Stories)'
	String get story_format_size => '1080 × 1920 (Instagram/Stories)';

	/// en: 'Generating preview...'
	String get generating_preview => 'Generating preview...';

	/// en: 'Bookmarked'
	String get bookmarked => 'Bookmarked';

	/// en: 'Removed from bookmarks'
	String get removed_from_bookmarks => 'Removed from bookmarks';

	/// en: 'Unlike, {{count}} likes'
	String unlike({required Object Count}) => 'Unlike, ${Count} likes';

	/// en: 'Like, {{count}} likes'
	String like({required Object Count}) => 'Like, ${Count} likes';

	/// en: '{{count}} comments'
	String comment_count({required Object Count}) => '${Count} comments';

	/// en: 'Share, {{count}} shares'
	String share_count({required Object Count}) => 'Share, ${Count} shares';

	/// en: 'Remove bookmark'
	String get remove_bookmark => 'Remove bookmark';

	/// en: 'Bookmark'
	String get add_bookmark => 'Bookmark';

	/// en: 'Quote'
	String get quote => 'Quote';

	/// en: 'Quote copied to clipboard'
	String get quote_copied => 'Quote copied to clipboard';

	/// en: 'Copy'
	String get copy => 'Copy';

	/// en: 'Tap to view full quote'
	String get tap_to_view_full_quote => 'Tap to view full quote';

	/// en: 'Quote from MyItihas'
	String get quote_from_myitihas => 'Quote from MyItihas';
}

// Path: story_generator.story_length
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
}
