import 'dart:convert';
import 'dart:async';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:math';
import 'package:http/http.dart' as http;
import './home_page.dart';
import 'ticker.dart';

Future<List> fetchPost() async {
  final response = await http.get('http://192.168.25.108:8085/ticker/cards');
  if (response.statusCode == 200) {

    final lista = json.decode(response.body) as List;
    final listaTicckers = new List();
    lista.forEach((element) {
      listaTicckers.add(Ticker.fromJson(element));
    });

    return listaTicckers;
  } else {
    throw Exception('Falha ao carregar um post');
  }
}

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {

  static const Map<int, Color> colorMap = {
    50: Color.fromRGBO(42, 54, 59, 0.1),
    100: Color.fromRGBO(42, 54, 59, 0.2),
    200: Color.fromRGBO(42, 54, 59, 0.3),
    300: Color.fromRGBO(42, 54, 59, 0.4),
    400: Color.fromRGBO(42, 54, 59, 0.5),
    500: Color.fromRGBO(42, 54, 59, 0.6),
    600: Color.fromRGBO(42, 54, 59, 0.7),
    700: Color.fromRGBO(42, 54, 59, 0.8),
    800: Color.fromRGBO(42, 54, 59, 0.9),
    900: Color.fromRGBO(42, 54, 59, 1.0)
  };

  static const MaterialColor _2A363B = MaterialColor(0xFF2A363B, colorMap);

  final String title = "Charts Demo";

  MyApp() : super();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finance - Tickers',
      theme: ThemeData(
        primarySwatch: _2A363B,
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      home: RandomWords()
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