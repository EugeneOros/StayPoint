import 'package:equatable/equatable.dart';

class PriceAndOccupancy extends Equatable {
  final int adultCount;
  final List<int> childrenAges;
  final int childrenCount;
  final int simplePricePerPerson;
  final int total;
  final String groupIdentifier;

  const PriceAndOccupancy({
    required this.adultCount,
    required this.childrenAges,
    required this.childrenCount,
    required this.simplePricePerPerson,
    required this.total,
    required this.groupIdentifier,
  });

  @override
  List<Object> get props => [
        adultCount,
        childrenAges,
        childrenCount,
        simplePricePerPerson,
        total,
        groupIdentifier,
      ];
}
