import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hotel_booking_app/core/assets/assets.dart' as app_assets;
import 'package:hotel_booking_app/l10n/app_localizations.dart';
import 'package:hotel_booking_app/domain/hotels/models/hotel.dart';
import 'package:hotel_booking_app/presentation/widgets/hotel_card/favorite_icon_button.dart';
import 'package:hotel_booking_app/presentation/widgets/hotel_card/info_row.dart';
import 'package:hotel_booking_app/presentation/widgets/hotel_card/star_rating.dart';
import 'package:hotel_booking_app/theme/colors.dart';
import 'package:hotel_booking_app/theme/dimens.dart';
import 'package:hotel_booking_app/theme/text_theme.dart';
import 'package:hotel_booking_app/utils/currency_helpers.dart';

const double _imageHeight = 200;

enum HotelCardType { normal, favorite }

class HotelCard extends StatelessWidget {
  final Hotel hotel;
  final bool isFavorite;
  final HotelCardType type;
  final VoidCallback onToggleFavorite;

  const HotelCard({
    super.key,
    required this.hotel,
    required this.isFavorite,
    required this.onToggleFavorite,
    this.type = HotelCardType.normal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(Dimens.xs),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.10),
            offset: Offset(Dimens.zero, Dimens.s),
            blurRadius: Dimens.l,
            spreadRadius: Dimens.zero,
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            offset: Offset(Dimens.zero, Dimens.zero),
            blurRadius: Dimens.l,
            spreadRadius: Dimens.zero,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(Dimens.xs),
                ),
                child: Image.network(
                  hotel.images.isNotEmpty ? hotel.images.first.large : '',
                  height: _imageHeight,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: _imageHeight,
                      color: AppColors.contentSecondary,
                      child: const Icon(
                        Icons.hotel,
                        size: Dimens.c,
                        color: AppColors.borderSecondary,
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                top: Dimens.xm,
                right: Dimens.m,
                child: FavoriteIconButton(
                  isFavorite: isFavorite,
                  type: type,
                  onTap: onToggleFavorite,
                ),
              ),
              if (type == HotelCardType.favorite)
                Positioned(
                  bottom: Dimens.m,
                  left: Dimens.s,
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimens.xs,
                          vertical: Dimens.xs,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.contentAdditionalD,
                          borderRadius: BorderRadius.circular(Dimens.xs),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              app_assets.Assets.icons.smile,
                              width: Dimens.m,
                              height: Dimens.m,
                            ),
                            SizedBox(width: Dimens.xxs),
                            Text(
                              AppLocalizations.of(context)!.ratingDisplay(
                                (hotel.ratingInfo?.score ?? 0.0)
                                    .toStringAsFixed(1),
                              ),
                              style: AppTextTheme.labelXSmallBold.copyWith(
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: Dimens.s),
                      if (hotel.ratingInfo != null)
                        Text(
                          AppLocalizations.of(
                            context,
                          )!.ratingDescriptionWithReviews(
                            hotel.ratingInfo!.scoreDescription,
                            hotel.ratingInfo!.reviewsCount,
                          ),
                          style: AppTextTheme.labelXSmallBold.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(Dimens.m),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    StarRating(rating: hotel.ratingInfo?.score ?? 0.0),
                    SizedBox(width: Dimens.xs),
                    Tooltip(
                      message: AppLocalizations.of(context)!.ratingTooltip,
                      child: Icon(
                        Icons.help_outline,
                        size: Dimens.m,
                        color: AppColors.contentSecondary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Dimens.xs),
                Text(
                  hotel.name,
                  style: AppTextTheme.labelMediumBold,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: Dimens.xxs),
                Text(hotel.location, style: AppTextTheme.labelSmall),
                SizedBox(height: Dimens.m),
                Divider(color: AppColors.borderSecondary, height: Dimens.xxxs),
                SizedBox(height: Dimens.m),
                if (hotel.bestOffer != null &&
                    type == HotelCardType.normal) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (hotel.bestOffer!.travelDate != null)
                              InfoRow(
                                leftText: AppLocalizations.of(
                                  context,
                                )!.days(hotel.bestOffer!.travelDate!.days),
                                rightText: AppLocalizations.of(
                                  context,
                                )!.nights(hotel.bestOffer!.travelDate!.nights),
                                dividerColor: AppColors.borderPrimary,
                              ),
                            if (hotel.bestOffer!.travelDate != null &&
                                hotel.bestOffer!.rooms != null)
                              SizedBox(height: Dimens.xs),
                            if (hotel.bestOffer!.rooms != null)
                              InfoRow(
                                leftText: hotel.bestOffer!.rooms!.overall.name,
                                rightText:
                                    hotel.bestOffer!.rooms!.overall.boarding,
                              ),
                            if (hotel.bestOffer!.rooms != null &&
                                (hotel.bestOffer!.rooms!.overall.adultCount >
                                        0 ||
                                    hotel.bestOffer!.flightIncluded))
                              SizedBox(height: Dimens.xs),
                            if (hotel.bestOffer!.rooms != null &&
                                (hotel.bestOffer!.rooms!.overall.adultCount >
                                        0 ||
                                    hotel.bestOffer!.flightIncluded))
                              InfoRow(
                                leftText:
                                    hotel.bestOffer!.rooms!.overall.adultCount >
                                        0
                                    ? AppLocalizations.of(
                                        context,
                                      )!.adultsAndChildren(
                                        hotel
                                            .bestOffer!
                                            .rooms!
                                            .overall
                                            .adultCount,
                                        hotel
                                            .bestOffer!
                                            .rooms!
                                            .overall
                                            .childrenCount,
                                      )
                                    : null,
                                rightText: hotel.bestOffer!.flightIncluded
                                    ? AppLocalizations.of(context)!.inclFlight
                                    : null,
                              ),
                          ],
                        ),
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: AppLocalizations.of(context)!.from,
                                  style: AppTextTheme.labelXSmall,
                                ),
                                TextSpan(
                                  text: formatPrice(
                                    hotel.bestOffer!.total,
                                    hotel.currency,
                                  ),
                                  style: AppTextTheme.labelXLargeBold,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: Dimens.xxs),
                          Text(
                            '${formatPrice(hotel.bestOffer!.simplePricePerPerson ?? 0, hotel.currency)} ${AppLocalizations.of(context)!.perPerson}',
                            style: AppTextTheme.labelXSmall.copyWith(
                              color: AppColors.contentSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: Dimens.m),
                ],
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.interactionPrimary,
                      foregroundColor: AppColors.white,
                      padding: EdgeInsets.symmetric(vertical: Dimens.s),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Dimens.xs),
                      ),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.toHotel,
                      style: AppTextTheme.labelSmallBold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
