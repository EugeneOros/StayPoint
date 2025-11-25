// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get appTitle => 'StayPoint';

  @override
  String get overview => 'Przegląd';

  @override
  String get hotels => 'Hotele';

  @override
  String get search => 'Szukaj';

  @override
  String get favorites => 'Ulubione';

  @override
  String get account => 'Konto';

  @override
  String get loading => 'Ładowanie...';

  @override
  String get errorLoadingHotels =>
      'Nie udało się załadować hoteli. Spróbuj ponownie.';

  @override
  String get errorLoadingFavorites =>
      'Nie udało się załadować ulubionych. Spróbuj ponownie.';

  @override
  String get errorTitle => 'Coś poszło nie tak';

  @override
  String get noHotels => 'Brak dostępnych hoteli';

  @override
  String get noFavorites => 'Nie masz jeszcze żadnych ulubionych hoteli';

  @override
  String get noFavoritesTitle => 'Brak ulubionych';

  @override
  String get noFavoritesSubtitle =>
      'Zacznij przeglądać hotele i dodawaj je do ulubionych';

  @override
  String get welcomeTitle => 'Witamy w StayPoint';

  @override
  String get welcomeSubtitle =>
      'Odkryj niesamowite hotele i zaplanuj idealny pobyt';

  @override
  String get addToFavorites => 'Dodaj do ulubionych';

  @override
  String get removeFromFavorites => 'Usuń z ulubionych';

  @override
  String get pricePerNight => 'za noc';

  @override
  String get rating => 'Ocena';

  @override
  String get location => 'Lokalizacja';

  @override
  String get toHotel => 'Do ofert';

  @override
  String get retry => 'Spróbuj ponownie';

  @override
  String ratingDisplay(String rating) {
    return '$rating / 5.0';
  }

  @override
  String get ratingTooltip => 'Informacje o ocenie hotelu';

  @override
  String ratingDescriptionWithReviews(String description, int count) {
    return '$description ($count recenzji)';
  }

  @override
  String get language => 'Język';

  @override
  String get selectLanguage => 'Wybierz język';

  @override
  String get english => 'Angielski';

  @override
  String get german => 'Niemiecki';

  @override
  String get polish => 'Polski';

  @override
  String get from => 'od ';

  @override
  String get perPerson => 'os.';

  @override
  String get inclFlight => 'w tym lot';

  @override
  String days(int count) {
    return '$count Dni';
  }

  @override
  String nights(int count) {
    return '$count Nocy';
  }

  @override
  String adultsAndChildren(int adults, int children) {
    return '$adults Dorosłych, $children Dzieci';
  }

  @override
  String get version => 'Wersja 1.0.0';

  @override
  String get errorToggleFavorite =>
      'Nie udało się zaktualizować ulubionego. Spróbuj ponownie.';
}
