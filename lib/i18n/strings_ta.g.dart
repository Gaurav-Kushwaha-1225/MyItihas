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
	@override late final _TranslationsHomeScreenTa homeScreen = _TranslationsHomeScreenTa._(_root);
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
	@override String get readFullStory => 'Read the full story';
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
class _TranslationsStoriesTa extends TranslationsStoriesEn {
	_TranslationsStoriesTa._(TranslationsTa root) : this._root = root, super.internal(root);

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
	@override String get failedToLoad => 'Failed to load story';
}

// Path: storyGenerator
class _TranslationsStoryGeneratorTa extends TranslationsStoryGeneratorEn {
	_TranslationsStoryGeneratorTa._(TranslationsTa root) : this._root = root, super.internal(root);

	final TranslationsTa _root; // ignore: unused_field

	// Translations
	@override String get title => 'கதை உருவாக்கி';
	@override String get subtitle => 'உங்கள் சொந்த புராண கதையை உருவாக்குங்கள்';
	@override String get quickStart => 'விரைவு தொடக்கம்';
	@override String get interactive => 'ஊடாடும்';
	@override String get rawPrompt => 'மூல வரியுரு';
	@override String get yourStoryPrompt => 'உங்கள் கதை வரியுரு';
	@override String get writeYourPrompt => 'உங்கள் வரியுருவை எழுதுங்கள்';
	@override String get selectScripture => 'நூலைத் தேர்ந்தெடுக்கவும்';
	@override String get selectStoryType => 'கதை வகையைத் தேர்ந்தெடுக்கவும்';
	@override String get selectCharacter => 'பாத்திரத்தைத் தேர்ந்தெடுக்கவும்';
	@override String get selectTheme => 'தீம் தேர்ந்தெடுக்கவும்';
	@override String get selectSetting => 'அமைப்பைத் தேர்ந்தெடுக்கவும்';
	@override String get selectLanguage => 'மொழி தேர்ந்தெடுக்கவும்';
	@override String get selectLength => 'கதை நீளம்';
	@override String get moreOptions => 'மேலும் விருப்பங்கள்';
	@override String get random => 'சீரற்ற';
	@override String get generate => 'கதை உருவாக்கு';
	@override String get generating => 'உங்கள் கதை உருவாக்கப்படுகிறது...';
	@override String get creatingYourStory => 'உங்கள் கதை உருவாக்கப்படுகிறது';
	@override String get consultingScriptures => 'பழங்கால நூல்களை ஆலோசிக்கிறது...';
	@override String get weavingTale => 'உங்கள் கதையை நெய்கிறது...';
	@override String get addingWisdom => 'தெய்வீக ஞானம் சேர்க்கிறது...';
	@override String get polishingNarrative => 'கதையை மெருகேற்றுகிறது...';
	@override String get almostThere => 'கிட்டத்தட்ட முடிந்தது...';
	@override String get generatedStory => 'உங்கள் உருவாக்கிய கதை';
	@override String get aiGenerated => 'AI உருவாக்கியது';
	@override String get regenerate => 'மீண்டும் உருவாக்கு';
	@override String get saveStory => 'கதையைச் சேமி';
	@override String get shareStory => 'கதையைப் பகிர்';
	@override String get newStory => 'புதிய கதை';
	@override String get saved => 'சேமிக்கப்பட்டது';
	@override String get storySaved => 'கதை உங்கள் நூலகத்தில் சேமிக்கப்பட்டது';
	@override String get story => 'கதை';
	@override String get lesson => 'பாடம்';
	@override String get didYouKnow => 'உங்களுக்குத் தெரியுமா?';
	@override String get activity => 'செயல்பாடு';
	@override String get optionalRefine => 'விருப்பம்: விருப்பங்களுடன் செம்மைப்படுத்து';
	@override String get applyOptions => 'விருப்பங்களை பயன்படுத்து';
	@override String get language => 'மொழி';
	@override String get storyFormat => 'கதை வடிவம்';
	@override late final _TranslationsStoryGeneratorStoryLengthTa storyLength = _TranslationsStoryGeneratorStoryLengthTa._(_root);
	@override late final _TranslationsStoryGeneratorFormatTa format = _TranslationsStoryGeneratorFormatTa._(_root);
	@override late final _TranslationsStoryGeneratorHintsTa hints = _TranslationsStoryGeneratorHintsTa._(_root);
	@override late final _TranslationsStoryGeneratorErrorsTa errors = _TranslationsStoryGeneratorErrorsTa._(_root);
}

