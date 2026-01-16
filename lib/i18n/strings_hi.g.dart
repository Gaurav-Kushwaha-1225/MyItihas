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
	@override late final _TranslationsHomeScreenHi homeScreen = _TranslationsHomeScreenHi._(_root);
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
	@override String get readFullStory => 'पूरी कहानी पढ़ें';
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
class _TranslationsStoriesHi extends TranslationsStoriesEn {
	_TranslationsStoriesHi._(TranslationsHi root) : this._root = root, super.internal(root);

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
	@override String get failedToLoad => 'कहानी लोड करने में विफल';
}

// Path: storyGenerator
class _TranslationsStoryGeneratorHi extends TranslationsStoryGeneratorEn {
	_TranslationsStoryGeneratorHi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'कहानी जनरेटर';
	@override String get subtitle => 'अपनी पौराणिक कहानी बनाएं';
	@override String get quickStart => 'त्वरित प्रारंभ';
	@override String get interactive => 'इंटरैक्टिव';
	@override String get rawPrompt => 'कच्चा प्रॉम्प्ट';
	@override String get yourStoryPrompt => 'आपका कहानी प्रॉम्प्ट';
	@override String get writeYourPrompt => 'अपना प्रॉम्प्ट लिखें';
	@override String get selectScripture => 'शास्त्र चुनें';
	@override String get selectStoryType => 'कहानी प्रकार चुनें';
	@override String get selectCharacter => 'पात्र चुनें';
	@override String get selectTheme => 'विषय चुनें';
	@override String get selectSetting => 'स्थान चुनें';
	@override String get selectLanguage => 'भाषा चुनें';
	@override String get selectLength => 'कहानी की लंबाई';
	@override String get moreOptions => 'अधिक विकल्प';
	@override String get random => 'यादृच्छिक';
	@override String get generate => 'कहानी बनाएं';
	@override String get generating => 'आपकी कहानी बन रही है...';
	@override String get creatingYourStory => 'आपकी कहानी बनाई जा रही है';
	@override String get consultingScriptures => 'प्राचीन शास्त्रों से परामर्श...';
	@override String get weavingTale => 'आपकी कथा बुनी जा रही है...';
	@override String get addingWisdom => 'दिव्य ज्ञान जोड़ रहे हैं...';
	@override String get polishingNarrative => 'कथा को निखारा जा रहा है...';
	@override String get almostThere => 'लगभग हो गया...';
	@override String get generatedStory => 'आपकी बनाई कहानी';
	@override String get aiGenerated => 'AI निर्मित';
	@override String get regenerate => 'फिर से बनाएं';
	@override String get saveStory => 'कहानी सहेजें';
	@override String get shareStory => 'कहानी साझा करें';
	@override String get newStory => 'नई कहानी';
	@override String get saved => 'सहेजा गया';
	@override String get storySaved => 'कहानी आपकी लाइब्रेरी में सहेजी गई';
	@override String get story => 'कहानी';
	@override String get lesson => 'सीख';
	@override String get didYouKnow => 'क्या आप जानते हैं?';
	@override String get activity => 'गतिविधि';
	@override String get optionalRefine => 'वैकल्पिक: विकल्पों से परिष्कृत करें';
	@override String get applyOptions => 'विकल्प लागू करें';
	@override String get language => 'भाषा';
	@override String get storyFormat => 'कहानी प्रारूप';
	@override late final _TranslationsStoryGeneratorStoryLengthHi storyLength = _TranslationsStoryGeneratorStoryLengthHi._(_root);
	@override late final _TranslationsStoryGeneratorFormatHi format = _TranslationsStoryGeneratorFormatHi._(_root);
	@override late final _TranslationsStoryGeneratorHintsHi hints = _TranslationsStoryGeneratorHintsHi._(_root);
	@override late final _TranslationsStoryGeneratorErrorsHi errors = _TranslationsStoryGeneratorErrorsHi._(_root);
}

// Path: chat
class _TranslationsChatHi extends TranslationsChatEn {
	_TranslationsChatHi._(TranslationsHi root) : this._root = root, super.internal(root);

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
	@override String get listPage => 'चैट सूची पृष्ठ';
}

// Path: map
class _TranslationsMapHi extends TranslationsMapEn {
	_TranslationsMapHi._(TranslationsHi root) : this._root = root, super.internal(root);

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
	@override String get shareYourStory => 'अपनी कहानी साझा करें...';
	@override String get post => 'पोस्ट करें';
	@override String get like => 'पसंद';
	@override String get comment => 'टिप्पणी';
	@override String get comments => 'टिप्पणियां';
	@override String get noPostsYet => 'अभी तक कोई पोस्ट नहीं';
}

