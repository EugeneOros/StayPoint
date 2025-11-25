import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hotel_booking_app/l10n/app_localizations.dart';
import 'package:hotel_booking_app/presentation/pages/overview/overview_page.dart';
import 'package:hotel_booking_app/presentation/pages/hotels/hotels_page.dart';
import 'package:hotel_booking_app/presentation/pages/favorites/favorites_page.dart';
import 'package:hotel_booking_app/presentation/pages/account/account_page.dart';
import 'package:hotel_booking_app/theme/colors.dart';
import 'package:hotel_booking_app/theme/dimens.dart';
import 'package:hotel_booking_app/core/assets/assets.dart';

class HomePage extends HookWidget {
  final int? initialTabIndex;

  const HomePage({super.key, this.initialTabIndex});

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState(initialTabIndex ?? 0);

    useEffect(() {
      if (initialTabIndex != null && initialTabIndex != selectedIndex.value) {
        selectedIndex.value = initialTabIndex!;
      }
      return null;
    }, [initialTabIndex]);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: IndexedStack(
        index: selectedIndex.value,
        children: const [
          OverviewPage(),
          HotelsPage(),
          FavoritesPage(),
          AccountPage(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              offset: Offset(Dimens.zero, Dimens.xxxs),
              blurRadius: Dimens.xs,
              spreadRadius: Dimens.zero,
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: selectedIndex.value,
          onTap: (index) {
            selectedIndex.value = index;
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.white,
          selectedItemColor: AppColors.backgroundBrand,
          unselectedItemColor: AppColors.contentSecondary,
          elevation: 0,
          items: [
            _AppBottomNavigationBarItem(
              iconPath: Assets.icons.home,
              label: AppLocalizations.of(context)!.overview,
              isSelected: selectedIndex.value == 0,
            ).toBottomNavigationBarItem(),
            _AppBottomNavigationBarItem(
              iconPath: Assets.icons.search,
              label: AppLocalizations.of(context)!.search,
              isSelected: selectedIndex.value == 1,
            ).toBottomNavigationBarItem(),
            _AppBottomNavigationBarItem(
              iconPath: Assets.icons.favorites,
              label: AppLocalizations.of(context)!.favorites,
              isSelected: selectedIndex.value == 2,
            ).toBottomNavigationBarItem(),
            _AppBottomNavigationBarItem(
              iconPath: Assets.icons.profile,
              label: AppLocalizations.of(context)!.account,
              isSelected: selectedIndex.value == 3,
            ).toBottomNavigationBarItem(),
          ],
        ),
      ),
    );
  }
}

class _AppBottomNavigationBarItem {
  final String iconPath;
  final String label;
  final bool isSelected;

  const _AppBottomNavigationBarItem({
    required this.iconPath,
    required this.label,
    required this.isSelected,
  });

  BottomNavigationBarItem toBottomNavigationBarItem() {
    return BottomNavigationBarItem(
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: Dimens.xm),
          SvgPicture.asset(
            iconPath,
            width: Dimens.l,
            height: Dimens.l,
            colorFilter: ColorFilter.mode(
              AppColors.contentSecondary,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(height: Dimens.s),
        ],
      ),
      activeIcon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: Dimens.xm),
          SvgPicture.asset(
            iconPath,
            width: Dimens.l,
            height: Dimens.l,
            colorFilter: ColorFilter.mode(AppColors.backgroundBrand, BlendMode.srcIn),
          ),
          SizedBox(height: Dimens.s),
        ],
      ),
      label: label,
    );
  }
}
