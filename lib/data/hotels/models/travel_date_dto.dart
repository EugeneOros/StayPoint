import 'package:json_annotation/json_annotation.dart';
import 'package:hotel_booking_app/domain/hotels/models/travel_date.dart';

part 'travel_date_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
final class TravelDateDto {
  const TravelDateDto({
    required this.days,
    required this.departureDate,
    required this.nights,
    required this.returnDate,
  });

  final int days;

  @JsonKey(name: 'departure-date')
  final String departureDate;

  final int nights;

  @JsonKey(name: 'return-date')
  final String returnDate;

  factory TravelDateDto.fromJson(Map<String, dynamic> json) =>
      _$TravelDateDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TravelDateDtoToJson(this);
}

extension TravelDateDtoExtension on TravelDateDto {
  TravelDate toDomain() {
    return TravelDate(
      days: days,
      departureDate: departureDate,
      nights: nights,
      returnDate: returnDate,
    );
  }
}

extension TravelDateExtension on TravelDate {
  TravelDateDto toDto() {
    return TravelDateDto(
      days: days,
      departureDate: departureDate,
      nights: nights,
      returnDate: returnDate,
    );
  }
}


