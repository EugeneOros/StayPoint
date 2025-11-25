import 'package:json_annotation/json_annotation.dart';
import 'package:hotel_booking_app/domain/hotels/models/hotel.dart';
import 'package:hotel_booking_app/data/hotels/models/rating_dto.dart';
import 'package:hotel_booking_app/data/hotels/models/best_offer_dto.dart';
import 'package:hotel_booking_app/data/hotels/models/hotel_image_dto.dart';

part 'hotel_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
final class HotelDto {
  const HotelDto({
    required this.id,
    required this.name,
    required this.location,
    this.bestOffer,
    this.ratingInfo,
    this.images,
    this.description,
    this.analytics,
  });

  @JsonKey(name: 'hotel-id')
  final String id;

  final String name;

  @JsonKey(name: 'destination')
  final String location;

  @JsonKey(name: 'best-offer')
  final BestOfferDto? bestOffer;

  @JsonKey(name: 'rating-info')
  final RatingDto? ratingInfo;

  final List<HotelImageDto>? images;

  final String? description;

  final Map<String, dynamic>? analytics;

  factory HotelDto.fromJson(Map<String, dynamic> json) =>
      _$HotelDtoFromJson(json);

  Map<String, dynamic> toJson() => _$HotelDtoToJson(this);
}

extension HotelDtoExtension on HotelDto {
  Hotel toDomain() {
    String? currency;
    if (analytics != null) {
      final selectItem =
          analytics!['select_item.item.0'] as Map<String, dynamic>?;
      currency = selectItem?['currency'] as String?;
    }

    return Hotel(
      id: id,
      name: name,
      location: location,
      bestOffer: bestOffer?.toDomain(),
      ratingInfo: ratingInfo?.toDomain(),
      images: images?.map((image) => image.toDomain()).toList() ?? [],
      description: description ?? '',
      currency: currency,
    );
  }
}

extension HotelExtension on Hotel {
  HotelDto toDto() {
    return HotelDto(
      id: id,
      name: name,
      location: location,
      bestOffer: bestOffer?.toDto(),
      ratingInfo: ratingInfo?.toDto(),
      images: images.map((image) => image.toDto()).toList(),
      description: description,
    );
  }
}
