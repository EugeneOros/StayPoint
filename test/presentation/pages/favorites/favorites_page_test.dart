import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:hotel_booking_app/domain/hotels/models/hotel.dart';
import 'package:hotel_booking_app/domain/hotels/service/hotel_service.dart';
import 'package:hotel_booking_app/domain/main_stream/service/main_stream_service.dart';
import 'package:hotel_booking_app/l10n/app_localizations.dart';
import 'package:hotel_booking_app/presentation/pages/favorites/cubit/favorites_cubit.dart';
import 'package:hotel_booking_app/presentation/pages/favorites/cubit/favorites_state.dart';
import 'package:hotel_booking_app/presentation/pages/favorites/favorites_page.dart';
import 'package:hotel_booking_app/shared/exceptions/app_exception.dart';
import 'package:hotel_booking_app/shared/result.dart';
import 'package:mocktail/mocktail.dart';

class MockHotelService extends Mock implements HotelService {}

class MockMainStreamService extends Mock implements MainStreamService {}

void main() {
  late MockHotelService mockHotelService;
  late MockMainStreamService mockStreamService;

  setUp(() {
    mockHotelService = MockHotelService();
    mockStreamService = MockMainStreamService();

    when(
      () => mockStreamService.getStream(),
    ).thenAnswer((_) => const Stream.empty());
  });

  group('FavoritesPage', () {
    final testHotels = [
      const Hotel(
        id: '1',
        name: 'Test Hotel 1',
        location: 'Test Location 1',
        images: [],
        description: 'Test Description 1',
      ),
      const Hotel(
        id: '2',
        name: 'Test Hotel 2',
        location: 'Test Location 2',
        images: [],
        description: 'Test Description 2',
      ),
    ];

    testWidgets('displays loading widget when status is loading', (
      WidgetTester tester,
    ) async {
      when(() => mockHotelService.getFavoriteHotels()).thenAnswer((_) async {
        // Use a completer to keep the future pending
        final completer = Completer<Result<List<Hotel>, FavoritesException>>();
        // Don't complete it, so the state stays in loading
        return completer.future;
      });

      final cubit = FavoritesCubit(mockHotelService, mockStreamService);

      await tester.pumpWidget(
        HookedBlocConfigProvider(
          injector: () => <T extends Object>() {
            if (T == FavoritesCubit) {
              return cubit as T;
            }
            throw UnimplementedError('No provider for type $T');
          },
          builderCondition: (state) => state != null,
          listenerCondition: (state) => state != null,
          child: MultiRepositoryProvider(
            providers: [
              RepositoryProvider<HotelService>.value(value: mockHotelService),
              RepositoryProvider<MainStreamService>.value(
                value: mockStreamService,
              ),
            ],
            child: MaterialApp(
              localizationsDelegates: const [
                AppLocalizations.delegate,
                ...GlobalMaterialLocalizations.delegates,
              ],
              supportedLocales: const [
                Locale('en'),
                Locale('de'),
                Locale('pl'),
              ],
              home: BlocProvider<FavoritesCubit>.value(
                value: cubit,
                child: const FavoritesPage(),
              ),
            ),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(); // Allow useOnce to execute and state to update

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      cubit.close();
    });

    testWidgets('displays error widget when status is error', (
      WidgetTester tester,
    ) async {
      when(() => mockHotelService.getFavoriteHotels()).thenAnswer((_) async {
        // Use a completer to keep the future pending so loadFavorites doesn't complete
        final completer = Completer<Result<List<Hotel>, FavoritesException>>();
        // Don't complete it, so we can manually emit error state
        return completer.future;
      });

      final cubit = FavoritesCubit(mockHotelService, mockStreamService);

      await tester.pumpWidget(
        HookedBlocConfigProvider(
          injector: () => <T extends Object>() {
            if (T == FavoritesCubit) {
              return cubit as T;
            }
            throw UnimplementedError('No provider for type $T');
          },
          builderCondition: (state) => state != null,
          listenerCondition: (state) => state != null,
          child: MultiRepositoryProvider(
            providers: [
              RepositoryProvider<HotelService>.value(value: mockHotelService),
              RepositoryProvider<MainStreamService>.value(
                value: mockStreamService,
              ),
            ],
            child: MaterialApp(
              localizationsDelegates: const [
                AppLocalizations.delegate,
                ...GlobalMaterialLocalizations.delegates,
              ],
              supportedLocales: const [
                Locale('en'),
                Locale('de'),
                Locale('pl'),
              ],
              home: BlocProvider<FavoritesCubit>.value(
                value: cubit,
                child: const FavoritesPage(),
              ),
            ),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(); // Allow useOnce to execute and state to be loading
      cubit.emit(
        const FavoritesState(
          status: FavoritesStatus.error,
          error: 'Test error',
        ),
      );
      await tester.pump();

      expect(find.text('Test error'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);

      cubit.close();
    });

    testWidgets('displays empty message when favorites list is empty', (
      WidgetTester tester,
    ) async {
      when(
        () => mockHotelService.getFavoriteHotels(),
      ).thenAnswer((_) async => const Success([]));

      final cubit = FavoritesCubit(mockHotelService, mockStreamService);

      await tester.pumpWidget(
        HookedBlocConfigProvider(
          injector: () => <T extends Object>() {
            if (T == FavoritesCubit) {
              return cubit as T;
            }
            throw UnimplementedError('No provider for type $T');
          },
          builderCondition: (state) => state != null,
          listenerCondition: (state) => state != null,
          child: MultiRepositoryProvider(
            providers: [
              RepositoryProvider<HotelService>.value(value: mockHotelService),
              RepositoryProvider<MainStreamService>.value(
                value: mockStreamService,
              ),
            ],
            child: MaterialApp(
              localizationsDelegates: const [
                AppLocalizations.delegate,
                ...GlobalMaterialLocalizations.delegates,
              ],
              supportedLocales: const [
                Locale('en'),
                Locale('de'),
                Locale('pl'),
              ],
              home: BlocProvider<FavoritesCubit>.value(
                value: cubit,
                child: const FavoritesPage(),
              ),
            ),
          ),
        ),
      );

      cubit.loadFavorites();
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      expect(find.text('No Favorites Yet'), findsOneWidget);

      cubit.close();
    });

    testWidgets('displays list of favorite hotels', (
      WidgetTester tester,
    ) async {
      when(
        () => mockHotelService.getFavoriteHotels(),
      ).thenAnswer((_) async => Success(testHotels));

      final cubit = FavoritesCubit(mockHotelService, mockStreamService);

      await tester.pumpWidget(
        HookedBlocConfigProvider(
          injector: () => <T extends Object>() {
            if (T == FavoritesCubit) {
              return cubit as T;
            }
            throw UnimplementedError('No provider for type $T');
          },
          builderCondition: (state) => state != null,
          listenerCondition: (state) => state != null,
          child: MultiRepositoryProvider(
            providers: [
              RepositoryProvider<HotelService>.value(value: mockHotelService),
              RepositoryProvider<MainStreamService>.value(
                value: mockStreamService,
              ),
            ],
            child: MaterialApp(
              localizationsDelegates: const [
                AppLocalizations.delegate,
                ...GlobalMaterialLocalizations.delegates,
              ],
              supportedLocales: const [
                Locale('en'),
                Locale('de'),
                Locale('pl'),
              ],
              home: BlocProvider<FavoritesCubit>.value(
                value: cubit,
                child: const FavoritesPage(),
              ),
            ),
          ),
        ),
      );

      cubit.loadFavorites();
      await tester.pumpAndSettle();

      expect(find.text('Test Hotel 1'), findsOneWidget);
      expect(find.text('Test Hotel 2'), findsOneWidget);

      cubit.close();
    });

    testWidgets('displays app bar with favorites title', (
      WidgetTester tester,
    ) async {
      when(
        () => mockHotelService.getFavoriteHotels(),
      ).thenAnswer((_) async => const Success([]));

      final cubit = FavoritesCubit(mockHotelService, mockStreamService);

      await tester.pumpWidget(
        HookedBlocConfigProvider(
          injector: () => <T extends Object>() {
            if (T == FavoritesCubit) {
              return cubit as T;
            }
            throw UnimplementedError('No provider for type $T');
          },
          builderCondition: (state) => state != null,
          listenerCondition: (state) => state != null,
          child: MultiRepositoryProvider(
            providers: [
              RepositoryProvider<HotelService>.value(value: mockHotelService),
              RepositoryProvider<MainStreamService>.value(
                value: mockStreamService,
              ),
            ],
            child: MaterialApp(
              localizationsDelegates: const [
                AppLocalizations.delegate,
                ...GlobalMaterialLocalizations.delegates,
              ],
              supportedLocales: const [
                Locale('en'),
                Locale('de'),
                Locale('pl'),
              ],
              home: BlocProvider<FavoritesCubit>.value(
                value: cubit,
                child: const FavoritesPage(),
              ),
            ),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Favorites'), findsOneWidget);

      cubit.close();
    });
  });
}
