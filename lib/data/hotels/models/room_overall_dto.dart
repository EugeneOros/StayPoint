import 'package:json_annotation/json_annotation.dart';
import 'package:hotel_booking_app/domain/hotels/models/room_overall.dart';

part 'room_overall_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
final class RoomOverallDto {
  const RoomOverallDto({
    required this.boarding,
    required this.name,
    required this.adultCount,
    required this.childrenAges,
    required this.childrenCount,
    required this.quantity,
    required this.sameBoarding,
    required this.sameRoomGroups,
    this.attributes,
  });

  final String boarding;
  final String name;

  @JsonKey(name: 'adult-count')
  final int adultCount;

  @JsonKey(name: 'children-ages')
  final List<int> childrenAges;

  @JsonKey(name: 'children-count')
  final int childrenCount;

  final int quantity;

  @JsonKey(name: 'same-boarding')
  final bool sameBoarding;

  @JsonKey(name: 'same-room-groups')
  final bool sameRoomGroups;

  @JsonKey(name: 'attributes', fromJson: _attributesFromJson)
  final List<String>? attributes;

  factory RoomOverallDto.fromJson(Map<String, dynamic> json) =>
      _$RoomOverallDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RoomOverallDtoToJson(this);

  static List<String>? _attributesFromJson(dynamic json) {
    if (json == null) return null;
    if (json is! List) return null;
    
    final List<String> result = [];
    for (final item in json) {
      if (item is String) {
        result.add(item);
      } else if (item is Map) {
        // Skip objects in attributes array
        continue;
      }
    }
    return result.isEmpty ? null : result;
  }
}

extension RoomOverallDtoExtension on RoomOverallDto {
  RoomOverall toDomain() {
    return RoomOverall(
      boarding: boarding,
      name: name,
      adultCount: adultCount,
      childrenAges: childrenAges,
      childrenCount: childrenCount,
      quantity: quantity,
      sameBoarding: sameBoarding,
      sameRoomGroups: sameRoomGroups,
      attributes: attributes ?? [],
    );
  }
}

extension RoomOverallExtension on RoomOverall {
  RoomOverallDto toDto() {
    return RoomOverallDto(
      boarding: boarding,
      name: name,
      adultCount: adultCount,
      childrenAges: childrenAges,
      childrenCount: childrenCount,
      quantity: quantity,
      sameBoarding: sameBoarding,
      sameRoomGroups: sameRoomGroups,
      attributes: attributes,
    );
  }
}


