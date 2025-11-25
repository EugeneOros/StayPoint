// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rooms_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomsDto _$RoomsDtoFromJson(Map<String, dynamic> json) => RoomsDto(
      overall: RoomOverallDto.fromJson(json['overall'] as Map<String, dynamic>),
      pricesAndOccupancy: (json['prices-and-occupancy'] as List<dynamic>)
          .map((e) => PriceAndOccupancyDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      roomGroups: (json['room-groups'] as List<dynamic>)
          .map((e) => RoomGroupDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RoomsDtoToJson(RoomsDto instance) => <String, dynamic>{
      'overall': instance.overall,
      'prices-and-occupancy': instance.pricesAndOccupancy,
      'room-groups': instance.roomGroups,
    };
