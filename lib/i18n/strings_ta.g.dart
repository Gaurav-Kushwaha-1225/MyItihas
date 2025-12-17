///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsTa extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsTa({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.ta,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver);

	/// Metadata for the translations of <ta>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	late final TranslationsTa _root = this; // ignore: unused_field

	@override 
	TranslationsTa $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsTa(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsAppTa app = _TranslationsAppTa._(_root);
	@override late final _TranslationsCommonTa common = _TranslationsCommonTa._(_root);
	@override late final _TranslationsNavigationTa navigation = _TranslationsNavigationTa._(_root);
	@override late final _TranslationsHomeTa home = _TranslationsHomeTa._(_root);
	@override late final _TranslationsStoriesTa stories = _TranslationsStoriesTa._(_root);
	@override late final _TranslationsStoryGeneratorTa story_generator = _TranslationsStoryGeneratorTa._(_root);
	@override late final _TranslationsChatTa chat = _TranslationsChatTa._(_root);
	@override late final _TranslationsMapTa map = _TranslationsMapTa._(_root);
	@override late final _TranslationsCommunityTa community = _TranslationsCommunityTa._(_root);
	@override late final _TranslationsSettingsTa settings = _TranslationsSettingsTa._(_root);
	@override late final _TranslationsAuthTa auth = _TranslationsAuthTa._(_root);
	@override late final _TranslationsErrorTa error = _TranslationsErrorTa._(_root);
	@override late final _TranslationsSubscriptionTa subscription = _TranslationsSubscriptionTa._(_root);
	@override late final _TranslationsNotificationTa notification = _TranslationsNotificationTa._(_root);
	@override late final _TranslationsProfileTa profile = _TranslationsProfileTa._(_root);
	@override late final _TranslationsFeedTa feed = _TranslationsFeedTa._(_root);
}

// Path: app
class _TranslationsAppTa extends TranslationsAppEn {
	_TranslationsAppTa._(TranslationsTa root) : this._root = root, super.internal(root);

	final TranslationsTa _root; // ignore: unused_field

	// Translations
	@override String get name => 'மைஇதிஹாஸ்';
	@override String get tagline => 'இந்திய புராணங்களைக் கண்டறியவும்';
}

// Path: common
class _TranslationsCommonTa extends TranslationsCommonEn {
	_TranslationsCommonTa._(TranslationsTa root) : this._root = root, super.internal(root);

	final TranslationsTa _root; // ignore: unused_field

	// Translations
	@override String get ok => 'சரி';
	@override String get cancel => 'ரத்துசெய்';
	@override String get confirm => 'உறுதிப்படுத்து';
	@override String get delete => 'நீக்கு';
	@override String get edit => 'திருத்து';
	@override String get save => 'சேமி';
	@override String get share => 'பகிர்';
	@override String get search => 'தேடு';
	@override String get loading => 'ஏற்றுகிறது...';
	@override String get error => 'பிழை';
	@override String get retry => 'மீண்டும் முயற்சி';
	@override String get back => 'பின்';
	@override String get next => 'அடுத்து';
	@override String get finish => 'முடி';
	@override String get skip => 'தவிர்';
	@override String get yes => 'ஆம்';
	@override String get no => 'இல்லை';
	@override String get read_full_story => 'Read the full story';
}

// Path: navigation
class _TranslationsNavigationTa extends TranslationsNavigationEn {
	_TranslationsNavigationTa._(TranslationsTa root) : this._root = root, super.internal(root);

	final TranslationsTa _root; // ignore: unused_field

	// Translations
	@override String get home => 'முகப்பு';
	@override String get stories => 'கதைகள்';
	@override String get chat => 'அரட்டை';
	@override String get map => 'வரைபடம்';
	@override String get community => 'சமூகம்';
	@override String get settings => 'அமைப்புகள்';
	@override String get profile => 'சுயவிவரம்';
}

// Path: home
class _TranslationsHomeTa extends TranslationsHomeEn {
	_TranslationsHomeTa._(TranslationsTa root) : this._root = root, super.internal(root);

