import '../../../shared/result.dart';
import '../../../shared/exceptions/app_exception.dart';

abstract interface class LocaleService {
  Future<Result<String?, LocaleException>> getSavedLocale();
  Future<Result<void, LocaleException>> saveLocale(String localeCode);
}
