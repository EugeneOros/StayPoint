import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking_app/core/assets/assets.dart';
import 'package:hotel_booking_app/l10n/app_localizations.dart';
import 'package:hotel_booking_app/presentation/widgets/empty_page_widget.dart';
import 'package:hotel_booking_app/theme/colors.dart';
import 'package:hotel_booking_app/theme/text_theme.dart';

@RoutePage()
class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.overview,
          style: AppTextTheme.headlineSmall.copyWith(color: AppColors.white),
        ),
        backgroundColor: AppColors.backgroundBrand,
        foregroundColor: AppColors.white,
      ),
      body: EmptyPageWidget(
        imagePath: Assets.icons.welcome,
        title: AppLocalizations.of(context)!.welcomeTitle,
        subtitle: AppLocalizations.of(context)!.welcomeSubtitle,
        imageWidth: 300,
        imageHeight: 300,
      ),
    );
  }
}

