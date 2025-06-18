import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('ne');

  Locale get locale => _locale;

  void toggleLocale() {
    _locale = _locale.languageCode == 'ne' ? const Locale('en') : const Locale('ne');
    notifyListeners();
  }
}