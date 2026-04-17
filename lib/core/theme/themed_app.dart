import 'package:flutter/material.dart';
import 'package:pantry_pal/core/theme/theme.dart';
import 'package:pantry_pal/features/settings/presentation/settings_provider.dart';
import 'package:provider/provider.dart';

class ThemedApp extends StatelessWidget {
  final Widget child;

  const ThemedApp({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = context.watch<SettingsProvider>();

    return MaterialApp(
      title: "Pantry Pal",
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: settingsProvider.themeMode,
      home: child,
    );
  }
}
