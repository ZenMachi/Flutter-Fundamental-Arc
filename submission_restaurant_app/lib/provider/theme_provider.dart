import 'package:flutter/material.dart';
import 'package:submission_restaurant_app/utils/preferences_helper.dart';

class ThemeProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  ThemeProvider({required this.preferencesHelper}) {
    _getTheme();
  }

  ThemeMode get themeMode => _isDark ? ThemeMode.dark : ThemeMode.light;

  bool _isDark = false;
  bool get isDark => _isDark;

  toggleTheme(bool value) {
    preferencesHelper.setDarkTheme(value);
    _getTheme();
  }

  void _getTheme() async {
    _isDark = await preferencesHelper.isDarkTheme;
    notifyListeners();
  }
}
