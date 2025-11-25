// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'best_offer_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BestOfferDto _$BestOfferDtoFromJson(Map<String, dynamic> json) => BestOfferDto(
      total: (json['total'] as num).toInt(),
      appliedTravelDiscount: (json['applied-travel-discount'] as num?)?.toInt(),
      includedTravelDiscount:
          (json['included-travel-discount'] as num?)?.toInt(),
      originalTravelPrice: (json['original-travel-price'] as num?)?.toInt(),
      simplePricePerPerson: (json['simple-price-per-person'] as num?)?.toInt(),
      travelPrice: (json['travel-price'] as num?)?.toInt(),
      availableSpecialGroups:
          (json['available-special-groups'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      flightIncluded: json['flight-included'] as bool?,
      rooms: json['rooms'] == null
          ? null
          : RoomsDto.fromJson(json['rooms'] as Map<String, dynamic>),
      travelDate: json['travel-date'] == null
          ? null
          : TravelDateDto.fromJson(json['travel-date'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BestOfferDtoToJson(BestOfferDto instance) =>
    <String, dynamic>{
      'total': instance.total,
      'applied-travel-discount': instance.appliedTravelDiscount,
      'included-travel-discount': instance.includedTravelDiscount,
      'original-travel-price': instance.originalTravelPrice,
      'simple-price-per-person': instance.simplePricePerPerson,
      'travel-price': instance.travelPrice,
      'available-special-groups': instance.availableSpecialGroups,
      'flight-included': instance.flightIncluded,
      'rooms': instance.rooms,
      'travel-date': instance.travelDate,
    };
