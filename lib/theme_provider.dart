import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  MaterialColor _primaryColor = Colors.deepPurple;

  ThemeMode get themeMode => _themeMode;
  MaterialColor get primaryColor => _primaryColor;

  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('isDark') ?? false;
    final color = prefs.getString('primaryColor') ?? 'deepPurple';

    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    _primaryColor = _mapStringToColor(color);
    notifyListeners();
  }

  void toggleTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    await prefs.setBool('isDark', isDark);
    notifyListeners();
  }

  void setPrimaryColor(String colorKey) async {
    final prefs = await SharedPreferences.getInstance();
    _primaryColor = _mapStringToColor(colorKey);
    await prefs.setString('primaryColor', colorKey);
    notifyListeners();
  }

  MaterialColor _mapStringToColor(String key) {
    switch (key) {
      case 'red':
        return Colors.red;
      case 'green':
        return Colors.green;
      case 'blue':
        return Colors.blue;
      default:
        return Colors.deepPurple;
    }
  }
}
