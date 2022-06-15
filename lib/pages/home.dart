import 'dart:convert';

import 'package:cftfx/methods/db_methods.dart';
import 'package:cftfx/methods/ws_methods.dart';
import 'package:cftfx/models/tickers_model.dart';
import 'package:cftfx/pages/coin.dart';
import 'package:cftfx/utils.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:velocity_x/velocity_x.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final WebSocketMethods _ws = WebSocketMethods();
  final Utils _utils = Utils();
  final DbMethods _dbMethods = DbMethods();

  List<String> symbols = [];

  @override
  void initState() {
    _dbMethods.allCoins().listen((event) {
      for (var element in event.docs) {
        // print(element.data());
        Map<String, dynamic> data = element.data() as Map<String, dynamic>;

        data.forEach((key, value) {
          // print(value);
          symbols.add(value['sym']);
        });
      }
    });

    super.initState();
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'CFT (fx)'.text.make(),
      ),
      body: StreamBuilder(
        stream: _ws.getAllTickers(),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            List<dynamic> data = jsonDecode(snapshot.data);
            List<TickersModel> tickers = [];

            // print(data);

            for (var element in data) {
              TickersModel _ticker = TickersModel.fromMap(element);

              if (_ticker.s.substring(_ticker.s.length - 4) == 'USDT' &&
                  symbols
                      .contains(_ticker.s.substring(0, _ticker.s.length - 4))) {
                tickers.add(_ticker);
              }
            }

            tickers.sort((a, b) {
              return a.s.toLowerCase().compareTo(b.s.toLowerCase());
            });

            return ListView.builder(
              itemCount: tickers.length,
              itemBuilder: (context, index) {
                String sym =
                    tickers[index].s.substring(0, tickers[index].s.length - 4);

                return GestureDetector(
                  onTap: () {
                    Map<String, dynamic> ohlc = {
                      'o': tickers[index].o,
                      'h': tickers[index].h,
                      'l': tickers[index].l,
                      'c': tickers[index].c,
                    };

                    pushNewScreen(
                      context,
                      screen: Coin(
                        sym: sym,
                        ohlc: ohlc,
                      ),
                      withNavBar: false,
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/color/${sym.toLowerCase()}.png',
                              width: 30,
                              height: 30,
                            ).pOnly(right: 10),
                            sym.text.size(16).make(),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        sym != 'SHIB'
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      '\$ '.text.size(16).make(),
                                      _utils
                                          .removeDecimalZeroFormat(
                                              double.parse(tickers[index].b))
                                          .text
                                          .size(16)
                                          .make(),
                                    ],
                                  )
                                      .pSymmetric(h: 10, v: 5)
                                      .backgroundColor(Vx.red600)
                                      .cornerRadius(8),
                                  Row(
                                    children: [
                                      '\$ '.text.size(16).make(),
                                      _utils
                                          .removeDecimalZeroFormat(
                                              double.parse(tickers[index].a))
                                          .text
                                          .size(16)
                                          .make(),
                                    ],
                                  )
                                      .pSymmetric(h: 10, v: 5)
                                      .backgroundColor(Vx.blue600)
                                      .cornerRadius(8),
                                ],
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      '\$ '.text.size(16).make(),
                                      num.parse(tickers[index].b)
                                          .toStringAsFixed(8)
                                          .text
                                          .size(16)
                                          .make(),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      '\$ '.text.size(16).make(),
                                      num.parse(tickers[index].a)
                                          .toStringAsFixed(8)
                                          .text
                                          .size(16)
                                          .make(),
                                    ],
                                  ),
                                ],
                              )
                      ],
                    ).p12(),
                  ).p2(),
                );
              },
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
