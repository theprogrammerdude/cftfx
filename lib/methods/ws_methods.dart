import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketMethods {
  final channel =
      WebSocketChannel.connect(Uri.parse('wss://socket.polygon.io/crypto'));

  final tickers = WebSocketChannel.connect(
      Uri.parse('wss://stream.binance.com:9443/ws/!ticker@arr'));

  Stream getAllTickers() {
    return tickers.stream;
  }

  Stream<dynamic> getSpecificCoinData(String sym) {
    channel.sink.add(jsonEncode(
        {"action": "auth", "params": "3r5A4iEkMqoBUNWCRPq2xBSJf0I82WfO"}));
    channel.sink
        .add(jsonEncode({"action": "subscribe", "params": "XQ.$sym-USD"}));

    return channel.stream;
  }

  Stream<dynamic> coinCandles(String coin) {
    var candles = WebSocketChannel.connect(
        Uri.parse('wss://stream.binance.com:9443/ws/${coin}usdt@kline_1m'));

    return candles.stream;
  }
}
