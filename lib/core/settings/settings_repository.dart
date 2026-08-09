import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepository {
  static const String _themeModeKey = 'app_theme_mode';
  static const String _localeKey = 'app_locale';

  late final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<ThemeMode> loadThemeMode() async {
    final prefs = await _prefs;
    return switch (prefs.getString(_themeModeKey)) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }

  Future<void> saveThemeMode(ThemeMode mode) async {
    final prefs = await _prefs;
    await prefs.setString(_themeModeKey, mode.name);
  }

  Future<Locale?> loadLocale() async {
    final prefs = await _prefs;
    final code = prefs.getString(_localeKey);
    return code == null ? null : Locale(code);
  }

  Future<void> saveLocale(Locale? locale) async {
    final prefs = await _prefs;
    if (locale == null) {
      await prefs.remove(_localeKey);
    } else {
      await prefs.setString(_localeKey, locale.languageCode);
    }
  }
}
