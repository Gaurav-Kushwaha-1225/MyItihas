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
	@override late final _TranslationsStoryGeneratorTe story_generator = _TranslationsStoryGeneratorTe._(_root);
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
	@override String get read_full_story => 'Read the full story';
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
	@override String get story_generator => 'కథ జనరేటర్';
	@override String get chat_itihas => 'చాట్ఇతిహాస్';
	@override String get community_stories => 'సంఘ కథలు';
	@override String get maps => 'మ్యాప్స్';
	@override String get greeting_morning => 'శుభోదయం';
	@override String get continue_reading => 'చదవడం కొనసాగించండి';
	@override String get greeting_afternoon => 'శుభ మధ్యాహ్నం';
	@override String get greeting_evening => 'శుభ సాయంత్రం';
	@override String get explore_stories => 'కథలను అన్వేషించండి';
	@override String get generate_story => 'కథ రూపొందించండి';
	@override String get content => 'Home Content';
}

// Path: stories
class _TranslationsStoriesTe extends TranslationsStoriesEn {
	_TranslationsStoriesTe._(TranslationsTe root) : this._root = root, super.internal(root);

	final TranslationsTe _root; // ignore: unused_field

	// Translations
	@override String get title => 'కథలు';
	@override String get search_hint => 'శీర్షిక లేదా రచయిత ద్వారా వెతకండి...';
	@override String get sort_by => 'క్రమీకరించు';
	@override String get sort_newest => 'కొత్తవి మొదట';
	@override String get sort_oldest => 'పాతవి మొదట';
	@override String get sort_popular => 'అత్యంత ప్రజాదరణ';
	@override String get no_stories => 'కథలు కనుగొనబడలేదు';
	@override String get loading_stories => 'కథలు లోడ్ అవుతున్నాయి...';
	@override String get error_loading_stories => 'కథలు లోడ్ చేయడంలో విఫలమైంది';
	@override String get story_details => 'కథ వివరాలు';
	@override String get continue_reading => 'చదవడం కొనసాగించండి';
	@override String get read_more => 'మరింత చదవండి';
	@override String get read_less => 'తక్కువ చదవండి';
	@override String get author => 'రచయిత';
	@override String get published_on => 'ప్రచురించబడింది';
	@override String get category => 'వర్గం';
	@override String get tags => 'ట్యాగ్స్';
	@override String get failed_to_load => 'Failed to load story';
}

// Path: story_generator
class _TranslationsStoryGeneratorTe extends TranslationsStoryGeneratorEn {
	_TranslationsStoryGeneratorTe._(TranslationsTe root) : this._root = root, super.internal(root);

	final TranslationsTe _root; // ignore: unused_field

	// Translations
	@override String get title => 'కథ జనరేటర్';
	@override String get subtitle => 'మీ స్వంత పురాణ కథను సృష్టించండి';
	@override String get select_character => 'పాత్రను ఎంచుకోండి';
	@override String get select_theme => 'థీమ్ను ఎంచుకోండి';
	@override String get select_language => 'భాషను ఎంచుకోండి';
	@override String get select_length => 'కథ పొడవు';
	@override String get generate => 'కథను రూపొందించండి';
	@override String get generating => 'మీ కథ రూపొందించబడుతోంది...';
	@override String get generated_story => 'మీ రూపొందించిన కథ';
	@override String get regenerate => 'మళ్లీ రూపొందించండి';
	@override String get save_story => 'కథను సేవ్ చేయండి';
	@override String get share_story => 'కథను పంచుకోండి';
	@override late final _TranslationsStoryGeneratorStoryLengthTe story_length = _TranslationsStoryGeneratorStoryLengthTe._(_root);
}

// Path: chat
class _TranslationsChatTe extends TranslationsChatEn {
	_TranslationsChatTe._(TranslationsTe root) : this._root = root, super.internal(root);

	final TranslationsTe _root; // ignore: unused_field

