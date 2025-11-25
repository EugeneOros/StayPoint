import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:hotel_booking_app/domain/hotels/models/hotel.dart';
import 'package:hotel_booking_app/domain/hotels/service/hotel_service.dart';
import 'package:hotel_booking_app/domain/main_stream/service/main_stream_service.dart';
import 'package:hotel_booking_app/data/hotels/data_source/hotel_remote_datasource.dart';
import 'package:hotel_booking_app/data/hotels/models/hotel_dto.dart';
import 'package:hotel_booking_app/data/hotels/service/hotel_event.dart';
import 'package:hotel_booking_app/shared/result.dart';
import 'package:hotel_booking_app/shared/exceptions/app_exception.dart';
import 'package:hotel_booking_app/shared/utils/logger.dart';

@LazySingleton(as: HotelService)
final class HotelServiceImpl implements HotelService {
  final HotelRemoteDataSource remoteDataSource;
  final MainStreamService mainStreamService;
  static const String _boxName = 'favorite_hotels';
  Box<String>? _box;

  HotelServiceImpl(this.remoteDataSource, this.mainStreamService);

  Future<Box<String>> get _favoritesBox async {
    _box ??= await Hive.openBox<String>(_boxName);
    return _box!;
  }

  @override
  Future<Result<List<Hotel>, HotelException>> getHotels() async {
    final result = await remoteDataSource.getHotels();
    switch (result) {
      case Success(value: final hotels):
        return Success(hotels.map((hotel) => hotel.toDomain()).toList());
      case Failure(error: final error):
        return Failure(error);
    }
  }

  @override
  Future<Result<List<Hotel>, FavoritesException>> getFavoriteHotels() async {
    try {
      final box = await _favoritesBox;
      final hotels = <Hotel>[];

      for (final value in box.values) {
        try {
          final json = jsonDecode(value) as Map<String, dynamic>;
          final hotelDto = HotelDto.fromJson(json);
          hotels.add(hotelDto.toDomain());
        } catch (e) {
          AppLogger.e('Error parsing hotel from JSON', e);
        }
      }

      return Success(hotels);
    } catch (e) {
      AppLogger.e('Error loading favorite hotels', e);
      return const Failure(FavoritesLoadFailedException());
    }
  }

  @override
  Future<Result<void, FavoritesException>> addFavorite(Hotel hotel) async {
    try {
      final box = await _favoritesBox;
      final hotelDto = hotel.toDto();
      final json = jsonEncode(hotelDto.toJson());
      await box.put(hotel.id, json);
      mainStreamService.add(UpdateFavoritesItemsEvent());
      return const Success(null);
    } catch (e) {
      AppLogger.e('Error saving favorite hotel', e);
      return const Failure(FavoritesSaveFailedException());
    }
  }

  @override
  Future<Result<void, FavoritesException>> removeFavorite(
    String hotelId,
  ) async {
    try {
      final box = await _favoritesBox;
      await box.delete(hotelId);
      mainStreamService.add(UpdateFavoritesItemsEvent());
      return const Success(null);
    } catch (e) {
      AppLogger.e('Error removing favorite hotel', e);
      return const Failure(FavoritesSaveFailedException());
    }
  }

  @override
  Future<Result<void, FavoritesException>> toggleFavorite(Hotel hotel) async {
    final isFavoriteResult = await isFavorite(hotel.id);
    return switch (isFavoriteResult) {
      Success(value: final isFavorite) =>
        isFavorite ? await removeFavorite(hotel.id) : await addFavorite(hotel),
      Failure() => isFavoriteResult,
    };
  }

  @override
  Future<Result<bool, FavoritesException>> isFavorite(String hotelId) async {
    try {
      final box = await _favoritesBox;
      return Success(box.containsKey(hotelId));
    } catch (e) {
      AppLogger.e('Error checking favorite hotel', e);
      return const Failure(FavoritesLoadFailedException());
    }
  }
}
