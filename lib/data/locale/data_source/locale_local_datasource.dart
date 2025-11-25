import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hotel_booking_app/shared/result.dart';
import 'package:hotel_booking_app/shared/exceptions/app_exception.dart';
import 'package:hotel_booking_app/shared/utils/logger.dart';

const String _localeKey = 'selected_locale';

abstract interface class LocaleLocalDataSource {
  Future<Result<String?, LocaleException>> getSavedLocale();
  Future<Result<void, LocaleException>> saveLocale(String localeCode);
}

@LazySingleton(as: LocaleLocalDataSource)
final class LocaleLocalDataSourceImpl implements LocaleLocalDataSource {
  final SharedPreferences _prefs;

  LocaleLocalDataSourceImpl(this._prefs);

  @override
  Future<Result<String?, LocaleException>> getSavedLocale() async {
    try {
      final locale = _prefs.getString(_localeKey);
      return Success(locale);
    } catch (e) {
      AppLogger.e('Error loading saved locale', e);
      return const Failure(LocaleLoadFailedException());
    }
  }

  @override
  Future<Result<void, LocaleException>> saveLocale(String localeCode) async {
    try {
      await _prefs.setString(_localeKey, localeCode);
      return const Success(null);
    } catch (e) {
      AppLogger.e('Error saving locale', e);
      return const Failure(LocaleSaveFailedException());
    }
  }
}

