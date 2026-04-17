import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pantry_pal/features/settings/data/settings_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  final SettingsModel _model = SettingsModel();
  final SharedPreferences _prefs;

  SettingsProvider(this._prefs) {
    _loadSettings();
  }

  SettingsModel get model => _model;

  ThemeMode get themeMode => model.themeMode;
  bool get isAutomatic => _model.themeMode == ThemeMode.system;
  bool get isNightMode => _model.themeMode == ThemeMode.dark;

  bool get isSystemDark =>
      PlatformDispatcher.instance.platformBrightness == Brightness.dark;

  void setAutomaticNightMode(bool state) {
    if (isAutomatic != state) {
      if (state) {
        _model.themeMode = ThemeMode.system;
      } else {
        _model.themeMode = isSystemDark ? ThemeMode.dark : ThemeMode.light;
      }
    }
    _saveSettings();
    notifyListeners();
  }

  void setNightMode(bool state) {
    _model.themeMode = state ? ThemeMode.dark : ThemeMode.light;
    _saveSettings();
    notifyListeners();
  }

  Future<void> _loadSettings() async {
    final String? savedTheme = _prefs.getString('theme_mode');

    if (savedTheme != null) {
      model.themeMode = ThemeMode.values.firstWhere(
        (themeMode) => themeMode.name.toLowerCase() == savedTheme.toLowerCase(),
        orElse: () => ThemeMode.system,
      );
    }
    notifyListeners();
  }

  Future<void> _saveSettings() async {
    await _prefs.setString('theme_mode', model.themeMode.name);
  }
}
