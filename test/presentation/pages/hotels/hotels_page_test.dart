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
import 'package:hotel_booking_app/presentation/pages/hotels/cubit/hotels_cubit.dart';
import 'package:hotel_booking_app/presentation/pages/hotels/cubit/hotels_state.dart';
import 'package:hotel_booking_app/presentation/pages/hotels/hotels_page.dart';
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
    when(
      () => mockHotelService.getFavoriteHotels(),
    ).thenAnswer((_) async => const Success([]));
  });

  group('HotelsPage', () {
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
      when(() => mockHotelService.getHotels()).thenAnswer((_) async {
        // Use a completer to keep the future pending
        final completer = Completer<Result<List<Hotel>, HotelException>>();
        // Don't complete it, so the state stays in loading
        return completer.future;
      });

      final hotelsCubit = HotelsCubit(mockHotelService, mockStreamService);

      await tester.pumpWidget(
        HookedBlocConfigProvider(
          injector: () => <T extends Object>() {
            if (T == HotelsCubit) {
              return hotelsCubit as T;
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
              home: BlocProvider<HotelsCubit>.value(
                value: hotelsCubit,
                child: const HotelsPage(),
              ),
            ),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(); // Allow useOnce to execute and state to update

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      hotelsCubit.close();
    });

    testWidgets('displays error widget when status is error', (
      WidgetTester tester,
    ) async {
      when(
        () => mockHotelService.getHotels(),
      ).thenAnswer((_) async => const Success([]));

      final hotelsCubit = HotelsCubit(mockHotelService, mockStreamService);

      await tester.pumpWidget(
        HookedBlocConfigProvider(
          injector: () => <T extends Object>() {
            if (T == HotelsCubit) {
              return hotelsCubit as T;
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
              home: BlocProvider<HotelsCubit>.value(
                value: hotelsCubit,
                child: const HotelsPage(),
              ),
            ),
          ),
        ),
      );

      hotelsCubit.emit(
        const HotelsState(status: HotelsStatus.error, error: 'Test error'),
      );
      await tester.pump();

      expect(find.text('Test error'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);

      hotelsCubit.close();
    });

    testWidgets('displays empty message when hotels list is empty', (
      WidgetTester tester,
    ) async {
      when(
        () => mockHotelService.getHotels(),
      ).thenAnswer((_) async => const Success([]));

      final hotelsCubit = HotelsCubit(mockHotelService, mockStreamService);

      await tester.pumpWidget(
        HookedBlocConfigProvider(
          injector: () => <T extends Object>() {
            if (T == HotelsCubit) {
              return hotelsCubit as T;
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
              home: BlocProvider<HotelsCubit>.value(
                value: hotelsCubit,
                child: const HotelsPage(),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('No hotels available'), findsOneWidget);

      hotelsCubit.close();
    });

    testWidgets('displays list of hotels', (WidgetTester tester) async {
      when(
        () => mockHotelService.getHotels(),
      ).thenAnswer((_) async => Success(testHotels));

      final hotelsCubit = HotelsCubit(mockHotelService, mockStreamService);

      await tester.pumpWidget(
        HookedBlocConfigProvider(
          injector: () => <T extends Object>() {
            if (T == HotelsCubit) {
              return hotelsCubit as T;
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
              home: BlocProvider<HotelsCubit>.value(
                value: hotelsCubit,
                child: const HotelsPage(),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Test Hotel 1'), findsOneWidget);
      expect(find.text('Test Hotel 2'), findsOneWidget);

      hotelsCubit.close();
    });

    testWidgets('displays app bar with hotels title', (
      WidgetTester tester,
    ) async {
      when(
        () => mockHotelService.getHotels(),
      ).thenAnswer((_) async => const Success([]));

      final hotelsCubit = HotelsCubit(mockHotelService, mockStreamService);

      await tester.pumpWidget(
        HookedBlocConfigProvider(
          injector: () => <T extends Object>() {
            if (T == HotelsCubit) {
              return hotelsCubit as T;
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
              home: BlocProvider<HotelsCubit>.value(
                value: hotelsCubit,
                child: const HotelsPage(),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Hotels'), findsOneWidget);

      hotelsCubit.close();
    });
  });
}
