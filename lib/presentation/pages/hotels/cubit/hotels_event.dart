import 'package:equatable/equatable.dart';

sealed class HotelsEvent extends Equatable {
  const HotelsEvent();

  @override
  List<Object?> get props => [];
}

class HotelsEventToggleFavoriteError extends HotelsEvent {
  const HotelsEventToggleFavoriteError();
}
