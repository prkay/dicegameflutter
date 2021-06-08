import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

String translate(BuildContext context, String text) =>
    AppLocalizations.of(context).translate(text);

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
  AppLocalizationsDelegate();

  Map<String, String> _localizedStrings;

  Future<bool> load({Map<String, dynamic> strings}) async {
    Map<String, dynamic> jsonMap = strings;
    if (jsonMap == null) {
      String jsonString =
      await rootBundle.loadString('lang/${locale.languageCode}.json');
      jsonMap = json.decode(jsonString);
    }

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  String translate(String key) {
    var string = _localizedStrings[key];
    assert(string != null, key + " key is missing");

    return string;
  }

  String getLanguageCode() {
    return locale.languageCode;
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}