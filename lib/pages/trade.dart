import 'dart:async';
import 'dart:convert';

import 'package:cftfx/methods/ws_methods.dart';
import 'package:cftfx/models/coin_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:velocity_x/velocity_x.dart';

class Trade extends StatefulWidget {
  const Trade({Key? key, required this.sym, required this.live})
      : super(key: key);

  final String sym;
  final List<Map<String, dynamic>> live;

  @override
  State<Trade> createState() => _TradeState();
}

class _TradeState extends State<Trade> {
  final WebSocketMethods _webSocketMethods = WebSocketMethods();

  ChartSeriesController? _chartSeriesController;
  List<Map<String, dynamic>> live = [];

  final List<num> _amounts = [100, 500, 1000];

  num _amount = 0;

  @override
  void initState() {
    Timer.periodic(const Duration(milliseconds: 700), (_) {
      live.removeAt(0);
      // print(widget.live.length);
    });

    super.initState();
  }

  @override
  void dispose() {
    _webSocketMethods.channel.sink.close();
    _chartSeriesController = null;

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
              CoinModel _coin = CoinModel.fromMap(
                  jsonDecode(snapshot.data)[0] as Map<String, dynamic>);

              live.add({'t': _coin.t, 'ap': _coin.ap});

              return Column(
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
                  AspectRatio(
                    aspectRatio: 1,
                    child: SfCartesianChart(
                      primaryXAxis: NumericAxis(
                        majorGridLines: const MajorGridLines(width: 0),
                      ),
                      primaryYAxis: NumericAxis(
                        axisLine: const AxisLine(width: 0),
                        majorTickLines: const MajorTickLines(size: 0),
                      ),
                      zoomPanBehavior: ZoomPanBehavior(
                        zoomMode: ZoomMode.xy,
                        enableDoubleTapZooming: true,
                      ),
                      series: [
                        LineSeries(
                          onRendererCreated:
                              (ChartSeriesController controller) {
                            _chartSeriesController = controller;
                          },
                          dataSource: live,
                          xValueMapper: (dynamic change, _) => _,
                          yValueMapper: (dynamic change, _) => change['ap'],
                          animationDuration: 0,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      labelText: 'Amount',
                    ),
                    items: _amounts.map((num amount) {
                      return DropdownMenuItem(
                        value: amount,
                        child: amount.text.make(),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      // print(newValue);

                      setState(() {
                        _amount = int.parse(newValue.toString());
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: const Icon(Icons.ssid_chart_sharp),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Vx.red600),
                          ),
                        )
                            .cornerRadius(10)
                            .wPCT(context: context, widthPCT: 45)
                            .h(50),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Icon(Icons.show_chart_rounded),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Vx.blue600),
                          ),
                        )
                            .cornerRadius(10)
                            .wPCT(context: context, widthPCT: 45)
                            .h(50),
                      ],
                    ).p4(),
                  ),
                ],
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
