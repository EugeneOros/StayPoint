import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_booking_app/domain/locale/service/locale_service.dart';
import 'package:hotel_booking_app/presentation/pages/account/cubit/locale_cubit.dart';
import 'package:hotel_booking_app/shared/result.dart';
import 'package:hotel_booking_app/shared/exceptions/app_exception.dart';
import 'package:mocktail/mocktail.dart';

class MockLocaleService extends Mock implements LocaleService {}

void main() {
  late MockLocaleService mockLocaleService;

  setUp(() {
    mockLocaleService = MockLocaleService();
  });

  group('LocaleCubit', () {
    test('initial state has default locale "de"', () {
      when(
        () => mockLocaleService.getSavedLocale(),
      ).thenAnswer((_) async => const Success(null));

      final cubit = LocaleCubit(mockLocaleService);

      expect(cubit.state.localeCode, 'de');
    });

    blocTest<LocaleCubit, LocaleState>(
      'loads saved locale on initialization',
      setUp: () {
        when(
          () => mockLocaleService.getSavedLocale(),
        ).thenAnswer((_) async => const Success('de'));
      },
      build: () => LocaleCubit(mockLocaleService),
      wait: const Duration(milliseconds: 200),
      expect: () => [const LocaleState(localeCode: 'de')],
      verify: (_) {
        verify(() => mockLocaleService.getSavedLocale()).called(1);
      },
    );

    blocTest<LocaleCubit, LocaleState>(
      'does not change locale when getSavedLocale returns null',
      setUp: () {
        when(
          () => mockLocaleService.getSavedLocale(),
        ).thenAnswer((_) async => const Success(null));
      },
      build: () => LocaleCubit(mockLocaleService),
      wait: const Duration(milliseconds: 100),
      expect: () => [],
    );

    blocTest<LocaleCubit, LocaleState>(
      'does not change locale when getSavedLocale fails',
      setUp: () {
        when(
          () => mockLocaleService.getSavedLocale(),
        ).thenAnswer((_) async => const Failure(LocaleLoadFailedException()));
      },
      build: () => LocaleCubit(mockLocaleService),
      wait: const Duration(milliseconds: 100),
      expect: () => [],
    );

    blocTest<LocaleCubit, LocaleState>(
      'emits new locale when changeLocale succeeds',
      setUp: () {
        when(
          () => mockLocaleService.getSavedLocale(),
        ).thenAnswer((_) async => const Success(null));
        when(
          () => mockLocaleService.saveLocale(any()),
        ).thenAnswer((_) async => const Success(null));
      },
      build: () => LocaleCubit(mockLocaleService),
      wait: const Duration(milliseconds: 100),
      act: (cubit) => cubit.changeLocale('pl'),
      expect: () => [const LocaleState(localeCode: 'pl')],
      verify: (_) {
        verify(() => mockLocaleService.saveLocale('pl')).called(1);
      },
    );

    blocTest<LocaleCubit, LocaleState>(
      'does not change locale when saveLocale fails',
      setUp: () {
        when(
          () => mockLocaleService.getSavedLocale(),
        ).thenAnswer((_) async => const Success(null));
        when(
          () => mockLocaleService.saveLocale(any()),
        ).thenAnswer((_) async => const Failure(LocaleSaveFailedException()));
      },
      build: () => LocaleCubit(mockLocaleService),
      wait: const Duration(milliseconds: 100),
      act: (cubit) => cubit.changeLocale('de'),
      expect: () => [],
      verify: (_) {
        verify(() => mockLocaleService.saveLocale('de')).called(1);
      },
    );

    blocTest<LocaleCubit, LocaleState>(
      'can change locale multiple times',
      setUp: () {
        when(
          () => mockLocaleService.getSavedLocale(),
        ).thenAnswer((_) async => const Success(null));
        when(
          () => mockLocaleService.saveLocale(any()),
        ).thenAnswer((_) async => const Success(null));
      },
      build: () => LocaleCubit(mockLocaleService),
      wait: const Duration(milliseconds: 100),
      act: (cubit) async {
        await cubit.changeLocale('pl');
        await cubit.changeLocale('de');
        await cubit.changeLocale('en');
      },
      expect: () => [
        const LocaleState(localeCode: 'pl'),
        const LocaleState(localeCode: 'de'),
        const LocaleState(localeCode: 'en'),
      ],
      verify: (_) {
        verify(() => mockLocaleService.saveLocale('pl')).called(1);
        verify(() => mockLocaleService.saveLocale('de')).called(1);
        verify(() => mockLocaleService.saveLocale('en')).called(1);
      },
    );
  });
}
