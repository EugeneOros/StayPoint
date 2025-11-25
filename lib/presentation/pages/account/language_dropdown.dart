import 'package:flutter/material.dart';
import 'package:hotel_booking_app/theme/colors.dart';
import 'package:hotel_booking_app/theme/dimens.dart';
import 'package:hotel_booking_app/theme/text_theme.dart';

class LanguageDropdown extends StatelessWidget {
  final String currentLocale;
  final Function(String) onLocaleChanged;
  final String englishLabel;
  final String germanLabel;
  final String polishLabel;

  const LanguageDropdown({
    super.key,
    required this.currentLocale,
    required this.onLocaleChanged,
    required this.englishLabel,
    required this.germanLabel,
    required this.polishLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(Dimens.xs),
        border: Border.all(color: AppColors.borderSecondary, width: 1),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: currentLocale,
          isExpanded: true,
          icon: Icon(
            Icons.arrow_drop_down,
            color: AppColors.contentSecondary,
            size: Dimens.l,
          ),
          padding: EdgeInsets.symmetric(horizontal: Dimens.m),
          style: AppTextTheme.labelSmall.copyWith(color: AppColors.black),
          dropdownColor: AppColors.white,
          items: [
            DropdownMenuItem<String>(value: 'en', child: Text(englishLabel)),
            DropdownMenuItem<String>(value: 'de', child: Text(germanLabel)),
            DropdownMenuItem<String>(value: 'pl', child: Text(polishLabel)),
          ],
          onChanged: (String? newLocale) {
            if (newLocale != null) {
              onLocaleChanged(newLocale);
            }
          },
        ),
      ),
    );
  }
}
