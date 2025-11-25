import 'package:equatable/equatable.dart';

class RoomGroup extends Equatable {
  final String boarding;
  final String name;
  final String groupIdentifier;
  final int quantity;
  final List<String> attributes;
  final String? detailedDescription;

  const RoomGroup({
    required this.boarding,
    required this.name,
    required this.groupIdentifier,
    required this.quantity,
    required this.attributes,
    this.detailedDescription,
  });

  @override
  List<Object?> get props => [
        boarding,
        name,
        groupIdentifier,
        quantity,
        attributes,
        detailedDescription,
      ];
}
