import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:hotel_booking_app/core/injection/injection.dart';
import 'package:hotel_booking_app/domain/hotels/service/hotel_service.dart';
import 'package:hotel_booking_app/domain/locale/service/locale_service.dart';
import 'package:hotel_booking_app/domain/main_stream/service/main_stream_service.dart';
import 'package:hotel_booking_app/l10n/app_localizations.dart';
import 'package:hotel_booking_app/theme/theme.dart';
import 'package:hotel_booking_app/presentation/pages/account/cubit/locale_cubit.dart';
import 'package:hotel_booking_app/presentation/router/app_router.dart';

import 'shared/utils/logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await configureDependencies();

  runApp(
    HookedBlocConfigProvider(
      injector: () => getIt.get,
      builderCondition: (state) => state != null,
      listenerCondition: (state) => state != null,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appRouter = AppRouter();
  late final AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;

  @override
  void initState() {
    super.initState();
    _appLinks = AppLinks();
    _initDeepLinks();
  }

  Future<void> _initDeepLinks() async {
      final initialLink = await _appLinks.getInitialLink();
      if (initialLink != null) {
        _handleDeepLink(initialLink);
      }

      _linkSubscription = _appLinks.uriLinkStream.listen(
        _handleDeepLink,
        onError: (error) {
          AppLogger.e('Error handling deep link: $error');
        },
      );
  }

  void _handleDeepLink(Uri uri) {
    if (uri.scheme == 'hotelbooking') {
      final route = _mapDeepLinkToRoute(uri);
      if (route != null) {
        _appRouter.navigate(route);
      }
    }
  }

  PageRouteInfo? _mapDeepLinkToRoute(Uri uri) {
    switch (uri.host) {
      case 'hotels':
        return const HomeRoute(children: [HotelsRoute()]);
      case 'favorites':
        return const HomeRoute(children: [FavoritesRoute()]);
      case 'overview':
        return const HomeRoute(children: [OverviewRoute()]);
      case 'account':
        return const HomeRoute(children: [AccountRoute()]);
      default:
        return null;
    }
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<HotelService>.value(value: getIt<HotelService>()),
        RepositoryProvider<LocaleService>.value(value: getIt<LocaleService>()),
        RepositoryProvider<MainStreamService>.value(
          value: getIt<MainStreamService>(),
        ),
        BlocProvider.value(value: getIt<LocaleCubit>()),
      ],
      child: BlocBuilder<LocaleCubit, LocaleState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'StayPoint',
            theme: AppTheme.darkTheme,
            locale: Locale(state.localeCode),
            localizationsDelegates: [
              AppLocalizations.delegate,
              ...GlobalMaterialLocalizations.delegates,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale('en'), Locale('de'), Locale('pl')],
            routerDelegate: _appRouter.delegate(),
            routeInformationParser: _appRouter.defaultRouteParser(),
          );
        },
      ),
    );
  }
}
