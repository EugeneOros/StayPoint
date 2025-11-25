import 'dart:async';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking_app/domain/hotels/models/hotel.dart';
import 'package:hotel_booking_app/presentation/pages/hotels/cubit/hotels_event.dart';
import 'package:injectable/injectable.dart';
import 'package:hotel_booking_app/domain/hotels/service/hotel_service.dart';
import 'package:hotel_booking_app/domain/main_stream/service/main_stream_service.dart';
import 'package:hotel_booking_app/data/hotels/service/hotel_event.dart';
import 'package:hotel_booking_app/shared/result.dart';
import 'hotels_state.dart';

@injectable
class HotelsCubit extends Cubit<HotelsState>
    with BlocPresentationMixin<HotelsState, HotelsEvent> {
  final HotelService hotelRepository;
  final MainStreamService mainStreamService;
  StreamSubscription? _streamSubscription;

  HotelsCubit(this.hotelRepository, this.mainStreamService)
    : super(const HotelsState()) {
    _listenToStream();
  }

  void _listenToStream() {
    _streamSubscription = mainStreamService.getStream().listen((event) {
      if (event is UpdateFavoritesItemsEvent) {
        _loadFavoriteIds();
      }
    });
  }

  Future<void> _loadFavoriteIds() async {
    final result = await hotelRepository.getFavoriteHotels();

    switch (result) {
      case Success(value: final favoriteHotels):
        final favoriteSet = favoriteHotels.map((h) => h.id).toSet();
        emit(state.copyWith(favoriteIds: favoriteSet));
        break;
      case Failure():
        break;
    }
  }

  Future<void> loadHotels() async {
    emit(state.copyWith(status: HotelsStatus.loading));

    final result = await hotelRepository.getHotels();

    switch (result) {
      case Success(value: final hotels):
        await _loadFavoriteIds();
        emit(state.copyWith(status: HotelsStatus.loaded, hotels: hotels));
        break;
      case Failure(error: _):
        emit(state.copyWith(status: HotelsStatus.error));
        break;
    }
  }

  Future<void> toggleFavorite(Hotel hotel) async {
    final result = await hotelRepository.toggleFavorite(hotel);
    switch (result) {
      case Success():
        await _loadFavoriteIds();
        break;
      case Failure(error: _):
        emitPresentation(const HotelsEventToggleFavoriteError());
        break;
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
