// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_and_occupancy_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceAndOccupancyDto _$PriceAndOccupancyDtoFromJson(
        Map<String, dynamic> json) =>
    PriceAndOccupancyDto(
      adultCount: (json['adult-count'] as num).toInt(),
      childrenAges: (json['children-ages'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      childrenCount: (json['children-count'] as num).toInt(),
      simplePricePerPerson: (json['simple-price-per-person'] as num).toInt(),
      total: (json['total'] as num).toInt(),
      groupIdentifier: json['group-identifier'] as String,
    );

Map<String, dynamic> _$PriceAndOccupancyDtoToJson(
        PriceAndOccupancyDto instance) =>
    <String, dynamic>{
      'adult-count': instance.adultCount,
      'children-ages': instance.childrenAges,
      'children-count': instance.childrenCount,
      'simple-price-per-person': instance.simplePricePerPerson,
      'total': instance.total,
      'group-identifier': instance.groupIdentifier,
    };
