import '../models/hotel.dart';
import '../../../shared/result.dart';
import '../../../shared/exceptions/app_exception.dart';

abstract interface class HotelService {
  Future<Result<List<Hotel>, HotelException>> getHotels();
  Future<Result<List<Hotel>, FavoritesException>> getFavoriteHotels();
  Future<Result<void, FavoritesException>> addFavorite(Hotel hotel);
  Future<Result<void, FavoritesException>> removeFavorite(String hotelId);
  Future<Result<void, FavoritesException>> toggleFavorite(Hotel hotel);
  Future<Result<bool, FavoritesException>> isFavorite(String hotelId);
}