// Path: chat
class _TranslationsChatTa extends TranslationsChatEn {
	_TranslationsChatTa._(TranslationsTa root) : this._root = root, super.internal(root);

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
	@override String get listPage => 'Chat List Page';
}

// Path: map
class _TranslationsMapTa extends TranslationsMapEn {
	_TranslationsMapTa._(TranslationsTa root) : this._root = root, super.internal(root);

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
	@override String get shareYourStory => 'உங்கள் கதையைப் பகிர்ந்து கொள்ளுங்கள்...';
	@override String get post => 'இடுகை';
	@override String get like => 'விருப்பம்';
	@override String get comment => 'கருத்து';
	@override String get comments => 'கருத்துகள்';
	@override String get noPostsYet => 'இன்னும் இடுகைகள் இல்லை';
}

// Path: settings
class _TranslationsSettingsTa extends TranslationsSettingsEn {
	_TranslationsSettingsTa._(TranslationsTa root) : this._root = root, super.internal(root);

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
class _TranslationsAuthTa extends TranslationsAuthEn {
	_TranslationsAuthTa._(TranslationsTa root) : this._root = root, super.internal(root);

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
class _TranslationsErrorTa extends TranslationsErrorEn {
	_TranslationsErrorTa._(TranslationsTa root) : this._root = root, super.internal(root);

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
class _TranslationsSubscriptionTa extends TranslationsSubscriptionEn {
	_TranslationsSubscriptionTa._(TranslationsTa root) : this._root = root, super.internal(root);

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
class _TranslationsNotificationTa extends TranslationsNotificationEn {
	_TranslationsNotificationTa._(TranslationsTa root) : this._root = root, super.internal(root);

	final TranslationsTa _root; // ignore: unused_field

