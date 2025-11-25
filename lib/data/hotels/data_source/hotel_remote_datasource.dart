import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:hotel_booking_app/data/hotels/models/hotel_dto.dart';
import 'package:hotel_booking_app/shared/result.dart';
import 'package:hotel_booking_app/shared/exceptions/app_exception.dart';
import 'package:hotel_booking_app/shared/utils/logger.dart';

abstract interface class HotelRemoteDataSource {
  Future<Result<List<HotelDto>, HotelException>> getHotels();
}

@LazySingleton(as: HotelRemoteDataSource)
final class HotelRemoteDataSourceImpl implements HotelRemoteDataSource {
  final http.Client client;
  static const String baseUrl =
      'https://d3ttsq6u5udup6.cloudfront.net/hotels.json';

  HotelRemoteDataSourceImpl(this.client);

  @override
  Future<Result<List<HotelDto>, HotelException>> getHotels() async {
    try {
      final response = await client.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);

        List<dynamic> jsonList;

        if (decoded is Map<String, dynamic>) {
          final hotelsData = decoded['hotels'];
          if (hotelsData is! List) {
            AppLogger.e('Expected List but got: ${hotelsData.runtimeType}');
            return const Failure(HotelFetchFailedException());
          }
          jsonList = hotelsData;
        } else if (decoded is List) {
          jsonList = decoded;
        } else {
          AppLogger.e('Unexpected response type: ${decoded.runtimeType}');
          return const Failure(HotelFetchFailedException());
        }

        final hotels = jsonList
            .map((jsonItem) {
              if (jsonItem is! Map<String, dynamic>) {
                AppLogger.e('Hotel item is not a Map: ${jsonItem.runtimeType}');
                return null;
              }
              return HotelDto.fromJson(jsonItem);
            })
            .whereType<HotelDto>()
            .toList();
        return Success(hotels);
      } else {
        AppLogger.e('Failed to fetch hotels: ${response.statusCode}');
        return const Failure(HotelFetchFailedException());
      }
    } catch (e, stackTrace) {
      AppLogger.e('Error fetching hotels', e);
      AppLogger.e('Stack trace', stackTrace);
      return const Failure(HotelFetchFailedException());
    }
  }
}
