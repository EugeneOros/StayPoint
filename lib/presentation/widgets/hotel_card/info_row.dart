import 'package:flutter/material.dart';
import 'package:hotel_booking_app/theme/colors.dart';
import 'package:hotel_booking_app/theme/dimens.dart';
import 'package:hotel_booking_app/theme/text_theme.dart';

class InfoRow extends StatelessWidget {
  final String? leftText;
  final String? rightText;
  final Color dividerColor;

  const InfoRow({
    super.key,
    this.leftText,
    this.rightText,
    this.dividerColor = AppColors.borderSecondary,
  });

  @override
  Widget build(BuildContext context) {
    final hasLeft = leftText != null && leftText!.isNotEmpty;
    final hasRight = rightText != null && rightText!.isNotEmpty;

    if (!hasLeft && !hasRight) {
      return const SizedBox.shrink();
    }

    return IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (hasLeft)
            Flexible(
              child: Text(
                leftText!,
                style: AppTextTheme.labelXSmall.copyWith(
                  color: AppColors.contentSecondary,
                ),
              ),
            ),
          if (hasLeft && hasRight)
            Container(
              width: Dimens.xxxs,
              height: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: Dimens.s),
              color: dividerColor,
            ),
          if (hasRight)
            Expanded(
              child: Text(
                rightText!,
                style: AppTextTheme.labelXSmall.copyWith(
                  color: AppColors.contentSecondary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
