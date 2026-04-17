import 'package:flutter/material.dart';
import 'package:pantry_pal/core/layout/column_padding.dart';
import 'package:pantry_pal/core/layout/form/form_padding.dart';
import 'package:pantry_pal/features/settings/presentation/settings_provider.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = context.watch<SettingsProvider>();

    return FormPadding(
      child: Column(
        children: [
          _Switch(
            title: "Automatic night mode",
            state: settingsProvider.isAutomatic,
            switchState: (state) =>
                settingsProvider.setAutomaticNightMode(state),
          ),
          ColumnPadding(),
          _Switch(
            title: "Night mode",
            state: settingsProvider.isNightMode,
            disabled: settingsProvider.isAutomatic,
            switchState: (state) => settingsProvider.setNightMode(state),
          ),
        ],
      ),
    );
  }
}

class _Switch extends StatelessWidget {
  final String title;
  final bool disabled;
  final bool state;
  final ValueChanged<bool> switchState;
  const _Switch({
    required this.title,
    required this.state,
    required this.switchState,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(fontSize: 16)),
        Switch(
          // This bool value toggles the switch.
          value: state,
          onChanged: disabled ? null : switchState,
        ),
      ],
    );
  }
}
