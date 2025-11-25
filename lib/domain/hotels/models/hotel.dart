import 'package:equatable/equatable.dart';
import 'package:hotel_booking_app/domain/hotels/models/rating.dart';
import 'package:hotel_booking_app/domain/hotels/models/best_offer.dart';
import 'package:hotel_booking_app/domain/hotels/models/hotel_image.dart';

class Hotel extends Equatable {
  final String id;
  final String name;
  final String location;
  final BestOffer? bestOffer;
  final Rating? ratingInfo;
  final List<HotelImage> images;
  final String description;
  final String? currency;

  const Hotel({
    required this.id,
    required this.name,
    required this.location,
    this.bestOffer,
    this.ratingInfo,
    required this.images,
    required this.description,
    this.currency,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    location,
    bestOffer,
    ratingInfo,
    images,
    description,
    currency,
  ];
}
