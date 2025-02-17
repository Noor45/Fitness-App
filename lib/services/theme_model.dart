import 'package:flutter/foundation.dart';
import 'package:t_fit/database/dart_theme_preference.dart';

class DarkThemeProvider with ChangeNotifier {
  DarkThemePreference lightThemePreference = DarkThemePreference();
  bool _lightTheme = false; bool get lightTheme => _lightTheme;
  set lightTheme(bool value) {
    _lightTheme = value;
    lightThemePreference.setDarkTheme(value);
    notifyListeners();
  }
}