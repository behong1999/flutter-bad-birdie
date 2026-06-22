import 'dart:convert';
import 'enums/shot_type.dart';

class TrainingPreset {
  const TrainingPreset({
    required this.id,
    required this.name,
    required this.selectedCorners,
    required this.sets,
    required this.shotsPerSet,
    required this.speed,
    required this.restSeconds,
    required this.useRingtone,
    this.selectedShots = const {},
  });

  factory TrainingPreset.fromJson(Map<String, dynamic> json) => TrainingPreset(
    id: json['id'] as String,
    name: json['name'] as String,
    selectedCorners: (json['selectedCorners'] as List<dynamic>)
        .map((e) => e as int)
        .toSet(),
    sets: json['sets'] as int,
    shotsPerSet: json['shotsPerSet'] as int,
    speed: (json['speed'] as num).toDouble(),
    restSeconds: json['restSeconds'] as int,
    useRingtone: json['useRingtone'] as bool,
    selectedShots: (json['selectedShots'] as List<dynamic>?)
            ?.map((e) => ShotType.values.byName(e as String))
            .toSet() ??
        const {},
  );

  factory TrainingPreset.decode(String raw) =>
      TrainingPreset.fromJson(jsonDecode(raw) as Map<String, dynamic>);

  final String id;
  final String name;
  final Set<int> selectedCorners;
  final int sets;
  final int shotsPerSet;
  final double speed;
  final int restSeconds;
  final bool useRingtone;
  final Set<ShotType> selectedShots;

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'selectedCorners': selectedCorners.toList(),
    'sets': sets,
    'shotsPerSet': shotsPerSet,
    'speed': speed,
    'restSeconds': restSeconds,
    'useRingtone': useRingtone,
    'selectedShots': selectedShots.map((s) => s.name).toList(),
  };

  String encode() => jsonEncode(toJson());

  static String encodeList(List<TrainingPreset> presets) =>
      jsonEncode(presets.map((p) => p.toJson()).toList());

  static List<TrainingPreset> decodeList(String raw) {
    final list = jsonDecode(raw) as List<dynamic>;
    return list
        .map((e) => TrainingPreset.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
