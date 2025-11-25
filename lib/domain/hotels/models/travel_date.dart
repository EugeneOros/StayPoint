import 'package:equatable/equatable.dart';

class TravelDate extends Equatable {
  final int days;
  final String departureDate;
  final int nights;
  final String returnDate;

  const TravelDate({
    required this.days,
    required this.departureDate,
    required this.nights,
    required this.returnDate,
  });

  @override
  List<Object> get props => [days, departureDate, nights, returnDate];
}
