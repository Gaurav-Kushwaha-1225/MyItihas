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
class TranslationsTe extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsTe({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.te,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver);

	/// Metadata for the translations of <te>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

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
	@override late final _TranslationsHomeScreenTe homeScreen = _TranslationsHomeScreenTe._(_root);
}

// Path: app
class _TranslationsAppTe extends TranslationsAppEn {
	_TranslationsAppTe._(TranslationsTe root) : this._root = root, super.internal(root);

	final TranslationsTe _root; // ignore: unused_field

	// Translations
	@override String get name => 'మైఇతిహాస్';
	@override String get tagline => 'భారతీయ పురాణాలను కనుగొనండి';
}

// Path: common
class _TranslationsCommonTe extends TranslationsCommonEn {
	_TranslationsCommonTe._(TranslationsTe root) : this._root = root, super.internal(root);

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
	@override String get readFullStory => 'Read the full story';
}

// Path: navigation
class _TranslationsNavigationTe extends TranslationsNavigationEn {
	_TranslationsNavigationTe._(TranslationsTe root) : this._root = root, super.internal(root);

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
class _TranslationsHomeTe extends TranslationsHomeEn {
	_TranslationsHomeTe._(TranslationsTe root) : this._root = root, super.internal(root);

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
class _TranslationsStoriesTe extends TranslationsStoriesEn {
	_TranslationsStoriesTe._(TranslationsTe root) : this._root = root, super.internal(root);

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
	@override String get failedToLoad => 'Failed to load story';
}

// Path: storyGenerator
class _TranslationsStoryGeneratorTe extends TranslationsStoryGeneratorEn {
	_TranslationsStoryGeneratorTe._(TranslationsTe root) : this._root = root, super.internal(root);

	final TranslationsTe _root; // ignore: unused_field

	// Translations
	@override String get title => 'కథ జనరేటర్';
	@override String get subtitle => 'మీ స్వంత పురాణ కథను సృష్టించండి';
	@override String get quickStart => 'త్వరిత ప్రారంభం';
	@override String get interactive => 'ఇంటరాక్టివ్';
	@override String get rawPrompt => 'రా ప్రాంప్ట్';
	@override String get yourStoryPrompt => 'మీ కథ ప్రాంప్ట్';
	@override String get writeYourPrompt => 'మీ ప్రాంప్ట్ రాయండి';
	@override String get selectScripture => 'గ్రంథాన్ని ఎంచుకోండి';
	@override String get selectStoryType => 'కథ రకాన్ని ఎంచుకోండి';
	@override String get selectCharacter => 'పాత్రను ఎంచుకోండి';
	@override String get selectTheme => 'థీమ్ను ఎంచుకోండి';
	@override String get selectSetting => 'సెట్టింగ్ను ఎంచుకోండి';
	@override String get selectLanguage => 'భాషను ఎంచుకోండి';
	@override String get selectLength => 'కథ పొడవు';
	@override String get moreOptions => 'మరిన్ని ఎంపికలు';
	@override String get random => 'యాదృచ్ఛిక';
	@override String get generate => 'కథను రూపొందించండి';
	@override String get generating => 'మీ కథ రూపొందించబడుతోంది...';
	@override String get creatingYourStory => 'మీ కథ సృష్టించబడుతోంది';
	@override String get consultingScriptures => 'పురాతన గ్రంథాలను సంప్రదిస్తోంది...';
	@override String get weavingTale => 'మీ కథను నేస్తోంది...';
	@override String get addingWisdom => 'దివ్య జ్ఞానాన్ని జోడిస్తోంది...';
	@override String get polishingNarrative => 'కథనాన్ని మెరుగుపరుస్తోంది...';
	@override String get almostThere => 'దాదాపు పూర్తయింది...';
	@override String get generatedStory => 'మీ రూపొందించిన కథ';
	@override String get aiGenerated => 'AI సృష్టించింది';
	@override String get regenerate => 'మళ్లీ రూపొందించండి';
	@override String get saveStory => 'కథను సేవ్ చేయండి';
	@override String get shareStory => 'కథను పంచుకోండి';
	@override String get newStory => 'కొత్త కథ';
	@override String get saved => 'సేవ్ చేయబడింది';
	@override String get storySaved => 'కథ మీ లైబ్రరీలో సేవ్ చేయబడింది';
	@override String get story => 'కథ';
	@override String get lesson => 'పాఠం';
	@override String get didYouKnow => 'మీకు తెలుసా?';
	@override String get activity => 'కార్యకలాపం';
	@override String get optionalRefine => 'ఐచ్ఛికం: ఎంపికలతో మెరుగుపరచండి';
	@override String get applyOptions => 'ఎంపికలను వర్తింపజేయండి';
	@override String get language => 'భాష';
	@override String get storyFormat => 'కథ ఫార్మాట్';
	@override late final _TranslationsStoryGeneratorStoryLengthTe storyLength = _TranslationsStoryGeneratorStoryLengthTe._(_root);
	@override late final _TranslationsStoryGeneratorFormatTe format = _TranslationsStoryGeneratorFormatTe._(_root);
	@override late final _TranslationsStoryGeneratorHintsTe hints = _TranslationsStoryGeneratorHintsTe._(_root);
	@override late final _TranslationsStoryGeneratorErrorsTe errors = _TranslationsStoryGeneratorErrorsTe._(_root);
}

// Path: chat
class _TranslationsChatTe extends TranslationsChatEn {
	_TranslationsChatTe._(TranslationsTe root) : this._root = root, super.internal(root);

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
	@override String get listPage => 'Chat List Page';
}

// Path: map
class _TranslationsMapTe extends TranslationsMapEn {
	_TranslationsMapTe._(TranslationsTe root) : this._root = root, super.internal(root);

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
class _TranslationsCommunityTe extends TranslationsCommunityEn {
	_TranslationsCommunityTe._(TranslationsTe root) : this._root = root, super.internal(root);

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
class _TranslationsSettingsTe extends TranslationsSettingsEn {
	_TranslationsSettingsTe._(TranslationsTe root) : this._root = root, super.internal(root);

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
class _TranslationsAuthTe extends TranslationsAuthEn {
	_TranslationsAuthTe._(TranslationsTe root) : this._root = root, super.internal(root);

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
class _TranslationsErrorTe extends TranslationsErrorEn {
	_TranslationsErrorTe._(TranslationsTe root) : this._root = root, super.internal(root);

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
class _TranslationsSubscriptionTe extends TranslationsSubscriptionEn {
	_TranslationsSubscriptionTe._(TranslationsTe root) : this._root = root, super.internal(root);

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
class _TranslationsNotificationTe extends TranslationsNotificationEn {
	_TranslationsNotificationTe._(TranslationsTe root) : this._root = root, super.internal(root);

