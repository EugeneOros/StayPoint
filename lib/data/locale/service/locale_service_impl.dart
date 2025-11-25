import 'package:injectable/injectable.dart';
import 'package:hotel_booking_app/domain/locale/service/locale_service.dart';
import 'package:hotel_booking_app/data/locale/data_source/locale_local_datasource.dart';
import 'package:hotel_booking_app/shared/result.dart';
import 'package:hotel_booking_app/shared/exceptions/app_exception.dart';

@LazySingleton(as: LocaleService)
final class LocaleServiceImpl implements LocaleService {
  final LocaleLocalDataSource localDataSource;

  LocaleServiceImpl(this.localDataSource);

  @override
  Future<Result<String?, LocaleException>> getSavedLocale() async {
    return await localDataSource.getSavedLocale();
  }

  @override
  Future<Result<void, LocaleException>> saveLocale(String localeCode) async {
    return await localDataSource.saveLocale(localeCode);
  }
}
