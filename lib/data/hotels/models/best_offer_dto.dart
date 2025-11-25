import 'package:json_annotation/json_annotation.dart';
import 'package:hotel_booking_app/domain/hotels/models/best_offer.dart';
import 'package:hotel_booking_app/data/hotels/models/rooms_dto.dart';
import 'package:hotel_booking_app/data/hotels/models/travel_date_dto.dart';

part 'best_offer_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
final class BestOfferDto {
  const BestOfferDto({
    required this.total,
    this.appliedTravelDiscount,
    this.includedTravelDiscount,
    this.originalTravelPrice,
    this.simplePricePerPerson,
    this.travelPrice,
    this.availableSpecialGroups,
    this.flightIncluded,
    this.rooms,
    this.travelDate,
  });

  final int total;

  @JsonKey(name: 'applied-travel-discount')
  final int? appliedTravelDiscount;

  @JsonKey(name: 'included-travel-discount')
  final int? includedTravelDiscount;

  @JsonKey(name: 'original-travel-price')
  final int? originalTravelPrice;

  @JsonKey(name: 'simple-price-per-person')
  final int? simplePricePerPerson;

  @JsonKey(name: 'travel-price')
  final int? travelPrice;

  @JsonKey(name: 'available-special-groups')
  final List<String>? availableSpecialGroups;

  @JsonKey(name: 'flight-included')
  final bool? flightIncluded;

  final RoomsDto? rooms;

  @JsonKey(name: 'travel-date')
  final TravelDateDto? travelDate;

  factory BestOfferDto.fromJson(Map<String, dynamic> json) =>
      _$BestOfferDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BestOfferDtoToJson(this);
}

extension BestOfferDtoExtension on BestOfferDto {
  BestOffer toDomain() {
    return BestOffer(
      total: total,
      appliedTravelDiscount: appliedTravelDiscount,
      includedTravelDiscount: includedTravelDiscount,
      originalTravelPrice: originalTravelPrice,
      simplePricePerPerson: simplePricePerPerson,
      travelPrice: travelPrice,
      availableSpecialGroups: availableSpecialGroups ?? [],
      flightIncluded: flightIncluded ?? false,
      rooms: rooms?.toDomain(),
      travelDate: travelDate?.toDomain(),
    );
  }
}

extension BestOfferExtension on BestOffer {
  BestOfferDto toDto() {
    return BestOfferDto(
      total: total,
      appliedTravelDiscount: appliedTravelDiscount,
      includedTravelDiscount: includedTravelDiscount,
      originalTravelPrice: originalTravelPrice,
      simplePricePerPerson: simplePricePerPerson,
      travelPrice: travelPrice,
      availableSpecialGroups: availableSpecialGroups,
      flightIncluded: flightIncluded,
      rooms: rooms?.toDto(),
      travelDate: travelDate?.toDto(),
    );
  }
}
