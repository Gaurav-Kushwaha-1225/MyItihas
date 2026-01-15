import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';

class StoryTtsState {
  final bool isReady;
  final bool isSpeaking;
  final bool isPaused;
  final int offset;
  final String text;
  final int maxSpeechInputLength;
  final String language;
  final String? error;

  const StoryTtsState({
    required this.isReady,
    required this.isSpeaking,
    required this.isPaused,
    required this.offset,
    required this.text,
    required this.maxSpeechInputLength,
    required this.language,
    required this.error,
  });

  factory StoryTtsState.initial() => const StoryTtsState(
        isReady: false,
        isSpeaking: false,
        isPaused: false,
        offset: 0,
        text: '',
        maxSpeechInputLength: 3500,
        language: 'en-US',
        error: null,
      );

  StoryTtsState copyWith({
    bool? isReady,
    bool? isSpeaking,
    bool? isPaused,
    int? offset,
    String? text,
    int? maxSpeechInputLength,
    String? language,
    String? error,
    bool clearError = false,
  }) {
    return StoryTtsState(
      isReady: isReady ?? this.isReady,
      isSpeaking: isSpeaking ?? this.isSpeaking,
      isPaused: isPaused ?? this.isPaused,
      offset: offset ?? this.offset,
      text: text ?? this.text,
      maxSpeechInputLength: maxSpeechInputLength ?? this.maxSpeechInputLength,
      language: language ?? this.language,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

/// BLoC/Cubit wrapper for all TTS behaviour.
/// This removes setState-based TTS handling from the UI.
class StoryTtsCubit extends Cubit<StoryTtsState> {
  final FlutterTts _tts = FlutterTts();

  int _runId = 0;
  int _utteranceBaseOffset = 0;

  StoryTtsCubit() : super(StoryTtsState.initial());

  Future<void> initialize({String language = 'en-US'}) async {
    try {
      await _tts.setLanguage(language);
      await _tts.setSpeechRate(0.5);
      await _tts.setVolume(1.0);
      await _tts.setPitch(1.0);

      final maxLen = await _tts.getMaxSpeechInputLength;
      final maxSpeech = (maxLen is int && maxLen > 0)
          ? maxLen
          : state.maxSpeechInputLength;

      _tts.setStartHandler(() {
        emit(
          state.copyWith(isSpeaking: true, isPaused: false, clearError: true),
        );
      });

      // Fires per utterance chunk
      _tts.setCompletionHandler(() {
        emit(state.copyWith(isSpeaking: false));
      });

      _tts.setCancelHandler(() {
        emit(state.copyWith(isSpeaking: false, isPaused: false));
      });

      _tts.setPauseHandler(() {
        emit(state.copyWith(isSpeaking: false, isPaused: true));
      });

      _tts.setContinueHandler(() {
        emit(state.copyWith(isSpeaking: true, isPaused: false));
      });

      _tts.setProgressHandler((String text, int start, int end, String word) {
        final absolute = _utteranceBaseOffset + end;
        emit(state.copyWith(offset: absolute));
      });

      emit(
        state.copyWith(
          isReady: true,
          maxSpeechInputLength: maxSpeech,
          language: language,
          clearError: true,
        ),
      );
    } catch (e) {
      emit(state.copyWith(error: 'TTS init failed: $e'));
    }
  }

  Future<void> setLanguage(
    String language, {
    bool stopIfSpeaking = true,
  }) async {
    try {
      if (!state.isReady) {
        await initialize(language: language);
        return;
      }
      if (stopIfSpeaking) {
        await stop(resetPosition: false);
      }
      await _tts.setLanguage(language);
      emit(state.copyWith(language: language, clearError: true));
    } catch (e) {
      emit(state.copyWith(error: 'TTS setLanguage failed: $e'));
    }
  }

  Future<void> setLanguageByCode(String code, {bool stopIfSpeaking = true}) {
    return setLanguage(
      ttsLocaleForLangCode(code),
      stopIfSpeaking: stopIfSpeaking,
    );
  }

  Future<void> setText(String text, {bool stopIfSpeaking = true}) async {
    if (stopIfSpeaking) {
      await stop(resetPosition: true);
    }
    emit(
      state.copyWith(
        text: text,
        offset: 0,
        isPaused: false,
        isSpeaking: false,
        clearError: true,
      ),
    );
  }

  Future<void> toggle() async {
    if (!state.isReady) {
      await initialize(language: state.language);
    }

    if (state.isSpeaking) {
      _runId++;
      await _tts.pause();
      emit(state.copyWith(isSpeaking: false, isPaused: true));
      return;
    }

    // Resume or start
    _runId++;
    emit(state.copyWith(isPaused: false, isSpeaking: true));
    await _speakFromOffset(runId: _runId);
  }

  Future<void> stop({required bool resetPosition}) async {
    _runId++;
    await _tts.stop();
    emit(
      state.copyWith(
        isSpeaking: false,
        isPaused: false,
        offset: resetPosition ? 0 : state.offset,
      ),
    );
  }

  Future<void> _speakFromOffset({required int runId}) async {
    var offset = _skipWhitespace(state.text, state.offset);

    while (offset < state.text.length) {
      if (runId != _runId) return; // canceled

      final chunk = _nextTtsChunk(
        state.text,
        offset,
        state.maxSpeechInputLength,
      );
      _utteranceBaseOffset = offset;

      await _tts.speak(chunk);

      // Wait for completion of this chunk (completion handler sets isSpeaking=false)
      while (state.isSpeaking) {
        if (runId != _runId) return;
        await Future.delayed(const Duration(milliseconds: 120));
      }

      if (state.isPaused) return;

      offset = _skipWhitespace(state.text, _utteranceBaseOffset + chunk.length);
      emit(state.copyWith(offset: offset));

      // Mark speaking for next chunk
      if (offset < state.text.length) {
        emit(state.copyWith(isSpeaking: true));
      }
    }

    // finished
    emit(state.copyWith(isSpeaking: false, isPaused: false, offset: 0));
  }

  int _skipWhitespace(String text, int from) {
    var i = from;
    while (i < text.length) {
      final c = text.codeUnitAt(i);
      if (c != 32 && c != 10 && c != 13 && c != 9) break;
      i++;
    }
    return i;
  }

  String _nextTtsChunk(String text, int start, int maxLen) {
    final remaining = text.length - start;
    final take = remaining < maxLen ? remaining : maxLen;
    var end = start + take;

    // Try to break at a sentence boundary or whitespace.
    final slice = text.substring(start, end);

    final lastPeriod = slice.lastIndexOf(RegExp(r'[.!?]\s'));
    if (lastPeriod > 200) {
      end = start + lastPeriod + 1;
      return text.substring(start, end);
    }

    final lastSpace = slice.lastIndexOf(' ');
    if (lastSpace > 200) {
      end = start + lastSpace;
      return text.substring(start, end);
    }

    return text.substring(start, end);
  }

  @override
  Future<void> close() async {
    try {
      await _tts.stop();
    } catch (_) {}
    return super.close();
  }
}

String ttsLocaleForLangCode(String code) {
  final c = code.trim().toLowerCase();
  switch (c) {
    case 'en':
      return 'en-US';
    case 'hi':
      return 'hi-IN';
    case 'ta':
      return 'ta-IN';
    case 'te':
      return 'te-IN';
    case 'bn':
      return 'bn-IN';
    case 'mr':
      return 'mr-IN';
    case 'gu':
      return 'gu-IN';
    case 'kn':
      return 'kn-IN';
    case 'ml':
      return 'ml-IN';
    case 'pa':
      return 'pa-IN';
    case 'ur':
      return 'ur-IN';
    default:
      return 'en-US';
  }
}
