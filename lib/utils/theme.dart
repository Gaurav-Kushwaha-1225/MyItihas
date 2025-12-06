import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:myitihas/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyItihasTheme {
  MyItihasTheme._();

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: DarkColors.bgColor,
    primaryColor: DarkColors.accentPrimary,
    colorScheme: ColorScheme.dark(
      primary: DarkColors.accentPrimary,
      secondary: DarkColors.accentSecondary,
      background: DarkColors.bgColor,
      error: DarkColors.dangerColor,
    ),
    textTheme: TextTheme(
      displayMedium: TextStyle(color: DarkColors.textPrimary),
      bodyMedium: TextStyle(color: DarkColors.textPrimary),
    ),
    secondaryHeaderColor: DarkColors.textSecondary,
    cardColor: DarkColors.glassBg,
    hoverColor: DarkColors.glowPrimary,
  );

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: LightColors.bgColor,
    primaryColor: LightColors.accentPrimary,
    colorScheme: ColorScheme.light(
      primary: LightColors.accentPrimary,
      secondary: LightColors.accentSecondary,
      background: LightColors.bgColor,
      error: LightColors.dangerColor,
    ),
    textTheme: TextTheme(
      displayMedium: TextStyle(color: LightColors.textPrimary),
      bodyMedium: TextStyle(color: LightColors.textPrimary),
    ),
    secondaryHeaderColor: LightColors.textSecondary,
    cardColor: LightColors.cardBg,
    hoverColor: LightColors.glowPrimary,
  );
}

// Events
abstract class ThemeEvent {}

class ToggleTheme extends ThemeEvent {}

class InitializeTheme extends ThemeEvent {}

// States
class ThemeState {
  final bool isDark;
  ThemeState({required this.isDark});
}

// BLoC
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final SharedPreferences storage;

  ThemeBloc({required this.storage}) : super(ThemeState(isDark: false)) {
    on<ToggleTheme>((event, emit) async {
      final newIsDark = !state.isDark;
      await storage.setString('isDark', newIsDark.toString());
      emit(ThemeState(isDark: newIsDark));
    });

    on<InitializeTheme>((event, emit) async {
      bool isDark = false;
      try {
        isDark = (storage.getString('isDark')) != "true" ? true : false;
      } catch (e) {
        await storage.clear();
        isDark = false;
      }
      emit(ThemeState(isDark: isDark));
    });
  }

  void loadSavedTheme() {
    add(InitializeTheme());
  }
}