	final TranslationsTa _root; // ignore: unused_field

	// Translations
	@override String get title => 'மைஇதிஹாஸ்';
	@override String get story_generator => 'கதை உருவாக்கி';
	@override String get chat_itihas => 'அரட்டைஇதிஹாஸ்';
	@override String get community_stories => 'சமூக கதைகள்';
	@override String get maps => 'வரைபடங்கள்';
	@override String get greeting_morning => 'காலை வணக்கம்';
	@override String get continue_reading => 'படிப்பதைத் தொடரவும்';
	@override String get greeting_afternoon => 'மதிய வணக்கம்';
	@override String get greeting_evening => 'மாலை வணக்கம்';
	@override String get explore_stories => 'கதைகளை ஆராயுங்கள்';
	@override String get generate_story => 'கதை உருவாக்கு';
	@override String get content => 'Home Content';
}

// Path: stories
class _TranslationsStoriesTa extends TranslationsStoriesEn {
	_TranslationsStoriesTa._(TranslationsTa root) : this._root = root, super.internal(root);

	final TranslationsTa _root; // ignore: unused_field

	// Translations
	@override String get title => 'கதைகள்';
	@override String get search_hint => 'தலைப்பு அல்லது ஆசிரியரால் தேடவும்...';
	@override String get sort_by => 'வரிசைப்படுத்து';
	@override String get sort_newest => 'புதியது முதலில்';
	@override String get sort_oldest => 'பழையது முதலில்';
	@override String get sort_popular => 'மிகவும் பிரபலமான';
	@override String get no_stories => 'கதைகள் எதுவும் இல்லை';
	@override String get loading_stories => 'கதைகள் ஏற்றப்படுகின்றன...';
	@override String get error_loading_stories => 'கதைகளை ஏற்ற முடியவில்லை';
	@override String get story_details => 'கதை விவரங்கள்';
	@override String get continue_reading => 'படிப்பதைத் தொடரவும்';
	@override String get read_more => 'மேலும் படிக்க';
	@override String get read_less => 'குறைவாக படிக்க';
	@override String get author => 'ஆசிரியர்';
	@override String get published_on => 'வெளியிடப்பட்டது';
	@override String get category => 'வகை';
	@override String get tags => 'குறிச்சொற்கள்';
	@override String get failed_to_load => 'Failed to load story';
}

// Path: story_generator
class _TranslationsStoryGeneratorTa extends TranslationsStoryGeneratorEn {
	_TranslationsStoryGeneratorTa._(TranslationsTa root) : this._root = root, super.internal(root);

	final TranslationsTa _root; // ignore: unused_field

	// Translations
	@override String get title => 'கதை உருவாக்கி';
	@override String get subtitle => 'உங்கள் சொந்த புராண கதையை உருவாக்குங்கள்';
	@override String get select_character => 'பாத்திரத்தைத் தேர்ந்தெடுக்கவும்';
	@override String get select_theme => 'தீம் தேர்ந்தெடுக்கவும்';
	@override String get select_language => 'மொழி தேர்ந்தெடுக்கவும்';
	@override String get select_length => 'கதை நீளம்';
	@override String get generate => 'கதை உருவாக்கு';
	@override String get generating => 'உங்கள் கதை உருவாக்கப்படுகிறது...';
	@override String get generated_story => 'உங்கள் உருவாக்கிய கதை';
	@override String get regenerate => 'மீண்டும் உருவாக்கு';
	@override String get save_story => 'கதையைச் சேமி';
	@override String get share_story => 'கதையைப் பகிர்';
	@override late final _TranslationsStoryGeneratorStoryLengthTa story_length = _TranslationsStoryGeneratorStoryLengthTa._(_root);
}

// Path: chat
class _TranslationsChatTa extends TranslationsChatEn {
	_TranslationsChatTa._(TranslationsTa root) : this._root = root, super.internal(root);

	final TranslationsTa _root; // ignore: unused_field

