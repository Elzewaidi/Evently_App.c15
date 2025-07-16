import 'package:flutter/material.dart';

class AppThemeProvider extends ChangeNotifier {
  ThemeMode apptheme = ThemeMode.light;

  void changeTheme(ThemeMode newTheme) {
    if (apptheme == newTheme) {
      return;
    }
    apptheme = newTheme;
    notifyListeners();
  }

  bool isDarkMode() {
    return apptheme == ThemeMode.dark;
  }
}
