import 'package:equatable/equatable.dart';
import 'package:hotel_booking_app/domain/hotels/models/room_overall.dart';
import 'package:hotel_booking_app/domain/hotels/models/price_and_occupancy.dart';
import 'package:hotel_booking_app/domain/hotels/models/room_group.dart';

class Rooms extends Equatable {
  final RoomOverall overall;
  final List<PriceAndOccupancy> pricesAndOccupancy;
  final List<RoomGroup> roomGroups;

  const Rooms({
    required this.overall,
    required this.pricesAndOccupancy,
    required this.roomGroups,
  });

  @override
  List<Object> get props => [overall, pricesAndOccupancy, roomGroups];
}
