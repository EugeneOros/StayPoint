class AppLogger {
  static void d(String message, [Object? error]) {
    print('[DEBUG] $message${error != null ? ': $error' : ''}');
  }

  static void e(String message, [Object? error]) {
    print('[ERROR] $message${error != null ? ': $error' : ''}');
  }

  static void i(String message, [Object? error]) {
    print('[INFO] $message${error != null ? ': $error' : ''}');
  }
}