	// Translations
	@override String get title => 'அறிவிப்புகள்';
	@override String get markAllRead => 'அனைத்தையும் படித்ததாக குறிக்கவும்';
	@override String get noNotifications => 'இன்னும் அறிவிப்புகள் இல்லை';
	@override String get errorPrefix => 'பிழை:';
	@override String get retry => 'மீண்டும் முயற்சிக்கவும்';
	@override String likedYourStory({required Object actorName}) => '${actorName} உங்கள் கதையை விரும்பினார்';
	@override String commentedOnYourStory({required Object actorName}) => '${actorName} உங்கள் கதையில் கருத்து தெரிவித்தார்';
	@override String repliedToYourComment({required Object actorName}) => '${actorName} உங்கள் கருத்துக்கு பதிலளித்தார்';
	@override String startedFollowingYou({required Object actorName}) => '${actorName} உங்களை பின்தொடரத் தொடங்கினார்';
	@override String sentYouAMessage({required Object actorName}) => '${actorName} உங்களுக்கு ஒரு செய்தியை அனுப்பினார்';
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
	@override String get errorTitle => 'அப்பா! ஏதோ தவறு நடந்தது';
	@override String get tryAgain => 'மீண்டும் முயற்சிக்கவும்';
	@override String get noStoriesAvailable => 'கதைகள் எதுவும் இல்லை';
	@override String get noImagesAvailable => 'படப் பதிவுகள் எதுவும் இல்லை';
	@override String get noTextPostsAvailable => 'சிந்தனை பதிவுகள் எதுவும் இல்லை';
	@override String get noContentAvailable => 'உள்ளடக்கம் எதுவும் இல்லை';
	@override String get refresh => 'புதுப்பிக்க';
	@override String get comments => 'கருத்துகள்';
	@override String get commentsComingSoon => 'கருத்துகள் விரைவில் வருகிறது';
	@override String get addCommentHint => 'கருத்தைச் சேர்க்கவும்...';
	@override String get shareStory => 'கதையை பகிரவும்';
	@override String get sharePost => 'பதிவை பகிரவும்';
	@override String get shareThought => 'சிந்தனையை பகிரவும்';
	@override String get shareAsImage => 'படமாக பகிரவும்';
	@override String get shareAsImageSubtitle => 'அழகான முன்னோட்ட அட்டையை உருவாக்கவும்';
	@override String get shareLink => 'இணைப்பை பகிரவும்';
	@override String get shareLinkSubtitle => 'கதை இணைப்பை நகலெடுக்க அல்லது பகிரவும்';
	@override String get shareImageLinkSubtitle => 'பதிவு இணைப்பை நகலெடுக்க அல்லது பகிரவும்';
	@override String get shareTextLinkSubtitle => 'சிந்தனை இணைப்பை நகலெடுக்க அல்லது பகிரவும்';
	@override String get shareAsText => 'உரையாக பகிரவும்';
	@override String get shareAsTextSubtitle => 'கதையின் சுருக்கத்தை பகிரவும்';
	@override String get shareQuote => 'மேற்கோளை பகிரவும்';
	@override String get shareQuoteSubtitle => 'மேற்கோள் உரையாக பகிரவும்';
	@override String get shareWithImage => 'படத்துடன் பகிரவும்';
	@override String get shareWithImageSubtitle => 'தலைப்புடன் படத்தை பகிரவும்';
	@override String get copyLink => 'இணைப்பை நகலெடு';
	@override String get copyLinkSubtitle => 'கிளிப்போர்டுக்கு இணைப்பை நகலெடுக்கவும்';
	@override String get copyText => 'உரையை நகலெடு';
	@override String get copyTextSubtitle => 'கிளிப்போர்டுக்கு மேற்கோளை நகலெடுக்கவும்';
	@override String get linkCopied => 'இணைப்பு கிளிப்போர்டுக்கு நகலெடுக்கப்பட்டது';
	@override String get textCopied => 'உரை கிளிப்போர்டுக்கு நகலெடுக்கப்பட்டது';
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
	@override late final _TranslationsFeedTabsTa tabs = _TranslationsFeedTabsTa._(_root);
	@override String get tapToShowCaption => 'தலைப்பைக் காட்ட தட்டவும்';
	@override String get noVideosAvailable => 'வீடியோக்கள் எதுவும் இல்லை';
}

// Path: homeScreen
class _TranslationsHomeScreenTa extends TranslationsHomeScreenEn {
	_TranslationsHomeScreenTa._(TranslationsTa root) : this._root = root, super.internal(root);

	final TranslationsTa _root; // ignore: unused_field

	// Translations
	@override String get greeting => 'வணக்கம்';
	@override String get quoteOfTheDay => 'இன்றைய மேற்கோள்';
	@override String get shareQuote => 'மேற்கோளைப் பகிரவும்';
	@override String get copyQuote => 'மேற்கோளை நகலெடுக்கவும்';
	@override String get quoteCopied => 'மேற்கோள் கிளிப்போர்டில் நகலெடுக்கப்பட்டது';
	@override String get featuredStories => 'சிறப்புக் கதைகள்';
	@override String get quickActions => 'விரைவு செயல்கள்';
	@override String get generateStory => 'கதை உருவாக்கு';
	@override String get chatWithKrishna => 'கிருஷ்ணருடன் அரட்டை';
	@override String get myActivity => 'என் செயல்பாடு';
	@override String get continueReading => 'படிப்பைத் தொடரவும்';
	@override String get savedStories => 'சேமித்த கதைகள்';
	@override String get seeAll => 'அனைத்தையும் காண்க';
	@override String get startReading => 'படிக்கத் தொடங்குங்கள்';
	@override String get exploreStories => 'உங்கள் பயணத்தைத் தொடங்க கதைகளை ஆராயுங்கள்';
	@override String get saveForLater => 'நீங்கள் விரும்பும் கதைகளை புக்மார்க் செய்யுங்கள்';
	@override String get noActivityYet => 'இதுவரை செயல்பாடு இல்லை';
	@override String minLeft({required Object count}) => '${count} நிமிடம் மீதம்';
	@override String get activityHistory => 'செயல்பாட்டு வரலாறு';
	@override String get storyGenerated => 'கதை உருவாக்கப்பட்டது';
	@override String get storyRead => 'கதை படிக்கப்பட்டது';
	@override String get storyBookmarked => 'கதை புக்மார்க் செய்யப்பட்டது';
	@override String get storyShared => 'கதை பகிரப்பட்டது';
	@override String get storyCompleted => 'கதை முடிக்கப்பட்டது';
	@override String get today => 'இன்று';
	@override String get yesterday => 'நேற்று';
	@override String get thisWeek => 'இந்த வாரம்';
	@override String get earlier => 'முன்னர்';
	@override String get noContinueReading => 'படிக்க எதுவும் இல்லை';
	@override String get noSavedStories => 'சேமித்த கதைகள் இல்லை';
	@override String get bookmarkStoriesToSave => 'சேமிக்க கதைகளை புக்மார்க் செய்யவும்';
}

// Path: storyGenerator.storyLength
class _TranslationsStoryGeneratorStoryLengthTa extends TranslationsStoryGeneratorStoryLengthEn {
	_TranslationsStoryGeneratorStoryLengthTa._(TranslationsTa root) : this._root = root, super.internal(root);

