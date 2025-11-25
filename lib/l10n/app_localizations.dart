import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_pl.dart';

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
    Locale('pl'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'StayPoint'**
  String get appTitle;

  /// Overview tab title
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// Hotels tab title
  ///
  /// In en, this message translates to:
  /// **'Hotels'**
  String get hotels;

  /// Search tab title
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// Favorites tab title
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// Account tab title
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// Loading message
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// Error message when hotels fail to load
  ///
  /// In en, this message translates to:
  /// **'Failed to load hotels. Please try again.'**
  String get errorLoadingHotels;

  /// Error message when favorites fail to load
  ///
  /// In en, this message translates to:
  /// **'Failed to load favorites. Please try again.'**
  String get errorLoadingFavorites;

  /// Title for error state
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get errorTitle;

  /// Message when no hotels are found
  ///
  /// In en, this message translates to:
  /// **'No hotels available'**
  String get noHotels;

  /// Message when no favorites exist
  ///
  /// In en, this message translates to:
  /// **'You haven\'t favorited any hotels yet'**
  String get noFavorites;

  /// Title for empty favorites state
  ///
  /// In en, this message translates to:
  /// **'No Favorites Yet'**
  String get noFavoritesTitle;

  /// Subtitle for empty favorites state
  ///
  /// In en, this message translates to:
  /// **'Start exploring hotels and add them to your favorites'**
  String get noFavoritesSubtitle;

  /// Title for welcome/overview page
  ///
  /// In en, this message translates to:
  /// **'Welcome to StayPoint'**
  String get welcomeTitle;

  /// Subtitle for welcome/overview page
  ///
  /// In en, this message translates to:
  /// **'Discover amazing hotels and plan your perfect stay'**
  String get welcomeSubtitle;

  /// Add to favorites action
  ///
  /// In en, this message translates to:
  /// **'Add to favorites'**
  String get addToFavorites;

  /// Remove from favorites action
  ///
  /// In en, this message translates to:
  /// **'Remove from favorites'**
  String get removeFromFavorites;

  /// Price per night label
  ///
  /// In en, this message translates to:
  /// **'per night'**
  String get pricePerNight;

  /// Rating label
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get rating;

  /// Location label
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// Button text to navigate to offers
  ///
  /// In en, this message translates to:
  /// **'To Offers'**
  String get toHotel;

  /// Retry button text
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// Rating display with parameter
  ///
  /// In en, this message translates to:
  /// **'{rating} / 5.0'**
  String ratingDisplay(String rating);

  /// Tooltip text for rating question mark icon
  ///
  /// In en, this message translates to:
  /// **'Hotel rating information'**
  String get ratingTooltip;

  /// Rating description with review count
  ///
  /// In en, this message translates to:
  /// **'{description} ({count} reviews)'**
  String ratingDescriptionWithReviews(String description, int count);

  /// Language selector label
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Select language dialog title
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// English language name
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// German language name
  ///
  /// In en, this message translates to:
  /// **'German'**
  String get german;

  /// Polish language name
  ///
  /// In en, this message translates to:
  /// **'Polish'**
  String get polish;

  /// Price prefix 'from'
  ///
  /// In en, this message translates to:
  /// **'from '**
  String get from;

  /// Per person label
  ///
  /// In en, this message translates to:
  /// **'per person'**
  String get perPerson;

  /// Flight included label
  ///
  /// In en, this message translates to:
  /// **'incl. flight'**
  String get inclFlight;

  /// Days count label
  ///
  /// In en, this message translates to:
  /// **'{count} Days'**
  String days(int count);

  /// Nights count label
  ///
  /// In en, this message translates to:
  /// **'{count} Nights'**
  String nights(int count);

  /// Adults and children count label
  ///
  /// In en, this message translates to:
  /// **'{adults} Adults, {children} Children'**
  String adultsAndChildren(int adults, int children);

  /// App version number
  ///
  /// In en, this message translates to:
  /// **'Version 1.0.0'**
  String get version;

  /// Error message when toggling favorite fails
  ///
  /// In en, this message translates to:
  /// **'Failed to update favorite. Please try again.'**
  String get errorToggleFavorite;
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
      <String>['de', 'en', 'pl'].contains(locale.languageCode);

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
    case 'pl':
      return AppLocalizationsPl();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
