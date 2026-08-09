// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Bad Birdie - App for Badminton Nerds';

  @override
  String get homeTitle => 'Bad Birdie';

  @override
  String get welcomeTitle => 'Welcome to Bad Birdie!';

  @override
  String get welcomeDescription =>
      'Improve your badminton skills with footwork training, tactical analysis, and learning resources.';

  @override
  String get trainingFeatures => 'Training Features';

  @override
  String get footworkTraining => 'Footwork Training';

  @override
  String get footworkDescription =>
      'Practice drills and improve your court movement';

  @override
  String get tacticalBoard => 'Tactical Board';

  @override
  String get tacticalDescription =>
      'Plan strategies and analyze game situations';

  @override
  String get learningHub => 'Learning Hub';

  @override
  String get learningDescription => 'Discover YouTube channels and tutorials';

  @override
  String get comingSoon => 'Coming Soon';

  @override
  String get chooseCornersTitle => 'Choose Corners to Focus';

  @override
  String get chooseCornersDescription =>
      'Select at least 1 corner for your footwork training';

  @override
  String get frontLeft => 'Front\nLeft';

  @override
  String get frontCenter => 'Front\nCenter';

  @override
  String get frontRight => 'Front\nRight';

  @override
  String get midLeft => 'Mid\nLeft';

  @override
  String get midCenter => 'Mid\nCenter';

  @override
  String get midRight => 'Mid\nRight';

  @override
  String get backLeft => 'Back\nLeft';

  @override
  String get backCenter => 'Back\nCenter';

  @override
  String get backRight => 'Back\nRight';

  @override
  String selectedCorners(num count, String corners) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Selected $countString corners: $corners',
      one: 'Selected $countString corner: $corners',
    );
    return '$_temp0';
  }

  @override
  String get trainingSettings => 'Training Settings';

  @override
  String get sets => 'Sets';

  @override
  String setsValue(int count) {
    return '$count sets';
  }

  @override
  String get shotsPerSet => 'Shots per Set';

  @override
  String shotsValue(int count) {
    return '$count shots';
  }

  @override
  String get speed => 'Speed';

  @override
  String speedValue(String speed) {
    return 'x$speed';
  }

  @override
  String get restBetweenSets => 'Rest Between Sets';

  @override
  String restValue(int seconds) {
    return '${seconds}s';
  }

  @override
  String get nextMoveNotification => 'Next Move Notification';

  @override
  String get ringtone => 'Ringtone';

  @override
  String get speech => 'Speech';

  @override
  String get letsBegin => 'Let\'s Begin! 🏸';

  @override
  String get saveSettings => 'Save Settings';

  @override
  String get help => 'Help';

  @override
  String get readyToTrain => 'Ready to Train! 🏸';

  @override
  String get corners => 'Corners';

  @override
  String get notification => 'Notification';

  @override
  String get cancel => 'Cancel';

  @override
  String get startTraining => 'Start Training';

  @override
  String get settingsSaved => 'Settings saved successfully!';

  @override
  String get trainingSettingsHelp => 'Training Settings Help';

  @override
  String get setsHelp =>
      'Number of training rounds you want to complete. Each set contains multiple shots.';

  @override
  String get shotsHelp =>
      'How many corner movements in each set. More shots = longer training per set.';

  @override
  String get speedHelp =>
      'How fast the corner calls come:\n• 1.0x = Beginner (slow)\n• 2.5x = Intermediate\n• 4.0x = Professional (very fast)';

  @override
  String get restHelp =>
      'Recovery time between each set. Use this time to catch your breath and prepare for the next set.';

  @override
  String get notificationHelp =>
      '• Ringtone: Simple beep sounds\n• Speech: Voice calls out corner numbers (\"Corner 1\", \"Corner 3\", etc.)';

  @override
  String get gotIt => 'Got it!';

  @override
  String get trainingStartingSoon => 'Training session starting soon! 🏸';

  @override
  String get shotsLabel => 'Shots';

  @override
  String get stopLabel => 'Stop';

  @override
  String get pauseLabel => 'Pause';

  @override
  String get resumeLabel => 'Resume';

  @override
  String get againLabel => 'Again';

  @override
  String get exitLabel => 'Exit';

  @override
  String get directionLabel => 'Direction';

  @override
  String get trainingCompletedLabel => 'Training Completed';

  @override
  String get trainingStoppedLabel => 'Training Stopped';

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
  String get skipLabel => 'Skip';

  @override
  String get savePreset => 'Save Preset';

  @override
  String get loadPreset => 'Load Preset';

  @override
  String get presets => 'Presets';

  @override
  String get noPresetsYet =>
      'No saved presets yet. Tap the save icon to add one.';

  @override
  String get presetNameLabel => 'Preset name';

  @override
  String get save => 'Save';

  @override
  String get delete => 'Delete';

  @override
  String defaultPresetName(int number) {
    return 'Preset $number';
  }

  @override
  String presetSummary(int sets, int shots, String speed, int rest) {
    return '$sets×$shots shots · x$speed · ${rest}s rest';
  }

  @override
  String presetSaved(String name) {
    return 'Preset \"$name\" saved';
  }

  @override
  String presetDeleted(String name) {
    return 'Preset \"$name\" deleted';
  }

  @override
  String get selectCornersFirst => 'Select at least one corner before saving';

  @override
  String get settings => 'Settings';

  @override
  String get appearance => 'Appearance';

  @override
  String get language => 'Language';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get shotSelection => 'Shot selection';

  @override
  String get optional => 'optional';

  @override
  String get presetNameExists => 'Already exists. Try a different name.';

  @override
  String get shotSelectionHelp =>
      'Pick which shot types to call during training. Leave empty to use all shots available for the selected corners.';

  @override
  String get singlesLabel => 'Singles';

  @override
  String get doublesLabel => 'Doubles';

  @override
  String get undoLabel => 'Undo';

  @override
  String get clearBoard => 'Reset to default';

  @override
  String get renamePlayerTitle => 'Rename player';

  @override
  String get toolPencil => 'Pencil';

  @override
  String get toolArrow => 'Arrow';

  @override
  String get toolMarker => 'Add player';

  @override
  String get tacticalBoardHelpMarkersTitle => 'Player markers';

  @override
  String get tacticalBoardHelpMarkers =>
      'Drag a marker to move it. Press and hold for about 1 second without moving to rename it. Blue and red markers represent each team.';

  @override
  String get tacticalBoardHelpPencil =>
      'Draw freehand lines to show paths or areas.';

  @override
  String get tacticalBoardHelpArrow =>
      'Drag on the court to draw an arrow showing direction or movement.';

  @override
  String get tacticalBoardHelpColorsTitle => 'Colors';

  @override
  String get tacticalBoardHelpColors =>
      'Tap a color to choose the stroke color for pencil and arrow tools.';

  @override
  String get tacticalBoardHelpUndo => 'Undo the last drawing or marker change.';

  @override
  String get tacticalBoardHelpClear =>
      'Reset the court to default by removing all drawings.';
}
