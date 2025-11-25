import 'package:json_annotation/json_annotation.dart';
import 'package:hotel_booking_app/domain/hotels/models/price_and_occupancy.dart';

part 'price_and_occupancy_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
final class PriceAndOccupancyDto {
  const PriceAndOccupancyDto({
    required this.adultCount,
    required this.childrenAges,
    required this.childrenCount,
    required this.simplePricePerPerson,
    required this.total,
    required this.groupIdentifier,
  });

  @JsonKey(name: 'adult-count')
  final int adultCount;

  @JsonKey(name: 'children-ages')
  final List<int> childrenAges;

  @JsonKey(name: 'children-count')
  final int childrenCount;

  @JsonKey(name: 'simple-price-per-person')
  final int simplePricePerPerson;

  final int total;

  @JsonKey(name: 'group-identifier')
  final String groupIdentifier;

  factory PriceAndOccupancyDto.fromJson(Map<String, dynamic> json) =>
      _$PriceAndOccupancyDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PriceAndOccupancyDtoToJson(this);
}

extension PriceAndOccupancyDtoExtension on PriceAndOccupancyDto {
  PriceAndOccupancy toDomain() {
    return PriceAndOccupancy(
      adultCount: adultCount,
      childrenAges: childrenAges,
      childrenCount: childrenCount,
      simplePricePerPerson: simplePricePerPerson,
      total: total,
      groupIdentifier: groupIdentifier,
    );
  }
}

extension PriceAndOccupancyExtension on PriceAndOccupancy {
  PriceAndOccupancyDto toDto() {
    return PriceAndOccupancyDto(
      adultCount: adultCount,
      childrenAges: childrenAges,
      childrenCount: childrenCount,
      simplePricePerPerson: simplePricePerPerson,
      total: total,
      groupIdentifier: groupIdentifier,
    );
  }
}


