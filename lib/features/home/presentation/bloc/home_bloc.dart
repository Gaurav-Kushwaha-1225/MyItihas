import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:myitihas/core/logging/talker_setup.dart';
import 'package:myitihas/features/home/data/datasources/quote_local_datasource.dart';
import 'package:myitihas/features/home/presentation/bloc/home_event.dart';
import 'package:myitihas/features/home/presentation/bloc/home_state.dart';
import 'package:myitihas/features/stories/domain/entities/story.dart';
import 'package:myitihas/features/story_generator/domain/repositories/story_generator_repository.dart';
import 'package:myitihas/services/reading_progress_service.dart';
import 'package:share_plus/share_plus.dart';

/// BLoC for HomeScreen state management
@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final QuoteLocalDataSource _quoteDataSource;
  final ReadingProgressService _readingProgressService;
  final StoryGeneratorRepository _storyGeneratorRepository;

  HomeBloc(
    this._quoteDataSource,
    this._readingProgressService,
    this._storyGeneratorRepository,
  ) : super(const HomeState()) {
    on<HomeEvent>((event, emit) async {
      await event.when(
        loadHome: () => _onLoadHome(emit),
        refresh: () => _onRefresh(emit),
        loadQuote: () => _onLoadQuote(emit),
        loadFeaturedStories: () => _onLoadFeaturedStories(emit),
        loadContinueReading: () => _onLoadContinueReading(emit),
        loadSavedStories: () => _onLoadSavedStories(emit),
        loadMyGeneratedStories: () => _onLoadMyGeneratedStories(emit),
        shareQuote: () => _onShareQuote(emit),
        copyQuote: () => _onCopyQuote(emit),
      );
    });
  }

  /// Load all home screen data
  Future<void> _onLoadHome(Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoading: true, greetingKey: _getGreetingKey()));

    // Load all sections in parallel
    await Future.wait([
      _loadQuote(emit),
      _loadContinueReading(emit),
      _loadFeaturedStories(emit),
      _loadSavedStories(emit),
      _loadMyGeneratedStories(emit),
    ]);

    emit(state.copyWith(isLoading: false));
  }

  /// Refresh home screen data
  Future<void> _onRefresh(Emitter<HomeState> emit) async {
    emit(state.copyWith(isRefreshing: true));

    await Future.wait([
      _loadQuote(emit),
      _loadContinueReading(emit),
      _loadFeaturedStories(emit),
      _loadSavedStories(emit),
      _loadMyGeneratedStories(emit),
    ]);

    emit(state.copyWith(isRefreshing: false));
  }

  /// Load quote of the day
  Future<void> _onLoadQuote(Emitter<HomeState> emit) async {
    emit(state.copyWith(isQuoteLoading: true));
    await _loadQuote(emit);
    emit(state.copyWith(isQuoteLoading: false));
  }

  Future<void> _loadQuote(Emitter<HomeState> emit) async {
    try {
      final quote = await _quoteDataSource.getQuoteOfTheDay();
      emit(state.copyWith(quote: quote));
    } catch (e, st) {
      talker.error('Failed to load quote', e, st);
    }
  }

  /// Load featured stories
  Future<void> _onLoadFeaturedStories(Emitter<HomeState> emit) async {
    emit(state.copyWith(isFeaturedLoading: true));
    await _loadFeaturedStories(emit);
    emit(state.copyWith(isFeaturedLoading: false));
  }

  Future<void> _loadFeaturedStories(Emitter<HomeState> emit) async {
    try {
      // TODO: Implement actual featured stories fetch from repository
      // For now, we'll use placeholder stories
      // This should be replaced with actual data from StoriesRepository
      emit(state.copyWith(featuredStories: _getPlaceholderStories()));
    } catch (e, st) {
      talker.error('Failed to load featured stories', e, st);
    }
  }

  /// Load continue reading section
  Future<void> _onLoadContinueReading(Emitter<HomeState> emit) async {
    emit(state.copyWith(isContinueReadingLoading: true));
    await _loadContinueReading(emit);
    emit(state.copyWith(isContinueReadingLoading: false));
  }

  Future<void> _loadContinueReading(Emitter<HomeState> emit) async {
    try {
      final inProgress = await _readingProgressService.getAllInProgress();
      emit(state.copyWith(continueReading: inProgress));
    } catch (e, st) {
      talker.error('Failed to load continue reading', e, st);
    }
  }

  /// Load saved/bookmarked stories
  Future<void> _onLoadSavedStories(Emitter<HomeState> emit) async {
    emit(state.copyWith(isSavedStoriesLoading: true));
    await _loadSavedStories(emit);
    emit(state.copyWith(isSavedStoriesLoading: false));
  }

  Future<void> _loadSavedStories(Emitter<HomeState> emit) async {
    try {
      // TODO: Implement actual saved stories fetch from repository
      // Filter stories where isFavorite == true
      emit(state.copyWith(savedStories: []));
    } catch (e, st) {
      talker.error('Failed to load saved stories', e, st);
    }
  }

  /// Load user's generated stories
  Future<void> _onLoadMyGeneratedStories(Emitter<HomeState> emit) async {
    emit(state.copyWith(isMyGeneratedStoriesLoading: true));
    await _loadMyGeneratedStories(emit);
    emit(state.copyWith(isMyGeneratedStoriesLoading: false));
  }

  Future<void> _loadMyGeneratedStories(Emitter<HomeState> emit) async {
    try {
      final result = await _storyGeneratorRepository.getGeneratedStories();
      result.fold(
        (failure) {
          talker.error('Failed to load generated stories: ${failure.message}');
          emit(state.copyWith(myGeneratedStories: []));
        },
        (stories) {
          // Limit to 10 most recent stories for home screen
          final limitedStories = stories.take(10).toList();
          emit(state.copyWith(myGeneratedStories: limitedStories));
        },
      );
    } catch (e, st) {
      talker.error('Failed to load generated stories', e, st);
      emit(state.copyWith(myGeneratedStories: []));
    }
  }

  /// Share the current quote
  Future<void> _onShareQuote(Emitter<HomeState> emit) async {
    final quote = state.quote;
    if (quote == null) return;

    try {
      await Share.share(quote.shareableText);
      HapticFeedback.mediumImpact();
    } catch (e, st) {
      talker.error('Failed to share quote', e, st);
    }
  }

  /// Copy quote to clipboard
  Future<void> _onCopyQuote(Emitter<HomeState> emit) async {
    final quote = state.quote;
    if (quote == null) return;

    try {
      await Clipboard.setData(ClipboardData(text: quote.shareableText));
      HapticFeedback.lightImpact();
    } catch (e, st) {
      talker.error('Failed to copy quote', e, st);
    }
  }

  /// Get greeting key based on time of day
  String _getGreetingKey() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'morning';
    } else if (hour < 17) {
      return 'afternoon';
    } else {
      return 'evening';
    }
  }

  /// Placeholder stories for development
  List<Story> _getPlaceholderStories() {
    return [
      Story(
        id: 'featured_1',
        title: 'The Wisdom of Arjuna',
        scripture: 'Mahabharata',
        story: 'In the great battle of Kurukshetra...',
        quotes: 'Do your duty without attachment to results.',
        trivia: 'The Mahabharata is the longest epic poem ever written.',
        activity: 'Reflect on a time when you had to make a difficult choice.',
        lesson:
            'True wisdom comes from understanding both action and inaction.',
        attributes: StoryAttributes(
          storyType: 'Epic',
          theme: 'Wisdom',
          mainCharacterType: 'Warrior',
          storySetting: 'Battlefield',
          timeEra: 'Dwapara Yuga',
          narrativePerspective: 'Third Person',
          languageStyle: 'Classical',
          emotionalTone: 'Contemplative',
          narrativeStyle: 'Epic',
          plotStructure: 'Hero\'s Journey',
          storyLength: 'medium',
        ),
        imageUrl:
            'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?w=800',
      ),
      Story(
        id: 'featured_2',
        title: 'Lord Hanuman\'s Devotion',
        scripture: 'Ramayana',
        story: 'When Lord Rama needed someone to cross the ocean...',
        quotes: 'With faith, mountains can be moved.',
        trivia: 'Hanuman is considered the 11th Rudra avatar.',
        activity: 'Practice a small act of selfless service today.',
        lesson: 'Devotion and faith can overcome any obstacle.',
        attributes: StoryAttributes(
          storyType: 'Devotional',
          theme: 'Faith',
          mainCharacterType: 'Divine',
          storySetting: 'Kingdom',
          timeEra: 'Treta Yuga',
          narrativePerspective: 'Third Person',
          languageStyle: 'Classical',
          emotionalTone: 'Inspiring',
          narrativeStyle: 'Devotional',
          plotStructure: 'Quest',
          storyLength: 'medium',
        ),
        imageUrl:
            'https://images.unsplash.com/photo-1609619385002-f40f1df9b7eb?w=800',
      ),
      Story(
        id: 'featured_3',
        title: 'The Churning of the Ocean',
        scripture: 'Vishnu Purana',
        story: 'The Devas and Asuras once joined forces...',
        quotes: 'From struggle comes nectar.',
        trivia: 'Samudra Manthan produced 14 treasures.',
        activity: 'Think about challenges that led to personal growth.',
        lesson: 'Cooperation can achieve what division cannot.',
        attributes: StoryAttributes(
          storyType: 'Mythological',
          theme: 'Cooperation',
          mainCharacterType: 'Divine',
          storySetting: 'Cosmic Ocean',
          timeEra: 'Satya Yuga',
          narrativePerspective: 'Third Person',
          languageStyle: 'Classical',
          emotionalTone: 'Epic',
          narrativeStyle: 'Mythological',
          plotStructure: 'Cosmic Drama',
          storyLength: 'long',
        ),
        imageUrl:
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=800',
      ),
    ];
  }
}
