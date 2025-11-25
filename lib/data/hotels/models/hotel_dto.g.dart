// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotel_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotelDto _$HotelDtoFromJson(Map<String, dynamic> json) => HotelDto(
      id: json['hotel-id'] as String,
      name: json['name'] as String,
      location: json['destination'] as String,
      bestOffer: json['best-offer'] == null
          ? null
          : BestOfferDto.fromJson(json['best-offer'] as Map<String, dynamic>),
      ratingInfo: json['rating-info'] == null
          ? null
          : RatingDto.fromJson(json['rating-info'] as Map<String, dynamic>),
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => HotelImageDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      description: json['description'] as String?,
      analytics: json['analytics'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$HotelDtoToJson(HotelDto instance) => <String, dynamic>{
      'hotel-id': instance.id,
      'name': instance.name,
      'destination': instance.location,
      'best-offer': instance.bestOffer,
      'rating-info': instance.ratingInfo,
      'images': instance.images,
      'description': instance.description,
      'analytics': instance.analytics,
    };