	// Translations
	@override String get title => 'அரட்டைஇதிஹாஸ்';
	@override String get subtitle => 'புராணங்கள் பற்றி AI உடன் அரட்டையடிக்கவும்';
	@override String get friend_mode => 'நண்பர் பயன்முறை';
	@override String get philosophical_mode => 'தத்துவ பயன்முறை';
	@override String get type_message => 'உங்கள் செய்தியை தட்டச்சு செய்யவும்...';
	@override String get send => 'அனுப்பு';
	@override String get new_chat => 'புதிய அரட்டை';
	@override String get chat_history => 'அரட்டை வரலாறு';
	@override String get clear_chat => 'அரட்டையை அழி';
	@override String get no_messages => 'இன்னும் செய்திகள் இல்லை. உரையாடலைத் தொடங்குங்கள்!';
	@override String get list_page => 'Chat List Page';
}

// Path: map
class _TranslationsMapTa extends TranslationsMapEn {
	_TranslationsMapTa._(TranslationsTa root) : this._root = root, super.internal(root);

	final TranslationsTa _root; // ignore: unused_field

	// Translations
	@override String get title => 'அகண்ட பாரதம்';
	@override String get subtitle => 'வரலாற்று இடங்களை ஆராயுங்கள்';
	@override String get search_location => 'இடத்தைத் தேடு...';
	@override String get view_details => 'விவரங்களைக் காண்க';
	@override String get show_route => 'பாதையைக் காட்டு';
	@override String get historical_info => 'வரலாற்று தகவல்';
	@override String get nearby_places => 'அருகிலுள்ள இடங்கள்';
}

// Path: community
class _TranslationsCommunityTa extends TranslationsCommunityEn {
	_TranslationsCommunityTa._(TranslationsTa root) : this._root = root, super.internal(root);

	final TranslationsTa _root; // ignore: unused_field

	// Translations
	@override String get title => 'சமூகம்';
	@override String get trending => 'டிரெண்டிங்';
	@override String get following => 'பின்தொடர்தல்';
	@override String get followers => 'பின்தொடர்பவர்கள்';
	@override String get posts => 'இடுகைகள்';
	@override String get follow => 'பின்தொடர்';
	@override String get unfollow => 'பின்தொடர்வதை நிறுத்து';
	@override String get share_your_story => 'உங்கள் கதையைப் பகிர்ந்து கொள்ளுங்கள்...';
	@override String get post => 'இடுகை';
	@override String get like => 'விருப்பம்';
	@override String get comment => 'கருத்து';
	@override String get comments => 'கருத்துகள்';
	@override String get no_posts_yet => 'இன்னும் இடுகைகள் இல்லை';
}

// Path: settings
class _TranslationsSettingsTa extends TranslationsSettingsEn {
	_TranslationsSettingsTa._(TranslationsTa root) : this._root = root, super.internal(root);

	final TranslationsTa _root; // ignore: unused_field

	// Translations
	@override String get title => 'அமைப்புகள்';
	@override String get language => 'மொழி';
	@override String get theme => 'தீம்';
	@override String get theme_light => 'வெளிச்சம்';
	@override String get theme_dark => 'இருள்';
	@override String get theme_system => 'கணினி இயல்புநிலை';
	@override String get notifications => 'அறிவிப்புகள்';
	@override String get account => 'கணக்கு';
	@override String get privacy => 'தனியுரிமை';
	@override String get about => 'எங்களைப் பற்றி';
	@override String get version => 'பதிப்பு';
	@override String get logout => 'வெளியேறு';
}

// Path: auth
class _TranslationsAuthTa extends TranslationsAuthEn {
	_TranslationsAuthTa._(TranslationsTa root) : this._root = root, super.internal(root);

	final TranslationsTa _root; // ignore: unused_field