	final TranslationsTa _root; // ignore: unused_field

	// Translations
	@override String get short => 'குறுகிய';
	@override String get medium => 'நடுத்தர';
	@override String get long => 'நீண்ட';
	@override String get epic => 'இதிகாசம்';
}

// Path: storyGenerator.format
class _TranslationsStoryGeneratorFormatTa extends TranslationsStoryGeneratorFormatEn {
	_TranslationsStoryGeneratorFormatTa._(TranslationsTa root) : this._root = root, super.internal(root);

	final TranslationsTa _root; // ignore: unused_field

	// Translations
	@override String get narrative => 'கதை சொல்லல்';
	@override String get dialogue => 'உரையாடல் அடிப்படை';
	@override String get poetic => 'கவிதை';
	@override String get scriptural => 'வேத நூல்';
}

// Path: storyGenerator.hints
class _TranslationsStoryGeneratorHintsTa extends TranslationsStoryGeneratorHintsEn {
	_TranslationsStoryGeneratorHintsTa._(TranslationsTa root) : this._root = root, super.internal(root);

	final TranslationsTa _root; // ignore: unused_field

	// Translations
	@override String get krishnaTeaching => 'கிருஷ்ணர் அர்ஜுனனுக்கு கற்பிக்கும் கதை...';
	@override String get warriorRedemption => 'விடுதலை தேடும் வீரனின் இதிகாசம்...';
	@override String get sageWisdom => 'முனிவர்களின் ஞானக் கதை...';
	@override String get devotedSeeker => 'பக்தனின் பயணம்...';
	@override String get divineIntervention => 'தெய்வீக தலையீட்டின் புராணம்...';
}

// Path: storyGenerator.errors
class _TranslationsStoryGeneratorErrorsTa extends TranslationsStoryGeneratorErrorsEn {
	_TranslationsStoryGeneratorErrorsTa._(TranslationsTa root) : this._root = root, super.internal(root);

	final TranslationsTa _root; // ignore: unused_field

	// Translations
	@override String get incompletePrompt => 'அனைத்து தேவையான விருப்பங்களையும் முடிக்கவும்';
	@override String get generationFailed => 'கதை உருவாக்க முடியவில்லை. மீண்டும் முயற்சிக்கவும்.';
}

// Path: feed.tabs
class _TranslationsFeedTabsTa extends TranslationsFeedTabsEn {
	_TranslationsFeedTabsTa._(TranslationsTa root) : this._root = root, super.internal(root);

	final TranslationsTa _root; // ignore: unused_field

	// Translations
	@override String get all => 'அனைத்தும்';
	@override String get stories => 'கதைகள்';
	@override String get posts => 'பதிவுகள்';
	@override String get videos => 'வீடியோக்கள்';
	@override String get images => 'படங்கள்';
	@override String get text => 'சிந்தனைகள்';
}
