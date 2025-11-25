import 'package:equatable/equatable.dart';

class HotelImage extends Equatable {
  final String large;
  final String small;

  const HotelImage({required this.large, required this.small});

  @override
  List<Object> get props => [large, small];
}
