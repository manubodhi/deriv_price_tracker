import 'package:web_socket_channel/io.dart';

abstract class WebSocketService {
  IOWebSocketChannel? connect({required String baseURL, required String appId});

  IOWebSocketChannel? get channel;

  void reset();
}

class WebSocketServiceImpl extends WebSocketService {
  IOWebSocketChannel? _channel;
  static const String appId = "1089";
  static const String baseURL = "wss://ws.binaryws.com/websockets/v3";

  WebSocketServiceImpl() {
    connect(baseURL: baseURL, appId: appId);
  }

  @override
  IOWebSocketChannel? connect(
      {required String baseURL, required String appId}) {
    final Uri uri = Uri(
      host: "ws.binaryws.com",
      scheme: 'wss',
      path: '/websockets/v3',
      queryParameters: <String, dynamic>{
        'app_id': appId,
      },
    );
    _channel ??= IOWebSocketChannel.connect(uri.toString());
    return _channel;
  }

  @override
  IOWebSocketChannel? get channel {
    return _channel ??= connect(baseURL: baseURL, appId: appId);
  }

  @override
  reset() {
    if (_channel != null) {
      _channel!.sink.close();
    }
  }
}
