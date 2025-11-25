import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:hotel_booking_app/domain/locale/service/locale_service.dart';
import 'package:hotel_booking_app/shared/result.dart';

@lazySingleton
class LocaleCubit extends Cubit<LocaleState> {
  final LocaleService _localeRepository;

  LocaleCubit(this._localeRepository)
    : super(const LocaleState(localeCode: 'de')) {
    _loadSavedLocale();
  }

  Future<void> _loadSavedLocale() async {
    final result = await _localeRepository.getSavedLocale();
    switch (result) {
      case Success(value: final locale):
        if (locale != null) {
          emit(LocaleState(localeCode: locale));
        }
        break;
      case Failure():
        break;
    }
  }

  Future<void> changeLocale(String localeCode) async {
    final result = await _localeRepository.saveLocale(localeCode);
    switch (result) {
      case Success():
        emit(LocaleState(localeCode: localeCode));
        break;
      case Failure():
        break;
    }
  }
}

class LocaleState extends Equatable {
  final String localeCode;

  const LocaleState({required this.localeCode});

  @override
  List<Object?> get props => [localeCode];
}