	final TranslationsTe _root; // ignore: unused_field

	// Translations
	@override String get title => 'నోటిఫికేషన్స్';
	@override String get markAllRead => 'అన్నింటినీ చదివినట్టు గుర్తించు';
	@override String get noNotifications => 'ఇంకా నోటిఫికేషన్స్ లేవు';
	@override String get errorPrefix => 'లోపం:';
	@override String get retry => 'మళ్లీ ప్రయత్నించు';
	@override String likedYourStory({required Object actorName}) => '${actorName} మీ కథను ఇష్టపడ్డారు';
	@override String commentedOnYourStory({required Object actorName}) => '${actorName} మీ కథను వ్యాఖ్యానించారు';
	@override String repliedToYourComment({required Object actorName}) => '${actorName} మీ వ్యాఖ్యకు సమాధానం ఇచ్చారు';
	@override String startedFollowingYou({required Object actorName}) => '${actorName} మిమ్మల్ని అనుసరించటం ప్రారంభించారు';
	@override String sentYouAMessage({required Object actorName}) => '${actorName} మీకు సందేశం పంపారు';
}

// Path: profile
class _TranslationsProfileTe extends TranslationsProfileEn {
	_TranslationsProfileTe._(TranslationsTe root) : this._root = root, super.internal(root);

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
class _TranslationsFeedTe extends TranslationsFeedEn {
	_TranslationsFeedTe._(TranslationsTe root) : this._root = root, super.internal(root);

	final TranslationsTe _root; // ignore: unused_field

