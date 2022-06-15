import 'dart:convert';

import 'package:candlesticks/candlesticks.dart';
import 'package:cftfx/methods/api_methods.dart';
import 'package:cftfx/methods/ws_methods.dart';
import 'package:cftfx/models/coin_model.dart';
import 'package:cftfx/models/historic_model.dart';
import 'package:cftfx/pages/trade.dart';
import 'package:cftfx/utils.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Coin extends StatefulWidget {
  const Coin({Key? key, required this.sym, required this.ohlc})
      : super(key: key);

  final String sym;
  final Map<String, dynamic> ohlc;

  @override
  State<Coin> createState() => _CoinState();
}

class _CoinState extends State<Coin> {
  final WebSocketMethods _webSocketMethods = WebSocketMethods();
  final ApiMethods _apiMethods = ApiMethods();
  final Utils _utils = Utils();

  final List<HistoricModel> _historic = [];
  List<Map<String, dynamic>> liveChange = [];
  // final List<Map<String, dynamic>> _kline = [];

  @override
  void initState() {
    _apiMethods.getHistoric(widget.sym + 'USD').asStream().listen((event) {
      var data = jsonDecode(event.body);
      List hData = data['results'];

      for (var element in hData) {
        HistoricModel _h = HistoricModel.fromMap(element);

        _historic.add(_h);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    liveChange = [];

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/color/${widget.sym.toLowerCase()}.png',
              width: 30,
              height: 30,
            ).pOnly(right: 10),
            widget.sym.text.make(),
          ],
        ),
      ),
      body: StreamBuilder(
        stream: _webSocketMethods.getSpecificCoinData(widget.sym),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            // print(snapshot.data);

            CoinModel _coin = CoinModel.fromMap(jsonDecode(snapshot.data)[0]);
            Map<String, dynamic> change = {'t': _coin.t, 'ap': _coin.ap};

            liveChange.add(change);

            // print(liveChange.length);

            return SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    // Ask and Bid price are reversed in this api
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ('\$ ' + _coin.bp.toString())
                            .text
                            .size(22)
                            .make()
                            .pSymmetric(v: 8, h: 14)
                            .backgroundColor(Vx.red600)
                            .cornerRadius(8),
                        ('\$ ' + _coin.ap.toString())
                            .text
                            .size(22)
                            .make()
                            .pSymmetric(v: 8, h: 14)
                            .backgroundColor(Vx.blue600)
                            .cornerRadius(8),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Card(
                      elevation: 8,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ('O: ' +
                                      ('\$ ' +
                                          _utils.removeDecimalZeroFormat(
                                              double.parse(widget.ohlc['o']))))
                                  .text
                                  .size(18)
                                  .make(),
                              ('H: ' +
                                      ('\$ ' +
                                          _utils.removeDecimalZeroFormat(
                                              double.parse(widget.ohlc['h']))))
                                  .text
                                  .size(18)
                                  .make(),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ('L: ' +
                                      ('\$ ' +
                                          _utils.removeDecimalZeroFormat(
                                              double.parse(widget.ohlc['l']))))
                                  .text
                                  .size(18)
                                  .make(),
                              ('C: ' +
                                      ('\$ ' +
                                          _utils.removeDecimalZeroFormat(
                                              double.parse(widget.ohlc['c']))))
                                  .text
                                  .size(18)
                                  .make(),
                            ],
                          ),
                        ],
                      ).p8(),
                    ).p8(),
                    const SizedBox(
                      height: 30,
                    ),
                    AspectRatio(
                      aspectRatio: 1.1,
                      child: Candlesticks(
                        candles: _historic
                            .map(
                              (e) => Candle(
                                date: DateTime.fromMillisecondsSinceEpoch(e.t),
                                high: double.parse(e.h.toString()),
                                low: double.parse(e.l.toString()),
                                open: double.parse(e.o.toString()),
                                close: double.parse(e.c.toString()),
                                volume: double.parse(e.v.toString()),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Trade(sym: widget.sym, live: liveChange),
                          ),
                        );
                      },
                      child: 'Open Trade'.text.size(20).make(),
                    )
                        .cornerRadius(25)
                        .wPCT(context: context, widthPCT: 95)
                        .h(50),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
