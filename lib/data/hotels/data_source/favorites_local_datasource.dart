import 'package:hive_flutter/hive_flutter.dart';
import 'package:hotel_booking_app/shared/result.dart';
import 'package:hotel_booking_app/shared/exceptions/app_exception.dart';
import 'package:hotel_booking_app/shared/utils/logger.dart';

abstract interface class FavoritesLocalDataSource {
  Future<Result<List<String>, FavoritesException>> getFavoriteIds();
  Future<Result<void, FavoritesException>> addFavorite(String hotelId);
  Future<Result<void, FavoritesException>> removeFavorite(String hotelId);
  Future<Result<bool, FavoritesException>> isFavorite(String hotelId);
}

final class FavoritesLocalDataSourceImpl implements FavoritesLocalDataSource {
  static const String _boxName = 'favorites';
  Box<String>? _box;

  Future<Box<String>> get _favoritesBox async {
    _box ??= await Hive.openBox<String>(_boxName);
    return _box!;
  }

  @override
  Future<Result<List<String>, FavoritesException>> getFavoriteIds() async {
    try {
      final box = await _favoritesBox;
      return Success(box.values.toList());
    } catch (e) {
      AppLogger.e('Error loading favorites', e);
      return const Failure(FavoritesLoadFailedException());
    }
  }

  @override
  Future<Result<void, FavoritesException>> addFavorite(String hotelId) async {
    try {
      final box = await _favoritesBox;
      await box.put(hotelId, hotelId);
      return const Success(null);
    } catch (e) {
      AppLogger.e('Error saving favorite', e);
      return const Failure(FavoritesSaveFailedException());
    }
  }

  @override
  Future<Result<void, FavoritesException>> removeFavorite(
      String hotelId) async {
    try {
      final box = await _favoritesBox;
      await box.delete(hotelId);
      return const Success(null);
    } catch (e) {
      AppLogger.e('Error removing favorite', e);
      return const Failure(FavoritesSaveFailedException());
    }
  }

  @override
  Future<Result<bool, FavoritesException>> isFavorite(String hotelId) async {
    try {
      final box = await _favoritesBox;
      return Success(box.containsKey(hotelId));
    } catch (e) {
      AppLogger.e('Error checking favorite', e);
      return const Failure(FavoritesLoadFailedException());
    }
  }
}

