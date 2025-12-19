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
class TranslationsTa with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsTa({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.ta,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <ta>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsTa _root = this; // ignore: unused_field

	@override 
	TranslationsTa $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsTa(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsAppTa app = _TranslationsAppTa._(_root);
	@override late final _TranslationsCommonTa common = _TranslationsCommonTa._(_root);
	@override late final _TranslationsNavigationTa navigation = _TranslationsNavigationTa._(_root);
	@override late final _TranslationsHomeTa home = _TranslationsHomeTa._(_root);
	@override late final _TranslationsStoriesTa stories = _TranslationsStoriesTa._(_root);
	@override late final _TranslationsStoryGeneratorTa storyGenerator = _TranslationsStoryGeneratorTa._(_root);
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
class _TranslationsAppTa implements TranslationsAppEn {
	_TranslationsAppTa._(this._root);

	final TranslationsTa _root; // ignore: unused_field

	// Translations
	@override String get name => 'மைஇதிஹாஸ்';
	@override String get tagline => 'இந்திய புராணங்களைக் கண்டறியவும்';
}

// Path: common
class _TranslationsCommonTa implements TranslationsCommonEn {
	_TranslationsCommonTa._(this._root);

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
class _TranslationsNavigationTa implements TranslationsNavigationEn {
	_TranslationsNavigationTa._(this._root);

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
class _TranslationsHomeTa implements TranslationsHomeEn {
	_TranslationsHomeTa._(this._root);

	final TranslationsTa _root; // ignore: unused_field

	// Translations
	@override String get title => 'மைஇதிஹாஸ்';
	@override String get storyGenerator => 'கதை உருவாக்கி';
	@override String get chatItihas => 'அரட்டைஇதிஹாஸ்';
	@override String get communityStories => 'சமூக கதைகள்';
	@override String get maps => 'வரைபடங்கள்';
	@override String get greetingMorning => 'காலை வணக்கம்';
	@override String get continueReading => 'படிப்பதைத் தொடரவும்';
	@override String get greetingAfternoon => 'மதிய வணக்கம்';
	@override String get greetingEvening => 'மாலை வணக்கம்';
	@override String get exploreStories => 'கதைகளை ஆராயுங்கள்';
	@override String get generateStory => 'கதை உருவாக்கு';
	@override String get content => 'Home Content';
}

// Path: stories
class _TranslationsStoriesTa implements TranslationsStoriesEn {
	_TranslationsStoriesTa._(this._root);

	final TranslationsTa _root; // ignore: unused_field

	// Translations
	@override String get title => 'கதைகள்';
	@override String get searchHint => 'தலைப்பு அல்லது ஆசிரியரால் தேடவும்...';
	@override String get sortBy => 'வரிசைப்படுத்து';
	@override String get sortNewest => 'புதியது முதலில்';
	@override String get sortOldest => 'பழையது முதலில்';
	@override String get sortPopular => 'மிகவும் பிரபலமான';
	@override String get noStories => 'கதைகள் எதுவும் இல்லை';
	@override String get loadingStories => 'கதைகள் ஏற்றப்படுகின்றன...';
	@override String get errorLoadingStories => 'கதைகளை ஏற்ற முடியவில்லை';
	@override String get storyDetails => 'கதை விவரங்கள்';
	@override String get continueReading => 'படிப்பதைத் தொடரவும்';
	@override String get readMore => 'மேலும் படிக்க';
	@override String get readLess => 'குறைவாக படிக்க';
	@override String get author => 'ஆசிரியர்';
	@override String get publishedOn => 'வெளியிடப்பட்டது';
	@override String get category => 'வகை';
	@override String get tags => 'குறிச்சொற்கள்';
	@override String get failed_to_load => 'Failed to load story';
}

// Path: storyGenerator
class _TranslationsStoryGeneratorTa implements TranslationsStoryGeneratorEn {
	_TranslationsStoryGeneratorTa._(this._root);

	final TranslationsTa _root; // ignore: unused_field

	// Translations
	@override String get title => 'கதை உருவாக்கி';
	@override String get subtitle => 'உங்கள் சொந்த புராண கதையை உருவாக்குங்கள்';
	@override String get selectCharacter => 'பாத்திரத்தைத் தேர்ந்தெடுக்கவும்';
	@override String get selectTheme => 'தீம் தேர்ந்தெடுக்கவும்';
	@override String get selectLanguage => 'மொழி தேர்ந்தெடுக்கவும்';
	@override String get selectLength => 'கதை நீளம்';
	@override String get generate => 'கதை உருவாக்கு';
	@override String get generating => 'உங்கள் கதை உருவாக்கப்படுகிறது...';
	@override String get generatedStory => 'உங்கள் உருவாக்கிய கதை';
	@override String get regenerate => 'மீண்டும் உருவாக்கு';
	@override String get saveStory => 'கதையைச் சேமி';
	@override String get shareStory => 'கதையைப் பகிர்';
	@override late final _TranslationsStoryGeneratorStoryLengthTa storyLength = _TranslationsStoryGeneratorStoryLengthTa._(_root);
}

// Path: chat
class _TranslationsChatTa implements TranslationsChatEn {
	_TranslationsChatTa._(this._root);

	final TranslationsTa _root; // ignore: unused_field

	// Translations
	@override String get title => 'அரட்டைஇதிஹாஸ்';
	@override String get subtitle => 'புராணங்கள் பற்றி AI உடன் அரட்டையடிக்கவும்';
	@override String get friendMode => 'நண்பர் பயன்முறை';
	@override String get philosophicalMode => 'தத்துவ பயன்முறை';
	@override String get typeMessage => 'உங்கள் செய்தியை தட்டச்சு செய்யவும்...';
	@override String get send => 'அனுப்பு';
	@override String get newChat => 'புதிய அரட்டை';
	@override String get chatHistory => 'அரட்டை வரலாறு';
	@override String get clearChat => 'அரட்டையை அழி';
	@override String get noMessages => 'இன்னும் செய்திகள் இல்லை. உரையாடலைத் தொடங்குங்கள்!';
	@override String get list_page => 'Chat List Page';
}

// Path: map
class _TranslationsMapTa implements TranslationsMapEn {
	_TranslationsMapTa._(this._root);

	final TranslationsTa _root; // ignore: unused_field

	// Translations
	@override String get title => 'அகண்ட பாரதம்';
	@override String get subtitle => 'வரலாற்று இடங்களை ஆராயுங்கள்';
	@override String get searchLocation => 'இடத்தைத் தேடு...';
	@override String get viewDetails => 'விவரங்களைக் காண்க';
	@override String get showRoute => 'பாதையைக் காட்டு';
	@override String get historicalInfo => 'வரலாற்று தகவல்';
	@override String get nearbyPlaces => 'அருகிலுள்ள இடங்கள்';
}

// Path: community
class _TranslationsCommunityTa implements TranslationsCommunityEn {
	_TranslationsCommunityTa._(this._root);

	final TranslationsTa _root; // ignore: unused_field

	// Translations
	@override String get title => 'சமூகம்';
	@override String get trending => 'டிரெண்டிங்';
	@override String get following => 'பின்தொடர்தல்';
	@override String get followers => 'பின்தொடர்பவர்கள்';
	@override String get posts => 'இடுகைகள்';
	@override String get follow => 'பின்தொடர்';
	@override String get unfollow => 'பின்தொடர்வதை நிறுத்து';
	@override String get shareYourStory => 'உங்கள் கதையைப் பகிர்ந்து கொள்ளுங்கள்...';
	@override String get post => 'இடுகை';
	@override String get like => 'விருப்பம்';
	@override String get comment => 'கருத்து';
	@override String get comments => 'கருத்துகள்';
	@override String get noPostsYet => 'இன்னும் இடுகைகள் இல்லை';
}

// Path: settings
class _TranslationsSettingsTa implements TranslationsSettingsEn {
	_TranslationsSettingsTa._(this._root);

	final TranslationsTa _root; // ignore: unused_field

	// Translations
	@override String get title => 'அமைப்புகள்';
	@override String get language => 'மொழி';
	@override String get theme => 'தீம்';
	@override String get themeLight => 'வெளிச்சம்';
	@override String get themeDark => 'இருள்';
	@override String get themeSystem => 'கணினி இயல்புநிலை';
	@override String get notifications => 'அறிவிப்புகள்';
	@override String get account => 'கணக்கு';
	@override String get privacy => 'தனியுரிமை';
	@override String get about => 'எங்களைப் பற்றி';
	@override String get version => 'பதிப்பு';
	@override String get logout => 'வெளியேறு';
}

// Path: auth
class _TranslationsAuthTa implements TranslationsAuthEn {
	_TranslationsAuthTa._(this._root);

	final TranslationsTa _root; // ignore: unused_field

	// Translations
	@override String get login => 'உள்நுழை';
	@override String get signup => 'பதிவு செய்யவும்';
	@override String get email => 'மின்னஞ்சல்';
	@override String get password => 'கடவுச்சொல்';
	@override String get confirmPassword => 'கடவுச்சொல்லை உறுதிப்படுத்தவும்';
	@override String get forgotPassword => 'கடவுச்சொல்லை மறந்துவிட்டீர்களா?';
	@override String get resetPassword => 'கடவுச்சொல்லை மீட்டமை';
	@override String get dontHaveAccount => 'கணக்கு இல்லையா?';
	@override String get alreadyHaveAccount => 'ஏற்கனவே கணக்கு உள்ளதா?';
	@override String get loginSuccess => 'உள்நுழைவு வெற்றிகரமாக';
	@override String get signupSuccess => 'பதிவு வெற்றிகரமாக';
	@override String get loginError => 'உள்நுழைவு தோல்வியடைந்தது';
	@override String get signupError => 'பதிவு தோல்வியடைந்தது';
}

// Path: error
class _TranslationsErrorTa implements TranslationsErrorEn {
	_TranslationsErrorTa._(this._root);

	final TranslationsTa _root; // ignore: unused_field

	// Translations
	@override String get network => 'இணைய இணைப்பு இல்லை';
	@override String get server => 'சேவையக பிழை ஏற்பட்டது';
	@override String get cache => 'கேச் செய்யப்பட்ட தரவை ஏற்ற முடியவில்லை';
	@override String get timeout => 'கோரிக்கை காலாவதியானது';
	@override String get notFound => 'வளம் கண்டுபிடிக்கப்படவில்லை';
	@override String get validation => 'சரிபார்ப்பு தோல்வியடைந்தது';
	@override String get unexpected => 'எதிர்பாராத பிழை ஏற்பட்டது';
	@override String get tryAgain => 'மீண்டும் முயற்சிக்கவும்';
}

// Path: subscription
class _TranslationsSubscriptionTa implements TranslationsSubscriptionEn {
	_TranslationsSubscriptionTa._(this._root);

	final TranslationsTa _root; // ignore: unused_field

	// Translations
	@override String get free => 'இலவசம்';
	@override String get plus => 'பிளஸ்';
	@override String get pro => 'ப்ரோ';
	@override String get upgradeToPro => 'ப்ரோவிற்கு மேம்படுத்தவும்';
	@override String get features => 'அம்சங்கள்';
	@override String get subscribe => 'குழுசேர்';
	@override String get currentPlan => 'தற்போதைய திட்டம்';
	@override String get managePlan => 'திட்டத்தை நிர்வகிக்கவும்';
}

// Path: notification
class _TranslationsNotificationTa implements TranslationsNotificationEn {
	_TranslationsNotificationTa._(this._root);

	final TranslationsTa _root; // ignore: unused_field

	// Translations
	@override String get title => 'அறிவிப்புகள்';
	@override String get markAllRead => 'அனைத்தையும் படித்ததாக குறிக்கவும்';
	@override String get noNotifications => 'இன்னும் அறிவிப்புகள் இல்லை';
	@override String get errorPrefix => 'பிழை:';
	@override String get retry => 'மீண்டும் முயற்சிக்கவும்';
	@override String get likedYourStory => '{{actorName}} உங்கள் கதையை விரும்பினார்';
	@override String get commentedOnYourStory => '{{actorName}} உங்கள் கதையில் கருத்து தெரிவித்தார்';
	@override String get repliedToYourComment => '{{actorName}} உங்கள் கருத்துக்கு பதிலளித்தார்';
	@override String get startedFollowingYou => '{{actorName}} உங்களை பின்தொடரத் தொடங்கினார்';
	@override String get sentYouAMessage => '{{actorName}} உங்களுக்கு ஒரு செய்தியை அனுப்பினார்';
}

// Path: profile
class _TranslationsProfileTa implements TranslationsProfileEn {
	_TranslationsProfileTa._(this._root);

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
class _TranslationsFeedTa implements TranslationsFeedEn {
	_TranslationsFeedTa._(this._root);

	final TranslationsTa _root; // ignore: unused_field

	// Translations
	@override String get loading => 'கதைகள் ஏற்றப்படுகிறது...';
	@override String get errorTitle => 'அப்பா! ஏதோ தவறு நடந்தது';
	@override String get tryAgain => 'மீண்டும் முயற்சிக்கவும்';
	@override String get noStoriesAvailable => 'கதைகள் எதுவும் இல்லை';
	@override String get refresh => 'புதுப்பிக்க';
	@override String get comments => 'கருத்துகள்';
	@override String get commentsComingSoon => 'கருத்துகள் விரைவில் வருகிறது';
	@override String get addCommentHint => 'கருத்தைச் சேர்க்கவும்...';
	@override String get shareStory => 'கதையை பகிரவும்';
	@override String get shareAsImage => 'படமாக பகிரவும்';
	@override String get shareAsImageSubtitle => 'அழகான முன்னோட்ட அட்டையை உருவாக்கவும்';
	@override String get shareLink => 'இணைப்பை பகிரவும்';
	@override String get shareLinkSubtitle => 'கதை இணைப்பை நகலெடுக்க அல்லது பகிரவும்';
	@override String get shareAsText => 'உரையாக பகிரவும்';
	@override String get shareAsTextSubtitle => 'கதையின் சுருக்கத்தை பகிரவும்';
	@override String get sendToUser => 'பயனருக்கு அனுப்பவும்';
	@override String get sendToUserSubtitle => 'நண்பருடன் நேரடியாக பகிரவும்';
	@override String get chooseFormat => 'வடிவத்தைத் தேர்ந்தெடுக்கவும்';
	@override String get linkPreview => 'இணைப்பு முன்னோட்டம்';
	@override String get linkPreviewSize => '1200 × 630';
	@override String get storyFormat => 'ஸ்டோரி வடிவம்';
	@override String get storyFormatSize => '1080 × 1920 (Instagram/Stories)';
	@override String get generatingPreview => 'முன்னோட்டம் உருவாக்கப்படுகிறது...';
	@override String get bookmarked => 'புக் மார்க் செய்யப்பட்டது';
	@override String get removedFromBookmarks => 'புக் மார்கிலிருந்து நீக்கப்பட்டது';
	@override String get unlike => 'Unlike, {{count}} likes';
	@override String get like => 'Like, {{count}} likes';
	@override String get commentCount => '{{count}} comments';
	@override String get shareCount => 'Share, {{count}} shares';
	@override String get removeBookmark => 'Remove bookmark';
	@override String get addBookmark => 'Bookmark';
	@override String get quote => 'Quote';
	@override String get quoteCopied => 'Quote copied to clipboard';
	@override String get copy => 'Copy';
	@override String get tapToViewFullQuote => 'Tap to view full quote';
	@override String get quoteFromMyitihas => 'Quote from MyItihas';
}

// Path: storyGenerator.storyLength
class _TranslationsStoryGeneratorStoryLengthTa implements TranslationsStoryGeneratorStoryLengthEn {
	_TranslationsStoryGeneratorStoryLengthTa._(this._root);

	final TranslationsTa _root; // ignore: unused_field

	// Translations
	@override String get short => 'குறுகிய';
	@override String get medium => 'நடுத்தர';
	@override String get long => 'நீண்ட';
}

/// The flat map containing all translations for locale <ta>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsTa {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.name' => 'மைஇதிஹாஸ்',
			'app.tagline' => 'இந்திய புராணங்களைக் கண்டறியவும்',
			'common.ok' => 'சரி',
			'common.cancel' => 'ரத்துசெய்',
			'common.confirm' => 'உறுதிப்படுத்து',
			'common.delete' => 'நீக்கு',
			'common.edit' => 'திருத்து',
			'common.save' => 'சேமி',
			'common.share' => 'பகிர்',
			'common.search' => 'தேடு',
			'common.loading' => 'ஏற்றுகிறது...',
			'common.error' => 'பிழை',
			'common.retry' => 'மீண்டும் முயற்சி',
			'common.back' => 'பின்',
			'common.next' => 'அடுத்து',
			'common.finish' => 'முடி',
			'common.skip' => 'தவிர்',
			'common.yes' => 'ஆம்',
			'common.no' => 'இல்லை',
			'common.read_full_story' => 'Read the full story',
			'navigation.home' => 'முகப்பு',
			'navigation.stories' => 'கதைகள்',
			'navigation.chat' => 'அரட்டை',
			'navigation.map' => 'வரைபடம்',
			'navigation.community' => 'சமூகம்',
			'navigation.settings' => 'அமைப்புகள்',
			'navigation.profile' => 'சுயவிவரம்',
			'home.title' => 'மைஇதிஹாஸ்',
			'home.storyGenerator' => 'கதை உருவாக்கி',
			'home.chatItihas' => 'அரட்டைஇதிஹாஸ்',
			'home.communityStories' => 'சமூக கதைகள்',
			'home.maps' => 'வரைபடங்கள்',
			'home.greetingMorning' => 'காலை வணக்கம்',
			'home.continueReading' => 'படிப்பதைத் தொடரவும்',
			'home.greetingAfternoon' => 'மதிய வணக்கம்',
			'home.greetingEvening' => 'மாலை வணக்கம்',
			'home.exploreStories' => 'கதைகளை ஆராயுங்கள்',
			'home.generateStory' => 'கதை உருவாக்கு',
			'home.content' => 'Home Content',
			'stories.title' => 'கதைகள்',
			'stories.searchHint' => 'தலைப்பு அல்லது ஆசிரியரால் தேடவும்...',
			'stories.sortBy' => 'வரிசைப்படுத்து',
			'stories.sortNewest' => 'புதியது முதலில்',
			'stories.sortOldest' => 'பழையது முதலில்',
			'stories.sortPopular' => 'மிகவும் பிரபலமான',
			'stories.noStories' => 'கதைகள் எதுவும் இல்லை',
			'stories.loadingStories' => 'கதைகள் ஏற்றப்படுகின்றன...',
			'stories.errorLoadingStories' => 'கதைகளை ஏற்ற முடியவில்லை',
			'stories.storyDetails' => 'கதை விவரங்கள்',
			'stories.continueReading' => 'படிப்பதைத் தொடரவும்',
			'stories.readMore' => 'மேலும் படிக்க',
			'stories.readLess' => 'குறைவாக படிக்க',
			'stories.author' => 'ஆசிரியர்',
			'stories.publishedOn' => 'வெளியிடப்பட்டது',
			'stories.category' => 'வகை',
			'stories.tags' => 'குறிச்சொற்கள்',
			'stories.failed_to_load' => 'Failed to load story',
			'storyGenerator.title' => 'கதை உருவாக்கி',
			'storyGenerator.subtitle' => 'உங்கள் சொந்த புராண கதையை உருவாக்குங்கள்',
			'storyGenerator.selectCharacter' => 'பாத்திரத்தைத் தேர்ந்தெடுக்கவும்',
			'storyGenerator.selectTheme' => 'தீம் தேர்ந்தெடுக்கவும்',
			'storyGenerator.selectLanguage' => 'மொழி தேர்ந்தெடுக்கவும்',
			'storyGenerator.selectLength' => 'கதை நீளம்',
			'storyGenerator.generate' => 'கதை உருவாக்கு',
			'storyGenerator.generating' => 'உங்கள் கதை உருவாக்கப்படுகிறது...',
			'storyGenerator.generatedStory' => 'உங்கள் உருவாக்கிய கதை',
			'storyGenerator.regenerate' => 'மீண்டும் உருவாக்கு',
			'storyGenerator.saveStory' => 'கதையைச் சேமி',
			'storyGenerator.shareStory' => 'கதையைப் பகிர்',
			'storyGenerator.storyLength.short' => 'குறுகிய',
			'storyGenerator.storyLength.medium' => 'நடுத்தர',
			'storyGenerator.storyLength.long' => 'நீண்ட',
			'chat.title' => 'அரட்டைஇதிஹாஸ்',
			'chat.subtitle' => 'புராணங்கள் பற்றி AI உடன் அரட்டையடிக்கவும்',
			'chat.friendMode' => 'நண்பர் பயன்முறை',
			'chat.philosophicalMode' => 'தத்துவ பயன்முறை',
			'chat.typeMessage' => 'உங்கள் செய்தியை தட்டச்சு செய்யவும்...',
			'chat.send' => 'அனுப்பு',
			'chat.newChat' => 'புதிய அரட்டை',
			'chat.chatHistory' => 'அரட்டை வரலாறு',
			'chat.clearChat' => 'அரட்டையை அழி',
			'chat.noMessages' => 'இன்னும் செய்திகள் இல்லை. உரையாடலைத் தொடங்குங்கள்!',
			'chat.list_page' => 'Chat List Page',
			'map.title' => 'அகண்ட பாரதம்',
			'map.subtitle' => 'வரலாற்று இடங்களை ஆராயுங்கள்',
			'map.searchLocation' => 'இடத்தைத் தேடு...',
			'map.viewDetails' => 'விவரங்களைக் காண்க',
			'map.showRoute' => 'பாதையைக் காட்டு',
			'map.historicalInfo' => 'வரலாற்று தகவல்',
			'map.nearbyPlaces' => 'அருகிலுள்ள இடங்கள்',
			'community.title' => 'சமூகம்',
			'community.trending' => 'டிரெண்டிங்',
			'community.following' => 'பின்தொடர்தல்',
			'community.followers' => 'பின்தொடர்பவர்கள்',
			'community.posts' => 'இடுகைகள்',
			'community.follow' => 'பின்தொடர்',
			'community.unfollow' => 'பின்தொடர்வதை நிறுத்து',
			'community.shareYourStory' => 'உங்கள் கதையைப் பகிர்ந்து கொள்ளுங்கள்...',
			'community.post' => 'இடுகை',
			'community.like' => 'விருப்பம்',
			'community.comment' => 'கருத்து',
			'community.comments' => 'கருத்துகள்',
			'community.noPostsYet' => 'இன்னும் இடுகைகள் இல்லை',
			'settings.title' => 'அமைப்புகள்',
			'settings.language' => 'மொழி',
			'settings.theme' => 'தீம்',
			'settings.themeLight' => 'வெளிச்சம்',
			'settings.themeDark' => 'இருள்',
			'settings.themeSystem' => 'கணினி இயல்புநிலை',
			'settings.notifications' => 'அறிவிப்புகள்',
			'settings.account' => 'கணக்கு',
			'settings.privacy' => 'தனியுரிமை',
			'settings.about' => 'எங்களைப் பற்றி',
			'settings.version' => 'பதிப்பு',
			'settings.logout' => 'வெளியேறு',
			'auth.login' => 'உள்நுழை',
			'auth.signup' => 'பதிவு செய்யவும்',
			'auth.email' => 'மின்னஞ்சல்',
			'auth.password' => 'கடவுச்சொல்',
			'auth.confirmPassword' => 'கடவுச்சொல்லை உறுதிப்படுத்தவும்',
			'auth.forgotPassword' => 'கடவுச்சொல்லை மறந்துவிட்டீர்களா?',
			'auth.resetPassword' => 'கடவுச்சொல்லை மீட்டமை',
			'auth.dontHaveAccount' => 'கணக்கு இல்லையா?',
			'auth.alreadyHaveAccount' => 'ஏற்கனவே கணக்கு உள்ளதா?',
			'auth.loginSuccess' => 'உள்நுழைவு வெற்றிகரமாக',
			'auth.signupSuccess' => 'பதிவு வெற்றிகரமாக',
			'auth.loginError' => 'உள்நுழைவு தோல்வியடைந்தது',
			'auth.signupError' => 'பதிவு தோல்வியடைந்தது',
			'error.network' => 'இணைய இணைப்பு இல்லை',
			'error.server' => 'சேவையக பிழை ஏற்பட்டது',
			'error.cache' => 'கேச் செய்யப்பட்ட தரவை ஏற்ற முடியவில்லை',
			'error.timeout' => 'கோரிக்கை காலாவதியானது',
			'error.notFound' => 'வளம் கண்டுபிடிக்கப்படவில்லை',
			'error.validation' => 'சரிபார்ப்பு தோல்வியடைந்தது',
			'error.unexpected' => 'எதிர்பாராத பிழை ஏற்பட்டது',
			'error.tryAgain' => 'மீண்டும் முயற்சிக்கவும்',
			'subscription.free' => 'இலவசம்',
			'subscription.plus' => 'பிளஸ்',
			'subscription.pro' => 'ப்ரோ',
			'subscription.upgradeToPro' => 'ப்ரோவிற்கு மேம்படுத்தவும்',
			'subscription.features' => 'அம்சங்கள்',
			'subscription.subscribe' => 'குழுசேர்',
			'subscription.currentPlan' => 'தற்போதைய திட்டம்',
			'subscription.managePlan' => 'திட்டத்தை நிர்வகிக்கவும்',
			'notification.title' => 'அறிவிப்புகள்',
			'notification.markAllRead' => 'அனைத்தையும் படித்ததாக குறிக்கவும்',
			'notification.noNotifications' => 'இன்னும் அறிவிப்புகள் இல்லை',
			'notification.errorPrefix' => 'பிழை:',
			'notification.retry' => 'மீண்டும் முயற்சிக்கவும்',
			'notification.likedYourStory' => '{{actorName}} உங்கள் கதையை விரும்பினார்',
			'notification.commentedOnYourStory' => '{{actorName}} உங்கள் கதையில் கருத்து தெரிவித்தார்',
			'notification.repliedToYourComment' => '{{actorName}} உங்கள் கருத்துக்கு பதிலளித்தார்',
			'notification.startedFollowingYou' => '{{actorName}} உங்களை பின்தொடரத் தொடங்கினார்',
			'notification.sentYouAMessage' => '{{actorName}} உங்களுக்கு ஒரு செய்தியை அனுப்பினார்',
			'profile.followers' => 'பின்தொடர்பவர்கள்',
			'profile.following' => 'பின்தொடர்பவர்கள்',
			'profile.unfollow' => 'பின்தொடர்வதை நிறுத்து',
			'profile.follow' => 'பின்தொடர்',
			'profile.about' => 'பற்றி',
			'profile.stories' => 'கதைகள்',
			'feed.loading' => 'கதைகள் ஏற்றப்படுகிறது...',
			'feed.errorTitle' => 'அப்பா! ஏதோ தவறு நடந்தது',
			'feed.tryAgain' => 'மீண்டும் முயற்சிக்கவும்',
			'feed.noStoriesAvailable' => 'கதைகள் எதுவும் இல்லை',
			'feed.refresh' => 'புதுப்பிக்க',
			'feed.comments' => 'கருத்துகள்',
			'feed.commentsComingSoon' => 'கருத்துகள் விரைவில் வருகிறது',
			'feed.addCommentHint' => 'கருத்தைச் சேர்க்கவும்...',
			'feed.shareStory' => 'கதையை பகிரவும்',
			'feed.shareAsImage' => 'படமாக பகிரவும்',
			'feed.shareAsImageSubtitle' => 'அழகான முன்னோட்ட அட்டையை உருவாக்கவும்',
			'feed.shareLink' => 'இணைப்பை பகிரவும்',
			'feed.shareLinkSubtitle' => 'கதை இணைப்பை நகலெடுக்க அல்லது பகிரவும்',
			'feed.shareAsText' => 'உரையாக பகிரவும்',
			'feed.shareAsTextSubtitle' => 'கதையின் சுருக்கத்தை பகிரவும்',
			'feed.sendToUser' => 'பயனருக்கு அனுப்பவும்',
			'feed.sendToUserSubtitle' => 'நண்பருடன் நேரடியாக பகிரவும்',
			'feed.chooseFormat' => 'வடிவத்தைத் தேர்ந்தெடுக்கவும்',
			'feed.linkPreview' => 'இணைப்பு முன்னோட்டம்',
			'feed.linkPreviewSize' => '1200 × 630',
			'feed.storyFormat' => 'ஸ்டோரி வடிவம்',
			'feed.storyFormatSize' => '1080 × 1920 (Instagram/Stories)',
			'feed.generatingPreview' => 'முன்னோட்டம் உருவாக்கப்படுகிறது...',
			'feed.bookmarked' => 'புக் மார்க் செய்யப்பட்டது',
			'feed.removedFromBookmarks' => 'புக் மார்கிலிருந்து நீக்கப்பட்டது',
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
			_ => null,
		};
	}
}
