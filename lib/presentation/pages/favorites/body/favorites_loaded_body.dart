import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hotel_booking_app/core/assets/assets.dart';
import 'package:hotel_booking_app/domain/hotels/models/hotel.dart';
import 'package:hotel_booking_app/l10n/app_localizations.dart';
import 'package:hotel_booking_app/presentation/widgets/hotel_card/hotel_card.dart';
import 'package:hotel_booking_app/presentation/widgets/empty_page_widget.dart';
import 'package:hotel_booking_app/theme/dimens.dart';

class FavoritesLoadedBody extends HookWidget {
  final List<Hotel> favorites;
  final Function(Hotel) onToggleFavorite;

  const FavoritesLoadedBody({
    super.key,
    required this.favorites,
    required this.onToggleFavorite,
  });

  static const _animationDuration = Duration(milliseconds: 400);

  @override
  Widget build(BuildContext context) {
    final listKey = useMemoized(() => GlobalKey<AnimatedListState>());
    final currentFavorites = useRef<List<Hotel>>([]);

    useEffect(() {
      final listState = listKey.currentState;

      if (listState == null) {
        currentFavorites.value = List.of(favorites);
        return null;
      }

      if (currentFavorites.value.isEmpty && favorites.isNotEmpty) {
        currentFavorites.value = List.of(favorites);
        for (var i = 0; i < favorites.length; i++) {
          listState.insertItem(i, duration: _animationDuration);
        }
      } else if (favorites.length != currentFavorites.value.length ||
          !_sameIds(currentFavorites.value, favorites)) {
        _updateList(context, listState, currentFavorites.value, favorites);
      } else {
        currentFavorites.value = List.of(favorites);
      }

      return null;
    }, [favorites]);

    if (favorites.isEmpty) {
      return EmptyPageWidget(
        imagePath: Assets.icons.emptyFavorite,
        title: AppLocalizations.of(context)!.noFavoritesTitle,
        subtitle: AppLocalizations.of(context)!.noFavoritesSubtitle,
        imageWidth: 200,
        imageHeight: 200,
      );
    }

    return AnimatedList(
      key: listKey,
      padding: EdgeInsets.only(top: Dimens.m),
      initialItemCount: currentFavorites.value.length,
      itemBuilder: (context, index, animation) {
        final hotel = currentFavorites.value[index];
        return _buildItem(context, hotel, animation);
      },
    );
  }

  static bool _sameIds(List<Hotel> a, List<Hotel> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i].id != b[i].id) return false;
    }
    return true;
  }

  Widget _buildItem(
    BuildContext context,
    Hotel hotel,
    Animation<double> animation,
  ) {
    final curved = CurvedAnimation(
      parent: animation,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );

    return SizeTransition(
      sizeFactor: curved,
      axisAlignment: -1.0,
      child: SlideTransition(
        position: curved.drive(
          Tween<Offset>(begin: const Offset(0.1, 0.0), end: Offset.zero),
        ),
        child: FadeTransition(
          opacity: curved,
          child: Padding(
            padding: EdgeInsets.only(
              left: Dimens.m,
              right: Dimens.m,
              bottom: Dimens.xl,
            ),
            child: HotelCard(
              type: HotelCardType.favorite,
              hotel: hotel,
              isFavorite: true,
              onToggleFavorite: () => onToggleFavorite(hotel),
            ),
          ),
        ),
      ),
    );
  }

  void _updateList(
    BuildContext context,
    AnimatedListState listState,
    List<Hotel> oldFavorites,
    List<Hotel> newFavorites,
  ) {
    final oldIds = oldFavorites.map((h) => h.id).toList();
    final newIds = newFavorites.map((h) => h.id).toList();

    for (int i = oldFavorites.length - 1; i >= 0; i--) {
      final hotel = oldFavorites[i];
      if (!newIds.contains(hotel.id)) {
        oldFavorites.removeAt(i);
        listState.removeItem(
          i,
          (context, animation) => _buildItem(context, hotel, animation),
          duration: _animationDuration,
        );
      }
    }

    for (int i = 0; i < newFavorites.length; i++) {
      final hotel = newFavorites[i];
      if (!oldIds.contains(hotel.id)) {
        oldFavorites.insert(i, hotel);
        listState.insertItem(i, duration: _animationDuration);
      }
    }
  }
}
