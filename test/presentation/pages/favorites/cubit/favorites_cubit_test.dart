import 'dart:async';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_booking_app/domain/hotels/models/hotel.dart';
import 'package:hotel_booking_app/domain/hotels/service/hotel_service.dart';
import 'package:hotel_booking_app/domain/main_stream/service/main_stream_service.dart';
import 'package:hotel_booking_app/data/hotels/service/hotel_event.dart';
import 'package:hotel_booking_app/presentation/pages/favorites/cubit/favorites_cubit.dart';
import 'package:hotel_booking_app/presentation/pages/favorites/cubit/favorites_state.dart';
import 'package:hotel_booking_app/shared/result.dart';
import 'package:hotel_booking_app/shared/exceptions/app_exception.dart';
import 'package:mocktail/mocktail.dart';

class MockHotelService extends Mock implements HotelService {}

class MockMainStreamService extends Mock implements MainStreamService {}

void main() {
  late MockHotelService mockHotelService;
  late MockMainStreamService mockMainStreamService;
  late StreamController<MainStreamEvent> streamController;

  setUpAll(() {
    registerFallbackValue(
      const Hotel(
        id: 'fallback',
        name: 'Fallback Hotel',
        location: 'Fallback Location',
        images: [],
        description: 'Fallback Description',
      ),
    );
  });

  setUp(() {
    mockHotelService = MockHotelService();
    mockMainStreamService = MockMainStreamService();
    streamController = StreamController<MainStreamEvent>.broadcast();

    when(
      () => mockMainStreamService.getStream(),
    ).thenAnswer((_) => streamController.stream);
  });

  tearDown(() {
    streamController.close();
  });

  group('FavoritesCubit', () {
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

    test('initial state is FavoritesState.loading', () {
      when(
        () => mockHotelService.getFavoriteHotels(),
      ).thenAnswer((_) async => Success(testHotels));

      final cubit = FavoritesCubit(mockHotelService, mockMainStreamService);

      expect(cubit.state.status, FavoritesStatus.loading);
      expect(cubit.state.favorites, isEmpty);
      expect(cubit.state.favoriteIds, isEmpty);

      cubit.close();
    });

    blocTest<FavoritesCubit, FavoritesState>(
      'emits [loading, loaded] when loadFavorites succeeds',
      setUp: () {
        when(
          () => mockHotelService.getFavoriteHotels(),
        ).thenAnswer((_) async => Success(testHotels));
      },
      build: () => FavoritesCubit(mockHotelService, mockMainStreamService),
      act: (cubit) => cubit.loadFavorites(),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        const FavoritesState(status: FavoritesStatus.loading),
        FavoritesState(
          status: FavoritesStatus.loaded,
          favorites: testHotels,
          favoriteIds: {'1', '2'},
        ),
      ],
      verify: (_) {
        verify(() => mockHotelService.getFavoriteHotels()).called(1);
      },
    );

    blocTest<FavoritesCubit, FavoritesState>(
      'emits [loading, error] when loadFavorites fails',
      setUp: () {
        when(() => mockHotelService.getFavoriteHotels()).thenAnswer(
          (_) async => const Failure(FavoritesLoadFailedException()),
        );
      },
      build: () => FavoritesCubit(mockHotelService, mockMainStreamService),
      act: (cubit) => cubit.loadFavorites(),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        const FavoritesState(status: FavoritesStatus.loading),
        const FavoritesState(
          status: FavoritesStatus.error,
          error: 'Instance of \'FavoritesLoadFailedException\'',
        ),
      ],
    );

    blocTest<FavoritesCubit, FavoritesState>(
      'isFavorite returns true when hotel is in favoriteIds',
      setUp: () {
        when(
          () => mockHotelService.getFavoriteHotels(),
        ).thenAnswer((_) async => Success(testHotels));
      },
      build: () => FavoritesCubit(mockHotelService, mockMainStreamService),
      act: (cubit) async {
        await cubit.loadFavorites();
        expect(cubit.state.isFavorite('1'), isTrue);
        expect(cubit.state.isFavorite('2'), isTrue);
        expect(cubit.state.isFavorite('3'), isFalse);
      },
      wait: const Duration(milliseconds: 100),
    );

    blocTest<FavoritesCubit, FavoritesState>(
      'toggleFavorite calls repository and does not emit on success',
      setUp: () {
        when(
          () => mockHotelService.getFavoriteHotels(),
        ).thenAnswer((_) async => Success(testHotels));
        when(
          () => mockHotelService.toggleFavorite(any()),
        ).thenAnswer((_) async => const Success(null));
      },
      build: () => FavoritesCubit(mockHotelService, mockMainStreamService),
      act: (cubit) async {
        await cubit.toggleFavorite(testHotels[0]);
      },
      expect: () => [],
      verify: (_) {
        verify(() => mockHotelService.toggleFavorite(testHotels[0])).called(1);
      },
    );

    blocTest<FavoritesCubit, FavoritesState>(
      'toggleFavorite does not emit state when repository fails',
      setUp: () {
        when(
          () => mockHotelService.getFavoriteHotels(),
        ).thenAnswer((_) async => Success(testHotels));
        when(() => mockHotelService.toggleFavorite(any())).thenAnswer(
          (_) async => const Failure(FavoritesSaveFailedException()),
        );
      },
      build: () => FavoritesCubit(mockHotelService, mockMainStreamService),
      act: (cubit) async {
        await cubit.toggleFavorite(testHotels[0]);
      },
      wait: const Duration(milliseconds: 100),
      expect: () => [],
    );

    blocTest<FavoritesCubit, FavoritesState>(
      'loadFavorites is called when UpdateFavoritesItemsEvent is received',
      setUp: () {
        when(
          () => mockHotelService.getFavoriteHotels(),
        ).thenAnswer((_) async => Success(testHotels));
      },
      build: () => FavoritesCubit(mockHotelService, mockMainStreamService),
      act: (cubit) async {
        streamController.add(UpdateFavoritesItemsEvent());
        await Future.delayed(const Duration(milliseconds: 200));
      },
      wait: const Duration(milliseconds: 100),
      expect: () => [
        const FavoritesState(status: FavoritesStatus.loading),
        FavoritesState(
          status: FavoritesStatus.loaded,
          favorites: testHotels,
          favoriteIds: {'1', '2'},
        ),
      ],
      verify: (_) {
        verify(() => mockHotelService.getFavoriteHotels()).called(1);
      },
    );

    test('close cancels stream subscription', () async {
      when(
        () => mockHotelService.getFavoriteHotels(),
      ).thenAnswer((_) async => Success(testHotels));

      final cubit = FavoritesCubit(mockHotelService, mockMainStreamService);

      await Future.delayed(const Duration(milliseconds: 100));

      expect(() => cubit.close(), returnsNormally);
    });
  });
}
