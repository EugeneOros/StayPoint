import 'package:hotel_booking_app/domain/main_stream/service/main_stream_service.dart';

sealed class HotelEvent extends MainStreamEvent {}

class UpdateFavoritesItemsEvent extends HotelEvent {
  UpdateFavoritesItemsEvent();
}
