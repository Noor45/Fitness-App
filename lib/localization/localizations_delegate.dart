import 'package:flutter/material.dart';
import 'package:t_fit/localization/language/language_ar.dart';
import 'package:t_fit/localization/language/language_en.dart';
import 'package:t_fit/localization/language/language_ch.dart';
import 'package:t_fit/localization/language/language_rus.dart';
import 'package:t_fit/localization/language/language_es.dart';

import 'language/languages.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<Languages> {

  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar', 'ch', 'ru', 'es'].contains(locale.languageCode);

  @override
  Future<Languages> load(Locale locale) => _load(locale);

  static Future<Languages> _load(Locale locale) async {
    switch (locale.languageCode) {
      case 'en':
        return LanguageEn();
      case 'ar':
        return LanguageAr();
      case 'ch':
        return LanguageCh();
      case 'ru':
        return LanguageRus();
      case 'es':
        return LanguageEs();
      default:
        return LanguageEn();
    }
  }

  @override
  bool shouldReload(LocalizationsDelegate<Languages> old) => false;
}
