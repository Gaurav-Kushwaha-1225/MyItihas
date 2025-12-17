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
class TranslationsHi extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsHi({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.hi,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver);

	/// Metadata for the translations of <hi>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	late final TranslationsHi _root = this; // ignore: unused_field

	@override 
	TranslationsHi $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsHi(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsAppHi app = _TranslationsAppHi._(_root);
	@override late final _TranslationsCommonHi common = _TranslationsCommonHi._(_root);
	@override late final _TranslationsNavigationHi navigation = _TranslationsNavigationHi._(_root);
	@override late final _TranslationsHomeHi home = _TranslationsHomeHi._(_root);
	@override late final _TranslationsStoriesHi stories = _TranslationsStoriesHi._(_root);
	@override late final _TranslationsStoryGeneratorHi story_generator = _TranslationsStoryGeneratorHi._(_root);
	@override late final _TranslationsChatHi chat = _TranslationsChatHi._(_root);
	@override late final _TranslationsMapHi map = _TranslationsMapHi._(_root);
	@override late final _TranslationsCommunityHi community = _TranslationsCommunityHi._(_root);
	@override late final _TranslationsSettingsHi settings = _TranslationsSettingsHi._(_root);
	@override late final _TranslationsAuthHi auth = _TranslationsAuthHi._(_root);
	@override late final _TranslationsErrorHi error = _TranslationsErrorHi._(_root);
	@override late final _TranslationsSubscriptionHi subscription = _TranslationsSubscriptionHi._(_root);
	@override late final _TranslationsNotificationHi notification = _TranslationsNotificationHi._(_root);
	@override late final _TranslationsProfileHi profile = _TranslationsProfileHi._(_root);
	@override late final _TranslationsFeedHi feed = _TranslationsFeedHi._(_root);
}

// Path: app
class _TranslationsAppHi extends TranslationsAppEn {
	_TranslationsAppHi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get name => 'मायइतिहास';
	@override String get tagline => 'भारतीय पौराणिक कथाएं खोजें';
}

// Path: common
class _TranslationsCommonHi extends TranslationsCommonEn {
	_TranslationsCommonHi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get ok => 'ठीक है';
	@override String get cancel => 'रद्द करें';
	@override String get confirm => 'पुष्टि करें';
	@override String get delete => 'हटाएं';
	@override String get edit => 'संपादित करें';
	@override String get save => 'सहेजें';
	@override String get share => 'साझा करें';
	@override String get search => 'खोजें';
	@override String get loading => 'लोड हो रहा है...';
	@override String get error => 'त्रुटि';
	@override String get retry => 'पुनः प्रयास करें';
	@override String get back => 'वापस';
	@override String get next => 'अगला';
	@override String get finish => 'समाप्त';
	@override String get skip => 'छोड़ें';
	@override String get yes => 'हां';
	@override String get no => 'नहीं';
	@override String get read_full_story => 'पूरी कहानी पढ़ें';
}

// Path: navigation
class _TranslationsNavigationHi extends TranslationsNavigationEn {
	_TranslationsNavigationHi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get home => 'होम';
	@override String get stories => 'कहानियां';
	@override String get chat => 'चैट';
	@override String get map => 'मानचित्र';
	@override String get community => 'समुदाय';
	@override String get settings => 'सेटिंग्स';
	@override String get profile => 'प्रोफाइल';
}

// Path: home
class _TranslationsHomeHi extends TranslationsHomeEn {
	_TranslationsHomeHi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'मायइतिहास';
	@override String get story_generator => 'कहानी जनरेटर';
	@override String get chat_itihas => 'चैटइतिहास';
	@override String get community_stories => 'सामुदायिक कहानियां';
	@override String get maps => 'मानचित्र';
	@override String get greeting_morning => 'सुप्रभात';
	@override String get continue_reading => 'पढ़ना जारी रखें';
	@override String get greeting_afternoon => 'नमस्कार';
	@override String get greeting_evening => 'शुभ संध्या';
	@override String get explore_stories => 'कहानियां खोजें';
	@override String get generate_story => 'कहानी बनाएं';
	@override String get content => 'होम सामग्री';
}

// Path: stories
class _TranslationsStoriesHi extends TranslationsStoriesEn {
	_TranslationsStoriesHi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'कहानियां';
	@override String get search_hint => 'शीर्षक या लेखक से खोजें...';
	@override String get sort_by => 'क्रमबद्ध करें';
	@override String get sort_newest => 'नवीनतम पहले';
	@override String get sort_oldest => 'पुरानी पहले';
	@override String get sort_popular => 'सबसे लोकप्रिय';
	@override String get no_stories => 'कोई कहानी नहीं मिली';
	@override String get loading_stories => 'कहानियां लोड हो रही हैं...';
	@override String get error_loading_stories => 'कहानियां लोड करने में विफल';
	@override String get story_details => 'कहानी विवरण';
	@override String get continue_reading => 'पढ़ना जारी रखें';
	@override String get read_more => 'और पढ़ें';
	@override String get read_less => 'कम पढ़ें';
	@override String get author => 'लेखक';
	@override String get published_on => 'प्रकाशित';
	@override String get category => 'श्रेणी';
	@override String get tags => 'टैग';
	@override String get failed_to_load => 'कहानी लोड करने में विफल';
}

// Path: story_generator
class _TranslationsStoryGeneratorHi extends TranslationsStoryGeneratorEn {
	_TranslationsStoryGeneratorHi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'कहानी जनरेटर';
	@override String get subtitle => 'अपनी पौराणिक कहानी बनाएं';
	@override String get select_character => 'पात्र चुनें';
	@override String get select_theme => 'विषय चुनें';
	@override String get select_language => 'भाषा चुनें';
	@override String get select_length => 'कहानी की लंबाई';
	@override String get generate => 'कहानी बनाएं';
	@override String get generating => 'आपकी कहानी बन रही है...';
	@override String get generated_story => 'आपकी बनाई कहानी';
	@override String get regenerate => 'फिर से बनाएं';
	@override String get save_story => 'कहानी सहेजें';
	@override String get share_story => 'कहानी साझा करें';
	@override late final _TranslationsStoryGeneratorStoryLengthHi story_length = _TranslationsStoryGeneratorStoryLengthHi._(_root);
}

// Path: chat
class _TranslationsChatHi extends TranslationsChatEn {
	_TranslationsChatHi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'चैटइतिहास';
	@override String get subtitle => 'पौराणिक कथाओं के बारे में AI से चैट करें';
	@override String get friend_mode => 'मित्र मोड';
	@override String get philosophical_mode => 'दार्शनिक मोड';
	@override String get type_message => 'अपना संदेश लिखें...';
	@override String get send => 'भेजें';
	@override String get new_chat => 'नई चैट';
	@override String get chat_history => 'चैट इतिहास';
	@override String get clear_chat => 'चैट साफ़ करें';
	@override String get no_messages => 'अभी तक कोई संदेश नहीं। बातचीत शुरू करें!';
	@override String get list_page => 'चैट सूची पृष्ठ';
}

// Path: map
class _TranslationsMapHi extends TranslationsMapEn {
	_TranslationsMapHi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'अखंड भारत';
	@override String get subtitle => 'ऐतिहासिक स्थानों का अन्वेषण करें';
	@override String get search_location => 'स्थान खोजें...';
	@override String get view_details => 'विवरण देखें';
	@override String get show_route => 'मार्ग दिखाएं';
	@override String get historical_info => 'ऐतिहासिक जानकारी';
	@override String get nearby_places => 'निकटवर्ती स्थान';
}

// Path: community
class _TranslationsCommunityHi extends TranslationsCommunityEn {
	_TranslationsCommunityHi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'समुदाय';
	@override String get trending => 'ट्रेंडिंग';
	@override String get following => 'फॉलोइंग';
	@override String get followers => 'फॉलोवर्स';
	@override String get posts => 'पोस्ट';
	@override String get follow => 'फॉलो करें';
	@override String get unfollow => 'अनफॉलो करें';
	@override String get share_your_story => 'अपनी कहानी साझा करें...';
	@override String get post => 'पोस्ट करें';
	@override String get like => 'पसंद';
	@override String get comment => 'टिप्पणी';
	@override String get comments => 'टिप्पणियां';
	@override String get no_posts_yet => 'अभी तक कोई पोस्ट नहीं';
}

// Path: settings
class _TranslationsSettingsHi extends TranslationsSettingsEn {
	_TranslationsSettingsHi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'सेटिंग्स';
	@override String get language => 'भाषा';
	@override String get theme => 'थीम';
	@override String get theme_light => 'लाइट';
	@override String get theme_dark => 'डार्क';
	@override String get theme_system => 'सिस्टम डिफ़ॉल्ट';
	@override String get notifications => 'सूचनाएं';
	@override String get account => 'खाता';
	@override String get privacy => 'गोपनीयता';
	@override String get about => 'हमारे बारे में';
	@override String get version => 'संस्करण';
	@override String get logout => 'लॉग आउट';
}

// Path: auth
class _TranslationsAuthHi extends TranslationsAuthEn {
	_TranslationsAuthHi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get login => 'लॉगिन';
	@override String get signup => 'साइन अप';
	@override String get email => 'ईमेल';
	@override String get password => 'पासवर्ड';
	@override String get confirm_password => 'पासवर्ड की पुष्टि करें';
	@override String get forgot_password => 'पासवर्ड भूल गए?';
	@override String get reset_password => 'पासवर्ड रीसेट करें';
	@override String get dont_have_account => 'खाता नहीं है?';
	@override String get already_have_account => 'पहले से खाता है?';
	@override String get login_success => 'लॉगिन सफल';
	@override String get signup_success => 'साइन अप सफल';
	@override String get login_error => 'लॉगिन विफल';
	@override String get signup_error => 'साइन अप विफल';
}

// Path: error
class _TranslationsErrorHi extends TranslationsErrorEn {
	_TranslationsErrorHi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get network => 'इंटरनेट कनेक्शन नहीं है';
	@override String get server => 'सर्वर त्रुटि हुई';
	@override String get cache => 'कैश्ड डेटा लोड करने में विफल';
	@override String get timeout => 'अनुरोध समय समाप्त';
	@override String get not_found => 'संसाधन नहीं मिला';
	@override String get validation => 'सत्यापन विफल';
	@override String get unexpected => 'एक अप्रत्याशित त्रुटि हुई';
	@override String get try_again => 'कृपया पुनः प्रयास करें';
}

// Path: subscription
class _TranslationsSubscriptionHi extends TranslationsSubscriptionEn {
	_TranslationsSubscriptionHi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get free => 'मुफ़्त';
	@override String get plus => 'प्लस';
	@override String get pro => 'प्रो';
	@override String get upgrade_to_pro => 'प्रो में अपग्रेड करें';
	@override String get features => 'सुविधाएँ';
	@override String get subscribe => 'सदस्यता लें';
	@override String get current_plan => 'वर्तमान योजना';
	@override String get manage_plan => 'योजना प्रबंधित करें';
}

// Path: notification
class _TranslationsNotificationHi extends TranslationsNotificationEn {
	_TranslationsNotificationHi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'सूचनाएं';
	@override String get mark_all_read => 'सभी को पढ़ा हुआ मार्क करें';
	@override String get no_notifications => 'अभी तक कोई सूचना नहीं';
	@override String get error_prefix => 'त्रुटि:';
	@override String get retry => 'पुनः प्रयास करें';
	@override String liked_your_story({required Object ActorName}) => '${ActorName} ने आपकी कहानी को लाइक किया';
	@override String commented_on_your_story({required Object ActorName}) => '${ActorName} ने आपकी कहानी पर टिप्पणी की';
	@override String replied_to_your_comment({required Object ActorName}) => '${ActorName} ने आपके कमेंट का जवाब दिया';
	@override String started_following_you({required Object ActorName}) => '${ActorName} ने आपको फॉलो करना शुरू किया';
	@override String sent_you_a_message({required Object ActorName}) => '${ActorName} ने आपको एक संदेश भेजा';
}

// Path: profile
class _TranslationsProfileHi extends TranslationsProfileEn {
	_TranslationsProfileHi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get followers => 'फॉलोअर्स';
	@override String get following => 'फॉलोइंग';
	@override String get unfollow => 'अनफॉलो करें';
	@override String get follow => 'फॉलो करें';
	@override String get about => 'के बारे में';
	@override String get stories => 'कहानियाँ';
}

// Path: feed
class _TranslationsFeedHi extends TranslationsFeedEn {
	_TranslationsFeedHi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get loading => 'कहानियाँ लोड हो रही हैं...';
	@override String get error_title => 'अरे! कुछ गलत हो गया';
	@override String get try_again => 'फिर से प्रयास करें';
	@override String get no_stories_available => 'कोई कहानी उपलब्ध नहीं';
	@override String get refresh => 'रिफ्रेश';
	@override String get comments => 'टिप्पणियाँ';
	@override String get comments_coming_soon => 'टिप्पणियाँ जल्द ही आ रही हैं';
	@override String get add_comment_hint => 'टिप्पणी जोड़ें...';
	@override String get share_story => 'कहानी साझा करें';
	@override String get share_as_image => 'चित्र के रूप में साझा करें';
	@override String get share_as_image_subtitle => 'एक सुंदर पूर्वावलोकन कार्ड बनाएं';
	@override String get share_link => 'लिंक साझा करें';
	@override String get share_link_subtitle => 'कहानी लिंक कॉपी या साझा करें';
	@override String get share_as_text => 'पाठ के रूप में साझा करें';
	@override String get share_as_text_subtitle => 'कहानी के अंश साझा करें';
	@override String get send_to_user => 'उपयोगकर्ता को भेजें';
	@override String get send_to_user_subtitle => 'सीधे मित्र के साथ साझा करें';
	@override String get choose_format => 'प्रारूप चुनें';
	@override String get link_preview => 'लिंक पूर्वावलोकन';
	@override String get link_preview_size => '1200 × 630';
	@override String get story_format => 'स्टोरी प्रारूप';
	@override String get story_format_size => '1080 × 1920 (Instagram/Stories)';
	@override String get generating_preview => 'पूर्वावलोकन तैयार किया जा रहा है...';
	@override String get bookmarked => 'बुकमार्क किया गया';
	@override String get removed_from_bookmarks => 'बुकमार्क से हटाया गया';
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
class _TranslationsStoryGeneratorStoryLengthHi extends TranslationsStoryGeneratorStoryLengthEn {
	_TranslationsStoryGeneratorStoryLengthHi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get short => 'छोटी';
	@override String get medium => 'मध्यम';
	@override String get long => 'लंबी';
}
