import 'dart:convert';
import 'dart:async';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:math';
import 'package:http/http.dart' as http;

Future<Ticker> fetchPost() async {
  final response = await http.get('http://127.0.0.1:8085/ticker/cards');
  if (response.statusCode == 200) {

    final lista = json.decode(response.body) as List;
    final listaTicckers = new List();
    lista.forEach((element) {
      listaTicckers.add(Ticker.fromJson(element));
    });

    return listaTicckers[0];
  } else {
    throw Exception('Falha ao carregar um post');
  }
}
class Ticker {
  final String ticker;
  final double valorAtual;
  final double quantidade;

  Ticker({this.ticker, this.valorAtual, this.quantidade});
  factory Ticker.fromJson(Map<String, dynamic> json) {
    return Ticker(
      ticker: json['ticker'],
      valorAtual: json['valorAtual'],
      quantidade: json['quantidade'],
    );
  }
}

void main() => runApp(MyApp(post: fetchPost()));
class MyApp extends StatelessWidget {
  final Future<Ticker> post;

  final String title = "Charts Demo";

  MyApp({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Obtendo dados da Web - Exemplo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Pegando dados da Web'),
        ),
        body: Center(
          child: FutureBuilder<Ticker>(
            future: post,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      'Id :' + snapshot.data.ticker.toString() + '\n\ntitle : '
                          + snapshot.data.valorAtual.toString() + '\n\nbody : ' +
                          snapshot.data.quantidade.toString()),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }


















  List<charts.Series> seriesList;

  static List<charts.Series<Ticker, String>> _createRandomData() {
    final random = Random();

    final desktopSalesData = [
      Ticker(ticker: '2015', valorAtual: random.nextDouble(), quantidade: random.nextDouble()),
      Ticker(ticker: '2016', valorAtual: random.nextDouble(), quantidade: random.nextDouble()),
      Ticker(ticker: '2017', valorAtual: random.nextDouble(), quantidade: random.nextDouble()),
      Ticker(ticker: '2018', valorAtual: random.nextDouble(), quantidade: random.nextDouble()),
      Ticker(ticker: '2019', valorAtual: random.nextDouble(), quantidade: random.nextDouble()),
    ];

    final tabletSalesData = [
      Ticker(ticker: '2015', valorAtual: random.nextDouble(), quantidade: random.nextDouble()),
      Ticker(ticker: '2016', valorAtual: random.nextDouble(), quantidade: random.nextDouble()),
      Ticker(ticker: '2017', valorAtual: random.nextDouble(), quantidade: random.nextDouble()),
      Ticker(ticker: '2018', valorAtual: random.nextDouble(), quantidade: random.nextDouble()),
      Ticker(ticker: '2019', valorAtual: random.nextDouble(), quantidade: random.nextDouble()),
    ];

    final mobileSalesData = [
      Ticker(ticker: '2015', valorAtual: random.nextDouble(), quantidade: random.nextDouble()),
      Ticker(ticker: '2016', valorAtual: random.nextDouble(), quantidade: random.nextDouble()),
      Ticker(ticker: '2017', valorAtual: random.nextDouble(), quantidade: random.nextDouble()),
      Ticker(ticker: '2018', valorAtual: random.nextDouble(), quantidade: random.nextDouble()),
      Ticker(ticker: '2019', valorAtual: random.nextDouble(), quantidade: random.nextDouble()),
    ];

    return [
      charts.Series<Ticker, String>(
        id: 'Sales',
        domainFn: (Ticker sales, _) => sales.ticker,
        measureFn: (Ticker sales, _) => sales.valorAtual,
        data: desktopSalesData,
        fillColorFn: (Ticker sales, _) {
          return charts.MaterialPalette.blue.shadeDefault;
        },
      ),
      charts.Series<Ticker, String>(
        id: 'Sales',
        domainFn: (Ticker sales, _) => sales.ticker,
        measureFn: (Ticker sales, _) => sales.valorAtual,
        data: tabletSalesData,
        fillColorFn: (Ticker sales, _) {
          return charts.MaterialPalette.green.shadeDefault;
        },
      ),
      charts.Series<Ticker, String>(
        id: 'Sales',
        domainFn: (Ticker sales, _) => sales.ticker,
        measureFn: (Ticker sales, _) => sales.valorAtual,
        data: mobileSalesData,
        fillColorFn: (Ticker sales, _) {
          return charts.MaterialPalette.teal.shadeDefault;
        },
      )
    ];
  }

  barChart() {
    return charts.BarChart(
      seriesList,
      animate: true,
      vertical: false,
      barGroupingType: charts.BarGroupingType.grouped,
      defaultRenderer: charts.BarRendererConfig(
        groupingType: charts.BarGroupingType.grouped,
        strokeWidthPx: 1.0,
      ),
      domainAxis: charts.OrdinalAxisSpec(
        renderSpec: charts.NoneRenderSpec(),
      ),
    );
  }
}