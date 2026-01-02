import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/app_constants.dart';

// Events
abstract class AppEvent extends Equatable {
  const AppEvent();
  @override
  List<Object?> get props => [];
}

class AppStarted extends AppEvent {}

class ThemeChanged extends AppEvent {
  final ThemeMode themeMode;
  const ThemeChanged(this.themeMode);
  @override
  List<Object?> get props => [themeMode];
}

class LocaleChanged extends AppEvent {
  final Locale locale;
  const LocaleChanged(this.locale);
  @override
  List<Object?> get props => [locale];
}

// State
class AppState extends Equatable {
  final ThemeMode themeMode;
  final Locale locale;
  final bool isLoading;

  const AppState({
    this.themeMode = ThemeMode.system,
    this.locale = const Locale('ar'),
    this.isLoading = true,
  });

  AppState copyWith({
    ThemeMode? themeMode,
    Locale? locale,
    bool? isLoading,
  }) {
    return AppState(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [themeMode, locale, isLoading];
}

// BLoC
class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppState()) {
    on<AppStarted>(_onAppStarted);
    on<ThemeChanged>(_onThemeChanged);
    on<LocaleChanged>(_onLocaleChanged);
  }

  Future<void> _onAppStarted(AppStarted event, Emitter<AppState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    
    // Load theme
    final themeString = prefs.getString(AppConstants.themeKey) ?? 'system';
    final themeMode = _stringToThemeMode(themeString);
    
    // Load locale
    final localeString = prefs.getString(AppConstants.localeKey) ?? 'ar';
    final locale = Locale(localeString);
    
    emit(state.copyWith(
      themeMode: themeMode,
      locale: locale,
      isLoading: false,
    ));
  }

  Future<void> _onThemeChanged(ThemeChanged event, Emitter<AppState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.themeKey, _themeModeToString(event.themeMode));
    emit(state.copyWith(themeMode: event.themeMode));
  }

  Future<void> _onLocaleChanged(LocaleChanged event, Emitter<AppState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.localeKey, event.locale.languageCode);
    emit(state.copyWith(locale: event.locale));
  }

  ThemeMode _stringToThemeMode(String value) {
    switch (value) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  String _themeModeToString(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      default:
        return 'system';
    }
  }
}
