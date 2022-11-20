import 'dart:convert';

import '../models/active_symbols_request_model.dart';
import '../models/active_symbols_response_model.dart';
import '../remote/web_socket_service.dart';
import 'active_symbols_repository.dart';

class ActiveSymbolsRepositoryImpl implements ActiveSymbolsRepository {
  final _socket = WebSocketServiceImpl();

  @override
  Stream<ActiveSymbolsResponseModel> fetchActiveSymbols(
      {required ActiveSymbolsRequestModel? activeSymbolsRequest}) {
    _socket.channel!.sink.add(jsonEncode(activeSymbolsRequest));
    return _socket.channel!.stream.map<ActiveSymbolsResponseModel>(
        (value) => ActiveSymbolsResponseModel.fromJson(jsonDecode(value)));
  }
}
