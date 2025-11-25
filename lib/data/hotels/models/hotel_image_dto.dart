import 'package:json_annotation/json_annotation.dart';
import 'package:hotel_booking_app/domain/hotels/models/hotel_image.dart';

part 'hotel_image_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
final class HotelImageDto {
  const HotelImageDto({required this.large, required this.small});

  final String large;
  final String small;

  factory HotelImageDto.fromJson(Map<String, dynamic> json) =>
      _$HotelImageDtoFromJson(json);

  Map<String, dynamic> toJson() => _$HotelImageDtoToJson(this);
}

extension HotelImageDtoExtension on HotelImageDto {
  HotelImage toDomain() {
    return HotelImage(large: large, small: small);
  }
}

extension HotelImageExtension on HotelImage {
  HotelImageDto toDto() {
    return HotelImageDto(large: large, small: small);
  }
}
