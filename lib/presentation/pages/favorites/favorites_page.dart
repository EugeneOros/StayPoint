import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:hotel_booking_app/l10n/app_localizations.dart';
import 'package:hotel_booking_app/presentation/pages/favorites/body/favorites_loaded_body.dart';
import 'package:hotel_booking_app/presentation/pages/favorites/cubit/favorites_event.dart';
import 'package:hotel_booking_app/presentation/widgets/loading_widget.dart';
import 'package:hotel_booking_app/presentation/widgets/error_widget.dart'
    as custom;
import 'package:hotel_booking_app/theme/colors.dart';
import 'package:hotel_booking_app/theme/text_theme.dart';
import 'package:hotel_booking_app/utils/use_once.dart';
import 'cubit/favorites_cubit.dart';
import 'cubit/favorites_state.dart';

class FavoritesPage extends HookWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = useBloc<FavoritesCubit>();
    final state = useBlocBuilder(cubit);

    useOnce(() async => cubit.loadFavorites());

    return BlocProvider<FavoritesCubit>.value(
      value: cubit,
      child: BlocPresentationListener<FavoritesCubit, FavoritesEvent>(
        listener: (BuildContext context, FavoritesEvent event) =>
            switch (event) {
              FavoritesEventToggleError() =>
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      AppLocalizations.of(context)!.errorToggleFavorite,
                    ),
                    backgroundColor: AppColors.red,
                  ),
                ),
            },
        child: Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            title: Text(
              AppLocalizations.of(context)!.favorites,
              style: AppTextTheme.headlineSmall.copyWith(
                color: AppColors.white,
              ),
            ),
            backgroundColor: AppColors.backgroundBrand,
            foregroundColor: AppColors.white,
          ),
          body: switch (state.status) {
            FavoritesStatus.loading => const LoadingWidget(),
            FavoritesStatus.error => custom.ErrorWidget(
              message:
                  state.error ??
                  AppLocalizations.of(context)!.errorLoadingFavorites,
              onRetry: () => cubit.loadFavorites(),
            ),
            FavoritesStatus.loaded => FavoritesLoadedBody(
              favorites: state.favorites,
              onToggleFavorite: (hotel) => cubit.toggleFavorite(hotel),
            ),
          },
        ),
      ),
    );
  }
}
