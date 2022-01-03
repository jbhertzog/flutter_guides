// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class AppLocale extends ChangeNotifier {
  final String _path = 'assets/lang/';
  final Locale _deviceLocale;

  AppLocale({
    required Locale deviceLocale,
  }) : _deviceLocale = deviceLocale;

  static const LocalizationsDelegate<AppLocale> delegate = _AppLocalizationsDelegate();

  static AppLocale? of(BuildContext context) {
    return Localizations.of<AppLocale>(context, AppLocale);
  }

  static var supportedLocales = [
    const Locale('en', "US"),
    const Locale('ja', "JA"),
  ];

  late Map<String, String> _localizedStrings;

  Future<void> loadDeviceLocale() async {
    try {
      String jsonString = await rootBundle.loadString('$_path${_deviceLocale.languageCode}.json');

      Map<String, dynamic> jsonMap = json.decode(jsonString);
      _localizedStrings = jsonMap.map((key, value) {
        return MapEntry(key, value.toString());
      });
    } on FlutterError catch (_) {
      print('Could not load json file');
      _localizedStrings = {'Error': '**Json Error**'};
    }
  }

  String translate(String key) {
    /// Return the matching string if we find it, otherwise just return the key
    /// Returning the key makes it easy for us to debug which strings are missing
    return _localizedStrings[key] ?? key;
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocale> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ja'].contains(locale.languageCode);
  }

  @override
  Future<AppLocale> load(Locale locale) async {
    AppLocale localizations = AppLocale(deviceLocale: locale);
    await localizations.loadDeviceLocale();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => true;
}