	// Translations
	@override String get loading => 'కథలు లోడ్ అవుతున్నాయి...';
	@override String get errorTitle => 'అయ్యో! ఏదో తప్పు జరిగింది';
	@override String get tryAgain => 'మళ్లీ ప్రయత్నించు';
	@override String get noStoriesAvailable => 'కథలు అందుబాటులో లేవు';
	@override String get noImagesAvailable => 'చిత్ర పోస్ట్‌లు అందుబాటులో లేవు';
	@override String get noTextPostsAvailable => 'ఆలోచన పోస్ట్‌లు అందుబాటులో లేవు';
	@override String get noContentAvailable => 'కంటెంట్ అందుబాటులో లేదు';
	@override String get refresh => 'రిఫ్రెష్';
	@override String get comments => 'వ్యాఖ్యలు';
	@override String get commentsComingSoon => 'వ్యాఖ్యలు త్వరలో వస్తాయి';
	@override String get addCommentHint => 'వ్యాఖ్యను జోడించండి...';
	@override String get shareStory => 'కథను పంచుకోండి';
	@override String get sharePost => 'పోస్ట్‌ను పంచుకోండి';
	@override String get shareThought => 'ఆలోచనను పంచుకోండి';
	@override String get shareAsImage => 'చిత్రంగా పంచుకోండి';
	@override String get shareAsImageSubtitle => 'అందమైన ప్రివ్యూ కార్డ్‌ను సృష్టించండి';
	@override String get shareLink => 'లింక్ పంచుకోండి';
	@override String get shareLinkSubtitle => 'కథ లింక్‌ను కాపీ చేయండి లేదా పంచుకోండి';
	@override String get shareImageLinkSubtitle => 'పోస్ట్ లింక్‌ను కాపీ చేయండి లేదా పంచుకోండి';
	@override String get shareTextLinkSubtitle => 'ఆలోచన లింక్‌ను కాపీ చేయండి లేదా పంచుకోండి';
	@override String get shareAsText => 'పాఠ్యంగా పంచుకోండి';
	@override String get shareAsTextSubtitle => 'కథ సారాంశాన్ని పంచుకోండి';
	@override String get shareQuote => 'ఉల్లేఖనాన్ని పంచుకోండి';
	@override String get shareQuoteSubtitle => 'ఉల్లేఖన పాఠ్యంగా పంచుకోండి';
	@override String get shareWithImage => 'చిత్రంతో పంచుకోండి';
	@override String get shareWithImageSubtitle => 'క్యాప్షన్‌తో చిత్రాన్ని పంచుకోండి';
	@override String get copyLink => 'లింక్ కాపీ చేయండి';
	@override String get copyLinkSubtitle => 'క్లిప్‌బోర్డ్‌కు లింక్ కాపీ చేయండి';
	@override String get copyText => 'పాఠ్యం కాపీ చేయండి';
	@override String get copyTextSubtitle => 'క్లిప్‌బోర్డ్‌కు ఉల్లేఖనాన్ని కాపీ చేయండి';
	@override String get linkCopied => 'లింక్ క్లిప్‌బోర్డ్‌కు కాపీ చేయబడింది';
	@override String get textCopied => 'పాఠ్యం క్లిప్‌బోర్డ్‌కు కాపీ చేయబడింది';
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
	@override late final _TranslationsFeedTabsTe tabs = _TranslationsFeedTabsTe._(_root);
	@override String get tapToShowCaption => 'క్యాప్షన్ చూడడానికి నొక్కండి';
	@override String get noVideosAvailable => 'వీడియోలు ఏవీ అందుబాటులో లేవు';
}

// Path: homeScreen
class _TranslationsHomeScreenTe extends TranslationsHomeScreenEn {
	_TranslationsHomeScreenTe._(TranslationsTe root) : this._root = root, super.internal(root);

	final TranslationsTe _root; // ignore: unused_field

