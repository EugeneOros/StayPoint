import 'dart:async';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking_app/presentation/pages/favorites/cubit/favorites_event.dart';
import 'package:injectable/injectable.dart';
import 'package:hotel_booking_app/domain/hotels/service/hotel_service.dart';
import 'package:hotel_booking_app/domain/main_stream/service/main_stream_service.dart';
import 'package:hotel_booking_app/domain/hotels/models/hotel.dart';
import 'package:hotel_booking_app/data/hotels/service/hotel_event.dart';
import 'package:hotel_booking_app/shared/result.dart';
import 'favorites_state.dart';

@injectable
class FavoritesCubit extends Cubit<FavoritesState>
    with BlocPresentationMixin<FavoritesState, FavoritesEvent> {
  final HotelService hotelService;
  final MainStreamService mainStreamService;
  StreamSubscription? _streamSubscription;

  FavoritesCubit(this.hotelService, this.mainStreamService)
    : super(const FavoritesState()) {
    _listenToStream();
  }

  void _listenToStream() {
    _streamSubscription = mainStreamService.getStream().listen((event) {
      if (event is UpdateFavoritesItemsEvent) {
        loadFavorites();
      }
    });
  }

  Future<void> loadFavorites() async {
    emit(state.copyWith(status: FavoritesStatus.loading));

    final result = await hotelService.getFavoriteHotels();

    switch (result) {
      case Success(value: final favoriteHotels):
        final favoriteSet = favoriteHotels.map((h) => h.id).toSet();
        emit(
          state.copyWith(
            status: FavoritesStatus.loaded,
            favoriteIds: favoriteSet,
            favorites: favoriteHotels,
          ),
        );
        break;
      case Failure(error: final error):
        emit(
          state.copyWith(
            status: FavoritesStatus.error,
            error: error.toString(),
          ),
        );
        break;
    }
  }

  Future<void> toggleFavorite(Hotel hotel) async {
    final result = await hotelService.toggleFavorite(hotel);

    switch (result) {
      case Success():
        break;
      case Failure(error: _):
        emitPresentation(const FavoritesEventToggleError());
        break;
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