	// Translations
	@override String get login => 'உள்நுழை';
	@override String get signup => 'பதிவு செய்யவும்';
	@override String get email => 'மின்னஞ்சல்';
	@override String get password => 'கடவுச்சொல்';
	@override String get confirm_password => 'கடவுச்சொல்லை உறுதிப்படுத்தவும்';
	@override String get forgot_password => 'கடவுச்சொல்லை மறந்துவிட்டீர்களா?';
	@override String get reset_password => 'கடவுச்சொல்லை மீட்டமை';
	@override String get dont_have_account => 'கணக்கு இல்லையா?';
	@override String get already_have_account => 'ஏற்கனவே கணக்கு உள்ளதா?';
	@override String get login_success => 'உள்நுழைவு வெற்றிகரமாக';
	@override String get signup_success => 'பதிவு வெற்றிகரமாக';
	@override String get login_error => 'உள்நுழைவு தோல்வியடைந்தது';
	@override String get signup_error => 'பதிவு தோல்வியடைந்தது';
}

// Path: error
class _TranslationsErrorTa extends TranslationsErrorEn {
	_TranslationsErrorTa._(TranslationsTa root) : this._root = root, super.internal(root);

	final TranslationsTa _root; // ignore: unused_field

	// Translations
	@override String get network => 'இணைய இணைப்பு இல்லை';
	@override String get server => 'சேவையக பிழை ஏற்பட்டது';
	@override String get cache => 'கேச் செய்யப்பட்ட தரவை ஏற்ற முடியவில்லை';
	@override String get timeout => 'கோரிக்கை காலாவதியானது';
	@override String get not_found => 'வளம் கண்டுபிடிக்கப்படவில்லை';
	@override String get validation => 'சரிபார்ப்பு தோல்வியடைந்தது';
	@override String get unexpected => 'எதிர்பாராத பிழை ஏற்பட்டது';
	@override String get try_again => 'மீண்டும் முயற்சிக்கவும்';
}

// Path: subscription
class _TranslationsSubscriptionTa extends TranslationsSubscriptionEn {
	_TranslationsSubscriptionTa._(TranslationsTa root) : this._root = root, super.internal(root);

	final TranslationsTa _root; // ignore: unused_field

	// Translations
	@override String get free => 'இலவசம்';
	@override String get plus => 'பிளஸ்';
	@override String get pro => 'ப்ரோ';
	@override String get upgrade_to_pro => 'ப்ரோவிற்கு மேம்படுத்தவும்';
	@override String get features => 'அம்சங்கள்';
	@override String get subscribe => 'குழுசேர்';
	@override String get current_plan => 'தற்போதைய திட்டம்';
	@override String get manage_plan => 'திட்டத்தை நிர்வகிக்கவும்';
}

// Path: notification
class _TranslationsNotificationTa extends TranslationsNotificationEn {
	_TranslationsNotificationTa._(TranslationsTa root) : this._root = root, super.internal(root);

	final TranslationsTa _root; // ignore: unused_field

	// Translations
	@override String get title => 'அறிவிப்புகள்';
	@override String get mark_all_read => 'அனைத்தையும் படித்ததாக குறிக்கவும்';
	@override String get no_notifications => 'இன்னும் அறிவிப்புகள் இல்லை';
	@override String get error_prefix => 'பிழை:';
	@override String get retry => 'மீண்டும் முயற்சிக்கவும்';
	@override String liked_your_story({required Object ActorName}) => '${ActorName} உங்கள் கதையை விரும்பினார்';
	@override String commented_on_your_story({required Object ActorName}) => '${ActorName} உங்கள் கதையில் கருத்து தெரிவித்தார்';
	@override String replied_to_your_comment({required Object ActorName}) => '${ActorName} உங்கள் கருத்துக்கு பதிலளித்தார்';
	@override String started_following_you({required Object ActorName}) => '${ActorName} உங்களை பின்தொடரத் தொடங்கினார்';
	@override String sent_you_a_message({required Object ActorName}) => '${ActorName} உங்களுக்கு ஒரு செய்தியை அனுப்பினார்';
}

// Path: profile
class _TranslationsProfileTa extends TranslationsProfileEn {
	_TranslationsProfileTa._(TranslationsTa root) : this._root = root, super.internal(root);

