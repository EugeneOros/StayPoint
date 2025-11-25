import 'package:equatable/equatable.dart';
import 'package:hotel_booking_app/domain/hotels/models/rooms.dart';
import 'package:hotel_booking_app/domain/hotels/models/travel_date.dart';

class BestOffer extends Equatable {
  final int total;
  final int? appliedTravelDiscount;
  final int? includedTravelDiscount;
  final int? originalTravelPrice;
  final int? simplePricePerPerson;
  final int? travelPrice;
  final List<String> availableSpecialGroups;
  final bool flightIncluded;
  final Rooms? rooms;
  final TravelDate? travelDate;

  const BestOffer({
    required this.total,
    this.appliedTravelDiscount,
    this.includedTravelDiscount,
    this.originalTravelPrice,
    this.simplePricePerPerson,
    this.travelPrice,
    required this.availableSpecialGroups,
    required this.flightIncluded,
    this.rooms,
    this.travelDate,
  });

  @override
  List<Object?> get props => [
    total,
    appliedTravelDiscount,
    includedTravelDiscount,
    originalTravelPrice,
    simplePricePerPerson,
    travelPrice,
    availableSpecialGroups,
    flightIncluded,
    rooms,
    travelDate,
  ];
}
