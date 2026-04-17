import 'package:flutter/material.dart';

class SettingsModel {
  ThemeMode themeMode = ThemeMode.system;

  Map<String, dynamic> toJson() {
    return {'themeMode': themeMode.name};
  }
}
