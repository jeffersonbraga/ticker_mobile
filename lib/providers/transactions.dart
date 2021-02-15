import 'package:flutter/material.dart';

class Transaction {
  final int id;
  final String title;
  final double value;
  final String category;
  final IconData iconData;
  final Color color;

  const Transaction({

    @required this.id,
    @required this.title,
    @required this.value,
    @required this.category,
    @required this.iconData,
    @required this.color
  });
}

class Transactions with ChangeNotifier {
  List<Transaction> _transactions = [
    Transaction(id: 1, title: 'ITSA4', value: 1103, category: 'Bancos', iconData: Icons.bar_chart, color: Color(0xff40bad5)),
    Transaction(id: 1, title: 'TOTV3', value: 1103, category: 'Bancos', iconData: Icons.bar_chart, color: Color(0xffe8505b)),
    Transaction(id: 1, title: 'SLCE3', value: 1103, category: 'Bancos', iconData: Icons.bar_chart, color: Color(0xfffe91ca)),
    Transaction(id: 1, title: 'MGLU3', value: 1103, category: 'Bancos', iconData: Icons.bar_chart, color: Color(0xfff6d443)),
    Transaction(id: 1, title: 'PETZ3', value: 1103, category: 'Bancos', iconData: Icons.bar_chart, color: Color(0xfff57b51))

  ];
  List<Transaction> get transactions {
    return _transactions;
  }
}