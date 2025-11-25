import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:hotel_booking_app/presentation/pages/home/home_page.dart';

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
  int? _initialTabIndex;
  static const MethodChannel _channel = MethodChannel('app.channel.deeplink');

  @override
  void initState() {
    super.initState();
    _getInitialLink();
    _listenToLinks();
  }

  Future<void> _getInitialLink() async {
    try {
      final String? link = await _channel.invokeMethod('getInitialLink');
      if (link != null) {
        _parseDeepLink(link);
      }
    } catch (e) {
      // No deep link on initial launch
    }
  }

  void _listenToLinks() {
    _channel.setMethodCallHandler((call) async {
      if (call.method == 'onNewLink') {
        final String? link = call.arguments as String?;
        if (link != null) {
          _parseDeepLink(link);
        }
      }
    });
  }

  void _parseDeepLink(String link) {
    final uri = Uri.parse(link);
    if (uri.scheme == 'hotelbooking') {
      if (uri.host == 'hotels') {
        setState(() {
          _initialTabIndex = 1;
        });
      } else if (uri.host == 'favorites') {
        setState(() {
          _initialTabIndex = 2;
        });
      }
    }
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
          return MaterialApp(
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
            onGenerateRoute: (settings) {
              if (settings.name == '/hotels') {
                return MaterialPageRoute(
                  builder: (_) => const HomePage(initialTabIndex: 1),
                );
              } else if (settings.name == '/favorites') {
                return MaterialPageRoute(
                  builder: (_) => const HomePage(initialTabIndex: 2),
                );
              }
              return MaterialPageRoute(
                builder: (_) => HomePage(initialTabIndex: _initialTabIndex),
              );
            },
            home: HomePage(initialTabIndex: _initialTabIndex),
          );
        },
      ),
    );
  }
}
