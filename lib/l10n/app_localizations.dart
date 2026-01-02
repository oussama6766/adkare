import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'ar': {
      'appName': 'منبه الأناشيد والأذكار',
      'home': 'الرئيسية',
      'alarms': 'المنبهات',
      'adhkar': 'الأذكار',
      'reminders': 'التذكيرات',
      'settings': 'الإعدادات',
      'library': 'المكتبة',
    },
    'en': {
      'appName': 'Nasheed & Adhkar Alarm',
      'home': 'Home',
      'alarms': 'Alarms',
      'adhkar': 'Adhkar',
      'reminders': 'Reminders',
      'settings': 'Settings',
      'library': 'Library',
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }

  String get appName => translate('appName');
  String get home => translate('home');
  String get alarms => translate('alarms');
  String get adhkar => translate('adhkar');
  String get reminders => translate('reminders');
  String get settings => translate('settings');
  String get library => translate('library');
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['ar', 'en'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
