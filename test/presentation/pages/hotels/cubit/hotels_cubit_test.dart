import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_booking_app/domain/hotels/models/hotel.dart';
import 'package:hotel_booking_app/domain/hotels/service/hotel_service.dart';
import 'package:hotel_booking_app/domain/main_stream/service/main_stream_service.dart';
import 'package:hotel_booking_app/presentation/pages/hotels/cubit/hotels_cubit.dart';
import 'package:hotel_booking_app/presentation/pages/hotels/cubit/hotels_state.dart';
import 'package:hotel_booking_app/shared/result.dart';
import 'package:hotel_booking_app/shared/exceptions/app_exception.dart';
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

  group('HotelsCubit', () {
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

    test('initial state is HotelsState.initial', () {
      final cubit = HotelsCubit(mockHotelService, mockStreamService);

      expect(cubit.state.status, HotelsStatus.loading);
      expect(cubit.state.hotels, isEmpty);
      expect(cubit.state.favoriteIds, isEmpty);
      expect(cubit.state.error, isNull);
    });

    blocTest<HotelsCubit, HotelsState>(
      'emits [loading, success] when loadHotels succeeds',
      setUp: () {
        when(
          () => mockHotelService.getHotels(),
        ).thenAnswer((_) async => Success(testHotels));
      },
      build: () => HotelsCubit(mockHotelService, mockStreamService),
      act: (cubit) => cubit.loadHotels(),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        const HotelsState(status: HotelsStatus.loading),
        HotelsState(
          status: HotelsStatus.loaded,
          hotels: testHotels,
          favoriteIds: {},
        ),
      ],
      verify: (_) {
        verify(() => mockHotelService.getHotels()).called(1);
        verify(() => mockHotelService.getFavoriteHotels()).called(1);
      },
    );

    blocTest<HotelsCubit, HotelsState>(
      'emits [loading, error] when loadHotels fails',
      setUp: () {
        when(
          () => mockHotelService.getHotels(),
        ).thenAnswer((_) async => const Failure(HotelFetchFailedException()));
      },
      build: () => HotelsCubit(mockHotelService, mockStreamService),
      act: (cubit) => cubit.loadHotels(),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        const HotelsState(status: HotelsStatus.loading),
        HotelsState(
          status: HotelsStatus.error,
        ),
      ],
      verify: (_) {
        verify(() => mockHotelService.getHotels()).called(1);
      },
    );

    blocTest<HotelsCubit, HotelsState>(
      'loadHotels can be called multiple times',
      setUp: () {
        when(
          () => mockHotelService.getHotels(),
        ).thenAnswer((_) async => Success(testHotels));
      },
      build: () => HotelsCubit(mockHotelService, mockStreamService),
      act: (cubit) async {
        cubit.loadHotels();
        await Future.delayed(const Duration(milliseconds: 100));
        cubit.loadHotels();
      },
      wait: const Duration(milliseconds: 200),
      expect: () => [
        const HotelsState(status: HotelsStatus.loading),
        HotelsState(
          status: HotelsStatus.loaded,
          hotels: testHotels,
          favoriteIds: {},
        ),
        HotelsState(
          status: HotelsStatus.loading,
          hotels: testHotels,
          favoriteIds: {},
        ),
        HotelsState(
          status: HotelsStatus.loaded,
          hotels: testHotels,
          favoriteIds: {},
        ),
      ],
      verify: (_) {
        verify(() => mockHotelService.getHotels()).called(2);
        verify(() => mockHotelService.getFavoriteHotels()).called(2);
      },
    );
  });
}
