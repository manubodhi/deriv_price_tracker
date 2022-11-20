import 'dart:convert';

import 'package:deriv_price_tracker/data/repos/ticking_price_repository.dart';

import '../models/forget_request_model.dart';
import '../models/forget_response_model.dart';
import '../models/ticks_stream_request_model.dart';
import '../models/ticks_stream_response_model.dart';
import '../remote/web_socket_service.dart';

class TickingPriceRepositoryImpl implements TickingPriceRepository {
  final _socket = WebSocketServiceImpl();

  @override
  Stream<TicksStreamResponseModel> subscribeTicks(
      {required TicksStreamRequestModel? ticksRequest}) {
    _socket.channel!.sink.add(jsonEncode(ticksRequest));
    return _socket.channel!.stream.map<TicksStreamResponseModel>(
        (value) => TicksStreamResponseModel.fromJson(jsonDecode(value)));
  }

  @override
  Stream<ForgetResponseModel> unSubscribeTicks(
      {required ForgetRequestModel forgetRequest}) {
    _socket.channel!.sink.add(jsonEncode(forgetRequest));
    return _socket.channel!.stream.map<ForgetResponseModel>(
        (value) => ForgetResponseModel.fromJson(jsonDecode(value)));
  }
}
