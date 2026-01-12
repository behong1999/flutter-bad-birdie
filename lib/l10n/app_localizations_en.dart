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
}
