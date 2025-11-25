import 'package:hotel_booking_app/domain/main_stream/service/main_stream_service.dart';
import 'package:hotel_booking_app/extensions/refresh_stream_mixin.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: MainStreamService)
class MainStreamServiceImpl extends MainStreamService
    with RefreshStreamMixin<MainStreamEvent> {}
