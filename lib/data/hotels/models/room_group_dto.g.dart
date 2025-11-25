// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_group_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomGroupDto _$RoomGroupDtoFromJson(Map<String, dynamic> json) => RoomGroupDto(
      boarding: json['boarding'] as String,
      name: json['name'] as String,
      groupIdentifier: json['group-identifier'] as String,
      quantity: (json['quantity'] as num).toInt(),
      attributes: RoomGroupDto._attributesFromJson(json['attributes']),
      detailedDescription: json['detailed-description'] as String?,
    );

Map<String, dynamic> _$RoomGroupDtoToJson(RoomGroupDto instance) =>
    <String, dynamic>{
      'boarding': instance.boarding,
      'name': instance.name,
      'group-identifier': instance.groupIdentifier,
      'quantity': instance.quantity,
      'attributes': instance.attributes,
      'detailed-description': instance.detailedDescription,
    };
