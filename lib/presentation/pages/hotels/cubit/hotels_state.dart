import 'package:equatable/equatable.dart';
import 'package:hotel_booking_app/domain/hotels/models/hotel.dart';

enum HotelsStatus { loading, loaded, error }

class HotelsState extends Equatable {
  final HotelsStatus status;
  final List<Hotel> hotels;
  final Set<String> favoriteIds;
  final String? error;

  const HotelsState({
    this.status = HotelsStatus.loading,
    this.hotels = const [],
    this.favoriteIds = const {},
    this.error,
  });

  HotelsState copyWith({
    HotelsStatus? status,
    List<Hotel>? hotels,
    Set<String>? favoriteIds,
    String? error,
  }) {
    return HotelsState(
      status: status ?? this.status,
      hotels: hotels ?? this.hotels,
      favoriteIds: favoriteIds ?? this.favoriteIds,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, hotels, favoriteIds, error];
}
