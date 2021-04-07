import 'package:flutter/material.dart';
import 'package:ticker_mobile/customs/header.dart';
import 'package:ticker_mobile/customs/new_transaction.dart';
import 'package:ticker_mobile/customs/ticker_list_card.dart';
import 'package:ticker_mobile/customs/transaction_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  double _height = .55;
  double _opacity = .9;

  void _addTransaction() {
    setState(() {
      _height = .08;
      _opacity = 1;
    });
  }

  void _done() {
    setState(() {
      _height = .55;
      _opacity = .9;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.short_text),
            onPressed: (){},
          ),
        centerTitle: true,
        title: const Text('Personal Finance',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold
          ),
        ),
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.person_outline), onPressed: () {  },)
        ],
      ),
      body: Stack(
        children: <Widget>[
          Column(
              children: <Widget>[
              HeaderApp(_addTransaction),
                NewTransaction(_opacity, _done)
            ],
          ),
          TickerListCard(_height)
        ],
      ),
    );
  }
}
