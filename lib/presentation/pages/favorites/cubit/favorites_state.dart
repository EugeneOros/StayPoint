import 'package:equatable/equatable.dart';
import 'package:hotel_booking_app/domain/hotels/models/hotel.dart';

enum FavoritesStatus {  loading, loaded, error }

class FavoritesState extends Equatable {
  final FavoritesStatus status;
  final List<Hotel> favorites;
  final Set<String> favoriteIds;
  final String? error;

  const FavoritesState({
    this.status = FavoritesStatus.loading,
    this.favorites = const [],
    this.favoriteIds = const {},
    this.error,
  });

  FavoritesState copyWith({
    FavoritesStatus? status,
    List<Hotel>? favorites,
    Set<String>? favoriteIds,
    String? error,
  }) {
    return FavoritesState(
      status: status ?? this.status,
      favorites: favorites ?? this.favorites,
      favoriteIds: favoriteIds ?? this.favoriteIds,
      error: error ?? this.error,
    );
  }

  bool isFavorite(String hotelId) => favoriteIds.contains(hotelId);

  @override
  List<Object?> get props => [status, favorites, favoriteIds, error];
}
