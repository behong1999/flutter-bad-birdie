import 'package:flutter/material.dart';
import 'settings_repository.dart';

class AppSettings extends ChangeNotifier {
  AppSettings._(this._repository, this._themeMode, this._locale);

  static Future<AppSettings> load(SettingsRepository repository) async {
    final themeMode = await repository.loadThemeMode();
    final locale = await repository.loadLocale();
    return AppSettings._(repository, themeMode, locale);
  }

  final SettingsRepository _repository;
  ThemeMode _themeMode;
  Locale? _locale;

  ThemeMode get themeMode => _themeMode;
  Locale? get locale => _locale;

  Future<void> setThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) return;
    _themeMode = mode;
    notifyListeners();
    await _repository.saveThemeMode(mode);
  }

  Future<void> setLocale(Locale? locale) async {
    if (_locale == locale) return;
    _locale = locale;
    notifyListeners();
    await _repository.saveLocale(locale);
  }
}
