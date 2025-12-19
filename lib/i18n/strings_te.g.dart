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
class TranslationsTe with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsTe({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.te,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <te>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsTe _root = this; // ignore: unused_field

	@override 
	TranslationsTe $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsTe(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsAppTe app = _TranslationsAppTe._(_root);
	@override late final _TranslationsCommonTe common = _TranslationsCommonTe._(_root);
	@override late final _TranslationsNavigationTe navigation = _TranslationsNavigationTe._(_root);
	@override late final _TranslationsHomeTe home = _TranslationsHomeTe._(_root);
	@override late final _TranslationsStoriesTe stories = _TranslationsStoriesTe._(_root);
	@override late final _TranslationsStoryGeneratorTe storyGenerator = _TranslationsStoryGeneratorTe._(_root);
	@override late final _TranslationsChatTe chat = _TranslationsChatTe._(_root);
	@override late final _TranslationsMapTe map = _TranslationsMapTe._(_root);
	@override late final _TranslationsCommunityTe community = _TranslationsCommunityTe._(_root);
	@override late final _TranslationsSettingsTe settings = _TranslationsSettingsTe._(_root);
	@override late final _TranslationsAuthTe auth = _TranslationsAuthTe._(_root);
	@override late final _TranslationsErrorTe error = _TranslationsErrorTe._(_root);
	@override late final _TranslationsSubscriptionTe subscription = _TranslationsSubscriptionTe._(_root);
	@override late final _TranslationsNotificationTe notification = _TranslationsNotificationTe._(_root);
	@override late final _TranslationsProfileTe profile = _TranslationsProfileTe._(_root);
	@override late final _TranslationsFeedTe feed = _TranslationsFeedTe._(_root);
}

// Path: app
class _TranslationsAppTe implements TranslationsAppEn {
	_TranslationsAppTe._(this._root);

	final TranslationsTe _root; // ignore: unused_field

	// Translations
	@override String get name => 'మైఇతిహాస్';
	@override String get tagline => 'భారతీయ పురాణాలను కనుగొనండి';
}

// Path: common
class _TranslationsCommonTe implements TranslationsCommonEn {
	_TranslationsCommonTe._(this._root);

	final TranslationsTe _root; // ignore: unused_field

	// Translations
	@override String get ok => 'సరే';
	@override String get cancel => 'రద్దు';
	@override String get confirm => 'నిర్ధారించండి';
	@override String get delete => 'తొలగించు';
	@override String get edit => 'సవరించు';
	@override String get save => 'సేవ్ చేయి';
	@override String get share => 'పంచుకోండి';
	@override String get search => 'వెతకండి';
	@override String get loading => 'లోడ్ అవుతోంది...';
	@override String get error => 'దోషం';
	@override String get retry => 'మళ్లీ ప్రయత్నించండి';
	@override String get back => 'వెనుకకు';
	@override String get next => 'తదుపరి';
	@override String get finish => 'ముగించు';
	@override String get skip => 'దాటవేయి';
	@override String get yes => 'అవును';
	@override String get no => 'కాదు';
	@override String get read_full_story => 'Read the full story';
}

// Path: navigation
class _TranslationsNavigationTe implements TranslationsNavigationEn {
	_TranslationsNavigationTe._(this._root);

	final TranslationsTe _root; // ignore: unused_field

	// Translations
	@override String get home => 'హోమ్';
	@override String get stories => 'కథలు';
	@override String get chat => 'చాట్';
	@override String get map => 'మ్యాప్';
	@override String get community => 'సంఘం';
	@override String get settings => 'సెట్టింగ్స్';
	@override String get profile => 'ప్రొఫైల్';
}

// Path: home
class _TranslationsHomeTe implements TranslationsHomeEn {
	_TranslationsHomeTe._(this._root);

	final TranslationsTe _root; // ignore: unused_field

	// Translations
	@override String get title => 'మైఇతిహాస్';
	@override String get storyGenerator => 'కథ జనరేటర్';
	@override String get chatItihas => 'చాట్ఇతిహాస్';
	@override String get communityStories => 'సంఘ కథలు';
	@override String get maps => 'మ్యాప్స్';
	@override String get greetingMorning => 'శుభోదయం';
	@override String get continueReading => 'చదవడం కొనసాగించండి';
	@override String get greetingAfternoon => 'శుభ మధ్యాహ్నం';
	@override String get greetingEvening => 'శుభ సాయంత్రం';
	@override String get exploreStories => 'కథలను అన్వేషించండి';
	@override String get generateStory => 'కథ రూపొందించండి';
	@override String get content => 'Home Content';
}

// Path: stories
class _TranslationsStoriesTe implements TranslationsStoriesEn {
	_TranslationsStoriesTe._(this._root);

	final TranslationsTe _root; // ignore: unused_field

	// Translations
	@override String get title => 'కథలు';
	@override String get searchHint => 'శీర్షిక లేదా రచయిత ద్వారా వెతకండి...';
	@override String get sortBy => 'క్రమీకరించు';
	@override String get sortNewest => 'కొత్తవి మొదట';
	@override String get sortOldest => 'పాతవి మొదట';
	@override String get sortPopular => 'అత్యంత ప్రజాదరణ';
	@override String get noStories => 'కథలు కనుగొనబడలేదు';
	@override String get loadingStories => 'కథలు లోడ్ అవుతున్నాయి...';
	@override String get errorLoadingStories => 'కథలు లోడ్ చేయడంలో విఫలమైంది';
	@override String get storyDetails => 'కథ వివరాలు';
	@override String get continueReading => 'చదవడం కొనసాగించండి';
	@override String get readMore => 'మరింత చదవండి';
	@override String get readLess => 'తక్కువ చదవండి';
	@override String get author => 'రచయిత';
	@override String get publishedOn => 'ప్రచురించబడింది';
	@override String get category => 'వర్గం';
	@override String get tags => 'ట్యాగ్స్';
	@override String get failed_to_load => 'Failed to load story';
}

// Path: storyGenerator
class _TranslationsStoryGeneratorTe implements TranslationsStoryGeneratorEn {
	_TranslationsStoryGeneratorTe._(this._root);

	final TranslationsTe _root; // ignore: unused_field

	// Translations
	@override String get title => 'కథ జనరేటర్';
	@override String get subtitle => 'మీ స్వంత పురాణ కథను సృష్టించండి';
	@override String get selectCharacter => 'పాత్రను ఎంచుకోండి';
	@override String get selectTheme => 'థీమ్ను ఎంచుకోండి';
	@override String get selectLanguage => 'భాషను ఎంచుకోండి';
	@override String get selectLength => 'కథ పొడవు';
	@override String get generate => 'కథను రూపొందించండి';
	@override String get generating => 'మీ కథ రూపొందించబడుతోంది...';
	@override String get generatedStory => 'మీ రూపొందించిన కథ';
	@override String get regenerate => 'మళ్లీ రూపొందించండి';
	@override String get saveStory => 'కథను సేవ్ చేయండి';
	@override String get shareStory => 'కథను పంచుకోండి';
	@override late final _TranslationsStoryGeneratorStoryLengthTe storyLength = _TranslationsStoryGeneratorStoryLengthTe._(_root);
}

// Path: chat
class _TranslationsChatTe implements TranslationsChatEn {
	_TranslationsChatTe._(this._root);

	final TranslationsTe _root; // ignore: unused_field

	// Translations
	@override String get title => 'చాట్ఇతిహాస్';
	@override String get subtitle => 'పురాణాల గురించి AI తో చాట్ చేయండి';
	@override String get friendMode => 'స్నేహితుడి మోడ్';
	@override String get philosophicalMode => 'తత్వశాస్త్ర మోడ్';
	@override String get typeMessage => 'మీ సందేశాన్ని టైప్ చేయండి...';
	@override String get send => 'పంపండి';
	@override String get newChat => 'కొత్త చాట్';
	@override String get chatHistory => 'చాట్ చరిత్ర';
	@override String get clearChat => 'చాట్ను తొలగించండి';
	@override String get noMessages => 'ఇంకా సందేశాలు లేవు. సంభాషణ ప్రారంభించండి!';
	@override String get list_page => 'Chat List Page';
}

// Path: map
class _TranslationsMapTe implements TranslationsMapEn {
	_TranslationsMapTe._(this._root);

	final TranslationsTe _root; // ignore: unused_field

	// Translations
	@override String get title => 'అఖండ భారతం';
	@override String get subtitle => 'చారిత్రక స్థలాలను అన్వేషించండి';
	@override String get searchLocation => 'స్థలాన్ని వెతకండి...';
	@override String get viewDetails => 'వివరాలను చూడండి';
	@override String get showRoute => 'మార్గాన్ని చూపించు';
	@override String get historicalInfo => 'చారిత్రక సమాచారం';
	@override String get nearbyPlaces => 'సమీప ప్రదేశాలు';
}

// Path: community
class _TranslationsCommunityTe implements TranslationsCommunityEn {
	_TranslationsCommunityTe._(this._root);

	final TranslationsTe _root; // ignore: unused_field

	// Translations
	@override String get title => 'సంఘం';
	@override String get trending => 'ట్రెండింగ్';
	@override String get following => 'ఫాలోయింగ్';
	@override String get followers => 'ఫాలోవర్స్';
	@override String get posts => 'పోస్ట్లు';
	@override String get follow => 'ఫాలో చేయండి';
	@override String get unfollow => 'అన్ఫాలో చేయండి';
	@override String get shareYourStory => 'మీ కథను పంచుకోండి...';
	@override String get post => 'పోస్ట్ చేయండి';
	@override String get like => 'ఇష్టం';
	@override String get comment => 'వ్యాఖ్య';
	@override String get comments => 'వ్యాఖ్యలు';
	@override String get noPostsYet => 'ఇంకా పోస్ట్లు లేవు';
}

// Path: settings
class _TranslationsSettingsTe implements TranslationsSettingsEn {
	_TranslationsSettingsTe._(this._root);

	final TranslationsTe _root; // ignore: unused_field

	// Translations
	@override String get title => 'సెట్టింగ్స్';
	@override String get language => 'భాష';
	@override String get theme => 'థీమ్';
	@override String get themeLight => 'లైట్';
	@override String get themeDark => 'డార్క్';
	@override String get themeSystem => 'సిస్టమ్ డిఫాల్ట్';
	@override String get notifications => 'నోటిఫికేషన్స్';
	@override String get account => 'ఖాతా';
	@override String get privacy => 'గోప్యత';
	@override String get about => 'మా గురించి';
	@override String get version => 'వెర్షన్';
	@override String get logout => 'లాగ్అవుట్';
}

// Path: auth
class _TranslationsAuthTe implements TranslationsAuthEn {
	_TranslationsAuthTe._(this._root);

	final TranslationsTe _root; // ignore: unused_field

	// Translations
	@override String get login => 'లాగిన్';
	@override String get signup => 'సైన్అప్';
	@override String get email => 'ఇమెయిల్';
	@override String get password => 'పాస్వర్డ్';
	@override String get confirmPassword => 'పాస్వర్డ్ను నిర్ధారించండి';
	@override String get forgotPassword => 'పాస్వర్డ్ మర్చిపోయారా?';
	@override String get resetPassword => 'పాస్వర్డ్ రీసెట్';
	@override String get dontHaveAccount => 'ఖాతా లేదా?';
	@override String get alreadyHaveAccount => 'ఇప్పటికే ఖాతా ఉందా?';
	@override String get loginSuccess => 'లాగిన్ విజయవంతం';
	@override String get signupSuccess => 'సైన్అప్ విజయవంతం';
	@override String get loginError => 'లాగిన్ విఫలమైంది';
	@override String get signupError => 'సైన్అప్ విఫలమైంది';
}

// Path: error
class _TranslationsErrorTe implements TranslationsErrorEn {
	_TranslationsErrorTe._(this._root);

	final TranslationsTe _root; // ignore: unused_field

	// Translations
	@override String get network => 'ఇంటర్నెట్ కనెక్షన్ లేదు';
	@override String get server => 'సర్వర్ లోపం సంభవించింది';
	@override String get cache => 'కాష్ చేసిన డేటాను లోడ్ చేయడంలో విఫలమైంది';
	@override String get timeout => 'అభ్యర్థన గడువు ముగిసింది';
	@override String get notFound => 'వనరు కనుగొనబడలేదు';
	@override String get validation => 'ధృవీకరణ విఫలమైంది';
	@override String get unexpected => 'అనుకోని లోపం సంభవించింది';
	@override String get tryAgain => 'దయచేసి మళ్లీ ప్రయత్నించండి';
}

// Path: subscription
class _TranslationsSubscriptionTe implements TranslationsSubscriptionEn {
	_TranslationsSubscriptionTe._(this._root);

	final TranslationsTe _root; // ignore: unused_field

	// Translations
	@override String get free => 'ఉచితం';
	@override String get plus => 'ప్లస్';
	@override String get pro => 'ప్రో';
	@override String get upgradeToPro => 'ప్రోకు అప్గ్రేడ్ చేయండి';
	@override String get features => 'ఫీచర్లు';
	@override String get subscribe => 'సబ్స్క్రైబ్ చేయండి';
	@override String get currentPlan => 'ప్రస్తుత ప్లాన్';
	@override String get managePlan => 'ప్లాన్ను నిర్వహించండి';
}

// Path: notification
class _TranslationsNotificationTe implements TranslationsNotificationEn {
	_TranslationsNotificationTe._(this._root);

	final TranslationsTe _root; // ignore: unused_field

	// Translations
	@override String get title => 'నోటిఫికేషన్స్';
	@override String get markAllRead => 'అన్నింటినీ చదివినట్టు గుర్తించు';
	@override String get noNotifications => 'ఇంకా నోటిఫికేషన్స్ లేవు';
	@override String get errorPrefix => 'లోపం:';
	@override String get retry => 'మళ్లీ ప్రయత్నించు';
	@override String get likedYourStory => '{{actorName}} మీ కథను ఇష్టపడ్డారు';
	@override String get commentedOnYourStory => '{{actorName}} మీ కథను వ్యాఖ్యానించారు';
	@override String get repliedToYourComment => '{{actorName}} మీ వ్యాఖ్యకు సమాధానం ఇచ్చారు';
	@override String get startedFollowingYou => '{{actorName}} మిమ్మల్ని అనుసరించటం ప్రారంభించారు';
	@override String get sentYouAMessage => '{{actorName}} మీకు సందేశం పంపారు';
}

// Path: profile
class _TranslationsProfileTe implements TranslationsProfileEn {
	_TranslationsProfileTe._(this._root);

	final TranslationsTe _root; // ignore: unused_field

	// Translations
	@override String get followers => 'అనుసరించేవారు';
	@override String get following => 'అనుసరిస్తున్నారు';
	@override String get unfollow => 'అనుసరించవద్దు';
	@override String get follow => 'అనుసరించు';
	@override String get about => 'గురించి';
	@override String get stories => 'కథలు';
}

// Path: feed
class _TranslationsFeedTe implements TranslationsFeedEn {
	_TranslationsFeedTe._(this._root);

	final TranslationsTe _root; // ignore: unused_field

	// Translations
	@override String get loading => 'కథలు లోడ్ అవుతున్నాయి...';
	@override String get errorTitle => 'అయ్యో! ఏదో తప్పు జరిగింది';
	@override String get tryAgain => 'మళ్లీ ప్రయత్నించు';
	@override String get noStoriesAvailable => 'కథలు అందుబాటులో లేవు';
	@override String get refresh => 'రిఫ్రెష్';
	@override String get comments => 'వ్యాఖ్యలు';
	@override String get commentsComingSoon => 'వ్యాఖ్యలు త్వరలో వస్తాయి';
	@override String get addCommentHint => 'వ్యాఖ్యను జోడించండి...';
	@override String get shareStory => 'కథను పంచుకోండి';
	@override String get shareAsImage => 'చిత్రంగా పంచుకోండి';
	@override String get shareAsImageSubtitle => 'అందమైన ప్రివ్యూ కార్డ్‌ను సృష్టించండి';
	@override String get shareLink => 'లింక్ పంచుకోండి';
	@override String get shareLinkSubtitle => 'కథ లింక్‌ను కాపీ చేయండి లేదా పంచుకోండి';
	@override String get shareAsText => 'పాఠ్యంగా పంచుకోండి';
	@override String get shareAsTextSubtitle => 'కథ సారాంశాన్ని పంచుకోండి';
	@override String get sendToUser => 'వినియోగదారునికి పంపండి';
	@override String get sendToUserSubtitle => 'స్నేహితుడితో నేరుగా పంచుకోండి';
	@override String get chooseFormat => 'ఫార్మాట్ ఎంచుకోండి';
	@override String get linkPreview => 'లింక్ ప్రివ్యూ';
	@override String get linkPreviewSize => '1200 × 630';
	@override String get storyFormat => 'స్టోరీ ఫార్మాట్';
	@override String get storyFormatSize => '1080 × 1920 (Instagram/Stories)';
	@override String get generatingPreview => 'ప్రివ్యూ రూపొందుతోంది...';
	@override String get bookmarked => 'బుక్‌మార్క్ చేయబడింది';
	@override String get removedFromBookmarks => 'బుక్‌మార్క్‌ల నుండి తీసివేయబడింది';
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
class _TranslationsStoryGeneratorStoryLengthTe implements TranslationsStoryGeneratorStoryLengthEn {
	_TranslationsStoryGeneratorStoryLengthTe._(this._root);

	final TranslationsTe _root; // ignore: unused_field

	// Translations
	@override String get short => 'చిన్నది';
	@override String get medium => 'మధ్యస్థం';
	@override String get long => 'పొడవైనది';
}

/// The flat map containing all translations for locale <te>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsTe {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.name' => 'మైఇతిహాస్',
			'app.tagline' => 'భారతీయ పురాణాలను కనుగొనండి',
			'common.ok' => 'సరే',
			'common.cancel' => 'రద్దు',
			'common.confirm' => 'నిర్ధారించండి',
			'common.delete' => 'తొలగించు',
			'common.edit' => 'సవరించు',
			'common.save' => 'సేవ్ చేయి',
			'common.share' => 'పంచుకోండి',
			'common.search' => 'వెతకండి',
			'common.loading' => 'లోడ్ అవుతోంది...',
			'common.error' => 'దోషం',
			'common.retry' => 'మళ్లీ ప్రయత్నించండి',
			'common.back' => 'వెనుకకు',
			'common.next' => 'తదుపరి',
			'common.finish' => 'ముగించు',
			'common.skip' => 'దాటవేయి',
			'common.yes' => 'అవును',
			'common.no' => 'కాదు',
			'common.read_full_story' => 'Read the full story',
			'navigation.home' => 'హోమ్',
			'navigation.stories' => 'కథలు',
			'navigation.chat' => 'చాట్',
			'navigation.map' => 'మ్యాప్',
			'navigation.community' => 'సంఘం',
			'navigation.settings' => 'సెట్టింగ్స్',
			'navigation.profile' => 'ప్రొఫైల్',
			'home.title' => 'మైఇతిహాస్',
			'home.storyGenerator' => 'కథ జనరేటర్',
			'home.chatItihas' => 'చాట్ఇతిహాస్',
			'home.communityStories' => 'సంఘ కథలు',
			'home.maps' => 'మ్యాప్స్',
			'home.greetingMorning' => 'శుభోదయం',
			'home.continueReading' => 'చదవడం కొనసాగించండి',
			'home.greetingAfternoon' => 'శుభ మధ్యాహ్నం',
			'home.greetingEvening' => 'శుభ సాయంత్రం',
			'home.exploreStories' => 'కథలను అన్వేషించండి',
			'home.generateStory' => 'కథ రూపొందించండి',
			'home.content' => 'Home Content',
			'stories.title' => 'కథలు',
			'stories.searchHint' => 'శీర్షిక లేదా రచయిత ద్వారా వెతకండి...',
			'stories.sortBy' => 'క్రమీకరించు',
			'stories.sortNewest' => 'కొత్తవి మొదట',
			'stories.sortOldest' => 'పాతవి మొదట',
			'stories.sortPopular' => 'అత్యంత ప్రజాదరణ',
			'stories.noStories' => 'కథలు కనుగొనబడలేదు',
			'stories.loadingStories' => 'కథలు లోడ్ అవుతున్నాయి...',
			'stories.errorLoadingStories' => 'కథలు లోడ్ చేయడంలో విఫలమైంది',
			'stories.storyDetails' => 'కథ వివరాలు',
			'stories.continueReading' => 'చదవడం కొనసాగించండి',
			'stories.readMore' => 'మరింత చదవండి',
			'stories.readLess' => 'తక్కువ చదవండి',
			'stories.author' => 'రచయిత',
			'stories.publishedOn' => 'ప్రచురించబడింది',
			'stories.category' => 'వర్గం',
			'stories.tags' => 'ట్యాగ్స్',
			'stories.failed_to_load' => 'Failed to load story',
			'storyGenerator.title' => 'కథ జనరేటర్',
			'storyGenerator.subtitle' => 'మీ స్వంత పురాణ కథను సృష్టించండి',
			'storyGenerator.selectCharacter' => 'పాత్రను ఎంచుకోండి',
			'storyGenerator.selectTheme' => 'థీమ్ను ఎంచుకోండి',
			'storyGenerator.selectLanguage' => 'భాషను ఎంచుకోండి',
			'storyGenerator.selectLength' => 'కథ పొడవు',
			'storyGenerator.generate' => 'కథను రూపొందించండి',
			'storyGenerator.generating' => 'మీ కథ రూపొందించబడుతోంది...',
			'storyGenerator.generatedStory' => 'మీ రూపొందించిన కథ',
			'storyGenerator.regenerate' => 'మళ్లీ రూపొందించండి',
			'storyGenerator.saveStory' => 'కథను సేవ్ చేయండి',
			'storyGenerator.shareStory' => 'కథను పంచుకోండి',
			'storyGenerator.storyLength.short' => 'చిన్నది',
			'storyGenerator.storyLength.medium' => 'మధ్యస్థం',
			'storyGenerator.storyLength.long' => 'పొడవైనది',
			'chat.title' => 'చాట్ఇతిహాస్',
			'chat.subtitle' => 'పురాణాల గురించి AI తో చాట్ చేయండి',
			'chat.friendMode' => 'స్నేహితుడి మోడ్',
			'chat.philosophicalMode' => 'తత్వశాస్త్ర మోడ్',
			'chat.typeMessage' => 'మీ సందేశాన్ని టైప్ చేయండి...',
			'chat.send' => 'పంపండి',
			'chat.newChat' => 'కొత్త చాట్',
			'chat.chatHistory' => 'చాట్ చరిత్ర',
			'chat.clearChat' => 'చాట్ను తొలగించండి',
			'chat.noMessages' => 'ఇంకా సందేశాలు లేవు. సంభాషణ ప్రారంభించండి!',
			'chat.list_page' => 'Chat List Page',
			'map.title' => 'అఖండ భారతం',
			'map.subtitle' => 'చారిత్రక స్థలాలను అన్వేషించండి',
			'map.searchLocation' => 'స్థలాన్ని వెతకండి...',
			'map.viewDetails' => 'వివరాలను చూడండి',
			'map.showRoute' => 'మార్గాన్ని చూపించు',
			'map.historicalInfo' => 'చారిత్రక సమాచారం',
			'map.nearbyPlaces' => 'సమీప ప్రదేశాలు',
			'community.title' => 'సంఘం',
			'community.trending' => 'ట్రెండింగ్',
			'community.following' => 'ఫాలోయింగ్',
			'community.followers' => 'ఫాలోవర్స్',
			'community.posts' => 'పోస్ట్లు',
			'community.follow' => 'ఫాలో చేయండి',
			'community.unfollow' => 'అన్ఫాలో చేయండి',
			'community.shareYourStory' => 'మీ కథను పంచుకోండి...',
			'community.post' => 'పోస్ట్ చేయండి',
			'community.like' => 'ఇష్టం',
			'community.comment' => 'వ్యాఖ్య',
			'community.comments' => 'వ్యాఖ్యలు',
			'community.noPostsYet' => 'ఇంకా పోస్ట్లు లేవు',
			'settings.title' => 'సెట్టింగ్స్',
			'settings.language' => 'భాష',
			'settings.theme' => 'థీమ్',
			'settings.themeLight' => 'లైట్',
			'settings.themeDark' => 'డార్క్',
			'settings.themeSystem' => 'సిస్టమ్ డిఫాల్ట్',
			'settings.notifications' => 'నోటిఫికేషన్స్',
			'settings.account' => 'ఖాతా',
			'settings.privacy' => 'గోప్యత',
			'settings.about' => 'మా గురించి',
			'settings.version' => 'వెర్షన్',
			'settings.logout' => 'లాగ్అవుట్',
			'auth.login' => 'లాగిన్',
			'auth.signup' => 'సైన్అప్',
			'auth.email' => 'ఇమెయిల్',
			'auth.password' => 'పాస్వర్డ్',
			'auth.confirmPassword' => 'పాస్వర్డ్ను నిర్ధారించండి',
			'auth.forgotPassword' => 'పాస్వర్డ్ మర్చిపోయారా?',
			'auth.resetPassword' => 'పాస్వర్డ్ రీసెట్',
			'auth.dontHaveAccount' => 'ఖాతా లేదా?',
			'auth.alreadyHaveAccount' => 'ఇప్పటికే ఖాతా ఉందా?',
			'auth.loginSuccess' => 'లాగిన్ విజయవంతం',
			'auth.signupSuccess' => 'సైన్అప్ విజయవంతం',
			'auth.loginError' => 'లాగిన్ విఫలమైంది',
			'auth.signupError' => 'సైన్అప్ విఫలమైంది',
			'error.network' => 'ఇంటర్నెట్ కనెక్షన్ లేదు',
			'error.server' => 'సర్వర్ లోపం సంభవించింది',
			'error.cache' => 'కాష్ చేసిన డేటాను లోడ్ చేయడంలో విఫలమైంది',
			'error.timeout' => 'అభ్యర్థన గడువు ముగిసింది',
			'error.notFound' => 'వనరు కనుగొనబడలేదు',
			'error.validation' => 'ధృవీకరణ విఫలమైంది',
			'error.unexpected' => 'అనుకోని లోపం సంభవించింది',
			'error.tryAgain' => 'దయచేసి మళ్లీ ప్రయత్నించండి',
			'subscription.free' => 'ఉచితం',
			'subscription.plus' => 'ప్లస్',
			'subscription.pro' => 'ప్రో',
			'subscription.upgradeToPro' => 'ప్రోకు అప్గ్రేడ్ చేయండి',
			'subscription.features' => 'ఫీచర్లు',
			'subscription.subscribe' => 'సబ్స్క్రైబ్ చేయండి',
			'subscription.currentPlan' => 'ప్రస్తుత ప్లాన్',
			'subscription.managePlan' => 'ప్లాన్ను నిర్వహించండి',
			'notification.title' => 'నోటిఫికేషన్స్',
			'notification.markAllRead' => 'అన్నింటినీ చదివినట్టు గుర్తించు',
			'notification.noNotifications' => 'ఇంకా నోటిఫికేషన్స్ లేవు',
			'notification.errorPrefix' => 'లోపం:',
			'notification.retry' => 'మళ్లీ ప్రయత్నించు',
			'notification.likedYourStory' => '{{actorName}} మీ కథను ఇష్టపడ్డారు',
			'notification.commentedOnYourStory' => '{{actorName}} మీ కథను వ్యాఖ్యానించారు',
			'notification.repliedToYourComment' => '{{actorName}} మీ వ్యాఖ్యకు సమాధానం ఇచ్చారు',
			'notification.startedFollowingYou' => '{{actorName}} మిమ్మల్ని అనుసరించటం ప్రారంభించారు',
			'notification.sentYouAMessage' => '{{actorName}} మీకు సందేశం పంపారు',
			'profile.followers' => 'అనుసరించేవారు',
			'profile.following' => 'అనుసరిస్తున్నారు',
			'profile.unfollow' => 'అనుసరించవద్దు',
			'profile.follow' => 'అనుసరించు',
			'profile.about' => 'గురించి',
			'profile.stories' => 'కథలు',
			'feed.loading' => 'కథలు లోడ్ అవుతున్నాయి...',
			'feed.errorTitle' => 'అయ్యో! ఏదో తప్పు జరిగింది',
			'feed.tryAgain' => 'మళ్లీ ప్రయత్నించు',
			'feed.noStoriesAvailable' => 'కథలు అందుబాటులో లేవు',
			'feed.refresh' => 'రిఫ్రెష్',
			'feed.comments' => 'వ్యాఖ్యలు',
			'feed.commentsComingSoon' => 'వ్యాఖ్యలు త్వరలో వస్తాయి',
			'feed.addCommentHint' => 'వ్యాఖ్యను జోడించండి...',
			'feed.shareStory' => 'కథను పంచుకోండి',
			'feed.shareAsImage' => 'చిత్రంగా పంచుకోండి',
			'feed.shareAsImageSubtitle' => 'అందమైన ప్రివ్యూ కార్డ్‌ను సృష్టించండి',
			'feed.shareLink' => 'లింక్ పంచుకోండి',
			'feed.shareLinkSubtitle' => 'కథ లింక్‌ను కాపీ చేయండి లేదా పంచుకోండి',
			'feed.shareAsText' => 'పాఠ్యంగా పంచుకోండి',
			'feed.shareAsTextSubtitle' => 'కథ సారాంశాన్ని పంచుకోండి',
			'feed.sendToUser' => 'వినియోగదారునికి పంపండి',
			'feed.sendToUserSubtitle' => 'స్నేహితుడితో నేరుగా పంచుకోండి',
			'feed.chooseFormat' => 'ఫార్మాట్ ఎంచుకోండి',
			'feed.linkPreview' => 'లింక్ ప్రివ్యూ',
			'feed.linkPreviewSize' => '1200 × 630',
			'feed.storyFormat' => 'స్టోరీ ఫార్మాట్',
			'feed.storyFormatSize' => '1080 × 1920 (Instagram/Stories)',
			'feed.generatingPreview' => 'ప్రివ్యూ రూపొందుతోంది...',
			'feed.bookmarked' => 'బుక్‌మార్క్ చేయబడింది',
			'feed.removedFromBookmarks' => 'బుక్‌మార్క్‌ల నుండి తీసివేయబడింది',
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