	// Translations
	@override String get title => 'చాట్ఇతిహాస్';
	@override String get subtitle => 'పురాణాల గురించి AI తో చాట్ చేయండి';
	@override String get friend_mode => 'స్నేహితుడి మోడ్';
	@override String get philosophical_mode => 'తత్వశాస్త్ర మోడ్';
	@override String get type_message => 'మీ సందేశాన్ని టైప్ చేయండి...';
	@override String get send => 'పంపండి';
	@override String get new_chat => 'కొత్త చాట్';
	@override String get chat_history => 'చాట్ చరిత్ర';
	@override String get clear_chat => 'చాట్ను తొలగించండి';
	@override String get no_messages => 'ఇంకా సందేశాలు లేవు. సంభాషణ ప్రారంభించండి!';
	@override String get list_page => 'Chat List Page';
}

// Path: map
class _TranslationsMapTe extends TranslationsMapEn {
	_TranslationsMapTe._(TranslationsTe root) : this._root = root, super.internal(root);

	final TranslationsTe _root; // ignore: unused_field

	// Translations
	@override String get title => 'అఖండ భారతం';
	@override String get subtitle => 'చారిత్రక స్థలాలను అన్వేషించండి';
	@override String get search_location => 'స్థలాన్ని వెతకండి...';
	@override String get view_details => 'వివరాలను చూడండి';
	@override String get show_route => 'మార్గాన్ని చూపించు';
	@override String get historical_info => 'చారిత్రక సమాచారం';
	@override String get nearby_places => 'సమీప ప్రదేశాలు';
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
	@override String get share_your_story => 'మీ కథను పంచుకోండి...';
	@override String get post => 'పోస్ట్ చేయండి';
	@override String get like => 'ఇష్టం';
	@override String get comment => 'వ్యాఖ్య';
	@override String get comments => 'వ్యాఖ్యలు';
	@override String get no_posts_yet => 'ఇంకా పోస్ట్లు లేవు';
}

// Path: settings
class _TranslationsSettingsTe extends TranslationsSettingsEn {
	_TranslationsSettingsTe._(TranslationsTe root) : this._root = root, super.internal(root);

	final TranslationsTe _root; // ignore: unused_field

	// Translations
	@override String get title => 'సెట్టింగ్స్';
	@override String get language => 'భాష';
	@override String get theme => 'థీమ్';
	@override String get theme_light => 'లైట్';
	@override String get theme_dark => 'డార్క్';
	@override String get theme_system => 'సిస్టమ్ డిఫాల్ట్';
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
	@override String get confirm_password => 'పాస్వర్డ్ను నిర్ధారించండి';
	@override String get forgot_password => 'పాస్వర్డ్ మర్చిపోయారా?';
	@override String get reset_password => 'పాస్వర్డ్ రీసెట్';
	@override String get dont_have_account => 'ఖాతా లేదా?';
	@override String get already_have_account => 'ఇప్పటికే ఖాతా ఉందా?';
	@override String get login_success => 'లాగిన్ విజయవంతం';
	@override String get signup_success => 'సైన్అప్ విజయవంతం';
	@override String get login_error => 'లాగిన్ విఫలమైంది';
	@override String get signup_error => 'సైన్అప్ విఫలమైంది';
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
	@override String get not_found => 'వనరు కనుగొనబడలేదు';
	@override String get validation => 'ధృవీకరణ విఫలమైంది';
	@override String get unexpected => 'అనుకోని లోపం సంభవించింది';
	@override String get try_again => 'దయచేసి మళ్లీ ప్రయత్నించండి';
}

// Path: subscription
class _TranslationsSubscriptionTe extends TranslationsSubscriptionEn {
	_TranslationsSubscriptionTe._(TranslationsTe root) : this._root = root, super.internal(root);

	final TranslationsTe _root; // ignore: unused_field

	// Translations
	@override String get free => 'ఉచితం';
	@override String get plus => 'ప్లస్';
	@override String get pro => 'ప్రో';
	@override String get upgrade_to_pro => 'ప్రోకు అప్గ్రేడ్ చేయండి';
	@override String get features => 'ఫీచర్లు';
	@override String get subscribe => 'సబ్స్క్రైబ్ చేయండి';
	@override String get current_plan => 'ప్రస్తుత ప్లాన్';
	@override String get manage_plan => 'ప్లాన్ను నిర్వహించండి';
}

