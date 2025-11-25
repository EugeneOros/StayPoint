// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'StayPoint';

  @override
  String get overview => 'Overview';

  @override
  String get hotels => 'Hotels';

  @override
  String get search => 'Search';

  @override
  String get favorites => 'Favorites';

  @override
  String get account => 'Account';

  @override
  String get loading => 'Loading...';

  @override
  String get errorLoadingHotels => 'Failed to load hotels. Please try again.';

  @override
  String get errorLoadingFavorites =>
      'Failed to load favorites. Please try again.';

  @override
  String get errorTitle => 'Something went wrong';

  @override
  String get noHotels => 'No hotels available';

  @override
  String get noFavorites => 'You haven\'t favorited any hotels yet';

  @override
  String get noFavoritesTitle => 'No Favorites Yet';

  @override
  String get noFavoritesSubtitle =>
      'Start exploring hotels and add them to your favorites';

  @override
  String get welcomeTitle => 'Welcome to StayPoint';

  @override
  String get welcomeSubtitle =>
      'Discover amazing hotels and plan your perfect stay';

  @override
  String get addToFavorites => 'Add to favorites';

  @override
  String get removeFromFavorites => 'Remove from favorites';

  @override
  String get pricePerNight => 'per night';

  @override
  String get rating => 'Rating';

  @override
  String get location => 'Location';

  @override
  String get toHotel => 'To Offers';

  @override
  String get retry => 'Retry';

  @override
  String ratingDisplay(String rating) {
    return '$rating / 5.0';
  }

  @override
  String get ratingTooltip => 'Hotel rating information';

  @override
  String ratingDescriptionWithReviews(String description, int count) {
    return '$description ($count reviews)';
  }

  @override
  String get language => 'Language';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get english => 'English';

  @override
  String get german => 'German';

  @override
  String get polish => 'Polish';

  @override
  String get from => 'from ';

  @override
  String get perPerson => 'per person';

  @override
  String get inclFlight => 'incl. flight';

  @override
  String days(int count) {
    return '$count Days';
  }

  @override
  String nights(int count) {
    return '$count Nights';
  }

  @override
  String adultsAndChildren(int adults, int children) {
    return '$adults Adults, $children Children';
  }

  @override
  String get version => 'Version 1.0.0';

  @override
  String get errorToggleFavorite =>
      'Failed to update favorite. Please try again.';
}
