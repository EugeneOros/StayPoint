import 'package:equatable/equatable.dart';

sealed class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object?> get props => [];
}

class FavoritesEventToggleError extends FavoritesEvent {
  const FavoritesEventToggleError();
}
