// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_overall_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomOverallDto _$RoomOverallDtoFromJson(Map<String, dynamic> json) =>
    RoomOverallDto(
      boarding: json['boarding'] as String,
      name: json['name'] as String,
      adultCount: (json['adult-count'] as num).toInt(),
      childrenAges: (json['children-ages'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      childrenCount: (json['children-count'] as num).toInt(),
      quantity: (json['quantity'] as num).toInt(),
      sameBoarding: json['same-boarding'] as bool,
      sameRoomGroups: json['same-room-groups'] as bool,
      attributes: RoomOverallDto._attributesFromJson(json['attributes']),
    );

Map<String, dynamic> _$RoomOverallDtoToJson(RoomOverallDto instance) =>
    <String, dynamic>{
      'boarding': instance.boarding,
      'name': instance.name,
      'adult-count': instance.adultCount,
      'children-ages': instance.childrenAges,
      'children-count': instance.childrenCount,
      'quantity': instance.quantity,
      'same-boarding': instance.sameBoarding,
      'same-room-groups': instance.sameRoomGroups,
      'attributes': instance.attributes,
    };