// Path: settings
class _TranslationsSettingsHi extends TranslationsSettingsEn {
	_TranslationsSettingsHi._(TranslationsHi root) : this._root = root, super.internal(root);

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
class _TranslationsAuthHi extends TranslationsAuthEn {
	_TranslationsAuthHi._(TranslationsHi root) : this._root = root, super.internal(root);

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
class _TranslationsErrorHi extends TranslationsErrorEn {
	_TranslationsErrorHi._(TranslationsHi root) : this._root = root, super.internal(root);

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
class _TranslationsSubscriptionHi extends TranslationsSubscriptionEn {
	_TranslationsSubscriptionHi._(TranslationsHi root) : this._root = root, super.internal(root);

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
class _TranslationsNotificationHi extends TranslationsNotificationEn {
	_TranslationsNotificationHi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'सूचनाएं';
	@override String get markAllRead => 'सभी को पढ़ा हुआ मार्क करें';
	@override String get noNotifications => 'अभी तक कोई सूचना नहीं';
	@override String get errorPrefix => 'त्रुटि:';
	@override String get retry => 'पुनः प्रयास करें';
	@override String likedYourStory({required Object actorName}) => '${actorName} ने आपकी कहानी को लाइक किया';
	@override String commentedOnYourStory({required Object actorName}) => '${actorName} ने आपकी कहानी पर टिप्पणी की';
	@override String repliedToYourComment({required Object actorName}) => '${actorName} ने आपके कमेंट का जवाब दिया';
	@override String startedFollowingYou({required Object actorName}) => '${actorName} ने आपको फॉलो करना शुरू किया';
	@override String sentYouAMessage({required Object actorName}) => '${actorName} ने आपको एक संदेश भेजा';
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
	@override String unlike({required Object count}) => 'Unlike, ${count} likes';
	@override String like({required Object count}) => 'Like, ${count} likes';
	@override String commentCount({required Object count}) => '${count} comments';
	@override String shareCount({required Object count}) => 'Share, ${count} shares';
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

// Path: homeScreen
class _TranslationsHomeScreenHi extends TranslationsHomeScreenEn {
	_TranslationsHomeScreenHi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get greeting => 'नमस्ते';
	@override String get quoteOfTheDay => 'आज का विचार';
	@override String get shareQuote => 'विचार साझा करें';
	@override String get copyQuote => 'विचार कॉपी करें';
	@override String get quoteCopied => 'विचार क्लिपबोर्ड पर कॉपी किया गया';
	@override String get featuredStories => 'विशेष कहानियां';
	@override String get quickActions => 'त्वरित क्रियाएं';
	@override String get generateStory => 'कहानी बनाएं';
	@override String get chatWithKrishna => 'कृष्ण से बातचीत';
	@override String get myActivity => 'मेरी गतिविधि';
	@override String get continueReading => 'पढ़ना जारी रखें';
	@override String get savedStories => 'सहेजी गई कहानियां';
	@override String get seeAll => 'सभी देखें';
	@override String get startReading => 'पढ़ना शुरू करें';
	@override String get exploreStories => 'अपनी यात्रा शुरू करने के लिए कहानियां खोजें';
	@override String get saveForLater => 'पसंदीदा कहानियां बुकमार्क करें';
	@override String get noActivityYet => 'अभी तक कोई गतिविधि नहीं';
	@override String minLeft({required Object count}) => '${count} मिनट बाकी';
	@override String get activityHistory => 'गतिविधि इतिहास';
	@override String get storyGenerated => 'कहानी बनाई';
	@override String get storyRead => 'कहानी पढ़ी';
	@override String get storyBookmarked => 'कहानी सहेजी';
	@override String get storyShared => 'कहानी साझा की';
	@override String get storyCompleted => 'कहानी पूरी की';
	@override String get today => 'आज';
	@override String get yesterday => 'कल';
	@override String get thisWeek => 'इस सप्ताह';
	@override String get earlier => 'पहले';
	@override String get noContinueReading => 'अभी पढ़ने के लिए कुछ नहीं';
	@override String get noSavedStories => 'अभी कोई सहेजी गई कहानी नहीं';
	@override String get bookmarkStoriesToSave => 'कहानियां सहेजने के लिए बुकमार्क करें';
}

// Path: storyGenerator.storyLength
class _TranslationsStoryGeneratorStoryLengthHi extends TranslationsStoryGeneratorStoryLengthEn {
	_TranslationsStoryGeneratorStoryLengthHi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get short => 'छोटी';
	@override String get medium => 'मध्यम';
	@override String get long => 'लंबी';
	@override String get epic => 'महाकाव्य';
}

// Path: storyGenerator.format
class _TranslationsStoryGeneratorFormatHi extends TranslationsStoryGeneratorFormatEn {
	_TranslationsStoryGeneratorFormatHi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get narrative => 'कथात्मक';
	@override String get dialogue => 'संवाद-आधारित';
	@override String get poetic => 'काव्यात्मक';
	@override String get scriptural => 'शास्त्रीय';
}

// Path: storyGenerator.hints
class _TranslationsStoryGeneratorHintsHi extends TranslationsStoryGeneratorHintsEn {
	_TranslationsStoryGeneratorHintsHi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get krishnaTeaching => 'कृष्ण द्वारा अर्जुन को शिक्षा देने की कहानी...';
	@override String get warriorRedemption => 'मुक्ति की खोज में एक योद्धा की महाकाव्य...';
	@override String get sageWisdom => 'ऋषियों की बुद्धि की कहानी...';
	@override String get devotedSeeker => 'एक भक्त साधक की यात्रा...';
	@override String get divineIntervention => 'दिव्य हस्तक्षेप की किंवदंती...';
}

// Path: storyGenerator.errors
class _TranslationsStoryGeneratorErrorsHi extends TranslationsStoryGeneratorErrorsEn {
	_TranslationsStoryGeneratorErrorsHi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get incompletePrompt => 'कृपया सभी आवश्यक विकल्प पूरे करें';
	@override String get generationFailed => 'कहानी बनाने में विफल। कृपया पुनः प्रयास करें।';
}

// Path: feed.tabs
class _TranslationsFeedTabsHi extends TranslationsFeedTabsEn {
	_TranslationsFeedTabsHi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get all => 'सभी';
	@override String get stories => 'कहानियाँ';
	@override String get posts => 'पोस्ट';
	@override String get videos => 'वीडियो';
	@override String get images => 'चित्र';
	@override String get text => 'विचार';
}
