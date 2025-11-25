import 'package:json_annotation/json_annotation.dart';
import 'package:hotel_booking_app/domain/hotels/models/rooms.dart';
import 'package:hotel_booking_app/data/hotels/models/room_overall_dto.dart';
import 'package:hotel_booking_app/data/hotels/models/price_and_occupancy_dto.dart';
import 'package:hotel_booking_app/data/hotels/models/room_group_dto.dart';

part 'rooms_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
final class RoomsDto {
  const RoomsDto({
    required this.overall,
    required this.pricesAndOccupancy,
    required this.roomGroups,
  });

  final RoomOverallDto overall;

  @JsonKey(name: 'prices-and-occupancy')
  final List<PriceAndOccupancyDto> pricesAndOccupancy;

  @JsonKey(name: 'room-groups')
  final List<RoomGroupDto> roomGroups;

  factory RoomsDto.fromJson(Map<String, dynamic> json) =>
      _$RoomsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RoomsDtoToJson(this);
}

extension RoomsDtoExtension on RoomsDto {
  Rooms toDomain() {
    return Rooms(
      overall: overall.toDomain(),
      pricesAndOccupancy:
          pricesAndOccupancy.map((item) => item.toDomain()).toList(),
      roomGroups: roomGroups.map((item) => item.toDomain()).toList(),
    );
  }
}

extension RoomsExtension on Rooms {
  RoomsDto toDto() {
    return RoomsDto(
      overall: overall.toDto(),
      pricesAndOccupancy: pricesAndOccupancy.map((item) => item.toDto()).toList(),
      roomGroups: roomGroups.map((item) => item.toDto()).toList(),
    );
  }
}


