import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../services/shared_preferences_service.dart';

class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);
 final SharedPref _prefs = SharedPref();

  static AppLocalizations of(BuildContext context) {
    return Localizations.of(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();
  Map<String, dynamic> _localizedStrings;

  Future<bool> load() async {
   final String jsonString =
        await rootBundle.loadString('lang/${locale.languageCode}.json');
   final Map<String, dynamic> jsonMap = json.decode(jsonString) as Map<String,dynamic>;

    _localizedStrings = jsonMap.map(
      (key, value) {
        return MapEntry(key, value.toString());
      },
    );
    return true;
  }

  Future<Locale> setLocale(String languageCode) async {
    await _prefs.saveLocale(languageCode);
    return _locale(languageCode);
  }

  Future<Locale> getLocale() async {
   final String languageCode = await _prefs.readLocale() ?? "en";
    return _locale(languageCode);
  }

  Language _language(String languageCode) {
    switch (languageCode) {
      case 'en':
        return Language(3, '🇺🇸', 'English', 'en');
      case 'ro':
        return Language(1, '🇲🇩', 'Română', 'ro');
      case 'ru':
        return Language(2, '🇷🇺', 'Русский', 'ru');

      default:
        return Language(3, '🇺🇸', 'English', 'en');
    }
  }

  Locale _locale(String languageCode) {
    switch (languageCode) {
      case 'en':
        return const Locale('en', 'US');
      case 'ro':
        return const Locale('ro', "RO");
      case 'ru':
        return const Locale('ru', "RU");

      default:
        return const Locale('en', 'US');
    }
  }

  Future<Language> getLanguage() async {
  final  String languageCode = await _prefs.readLocale() ?? "en";
    return _language(languageCode);
  }

  String translate(String key) {
    return _localizedStrings[key] as String;
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ro', 'ru', 'md'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
  final AppLocalizations localizations =  AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  // ignore: non_constant_identifier_names
  bool shouldReload(_AppLocalizationsDelegate) => false;
}

class Language {
  final int id;
  final String flag;
  final String name;
  final String languageCode;

  Language(this.id, this.flag, this.name, this.languageCode);

  static List<Language> languageList() {
    return <Language>[
      Language(1, '🇲🇩', 'Română', 'ro'),
      Language(2, '🇷🇺', 'Русский', 'ru'),
      Language(3, '🇺🇸', 'English', 'en'),
    ];
  }
}
