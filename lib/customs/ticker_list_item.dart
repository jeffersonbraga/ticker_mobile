import 'package:flutter/material.dart';
import 'package:ticker_mobile/models/ticker.dart';
import 'package:ticker_mobile/providers/transactions.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:ticker_mobile/customs/expense_chart.dart';

class TickerListItem extends StatelessWidget {

  final Ticker ticker;

  const TickerListItem(this.ticker);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            //color: ticker.color.withOpacity(.8),
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          /*child: Icon(
            ticker.iconData,
            size: 20,
            color: Colors.white,
          ),*/
        ),
        title: Text(
          ticker.ticker,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold
          ),
        ),
        subtitle: Text(
          'Qtd: ${ticker.quantidade}      Valor: R\$${ticker.valorAtual}',
          style: const TextStyle(
            fontSize: 12
          ),
        ),
        trailing: Text(
          'R\$ ${(ticker.quantidade * ticker.valorAtual).toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 12,
            color: Colors.red,
            fontWeight: FontWeight.bold
          ),
        ),
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SecondRoute(ticker)),);
        },
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {

  /// Create one series with sample hard coded data.
  static List<charts.Series<OrdinalSales, String>> _createSampleData(Ticker ticker) {
    final data = [
      new OrdinalSales('2014', ticker.valorAtual.toInt()),
      new OrdinalSales('2015', ticker.quantidade.toInt()),
      new OrdinalSales('2016', 100),
      new OrdinalSales('2017', 75),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }

  static List<charts.Series<Ticker, String>> _series = [
    charts.Series<Ticker, String>(
        id: 'Ticker',
        domainFn: (Ticker ticker, _) => ticker.ticker,
        measureFn: (Ticker ticker, _) => ticker.valorAtual,
        labelAccessorFn: (Ticker ticker, _) => '\$${ticker.valorAtual}',
        colorFn: (Ticker ticker, _) =>
            charts.ColorUtil.fromDartColor(ticker.color),
        data: [
          Ticker.fromJson({'ticker': 'ITSA4', 'valorAtual': 50.0, 'quantidade': 10.0, 'logo':' ', 'color': Color(0xff40bad5)}),
          Ticker.fromJson({'ticker': 'TOTV3', 'valorAtual': 20.0, 'quantidade': 10.0, 'logo':' ', 'color': Color(0xffe8505b)}),
          Ticker.fromJson({'ticker': 'SLCE3', 'valorAtual': 10.0, 'quantidade': 10.0, 'logo':' ', 'color': Color(0xfffe91ca)}),
          Ticker.fromJson({'ticker': 'MGLU3', 'valorAtual': 10.0, 'quantidade': 10.0, 'logo':' ', 'color': Color(0xfff6d443)}),
          Ticker.fromJson({'ticker': 'PETZ3', 'valorAtual': 10.0, 'quantidade': 10.0, 'logo':' ', 'color': Color(0xfff57b51)}),
        ]
    )
  ];

  SecondRoute(this.ticker);

  final Ticker ticker;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ticker.ticker),
      ),
      body: Center(
        child:
        Stack(
          children: <Widget>[
            ExpenseChart(_series, animate: true),
            charts.BarChart(
              _createSampleData(ticker),
              animate: false,
            )

        ],
        ),
      ),
    );
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}