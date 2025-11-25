import 'package:auto_route/auto_route.dart';
import 'package:hotel_booking_app/presentation/pages/account/account_page.dart';
import 'package:hotel_booking_app/presentation/pages/favorites/favorites_page.dart';
import 'package:hotel_booking_app/presentation/pages/home/home_page.dart';
import 'package:hotel_booking_app/presentation/pages/hotels/hotels_page.dart';
import 'package:hotel_booking_app/presentation/pages/overview/overview_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: HomeRoute.page,
      path: '/',
      initial: true,
      children: [
        AutoRoute(page: OverviewRoute.page, path: 'overview', initial: true),
        AutoRoute(page: HotelsRoute.page, path: 'hotels'),
        AutoRoute(page: FavoritesRoute.page, path: 'favorites'),
        AutoRoute(page: AccountRoute.page, path: 'account'),
      ],
    ),
  ];
}
