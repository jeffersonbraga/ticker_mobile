import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticker_mobile/pages/home_page.dart';
import 'package:ticker_mobile/providers/transactions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stock Manager Title',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Stock Manager page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

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

  final String title = "Stock Manager";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Transactions(),
      child:
      MaterialApp(
        title: 'Personal Finance',
        home: HomePage(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: _2A363B,
          fontFamily: 'Quicksand',
          visualDensity: VisualDensity.adaptivePlatformDensity
        ),
      )
    );
  }
}