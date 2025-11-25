// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:http/http.dart' as _i519;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../data/hotels/data_source/hotel_remote_datasource.dart' as _i478;
import '../../data/hotels/service/hotel_repository_impl.dart' as _i975;
import '../../data/locale/data_source/locale_local_datasource.dart' as _i233;
import '../../data/locale/service/locale_service_impl.dart' as _i918;
import '../../data/main_stream/service/main_stream_service_impl.dart' as _i905;
import '../../domain/hotels/service/hotel_service.dart' as _i216;
import '../../domain/locale/service/locale_service.dart' as _i992;
import '../../domain/main_stream/service/main_stream_service.dart' as _i820;
import '../../presentation/pages/account/cubit/locale_cubit.dart' as _i550;
import '../../presentation/pages/favorites/cubit/favorites_cubit.dart' as _i49;
import '../../presentation/pages/hotels/cubit/hotels_cubit.dart' as _i220;
import 'injection_module.dart' as _i212;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final injectionModule = _$InjectionModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => injectionModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i519.Client>(() => injectionModule.httpClient);
    gh.lazySingleton<_i233.LocaleLocalDataSource>(
        () => _i233.LocaleLocalDataSourceImpl(gh<_i460.SharedPreferences>()));
    gh.lazySingleton<_i820.MainStreamService>(
        () => _i905.MainStreamServiceImpl());
    gh.lazySingleton<_i992.LocaleService>(
        () => _i918.LocaleServiceImpl(gh<_i233.LocaleLocalDataSource>()));
    gh.lazySingleton<_i550.LocaleCubit>(
        () => _i550.LocaleCubit(gh<_i992.LocaleService>()));
    gh.lazySingleton<_i478.HotelRemoteDataSource>(
        () => _i478.HotelRemoteDataSourceImpl(gh<_i519.Client>()));
    gh.lazySingleton<_i216.HotelService>(() => _i975.HotelServiceImpl(
          gh<_i478.HotelRemoteDataSource>(),
          gh<_i820.MainStreamService>(),
        ));
    gh.factory<_i49.FavoritesCubit>(() => _i49.FavoritesCubit(
          gh<_i216.HotelService>(),
          gh<_i820.MainStreamService>(),
        ));
    gh.factory<_i220.HotelsCubit>(() => _i220.HotelsCubit(
          gh<_i216.HotelService>(),
          gh<_i820.MainStreamService>(),
        ));
    return this;
  }
}

class _$InjectionModule extends _i212.InjectionModule {}
