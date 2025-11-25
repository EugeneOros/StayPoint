import 'package:equatable/equatable.dart';

class RoomOverall extends Equatable {
  final String boarding;
  final String name;
  final int adultCount;
  final List<int> childrenAges;
  final int childrenCount;
  final int quantity;
  final bool sameBoarding;
  final bool sameRoomGroups;
  final List<String> attributes;

  const RoomOverall({
    required this.boarding,
    required this.name,
    required this.adultCount,
    required this.childrenAges,
    required this.childrenCount,
    required this.quantity,
    required this.sameBoarding,
    required this.sameRoomGroups,
    required this.attributes,
  });

  @override
  List<Object> get props => [
        boarding,
        name,
        adultCount,
        childrenAges,
        childrenCount,
        quantity,
        sameBoarding,
        sameRoomGroups,
        attributes,
      ];
}
