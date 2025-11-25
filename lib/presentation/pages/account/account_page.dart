import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking_app/l10n/app_localizations.dart';
import 'package:hotel_booking_app/presentation/pages/account/cubit/locale_cubit.dart';
import 'package:hotel_booking_app/presentation/pages/account/language_dropdown.dart';
import 'package:hotel_booking_app/theme/colors.dart';
import 'package:hotel_booking_app/theme/dimens.dart';
import 'package:hotel_booking_app/theme/text_theme.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          l10n.account,
          style: AppTextTheme.headlineSmall.copyWith(color: AppColors.white),
        ),
        backgroundColor: AppColors.backgroundBrand,
      ),
      body: Padding(
        padding: EdgeInsets.all(Dimens.m),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.language,
              style: AppTextTheme.headlineSmall.copyWith(
                color: AppColors.black,
              ),
            ),
            SizedBox(height: Dimens.m),
            BlocBuilder<LocaleCubit, LocaleState>(
              builder: (context, state) {
                final localeCubit = context.read<LocaleCubit>();
                final currentLocale = state.localeCode;

                return LanguageDropdown(
                  currentLocale: currentLocale,
                  onLocaleChanged: (localeCode) =>
                      localeCubit.changeLocale(localeCode),
                  englishLabel: l10n.english,
                  germanLabel: l10n.german,
                  polishLabel: l10n.polish,
                );
              },
            ),
            SizedBox(height: Dimens.xl),
            Center(
              child: Text(
                l10n.version,
                style: AppTextTheme.labelXSmall.copyWith(
                  color: AppColors.contentSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
