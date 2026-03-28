// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Bad Birdie - App für Badminton-Nerds';

  @override
  String get homeTitle => 'Bad Birdie';

  @override
  String get welcomeTitle => 'Willkommen bei Bad Birdie!';

  @override
  String get welcomeDescription =>
      'Verbessere deine Badminton-Fähigkeiten mit Beinarbeit-Training, taktischer Analyse und Lernressourcen.';

  @override
  String get trainingFeatures => 'Trainings-Features';

  @override
  String get footworkTraining => 'Beinarbeit-Training';

  @override
  String get footworkDescription =>
      'Übe Übungen und verbessere deine Platzbewegung';

  @override
  String get tacticalBoard => 'Taktiktafel';

  @override
  String get tacticalDescription =>
      'Plane Strategien und analysiere Spielsituationen';

  @override
  String get learningHub => 'Lern-Hub';

  @override
  String get learningDescription => 'Entdecke YouTube-Kanäle und Tutorials';

  @override
  String get footworkComingSoon => 'Beinarbeit-Training kommt bald!';

  @override
  String get tacticalComingSoon => 'Taktiktafel kommt bald!';

  @override
  String get learningComingSoon => 'Lern-Hub kommt bald!';

  @override
  String get chooseCornersTitle => 'Ecken zum Trainieren wählen';

  @override
  String get chooseCornersDescription =>
      'Wähle mindestens 1 Ecke für dein Beinarbeit-Training';

  @override
  String get frontLeft => 'Vorne\nLinks';

  @override
  String get frontRight => 'Vorne\nRechts';

  @override
  String get midLeft => 'Mitte\nLinks';

  @override
  String get midRight => 'Mitte\nRechts';

  @override
  String get backLeft => 'Hinten\nLinks';

  @override
  String get backRight => 'Hinten\nRechts';

  @override
  String selectedCorners(int count, String plural, String corners) {
    return '$count Ecke$plural ausgewählt: $corners';
  }

  @override
  String get trainingSettings => 'Trainings-Einstellungen';

  @override
  String get sets => 'Sätze';

  @override
  String setsValue(int count) {
    return '$count Sätze';
  }

  @override
  String get shotsPerSet => 'Schläge pro Satz';

  @override
  String shotsValue(int count) {
    return '$count Schläge';
  }

  @override
  String get speed => 'Geschwindigkeit';

  @override
  String speedValue(String speed) {
    return 'x$speed';
  }

  @override
  String get restBetweenSets => 'Pause zwischen Sätzen';

  @override
  String restValue(int seconds) {
    return '${seconds}s';
  }

  @override
  String get nextMoveNotification => 'Nächster Zug Benachrichtigung';

  @override
  String get ringtone => 'Klingelton';

  @override
  String get speech => 'Sprache';

  @override
  String get letsBegin => 'Los geht\'s! 🏸';

  @override
  String get saveSettings => 'Einstellungen speichern';

  @override
  String get help => 'Hilfe';

  @override
  String get readyToTrain => 'Bereit zum Training! 🏸';

  @override
  String get corners => 'Ecken';

  @override
  String get notification => 'Benachrichtigung';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get startTraining => 'Training starten';

  @override
  String get settingsSaved => 'Einstellungen erfolgreich gespeichert!';

  @override
  String get trainingSettingsHelp => 'Trainings-Einstellungen Hilfe';

  @override
  String get setsHelp =>
      'Anzahl der Trainingsrunden, die du absolvieren möchtest. Jeder Satz enthält mehrere Schläge.';

  @override
  String get shotsHelp =>
      'Wie viele Eckenbewegungen in jedem Satz. Mehr Schläge = längeres Training pro Satz.';

  @override
  String get speedHelp =>
      'Wie schnell die Eckenaufrufe kommen:\n• 1,0x = Anfänger (langsam)\n• 2,5x = Fortgeschritten\n• 5,0x = Profi (sehr schnell)';

  @override
  String get restHelp =>
      'Erholungszeit zwischen jedem Satz. Nutze diese Zeit, um zu Atem zu kommen und dich auf den nächsten Satz vorzubereiten.';

  @override
  String get notificationHelp =>
      '• Klingelton: Einfache Pieptöne\n• Sprache: Sprachansagen der Eckennummern (\"Ecke 1\", \"Ecke 3\", etc.)';

  @override
  String get gotIt => 'Verstanden!';

  @override
  String get trainingStartingSoon => 'Trainingseinheit startet bald! 🏸';
}
