// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'StayPoint';

  @override
  String get overview => 'Übersicht';

  @override
  String get hotels => 'Hotels';

  @override
  String get search => 'Suche';

  @override
  String get favorites => 'Favoriten';

  @override
  String get account => 'Konto';

  @override
  String get loading => 'Laden...';

  @override
  String get errorLoadingHotels =>
      'Hotels konnten nicht geladen werden. Bitte versuchen Sie es erneut.';

  @override
  String get errorLoadingFavorites =>
      'Favoriten konnten nicht geladen werden. Bitte versuchen Sie es erneut.';

  @override
  String get errorTitle => 'Etwas ist schief gelaufen';

  @override
  String get noHotels => 'Keine Hotels verfügbar';

  @override
  String get noFavorites =>
      'Sie haben noch keine Hotels als Favoriten markiert';

  @override
  String get noFavoritesTitle => 'Noch keine Favoriten';

  @override
  String get noFavoritesSubtitle =>
      'Beginnen Sie, Hotels zu erkunden und fügen Sie sie zu Ihren Favoriten hinzu';

  @override
  String get welcomeTitle => 'Willkommen bei StayPoint';

  @override
  String get welcomeSubtitle =>
      'Entdecken Sie fantastische Hotels und planen Sie Ihren perfekten Aufenthalt';

  @override
  String get addToFavorites => 'Zu Favoriten hinzufügen';

  @override
  String get removeFromFavorites => 'Aus Favoriten entfernen';

  @override
  String get pricePerNight => 'pro Nacht';

  @override
  String get rating => 'Bewertung';

  @override
  String get location => 'Standort';

  @override
  String get toHotel => 'Zu den Angeboten';

  @override
  String get retry => 'Wiederholen';

  @override
  String ratingDisplay(String rating) {
    return '$rating / 5.0';
  }

  @override
  String get ratingTooltip => 'Hotelbewertungsinformationen';

  @override
  String ratingDescriptionWithReviews(String description, int count) {
    return '$description ($count Bew.)';
  }

  @override
  String get language => 'Sprache';

  @override
  String get selectLanguage => 'Sprache auswählen';

  @override
  String get english => 'Englisch';

  @override
  String get german => 'Deutsch';

  @override
  String get polish => 'Polnisch';

  @override
  String get from => 'ab ';

  @override
  String get perPerson => 'p.P.';

  @override
  String get inclFlight => 'inkl. Flug';

  @override
  String days(int count) {
    return '$count Tage';
  }

  @override
  String nights(int count) {
    return '$count Nächte';
  }

  @override
  String adultsAndChildren(int adults, int children) {
    return '$adults Erw., $children Kinder';
  }

  @override
  String get version => 'Version 1.0.0';

  @override
  String get errorToggleFavorite =>
      'Favorit konnte nicht aktualisiert werden. Bitte versuchen Sie es erneut.';
}
