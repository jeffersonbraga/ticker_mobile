import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:ticker_mobile/customs/ticker_list_item.dart';

import 'package:ticker_mobile/customs/transaction_item.dart';
import 'package:ticker_mobile/models/ticker.dart';
import 'package:ticker_mobile/providers/transactions.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<List> fetchTickersCard() async {
  final response = await http.get('http://192.168.2.105:8085/ticker/cards');

  if (response.statusCode == 200) {

    final lista = json.decode(response.body) as List;
    final listaTickers = new List();
    lista.forEach((element) {
      listaTickers.add(Ticker.fromJson(element));
    });

    return listaTickers;
  } else {
    throw Exception('Failed to load album');
  }
}

class TickerListCard extends StatefulWidget {
  final double height;

  const TickerListCard(this.height);

  @override
  _TickerListCardState createState() => _TickerListCardState();
}

class _TickerListCardState extends State<TickerListCard> {
  int _date = 16;
  Future<List> futureTickerCard;

  @override
  void initState() {
    super.initState();
    futureTickerCard = fetchTickersCard();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final providedTransactions = Provider.of<Transactions>(context);

    return Positioned(
        bottom: 0,
        left: mediaQuery.size.width * .03,
        child: AnimatedContainer(
          duration: Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
          width: mediaQuery.size.width * .94,
          height: mediaQuery.size.height * widget.height,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
            ),
          ),
          child: FutureBuilder<List>(
            future: futureTickerCard,
            builder: (context, snapshot) {
              if (snapshot.hasData) {

                return Column(
                      children: <Widget>[
                        Container(
                          height: 60,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 8, right: 12),
                                child: const Text(
                                  'See all',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () => setState(() => _date--),
                                        child: const Icon(Icons.arrow_left),
                                      ),
                                      Text(
                                        '$_date ${DateFormat('MMM yyyy').format(DateTime.now())}',
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () => setState(() => _date++),
                                        child: const Icon(Icons.arrow_right),
                                      )
                                    ],
                                  )
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, i) {
                                return TickerListItem(snapshot.data[i]);
                              }
                          ),
                        ),
                      ]
                  );
                  /*ListView(
                  restorationId: 'list_demo_list_view',
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  children: [
                    for (Ticker t in snapshot.data)
                      ListTile(
                        leading: ExcludeSemantics(),
                        title: Text(
                          t.ticker,
                        ),
                        subtitle: Text(t.valorAtual.toString()),
                        onTap: (){ },
                        tileColor: Color.fromRGBO(0, 0, 0, 0.3),
                      ),
                  ],
                );*/
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            },
          ),
      )
    );
  }
}
