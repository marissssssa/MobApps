import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isHighContrast = false;
  bool _isLargeText = false;

  bool get isHighContrast => _isHighContrast;
  bool get isLargeText => _isLargeText;

  ThemeProvider() {
    _loadPreferences();
  }

  void toggleHighContrast(bool value) {
    _isHighContrast = value;
    _savePreferences();
    notifyListeners();
  }

  void toggleLargeText(bool value) {
    _isLargeText = value;
    _savePreferences();
    notifyListeners();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _isHighContrast = prefs.getBool('high_contrast') ?? false;
    _isLargeText = prefs.getBool('large_text') ?? false;
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('high_contrast', _isHighContrast);
    prefs.setBool('large_text', _isLargeText);
  }
}
