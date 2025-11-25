import 'package:flutter/material.dart';

class AppLogger {
  static void d(String message, [Object? error]) {
    debugPrint('[DEBUG] $message${error != null ? ': $error' : ''}');
  }

  static void e(String message, [Object? error]) {
    debugPrint('[ERROR] $message${error != null ? ': $error' : ''}');
  }

  static void i(String message, [Object? error]) {
    debugPrint('[INFO] $message${error != null ? ': $error' : ''}');
  }
}