	final TranslationsTa _root; // ignore: unused_field

	// Translations
	@override String get followers => 'பின்தொடர்பவர்கள்';
	@override String get following => 'பின்தொடர்பவர்கள்';
	@override String get unfollow => 'பின்தொடர்வதை நிறுத்து';
	@override String get follow => 'பின்தொடர்';
	@override String get about => 'பற்றி';
	@override String get stories => 'கதைகள்';
}

// Path: feed
class _TranslationsFeedTa extends TranslationsFeedEn {
	_TranslationsFeedTa._(TranslationsTa root) : this._root = root, super.internal(root);

	final TranslationsTa _root; // ignore: unused_field

	// Translations
	@override String get loading => 'கதைகள் ஏற்றப்படுகிறது...';
	@override String get error_title => 'அப்பா! ஏதோ தவறு நடந்தது';
	@override String get try_again => 'மீண்டும் முயற்சிக்கவும்';
	@override String get no_stories_available => 'கதைகள் எதுவும் இல்லை';
	@override String get refresh => 'புதுப்பிக்க';
	@override String get comments => 'கருத்துகள்';
	@override String get comments_coming_soon => 'கருத்துகள் விரைவில் வருகிறது';
	@override String get add_comment_hint => 'கருத்தைச் சேர்க்கவும்...';
	@override String get share_story => 'கதையை பகிரவும்';
	@override String get share_as_image => 'படமாக பகிரவும்';
	@override String get share_as_image_subtitle => 'அழகான முன்னோட்ட அட்டையை உருவாக்கவும்';
	@override String get share_link => 'இணைப்பை பகிரவும்';
	@override String get share_link_subtitle => 'கதை இணைப்பை நகலெடுக்க அல்லது பகிரவும்';
	@override String get share_as_text => 'உரையாக பகிரவும்';
	@override String get share_as_text_subtitle => 'கதையின் சுருக்கத்தை பகிரவும்';
	@override String get send_to_user => 'பயனருக்கு அனுப்பவும்';
	@override String get send_to_user_subtitle => 'நண்பருடன் நேரடியாக பகிரவும்';
	@override String get choose_format => 'வடிவத்தைத் தேர்ந்தெடுக்கவும்';
	@override String get link_preview => 'இணைப்பு முன்னோட்டம்';
	@override String get link_preview_size => '1200 × 630';
	@override String get story_format => 'ஸ்டோரி வடிவம்';
	@override String get story_format_size => '1080 × 1920 (Instagram/Stories)';
	@override String get generating_preview => 'முன்னோட்டம் உருவாக்கப்படுகிறது...';
	@override String get bookmarked => 'புக் மார்க் செய்யப்பட்டது';
	@override String get removed_from_bookmarks => 'புக் மார்கிலிருந்து நீக்கப்பட்டது';
	@override String unlike({required Object Count}) => 'Unlike, ${Count} likes';
	@override String like({required Object Count}) => 'Like, ${Count} likes';
	@override String comment_count({required Object Count}) => '${Count} comments';
	@override String share_count({required Object Count}) => 'Share, ${Count} shares';
	@override String get remove_bookmark => 'Remove bookmark';
	@override String get add_bookmark => 'Bookmark';
	@override String get quote => 'Quote';
	@override String get quote_copied => 'Quote copied to clipboard';
	@override String get copy => 'Copy';
	@override String get tap_to_view_full_quote => 'Tap to view full quote';
	@override String get quote_from_myitihas => 'Quote from MyItihas';
}

// Path: story_generator.story_length
class _TranslationsStoryGeneratorStoryLengthTa extends TranslationsStoryGeneratorStoryLengthEn {
	_TranslationsStoryGeneratorStoryLengthTa._(TranslationsTa root) : this._root = root, super.internal(root);

	final TranslationsTa _root; // ignore: unused_field

	// Translations
	@override String get short => 'குறுகிய';
	@override String get medium => 'நடுத்தர';
	@override String get long => 'நீண்ட';
}