// Path: notification
class _TranslationsNotificationTe extends TranslationsNotificationEn {
	_TranslationsNotificationTe._(TranslationsTe root) : this._root = root, super.internal(root);

	final TranslationsTe _root; // ignore: unused_field

	// Translations
	@override String get title => 'నోటిఫికేషన్స్';
	@override String get mark_all_read => 'అన్నింటినీ చదివినట్టు గుర్తించు';
	@override String get no_notifications => 'ఇంకా నోటిఫికేషన్స్ లేవు';
	@override String get error_prefix => 'లోపం:';
	@override String get retry => 'మళ్లీ ప్రయత్నించు';
	@override String liked_your_story({required Object ActorName}) => '${ActorName} మీ కథను ఇష్టపడ్డారు';
	@override String commented_on_your_story({required Object ActorName}) => '${ActorName} మీ కథను వ్యాఖ్యానించారు';
	@override String replied_to_your_comment({required Object ActorName}) => '${ActorName} మీ వ్యాఖ్యకు సమాధానం ఇచ్చారు';
	@override String started_following_you({required Object ActorName}) => '${ActorName} మిమ్మల్ని అనుసరించటం ప్రారంభించారు';
	@override String sent_you_a_message({required Object ActorName}) => '${ActorName} మీకు సందేశం పంపారు';
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
	@override String get error_title => 'అయ్యో! ఏదో తప్పు జరిగింది';
	@override String get try_again => 'మళ్లీ ప్రయత్నించు';
	@override String get no_stories_available => 'కథలు అందుబాటులో లేవు';
	@override String get refresh => 'రిఫ్రెష్';
	@override String get comments => 'వ్యాఖ్యలు';
	@override String get comments_coming_soon => 'వ్యాఖ్యలు త్వరలో వస్తాయి';
	@override String get add_comment_hint => 'వ్యాఖ్యను జోడించండి...';
	@override String get share_story => 'కథను పంచుకోండి';
	@override String get share_as_image => 'చిత్రంగా పంచుకోండి';
	@override String get share_as_image_subtitle => 'అందమైన ప్రివ్యూ కార్డ్‌ను సృష్టించండి';
	@override String get share_link => 'లింక్ పంచుకోండి';
	@override String get share_link_subtitle => 'కథ లింక్‌ను కాపీ చేయండి లేదా పంచుకోండి';
	@override String get share_as_text => 'పాఠ్యంగా పంచుకోండి';
	@override String get share_as_text_subtitle => 'కథ సారాంశాన్ని పంచుకోండి';
	@override String get send_to_user => 'వినియోగదారునికి పంపండి';
	@override String get send_to_user_subtitle => 'స్నేహితుడితో నేరుగా పంచుకోండి';
	@override String get choose_format => 'ఫార్మాట్ ఎంచుకోండి';
	@override String get link_preview => 'లింక్ ప్రివ్యూ';
	@override String get link_preview_size => '1200 × 630';
	@override String get story_format => 'స్టోరీ ఫార్మాట్';
	@override String get story_format_size => '1080 × 1920 (Instagram/Stories)';
	@override String get generating_preview => 'ప్రివ్యూ రూపొందుతోంది...';
	@override String get bookmarked => 'బుక్‌మార్క్ చేయబడింది';
	@override String get removed_from_bookmarks => 'బుక్‌మార్క్‌ల నుండి తీసివేయబడింది';
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
class _TranslationsStoryGeneratorStoryLengthTe extends TranslationsStoryGeneratorStoryLengthEn {
	_TranslationsStoryGeneratorStoryLengthTe._(TranslationsTe root) : this._root = root, super.internal(root);

	final TranslationsTe _root; // ignore: unused_field

	// Translations
	@override String get short => 'చిన్నది';
	@override String get medium => 'మధ్యస్థం';
	@override String get long => 'పొడవైనది';
}
