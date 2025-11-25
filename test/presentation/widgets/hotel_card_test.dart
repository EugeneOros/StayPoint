import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hotel_booking_app/domain/hotels/models/hotel.dart';
import 'package:hotel_booking_app/domain/hotels/service/hotel_service.dart';
import 'package:hotel_booking_app/l10n/app_localizations.dart';
import 'package:hotel_booking_app/presentation/pages/favorites/cubit/favorites_cubit.dart';
import 'package:hotel_booking_app/presentation/widgets/hotel_card/hotel_card.dart';
import 'package:hotel_booking_app/domain/main_stream/service/main_stream_service.dart';
import 'package:hotel_booking_app/shared/result.dart';
import 'package:mocktail/mocktail.dart';

class MockHotelService extends Mock implements HotelService {}

class MockMainStreamService extends Mock implements MainStreamService {}

void main() {
  late FavoritesCubit favoritesCubit;

  setUpAll(() {
    registerFallbackValue(
      const Hotel(
        id: 'fallback',
        name: 'Fallback Hotel',
        location: 'Fallback Location',
        description: 'Fallback Description',
        images: [],
      ),
    );
  });

  setUp(() {
    final mockHotelService = MockHotelService();
    final mockStreamService = MockMainStreamService();

    when(
      () => mockStreamService.getStream(),
    ).thenAnswer((_) => const Stream.empty());
    when(
      () => mockHotelService.getFavoriteHotels(),
    ).thenAnswer((_) async => const Success([]));

    favoritesCubit = FavoritesCubit(mockHotelService, mockStreamService);
  });

  tearDown(() {
    favoritesCubit.close();
  });

  group('HotelCard', () {
    final testHotel = const Hotel(
      id: '1',
      name: 'Test Hotel',
      location: 'Test Location',
      description: 'Test Description',
      images: [],
    );

    testWidgets('displays hotel name', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            ...GlobalMaterialLocalizations.delegates,
          ],
          supportedLocales: const [Locale('en'), Locale('de'), Locale('pl')],
          home: Scaffold(
            body: BlocProvider<FavoritesCubit>.value(
              value: favoritesCubit,
              child: HotelCard(
                hotel: testHotel,
                isFavorite: true,
                onToggleFavorite: () {},
              ),
            ),
          ),
        ),
      );

      expect(find.text('Test Hotel'), findsOneWidget);
    });

    testWidgets('displays hotel location', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            ...GlobalMaterialLocalizations.delegates,
          ],
          supportedLocales: const [Locale('en'), Locale('de'), Locale('pl')],
          home: Scaffold(
            body: BlocProvider<FavoritesCubit>.value(
              value: favoritesCubit,
              child: HotelCard(
                hotel: testHotel,
                isFavorite: true,
                onToggleFavorite: () {},
              ),
            ),
          ),
        ),
      );

      expect(find.text('Test Location'), findsOneWidget);
    });

    testWidgets('displays favorite icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            ...GlobalMaterialLocalizations.delegates,
          ],
          supportedLocales: const [Locale('en'), Locale('de'), Locale('pl')],
          home: Scaffold(
            body: BlocProvider<FavoritesCubit>.value(
              value: favoritesCubit,
              child: HotelCard(
                hotel: testHotel,
                isFavorite: true,
                onToggleFavorite: () {},
              ),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.favorite_rounded), findsOneWidget);
    });

    testWidgets('toggles favorite when favorite icon is tapped', (
      WidgetTester tester,
    ) async {
      final mockHotelService = MockHotelService();
      final mockStreamService = MockMainStreamService();

      when(
        () => mockStreamService.getStream(),
      ).thenAnswer((_) => const Stream.empty());
      when(
        () => mockHotelService.getFavoriteHotels(),
      ).thenAnswer((_) async => const Success([]));
      when(
        () => mockHotelService.toggleFavorite(any<Hotel>()),
      ).thenAnswer((_) async => const Success(null));

      final cubit = FavoritesCubit(mockHotelService, mockStreamService);

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            ...GlobalMaterialLocalizations.delegates,
          ],
          supportedLocales: const [Locale('en'), Locale('de'), Locale('pl')],
          home: Scaffold(
            body: BlocProvider<FavoritesCubit>.value(
              value: cubit,
              child: HotelCard(
                hotel: testHotel,
                isFavorite: true,
                onToggleFavorite: () => cubit.toggleFavorite(testHotel),
              ),
            ),
          ),
        ),
      );

      final favoriteIcon = find.byIcon(Icons.favorite_rounded);
      expect(favoriteIcon, findsOneWidget);

      await tester.tap(favoriteIcon);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      verify(() => mockHotelService.toggleFavorite(testHotel)).called(1);

      cubit.close();
    });

    testWidgets('displays filled favorite icon when hotel is favorited', (
      WidgetTester tester,
    ) async {
      final mockHotelService = MockHotelService();
      final mockStreamService = MockMainStreamService();

      when(
        () => mockStreamService.getStream(),
      ).thenAnswer((_) => const Stream.empty());
      when(
        () => mockHotelService.getFavoriteHotels(),
      ).thenAnswer((_) async => Success([testHotel]));

      final cubit = FavoritesCubit(mockHotelService, mockStreamService);

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            ...GlobalMaterialLocalizations.delegates,
          ],
          supportedLocales: const [Locale('en'), Locale('de'), Locale('pl')],
          home: Scaffold(
            body: BlocProvider<FavoritesCubit>.value(
              value: cubit,
              child: HotelCard(
                hotel: testHotel,
                isFavorite: true,
                onToggleFavorite: () {},
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle(const Duration(seconds: 2));

      expect(find.byIcon(Icons.favorite_rounded), findsOneWidget);

      cubit.close();
    });
  });
}
