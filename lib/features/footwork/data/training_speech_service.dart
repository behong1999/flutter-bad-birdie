import 'package:audioplayers/audioplayers.dart';

import '../domain/enums/shot_type.dart';

/// Plays bundled shot-name clips so speech sounds identical on every device.
class TrainingSpeechService {
  const TrainingSpeechService._();

  static String _languageFolder(String localeTag) =>
      localeTag.split('-').first.toLowerCase() == 'de' ? 'de' : 'en';

  static String assetPathFor(ShotType shot, {required String localeTag}) {
    final lang = _languageFolder(localeTag);
    final file = switch (shot) {
      ShotType.clear => 'clear',
      ShotType.drop => 'drop',
      ShotType.smash => 'smash',
      ShotType.lift => 'lift',
      ShotType.block => 'block',
      ShotType.kill => 'tap',
      ShotType.drive => 'drive',
    };
    return 'sounds/shots/$lang/$file.wav';
  }

  static Future<void> play(
    AudioPlayer player,
    ShotType shot, {
    required String localeTag,
  }) async {
    await player.stop();
    await player.play(
      AssetSource(assetPathFor(shot, localeTag: localeTag)),
    );
  }
}
