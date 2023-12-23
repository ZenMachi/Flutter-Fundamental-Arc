import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _theme = ThemeMode.light;
  ThemeMode get themeMode => _theme;

  bool _isDark = false;
  bool get isDark => _isDark;

  toggleTheme(bool value) {
    _isDark = value;
    _theme = _isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

}