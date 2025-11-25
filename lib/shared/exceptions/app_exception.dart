sealed class AppException implements Exception {
  const AppException();
}

sealed class HotelException extends AppException {
  const HotelException();
}

final class HotelFetchFailedException extends HotelException {
  const HotelFetchFailedException();
}

final class HotelNotFoundException extends HotelException {
  const HotelNotFoundException();
}

sealed class FavoritesException extends AppException {
  const FavoritesException();
}

final class FavoritesSaveFailedException extends FavoritesException {
  const FavoritesSaveFailedException();
}

final class FavoritesLoadFailedException extends FavoritesException {
  const FavoritesLoadFailedException();
}

sealed class LocaleException extends AppException {
  const LocaleException();
}

final class LocaleSaveFailedException extends LocaleException {
  const LocaleSaveFailedException();
}

final class LocaleLoadFailedException extends LocaleException {
  const LocaleLoadFailedException();
}

