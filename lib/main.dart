import 'package:flutter/material.dart';
import 'package:pantry_pal/core/layout/main_screen.dart';
import 'package:pantry_pal/core/layout/mobile_wrapper.dart';
import 'package:pantry_pal/core/theme/themed_app.dart';
import 'package:pantry_pal/features/pantry/presentation/pantry_items_provider.dart';
import 'package:pantry_pal/features/settings/presentation/settings_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PantryItemsProvider(prefs)),
        ChangeNotifierProvider(create: (_) => SettingsProvider(prefs)),
      ],
      child: ThemedApp(child: MobileWrapper(child: MainScreen())),
    ),
  );
}
