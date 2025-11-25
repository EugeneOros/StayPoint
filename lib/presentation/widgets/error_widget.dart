import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:hotel_booking_app/core/assets/assets.dart';
import 'package:hotel_booking_app/l10n/app_localizations.dart';
import 'package:hotel_booking_app/presentation/widgets/empty_page_widget.dart';
import 'package:hotel_booking_app/theme/colors.dart';
import 'package:hotel_booking_app/theme/dimens.dart';
import 'package:hotel_booking_app/theme/text_theme.dart';

class ErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const ErrorWidget({super.key, required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: EmptyPageWidget(
            imagePath: Assets.icons.error,
            title: AppLocalizations.of(context)!.errorTitle,
            subtitle: message,
          ),
        ),
        if (onRetry != null) ...[
          Padding(
            padding: EdgeInsets.all(Dimens.xl),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.backgroundBrand,
                  padding: EdgeInsets.symmetric(vertical: Dimens.m),
                ),
                child: Text(
                  AppLocalizations.of(context)!.retry,
                  style: AppTextTheme.labelSmallBold,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