	// Translations
	@override String get greeting => 'నమస్కారం';
	@override String get quoteOfTheDay => 'రోజు యొక్క కోట్';
	@override String get shareQuote => 'కోట్ షేర్ చేయండి';
	@override String get copyQuote => 'కోట్ కాపీ చేయండి';
	@override String get quoteCopied => 'కోట్ క్లిప్‌బోర్డ్‌కి కాపీ అయింది';
	@override String get featuredStories => 'ఫీచర్డ్ కథలు';
	@override String get quickActions => 'శీఘ్ర చర్యలు';
	@override String get generateStory => 'కథ రూపొందించండి';
	@override String get chatWithKrishna => 'కృష్ణుడితో చాట్';
	@override String get myActivity => 'నా కార్యకలాపం';
	@override String get continueReading => 'చదవడం కొనసాగించండి';
	@override String get savedStories => 'సేవ్ చేసిన కథలు';
	@override String get seeAll => 'అన్నీ చూడండి';
	@override String get startReading => 'చదవడం ప్రారంభించండి';
	@override String get exploreStories => 'మీ ప్రయాణాన్ని ప్రారంభించడానికి కథలను అన్వేషించండి';
	@override String get saveForLater => 'మీరు ఇష్టపడే కథలను బుక్‌మార్క్ చేయండి';
	@override String get noActivityYet => 'ఇంకా కార్యకలాపం లేదు';
	@override String minLeft({required Object count}) => '${count} నిమిషాలు మిగిలి ఉన్నాయి';
	@override String get activityHistory => 'కార్యకలాప చరిత్ర';
	@override String get storyGenerated => 'కథ రూపొందించబడింది';
	@override String get storyRead => 'కథ చదివారు';
	@override String get storyBookmarked => 'కథ బుక్‌మార్క్ చేయబడింది';
	@override String get storyShared => 'కథ షేర్ చేయబడింది';
	@override String get storyCompleted => 'కథ పూర్తయింది';
	@override String get today => 'ఈరోజు';
	@override String get yesterday => 'నిన్న';
	@override String get thisWeek => 'ఈ వారం';
	@override String get earlier => 'ముందు';
	@override String get noContinueReading => 'చదవడానికి ఏమీ లేదు';
	@override String get noSavedStories => 'సేవ్ చేసిన కథలు లేవు';
	@override String get bookmarkStoriesToSave => 'సేవ్ చేయడానికి కథలను బుక్‌మార్క్ చేయండి';
}

// Path: storyGenerator.storyLength
class _TranslationsStoryGeneratorStoryLengthTe extends TranslationsStoryGeneratorStoryLengthEn {
	_TranslationsStoryGeneratorStoryLengthTe._(TranslationsTe root) : this._root = root, super.internal(root);

	final TranslationsTe _root; // ignore: unused_field

	// Translations
	@override String get short => 'చిన్నది';
	@override String get medium => 'మధ్యస్థం';
	@override String get long => 'పొడవైనది';
	@override String get epic => 'ఇతిహాసం';
}

// Path: storyGenerator.format
class _TranslationsStoryGeneratorFormatTe extends TranslationsStoryGeneratorFormatEn {
	_TranslationsStoryGeneratorFormatTe._(TranslationsTe root) : this._root = root, super.internal(root);

	final TranslationsTe _root; // ignore: unused_field

	// Translations
	@override String get narrative => 'కథనం';
	@override String get dialogue => 'సంభాషణ ఆధారిత';
	@override String get poetic => 'కావ్య';
	@override String get scriptural => 'శాస్త్రీయ';
}

// Path: storyGenerator.hints
class _TranslationsStoryGeneratorHintsTe extends TranslationsStoryGeneratorHintsEn {
	_TranslationsStoryGeneratorHintsTe._(TranslationsTe root) : this._root = root, super.internal(root);

	final TranslationsTe _root; // ignore: unused_field

	// Translations
	@override String get krishnaTeaching => 'కృష్ణుడు అర్జునుడికి బోధించే కథ...';
	@override String get warriorRedemption => 'విముక్తి కోరుకునే యోధుడి ఇతిహాసం...';
	@override String get sageWisdom => 'ఋషుల జ్ఞానం గురించి కథ...';
	@override String get devotedSeeker => 'భక్తుని ప్రయాణం...';
	@override String get divineIntervention => 'దైవ జోక్యం యొక్క గాథ...';
}

// Path: storyGenerator.errors
class _TranslationsStoryGeneratorErrorsTe extends TranslationsStoryGeneratorErrorsEn {
	_TranslationsStoryGeneratorErrorsTe._(TranslationsTe root) : this._root = root, super.internal(root);

	final TranslationsTe _root; // ignore: unused_field

	// Translations
	@override String get incompletePrompt => 'దయచేసి అన్ని అవసరమైన ఎంపికలను పూర్తి చేయండి';
	@override String get generationFailed => 'కథను సృష్టించడంలో విఫలమైంది. దయచేసి మళ్లీ ప్రయత్నించండి.';
}

// Path: feed.tabs
class _TranslationsFeedTabsTe extends TranslationsFeedTabsEn {
	_TranslationsFeedTabsTe._(TranslationsTe root) : this._root = root, super.internal(root);

	final TranslationsTe _root; // ignore: unused_field

	// Translations
	@override String get all => 'అన్నీ';
	@override String get stories => 'కథలు';
	@override String get posts => 'పోస్ట్‌లు';
	@override String get videos => 'వీడియోలు';
	@override String get images => 'చిత్రాలు';
	@override String get text => 'ఆలోచనలు';
}
