import 'package:flutter/material.dart';
import 'package:hotel_booking_app/domain/hotels/models/hotel.dart';
import 'package:hotel_booking_app/l10n/app_localizations.dart';
import 'package:hotel_booking_app/presentation/widgets/hotel_card/hotel_card.dart';
import 'package:hotel_booking_app/theme/dimens.dart';
import 'package:hotel_booking_app/theme/text_theme.dart';

class HotelsLoadedBody extends StatelessWidget {
  final List<Hotel> hotels;
  final Set<String> favoriteIds;
  final Function(Hotel) onToggleFavorite;
  const HotelsLoadedBody({
    super.key,
    required this.hotels,
    required this.favoriteIds,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return hotels.isEmpty
        ? Center(
            child: Text(
              AppLocalizations.of(context)!.noHotels,
              style: AppTextTheme.labelXSmall,
            ),
          )
        : ListView.builder(
            padding: EdgeInsets.all(Dimens.m),
            itemCount: hotels.length,
            itemBuilder: (context, index) {
              final hotel = hotels[index];
              return Padding(
                padding: EdgeInsets.only(bottom: Dimens.m),
                child: HotelCard(
                  hotel: hotel,
                  isFavorite: favoriteIds.contains(hotel.id),
                  onToggleFavorite: () => onToggleFavorite(hotel),
                ),
              );
            },
          );
  }
}
