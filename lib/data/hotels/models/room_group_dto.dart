import 'package:json_annotation/json_annotation.dart';
import 'package:hotel_booking_app/domain/hotels/models/room_group.dart';

part 'room_group_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
final class RoomGroupDto {
  const RoomGroupDto({
    required this.boarding,
    required this.name,
    required this.groupIdentifier,
    required this.quantity,
    this.attributes,
    this.detailedDescription,
  });

  final String boarding;
  final String name;

  @JsonKey(name: 'group-identifier')
  final String groupIdentifier;

  final int quantity;

  @JsonKey(name: 'attributes', fromJson: _attributesFromJson)
  final List<String>? attributes;

  @JsonKey(name: 'detailed-description')
  final String? detailedDescription;

  factory RoomGroupDto.fromJson(Map<String, dynamic> json) =>
      _$RoomGroupDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RoomGroupDtoToJson(this);

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

extension RoomGroupDtoExtension on RoomGroupDto {
  RoomGroup toDomain() {
    return RoomGroup(
      boarding: boarding,
      name: name,
      groupIdentifier: groupIdentifier,
      quantity: quantity,
      attributes: attributes ?? [],
      detailedDescription: detailedDescription,
    );
  }
}

extension RoomGroupExtension on RoomGroup {
  RoomGroupDto toDto() {
    return RoomGroupDto(
      boarding: boarding,
      name: name,
      groupIdentifier: groupIdentifier,
      quantity: quantity,
      attributes: attributes,
      detailedDescription: detailedDescription,
    );
  }
}


