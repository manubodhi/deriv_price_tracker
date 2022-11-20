import 'package:deriv_price_tracker/data/models/forget_request_model.dart';
import 'package:deriv_price_tracker/data/models/forget_response_model.dart';
import 'package:deriv_price_tracker/data/models/ticks_stream_request_model.dart';
import 'package:deriv_price_tracker/data/models/ticks_stream_response_model.dart';

abstract class TickingPriceRepository {
  Stream<TicksStreamResponseModel> subscribeTicks(
      {required TicksStreamRequestModel? ticksRequest});

  Stream<ForgetResponseModel> unSubscribeTicks(
      {required ForgetRequestModel forgetRequest});
}
