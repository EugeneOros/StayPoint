class Assets {
  Assets._();

  static const Icons icons = Icons._();
  static const Illustrations illustrations = Illustrations._();
}

class Icons {
  const Icons._();

  static const String _path = 'assets/icons';

  final String home = '$_path/home.svg';
  final String search = '$_path/search.svg';
  final String favorites = '$_path/favorites.svg';
  final String profile = '$_path/profile.svg';
  final String smile = '$_path/smile.svg';
  final String emptyFavorite = '$_path/empty_favorite.svg';
  final String welcome = '$_path/welcome.svg';
  final String error = '$_path/error.svg';
}

class Illustrations {
  const Illustrations._();

  static const String _path = 'assets/illustrations';

  final String logo = '$_path/logo.png';
}
