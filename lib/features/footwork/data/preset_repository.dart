import 'package:shared_preferences/shared_preferences.dart';
import '../domain/training_preset.dart';

class PresetRepository {
  static const String _presetsKey = 'training_presets';
  static const String _lastUsedKey = 'training_last_used';

  late final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<List<TrainingPreset>> loadPresets() async {
    final prefs = await _prefs;
    final raw = prefs.getString(_presetsKey);
    if (raw == null || raw.isEmpty) return [];
    return TrainingPreset.decodeList(raw);
  }

  Future<void> savePreset(TrainingPreset preset) async {
    final prefs = await _prefs;
    final current = await loadPresets()
      ..add(preset);
    await prefs.setString(_presetsKey, TrainingPreset.encodeList(current));
  }

  Future<void> deletePreset(String id) async {
    final prefs = await _prefs;
    final current = await loadPresets()
      ..removeWhere((p) => p.id == id);
    await prefs.setString(_presetsKey, TrainingPreset.encodeList(current));
  }

  Future<TrainingPreset?> loadLastUsed() async {
    final prefs = await _prefs;
    final raw = prefs.getString(_lastUsedKey);
    if (raw == null || raw.isEmpty) return null;
    return TrainingPreset.decode(raw);
  }

  Future<void> saveLastUsed(TrainingPreset preset) async {
    final prefs = await _prefs;
    await prefs.setString(_lastUsedKey, preset.encode());
  }
}
