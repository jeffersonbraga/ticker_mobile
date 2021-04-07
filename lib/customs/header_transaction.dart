import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:ticker_mobile/customs/expense_chart.dart';
import 'package:ticker_mobile/models/ticker.dart';

class HeaderApp extends StatelessWidget {

  final Function addTransaction;

  const HeaderApp(this.addTransaction);

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

  @override
  Widget build(BuildContext context) {

    final primaryColor = Theme.of(context).primaryColor;
    final mediaQuery = MediaQuery.of(context);
    return Container(
      width: double.infinity,
      height: mediaQuery.size.height * .4,
      color: primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 150,
              child: ExpenseChart(_series, animate: true),
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                OutlineButton(
                    onPressed: addTransaction,
                    borderSide: const BorderSide(
                      width: 1,
                      color: Colors.white
                    ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Container(
                    width: 124,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Icon(
                          Icons.playlist_add,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 4),
                        const Text(
                            'Add Transaction',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                            )),
                      ],
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {},
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Container(
                    width: 72,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Reports',
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Icons.navigate_next,
                          color: primaryColor,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                  'Transactions',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Quicksand',
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
