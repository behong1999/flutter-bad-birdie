import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Bad Birdie - App for Badminton Nerds'**
  String get appTitle;

  /// Title shown in the home screen app bar
  ///
  /// In en, this message translates to:
  /// **'Bad Birdie'**
  String get homeTitle;

  /// Welcome message title on home screen
  ///
  /// In en, this message translates to:
  /// **'Welcome to Bad Birdie!'**
  String get welcomeTitle;

  /// Welcome message description on home screen
  ///
  /// In en, this message translates to:
  /// **'Improve your badminton skills with footwork training, tactical analysis, and learning resources.'**
  String get welcomeDescription;

  /// Section title for training features
  ///
  /// In en, this message translates to:
  /// **'Training Features'**
  String get trainingFeatures;

  /// Footwork training feature title
  ///
  /// In en, this message translates to:
  /// **'Footwork Training'**
  String get footworkTraining;

  /// Description for footwork training feature
  ///
  /// In en, this message translates to:
  /// **'Practice drills and improve your court movement'**
  String get footworkDescription;

  /// Tactical board feature title
  ///
  /// In en, this message translates to:
  /// **'Tactical Board'**
  String get tacticalBoard;

  /// Description for tactical board feature
  ///
  /// In en, this message translates to:
  /// **'Plan strategies and analyze game situations'**
  String get tacticalDescription;

  /// Learning hub feature title
  ///
  /// In en, this message translates to:
  /// **'Learning Hub'**
  String get learningHub;

  /// Description for learning hub feature
  ///
  /// In en, this message translates to:
  /// **'Discover YouTube channels and tutorials'**
  String get learningDescription;

  /// Message when footwork feature is not yet available
  ///
  /// In en, this message translates to:
  /// **'Footwork training coming soon!'**
  String get footworkComingSoon;

  /// Message when tactical board feature is not yet available
  ///
  /// In en, this message translates to:
  /// **'Tactical board coming soon!'**
  String get tacticalComingSoon;

  /// Message when learning hub feature is not yet available
  ///
  /// In en, this message translates to:
  /// **'Learning hub coming soon!'**
  String get learningComingSoon;

  /// Title for corner selection section
  ///
  /// In en, this message translates to:
  /// **'Choose Corners to Focus'**
  String get chooseCornersTitle;

  /// Description for corner selection
  ///
  /// In en, this message translates to:
  /// **'Select at least 1 corner for your footwork training'**
  String get chooseCornersDescription;

  /// Front left corner label
  ///
  /// In en, this message translates to:
  /// **'Front\nLeft'**
  String get frontLeft;

  /// Front center corner label
  ///
  /// In en, this message translates to:
  /// **'Front\nCenter'**
  String get frontCenter;

  /// Front right corner label
  ///
  /// In en, this message translates to:
  /// **'Front\nRight'**
  String get frontRight;

  /// Mid left corner label
  ///
  /// In en, this message translates to:
  /// **'Mid\nLeft'**
  String get midLeft;

  /// Mid center corner label
  ///
  /// In en, this message translates to:
  /// **'Mid\nCenter'**
  String get midCenter;

  /// Mid right corner label
  ///
  /// In en, this message translates to:
  /// **'Mid\nRight'**
  String get midRight;

  /// Back left corner label
  ///
  /// In en, this message translates to:
  /// **'Back\nLeft'**
  String get backLeft;

  /// Back center corner label
  ///
  /// In en, this message translates to:
  /// **'Back\nCenter'**
  String get backCenter;

  /// Back right corner label
  ///
  /// In en, this message translates to:
  /// **'Back\nRight'**
  String get backRight;

  /// Shows selected corners count and list
  ///
  /// In en, this message translates to:
  /// **'Selected {count} corner{plural}: {corners}'**
  String selectedCorners(int count, String plural, String corners);

  /// Title for training settings section
  ///
  /// In en, this message translates to:
  /// **'Training Settings'**
  String get trainingSettings;

  /// Sets slider label
  ///
  /// In en, this message translates to:
  /// **'Sets'**
  String get sets;

  /// Sets value display
  ///
  /// In en, this message translates to:
  /// **'{count} sets'**
  String setsValue(int count);

  /// Shots per set slider label
  ///
  /// In en, this message translates to:
  /// **'Shots per Set'**
  String get shotsPerSet;

  /// Shots value display
  ///
  /// In en, this message translates to:
  /// **'{count} shots'**
  String shotsValue(int count);

  /// Speed slider label
  ///
  /// In en, this message translates to:
  /// **'Speed'**
  String get speed;

  /// Speed value display
  ///
  /// In en, this message translates to:
  /// **'x{speed}'**
  String speedValue(String speed);

  /// Rest slider label
  ///
  /// In en, this message translates to:
  /// **'Rest Between Sets'**
  String get restBetweenSets;

  /// Rest value display
  ///
  /// In en, this message translates to:
  /// **'{seconds}s'**
  String restValue(int seconds);

  /// Notification mode section title
  ///
  /// In en, this message translates to:
  /// **'Next Move Notification'**
  String get nextMoveNotification;

  /// Ringtone notification mode
  ///
  /// In en, this message translates to:
  /// **'Ringtone'**
  String get ringtone;

  /// Speech notification mode
  ///
  /// In en, this message translates to:
  /// **'Speech'**
  String get speech;

  /// Start training button text
  ///
  /// In en, this message translates to:
  /// **'Let\'s Begin! 🏸'**
  String get letsBegin;

  /// Save settings tooltip
  ///
  /// In en, this message translates to:
  /// **'Save Settings'**
  String get saveSettings;

  /// Help tooltip
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get help;

  /// Training confirmation dialog title
  ///
  /// In en, this message translates to:
  /// **'Ready to Train! 🏸'**
  String get readyToTrain;

  /// Corners label in summary
  ///
  /// In en, this message translates to:
  /// **'Corners'**
  String get corners;

  /// Notification label in summary
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notification;

  /// Cancel button
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Start training button
  ///
  /// In en, this message translates to:
  /// **'Start Training'**
  String get startTraining;

  /// Settings saved confirmation message
  ///
  /// In en, this message translates to:
  /// **'Settings saved successfully!'**
  String get settingsSaved;

  /// Help dialog title
  ///
  /// In en, this message translates to:
  /// **'Training Settings Help'**
  String get trainingSettingsHelp;

  /// Help text for sets
  ///
  /// In en, this message translates to:
  /// **'Number of training rounds you want to complete. Each set contains multiple shots.'**
  String get setsHelp;

  /// Help text for shots
  ///
  /// In en, this message translates to:
  /// **'How many corner movements in each set. More shots = longer training per set.'**
  String get shotsHelp;

  /// Help text for speed
  ///
  /// In en, this message translates to:
  /// **'How fast the corner calls come:\n• 1.0x = Beginner (slow)\n• 2.5x = Intermediate\n• 5.0x = Professional (very fast)'**
  String get speedHelp;

  /// Help text for rest
  ///
  /// In en, this message translates to:
  /// **'Recovery time between each set. Use this time to catch your breath and prepare for the next set.'**
  String get restHelp;

  /// Help text for notification modes
  ///
  /// In en, this message translates to:
  /// **'• Ringtone: Simple beep sounds\n• Speech: Voice calls out corner numbers (\"Corner 1\", \"Corner 3\", etc.)'**
  String get notificationHelp;

  /// Help dialog close button
  ///
  /// In en, this message translates to:
  /// **'Got it!'**
  String get gotIt;

  /// Training start confirmation message
  ///
  /// In en, this message translates to:
  /// **'Training session starting soon! 🏸'**
  String get trainingStartingSoon;

  /// Top-left label for current shot progress
  ///
  /// In en, this message translates to:
  /// **'Shots'**
  String get shotsLabel;

  /// Stop training button label
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get stopLabel;

  /// Pause training button label
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get pauseLabel;

  /// Resume training button label
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get resumeLabel;

  /// Restart training button label
  ///
  /// In en, this message translates to:
  /// **'Again'**
  String get againLabel;

  /// Exit training button label
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get exitLabel;

  /// Direction label shown under current shot name
  ///
  /// In en, this message translates to:
  /// **'Direction'**
  String get directionLabel;

  /// Label shown when all shots are done
  ///
  /// In en, this message translates to:
  /// **'Training Completed'**
  String get trainingCompletedLabel;

  /// Label shown when user stops training
  ///
  /// In en, this message translates to:
  /// **'Training Stopped'**
  String get trainingStoppedLabel;

  /// Back-court shot type clear
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get shotClear;

  /// Back-court shot type drop
  ///
  /// In en, this message translates to:
  /// **'Drop'**
  String get shotDrop;

  /// Back-court shot type smash
  ///
  /// In en, this message translates to:
  /// **'Smash'**
  String get shotSmash;

  /// Front-court shot type lift
  ///
  /// In en, this message translates to:
  /// **'Lift'**
  String get shotLift;

  /// Front-court shot type block
  ///
  /// In en, this message translates to:
  /// **'Block'**
  String get shotBlock;

  /// Front-court shot type kill
  ///
  /// In en, this message translates to:
  /// **'Kill'**
  String get shotKill;

  /// Skip rest dialog button label
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skipLabel;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
