import 'package:flutter/material.dart';
import 'package:hotel_booking_app/theme/colors.dart';
import 'package:hotel_booking_app/theme/dimens.dart';

class StarRating extends StatelessWidget {
  final double rating;

  const StarRating({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...List.generate(5, (index) {
          if (index < rating.floor()) {
            return const Icon(
              Icons.star_rounded,
              size: Dimens.m,
              color: AppColors.black,
            );
          } else if (index < rating.ceil()) {
            return const Icon(
              Icons.star_half_rounded,
              size: Dimens.m,
              color: AppColors.black,
            );
          } else {
            return const Icon(
              Icons.star_border_rounded,
              size: Dimens.m,
              color: AppColors.black,
            );
          }
        }),
      ],
    );
  }
}
