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
  String get comingSoon => 'Bald verfügbar';

  @override
  String get chooseCornersTitle => 'Ecken zum Trainieren wählen';

  @override
  String get chooseCornersDescription =>
      'Wähle mindestens 1 Ecke für dein Beinarbeit-Training';

  @override
  String get frontLeft => 'Vorne\nLinks';

  @override
  String get frontCenter => 'Vorne\nMitte';

  @override
  String get frontRight => 'Vorne\nRechts';

  @override
  String get midLeft => 'Mitte\nLinks';

  @override
  String get midCenter => 'Mitte\nMitte';

  @override
  String get midRight => 'Mitte\nRechts';

  @override
  String get backLeft => 'Hinten\nLinks';

  @override
  String get backCenter => 'Hinten\nMitte';

  @override
  String get backRight => 'Hinten\nRechts';

  @override
  String selectedCorners(num count, String corners) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString Ecken ausgewählt: $corners',
      one: '$countString Ecke ausgewählt: $corners',
    );
    return '$_temp0';
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
      'Wie schnell die Eckenaufrufe kommen:\n• 1,0x = Anfänger (langsam)\n• 2,5x = Fortgeschritten\n• 4,0x = Profi (sehr schnell)';

  @override
  String get restHelp =>
      'Erholungszeit zwischen jedem Satz. Nutze diese Zeit, um zu Atem zu kommen und dich auf den nächsten Satz vorzubereiten.';

  @override
  String get notificationHelp =>
      '• Klingelton: Einfache Pieptöne\n• Sprache: Sprachansagen des Schlagnamens (\"Clear\", \"Smash\", etc.)';

  @override
  String get gotIt => 'Verstanden!';

  @override
  String get trainingStartingSoon => 'Trainingseinheit startet bald! 🏸';

  @override
  String get shotsLabel => 'Schläge';

  @override
  String get stopLabel => 'Stopp';

  @override
  String get pauseLabel => 'Pause';

  @override
  String get resumeLabel => 'Fortsetzen';

  @override
  String get againLabel => 'Erneut';

  @override
  String get exitLabel => 'Beenden';

  @override
  String get enterFullscreen => 'Vollbild';

  @override
  String get exitFullscreen => 'Vollbild beenden';

  @override
  String get directionLabel => 'Richtung';

  @override
  String get trainingCompletedLabel => 'Training abgeschlossen';

  @override
  String get trainingStoppedLabel => 'Training gestoppt';

  @override
  String get shotClear => 'Clear';

  @override
  String get shotDrop => 'Drop';

  @override
  String get shotSmash => 'Smash';

  @override
  String get shotLift => 'Lift';

  @override
  String get shotBlock => 'Block';

  @override
  String get shotKill => 'Tap';

  @override
  String get shotDrive => 'Drive';

  @override
  String get skipLabel => 'Überspringen';

  @override
  String get savePreset => 'Voreinstellung speichern';

  @override
  String get loadPreset => 'Voreinstellung laden';

  @override
  String get loadPresetHelp =>
      'Tippe in der oberen Leiste auf dieses Symbol, um gespeicherte Voreinstellungen zu öffnen. Wähle eine aus, um Ecken, Schläge, Tempo, Pausenzeit und Benachrichtigung zu übernehmen.';

  @override
  String get savePresetHelp =>
      'Tippe in der oberen Leiste auf dieses Symbol, um deine aktuelle Konfiguration als Voreinstellung zu speichern. Gib ihr einen Namen, damit du sie später wieder laden kannst.';

  @override
  String get presets => 'Voreinstellungen';

  @override
  String get noPresetsYet =>
      'Noch keine Voreinstellungen gespeichert. Tippe auf das Speichern-Symbol, um eine hinzuzufügen.';

  @override
  String get presetNameLabel => 'Name der Voreinstellung';

  @override
  String get save => 'Speichern';

  @override
  String get delete => 'Löschen';

  @override
  String defaultPresetName(int number) {
    return 'Voreinstellung $number';
  }

  @override
  String presetSummary(int sets, int shots, String speed, int rest) {
    return '$sets×$shots Schläge · x$speed · ${rest}s Pause';
  }

  @override
  String presetSaved(String name) {
    return 'Voreinstellung \"$name\" gespeichert';
  }

  @override
  String presetDeleted(String name) {
    return 'Voreinstellung \"$name\" gelöscht';
  }

  @override
  String get selectCornersFirst =>
      'Wähle vor dem Speichern mindestens eine Ecke aus';

  @override
  String get settings => 'Einstellungen';

  @override
  String get appearance => 'Erscheinungsbild';

  @override
  String get language => 'Sprache';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Hell';

  @override
  String get themeDark => 'Dunkel';

  @override
  String get shotSelection => 'Schlagauswahl';

  @override
  String get optional => 'optional';

  @override
  String get presetNameExists =>
      'Existiert bereits. Wähle einen anderen Namen.';

  @override
  String get shotSelectionHelp =>
      'Wähle, welche Schlagarten während des Trainings gerufen werden. Lass die Auswahl leer, um alle für die gewählten Ecken verfügbaren Schläge zu nutzen.';

  @override
  String get singlesLabel => 'Einzel';

  @override
  String get doublesLabel => 'Doppel';

  @override
  String get undoLabel => 'Rückgängig';

  @override
  String get clearBoard => 'Standard wiederherstellen';

  @override
  String get renamePlayerTitle => 'Spieler umbenennen';

  @override
  String get toolPencil => 'Stift';

  @override
  String get toolArrow => 'Pfeil';

  @override
  String get toolMarker => 'Spieler hinzufügen';

  @override
  String get tacticalBoardHelpMarkersTitle => 'Spielermarkierungen';

  @override
  String get tacticalBoardHelpMarkers =>
      'Markierung ziehen zum Verschieben. Etwa 1 Sekunde gedrückt halten (ohne zu bewegen) zum Umbenennen. Blaue und rote Markierungen stehen für jedes Team.';

  @override
  String get tacticalBoardHelpPencil =>
      'Freihandlinien für Wege oder Bereiche zeichnen.';

  @override
  String get tacticalBoardHelpArrow =>
      'Auf dem Feld ziehen, um einen Pfeil für Richtung oder Bewegung zu zeichnen.';

  @override
  String get tacticalBoardHelpColorsTitle => 'Farben';

  @override
  String get tacticalBoardHelpColors =>
      'Farbe für Stift- und Pfeilwerkzeug wählen.';

  @override
  String get tacticalBoardHelpUndo =>
      'Letzte Zeichnung oder Markierungsänderung rückgängig machen.';

  @override
  String get tacticalBoardHelpClear =>
      'Setzt Spielermarkierungen auf ihre Standardpositionen zurück und entfernt alle Zeichnungen.';
}
