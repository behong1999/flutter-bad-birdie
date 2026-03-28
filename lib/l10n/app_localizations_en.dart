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
  String get footworkComingSoon => 'Footwork training coming soon!';

  @override
  String get tacticalComingSoon => 'Tactical board coming soon!';

  @override
  String get learningComingSoon => 'Learning hub coming soon!';

  @override
  String get chooseCornersTitle => 'Choose Corners to Focus';

  @override
  String get chooseCornersDescription =>
      'Select at least 1 corner for your footwork training';

  @override
  String get frontLeft => 'Front\nLeft';

  @override
  String get frontRight => 'Front\nRight';

  @override
  String get midLeft => 'Mid\nLeft';

  @override
  String get midRight => 'Mid\nRight';

  @override
  String get backLeft => 'Back\nLeft';

  @override
  String get backRight => 'Back\nRight';

  @override
  String selectedCorners(int count, String plural, String corners) {
    return 'Selected $count corner$plural: $corners';
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
      'How fast the corner calls come:\n• 1.0x = Beginner (slow)\n• 2.5x = Intermediate\n• 5.0x = Professional (very fast)';

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
}
