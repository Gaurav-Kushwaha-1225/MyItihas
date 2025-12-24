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
class TranslationsHi with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsHi({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.hi,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <hi>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsHi _root = this; // ignore: unused_field

	@override 
	TranslationsHi $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsHi(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsAppHi app = _TranslationsAppHi._(_root);
	@override late final _TranslationsCommonHi common = _TranslationsCommonHi._(_root);
	@override late final _TranslationsNavigationHi navigation = _TranslationsNavigationHi._(_root);
	@override late final _TranslationsHomeHi home = _TranslationsHomeHi._(_root);
	@override late final _TranslationsStoriesHi stories = _TranslationsStoriesHi._(_root);
	@override late final _TranslationsStoryGeneratorHi storyGenerator = _TranslationsStoryGeneratorHi._(_root);
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
class _TranslationsAppHi implements TranslationsAppEn {
	_TranslationsAppHi._(this._root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get name => 'मायइतिहास';
	@override String get tagline => 'भारतीय पौराणिक कथाएं खोजें';
}

// Path: common
class _TranslationsCommonHi implements TranslationsCommonEn {
	_TranslationsCommonHi._(this._root);

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
class _TranslationsNavigationHi implements TranslationsNavigationEn {
	_TranslationsNavigationHi._(this._root);

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
class _TranslationsHomeHi implements TranslationsHomeEn {
	_TranslationsHomeHi._(this._root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'मायइतिहास';
	@override String get storyGenerator => 'कहानी जनरेटर';
	@override String get chatItihas => 'चैटइतिहास';
	@override String get communityStories => 'सामुदायिक कहानियां';
	@override String get maps => 'मानचित्र';
	@override String get greetingMorning => 'सुप्रभात';
	@override String get continueReading => 'पढ़ना जारी रखें';
	@override String get greetingAfternoon => 'नमस्कार';
	@override String get greetingEvening => 'शुभ संध्या';
	@override String get exploreStories => 'कहानियां खोजें';
	@override String get generateStory => 'कहानी बनाएं';
	@override String get content => 'होम सामग्री';
}

// Path: stories
class _TranslationsStoriesHi implements TranslationsStoriesEn {
	_TranslationsStoriesHi._(this._root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'कहानियां';
	@override String get searchHint => 'शीर्षक या लेखक से खोजें...';
	@override String get sortBy => 'क्रमबद्ध करें';
	@override String get sortNewest => 'नवीनतम पहले';
	@override String get sortOldest => 'पुरानी पहले';
	@override String get sortPopular => 'सबसे लोकप्रिय';
	@override String get noStories => 'कोई कहानी नहीं मिली';
	@override String get loadingStories => 'कहानियां लोड हो रही हैं...';
	@override String get errorLoadingStories => 'कहानियां लोड करने में विफल';
	@override String get storyDetails => 'कहानी विवरण';
	@override String get continueReading => 'पढ़ना जारी रखें';
	@override String get readMore => 'और पढ़ें';
	@override String get readLess => 'कम पढ़ें';
	@override String get author => 'लेखक';
	@override String get publishedOn => 'प्रकाशित';
	@override String get category => 'श्रेणी';
	@override String get tags => 'टैग';
	@override String get failed_to_load => 'कहानी लोड करने में विफल';
}

// Path: storyGenerator
class _TranslationsStoryGeneratorHi implements TranslationsStoryGeneratorEn {
	_TranslationsStoryGeneratorHi._(this._root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'कहानी जनरेटर';
	@override String get subtitle => 'अपनी पौराणिक कहानी बनाएं';
	@override String get selectCharacter => 'पात्र चुनें';
	@override String get selectTheme => 'विषय चुनें';
	@override String get selectLanguage => 'भाषा चुनें';
	@override String get selectLength => 'कहानी की लंबाई';
	@override String get generate => 'कहानी बनाएं';
	@override String get generating => 'आपकी कहानी बन रही है...';
	@override String get generatedStory => 'आपकी बनाई कहानी';
	@override String get regenerate => 'फिर से बनाएं';
	@override String get saveStory => 'कहानी सहेजें';
	@override String get shareStory => 'कहानी साझा करें';
	@override late final _TranslationsStoryGeneratorStoryLengthHi storyLength = _TranslationsStoryGeneratorStoryLengthHi._(_root);
}

// Path: chat
class _TranslationsChatHi implements TranslationsChatEn {
	_TranslationsChatHi._(this._root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'चैटइतिहास';
	@override String get subtitle => 'पौराणिक कथाओं के बारे में AI से चैट करें';
	@override String get friendMode => 'मित्र मोड';
	@override String get philosophicalMode => 'दार्शनिक मोड';
	@override String get typeMessage => 'अपना संदेश लिखें...';
	@override String get send => 'भेजें';
	@override String get newChat => 'नई चैट';
	@override String get chatHistory => 'चैट इतिहास';
	@override String get clearChat => 'चैट साफ़ करें';
	@override String get noMessages => 'अभी तक कोई संदेश नहीं। बातचीत शुरू करें!';
	@override String get list_page => 'चैट सूची पृष्ठ';
}

// Path: map
class _TranslationsMapHi implements TranslationsMapEn {
	_TranslationsMapHi._(this._root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'अखंड भारत';
	@override String get subtitle => 'ऐतिहासिक स्थानों का अन्वेषण करें';
	@override String get searchLocation => 'स्थान खोजें...';
	@override String get viewDetails => 'विवरण देखें';
	@override String get showRoute => 'मार्ग दिखाएं';
	@override String get historicalInfo => 'ऐतिहासिक जानकारी';
	@override String get nearbyPlaces => 'निकटवर्ती स्थान';
}

// Path: community
class _TranslationsCommunityHi implements TranslationsCommunityEn {
	_TranslationsCommunityHi._(this._root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'समुदाय';
	@override String get trending => 'ट्रेंडिंग';
	@override String get following => 'फॉलोइंग';
	@override String get followers => 'फॉलोवर्स';
	@override String get posts => 'पोस्ट';
	@override String get follow => 'फॉलो करें';
	@override String get unfollow => 'अनफॉलो करें';
	@override String get shareYourStory => 'अपनी कहानी साझा करें...';
	@override String get post => 'पोस्ट करें';
	@override String get like => 'पसंद';
	@override String get comment => 'टिप्पणी';
	@override String get comments => 'टिप्पणियां';
	@override String get noPostsYet => 'अभी तक कोई पोस्ट नहीं';
}

// Path: settings
class _TranslationsSettingsHi implements TranslationsSettingsEn {
	_TranslationsSettingsHi._(this._root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'सेटिंग्स';
	@override String get language => 'भाषा';
	@override String get theme => 'थीम';
	@override String get themeLight => 'लाइट';
	@override String get themeDark => 'डार्क';
	@override String get themeSystem => 'सिस्टम डिफ़ॉल्ट';
	@override String get notifications => 'सूचनाएं';
	@override String get account => 'खाता';
	@override String get privacy => 'गोपनीयता';
	@override String get about => 'हमारे बारे में';
	@override String get version => 'संस्करण';
	@override String get logout => 'लॉग आउट';
}

// Path: auth
class _TranslationsAuthHi implements TranslationsAuthEn {
	_TranslationsAuthHi._(this._root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get login => 'लॉगिन';
	@override String get signup => 'साइन अप';
	@override String get email => 'ईमेल';
	@override String get password => 'पासवर्ड';
	@override String get confirmPassword => 'पासवर्ड की पुष्टि करें';
	@override String get forgotPassword => 'पासवर्ड भूल गए?';
	@override String get resetPassword => 'पासवर्ड रीसेट करें';
	@override String get dontHaveAccount => 'खाता नहीं है?';
	@override String get alreadyHaveAccount => 'पहले से खाता है?';
	@override String get loginSuccess => 'लॉगिन सफल';
	@override String get signupSuccess => 'साइन अप सफल';
	@override String get loginError => 'लॉगिन विफल';
	@override String get signupError => 'साइन अप विफल';
}

// Path: error
class _TranslationsErrorHi implements TranslationsErrorEn {
	_TranslationsErrorHi._(this._root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get network => 'इंटरनेट कनेक्शन नहीं है';
	@override String get server => 'सर्वर त्रुटि हुई';
	@override String get cache => 'कैश्ड डेटा लोड करने में विफल';
	@override String get timeout => 'अनुरोध समय समाप्त';
	@override String get notFound => 'संसाधन नहीं मिला';
	@override String get validation => 'सत्यापन विफल';
	@override String get unexpected => 'एक अप्रत्याशित त्रुटि हुई';
	@override String get tryAgain => 'कृपया पुनः प्रयास करें';
}

// Path: subscription
class _TranslationsSubscriptionHi implements TranslationsSubscriptionEn {
	_TranslationsSubscriptionHi._(this._root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get free => 'मुफ़्त';
	@override String get plus => 'प्लस';
	@override String get pro => 'प्रो';
	@override String get upgradeToPro => 'प्रो में अपग्रेड करें';
	@override String get features => 'सुविधाएँ';
	@override String get subscribe => 'सदस्यता लें';
	@override String get currentPlan => 'वर्तमान योजना';
	@override String get managePlan => 'योजना प्रबंधित करें';
}

// Path: notification
class _TranslationsNotificationHi implements TranslationsNotificationEn {
	_TranslationsNotificationHi._(this._root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'सूचनाएं';
	@override String get markAllRead => 'सभी को पढ़ा हुआ मार्क करें';
	@override String get noNotifications => 'अभी तक कोई सूचना नहीं';
	@override String get errorPrefix => 'त्रुटि:';
	@override String get retry => 'पुनः प्रयास करें';
	@override String get likedYourStory => '{{actorName}} ने आपकी कहानी को लाइक किया';
	@override String get commentedOnYourStory => '{{actorName}} ने आपकी कहानी पर टिप्पणी की';
	@override String get repliedToYourComment => '{{actorName}} ने आपके कमेंट का जवाब दिया';
	@override String get startedFollowingYou => '{{actorName}} ने आपको फॉलो करना शुरू किया';
	@override String get sentYouAMessage => '{{actorName}} ने आपको एक संदेश भेजा';
}

// Path: profile
class _TranslationsProfileHi implements TranslationsProfileEn {
	_TranslationsProfileHi._(this._root);

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
class _TranslationsFeedHi implements TranslationsFeedEn {
	_TranslationsFeedHi._(this._root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get loading => 'कहानियाँ लोड हो रही हैं...';
	@override String get errorTitle => 'अरे! कुछ गलत हो गया';
	@override String get tryAgain => 'फिर से प्रयास करें';
	@override String get noStoriesAvailable => 'कोई कहानी उपलब्ध नहीं';
	@override String get noImagesAvailable => 'कोई चित्र पोस्ट उपलब्ध नहीं';
	@override String get noTextPostsAvailable => 'कोई विचार पोस्ट उपलब्ध नहीं';
	@override String get noContentAvailable => 'कोई सामग्री उपलब्ध नहीं';
	@override String get refresh => 'रिफ्रेश';
	@override String get comments => 'टिप्पणियाँ';
	@override String get commentsComingSoon => 'टिप्पणियाँ जल्द ही आ रही हैं';
	@override String get addCommentHint => 'टिप्पणी जोड़ें...';
	@override String get shareStory => 'कहानी साझा करें';
	@override String get sharePost => 'पोस्ट साझा करें';
	@override String get shareThought => 'विचार साझा करें';
	@override String get shareAsImage => 'चित्र के रूप में साझा करें';
	@override String get shareAsImageSubtitle => 'एक सुंदर पूर्वावलोकन कार्ड बनाएं';
	@override String get shareLink => 'लिंक साझा करें';
	@override String get shareLinkSubtitle => 'कहानी लिंक कॉपी या साझा करें';
	@override String get shareImageLinkSubtitle => 'पोस्ट लिंक कॉपी या साझा करें';
	@override String get shareTextLinkSubtitle => 'विचार लिंक कॉपी या साझा करें';
	@override String get shareAsText => 'पाठ के रूप में साझा करें';
	@override String get shareAsTextSubtitle => 'कहानी के अंश साझा करें';
	@override String get shareQuote => 'उद्धरण साझा करें';
	@override String get shareQuoteSubtitle => 'उद्धरण के रूप में साझा करें';
	@override String get shareWithImage => 'चित्र सहित साझा करें';
	@override String get shareWithImageSubtitle => 'कैप्शन सहित चित्र साझा करें';
	@override String get copyLink => 'लिंक कॉपी करें';
	@override String get copyLinkSubtitle => 'क्लिपबोर्ड पर लिंक कॉपी करें';
	@override String get copyText => 'पाठ कॉपी करें';
	@override String get copyTextSubtitle => 'क्लिपबोर्ड पर उद्धरण कॉपी करें';
	@override String get linkCopied => 'लिंक क्लिपबोर्ड पर कॉपी हो गया';
	@override String get textCopied => 'पाठ क्लिपबोर्ड पर कॉपी हो गया';
	@override String get sendToUser => 'उपयोगकर्ता को भेजें';
	@override String get sendToUserSubtitle => 'सीधे मित्र के साथ साझा करें';
	@override String get chooseFormat => 'प्रारूप चुनें';
	@override String get linkPreview => 'लिंक पूर्वावलोकन';
	@override String get linkPreviewSize => '1200 × 630';
	@override String get storyFormat => 'स्टोरी प्रारूप';
	@override String get storyFormatSize => '1080 × 1920 (Instagram/Stories)';
	@override String get generatingPreview => 'पूर्वावलोकन तैयार किया जा रहा है...';
	@override String get bookmarked => 'बुकमार्क किया गया';
	@override String get removedFromBookmarks => 'बुकमार्क से हटाया गया';
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
	@override late final _TranslationsFeedTabsHi tabs = _TranslationsFeedTabsHi._(_root);
	@override String get tapToShowCaption => 'कैप्शन देखने के लिए टैप करें';
	@override String get noVideosAvailable => 'कोई वीडियो उपलब्ध नहीं';
}

// Path: storyGenerator.storyLength
class _TranslationsStoryGeneratorStoryLengthHi implements TranslationsStoryGeneratorStoryLengthEn {
	_TranslationsStoryGeneratorStoryLengthHi._(this._root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get short => 'छोटी';
	@override String get medium => 'मध्यम';
	@override String get long => 'लंबी';
}

// Path: feed.tabs
class _TranslationsFeedTabsHi implements TranslationsFeedTabsEn {
	_TranslationsFeedTabsHi._(this._root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get all => 'सभी';
	@override String get stories => 'कहानियाँ';
	@override String get posts => 'पोस्ट';
	@override String get videos => 'वीडियो';
	@override String get images => 'चित्र';
	@override String get text => 'विचार';
}

/// The flat map containing all translations for locale <hi>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsHi {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.name' => 'मायइतिहास',
			'app.tagline' => 'भारतीय पौराणिक कथाएं खोजें',
			'common.ok' => 'ठीक है',
			'common.cancel' => 'रद्द करें',
			'common.confirm' => 'पुष्टि करें',
			'common.delete' => 'हटाएं',
			'common.edit' => 'संपादित करें',
			'common.save' => 'सहेजें',
			'common.share' => 'साझा करें',
			'common.search' => 'खोजें',
			'common.loading' => 'लोड हो रहा है...',
			'common.error' => 'त्रुटि',
			'common.retry' => 'पुनः प्रयास करें',
			'common.back' => 'वापस',
			'common.next' => 'अगला',
			'common.finish' => 'समाप्त',
			'common.skip' => 'छोड़ें',
			'common.yes' => 'हां',
			'common.no' => 'नहीं',
			'common.read_full_story' => 'पूरी कहानी पढ़ें',
			'navigation.home' => 'होम',
			'navigation.stories' => 'कहानियां',
			'navigation.chat' => 'चैट',
			'navigation.map' => 'मानचित्र',
			'navigation.community' => 'समुदाय',
			'navigation.settings' => 'सेटिंग्स',
			'navigation.profile' => 'प्रोफाइल',
			'home.title' => 'मायइतिहास',
			'home.storyGenerator' => 'कहानी जनरेटर',
			'home.chatItihas' => 'चैटइतिहास',
			'home.communityStories' => 'सामुदायिक कहानियां',
			'home.maps' => 'मानचित्र',
			'home.greetingMorning' => 'सुप्रभात',
			'home.continueReading' => 'पढ़ना जारी रखें',
			'home.greetingAfternoon' => 'नमस्कार',
			'home.greetingEvening' => 'शुभ संध्या',
			'home.exploreStories' => 'कहानियां खोजें',
			'home.generateStory' => 'कहानी बनाएं',
			'home.content' => 'होम सामग्री',
			'stories.title' => 'कहानियां',
			'stories.searchHint' => 'शीर्षक या लेखक से खोजें...',
			'stories.sortBy' => 'क्रमबद्ध करें',
			'stories.sortNewest' => 'नवीनतम पहले',
			'stories.sortOldest' => 'पुरानी पहले',
			'stories.sortPopular' => 'सबसे लोकप्रिय',
			'stories.noStories' => 'कोई कहानी नहीं मिली',
			'stories.loadingStories' => 'कहानियां लोड हो रही हैं...',
			'stories.errorLoadingStories' => 'कहानियां लोड करने में विफल',
			'stories.storyDetails' => 'कहानी विवरण',
			'stories.continueReading' => 'पढ़ना जारी रखें',
			'stories.readMore' => 'और पढ़ें',
			'stories.readLess' => 'कम पढ़ें',
			'stories.author' => 'लेखक',
			'stories.publishedOn' => 'प्रकाशित',
			'stories.category' => 'श्रेणी',
			'stories.tags' => 'टैग',
			'stories.failed_to_load' => 'कहानी लोड करने में विफल',
			'storyGenerator.title' => 'कहानी जनरेटर',
			'storyGenerator.subtitle' => 'अपनी पौराणिक कहानी बनाएं',
			'storyGenerator.selectCharacter' => 'पात्र चुनें',
			'storyGenerator.selectTheme' => 'विषय चुनें',
			'storyGenerator.selectLanguage' => 'भाषा चुनें',
			'storyGenerator.selectLength' => 'कहानी की लंबाई',
			'storyGenerator.generate' => 'कहानी बनाएं',
			'storyGenerator.generating' => 'आपकी कहानी बन रही है...',
			'storyGenerator.generatedStory' => 'आपकी बनाई कहानी',
			'storyGenerator.regenerate' => 'फिर से बनाएं',
			'storyGenerator.saveStory' => 'कहानी सहेजें',
			'storyGenerator.shareStory' => 'कहानी साझा करें',
			'storyGenerator.storyLength.short' => 'छोटी',
			'storyGenerator.storyLength.medium' => 'मध्यम',
			'storyGenerator.storyLength.long' => 'लंबी',
			'chat.title' => 'चैटइतिहास',
			'chat.subtitle' => 'पौराणिक कथाओं के बारे में AI से चैट करें',
			'chat.friendMode' => 'मित्र मोड',
			'chat.philosophicalMode' => 'दार्शनिक मोड',
			'chat.typeMessage' => 'अपना संदेश लिखें...',
			'chat.send' => 'भेजें',
			'chat.newChat' => 'नई चैट',
			'chat.chatHistory' => 'चैट इतिहास',
			'chat.clearChat' => 'चैट साफ़ करें',
			'chat.noMessages' => 'अभी तक कोई संदेश नहीं। बातचीत शुरू करें!',
			'chat.list_page' => 'चैट सूची पृष्ठ',
			'map.title' => 'अखंड भारत',
			'map.subtitle' => 'ऐतिहासिक स्थानों का अन्वेषण करें',
			'map.searchLocation' => 'स्थान खोजें...',
			'map.viewDetails' => 'विवरण देखें',
			'map.showRoute' => 'मार्ग दिखाएं',
			'map.historicalInfo' => 'ऐतिहासिक जानकारी',
			'map.nearbyPlaces' => 'निकटवर्ती स्थान',
			'community.title' => 'समुदाय',
			'community.trending' => 'ट्रेंडिंग',
			'community.following' => 'फॉलोइंग',
			'community.followers' => 'फॉलोवर्स',
			'community.posts' => 'पोस्ट',
			'community.follow' => 'फॉलो करें',
			'community.unfollow' => 'अनफॉलो करें',
			'community.shareYourStory' => 'अपनी कहानी साझा करें...',
			'community.post' => 'पोस्ट करें',
			'community.like' => 'पसंद',
			'community.comment' => 'टिप्पणी',
			'community.comments' => 'टिप्पणियां',
			'community.noPostsYet' => 'अभी तक कोई पोस्ट नहीं',
			'settings.title' => 'सेटिंग्स',
			'settings.language' => 'भाषा',
			'settings.theme' => 'थीम',
			'settings.themeLight' => 'लाइट',
			'settings.themeDark' => 'डार्क',
			'settings.themeSystem' => 'सिस्टम डिफ़ॉल्ट',
			'settings.notifications' => 'सूचनाएं',
			'settings.account' => 'खाता',
			'settings.privacy' => 'गोपनीयता',
			'settings.about' => 'हमारे बारे में',
			'settings.version' => 'संस्करण',
			'settings.logout' => 'लॉग आउट',
			'auth.login' => 'लॉगिन',
			'auth.signup' => 'साइन अप',
			'auth.email' => 'ईमेल',
			'auth.password' => 'पासवर्ड',
			'auth.confirmPassword' => 'पासवर्ड की पुष्टि करें',
			'auth.forgotPassword' => 'पासवर्ड भूल गए?',
			'auth.resetPassword' => 'पासवर्ड रीसेट करें',
			'auth.dontHaveAccount' => 'खाता नहीं है?',
			'auth.alreadyHaveAccount' => 'पहले से खाता है?',
			'auth.loginSuccess' => 'लॉगिन सफल',
			'auth.signupSuccess' => 'साइन अप सफल',
			'auth.loginError' => 'लॉगिन विफल',
			'auth.signupError' => 'साइन अप विफल',
			'error.network' => 'इंटरनेट कनेक्शन नहीं है',
			'error.server' => 'सर्वर त्रुटि हुई',
			'error.cache' => 'कैश्ड डेटा लोड करने में विफल',
			'error.timeout' => 'अनुरोध समय समाप्त',
			'error.notFound' => 'संसाधन नहीं मिला',
			'error.validation' => 'सत्यापन विफल',
			'error.unexpected' => 'एक अप्रत्याशित त्रुटि हुई',
			'error.tryAgain' => 'कृपया पुनः प्रयास करें',
			'subscription.free' => 'मुफ़्त',
			'subscription.plus' => 'प्लस',
			'subscription.pro' => 'प्रो',
			'subscription.upgradeToPro' => 'प्रो में अपग्रेड करें',
			'subscription.features' => 'सुविधाएँ',
			'subscription.subscribe' => 'सदस्यता लें',
			'subscription.currentPlan' => 'वर्तमान योजना',
			'subscription.managePlan' => 'योजना प्रबंधित करें',
			'notification.title' => 'सूचनाएं',
			'notification.markAllRead' => 'सभी को पढ़ा हुआ मार्क करें',
			'notification.noNotifications' => 'अभी तक कोई सूचना नहीं',
			'notification.errorPrefix' => 'त्रुटि:',
			'notification.retry' => 'पुनः प्रयास करें',
			'notification.likedYourStory' => '{{actorName}} ने आपकी कहानी को लाइक किया',
			'notification.commentedOnYourStory' => '{{actorName}} ने आपकी कहानी पर टिप्पणी की',
			'notification.repliedToYourComment' => '{{actorName}} ने आपके कमेंट का जवाब दिया',
			'notification.startedFollowingYou' => '{{actorName}} ने आपको फॉलो करना शुरू किया',
			'notification.sentYouAMessage' => '{{actorName}} ने आपको एक संदेश भेजा',
			'profile.followers' => 'फॉलोअर्स',
			'profile.following' => 'फॉलोइंग',
			'profile.unfollow' => 'अनफॉलो करें',
			'profile.follow' => 'फॉलो करें',
			'profile.about' => 'के बारे में',
			'profile.stories' => 'कहानियाँ',
			'feed.loading' => 'कहानियाँ लोड हो रही हैं...',
			'feed.errorTitle' => 'अरे! कुछ गलत हो गया',
			'feed.tryAgain' => 'फिर से प्रयास करें',
			'feed.noStoriesAvailable' => 'कोई कहानी उपलब्ध नहीं',
			'feed.noImagesAvailable' => 'कोई चित्र पोस्ट उपलब्ध नहीं',
			'feed.noTextPostsAvailable' => 'कोई विचार पोस्ट उपलब्ध नहीं',
			'feed.noContentAvailable' => 'कोई सामग्री उपलब्ध नहीं',
			'feed.refresh' => 'रिफ्रेश',
			'feed.comments' => 'टिप्पणियाँ',
			'feed.commentsComingSoon' => 'टिप्पणियाँ जल्द ही आ रही हैं',
			'feed.addCommentHint' => 'टिप्पणी जोड़ें...',
			'feed.shareStory' => 'कहानी साझा करें',
			'feed.sharePost' => 'पोस्ट साझा करें',
			'feed.shareThought' => 'विचार साझा करें',
			'feed.shareAsImage' => 'चित्र के रूप में साझा करें',
			'feed.shareAsImageSubtitle' => 'एक सुंदर पूर्वावलोकन कार्ड बनाएं',
			'feed.shareLink' => 'लिंक साझा करें',
			'feed.shareLinkSubtitle' => 'कहानी लिंक कॉपी या साझा करें',
			'feed.shareImageLinkSubtitle' => 'पोस्ट लिंक कॉपी या साझा करें',
			'feed.shareTextLinkSubtitle' => 'विचार लिंक कॉपी या साझा करें',
			'feed.shareAsText' => 'पाठ के रूप में साझा करें',
			'feed.shareAsTextSubtitle' => 'कहानी के अंश साझा करें',
			'feed.shareQuote' => 'उद्धरण साझा करें',
			'feed.shareQuoteSubtitle' => 'उद्धरण के रूप में साझा करें',
			'feed.shareWithImage' => 'चित्र सहित साझा करें',
			'feed.shareWithImageSubtitle' => 'कैप्शन सहित चित्र साझा करें',
			'feed.copyLink' => 'लिंक कॉपी करें',
			'feed.copyLinkSubtitle' => 'क्लिपबोर्ड पर लिंक कॉपी करें',
			'feed.copyText' => 'पाठ कॉपी करें',
			'feed.copyTextSubtitle' => 'क्लिपबोर्ड पर उद्धरण कॉपी करें',
			'feed.linkCopied' => 'लिंक क्लिपबोर्ड पर कॉपी हो गया',
			'feed.textCopied' => 'पाठ क्लिपबोर्ड पर कॉपी हो गया',
			'feed.sendToUser' => 'उपयोगकर्ता को भेजें',
			'feed.sendToUserSubtitle' => 'सीधे मित्र के साथ साझा करें',
			'feed.chooseFormat' => 'प्रारूप चुनें',
			'feed.linkPreview' => 'लिंक पूर्वावलोकन',
			'feed.linkPreviewSize' => '1200 × 630',
			'feed.storyFormat' => 'स्टोरी प्रारूप',
			'feed.storyFormatSize' => '1080 × 1920 (Instagram/Stories)',
			'feed.generatingPreview' => 'पूर्वावलोकन तैयार किया जा रहा है...',
			'feed.bookmarked' => 'बुकमार्क किया गया',
			'feed.removedFromBookmarks' => 'बुकमार्क से हटाया गया',
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
			'feed.tabs.all' => 'सभी',
			'feed.tabs.stories' => 'कहानियाँ',
			'feed.tabs.posts' => 'पोस्ट',
			'feed.tabs.videos' => 'वीडियो',
			'feed.tabs.images' => 'चित्र',
			'feed.tabs.text' => 'विचार',
			'feed.tapToShowCaption' => 'कैप्शन देखने के लिए टैप करें',
			'feed.noVideosAvailable' => 'कोई वीडियो उपलब्ध नहीं',
			_ => null,
		};
	}
}
