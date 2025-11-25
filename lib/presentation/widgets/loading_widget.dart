import 'package:flutter/material.dart';
import 'package:hotel_booking_app/theme/colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.backgroundBrand,
      ),
    );
  }
}
