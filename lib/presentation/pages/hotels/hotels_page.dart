import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hotel_booking_app/l10n/app_localizations.dart';
import 'package:hotel_booking_app/presentation/pages/hotels/body/hotels_loaded_body.dart';
import 'package:hotel_booking_app/presentation/pages/hotels/cubit/hotels_event.dart';
import 'package:hotel_booking_app/presentation/widgets/loading_widget.dart';
import 'package:hotel_booking_app/presentation/widgets/error_widget.dart'
    as custom;
import 'package:hotel_booking_app/theme/colors.dart';
import 'package:hotel_booking_app/theme/text_theme.dart';
import 'package:hotel_booking_app/shared/utils/use_once.dart';
import 'cubit/hotels_cubit.dart';
import 'cubit/hotels_state.dart';

import 'package:hooked_bloc/hooked_bloc.dart';

class HotelsPage extends HookWidget {
  const HotelsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = useBloc<HotelsCubit>();
    final state = useBlocBuilder(cubit);
    useOnce(() async => cubit.loadHotels());

    return BlocProvider<HotelsCubit>.value(
      value: cubit,
      child: BlocPresentationListener<HotelsCubit, HotelsEvent>(
        listener: (BuildContext context, HotelsEvent event) => switch (event) {
          HotelsEventToggleFavoriteError() =>
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
              AppLocalizations.of(context)!.hotels,
              style: AppTextTheme.headlineSmall.copyWith(
                color: AppColors.white,
              ),
            ),
            backgroundColor: AppColors.backgroundBrand,
            foregroundColor: AppColors.white,
          ),
          body: switch (state.status) {
            HotelsStatus.loading => const LoadingWidget(),
            HotelsStatus.error => custom.ErrorWidget(
              message:
                  state.error ??
                  AppLocalizations.of(context)!.errorLoadingHotels,
              onRetry: () => cubit.loadHotels(),
            ),
            HotelsStatus.loaded => HotelsLoadedBody(
              favoriteIds: state.favoriteIds,
              hotels: state.hotels,
              onToggleFavorite: (hotel) => cubit.toggleFavorite(hotel),
            ),
          },
        ),
      ),
    );
  }
}
