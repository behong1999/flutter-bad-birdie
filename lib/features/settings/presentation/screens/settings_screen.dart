import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/settings/app_settings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<AppSettings>();
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.settings),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 12),
        children: [
          _SectionHeader(context.l10n.appearance),
          RadioGroup<ThemeMode>(
            groupValue: settings.themeMode,
            onChanged: (m) {
              if (m != null) settings.setThemeMode(m);
            },
            child: Column(
              children: [
                RadioListTile<ThemeMode>(
                  title: Text(context.l10n.themeSystem),
                  value: ThemeMode.system,
                ),
                RadioListTile<ThemeMode>(
                  title: Text(context.l10n.themeLight),
                  value: ThemeMode.light,
                ),
                RadioListTile<ThemeMode>(
                  title: Text(context.l10n.themeDark),
                  value: ThemeMode.dark,
                ),
              ],
            ),
          ),
          const Divider(height: 32),
          _SectionHeader(context.l10n.language),
          RadioGroup<Locale?>(
            groupValue: settings.locale,
            onChanged: settings.setLocale,
            child: Column(
              children: [
                RadioListTile<Locale?>(
                  title: Text(context.l10n.themeSystem),
                  value: null,
                ),
                const RadioListTile<Locale?>(
                  title: Text('English'),
                  value: Locale('en'),
                ),
                const RadioListTile<Locale?>(
                  title: Text('Deutsch'),
                  value: Locale('de'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
      child: Text(
        label,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
